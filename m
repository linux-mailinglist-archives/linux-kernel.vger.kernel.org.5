Return-Path: <linux-kernel+bounces-71701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9385A93F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCF81F24F89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93625446A2;
	Mon, 19 Feb 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9IGnDcT"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF475405DE;
	Mon, 19 Feb 2024 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361175; cv=none; b=IZ42uj3/S33BEnyIAB55JTvSoEpwFtsdaNvM7j5WFIxoD0YYapaZN+v6DS00itgXwXVVoMEEK6x7GcX1SmpYDZLy6vBQAIVgQhcJ2H7huFvxR2SYfdlH20RbyCRoWjo+qoFakLOA1A8+EcVIbBCOgFxL4b8/UHaZdWlfGpeI6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361175; c=relaxed/simple;
	bh=2dNkZy9Qowr+lnIaUQIrE1w0rz67bEVHP8S1+WQjZ9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgOzagJPMea7thHOAg6EgVJCuDSCyCJT5Qm3UkP/Vf2uzO7u/ooIceeXM7FhwIib2AaXFyK0Dexx6fL3Zqf53k4pUKIuNFuy/7PPANIbCUz/Jz11G0EuziRvJRNd/95fc2JC9Xb8t+UeLbZk/bvqE/GDOkLX3g3ht9EfFWkCW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9IGnDcT; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512a96e44e2so2313081e87.2;
        Mon, 19 Feb 2024 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708361171; x=1708965971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtDtxHtlcu9ASavvT/LxF1yz07grVTxYpKmjdaNvLlA=;
        b=f9IGnDcT4jVRegXqPvunlV0mgKFK0jCu75DzI6pqNr9XoYH1YyCt2ozb7LqoKP9/LH
         tuqoIqDNHxLCvhT0MeeTFPuJNrbxqx7X8JNwcQwcZsJl51oxmLV6HeuojH+5um/CWtQ9
         fWuuVsJ3FhnjS6aWrRdniaBvdHEtcIF9DuHIPzoiVj+pd1jTbL1qBIx9H3dFIbwlwgRR
         BcdWhy4LB1WuD+yewii4AaDI14e0NKFYYU1TF5HzhCL/aHjYjgzNFAF2Z1W7Gy81uEXC
         oiFCAU3nECQIj/5dmz4q24zeD6Dv913nYMR5gKfDjFufAFqAqlylh+T287cOZt5QKGBf
         MT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708361171; x=1708965971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtDtxHtlcu9ASavvT/LxF1yz07grVTxYpKmjdaNvLlA=;
        b=tHqgPjTj/zA36sZunTXv5eymgBbvwJcfHeOFRIcODAPBf7se57TPfJiB4Mpp2Nff0m
         +uopu4kvmqRx5/AZSRSKXsUBvUzSHsmOb7Rbm3jsuydYax196eiQz4m9vrl99wHYwkci
         Iq1EH1A4W8QAmUuY/gzltUDKjJselMrWOT9xzP90qXceGq432kxmS5fxs8ieBdhuH+t2
         YIGn/DUtDOsFTjSbgtuRum1Wb691FDMIPav4BGcCVyIP2fy79RF06RoLwSv6DhSQHbCW
         4bNfEOJWP9E9LQG+F9VxP9Z8eBFmge5TBHe+JSNAN5qRpQc6ihUWae69fA3j7HXw7bWS
         FW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhdxkRiBPLzqgyBPrWwIVxKPxoqWE4J1m85zUwG9HoKGBbcX1Pi2VHw4Qq5xfxAWrfqeiaVTXon0RQ30m+IV/MIIdS9mJk5O1HAFDIj50+Y0F+bvRncl7Qk5GxetFUnwiLe2WsFscglLS/psVVo1y0TDHn3CmiLibgxo59xsIZ+4E=
X-Gm-Message-State: AOJu0YxBKiaxHDGD+hgyRqvhHMKe2lJYkhSFMH9jP6x1QjbcIg5QNDCJ
	LEYaqQmKZC0eagzkpO99JkF+szAwoX5zd+eVBuFRg+a7TTKN0c6l
