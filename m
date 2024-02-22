Return-Path: <linux-kernel+bounces-77060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872FB8600AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9441F2576B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6161159574;
	Thu, 22 Feb 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgS/draF"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B011586FE;
	Thu, 22 Feb 2024 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625670; cv=none; b=c2FkqOURmUo+MwWNkY3HJmmymU1uhLR48wUU3PCNwNLkmdAm9R9gxV4FEtYjJPZeytlYX44fxS7uRfe+/415GV1xqE2Q+p17M34BYxRF31WtCF0IwYcG2KO4ZQHa+K/1hAFn4uzDMarc/T0Hsk2zRxM/56mYR6GyiBm+xK+LG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625670; c=relaxed/simple;
	bh=qvt/AxuuD7wwbgx60w7qybSQURCLd9kZ77gSrC/d+OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFY8wCUKGpFDz5KOuY6s3fnEOr8b/WlKLxrSvnh8SSaz9AQ1XX88zBvyDMczs/K2NX1GjScR+KJPBVWe2yDDxt1ytrwIA+NgsyrdqwBriz/pc+41Hry0I+ZNwIzJOJQop0HsRg6w7jeFni7u7tOemgTGSulyRUJOf24Q1FqpgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgS/draF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512aafb3ca8so92422e87.3;
        Thu, 22 Feb 2024 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625666; x=1709230466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0PkFM1zHHNODsMfc/INZSKS8pmA7KHQoUde1CaCg/A=;
        b=KgS/draFvQy/FNfwqqAh+O3dVfhyX7v+jMYRVoXHI25AU9/9f5leVsm1D+ra1kK80F
         7ZxqK6VKAu472cLY/mEZpzhupvB1JPLSYbenX+CS1chEhQKi2IIrbEyYkzyZBZcDTmts
         qEvhcs1Ms9P+h5nZcNntgLXL9Z7YCtzyaq6Tnz81pmKuIWTCBpS5k6Z9MFGOOudqR8BW
         2bsOhjTlqDL7JsDSCizGSqteRU2KGulH2SNI0b3bG+epAhW4y3wk4m0sTYG2bhRLaOe4
         G9kNxV9wmf5xDSl7v4nD8wBYYHd0os4Aet/C8g7JOe5qz5CHdTQ9w82cNWwYy2zUicMc
         RlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625666; x=1709230466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0PkFM1zHHNODsMfc/INZSKS8pmA7KHQoUde1CaCg/A=;
        b=Kw0F3iJdD4dIDXqVQjZHS4pHv3cxUuKRJcttm11RZIdJRX7HaMn1fTWlB+pa96Abnu
         aXeJ4XFmM51ds0epkrARz3uaHPIfCqya6PKJJAnGAa34a4vP7rEkQA/yOKb3aXOOW78J
         uTIEYB0pkKCeE6BmxL43PJismPjh3l15cCuEubMrW1c25eZJkpXEbdxgtic63uk+d02y
         3gf1+iKZYv1liA1NSrHrwPIzEC62lVBJilPyG9Wu33P6091Osl3jmTwggXyj9aK8CM9l
         s5LT1Gfvqp0IjSCBpK2t2WNFPquFAN3zQNeFo8BMmTC9XySbU92QYUX+suI0BrbZGpX/
         XEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGIJadneJ1m5njLXW3zUdLO9co61jzOKmCXd3NJnJS0ucnKwTiICakRz20hSyp2IIqbKFpSQ4RC2dkfKd/pKGFPb86biIEXxunnKKyYka6cJ3ZglVsHFy4cBVr3u5M2rRiCnmuBNsqkg==
X-Gm-Message-State: AOJu0YzgSLAw4zpPrlICk51x22mXHLycof22TBm3MqDVYSI/nwYB/XLc
	XgOZbkeGFRO24Vnz62CEaDHNzdXHySt0llaqqtC/GJ+e50EKSCk5
X-Google-Smtp-Source: AGHT+IHahT0a07aFA2OedK8mTZdnaBkfS3CSGBF+9vHiELIFN8mrf5vJu/bEAFsJ399T8e/mgXYx1Q==
X-Received: by 2002:ac2:593b:0:b0:512:b366:6c42 with SMTP id v27-20020ac2593b000000b00512b3666c42mr8072382lfi.32.1708625666512;
        Thu, 22 Feb 2024 10:14:26 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q2-20020ac25a02000000b00512daaef13bsm398124lfn.102.2024.02.22.10.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:26 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH v5 03/20] EDAC/synopsys: Fix mci->scrub_cap field setting
Date: Thu, 22 Feb 2024 21:12:48 +0300
Message-ID: <20240222181324.28242-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mem_ctl_info.scrub_cap field is supposed to be set with the ECC
scrub-related flags. Instead the driver erroneously initializes it with
the SCRUB_HW_SRC flag ID. It's definitely wrong, though it hasn't caused
any problem so far since the structure field isn't used by the EDAC core.
Fix it anyway by using the SCRUB_FLAG_HW_SRC macro to initialize the
field.

Fixes: ae9b56e3996d ("EDAC, synps: Add EDAC support for zynq ddr ecc controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 455d2fcfd8c1..7c57c43b4d31 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -855,7 +855,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	/* Initialize controller capabilities and configuration */
 	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
-	mci->scrub_cap = SCRUB_HW_SRC;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
 	mci->scrub_mode = SCRUB_NONE;
 
 	mci->edac_cap = EDAC_FLAG_SECDED;
-- 
2.43.0


