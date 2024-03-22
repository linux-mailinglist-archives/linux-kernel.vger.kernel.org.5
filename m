Return-Path: <linux-kernel+bounces-111236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DE886986
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF95F284134
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3223BB4B;
	Fri, 22 Mar 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxSbVXBJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD0C14F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100572; cv=none; b=Xe2O9SEnxPaehsPtwEeRlMnyFhhBD0TZKX77Vkiqjgz8EYGltuJoUJwWDX2JhCeHeDl06LvEOpELk1grvfLxH2wcWieGXCFCEyku17wTsw9YkK3R0+INsswRBtxcaMPjSP+9qH9G2a4mEGZ8BW7ew2w4AS7dJ41+TolIYklcCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100572; c=relaxed/simple;
	bh=Kx4iMHJO5z5RGLzsJX88ltZJ+Wx+25o5A/I8DsYjDng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNi/nIImNzDz+p9bgkyCYS4TDFB2ut2TAHf9AxfFXanmZgYQBQXA7INnmRHF0FHYBxEmoUcGOuoQ90PFQ815C3ZUAYnZEx4Mqit3SkUBOpcdgzY/LWdaMl3glsIt8fXBCCHg0D/f1PKB+KqqMY01NRFTiikgaspjwv3iruOz+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bxSbVXBJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-414701303f7so18370725e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711100567; x=1711705367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCVeYwWPRSz03B1OM4VXzQEUZALrlERjZIgaPDXj1aU=;
        b=bxSbVXBJws315bLuoeUeFTBDZEWNGletHf3hZXt756ZSPYO/tHmQCp8d95iZQPDGuO
         IEvGOlWotNdEDYVkAD8hLK4vqiD4mylz0NbP+WgV04EJGPmkfFUi2QBuwFgZBQ3dxzhQ
         bqgi9WhEEim0Q1BdiMHjyvtD8gFLQkBTX81x+5cKCEFWOPa/tT0XsrJCKAb80Hv9Tc4s
         LGB90QS87nxNAAmm5ea1HpM8tW0csCl2QhWtOZ7E36a5QiEPGIDkj2lQ1SvMSqWP7U6o
         wm5L7jQZzRuitUUoxGYFACcxr9ObhqkLSzOk2iK8ZGI+flwx6shxLXCAhcraVjrpacOX
         JP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100567; x=1711705367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCVeYwWPRSz03B1OM4VXzQEUZALrlERjZIgaPDXj1aU=;
        b=lePjf5QFyyHdl28hv4rkYuQ2xU3GxvGzyRAJzv608UD7ibw7cuQsvEnj/BzmIb7ZNF
         1iA0vLfHwV0UEFdbAfCCLFULp9vhfr65Nc6/TMfnXx2z5uwmibrbQe5N6huK4g35DnVe
         gek1hk2PSnyoiz8YoS9rS8Z6tdviK9ZgFik9Ew1EpQ0lVNOfWR+a9JAPNA9K/7bb2Ir+
         m7zD3Ktc+TNuxrXabfaNFdazwjE5Jm4UfMAtP6XHXLuvHmgBXMB4TqzWiDlRXpHlxTqD
         QT53VG9M+L/1Z9ew8LMYHAXEMHE+a7BvOvzvvgGTsAF+eYZvHGNFZJIbI+6OoRL/E+vh
         A/hg==
X-Forwarded-Encrypted: i=1; AJvYcCUP5F0qA0UKqfAKfKXVLjV8pac3GrIVJjFzf1Rih7Gbs2LZky9K2FWQDLwGw764W9X4Q6iHGhFMBbbkzoZ1Wq4QcVK8ck6Sp8jhkRQX
X-Gm-Message-State: AOJu0YzcLMXIIFpRiSX7bR9JcEUGHT3nhDc9rtNH/ABS40dpMBPeSbUY
	sk8HDTJgGpa2PanIyHALeLUDOqYC9P6DY10oTD/JmT00w9jFyQhnWuhwL8eGC3c=