X-Google-Smtp-Source: AGHT+IEKhu3/RJx/D2ZdIXAGGxEZhDJ+CzcXwqo7Dd3MS4t2r7Ee/yMmfsTMn/53gYqw6nZ4agFzCw==
X-Received: by 2002:a19:5e12:0:b0:512:b115:a62f with SMTP id s18-20020a195e12000000b00512b115a62fmr2303991lfb.59.1708361170598;
        Mon, 19 Feb 2024 08:46:10 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fj6-20020a1709069c8600b00a3cfe376116sm3125777ejc.57.2024.02.19.08.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:46:10 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 19 Feb 2024 17:46:04 +0100
Subject: [PATCH net-next v3 1/3] net: stmmac: Pass resources to DT parsing
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-stmmac-axi-config-v3-1-fca7f046e6ee@nvidia.com>
References: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
In-Reply-To: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semit <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18284; i=treding@nvidia.com;
 h=from:subject:message-id; bh=tPuSb3hQEc/qFI5pO8U8rTYdq/fzctAjnfT+D0rXkZg=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBl04XQ6770lXFRm8Hm035I191EStZqe1GOks4fl
 ToD9a4HluaJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZdOF0AAKCRDdI6zXfz6z
 oatRD/9yHWXEbNduxQNzMTvSpL7DZXy2AdlnOyUiD1HHrzb6ycYv5La40QildzqoAVHTy4RxfQE
 eMa82BUWnAeVh8dfGS9V3NNDnCD/w6f6d3SSXYnWbVp+qXihyKVayNsMvoZV02ZgSv/SLUmBQZT
 SfO8tEiJQ2+GZC0oFRBbZpHcSCoIsLtmbXC13jmfS63zFxWJi8WKI4+1iuG+EsOQna5jgCS9VBv
 gj9lyAXZRlCe72/eFIAayKcfYvBM9I9KMm8/Cv4ceZqNMUitY+gk7cgjbnSTr432EkLwos71n6/
 hErE9tnCwLo2LdVqdVXVfDSlrWhaItPaGUZyuCOBl33bC54wGoDFD03K/ZHbQiKNDrf34qjhGlt
 WuR2tLiCrbjtErMLIDPnsoG9VADzj/ViAdAmJheF6ZzjZ3z4xsgDupEodvDAX89UbAFO9o4yPTe
 INjOzSE3ps6sNRHxwUt+05bOY39p6ytdaemcLBrKmLkQ8bugksHKUmVo7tIMNNEE5kITSC+Jqye
 NckI7VjTWc6qsOw4WP6tTVqRiX1HMpKaX2+ffxb9ABwLogRAcqnJj3q1wUvGdQSFaa8HV7tRWG7
 Vr/RKfzkmsckqkxwJ1cl7Npqy8ahTYLdyhX28zUxikoeF3Xef84t3lD5wqCD9U/dg/0d2pbT8VZ
 U3JO6LAJXSnaU5A==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

