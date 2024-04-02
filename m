Return-Path: <linux-kernel+bounces-128560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C879895C74
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158F21F24DF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5F15CD43;
	Tue,  2 Apr 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNfmZUSL"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181515B962;
	Tue,  2 Apr 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085963; cv=none; b=j26c0ElQx5n4l4YIVuNbRzt7lxLiojM/oLLp9JwmfHyCuj+DMKNw4m3J/Ngj+oQKQXtAOa8wCIzVHyd6awOTlojGg+CU091VgqQ5YGhgBgcMZEre5ceWgAyM/B70jdoL/JS+/DuRPG6fMRRB5KmazQhUXogEX8YDDCQ0JrwdSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085963; c=relaxed/simple;
	bh=rqIqY8Pohnzmuqk3e+iotC9acyr1TG4rYOT2z0aVar8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLUNbB5hJh9KqL2IqmLKxxQUrX4UrgOpdXXuiiEvUQglLTGwB2OsKWRjhUH2OBrN8RBrzCwShDLGcevu1xwc5GJyOfrEEu69W6BAUvywZ7B41dItrpTAzuJyRj9SLWLxbX0kK2MMvY5PEhRmOL6eFK60DwKb5tYAirKo10m1i4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNfmZUSL; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c3d2d0e86dso2642662b6e.2;
        Tue, 02 Apr 2024 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712085960; x=1712690760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pom75eUhi37RZhKWTh9yAvX/1ryA6862dvJ+xgfIpYg=;
        b=kNfmZUSLVPj5YBv4azog+2ySS7FRJEBCRTE7V4P/dfK1Og74pvNxKEFupzCb77Qeaz
         +LGZc97ytUseudVV0yntQX9+fZiwTroo0hwe89mlLC2C3WnbFrm5BtsOUcesukCGxoTN
         5/N90cOXbPPz8FDyb0JbCt3Sc0HuLp9gGhMFGixUfjOyxJL+IEnyamqufEqY2JzaPasu
         Nzecw8tgfPij54KcXumkqtpIJ5pU9jeF4fGGGmOa9351X5w/bCv75jfGFvpyUjkPwb8c
         O21jlsonle4cNoUd4i2W0AH9BOyG93+Rs0EfD1uOMCKf/GKpkbydMkbeI2Z4Q9vb9U6Q
         iJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712085960; x=1712690760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pom75eUhi37RZhKWTh9yAvX/1ryA6862dvJ+xgfIpYg=;
        b=jYpU+8RAa3tfmMo9XwCf4W8UBrPYz1ZmrwoZFU+Cse7a0r0YqR0N2YJNUBRqbYpGqz
         rxgUWsBOvbeSPTP+lC3iJPBg/tvj5az9k8zR3GsToMYGk+W6ssWx4viMroDCxYdracPf
         GCu7Gf5vU4kknevQeTQxPITksbVim5pQbLrPQtHish6W+aifF7mUkkxedmC2Js2BfEKr
         ZLOFN7r+2vS+yCR/KAmz5fjS4QIfUABEMGslAAcYIG+oZ9Us4dTZuL2OLxV5p+PMQyXG
         G568YhWHoAq6lpDc1Wl+lal/RZHHTW8ySecQyRpioP83Q3BBlOLQRLOAjqcaZ2YiLg23
         gjjw==
X-Forwarded-Encrypted: i=1; AJvYcCV7EHjWw/3A0VR9gOUF0uL41dwVPqEpEHoVUz6adO9xYt7D+zCoCMQ2/n8KCHQwM0jjdA/z+ZcxRFW5NuJpaPju9jmjp/gLINCpWdBf68zKdFwjoUmCx8WTQHd1aNPLfAE0UAO13fu/5+Ug3rsgf/QHCYM2HveY7nL1QmZaXKptIztnPY084A==
X-Gm-Message-State: AOJu0YylzIxyJwFNktRqgCfuP/2At88PBWcIBxbmSVHBy8EIi6E/O0bd
	gWH177Z1oqM4XplFPjNvI7qH4+w6UdeFPqvmKcXc8+rdE+Fhmk4bNowSziOGi406hQ==
X-Google-Smtp-Source: AGHT+IHYnfPF54gy8f3Y/NUMbU723oorzfi9/LFy5Vo6sH81HJBz6iySqGML4RJHoZG2VquGkcsCvA==
X-Received: by 2002:a05:6870:a552:b0:22e:87db:b6ae with SMTP id p18-20020a056870a55200b0022e87dbb6aemr1645488oal.54.1712085960469;
        Tue, 02 Apr 2024 12:26:00 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id ld22-20020a0568702b1600b0022e8f9fa89bsm75622oab.57.2024.04.02.12.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:26:00 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: ansuelsmth@gmail.com,
	robimarko@gmail.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
Date: Tue,  2 Apr 2024 14:25:50 -0500
Message-Id: <20240402192555.1955204-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
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


