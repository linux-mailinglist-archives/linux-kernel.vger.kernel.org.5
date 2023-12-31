Return-Path: <linux-kernel+bounces-13720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65800820B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B911C21313
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A18F63;
	Sun, 31 Dec 2023 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Ou5J4XYS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491606111;
	Sun, 31 Dec 2023 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1704034144; bh=iV6I3JyGdTSjJ/OrFak2R6HQgtxg2qe0kijUxUTVvis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ou5J4XYSC3TSFaP2sssK4SiYloGxEvfUCt7YhFgumpljStm/Eh5ojEmXigQbfUvkL
	 jLq9ml4FUWE8dOZgoYn6a0Ow/JtbrTXqIaokqhS5IQTWr2QY8Huq9VstDl0crZEo6F
	 WUFN/V2QJm0hjUsLOMPXI2IfelRr0vX8K71FVdQU=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 31 Dec 2023 15:48:44 +0100
Subject: [PATCH 2/3] clk: qcom: hfpll: Add QCS404-specific compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231231-hfpll-yaml-v1-2-359d44a4e194@z3ntu.xyz>
References: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
In-Reply-To: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=iV6I3JyGdTSjJ/OrFak2R6HQgtxg2qe0kijUxUTVvis=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlkX9dzudjUyNQvRt2uPyy5l+OT6HTDWBZeHFu1
 ZgyaPxPoZyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZZF/XQAKCRBy2EO4nU3X
 VvKMEACX638SAMzvEH1wjIhHAH5bKto2xRxgHfe8+IKZ/PiOSGw9TrUih7SfyLeMm+XRsckalm5
 KF+GPBk8p4JgZ15lxafx8Ek7NPVca+7l/3cWGqwrRWI4FMdUbpNUsW5EbLhqI6sTKuLisbPvWfe
 0UPk+J79pHo/4tBk0sZJGEQ5wMAX4vp8Yhce/e5h+w+axIr+UsqgZCbOV5G9yahxbKm6vDrLUxh
 IqNScMYuUvmEgAGFeEh1P0d/DM6sUC+efrCGauP6N7Yqq8Oyby20L8GIwhAZrbkmz3auVlUk1yi
 Crd3RnnN0ZcIAlcuS52sf5KMliyMQjJTFvb7jyYptassC6TRk6DISOj2FqJzEzms3rdCv6bbcTC
 aFinjx203/t4p2s0+Qz400TksxOge3bLJO7VlQo1vCqA4tgLslxoF4gi7ZtUjd3I3Xd5X1iqSW8
 e0evDpIAtoWUz0PRpD84zVZaj17cUScUI/+vyCEJohOWQU1BASaV9q1eN3STvIc/GWWq+xQCnje
 UXrBFaGiXkGz45znuzWtNH9Ml+RqoB7T4YjXkLHO/6pZDwi/zg5/8H/NIjC3aw40zbbYhWZ1M78
 d22DSQweZiphrJRrxogLgRwmuoZmsJsf+QI2qVkWEeAihaBcIZ+HY2lxZgsyJAWVQI1gg6uANd/
 qbESMzYDMS4sexQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

It doesn't appear that the configuration is for the HFPLL is generic, so
add a qcs404-specific compatible and rename the existing struct to
qcs404.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/hfpll.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index dac27e31ef60..5b12982519be 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -14,7 +14,7 @@
 #include "clk-regmap.h"
 #include "clk-hfpll.h"
 
-static const struct hfpll_data hdata = {
+static const struct hfpll_data qcs404 = {
 	.mode_reg = 0x00,
 	.l_reg = 0x04,
 	.m_reg = 0x08,
@@ -84,10 +84,12 @@ static const struct hfpll_data msm8976_cci = {
 };
 
 static const struct of_device_id qcom_hfpll_match_table[] = {
-	{ .compatible = "qcom,hfpll", .data = &hdata },
 	{ .compatible = "qcom,msm8976-hfpll-a53", .data = &msm8976_a53 },
 	{ .compatible = "qcom,msm8976-hfpll-a72", .data = &msm8976_a72 },
 	{ .compatible = "qcom,msm8976-hfpll-cci", .data = &msm8976_cci },
+	{ .compatible = "qcom,qcs404-hfpll", .data = &qcs404 },
+	/* deprecated, use SoC-specific compatible */
+	{ .compatible = "qcom,hfpll", .data = &qcs404 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);

-- 
2.43.0


