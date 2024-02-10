Return-Path: <linux-kernel+bounces-60487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0629985058F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC051F253C4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198995D497;
	Sat, 10 Feb 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+ao3uEv"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F664F8B5
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585018; cv=none; b=HnS7JL5fxn0fQLJKrZmaV9iTDFRXratJBHtqdLrzTuhxsqcVm5upg3ujQ+xuLGWEL+QDtX4Qje5ZktjXsUAMGYVaYe7SmTeNaU7aQVm/rcrV9pt4HfAmewzVWcTrJSs7lTtbbwKOluNVGLS5yltzepnUUcTqtRu8lRBB1ksFuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585018; c=relaxed/simple;
	bh=Q/tkGNJIBJXpyEDTXFQsgKm/Jzq5e6UGCxuEuvZ0MQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGdYLFtBv8l+rwMVTUV49KJqPTsRzjQ8ZPoV5IohFsl8K45vCmBsWct9tXf6A0kSMdMIbG2eDirbRVCPvQK1qdl95JpVx0dF1WnAXR99N2SrSKrieJf6XC1ic0oXtoALWZcxjFBxbQlyugWdsVfzaXJA1oYabER1yVk3/XUuHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+ao3uEv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5610b9855a8so4923651a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 09:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585013; x=1708189813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4uw6U5ne+R+sJJghVlkDrwwqaS/V9vKBh8/gfD/1Fw=;
        b=G+ao3uEv5toX1HfCVp8O/c/67NMiiSd0y/3OVBnQ4IyTl/pexzRNHKdrlWRAP6zVk6
         mZ/MxPYKdb45AC6ZIbspp5cQoDrdZfB0IILIuUNNPdILBlCnX+dN3dVWTSVIidDuvhu/
         m+rladvPcEfjndTvTT/UpFLhAKJf1TVDITRcrusu+u7CetBT8fruy7XUOpUjecBaOo45
         kWIj5pIEHY7yxlHZ4shHFIv/VmyRNYByzyNVfGO+yEh21xohlDVd2ydAVJqZNl5n2DZ/
         VmgI3IUXcc8gmyNLJbhmZEbbDH9L8IlSk42ZgpW3E51628EX8QHjG8SZxbogEZhziTVB
         9svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585013; x=1708189813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4uw6U5ne+R+sJJghVlkDrwwqaS/V9vKBh8/gfD/1Fw=;
        b=MF4iGjlCEwMLn7+L5SCIU6XrSdyLOZu3dJLLSA9p8UY6qq4bf9uwoUkZOeNRHKloZ5
         I7bCS4qXDp4CWMwr5yJDF712DmiG2R3jtQ4QpUFsOqnMGlY+/juDO5YTFOIwIhj3bvmi
         szmIGWeIfE1GNVfsglsgADIIsBlohApT+qqWVIj2raSI1aJHZKfTjH5vYWQFKpFLm0em
         /xCXpAyGaH44VjnVbQNrpStPHJQVr2vaQElwBwThGm9wI/LNVJnRPdFKzybAbYjyILQy
         DMM4H6Va42g21Nv/j+6fqWqOuDZSiqCO5DK7Nwl6sp6N5BMeBcoF7+kmTDm5iEnx+FCz
         AXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+FNqzEFy5aRYzQAWNuk8f9dkzvA3k+UACYvxN0lZnLsfTImDmZtB6+lS4m1pJm62usGxQU+jMvwz1VCn9n8O8lHCREl4RrfMIuFEN
X-Gm-Message-State: AOJu0YyRgg42frZmsm1KwqtQ/BzVY8PkBfrHys9Pen9V09//cjj2o4S3
	RFgzs3oT2Y1Z9UJKfFyPKrE+VtZp6vU5usJ2RDfzj5eSmbjFmyAs/DO6ufzvc5Y=
X-Google-Smtp-Source: AGHT+IEWBD/YrIDuofpyLF0Bn38wTBLG3x7OxG2MKQ+2xkzcE18D1qoRpWnshledBQN9Fxw/QD5YSQ==
X-Received: by 2002:a17:906:6a11:b0:a3c:458d:a1a8 with SMTP id qw17-20020a1709066a1100b00a3c458da1a8mr1320996ejc.12.1707585013633;
        Sat, 10 Feb 2024 09:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkSLJ1a5g8IPS4jmUAHg+1UemkoLGyCjbQ3H0wNJUaUK6ogLUfJh51CmnFxnjeTPRDqB6bLet39f6SWeZYztiCH/ZE/OTY36NI/3tliQmiKYSLnO3aJgyu3kxnZwYJR/SiMp83N/eNdivQvC+HART/Ul9ugkyi5GHa6IT/woPQW/t2aPSFVZAO3NuZhWsfiN0AnatAWNiZkcCCUMQIYMUH2O+arWfIYG5nTKTQhgdncWnSCtlE30pph23wyeyUe1IzSVs7OT2DeW+5Lpr3pBHgbKtQMKiCG2ACpcyznMs6qt/E8isx+6EnkRIcXTaXRDA9Sk7//FGqW5o8bjBhLRMl5yQIWEwBTrz4t06hX0XQXbFPZ6kmJUpWnNisWxul3Q==
Received: from [127.0.1.1] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3c1e1ca800sm973242ejc.11.2024.02.10.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:10:13 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 10 Feb 2024 18:10:05 +0100
Subject: [PATCH v2 1/3] PCI: qcom: reshuffle reset logic in 2_7_0 .init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-8280_pcie-v2-1-1cef4b606883@linaro.org>
References: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
In-Reply-To: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

At least on SC8280XP, if the PCIe reset is asserted, the corresponding
AUX_CLK will be stuck at 'off'. This has not been an issue so far,
since the reset is both left de-asserted by the previous boot stages
and the driver only toggles it briefly in .init.

As part of the upcoming suspend prodecure however, the reset will be
held asserted.

Assert the reset (which may end up being a NOP in some cases) and
de-assert it back *before* turning on the clocks in preparation for
introducing RC powerdown and reinitialization.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ce2a3bd932b..cbde9effa352 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -900,27 +900,27 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
-	if (ret < 0)
-		goto err_disable_regulators;
-
+	/* Assert the reset to hold the RC in a known state */
 	ret = reset_control_assert(res->rst);
 	if (ret) {
 		dev_err(dev, "reset assert failed (%d)\n", ret);
-		goto err_disable_clocks;
+		goto err_disable_regulators;
 	}
-
 	usleep_range(1000, 1500);
 
+	/* GCC_PCIE_n_AUX_CLK won't come up if the reset is asserted */
 	ret = reset_control_deassert(res->rst);
 	if (ret) {
 		dev_err(dev, "reset deassert failed (%d)\n", ret);
-		goto err_disable_clocks;
+		goto err_disable_regulators;
 	}
-
 	/* Wait for reset to complete, required on SM8450 */
 	usleep_range(1000, 1500);
 
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+	if (ret < 0)
+		goto err_disable_regulators;
+
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 
@@ -951,8 +951,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
-err_disable_clocks:
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 

-- 
2.40.1


