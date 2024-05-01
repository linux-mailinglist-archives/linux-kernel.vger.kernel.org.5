Return-Path: <linux-kernel+bounces-165082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE98B8787
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E41C21F04
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54AC58235;
	Wed,  1 May 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxulVpEV"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAEA51C2A
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555183; cv=none; b=B7beL1BU1XG+77ITt16WFBvojGUE6bPoYemcHDUMYBbaPb1Cx3Vpl2v52Ry3mKbTEmrjy4IEJtFjbs851RC4iAn1GZutniNr45w1dvhgH+sXC50QJ9qvKD7SI1a/SCDoZYuO5gqdohyKUjyrf4ipAajASdcZbk+WJKwzpNEa7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555183; c=relaxed/simple;
	bh=fnl0PRNOnTN5F2TPa7B0Obhuw7G9puincq7QmLU2688=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkdPvhZP9Prm/necbMR9uQy7UZx3jwhNXlshleVHru9fZJKwTWeMhSIfVH0b9hjQwi5MjSmZAduu7yA93pEC6BQ6sseE+3mvzQlAPPy/60/AcZFYcCi+Qe3AhPMHbAmeaTE56YqQzdbwQBlLVSkrFhqOnmf2kc7II7emD8NUaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxulVpEV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200202c1bso859727366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714555180; x=1715159980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpsAkp1XfiYO3VUkSw1HuWtX6ajnqroh4NpfGPkLszE=;
        b=xxulVpEVg397oQccBfHMAgwZVzpXf6TZgI67RaXXRGE9EoAKYAvutYes/N2JSsMsNy
         WMFLdXoYJrhEtdylueAfGsimvubAItQPf6jwfdL/mq1+h3OLq2svbbTF91pe+uUxn2sN
         hcyK27vSD6+jrtP+IcbPWencnfLT+ZC/lg0nLJE9cfcu0yZ4Y/cox5r0E/Bw5CiIhL8j
         GLF8fTfkYmnDpdXF3AmQig2Y31w+4o64Hifs967pFUof519yNOd5lbp2IkPIoyKm1L9w
         63LC8ymaYLqPDAtEsnViFbpcBcIUqLsJ8z3CAKFPsQSQc3GElqI6BgtLhGMzZNDNitTC
         XS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555180; x=1715159980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpsAkp1XfiYO3VUkSw1HuWtX6ajnqroh4NpfGPkLszE=;
        b=h4csY4z0yFhKWHB2E0jw6xYVol3X3MMr1K5VmQ1/djKuzPpFnhWqObBPV7iSxVkPRH
         ATKL6jtIDmO0mk6GxR4GdhKBI/AGFTQMyQxmePSRITjt44+ZRIhfVAGCR7/ilV6/JhLK
         Qymgl7lVaZLmA4MTKC5GWB5KBsNlmmMXkne9Duz5T2uuw5Yl1/peLYQSYfDFk3jj8QR/
         B+S0z+8pwLv1Vedg2gT+JdX91TTHyy3A2kWcXC7EyaitzT3cM8Hgq4u5ov9RxOl2+0wT
         y27UbdIJxlEa2KFdy7+zMlCgFAd28PKryX+pAD3x0+kg+TkUp97KwyUUvrqSW1ouGmdJ
         HuUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLIJ2/XCOgETp/tAzdi4muDa9azVlOBoqE7KMwI2w4oIIcvbMEJ2ak9KAk4sM50n3N7W9reA1NFy6WYldYdRtjuiihjuQ2Tl14pIbG
X-Gm-Message-State: AOJu0YxTazpNDZpIBk1gkhIV5/lexFOmW/2sqPA2fKqE52pifbOUNWoW
	MtMk/zwAw8XKLM6HlokYP0e5PxYiHhIJ6C6QNtXry65z4Hf/dShgYjpsAsNJQuk=
X-Google-Smtp-Source: AGHT+IEkQUXDOOtvuZVGg3nz6KbIVcLBaS3f++uJVokxkU0jYEyvOsaDOInv1XRYLWI7ytlxWsL6ow==
X-Received: by 2002:a17:906:1b4b:b0:a58:c09d:1484 with SMTP id p11-20020a1709061b4b00b00a58c09d1484mr1850250ejg.7.1714555180304;
        Wed, 01 May 2024 02:19:40 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id bw13-20020a170906c1cd00b00a58de09fd92sm5425674ejb.27.2024.05.01.02.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:19:39 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 01 May 2024 10:19:41 +0100
Subject: [PATCH v2 6/7] phy: exynos5-usbdrd: convert to clk_bulk for phy
 (register) access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-usb-phy-gs101-v2-6-ed9f14a1bd6d@linaro.org>
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

In preparation for support for additional platforms, convert the phy
register access clock to using the clk_bulk interfaces.

Newer SoCs like Google Tensor gs101 require more clocks for register
access, and converting to clk_bulk simplifies addition of those extra
clocks.

