Return-Path: <linux-kernel+bounces-70580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F285996F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2351F215B7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18F74E21;
	Sun, 18 Feb 2024 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="G7LmKXUa"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468497319C;
	Sun, 18 Feb 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708289872; cv=none; b=RXzmgcLb0EeqSEFL0zwzgM/9NkqHyXM3iqjuAckOYyeC5roHMVoXt0+VKjU6n8zfNfRW2W9dc6r0Zk2yk9fvOT3QNm4dTVCFgNRZvTM8Se7X+gxqxZsnnHyE5UrKcX6U9fMambPePfo3OG0M4t8Eyh6o2jnLxWHKLefw0g66vPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708289872; c=relaxed/simple;
	bh=iOU/i94FGLUQQ/Zi7YDwFxvihjyDEdP/r4joP5PnYvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TU9q+gLWlhjtahfEZxjXF6fWx2Fsnm84P1btPlmUmQxiFQMXhxV0SRyMxlanlHL47p/QLjUddM2+CJTXo5prHFNmm5jkk2ExMB5WxEmaklQPex+tYfrDTpGitOCwIhg9Aaa1AkmxDUJgtz+ry99hxLpsQHFphuyldUm0MoAwdyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=G7LmKXUa; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708289861; bh=iOU/i94FGLUQQ/Zi7YDwFxvihjyDEdP/r4joP5PnYvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G7LmKXUauXglKa5Rxtx/ZoccHgoo+kzQC7RpuzK4/LdHPbWuUSM1I3vQyLWPEyrGU
	 BswC+ifi2LEJuMSb6C2plJW6mWYAccAwo9GxCDGvlXB6E0lTAPDejzLJFGr63HK7k+
	 FPa7ZwSmNGNXT6JokegqlTuZGG1N5GPPAEThg6ac=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 18 Feb 2024 21:57:26 +0100
Subject: [PATCH v2 2/3] clk: qcom: hfpll: Add QCS404-specific compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-hfpll-yaml-v2-2-31543e0d6261@z3ntu.xyz>
References: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
In-Reply-To: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=iOU/i94FGLUQQ/Zi7YDwFxvihjyDEdP/r4joP5PnYvM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl0m9C9LZtfFB13azY8G7tV/jnLuGVeboPdnthA
 k1s+eIShnKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZdJvQgAKCRBy2EO4nU3X
 VuP4EACmTCqSrUYviwaGfGtWpM+j5PGg7WK2MFG0jnwej64/3Y5BAUh6Aw1n/19WpTCPSJeDyHZ
 flRTnZyldkAYJS7sWIanzI9C4C+/BOYtV4odzHtB/PWxoeRBQrZjgBZslAT0ZrMmdP4QrD0BhNm
 lr9PM+j1xxcI00ISzMr0EpOp9o3PCwzvIED6g89NYu2Blqha0BdBHLKZwvDNeRe2cGLTvA/Tric
 0IZCFIWuG6jAwhVi83DWNjKXPt6ZRTBgUn4dKpqnp3YsUgg/WV1JJZMm2KPoBIfFBSk0iEuaAvo
 H9Feqa4UDyWi5VDiHeioGEtYXRCsKSmkUouioL6Lcr6AYhA78IakV2q6BdUDqg27baDOU4uUpUg
 xYJq+fFlXbBxVrkbvdYjBfD+91RafyiG6NCPyseI0CG8k8aqtkuN3da63aUvZjYoHzfQ3H2A1kE
 apnxPDjLhVsJOaIqVtPhTwLng2yln94Uh/Vm4WxMEA7FmZR8i8aJ1pFxDDXQPC270m5w/YZrcBm
 3bd6ffWjxyRb04Z3Cn+SPneCD5xDqe6UK7D/WH7GUDyy9tMMYAN0uZATSgdr46PppaiIbl/SWjQ
 24nepOxjoeoQn+ZtPa2L3NIKkrXwMw8ggTrR6RmEcuBhK2djBfC9n0ud7vSKjHg7PteKxWI6bHZ
 iunAFrUT5ohGa5A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

It doesn't appear that the configuration is for the HFPLL is generic, so
add a qcs404-specific compatible and rename the existing struct to
qcs404.

Keep qcom,hfpll in the driver for compatibility with old dtbs.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/hfpll.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index dac27e31ef60..b0b0cb074b4a 100644
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
+	/* Deprecated in bindings */
+	{ .compatible = "qcom,hfpll", .data = &qcs404 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);

-- 
2.43.2


