Return-Path: <linux-kernel+bounces-165078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081698B877D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736EF1F216F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109453379;
	Wed,  1 May 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzSOTTFo"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55B502B2
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555181; cv=none; b=fN2zuyHfMv5Gf2Y4AmzaSPGs80L5/2KlWbI2UZPD8dx7GLssq1FYC/K+zyPfYRQH5yU7cucf504xeUq55uHAF1zVizvPGnbRW69Z/riTfDsPPchwAaZkW06VCTABRMykRYCB/1uwEwYV/A/7xPjawC7CrtcSh+4ow5V3+nyRmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555181; c=relaxed/simple;
	bh=ZyNnKgvZCiDg/WDXGvirLjjH/RMUJBnGJV7fcumvd3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s2scs3NIaW3rwqyeyTgRLtsn7F+csK/AJBl843bqqL7QJ26EewhkLXED63CtxTEM+2q6CWVpy8FtzEf7890P0xb2IHGoZeObNKw3t9Cdv9qaQQ/iIPR8To3B1Vdb0i5xrWQL/QBrV9CEaRz1gs4/dTIQEesnp5qPphGI+ndcVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uzSOTTFo; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so8309384e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714555178; x=1715159978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDKjYuMOOvQueQlZtzxRYnLgIlA8f7Ari39jSEC+hu0=;
        b=uzSOTTFoK92qHI92dtkOeF92jCEN56Wr5hUJRtqQ3dj3uJ16/8vWw1a7XbodQ7GVuN
         X/akwxanJiw3BXxTcNywCkq317Cv6J4HwYCVCFPyCGA+BCdyOguWhH6KXxCkyu+d5HCB
         RUoBo4+VJGImn4BpDSG6CNscGwWNgH69D+5MJ8esbO4E4phrJJ6clnP3AW1XlAn7sh81
         kiFVCEJRxh5eVgBxVgYqBW4uISpKyq7tfgjgvaq5kliTCF79Nu+PXlV7K2+YKeZb8kTl
         pYM2kfmP0vvfyJfGPGdBKsvHlXnHpKivCuedQqjzKT4dqbaVOWCGxnHBBsMPK+iT9RHJ
         JIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555178; x=1715159978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDKjYuMOOvQueQlZtzxRYnLgIlA8f7Ari39jSEC+hu0=;
        b=nlJZ4ixD9UCBTFpX0NabeEXi02BPMgibApSg/XKYtdnpTpsPKDWgMTNHswNqt6m7wg
         Lcn+ahVrL+Q/bM5uQ+EuuUko/R8KhbF+VbbsuaVKkjpaqM0Ar18YIeiJvRa7bRCK4map
         x9hVb4O2BnIB+7SU35fYVvwgnX0YjPVcrku3O9J1iTe//iNi/6HK2E16atKEjuLiOBzJ
         1P7wiHAljvWeqj4Coh2KPfhKMTlZ684oILAiHR4a5QZzGWZk3WMIpKO+NmkIGzbQ0SIe
         xwnaCHJY/Ss7hXsMDTknqoZ5dMG2xKzNJsasmjujXXCRBy3roPnRmdfi/FBJD0vuCCLo
         eOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW910vsA9yQnloVMqHOKFgYQMEqVzJC6HwR82YIUp3bYEcfw0IsLgM+Qeb2uMuc5ispnN8TulykDTu6hfDqCHwHe6Qyt1IjNjcbTGG9
X-Gm-Message-State: AOJu0YzUclUcsUq3C1MG/rN6AmwEgAd5rD+Xy2F7nGrJ4+3ZFcWMhs94
	H5VQT7XGSh/DILceTDKGcClSfJp7DhmrW7o5gT/snuFFQEAxjbQFH1DaHVgfJOo=
X-Google-Smtp-Source: AGHT+IG35wPVpTgwkzCXgj+m93i9OP3q32II4vi8eJQ5xijSDEEE5d2Q9QmPaTZNA6Hi++3pKyY3vg==
X-Received: by 2002:a19:ca53:0:b0:51b:396e:2880 with SMTP id h19-20020a19ca53000000b0051b396e2880mr1133041lfj.63.1714555178313;
        Wed, 01 May 2024 02:19:38 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id bw13-20020a170906c1cd00b00a58de09fd92sm5425674ejb.27.2024.05.01.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:19:37 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 01 May 2024 10:19:37 +0100
Subject: [PATCH v2 2/7] phy: exynos5-usbdrd: use
 exynos_get_pmu_regmap_by_phandle() for PMU regs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-usb-phy-gs101-v2-2-ed9f14a1bd6d@linaro.org>
References: <20240501-usb-phy-gs101-v2-0-ed9f14a1bd6d@linaro.org>
In-Reply-To: <20240501-usb-phy-gs101-v2-0-ed9f14a1bd6d@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, lee@kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
security hardening reasons so that they are only write accessible in
EL3 via an SMC call.

The Exynos PMU driver handles this transparently when using
exynos_get_pmu_regmap_by_phandle().

Switch to using that API to support such SoCs. As this driver now no
longer depends on mfd syscon remove that header and Kconfig dependency.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/Kconfig              | 1 -
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index f10afa3d7ff5..bb63fa710803 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -82,7 +82,6 @@ config PHY_EXYNOS5_USBDRD
 	depends on HAS_IOMEM
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
-	select MFD_SYSCON
 	default y
 	help
 	  Enable USB DRD PHY support for Exynos 5 SoC series.
diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 04171eed5b16..ac208b89f5a6 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -18,9 +18,9 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
-#include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 
 /* Exynos USB PHY registers */
@@ -1034,7 +1034,7 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	reg_pmu = syscon_regmap_lookup_by_phandle(dev->of_node,
+	reg_pmu = exynos_get_pmu_regmap_by_phandle(dev->of_node,
 						   "samsung,pmu-syscon");
 	if (IS_ERR(reg_pmu)) {
 		dev_err(dev, "Failed to lookup PMU regmap\n");

-- 
2.45.0.rc0.197.gbae5840b3b-goog


