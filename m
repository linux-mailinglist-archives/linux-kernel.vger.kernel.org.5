Return-Path: <linux-kernel+bounces-56272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78FA84C82C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC04B27C56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A7024B2F;
	Wed,  7 Feb 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwkJ6OJH"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3670250F2;
	Wed,  7 Feb 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299943; cv=none; b=JKOsueoT7Yn/esEuDwJTUOhBP6sEWtYDrU6LMvSsE00JjITGoYun1nx+ZQHPhLpSKLW5VRswAk81fT1bB6RJrQ0mVUzlUnwRqKI3tzH4iTlylyJwFcjVm5fKWRVRNzZ7ahTXyF9ZC59Tx6R1s9MBJe2eH6CDRfn5Muhku/V7B9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299943; c=relaxed/simple;
	bh=i63QLZf/wIh/WJBSfouiNWXUDcOcWR/zWTs95/ThghA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RzqZs8V4zajOk6CnFS0aG+L1t0frE1N9MGBJh/Hziv9t2F6QJWtHPEy3/O8Aw/ATzPmmgHRPf0GECY8fNiTu67Zg1+8r+EeRRtj/NFYO5+Fi3dmGvM2kVjhXlP8uZyX+OilEB7kxmOEK7aKW59KFIG5sW79JJ7G1pY5Lg4BtoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwkJ6OJH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51124e08565so629993e87.3;
        Wed, 07 Feb 2024 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707299939; x=1707904739; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWpjv7NMSO49fP0LrCFcUvcBiasQuCoytT6mlIOXr/s=;
        b=ZwkJ6OJHJaAt4hYxlno1U8inV4CzFnnwIQSADyKvMcy6eaTDogZfBHH7Nw71UriIv3
         cKKbVSUYNHr/J2YQMvF853k6xCt+bPZ+BRrCYYI/p39wXQjVlVyWclgnZ9rfimTJTBLD
         t3Aow2TGmZRxbJiodyTZpFQwmK/wXiHx2to3zIYCYDPzwPsRsJW6mUUBOx8FnDJq+sH4
         c1JNI27Gc0vvGfDeCbR3cqRbddoxVIIn8iAl5NjaYDKwhrj9CEAcQ+yz82lnNI7TyYF0
         xH0stdcVL6zaKBNm+z2Yu4yphggOwjnKRPtfudMLysSGHCSDotBfNdh2n7FeNeqid795
         HteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299939; x=1707904739;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWpjv7NMSO49fP0LrCFcUvcBiasQuCoytT6mlIOXr/s=;
        b=cG6/Pm5zRz5IIGBYYk+6uTg4TFYR0JWJUmUtw6LeBgmS6bqso6vlhXzxkkEn83PQnK
         owwWkfWSvG+Sa9CtI41I5yHnIDznEPqrgrLMJ9Hls1mYc6goiOqlSFIJAF1ikNaM/8By
         AcozIQwmKdMufAhoeO4Tg+njCCMK0pQJGr3hWeb2Kb1wIfiFjxDqnxeLScAJT2MXQGNT
         tJAUBGQbew6Qmps0ppR1e0vXQsEX2uQI+VrFmijgD20K88QQCvEKdM3RjH4Ii3LbI34p
         H7E4+sCfUt0MMCIwxEyhqg8PC4WKyzgXhFCVJahxGDvXZ2EkwysYQzUgZ1EdoJaoNDOG
         PaCQ==
X-Gm-Message-State: AOJu0YzN1zHEcRZiCir8g6VyM7A/txLfntFo4yFBYaAMVHOFds47KmAF
	NFkGrKsHPB9F5MNrML98Y8CS9rPwLly2ZWutZXJNsXeLRMq4JV9oMyp7sK6k
X-Google-Smtp-Source: AGHT+IFIiBNFmCiLygDZ9ZDhh0MCoRLrT+oYrdvV8IATTuZn9aqfDK+5o3Bk7CwtfkovJt5I2PHA1Q==
X-Received: by 2002:a05:6512:39c7:b0:511:50a2:e750 with SMTP id k7-20020a05651239c700b0051150a2e750mr5131287lfu.33.1707299939132;
        Wed, 07 Feb 2024 01:58:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsFDgyaJIyStR41RFV9VXFIG/WP1oWoSmyHQi2pr0pLJLLCnGsHmS1szlducxm8ukOPpa7Q9DSoy86TbRURvik/Zeih1siOUmfxwR7zsC/WYmdiOR+MAfWRK/O2PR8KC8O
Received: from ppc.Dlink ([91.223.70.172])
        by smtp.gmail.com with ESMTPSA id m25-20020a056512359900b0051151e530f4sm122150lfr.204.2024.02.07.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:58:58 -0800 (PST)
Date: Wed, 7 Feb 2024 12:58:56 +0300
From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dlemoal@kernel.org, hdegoede@redhat.com
Subject: [PATCH] ahci: asm1064: correct count of reported ports
Message-ID: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The ASM1064 SATA host controller always reports wrongly,
that it has 24 ports. But in reality, it only has four ports.

before:
ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst 

after:
ahci 0000:04:00.0: ASM1064 has only four ports
ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst 


Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index da2e74fce2d9..ec30d8330d16 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -671,9 +671,14 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
-		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
-		hpriv->saved_port_map = 0x3f;
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
+		if (pdev->device == 0x1166) {
+			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
+			hpriv->saved_port_map = 0x3f;
+		} else if (pdev->device == 0x1064) {
+			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
+			hpriv->saved_port_map = 0xf;
+		}
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {

