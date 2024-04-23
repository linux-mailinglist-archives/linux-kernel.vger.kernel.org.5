Return-Path: <linux-kernel+bounces-155632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D686E8AF507
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBCF28242D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196913F437;
	Tue, 23 Apr 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1+LVHHG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452013DDDF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891989; cv=none; b=a+jo3FPn0Ejp98sAwDRTJP2P0xI+0NjSUMMyxdzsnGedk0fIUaxeaLuOJUsL71OPvCuJ+Frh8ueZfFAh7rYnDIOQG0eWrcWxzFgMTu5084aeT7H1jJF6qjLZ6bdUrjFVLcR9GczqbwKPYwQHj8YPnXAUArGMzOvAQvl5g9EcnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891989; c=relaxed/simple;
	bh=lEQL4JvbQIS8+IoUWQG/7yIMLEyuerLO3fV1yFnwKN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9Pe/WX/kx8gok0HlLdHPp0XS2OZOBoFHCoa1rB2mHEwUhfzoKpDV0gLp/Xbh3tM6yH/5qIyuSn5DWgkELqBwqJbRd8vBfcadNgPSz7MT8Trh3NXrUebjynl/hXIVOCe3yeE49rTX0zJoqTfAqQXQCHRb4SHW9p0nZHt5w7Hhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1+LVHHG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5544fd07easo674563566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713891986; x=1714496786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTeJ++F/mnm19eqXVShab+zLQp1WnhObbyrG4T/vDvk=;
        b=J1+LVHHGU4fc/kJiwUkIocQCh3g6oYCGubGzapdWl277CvX3AHHCab0XHPO48nb0rV
         a/y85XwKDxsn0dJ3smjAtFj0KRCC0eGloLvJfI2OL0YduBLKDIOir0rNYmBsbEu5MsxH
         HClZQako+P0Dye1RWj0EfN0DgS9zw1LxE+J1jFt/FIGpZaZS8Lf9UfQfCDR4P8GhnsO3
         QNyt/xt5gsCsUAbO+M60veQCIR2tW5FE9ho/grpyY+EDeXES/sprO+RsBTpbsuXb9dqh
         GXev4y7W7s4LxEDCs/TyCLuuvymSAlRMaw+mI/OprgO7QLyR44SndGXsAX5z6Sh2DEdr
         Ls4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891986; x=1714496786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTeJ++F/mnm19eqXVShab+zLQp1WnhObbyrG4T/vDvk=;
        b=FGCC5PPrVsD3/3i9dfNP/Y6sJAyZJOCzUw5zsE8wb5ABR/m2Js3IIHwrWNkma0Hbl4
         hvvXs42imVx6kq9V1/hSXP1E4UGimf8UwafwdJtBu9Xlk+fOHGzvI4BSzsndIx9A8iIO
         yzcYlYGCeLxQTxCYKVOEPNrAZGh+hLy7+mo798hdpswmrsbkw71n2cHhaYiBo3PUlqTI
         5CcDSyxtLbxfLI8TMzGoCG+TFJFWS9lLEMj9eE9b4NmmfJNX1oT1BT2YQh+SKBjJwH+y
         QCC35azchAV0Mj+cIJ+f+HAyspEL29xjEOKe/fD9Be+ab04OuHUwiO9bk+1o/7Ou+1yH
         eHRw==
X-Forwarded-Encrypted: i=1; AJvYcCXDhznVwrstqrVhLQJbLbjMq5waeg37w5vF5ZGIYsuUIqgIxzXVv7sF4y1/8f7rsYWm4FVo6wMqXxf9wxFSKgeQV9V5mbFoWDln68fb
X-Gm-Message-State: AOJu0YyUW2GU8KfOkYbO7TipTB3bAiMUVoukc3necTnfByoOkepK2Cz3
	LdVQcb1X5/CtYUSHeDz6Q1uMLSPSkin7G9Q/XUs9ISoLZkweRwhKiew+Tik9joM=
X-Google-Smtp-Source: AGHT+IGmX8/L0/I9Xfi/12RjpvA/XDSBEjDv0Ba0q/FGDoMM5t1bQJxoQFANCyEahhfvXPMRwfCN7A==
X-Received: by 2002:a17:907:bb92:b0:a58:7505:1968 with SMTP id xo18-20020a170907bb9200b00a5875051968mr2076701ejc.43.1713891986224;
        Tue, 23 Apr 2024 10:06:26 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709063e5600b00a5209dc79c1sm7351624eji.146.2024.04.23.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:06:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 18:06:05 +0100
Subject: [PATCH 3/7] phy: exynos5-usbdrd: support isolating HS and SS ports
 independently
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-usb-phy-gs101-v1-3-ebdcb3ac174d@linaro.org>
References: <20240423-usb-phy-gs101-v1-0-ebdcb3ac174d@linaro.org>
In-Reply-To: <20240423-usb-phy-gs101-v1-0-ebdcb3ac174d@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

Some versions of this IP have been integrated using separate PMU power
control registers for the HS and SS parts. One example is the Google
Tensor gs101 SoC.

Such SoCs can now set pmu_offset_usbdrd0_phy_ss in their
exynos5_usbdrd_phy_drvdata for the SS phy to the appropriate value.

The existing 'usbdrdphy' alias can not be used in this case because
that is meant for determining the correct PMU offset if multiple
distinct PHYs exist in the system (as opposed to one PHY with multiple
isolators).

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index ac208b89f5a6..d69187c22613 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -196,6 +196,7 @@ struct exynos5_usbdrd_phy_drvdata {
 	const struct exynos5_usbdrd_phy_config *phy_cfg;
 	const struct phy_ops *phy_ops;
 	u32 pmu_offset_usbdrd0_phy;
+	u32 pmu_offset_usbdrd0_phy_ss;
 	u32 pmu_offset_usbdrd1_phy;
 	bool has_common_clk_gate;
 };
@@ -1050,16 +1051,6 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 	if (channel < 0)
 		dev_dbg(dev, "Not a multi-controller usbdrd phy\n");
 
-	switch (channel) {
-	case 1:
-		pmu_offset = phy_drd->drv_data->pmu_offset_usbdrd1_phy;
-		break;
-	case 0:
-	default:
-		pmu_offset = phy_drd->drv_data->pmu_offset_usbdrd0_phy;
-		break;
-	}
-
 	/* Get Vbus regulators */
 	phy_drd->vbus = devm_regulator_get(dev, "vbus");
 	if (IS_ERR(phy_drd->vbus)) {
@@ -1094,6 +1085,19 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 		phy_drd->phys[i].phy = phy;
 		phy_drd->phys[i].index = i;
 		phy_drd->phys[i].reg_pmu = reg_pmu;
+		switch (channel) {
+		case 1:
+			pmu_offset = phy_drd->drv_data->pmu_offset_usbdrd1_phy;
+			break;
+		case 0:
+		default:
+			pmu_offset = phy_drd->drv_data->pmu_offset_usbdrd0_phy;
+			if (i == EXYNOS5_DRDPHY_PIPE3
+			    && phy_drd->drv_data->pmu_offset_usbdrd0_phy_ss)
+				pmu_offset = phy_drd->drv_data
+						->pmu_offset_usbdrd0_phy_ss;
+			break;
+		}
 		phy_drd->phys[i].pmu_offset = pmu_offset;
 		phy_drd->phys[i].phy_cfg = &drv_data->phy_cfg[i];
 		phy_set_drvdata(phy, &phy_drd->phys[i]);

-- 
2.44.0.769.g3c40516874-goog


