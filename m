Return-Path: <linux-kernel+bounces-152502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B78ABF68
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314261F21827
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E01317BD4;
	Sun, 21 Apr 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx6zQLop"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D411C29F;
	Sun, 21 Apr 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707339; cv=none; b=HaIH67yBmeXRY/KqGy6tnDHKsBZzW6zWT/ubVefid1ChRAGJfaewdJ6hUIy6573IBqBdG5p+MefNOhyw2VQLw/xiKdbep26eaHEkm6X7DsQOXMxhMxTIDA1/TodivtND3S4dOVGWESoqtW/YgImF73f4Dr7wW3QPsVdWMwoOX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707339; c=relaxed/simple;
	bh=Y9jIyElOMp31XHXfaCIVTLoMyn8wDqkA34DCh0awnvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oinBLTiDXDSL14ka0l2Wwo3jnqvCtylnFqAL4PBSWjpu8v9kykt1SHouYi50v8PXPOnaGryhzVy0xKmaEu9SmP4OW6WWLnc67eYIXBxlYVeMJCGM37hTULXWAGTSFq2er5Jj7qImGxoUTvBZSacIhowaZV+8/S4el5/yGj73URk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx6zQLop; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed627829e6so4016303b3a.1;
        Sun, 21 Apr 2024 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713707338; x=1714312138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAq3AHvWEQFsKDgpu//rdmbRIcBJ6dLOs4RYotedEeg=;
        b=Tx6zQLopnJkmPQeroWlWtNHVVFP4NZSBfP+CV8kfhhmDeB5pPfh86sFz43FOO2aISl
         XJTWhIZfwNCaOkV2JxSB/2Kp+VhB75CX9bx6BKzccB/UQIs9VbqfZqX/0kRCLZI7S7de
         1kYvhPh7MD0zc+G0sCCoA3hTEVug8jK9sr32IderaCqZbHWQlMVKHj1+WeK5OVwqvEub
         w/8kdSAi/gHHtRQl7pOjxM+AWWeszXFVnZxxIcZ/t9SvUAsba0Z31snoQylO1yqNJYwk
         jEbr5W9XuDPRAkedjdSKip6agfJy6E9G/Fq9xE61GzYGSEkpV6ehzcltkglaRFpMyQ8o
         FQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713707338; x=1714312138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAq3AHvWEQFsKDgpu//rdmbRIcBJ6dLOs4RYotedEeg=;
        b=e7WmupRFU921uCvrnLtLYigQJ76w4ESoOd539E3UsTxfLxXaF3uwMChEG6DjEVel1u
         +7zNAyhPws//rtzlmsk08S0crhs6hm+w/cx/NCiwm6c4M/gekCNid2R9knP+LWoxFNjK
         ONnney3Fkyrpm1TGV63XZaCQksTSkUiyZAsgTmA3i0g4c6J1PG3A3b6PTIVAYn1zOfDU
         1Ms+8pXFNl+8RLOSgUJvhQRcgeFCytIDYsRRBFSTmR6CjQ9ECdlfYF7mM4oLGGzHefQ2
         DEbV982YhVTkRakN2VCFzVSZvdJddNueg6VKz6wfYJW75/U8sDZjUFp7zDlMusxKhr7r
         aFMA==
X-Forwarded-Encrypted: i=1; AJvYcCXBoWA/ya0WcTFFIkn0PToMHCKCDmSfMcUZlCYdc8gitb9a9cltQdTNFUeeW0n2LZGrjnctEazVcXTX3k2vY4BaFLpddiahJKl9I2rN6IC8ZILkt0KUPx4atRRZg3TQx+mwo8Iof6BTgkUgRe11bk41Gv/nHKMCDZ8XKDWCPkABxqjssY6e49zRIiU=
X-Gm-Message-State: AOJu0YyCEZsUT7bnWOzw+I5Su3m60xozxW/ku7Umyc7FMvOqv8b3BN/i
	cjYU97miwnm2SWuS68ImMsFe0HPisaoHEj2OFFBle++cKmKtq2wn
X-Google-Smtp-Source: AGHT+IFqFGNGrYSxduO+G3kiUy/CR5IuQrcVEgPwVltGpWh2slVvuWUY98I8IosXloAx10/SaETCIw==
X-Received: by 2002:aa7:8883:0:b0:6ea:bf1c:9dfd with SMTP id z3-20020aa78883000000b006eabf1c9dfdmr10512702pfe.27.1713707337795;
        Sun, 21 Apr 2024 06:48:57 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id o13-20020a056a001b4d00b006e6c733bde9sm6175043pfv.155.2024.04.21.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 06:48:57 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] usb: dwc3: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date: Sun, 21 Apr 2024 19:17:34 +0530
Message-ID: <20240421134752.2652-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421134752.2652-1-linux.amoon@gmail.com>
References: <20240421134752.2652-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro has the advantage over SET_SYSTEM_SLEEP_PM_OPS that we
don't have to care about when the functions are actually used.

Also make use of pm_sleep_ptr() to discard all PM_SLEEP related
stuff if CONFIG_PM_SLEEP isn't enabled.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4 Fix typo in commit message SIMPLE_DEV_PM_OPS to
       SET_SYSTEM_SLEEP_PM_OPS
   Add Acked by Thinh Nguyen

v3: fix using new DEFINE_SIMPLE_DEV_PM_OPS PM macro hence
    change the $subject and the commit message

v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM
   is disabled.
---
 drivers/usb/dwc3/dwc3-exynos.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 5d365ca51771..3427522a7c6a 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -187,7 +187,6 @@ static const struct of_device_id exynos_dwc3_match[] = {
 };
 MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
 
-#ifdef CONFIG_PM_SLEEP
 static int dwc3_exynos_suspend(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
@@ -230,14 +229,8 @@ static int dwc3_exynos_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops dwc3_exynos_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_exynos_suspend, dwc3_exynos_resume)
-};
-
-#define DEV_PM_OPS	(&dwc3_exynos_dev_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
+static DEFINE_SIMPLE_DEV_PM_OPS(dwc3_exynos_dev_pm_ops,
+				dwc3_exynos_suspend, dwc3_exynos_resume);
 
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
@@ -245,7 +238,7 @@ static struct platform_driver dwc3_exynos_driver = {
 	.driver		= {
 		.name	= "exynos-dwc3",
 		.of_match_table = exynos_dwc3_match,
-		.pm	= DEV_PM_OPS,
+		.pm	= pm_sleep_ptr(&dwc3_exynos_dev_pm_ops),
 	},
 };
 
-- 
2.44.0