Given the list of phy register clocks is requested as optional, I
haven't made it platform specific, as only those clocks that are
actually declared (in the DT) will be retrieved and the code behaves as
before this change. Nevertheless, this piece of the code is easy to
change in the future if the need arises.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 45 +++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 200285fa823b..c5a0c4882a86 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -195,7 +195,8 @@ struct exynos5_usbdrd_phy_drvdata {
  * struct exynos5_usbdrd_phy - driver data for USB 3.0 PHY
  * @dev: pointer to device instance of this platform device
  * @reg_phy: usb phy controller register memory base
- * @clk: phy clock for register access
+ * @phy_clks: phy clocks for register access
+ * @n_phy_clks: number of phy clocks for register access
  * @pipeclk: clock for pipe3 phy
  * @utmiclk: clock for utmi+ phy
  * @itpclk: clock for ITP generation
@@ -212,7 +213,8 @@ struct exynos5_usbdrd_phy_drvdata {
 struct exynos5_usbdrd_phy {
 	struct device *dev;
 	void __iomem *reg_phy;
-	struct clk *clk;
+	struct clk_bulk_data  *phy_clks;
+	size_t n_phy_clks;
 	struct clk *pipeclk;
 	struct clk *utmiclk;
 	struct clk *itpclk;
@@ -408,7 +410,7 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
-	ret = clk_prepare_enable(phy_drd->clk);
+	ret = clk_bulk_prepare_enable(phy_drd->n_phy_clks, phy_drd->phy_clks);
 	if (ret)
 		return ret;
 
@@ -458,7 +460,7 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
 	reg &= ~PHYCLKRST_PORTRESET;
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYCLKRST);
 
-	clk_disable_unprepare(phy_drd->clk);
+	clk_bulk_disable_unprepare(phy_drd->n_phy_clks, phy_drd->phy_clks);
 
 	return 0;
 }
@@ -470,7 +472,7 @@ static int exynos5_usbdrd_phy_exit(struct phy *phy)
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
-	ret = clk_prepare_enable(phy_drd->clk);
+	ret = clk_bulk_prepare_enable(phy_drd->n_phy_clks, phy_drd->phy_clks);
 	if (ret)
 		return ret;
 
@@ -492,7 +494,7 @@ static int exynos5_usbdrd_phy_exit(struct phy *phy)
 		PHYTEST_POWERDOWN_HSP;
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYTEST);
 
-	clk_disable_unprepare(phy_drd->clk);
+	clk_bulk_disable_unprepare(phy_drd->n_phy_clks, phy_drd->phy_clks);
 
 	return 0;
 }
@@ -827,14 +829,14 @@ static int exynos850_usbdrd_phy_init(struct phy *phy)
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 	int ret;
 
-	ret = clk_prepare_enable(phy_drd->clk);
+	ret = clk_bulk_prepare_enable(phy_drd->n_phy_clks, phy_drd->phy_clks);
 	if (ret)
 		return ret;
 
 	/* UTMI or PIPE3 specific init */
 	inst->phy_cfg->phy_init(phy_drd);
 
-	clk_disable_unprepare(phy_drd->clk);
+	clk_bulk_disable_unprepare(phy_drd->n_phy_clks, phy_drd->phy_clks);
 
 	return 0;
 }
@@ -847,7 +849,7 @@ static int exynos850_usbdrd_phy_exit(struct phy *phy)
 	u32 reg;
 	int ret;
 
-	ret = clk_prepare_enable(phy_drd->clk);
+	ret = clk_bulk_prepare_enable(phy_drd->n_phy_clks, phy_drd->phy_clks);
 	if (ret)
 		return ret;
 
@@ -870,7 +872,7 @@ static int exynos850_usbdrd_phy_exit(struct phy *phy)
 	reg &= ~CLKRST_LINK_SW_RST;
 	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
 
-	clk_disable_unprepare(phy_drd->clk);
+	clk_bulk_disable_unprepare(phy_drd->n_phy_clks, phy_drd->phy_clks);
 
 	return 0;
 }
@@ -883,16 +885,29 @@ static const struct phy_ops exynos850_usbdrd_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const char * const phy_clk_list[] = {
+	"phy",
+};
+
 static int exynos5_usbdrd_phy_clk_handle(struct exynos5_usbdrd_phy *phy_drd)
 {
 	unsigned long ref_rate;
 	int ret;
 
-	phy_drd->clk = devm_clk_get(phy_drd->dev, "phy");
-	if (IS_ERR(phy_drd->clk)) {
-		dev_err(phy_drd->dev, "Failed to get phy clock\n");
-		return PTR_ERR(phy_drd->clk);
-	}
+	phy_drd->n_phy_clks = ARRAY_SIZE(phy_clk_list);
+	phy_drd->phy_clks = devm_kcalloc(phy_drd->dev, phy_drd->n_phy_clks,
+					 sizeof(*phy_drd->phy_clks),
+					 GFP_KERNEL);
+	if (!phy_drd->phy_clks)
+		return -ENOMEM;
+
+	for (int i = 0; i < phy_drd->n_phy_clks; ++i)
+		phy_drd->phy_clks[i].id = phy_clk_list[i];
+
+	ret = devm_clk_bulk_get_optional(phy_drd->dev, phy_drd->n_phy_clks,
+					 phy_drd->phy_clks);
+	if (ret < 0)
+		return ret;
 
 	phy_drd->ref_clk = devm_clk_get(phy_drd->dev, "ref");
 	if (IS_ERR(phy_drd->ref_clk)) {

-- 
2.45.0.rc0.197.gbae5840b3b-goog


