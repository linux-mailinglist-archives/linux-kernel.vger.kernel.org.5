Return-Path: <linux-kernel+bounces-96005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8488B8755F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C371F22FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12029132C19;
	Thu,  7 Mar 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF7vrSnw"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC6132494;
	Thu,  7 Mar 2024 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835459; cv=none; b=cLghDe4ks0yOooBoIzTQI/fNrBTplpwDWFdlLGaQveXrb59RGlF6kvgoGsoSZZQrQC3PKc+5Mpzb4j7fUmTl3kWKrMsA6CWKgIm6MbqIzR6yV0vUl5aXWbN8x8uZTOmtji2L6GhCWvKSPyZkeBI8eqqXuAeBeJYbQE8DOwoABd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835459; c=relaxed/simple;
	bh=tS/IFPg7cx1pgTE8i9jCOG/PSDwlO/ZsPG9gatsNzZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GlEtWKjZ/yjHwu+K5U2mQuWEsJBRWn5kifWI7lZrpwdRCvTlugWyZX6FbbIPmS61JXFNsRQhurWsQxdOp3EPxsu2XASXswF/rtMxCXa59u/doxcfUco9Uu7u/jE7qYi8KPv5BR02lnTodGQUrdQdWdhcDtWEC2uqs2EwbSV5zbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RF7vrSnw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ddd1624beso782475f8f.1;
        Thu, 07 Mar 2024 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709835456; x=1710440256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4IzLeRGDXIml4WPRP0z/vVkc5vfGEv9d+YctMnKNIQ=;
        b=RF7vrSnwAPwaStIzwXNK5M9TL15xNRpGauS80BK3OjvBDoiySj3KxCEGhlmDAq+NF+
         UxkCHX0gycoWXrPEbb+rps1TGxH2WdtbnxlMtaUbshy2CWZ8tOkoDn296S5oOD988uYh
         /MCrJtPhURHX5DLIiQ3dDuPAUfwvo3pfcqJxCLw/L7Enh9GrKKH7iQ448wdLof5NDj8b
         byK/I0uAUCwR7E7xHyIPAa61X7URKPGXzTefwQNIvVxjEHQfpYU/FPsC5YgQFExxfVT3
         FXuOjbWKfsh9XaB7fF416wsQ9rOu51zEHZFLF7y1iMlexaIVL8rpGUsTI1bMioxF1hT0
         XPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709835456; x=1710440256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4IzLeRGDXIml4WPRP0z/vVkc5vfGEv9d+YctMnKNIQ=;
        b=pFu88zBeArTsG5pH7hWs6qWTVvM2AV/QzCk+t1Ry94kYeM3rbfJzOuR9axNTfBpBEB
         8GQEerZiWKttAs8+YMVZs0ODPoxszwRAtJ3MD5XjuBcy2xcApSD93VlJ8/pQl0K0InkN
         cgySD8GAjmItuVeXC0tR0tT5cuV11EWHckyxyKTb/LCcZz0fBLl5R+CVRRB8DF2eAYeV
         6QJSYZeDby8GJKBTHIwVpCpA1sAOgGsyCrDAGqu78x2ODB/MfXsi5RjUgXP5SkQMbjt5
         B81SpGFeaYfNs/cm1kaN1y6waQtKTOroMrDzqOcULGcVEkat43jxVTDviVlE5bMSaT6i
         9tjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA9e87Sb/Dh2cqlZ17NW177IBS4Q5SDRT4/BfVjwxi/CIsRIKmNdxmFrNck5EKslMb5HSd9nwnIVQGXlp2BWtUHIW6teCjN4n3t1A+HiknXOTtxQ13EAuGbiThMVzKytl3M6T/neeJ
X-Gm-Message-State: AOJu0YyMmw3RigPil5eHjVDx3O2WkKZs3I7MkA6u0c71HZtEUeZckrMY
	WsfVO1ehpx0V/5JmDHwgTLZBHnTK77bSO+lPW1aw5Cov9SFCE+K9Wg5o3eGh65k=
X-Google-Smtp-Source: AGHT+IFhXEcBUHBfrGKPRVKKjnrYD0VO7ipK2IkyLwPd+jvBJOsv+bpjH/6Bly7zRDfwPiRtfhvtag==
X-Received: by 2002:adf:a31a:0:b0:33e:73a3:fd13 with SMTP id c26-20020adfa31a000000b0033e73a3fd13mr624632wrb.16.1709835455886;
        Thu, 07 Mar 2024 10:17:35 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bw1-20020a0560001f8100b0033db0c866f7sm21242811wrb.11.2024.03.07.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:17:35 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Roy Huang <roy.huang@analog.com>,
	Ash Aziz <ash.aziz@plxtech.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Seth Levy <seth.levy@plxtech.com>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] usb: gadget: net2272: Use irqflags in the call to net2272_probe_fin
Date: Thu,  7 Mar 2024 18:17:34 +0000
Message-Id: <20240307181734.2034407-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the variable irqflags is being set but is not being used,
it appears it should be used in the call to net2272_probe_fin
rather than IRQF_TRIGGER_LOW being used. Kudos to Uwe Kleine-König
for suggesting the fix.

Cleans up clang scan build warning:
drivers/usb/gadget/udc/net2272.c:2610:15: warning: variable 'irqflags'
set but not used [-Wunused-but-set-variable]

Fixes: ceb80363b2ec ("USB: net2272: driver for PLX NET2272 USB device controller")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: don't remove irqflags but instead use it in the call to net2272_probe_fin

---
 drivers/usb/gadget/udc/net2272.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 12e76bb62c20..19bbc38f3d35 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2650,7 +2650,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
-- 
2.39.2


