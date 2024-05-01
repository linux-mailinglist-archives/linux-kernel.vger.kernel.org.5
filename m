Return-Path: <linux-kernel+bounces-164894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49A78B8499
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1072831DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69A43ADE;
	Wed,  1 May 2024 04:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED+p0tN4"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872437165;
	Wed,  1 May 2024 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536488; cv=none; b=lfGbnNWaFsvamkIThWAZ6j2jhbFnOgFEcQvbdKvwixfbPsMpBoL6M5ki52pWOIlZBkhBkh/TqPuReq9C/zy6F7sZdL1h45nI3/ozKTV+75lP2dCk/azPP3xK8ctAm5N9YnL/vP7FAVThMLv+iq35MRvt7UkMla0Ervksaml6KP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536488; c=relaxed/simple;
	bh=hXqcsPpRih55X6qbkKifrC4azWi5ZS32nt4esjIky/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5lsjFAxNpT8P2Oz3fOKOs2dAC2JA1P+9PzxrDjmmH/PPtjIA01aaF78wNq0BRihqjZ0BQAJ+wWQmrbeVsmuZfqsKZSek8s3nSWIge4vyAPvAuMsxSopclVjJ9vPIKcEo13V4gWk+hw1e/LE8iMxrsHmqkxKtsyxyvTEWBlPkpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED+p0tN4; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c5ed7fdbb1so266621b6e.0;
        Tue, 30 Apr 2024 21:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536485; x=1715141285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzHEIPYot6c8NAo7TIBriZfyyuOfBQrBEKWQMBGEIB8=;
        b=ED+p0tN4Wl0p+XnMSVhQcwCMgZ3f4qVBQe9g233mmvGm5sp71Oibh1ErwL5Ybz4oDu
         X23e9waaAPbkC6RZn/5RhH/nMGh9aBVVP+/hdobRemraa/wCLfRk8OYvD4LQn9ljw/b/
         hl9Aqf5cs12faI91nGoHKP1xGbNoKtSc0ZKWeZLffAOZw9MG2uO1KF/O1QovNeAxxstL
         C0E09hsU/+8Cko9EwMWraYP1ROkOereCKVXAmoXWdJtpN0obcGfQHOGPRZYQJEIHbRTN
         jcusNa6n0JaO6IwIXWhOD+gI5O7cc8wKr5DKuBcYsGNzFbVj/iUYD0VxErkb41Wu6HXC
         yCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536485; x=1715141285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzHEIPYot6c8NAo7TIBriZfyyuOfBQrBEKWQMBGEIB8=;
        b=SKEl0tb7TqbRnukBtOkafKf0VB5cTZ0P8f/w9fq8dJaq0AOxfeiH5jOSwfKdK/5Wum
         Nf1QiM0eqRrPVQsehaA79mrj1En32WdcEZtnVCv9QAmR+6vGXAukCnsLjEmhX+Na+kXK
         1pJoYcUgMBAXfkk9gGXszlx816FY7iSbi//FoMTBFJTrYBXV44Rr3a6b9v3wZgddiGKt
         g8egFJYVsS+J5Du8VmJPIX8t1aBoQBv0Fr1TDM+mpHocXSMitLYcF0i/hZSUh5wijZ1l
         mXaaGFQis7Dx3T0V3b0+PtxRJH/bEFPwgkDEsEpp6fyZlrVQ160zDW9mWsyD2+7kHTWP
         Mb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFOt/H4sbp+xLZSYjZHw6lzbgOID8DneLhhJssXzN2cYxZYXHOsx0rDYAZl+jdaS3Xzvpn4YiYXinrc/zIf3yCGN1SxPpFEbDlNw37c33Ls/N1j+yE/mLPGw+duFddjE3PveMVgF2IJQ==
X-Gm-Message-State: AOJu0Yy8upDEM7Oi30BPX5QtdgcNPvA3WyiGX3bec7+oYrVfyouCrnw3
	Cwq6xr4t+WEXKUCohmAVm4e3WUVOe1zC9B+QEKJFerVQaBmzbfWl
X-Google-Smtp-Source: AGHT+IHJQwbzX9N72JdRoLScn+lsQNa+nuWXZcpHm2Ahi34mCftug1KHXAKzZdB8EagfC76klg3PQg==
X-Received: by 2002:a05:6808:3088:b0:3c8:4cf8:a969 with SMTP id bl8-20020a056808308800b003c84cf8a969mr2143976oib.23.1714536485695;
        Tue, 30 Apr 2024 21:08:05 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:04 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v4 2/8] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
Date: Tue, 30 Apr 2024 23:07:44 -0500
Message-Id: <20240501040800.1542805-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ9574 has four PCIe "pipe" clocks. These clocks are required by
PCIe PHYs. Port the pipe clocks from the downstream 5.4 kernel.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..bc3e17f34295 100644
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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
+		.hw.init = &(const struct clk_init_data) {
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


