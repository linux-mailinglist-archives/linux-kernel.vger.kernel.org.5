Return-Path: <linux-kernel+bounces-5468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829A818AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EB01C21671
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E461C6BE;
	Tue, 19 Dec 2023 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1wJ1ein"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33D1C68A;
	Tue, 19 Dec 2023 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso1994927f8f.0;
        Tue, 19 Dec 2023 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702998878; x=1703603678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRzX3hUbPtrAVrbHdB/NlfsXUqLfq91OinN9p1IBzVk=;
        b=A1wJ1einY1p/eknjGE9iWj56vm+k4achQ2i604++5T9LRVTdF/6aLqVoIXgFsbp0e6
         WXQEjzr7ukQBa7YJC6NwT6nvF89qyi/Fks66UkUNNxLDDJpVzE7Pk7stLVpcArgP9HE5
         PYZAY4qMEdxb9hFchuDYXpi/kjcxB2VKt7sBcktcfjob3IImeZhfjH+ECmJw17EcY6NG
         eTni7zAKIMlVfUF5c6IZyfP+dz22vDslqYgARhSNv/gnv92F+ydxh8Y1hmJXHiCLENMS
         PYzm775WPKecsdVAtbZIZDsC6R2FE/+TCNKB/haEBuLGRB4AuqmlA/k+SuGwVJJNoC6p
         9pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702998878; x=1703603678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRzX3hUbPtrAVrbHdB/NlfsXUqLfq91OinN9p1IBzVk=;
        b=eR9dMVJELAbMmb2Wz46ANO4enWGLW32NtZAI12wH8Z55ivR3bnRmAIdBW7SeVyodJW
         v0KqLJHzykNXelTsPjf7+K1lR1wZggLBd3U1ySdv4yH7W1XAm06cbbouuK7zzP4aciHH
         78eZnAY/GZG4Vi3ztyKRM8mQEtfXE+FgaA/AQs9sDgC0275KpSwzgVlsurYmz6UnnXCL
         lMpfREYsP5koizZuQ7P4jhpPEWMWyefFZx5sBdAK/VgO4dR7lTnWTiAw8iM4DEpg8iRF
         1jEBmrVfr0CvUFSZrheeLE35tJmLboaTe7ilFiSMaobSamdbbgtSwcPhUCxSnqo4vv47
         VJIg==
X-Gm-Message-State: AOJu0YyASKNuq6j9m6eGdE/85Tk0gfYzq75atuggyTVHfRP9lanwdY1J
	zVTzO9ZQ/FeLQb5nVYc0+B8=
X-Google-Smtp-Source: AGHT+IEgxSk4I/pZ3tdRsHVUcpmoX5T3UR/Qn+n42lmm5pkIOSmNqTF+iyUc87KbTBOBW/gp1MkJuQ==
X-Received: by 2002:a5d:47cf:0:b0:336:3db1:1c1f with SMTP id o15-20020a5d47cf000000b003363db11c1fmr4370056wrc.235.1702998877941;
        Tue, 19 Dec 2023 07:14:37 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v30-20020adfa1de000000b003366cb73f74sm4217956wrv.66.2023.12.19.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:14:37 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Nikita Romanyuk <ufh8945@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: video: logo: use %u format specifier for unsigned int values
Date: Tue, 19 Dec 2023 15:14:36 +0000
Message-Id: <20231219151436.368696-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the %d format specifier is being used for unsigned int values.
Fix this by using the correct %u format specifier. Cleans up cppcheck
warnings:

warning: %d in format string (no. 1) requires 'int' but the argument
type is 'unsigned int'. [invalidPrintfArgType_sint]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/logo/pnmtologo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/logo/pnmtologo.c b/drivers/video/logo/pnmtologo.c
index ada5ef6e51b7..2434a25afb64 100644
--- a/drivers/video/logo/pnmtologo.c
+++ b/drivers/video/logo/pnmtologo.c
@@ -249,10 +249,10 @@ static void write_footer(void)
 	fputs("\n};\n\n", out);
 	fprintf(out, "const struct linux_logo %s __initconst = {\n", logoname);
 	fprintf(out, "\t.type\t\t= %s,\n", logo_types[logo_type]);
-	fprintf(out, "\t.width\t\t= %d,\n", logo_width);
-	fprintf(out, "\t.height\t\t= %d,\n", logo_height);
+	fprintf(out, "\t.width\t\t= %u,\n", logo_width);
+	fprintf(out, "\t.height\t\t= %u,\n", logo_height);
 	if (logo_type == LINUX_LOGO_CLUT224) {
-		fprintf(out, "\t.clutsize\t= %d,\n", logo_clutsize);
+		fprintf(out, "\t.clutsize\t= %u,\n", logo_clutsize);
 		fprintf(out, "\t.clut\t\t= %s_clut,\n", logoname);
 	}
 	fprintf(out, "\t.data\t\t= %s_data\n", logoname);
-- 
2.39.2


