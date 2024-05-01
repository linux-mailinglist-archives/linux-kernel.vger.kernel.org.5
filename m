Return-Path: <linux-kernel+bounces-165283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A48B8A98
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D81C21C22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C212BF1D;
	Wed,  1 May 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfJIWssj"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC81292FC;
	Wed,  1 May 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567925; cv=none; b=TYPn+T4RG2gUX6/4fFrh5hV1n5Tlps4t9wa8s82XltkvV63JdcEmu/pFckwrJfMM8PZ+PKWohmFOCITpJfeQWOI/XCDZSdY+cqqDpaXFA/MNcITeDeBj2XLTKiPLq94Fe4auwv71wTcDupR8WWWH53q68URjoESWIJ2yVJVWPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567925; c=relaxed/simple;
	bh=B4MxyGe8ujuxUYQiduH+SJm1w/8TfpEIpN+MIF9noHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxyzlLF2aS+8eKIdXntejv1zAdK2z0W2Pc8aZ8obts02zu2n08ssaLqOmMHxRZzZTMPqXEjmLbP+UHyA116XCO6D42KimpZpzWiT9q5CjJwUZUf1eWoTllDcnBqx0Zy4te2ta7F0otCAgSjPAHaYTLOp2/KrWh/hlOFs57VMhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfJIWssj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so5671760b3a.3;
        Wed, 01 May 2024 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714567924; x=1715172724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/dJlWSPreiopPSl6wgz1zP3z6iVTFkuzcbTcNZ6zic=;
        b=KfJIWssjj29QYopPVsvdOHoOmKHpNlUtGBUnQkqxaHmTnv72Uk2FAE7oAyLaCCTdUG
         fewMkM/ch14oxns1olYIcYGZ+LaWRuf2pu+BBEzrveCXPn7u9yxGGMuR7XrvXF3Ou5uw
         v2fiOKzLoG6xipKoBOR5vZFJulXX1DYSfHpDgAoUyU+FUGqFw4PN65IxWkoIbCYfvsG+
         4mOB+pDcWxHBpGQ/G2ZsC0TqEqpHz6fVV7mEiO8WPYzXepEQ+u7D/WGnQMUSsEjdy5R5
         p3qo0wS99pExJ1vZ9Vk0vEw8nIhHStw4wmf2aHqwYFU2OYdb38pbUYg+lmK4IMlGW2Bq
         zAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714567924; x=1715172724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/dJlWSPreiopPSl6wgz1zP3z6iVTFkuzcbTcNZ6zic=;
        b=bx75iooQpVddFzdK3b7k8JE2H/sSlWXIdI8Vt2+r7EC2T2cv9LzQnkcXJ3At+J9UfC
         V/SH14L97RDMghmqG38XFt6ffLa/rLkTDG78tZkEeaL0NHP4Fu3LNNjrohCHaKULTA2k
         GGiA3l/Hpb7eioslZssPxLG3a7DEI5o5gHRqPodI+wpBZ1r3ad4JR2xd0y4q+JQIPNwr
         3QD13SAnX0oB9iC70zQrna0XAKeGhqbB01Fae1ViLN/+XE06d+U70cxDdyXIs4m4CAyx
         GKcjUmA1E0CqGZ/U+0f8xsunIvQh1HKnHoy1TexH6WmYuOGmpNIr3pFb1+6mdAY3on6x
         RjzA==
X-Forwarded-Encrypted: i=1; AJvYcCX8MdXBqfxqdIjn9l21C/gZZbujY4BlRZdz2TYO04Gf1kNkeCcJjK4ylVZkmwZknSIqEEU4sNkbKK53ntr4Fyi4VghTQxa+em2Tcs2L+DB9E9Hmdw53ClP6WZUHCPGocPI48HpZtcLtMwA=
X-Gm-Message-State: AOJu0Yw5yNNI2/s4INHT/BxRVRJy/IQc5aOOAQ85C4uHPVLV2Q8FcAWO
	R/5XFcUDjf9PIxira6q1SiCKCoyK1R5Qy8PknEL71i1v41az2uT5
X-Google-Smtp-Source: AGHT+IG9pZ629ZawhSJloqIJTILZG+s27Bbhu3JGaf+WQGhAeV1DAcYc/NGiY8Iwuy6byAhwjoXamg==
X-Received: by 2002:a05:6a20:ce4b:b0:1af:3715:80c8 with SMTP id id11-20020a056a20ce4b00b001af371580c8mr3408299pzb.46.1714567923655;
        Wed, 01 May 2024 05:52:03 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:7cbc:420c:c1c5:6f2e])
        by smtp.gmail.com with ESMTPSA id c2-20020a62e802000000b006ed4f616ec4sm22545230pfi.57.2024.05.01.05.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:52:03 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	R Sundar <prosunofficial@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] backlight: sky81452-backlight: replace of_node_put with __free
Date: Wed,  1 May 2024 18:21:46 +0530
Message-Id: <20240501125146.33648-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cleanup magic to replace of_node_put() with
__free(device_node) marking to auto release when they get out of scope.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---
 drivers/video/backlight/sky81452-backlight.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index eb18c6eb0ff0..54095872a33a 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -182,7 +182,7 @@ static const struct attribute_group sky81452_bl_attr_group = {
 static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 							struct device *dev)
 {
-	struct device_node *np = of_node_get(dev->of_node);
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	struct sky81452_bl_platform_data *pdata;
 	int num_entry;
 	unsigned int sources[6];
@@ -194,10 +194,8 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	}
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		of_node_put(np);
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	of_property_read_string(np, "name", &pdata->name);
 	pdata->ignore_pwm = of_property_read_bool(np, "skyworks,ignore-pwm");
@@ -217,7 +215,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 					num_entry);
 		if (ret < 0) {
 			dev_err(dev, "led-sources node is invalid.\n");
-			of_node_put(np);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -237,7 +234,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	if (ret < 0)
 		pdata->boost_current_limit = 2750;
 
-	of_node_put(np);
 	return pdata;
 }
 #else
-- 
2.34.1


