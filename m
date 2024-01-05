Return-Path: <linux-kernel+bounces-17733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5AA8251B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165972841EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA42DF62;
	Fri,  5 Jan 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8M9F3p+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7D2D62D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so20310111fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 02:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704449790; x=1705054590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QKH2I8GrPdCeY4Xo3OxMu/ITqYHkEvyiTHRM/5TT/M=;
        b=R8M9F3p+X41r8mFI2DryiwAcxDe/a/uWXUISJcni4hVpCW1N+fSna0LT1uzI1eShCa
         KuVWiKJhlHbKbl5DYVvLSqHXj6hIjxbM6pst0TLBtt26ks72hFipgfCtrUXGcq4Smulz
         b1fr2TAckhWat7ZE/dnyXfcuPg8l7vE0TZvpJtVDRRkjGr+YnLGlsuqdqWwl7x0uYsBK
         S+03lQfR7vG4Hoen1u9SALznCagDYiYR8e72GT7uI+Hd6uESKiiltfWdb2dQm72bv4RA
         z8Ccnyq5jdQu20p5Y1ckzSjw8SSRO9q7WtKTXlu1jwjgiHL8zBkzt+fcX4MSn9Aa6h3E
         6YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704449790; x=1705054590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QKH2I8GrPdCeY4Xo3OxMu/ITqYHkEvyiTHRM/5TT/M=;
        b=c4UKtZMqzQzkEGGSnZLw7obgdeRPEMkJeDDpC2O0hOxoMt1+QJMjwfX5+ytLKKvkBO
         U01B++034Iv3NeBJ76cg9ePC0UPZBzgG4TTs3H/LwHGJ64LfmPMuRCMO6BMw4S0/EevQ
         dbTyMcIEMQn9M4QiP4ltoT2jKD8Vg+KIRMvkwnFYVJjUMY159h2Jtg0vgDLDqZ/jrsw0
         p+6G0pmqBJjA80G4I0qRxlqqql9ySIQhIUt/r3OUj4GGDzixxca8FZfZdinSdfXtkCbd
         wE+M6uiakoM2uWQPmHDA1qRgImLFtVdXsnblb3/vArIsSgShVUAgAjlEIXdatHVnF3kR
         6BjQ==
X-Gm-Message-State: AOJu0YydxvBqOXk0k15JsctQ00RG+827K1EJ3gl3Eu+1ISwbr1aJ1Q+8
	r8u/50FsbpbFdwTnjVBiOIu+D2qSY3TnuQ==
X-Google-Smtp-Source: AGHT+IH1RawZ6OGwh/tmYi2y5tlVMSy5TK/O7WKXvjLqh8pSSTkg0pe17sX5VEnwrzib+wteIRYU1Q==
X-Received: by 2002:a05:6512:398f:b0:50e:a8c7:b2df with SMTP id j15-20020a056512398f00b0050ea8c7b2dfmr1238858lfu.36.1704449790463;
        Fri, 05 Jan 2024 02:16:30 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906358900b00a2824bff5b1sm713180ejb.216.2024.01.05.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 02:16:30 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 05 Jan 2024 12:16:17 +0200
Subject: [PATCH v2 2/2] phy: qualcomm: eusb2-repeater: Rework init to drop
 redundant zero-out loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-phy-qcom-eusb2-repeater-fixes-v2-2-775d98e7df05@linaro.org>
References: <20240105-phy-qcom-eusb2-repeater-fixes-v2-0-775d98e7df05@linaro.org>
In-Reply-To: <20240105-phy-qcom-eusb2-repeater-fixes-v2-0-775d98e7df05@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Elliot Berman <quic_eberman@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4690; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=qz6RxnBEtexpOzrPteLkLotdoWP7JKERv8XNG5Nn5QM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBll9b6oEoplC1rUxzC5CX0PPap9ab4rMbCpOvnF
 gB3skAbdMWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZZfW+gAKCRAbX0TJAJUV
 VkmMEAC24tkNwCFDgvtyg4UdCNkqDoMI7rhoRoHjl8iutENftVniejltVji8R6WcslGJhr3uzyx
 sO1FM+8DgxKVuiIM7PLO97LbHwqDk1J1q3qN/7ViKmIYKJsU1KuXSOmh894Z5JmYfNi1hnBlqBQ
 /j9EddFvW/SbATHdL/7T/xHrnqj4AYAywauwTKhcDZEz9lbuvjxqq/v+Rbx+0gBb/rDgwJ9zgsO
 NblEYyt1QRAp+dC4wyuBjAa1JlO1MluMSlNrq86xOWz/sg8owH+h15Tude7ZZPHyW9sMP7u0YsF
 ee+9JAc4whznsIvVjLC5OyZcgG2SMJz0HlsR1isCNkoCbIqq2WtQH2OqNCxL4elNChKSveeEiJT
 sBWYvfpv7AO/Mm9k/oz2i74sOwmtDyZMwho1YoDaM1WkvY5lX2T65AVYugRnaT7gaei2j3WSb+b
 OYpDm7AGhVBhytb31Qv7MdYxiznkv/q+MtkFWvGZ+GTC/+W6GjuhY+s5RYo9sWnHktoQicrfmbN
 h+u8ntPOjhA8P0suRSayTxEVEpV87R6+2uSFiA++IbnBjiI/ixsqOnUL4/I0AQ922CoJcfrGUU5
 i6BB4xmoa0m0d5whGV2svtrt6zxndROwCWFzI8KikcS9VCuvlbJUL9ugMpDtugwaukV4dKMFYHG
 Bvdgr57kzmJHYUg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The device match config init table already has zero values, so rework
