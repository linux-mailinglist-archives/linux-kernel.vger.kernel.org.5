Return-Path: <linux-kernel+bounces-144635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F28A48A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700141C2273B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F2208C3;
	Mon, 15 Apr 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHmzOfbV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19521171C;
	Mon, 15 Apr 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164810; cv=none; b=AWzqQth+qSRjUV9k0UkraUuYxKKZE1E55OY0ZU8B4z8beyh/ROqonA9GEDHL/Qkl5aPL8E1ctiTzziNRqU+Cocu0tiAY9a1JWuomWYqTCPz/xuyNAd/Kb07pVE/hC5syqhImzIzZZMmuZC5TyO583EpYHwiHBt2kqMgrEl7UOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164810; c=relaxed/simple;
	bh=YKuJfRTjciZPhyxgyG6DA7n6YZ2TLld0CbjLQtdO4Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GtIljTr9oL5fP0bzGMObBzjNnOoC3qvIkpfrw0Wmhh1ujMzn6NL7C6vD+M/WipBPBQATzSrB0Q+H6zifesSDvFxRRZq8cpNYUWa7ATCVuggf6TiQ9Jd0ztvQveAkQxyBUQP2Yn/dSREKpwdnfJUQF2UwceCXjCUVN5XgWL7DFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHmzOfbV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e40042c13eso19350405ad.2;
        Mon, 15 Apr 2024 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713164808; x=1713769608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kB+FGGZ1O8+acAP7LbuhoplMsezAErVFwb8wVQ9L3g=;
        b=HHmzOfbVyW6a3+1fBS9ODQwhBFWX/KiiKEfrsW0uk3aJqojMw+4vDwH8ryo0XjOT4f
         Sonak0UC31pKaA0d/NYGfm4Hqc9YNBOEWEjomB83npLVIBmGjXoqvbZH2Aitjf3ZCqLU
         TO3vs7YCrMpDwsteU4dnYM9h7Zp/8UOfU/O39dO5HMooHC3NklpMFnV+vEcuu93pW3wO
         pqpdQ17wIkonSdsQ3NfTu1yOWZRNN0oPRgzInro4hxb4sMz3Rrh4qKXN7dXauQzVSzmR
         ddjJxtSDq2GHggHyixcsJRPNpp19+7CdlnzoSc5kM59ikL5yxFZfvvt5iC1WTH6M87Ro
         wJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713164808; x=1713769608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kB+FGGZ1O8+acAP7LbuhoplMsezAErVFwb8wVQ9L3g=;
        b=cd4HWo09ZQ9jNL64cVcLg3AmNcyD2skBpkRcbUJQlzJU2cQ90w2sxQhyNd2d+alMMA
         m5e3iQ76XZTBj6fT453Uv2PFWTtgiJT0pXl8uoPAPxGJL8Kc1u3S3Mz1h3l+xe9y/4R5
         4c89VGa096Q99eyHTt0UE4X1b7TxN+OFRlvpLtexAaZrpmtgpPYsB1/LD2CLIBPktwwp
         /ErwYx/f7yiYP5pUqSvCX0/AQBtUqSW6UB9SkECFydqqNg6oRffTeKGrtwDr3VLiLfy+
         GsDOrPdljK15ysbLREcrheqScYSsx+h8NJzHGowokaTx+Jw1krbOtTa47obVnunIp0Vg
         c+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOn7qPzijFFJblfR5vmL5p1tZzkYIgqqW5Id/ebR/jTq60fBxdqXKnc0uXbVuLu9zunioKWTiP/KExOCc2kJhTojNkwBRwEtfh9u7Q
X-Gm-Message-State: AOJu0YywlUmsJxEwFxLkBeBGPy4UikKgk6wo71WAV8XIEdpzmIsz55uH
	3Ja0moBh1+4F9+4cWamBrY9pQ2JV7LL1A/uVoRpYQ2mETFXjIV9GFkmLhQ==
X-Google-Smtp-Source: AGHT+IHbW9V0dfDw+DWClhgSHiLxrom5pEzPyCvBJsgmCR1dx0pvZ9ygwXh0Tta3KFvhhHZ2Iw0gkw==
X-Received: by 2002:a17:902:6909:b0:1e4:9c2f:d4f7 with SMTP id j9-20020a170902690900b001e49c2fd4f7mr7161372plk.28.1713164808070;
        Mon, 15 Apr 2024 00:06:48 -0700 (PDT)
Received: from den-build.fareast.nevint.com ([116.228.68.226])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001e503c555afsm7200909pld.97.2024.04.15.00.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:06:47 -0700 (PDT)
From: Richard Clark <richard.xnu.clark@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	richard.xnu.clark@gmail.com
Subject: [PATCH] sdhci: Fix SD card detection issue
Date: Mon, 15 Apr 2024 15:06:20 +0800
Message-Id: <20240415070620.133143-1-richard.xnu.clark@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmc_gpio_get_cd(...) will return 0 called from sdhci_get_cd(...), which means
the card is not present. Actually, the card detection pin is active low by default
according to the SDHCI psec, thus the card detection result is not correct, more
specificly below if condition is true in mmc_rescan(...):
	...
	if (mmc_card_is_removable(host) && host->ops->get_cd &&
		host->ops->get_cd(host) == 0) {
		...
		goto out;
	}
The SD card device will have no chance to be created.

This commit fixes this detection issue via the MMC_CAP2_CD_ACTIVE_HIGH cap2 flag,
parsed from the 'cd-inverted' property of DT.

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c79f73459915..79f33a161ca8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2483,6 +2483,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 	 * Try slot gpio detect, if defined it take precedence
 	 * over build in controller functionality
 	 */
+	if (!(mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
+		gpio_cd = !gpio_cd;
+
 	if (gpio_cd >= 0)
 		return !!gpio_cd;
 
-- 
2.34.1