X-Google-Smtp-Source: AGHT+IHuvX98vufxnj4c0MPkLoSPVwneu2E3xOT/4wRhqnWE78lQbmyGtmWzSybZTB5mt/SGHh2JpQ==
X-Received: by 2002:a05:600c:3b99:b0:413:286c:4fc0 with SMTP id n25-20020a05600c3b9900b00413286c4fc0mr1244065wms.34.1711100566636;
        Fri, 22 Mar 2024 02:42:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b0041461a922c2sm2547845wmq.5.2024.03.22.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:42:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Mar 2024 10:42:39 +0100
Subject: [PATCH v2 2/7] phy: qcom: qmp-pcie: refactor clock register code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-2-3ec0a966d52f@linaro.org>
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
In-Reply-To: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Kx4iMHJO5z5RGLzsJX88ltZJ+Wx+25o5A/I8DsYjDng=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl/VKRV3QKxg4v+M8JT2fAbX1GHt2A5QnD7QKumt8Z
 s4yRYgKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZf1SkQAKCRB33NvayMhJ0RfpD/
 4yoc9hDH+2tgpOUGvP8Jz8d3R1kJ7/9B9wDT3JPRVWRiBiP/dGO1eJl/Iwj+DgYHugvFp+iEPuCUHA
 /xOMr9SDEZy85xLhmLDBYZCHAQZtLyoYNi02ZwyHJ+cJM1MGMzq8H0NFLoDYVWxVkYJWzVAPOybBwF
 ojmpu7U1uJSMfycX6t9LfFetWI3+FUu0CZ+jchqV0vk9Io9hUEelywc7t7egRzf5r9XombNqjEaARg
 7MIC2yGMb4iC/0T8SOf8fE2w80fzJSgOQuF97GMuEsOCTagBoZTnk6bI8RgKoLbm3X1UewEQXIumaP
 gw975Bfz02lsG02mE+eeehjA5kiZ8cw4/CUysHJbBMFtvXaCV2pp1ldMpt8l5lgH//+lJFw9/+Cryn
 j5U9fJxmqF0Si79c1OPURBBqDp1/eluNm7MXx6eDBQ39NILu7Q3qtPolPXyhlQSnwJIz0+dKWkyS0m
 Zlc3vsrtaoVF3kKYoYios8inatr8RQ8gRd9t/FisXA2OXBU2ylgPMVaavxpeyaGxqKGCuk6g0/o/51
 3w6Z1plxH2RdQYlv47OYSI0wae7mKQjttKsd/Gi4opqjTbpWuOeoYaDcakKNAblF7ySlLHYz1Ck616
 N082i3ZTsAm26Wgulfz3NipQxmoU85imns6bilNEwAMOxMnuoxLnT4qvmfYA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
in order to expose it, split the current clock registering in two parts:
- CCF clock registering
- DT clock registering

Keep the of_clk_add_hw_provider/devm_add_action_or_reset to keep
compatibility with the legacy subnode bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 8836bb1ff0cc..e8da2e9146dc 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -3664,7 +3664,7 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 	struct clk_init_data init = { };
 	int ret;
 
-	ret = of_property_read_string(np, "clock-output-names", &init.name);
+	ret = of_property_read_string_index(np, "clock-output-names", 0, &init.name);
 	if (ret) {
 		dev_err(qmp->dev, "%pOFn: No clock-output-names\n", np);
 		return ret;
@@ -3683,11 +3683,18 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 
 	fixed->hw.init = &init;
 
-	ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
+	return devm_clk_hw_register(qmp->dev, &fixed->hw);
+}
+
+static int qmp_pcie_register_clocks(struct qmp_pcie *qmp, struct device_node *np)
+{
+	int ret;
+
+	ret = phy_pipe_clk_register(qmp, np);
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &qmp->pipe_clk_fixed.hw);
 	if (ret)
 		return ret;
 
@@ -3899,7 +3906,7 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
-	ret = phy_pipe_clk_register(qmp, np);
+	ret = qmp_pcie_register_clocks(qmp, np);
 	if (ret)
 		goto err_node_put;
 

-- 
2.34.1


