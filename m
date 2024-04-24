Return-Path: <linux-kernel+bounces-157160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA39B8B0D96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2BD2891BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7115FA82;
	Wed, 24 Apr 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJG39ONf"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093815F30A;
	Wed, 24 Apr 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971241; cv=none; b=CM9Pb6BSVbuPTOroHUxyQM+FGuaezcrfSJs427r52AvNBEgMyuDb7vqpQ0Sn4PISDN8b7cHJOTDRN6SEmWw19FsMVQhnqPv0WSdks4porCrdJizb4lFiozDgw0+9EZyVGCbHwcJN5pxxrWtIwVWFyiqb8vf8y+FEsRjQxlZuudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971241; c=relaxed/simple;
	bh=wn6duOFR0By1a9rcZwmatu6QiLy3rmMNGIJzk+ktlD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyBOvlGc6cnMDg+QSS3uWD7oYBXAplwhLDoy8y0ietqNqqvGFrc4jwW7OJd9eD0YZ9q1O3DffY3RsTYfhXnDeoxQFYdqWJUmfzimGMoup1/qZxforQ5kliy9Hb8zZ/NLswaXvPEW/NUBcqq+PEURmdJzf0OAW7NWPKcBcaJp/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJG39ONf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-518a56cdc03so8637144e87.1;
        Wed, 24 Apr 2024 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713971238; x=1714576038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXtT3vdT1DlOmZWPolm6flA8JD62wpxOz2LSc4zAwz4=;
        b=KJG39ONf9sTFwvT5TICSgm6lsdUp+4fOkb7jszoaOv6Wb7ts4ckhNbauRH+6/QZH0S
         jpDAxzvdlMgdeqzVezAs9h7W2+OEMRyI9w1G7RS5J2axBodX0sPzhXgw6vniF5o4V1fU
         x36JWyOCgsSnI+BWYxDo76vzG3XNpML3A2dud9y3R4zw+PXlwZV4+rbFW2qxcruXPEZn
         D8DJElxlpRZrfNFBZLZlABiDdKJ8nHpI+BTgTwp39FgOIsLOEN0DHUn6o+L19gQ+WHBh
         f6Wlp9NvIHJXscbFLbDVJLIv2/JGPp7+OAfwfnpPkmc9LG5gkI8QW0QI63djeSe/r9mf
         Ya5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971238; x=1714576038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXtT3vdT1DlOmZWPolm6flA8JD62wpxOz2LSc4zAwz4=;
        b=QRhAE+YiFoJEppvAmLoPeDiGvQ0VcnKit66RdVefdxVEFUXzZQUx/2AgAygO2Pg2fD
         deWK7Qrn8+HZqu0/IYBjMPu6pS0uonUOP54mflbsBOpv4suA0KYqRp70PNC3phtNgV3o
         YejeZ+37ZTHVJccpQnQSm976irG3m/FcHxmPR4cpgwgt6MHU+FVHQxLfMphyHUFoq7cZ
         nJyegjuGqNI00c6+qvrqwUrvlecOZUuo23CFmZymTuCSRwPxCQOxcjjG7Hw3yggUuIKD
         oFCDdeLufkiSg051y0wjL9onWhSQAelH3a0AGUHAbBFohXZX7OBKx8aSoy8TVASImREU
         zRig==
X-Forwarded-Encrypted: i=1; AJvYcCVUFGhyTI33E2/Ed82qvS6GUCexJ/8myD2uf0+l9pMQEvEJPkd948SysJpCrEdh4MQ5TyC3aurkQNIvFnmhNl58b/TFo3YUIEv54yn5+PUYbojs91K/HekKgZQ5wU4Bmk8ClxXVjTvw
X-Gm-Message-State: AOJu0Yyw7kOTJRtHCm4dpCc7+2Kpf40eP9S9nUZ0XOeOsKrBjd7LR0kW
	67OWY9vx9bMohz4bB3y9zXtuP0Y8tr9ylWy2pDvOOR/YM/a4ZFPUJ9+oVQ==
X-Google-Smtp-Source: AGHT+IFOZI5q6xCtCYfNHga3s7Hp5kGMUXV1xn1xC1b6C6pnnPy2Hr/jNBvnCEF0Vfu9C8weJF7UEw==
X-Received: by 2002:ac2:4889:0:b0:51b:6296:8d1a with SMTP id x9-20020ac24889000000b0051b62968d1amr1803161lfc.29.1713971238032;
        Wed, 24 Apr 2024 08:07:18 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b00515c8ff6f52sm2440664lft.229.2024.04.24.08.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:07:17 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 2/4] spi: dw: Add a number of native CS auto-detection
Date: Wed, 24 Apr 2024 18:06:43 +0300
Message-ID: <20240424150657.9678-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424150657.9678-1-fancer.lancer@gmail.com>
References: <20240424150657.9678-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aside with the FIFO depth and DFS field size it's possible to auto-detect
a number of native chip-select synthesized in the DW APB/AHB SSI IP-core.
It can be done just by writing ones to the SER register. The number of
writable flags in the register is limited by the SSI_NUM_SLAVES IP-core
synthesize parameter. All the upper flags are read-only and wired to zero.
Based on that let's add the number of native CS auto-detection procedure
so the low-level platform drivers wouldn't need to manually set it up
unless it's required to set a constraint due to platform-specific reasons
(for instance, due to a hardware bug).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/spi/spi-dw-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 722b5eb1f709..ddfdb903047a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -834,6 +834,20 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 			DW_SPI_GET_BYTE(dws->ver, 1));
 	}
 
+	/*
+	 * Try to detect the number of native chip-selects if the platform
+	 * driver didn't set it up. There can be up to 16 lines configured.
+	 */
+	if (!dws->num_cs) {
+		u32 ser;
+
+		dw_writel(dws, DW_SPI_SER, 0xffff);
+		ser = dw_readl(dws, DW_SPI_SER);
+		dw_writel(dws, DW_SPI_SER, 0);
+
+		dws->num_cs = hweight16(ser);
+	}
+
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
 	 * the depth could be from 2 to 256 from HW spec
-- 
2.43.0


