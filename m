Return-Path: <linux-kernel+bounces-137500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364989E2F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46601C216C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4D4157A41;
	Tue,  9 Apr 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drkuT0Hu"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE24156F5D;
	Tue,  9 Apr 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689723; cv=none; b=GgpvSqxw1Qr0VaxVmffrMKOnB2LLixzwtZIvbyumnY9NoBspvss1giZrxBu+Hqp0tgA+on2oSHp63ScoOB3CyNFTAah877klgQWVe/MxTi001iyNO+myEePPG5zSpZouHnyPxnEmI3rIh9HH6bPDpPTWpakyeSBvE99VJPxAvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689723; c=relaxed/simple;
	bh=2SGSOf9MraG0urfLafHVpTPVh0NeYydXJoNcIM3qPUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpBkZGwJfaVqy4RNlSAXhJ3h4+SJ94iaR2CzrdyKJ72jdFCC7EZQj51AjUzCOtTS+JlNnUVWCfCIhFI7Y+7fk17DCh/2Z86lYkx1avcvRKzjTFNzESWquOZzi/Jxx+Qfs/ih5JfdQcr4fcNVmRoZNbcCf+esQ3oXRpjEk+y2U+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drkuT0Hu; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ea15e25a06so1725809a34.0;
        Tue, 09 Apr 2024 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712689721; x=1713294521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBuC8pqgFsd4wEiPMqmBqwIDKCnuRqVAfWjdldEDdmk=;
        b=drkuT0HuZ+8zVc3aK1nhWEMyEIpZNorsKISaCCwQvFNDL5xbJ2B+V+YCjHoiNDjkDS
         F+kuc63NsjC6JLhnr5HiF1f4uQXI8nWpURDG/sg+6Q+rUBMkwyx1iQvNJp2lFC/9UKA0
         MU4GNgA6jx9PQgfgwun43E5J++WQ2p6BYV7D/vplrW0VrZMiUVlIYxz4g09DUNbvjVeq
         BxiK7Gd/xfERBFLMVp3nVBVh4MagbRqm2138DASxrEJ2F9q3tlYKwZHyn1jzW8PWfG7G
         d5zlDytNm+d4x290vU43kr8KaHbOJwv3XWhFmerbuq2J6XZRtjEqfbZ//6a+YL1TiGxK
         8+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689721; x=1713294521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBuC8pqgFsd4wEiPMqmBqwIDKCnuRqVAfWjdldEDdmk=;
        b=t9imA0vnoOd9iSMhvxV4G5cnH1fd0KCA+eeQwvSwOIzkeqmXzVsF3ob9olX7Sy6XqE
         Wc4REbB7ZJbbJ740dapq855BLbRwk8whEpdB+BhFP3NQqlDiIkftBXQxQypAptUvx2G1
         DiDZCqWXeSZ+61TvXSX8dz4Qg2oLnem4tTnB6NMMYIqaMGT81WjmOeh/Jgn+y35P4qaB
         oN5+ePxQ9SB4HhHgYSvFqWJQRxy6Gr1FikdWaGCCjPzuImPXhzE0dhQO3mTr7jd6xrYh
         DSLhTep+jPCLomHA0DlsnrkwmkPNA5Jxvet6AjGrPXdTqX0/+Az5Qz8p4ESRThgLxSfV
         aYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwJaXo1n1xYUDv2nJ82EJzGZ2AeDmUdW03yIMBqOVqxNwxEvR09Cb9TlUafXc8gR5fhd/HIIjIGTo4CXle56F6gVbc29eSkGhvp/Iq9jR69hPEfArJvTN6AQ2E9U9/5MG4cdiqmFq9rjtI7zVt6Db0oi61QwE9QraNJXNRiSUt3lqeePdXeQ==
X-Gm-Message-State: AOJu0YxGOpHd3a1gp97XL7zTklWXT28nD7Q3hxsubs6ky0HvEvqcexKz
	ggoeLjuKYbaARSZkDO8MRt4ZvhACK9AcT4f6W40P4uIlw3/v+yoOmTRlrIP/JZOa5A==
X-Google-Smtp-Source: AGHT+IHJ2x7wyJuwaDEleEnuz1j3q5JK70qW3MNUIhjGajZK7FoAI+SBypCk+J8RF2L4o0hdjBdftg==
X-Received: by 2002:a9d:7f94:0:b0:6ea:767:9dc5 with SMTP id t20-20020a9d7f94000000b006ea07679dc5mr772361otp.3.1712689721325;
        Tue, 09 Apr 2024 12:08:41 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d7b4b000000b006ea1cf91a8dsm674920oto.40.2024.04.09.12.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:08:40 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
Date: Tue,  9 Apr 2024 14:08:28 -0500
Message-Id: <20240409190833.3485824-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ9574 has four PCIe "pipe" clocks. These clocks are required by
PCIe PHYs. Port the pipe clocks from the downstream kernel.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..c748d2f124f3 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -1569,6 +1569,24 @@ static struct clk_regmap_phy_mux pcie0_pipe_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_pcie0_pipe_clk = {
+	.halt_reg = 0x28044,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x28044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pcie0_pipe_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcie0_pipe_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
 	.reg = 0x29064,
 	.clkr = {
@@ -1583,6 +1601,24 @@ static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_pcie1_pipe_clk = {
+	.halt_reg = 0x29044,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x29044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pcie1_pipe_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcie1_pipe_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_regmap_phy_mux pcie2_pipe_clk_src = {
 	.reg = 0x2a064,
 	.clkr = {
@@ -1597,6 +1633,24 @@ static struct clk_regmap_phy_mux pcie2_pipe_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_pcie2_pipe_clk = {
+	.halt_reg = 0x2a044,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x2a044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_pcie2_pipe_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcie2_pipe_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_regmap_phy_mux pcie3_pipe_clk_src = {
 	.reg = 0x2b064,
 	.clkr = {
@@ -1611,6 +1665,24 @@ static struct clk_regmap_phy_mux pcie3_pipe_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_pcie3_pipe_clk = {
+	.halt_reg = 0x2b044,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x2b044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "gcc_pcie3_pipe_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcie3_pipe_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static const struct freq_tbl ftbl_pcie_rchng_clk_src[] = {
 	F(24000000, P_XO, 1, 0, 0),
 	F(100000000, P_GPLL0, 8, 0, 0),
@@ -4141,6 +4213,10 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_SNOC_PCIE1_1LANE_S_CLK] = &gcc_snoc_pcie1_1lane_s_clk.clkr,
 	[GCC_SNOC_PCIE2_2LANE_S_CLK] = &gcc_snoc_pcie2_2lane_s_clk.clkr,
 	[GCC_SNOC_PCIE3_2LANE_S_CLK] = &gcc_snoc_pcie3_2lane_s_clk.clkr,
+	[GCC_PCIE0_PIPE_CLK] = &gcc_pcie0_pipe_clk.clkr,
+	[GCC_PCIE1_PIPE_CLK] = &gcc_pcie1_pipe_clk.clkr,
+	[GCC_PCIE2_PIPE_CLK] = &gcc_pcie2_pipe_clk.clkr,
+	[GCC_PCIE3_PIPE_CLK] = &gcc_pcie3_pipe_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq9574_resets[] = {
-- 
2.40.1