We already pass the stmmac_resources structure to other initialization
functions since it allows us to exchange more data between the driver
and those functions. Passing this structure to the DT parsing code makes
it easier to extend what we pass around in the future.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix bisectability
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c       |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c        |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c       |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 19 +++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h |  3 ++-
 24 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 643ee6d8d4dd..f37d9912380b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -115,7 +115,7 @@ static int anarion_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(gmac))
 		return PTR_ERR(gmac);
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index ec924c6c76c6..36ef2ed9fd2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -435,7 +435,7 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(stmmac_res.addr))
 		return PTR_ERR(stmmac_res.addr);
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index 598eff926815..98a00084807b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -27,7 +27,7 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 		return ret;
 
 	if (pdev->dev.of_node) {
-		plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+		plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 		if (IS_ERR(plat_dat)) {
 			dev_err(&pdev->dev, "dt configuration failed\n");
 			return PTR_ERR(plat_dat);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 6b65420e11b5..d72b9d8ac464 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -331,7 +331,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (!dwmac)
 		return -ENOMEM;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 19c93b998fb3..de2f5d7e95b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -241,7 +241,7 @@ static int ingenic_mac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d68f0c4e7835..79582983c060 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -84,7 +84,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat)) {
 		dev_err(&pdev->dev, "dt configuration failed\n");
 		return PTR_ERR(plat_dat);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 281687d7083b..311410509012 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -384,7 +384,7 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	if (val)
 		return val;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
index 3e86810717d3..1ede4f409937 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
@@ -169,7 +169,7 @@ static int ls1x_dwmac_probe(struct platform_device *pdev)
 	if (!dwmac)
 		return -ENOMEM;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
 				     "dt configuration failed\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 4c810d8f5bea..004bf4d14fdb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -37,7 +37,7 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 2a9132d6d743..763ec218ff2c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -656,7 +656,7 @@ static int mediatek_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index a16bfa9089ea..5bd936ef2796 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -52,7 +52,7 @@ static int meson6_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index b23944aa344e..88db2907640d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -400,7 +400,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2691a250a5a7..7f4cbea4042f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -735,7 +735,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get platform resources\n");
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat)) {
 		return dev_err_probe(dev, PTR_ERR(plat_dat),
 				     "dt configuration failed\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 382e8de1255d..4297a6919c8a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1824,7 +1824,7 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 68f85e4605cb..e827e01b4398 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -400,7 +400,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 4e1076faee0c..a0f15fbb8993 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -122,7 +122,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to get resources\n");
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
 				     "dt configuration failed\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index 4445cddc4cbe..5b2cde45dc3e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -273,7 +273,7 @@ static int sti_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index c92dfc4ecf57..af131b0bf589 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -366,7 +366,7 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index b21d99faa2d0..8f47f2e904d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1223,7 +1223,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return -EINVAL;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 2653a9f0958c..f78e244b9d81 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -108,7 +108,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 362f85136c3e..bab57d1675df 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -284,7 +284,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto disable_clks;
 
-	plat = devm_stmmac_probe_config_dt(pdev, res.mac);
+	plat = devm_stmmac_probe_config_dt(pdev, &res);
 	if (IS_ERR(plat)) {
 		err = PTR_ERR(plat);
 		goto disable_clks;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index a5a5cfa989c6..f99d147b3424 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -220,7 +220,7 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 54797edc9b38..4e2eb54306f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -424,13 +424,14 @@ static void stmmac_remove_config_dt(struct platform_device *pdev,
 /**
  * stmmac_probe_config_dt - parse device-tree driver parameters
  * @pdev: platform_device structure
- * @mac: MAC address to use
+ * @res: driver-specific parameters
  * Description:
  * this function is to read the driver parameters from device-tree and
  * set some private fields that will be used by the main at runtime.
  */
 static struct plat_stmmacenet_data *
-stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+stmmac_probe_config_dt(struct platform_device *pdev,
+		       struct stmmac_resources *res)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct plat_stmmacenet_data *plat;
@@ -443,12 +444,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (!plat)
 		return ERR_PTR(-ENOMEM);
 
-	rc = of_get_mac_address(np, mac);
+	rc = of_get_mac_address(np, res->mac);
 	if (rc) {
 		if (rc == -EPROBE_DEFER)
 			return ERR_PTR(rc);
 
-		eth_zero_addr(mac);
+		eth_zero_addr(res->mac);
 	}
 
 	phy_mode = device_get_phy_mode(&pdev->dev);
@@ -677,17 +678,18 @@ static void devm_stmmac_remove_config_dt(void *data)
 /**
  * devm_stmmac_probe_config_dt
  * @pdev: platform_device structure
- * @mac: MAC address to use
+ * @res: driver-specific parameters
  * Description: Devres variant of stmmac_probe_config_dt(). Does not require
  * the user to call stmmac_remove_config_dt() at driver detach.
  */
 struct plat_stmmacenet_data *
-devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+devm_stmmac_probe_config_dt(struct platform_device *pdev,
+			    struct stmmac_resources *res)
 {
 	struct plat_stmmacenet_data *plat;
 	int ret;
 
-	plat = stmmac_probe_config_dt(pdev, mac);
+	plat = stmmac_probe_config_dt(pdev, res);
 	if (IS_ERR(plat))
 		return plat;
 
@@ -700,7 +702,8 @@ devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 }
 #else
 struct plat_stmmacenet_data *
-devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+devm_stmmac_probe_config_dt(struct platform_device *pdev,
+			    struct stmmac_resources *res)
 {
 	return ERR_PTR(-EINVAL);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index bb6fc7e59aed..daf3bbb503a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -12,7 +12,8 @@
 #include "stmmac.h"
 
 struct plat_stmmacenet_data *
-devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
+devm_stmmac_probe_config_dt(struct platform_device *pdev,
+			    struct stmmac_resources *res);
 
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res);

-- 
2.43.2


