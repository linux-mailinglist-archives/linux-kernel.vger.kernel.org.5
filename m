Return-Path: <linux-kernel+bounces-128954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E560896236
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179B428D87A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E61C692;
	Wed,  3 Apr 2024 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVkyI4L9"
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D01CAAA;
	Wed,  3 Apr 2024 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108617; cv=none; b=SlGgXvyldwyqpExbOHR62aLx0OuUYyrCz/fqqEu75AqZjhiyo1btooq89R6pylLKF0ekttT2/LGqGnkPxnr3gWrQEBVXXygruo4vYq4t87JMSgrh1AhDyZGAWorjmQkJ8uVeQ/rm7DMGlpGQJD4/hU0L07qqLRe2661Dlpv8xkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108617; c=relaxed/simple;
	bh=GmjAj532GROcGfekdwYtm9RSioEjiUXNOBiz7tB0ing=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mYliCyAOiU9rmLJsUoJXCIF79QfpuJDPXuhqbN8Il0tK/itLymBma2HzAYiGOpRZBZctyxXNtCUPsESYz9qUcmCDSTwpmuRphGFni6PzUvrpuUWpxARsJAOJKJfX42+8cvtnOqAveO9MFw+M9KWso3e09PFU9lu9s4qHBJV9a/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVkyI4L9; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-6e6888358dfso3348614a34.2;
        Tue, 02 Apr 2024 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712108615; x=1712713415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsJ4FQL0ZHmTisEqkBaubldM19KDKDegM1Fl5PQoDrw=;
        b=PVkyI4L9iBrtKOkXjopDfwREj4MfiTnC+nvllKXfLE0WNxQLK0oGCPWvPxb14eeXjL
         Dwg5CBVLWCWMmFPfAP1pFF0YaAziVNs9luQo3WP3aL+SENd0JYXhMyob7XZ/DbF3lCK8
         JTQFpy6gBFx097tvW9CQnxxfgyzgdhnz0Kf+1N6J+JA/kGHBQoikfbDa+ebhO6NQqNJD
         4+Yk76wYqk/yH1HS7VYcdk+/PzwVOfDRs0cR0rgXG+8ZI0bOQNxER6DZM12weEHxdrZw
         fpUjqgJT+5f0Uh8DyqVGuNQMKQ7a1HQQwhM0ep98uf7IdZ28U2GXukbPYUmfGLBiJyr2
         zMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712108615; x=1712713415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsJ4FQL0ZHmTisEqkBaubldM19KDKDegM1Fl5PQoDrw=;
        b=APU1DkQde/dmY/8IcJgxWdfIz79I1MuPrY4kI7hFtqRxlpiqr3srC0PRaomlRMA3zA
         4kFXDAk/vI8ppHh/wM4xDJqYU97HIuL2GdHCCYtr7w7Cl15oMU6rRp2ssbTTpvNC4cR7
         P/5mmwZp7xUcVV5ek49zt+NcTlhrhVmWFLrpt7Ztbd+wCKwBmVgga5I6noYR9/mEps0o
         d2rVu6KTXiKx7aXhqOFFeTcZRMh7Ci3MoH1sBU0JBWWgx+XU+3knalsNPTYnb4ZGDJzL
         kht7nu/0k4xx8cGeGV5oMvc2iGjf6HUikTMVmDLd7Nfirv0zXZOG+DCOjDZd9kZ8y45w
         cm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjmotA4qjpf+Y3jn4sarER4rv7YAMkTSmfhfMBYr/s9vHJMg3u6F3f2rcyThTWzBS1iIesgCDNzroDmD1cD2k3lLjYvjyjgdQthGjc
X-Gm-Message-State: AOJu0YyFv8niW7Nhzc+TowWi5bc2sCuw4fopAi0jQ9tQCDOLh62ccCCq
	FBlF0xGUJ5KbwMcMBFCT8IT2OhmKdjnrTP1FOWnSlEvqhoyFDBtE
X-Google-Smtp-Source: AGHT+IFWdg4Jft0MJsEyLjf4TOUUiI1Wxoc2/tcBKNMSE+rgJhzeGdOLrEF3UdhUe1Jq5sMqFuCbww==
X-Received: by 2002:a9d:6f13:0:b0:6e6:8516:4866 with SMTP id n19-20020a9d6f13000000b006e685164866mr16951430otq.16.1712108614783;
        Tue, 02 Apr 2024 18:43:34 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id u4-20020a632344000000b005dc3fc53f19sm10403737pgm.7.2024.04.02.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:43:34 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH] ACPICA: debugger: dbconvert: add a null pointer check
Date: Wed,  3 Apr 2024 09:43:26 +0800
Message-Id: <20240403014326.970237-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocation function ACPI_ALLOCATE_ZEROED does not guarantee a
successful allocation, but the subsequent code directly dereferences the
pointer that receives it, which may lead to null pointer dereference.

To fix this issue, a null pointer check should be added. If it is null, 
return exception code AE_NO_MEMORY.

Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698..8dbab6932049 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
-- 
2.34.1