the container struct to hold a copy of the init table that can be
override be the DT specified values. By doing this, only the number of
vregs remain in the device match config that will be later needed, so
instead of holding the cfg after probe, store the number of vregs in the
container struct.

Fixes: 99a517a582fc ("phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 42 ++++++++++++--------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 5f5862a68b73..d28106e71ce3 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -102,7 +102,8 @@ struct eusb2_repeater {
 	struct phy *phy;
 	struct regulator_bulk_data *vregs;
 	struct reg_field *regfields;
-	const struct eusb2_repeater_cfg *cfg;
+	u32 *init_tbl;
+	int num_vregs;
 	enum phy_mode mode;
 };
 
@@ -123,9 +124,10 @@ static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
 	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
 };
 
-static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
+static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr,
+				     const struct eusb2_repeater_cfg *cfg)
 {
-	int num = rptr->cfg->num_vregs;
+	int num = cfg->num_vregs;
 	struct device *dev = rptr->dev;
 	int i;
 
@@ -134,7 +136,7 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
 		return -ENOMEM;
 
 	for (i = 0; i < num; i++)
-		rptr->vregs[i].supply = rptr->cfg->vreg_list[i];
+		rptr->vregs[i].supply = cfg->vreg_list[i];
 
 	return devm_regulator_bulk_get(dev, num, rptr->vregs);
 }
@@ -142,32 +144,19 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
 static int eusb2_repeater_init(struct phy *phy)
 {
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
-	struct reg_field *regfields = rptr->regfields;
 	struct device_node *np = rptr->dev->of_node;
-	u32 init_tbl[F_NUM_TUNE_FIELDS] = { 0 };
+	u32 *init_tbl = rptr->init_tbl;
 	u8 override;
 	u32 val;
 	int ret;
 	int i;
 
-	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
+	ret = regulator_bulk_enable(rptr->num_vregs, rptr->vregs);
 	if (ret)
 		return ret;
 
 	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
 
-	for (i = 0; i < F_NUM_TUNE_FIELDS; i++) {
-		if (init_tbl[i]) {
-			regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
-		} else {
-			/* Write 0 if there's no value set */
-			u32 mask = GENMASK(regfields[i].msb, regfields[i].lsb);
-
-			regmap_field_update_bits(rptr->regs[i], mask, 0);
-		}
-	}
-	memcpy(init_tbl, rptr->cfg->init_tbl, sizeof(init_tbl));
-
 	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &override))
 		init_tbl[F_TUNE_IUSB2] = override;
 
@@ -228,7 +217,7 @@ static int eusb2_repeater_exit(struct phy *phy)
 {
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 
-	return regulator_bulk_disable(rptr->cfg->num_vregs, rptr->vregs);
+	return regulator_bulk_disable(rptr->num_vregs, rptr->vregs);
 }
 
 static const struct phy_ops eusb2_repeater_ops = {
@@ -240,6 +229,7 @@ static const struct phy_ops eusb2_repeater_ops = {
 
 static int eusb2_repeater_probe(struct platform_device *pdev)
 {
+	const struct eusb2_repeater_cfg *cfg;
 	struct eusb2_repeater *rptr;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
@@ -255,8 +245,8 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	rptr->dev = dev;
 	dev_set_drvdata(dev, rptr);
 
-	rptr->cfg = of_device_get_match_data(dev);
-	if (!rptr->cfg)
+	cfg = of_device_get_match_data(dev);
+	if (!cfg)
 		return -EINVAL;
 
 	regmap = dev_get_regmap(dev->parent, NULL);
@@ -269,6 +259,12 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	if (!rptr->regfields)
 		return -ENOMEM;
 
+	rptr->init_tbl = devm_kmemdup(dev, cfg->init_tbl,
+				       sizeof(cfg->init_tbl),
+				       GFP_KERNEL);
+	if (!rptr->init_tbl)
+		return -ENOMEM;
+
 	ret = of_property_read_u32(np, "reg", &res);
 	if (ret < 0)
 		return ret;
@@ -282,7 +278,7 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = eusb2_repeater_init_vregs(rptr);
+	ret = eusb2_repeater_init_vregs(rptr, cfg);
 	if (ret < 0) {
 		dev_err(dev, "unable to get supplies\n");
 		return ret;

-- 
2.34.1


