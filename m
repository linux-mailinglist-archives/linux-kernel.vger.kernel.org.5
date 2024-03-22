Return-Path: <linux-kernel+bounces-110920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52E8865B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BDA1C22315
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92906FCC;
	Fri, 22 Mar 2024 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl83Gsid"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456566FA7;
	Fri, 22 Mar 2024 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711080613; cv=none; b=g6PdQrRGKrRzE0w3+Q5NsKxf6VV9oR0jnUUVU6FDTAMCFsVH2BWsZ0FNRYQECehG4OlqhokItbR+oEPATNgqI2WynVU+RVf8lsrDdmk+vodgOrme+zMLhEGiRs8ej5l/WmUPq7caOXBdovb0PNYGOUXe4V+Ez7IYIjCd6eiCSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711080613; c=relaxed/simple;
	bh=bYqOgOUndYgF/xG+o0Gh2rPPW4U8Lxkdfch8sJiHQwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3rNgiWAQbinMHg1SxbtFt3HRGQfvhKWdcTKh50btrgxpKFmxma9d/k5uqN4QS7PArOlFKikY1cxrgV+Ie6dBpzo8hyxq905Q5Hk+8rIvv2moJIY1eeUat3Z5qBYw2JJQqwW3Lz7rOtRcvJp6Lxr2aBHyM8Rya0Hjitt4yDc/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl83Gsid; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-414783a4a4eso5615165e9.0;
        Thu, 21 Mar 2024 21:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711080609; x=1711685409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NA3Bmop1gCKtv1Q82P2cRoeegkqQuerIZY6ItFpjOU=;
        b=bl83GsidPhTfZEYs+NjjD1WSJGDdQYDjctamSAkqQKuha7+pxwTA9Vh8TqEGi7tDDB
         upXkQGc2wXnD3Ph/e5CMQWpUt9IzVL6/xvcUX4+Uhs1+A84LGS6WiGpI1GXCHeQ84FXV
         MeGIiYU4YPr2OE5vfpU+dibH066rWWIHXwrqUhFjmTi2rvImlfeGO9fFMJuBKFS6MJXU
         Q79B2h/8hPLBy0tvAF/oOoCop49VTsXCaQCsvCexopmbFqN6TfjD9pgU7wVXQqCGdtO3
         OufUf9tJ6DtFqqeyE8fmBbKKXwCVkGr/3FJ64ScMTqyCrx7ctWF2TyugrOYIm+fY2EFy
         wibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711080609; x=1711685409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NA3Bmop1gCKtv1Q82P2cRoeegkqQuerIZY6ItFpjOU=;
        b=K/885Cr/AE4lcgVOH+tBIkDI51zhSBu3y6jBtoiSb+X3koC4/Q4U2HlSQo+v5XGk+T
         WdYIy9tuniKcCYz0MmmBiParSgZU4/yFV9al0HPpet/uZ+4Mn8NJfkz/6K+V94Kwuq34
         dUeF/T3EnQRgnbQn5nMGxquMwqcbCsPIxByea7u8JnBOXC7+aNA5HsRbCkfCHqHiQhpN
         T67UAr5+SKrKLHxliwszCqPNFjfoRuE9dBV3JMfG9T6Vi/3feuXV/86Fq4UP7pgwGVNF
         hgnIZ+CfWs75sgwlXFrR/jaxw1t7EsSY8f45FlsOe4pcHAI3RP94XWii+6sDQdqRqbL/
         k/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCV20pB1pUrPna8G/UBl+oG+P8JB0rXhGSW3PS8l0Bvq/8hnJXZ6vaM5ubQlhqZ0tbfYrhUmsJHf0kGCSZNLkjxVrCLrfFD+OCxgOdh6xqrVDU2fmgs1PGkVP3ecTqbb4v8nBvcB
X-Gm-Message-State: AOJu0YzZrvPdxzZhdg+s9Q5Msi+pfF3mH38HlkRrLrDuB/5c6p0AJON9
	eJfrJmKisOubhiCeGFKCHp3FBXAq189Vf4FYbT5PxVumwd/GLUjZ
X-Google-Smtp-Source: AGHT+IHzryKQyKjUaWMydnS98Rv2D/wqKdSlap+b3Gib6PJz45la8lFONvHSzUUr6Wjek487pAiq1g==
X-Received: by 2002:a05:600c:35d1:b0:414:fd8:10b2 with SMTP id r17-20020a05600c35d100b004140fd810b2mr632367wmq.8.1711080609255;
        Thu, 21 Mar 2024 21:10:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id dj9-20020a0560000b0900b0033ec812ee0esm1058605wrb.71.2024.03.21.21.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 21:10:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
Date: Fri, 22 Mar 2024 05:09:49 +0100
Message-ID: <20240322040951.16680-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTD OTP logic is very fragile and can be problematic with some specific
kind of devices.

NVMEM across the years had various iteration on how Cells could be
declared in DT and MTD OTP probably was left behind and
add_legacy_fixed_of_cells was enabled without thinking of the consequences.

That option enables NVMEM to scan the provided of_node and treat each
child as a NVMEM Cell, this was to support legacy NVMEM implementation
and don't cause regression.

This is problematic if we have devices like Nand where the OTP is
triggered by setting a special mode in the flash. In this context real
partitions declared in the Nand node are registered as OTP Cells and
this cause probe fail with -EINVAL error.

This was never notice due to the fact that till now, no Nand supported
the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
access for MX30LFxG18AC") this changed and coincidentally this Nand is
used on an FritzBox 7530 supported on OpenWrt.

Alternative and more robust way to declare OTP Cells are already
prossible by using the fixed-layout node or by declaring a child node
with the compatible set to "otp-user" or "otp-factory".

To fix this and limit any regression with other MTD that makes use of
declaring OTP as direct child of the dev node, disable
add_legacy_fixed_of_cells if we detect the MTD type is Nand.

With the following logic, the OTP NVMEM entry is correctly created with
no Cells and the MTD Nand is correctly probed and partitions are
correctly exposed.

Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax fixed OF cells")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5887feb347a4..0de87bc63840 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
 	config.name = compatible;
 	config.id = NVMEM_DEVID_AUTO;
 	config.owner = THIS_MODULE;
-	config.add_legacy_fixed_of_cells = true;
+	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
 	config.type = NVMEM_TYPE_OTP;
 	config.root_only = true;
 	config.ignore_wp = true;
-- 
2.43.0


