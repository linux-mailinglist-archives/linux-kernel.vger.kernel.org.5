Return-Path: <linux-kernel+bounces-164903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9F8B84B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC81B20C60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732B5028D;
	Wed,  1 May 2024 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axhGrnhV"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35E4F201;
	Wed,  1 May 2024 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536503; cv=none; b=ukjYvZyM/L+EM6e3eqlI3dZ0dVqv7FziE4qHjkbWhPl5XRl107FXRhGONzbt47uSu6XInNZC7G+5LdGaUQYPAUtQOjNyAsbbSg8XbbAYiffKF32JL1XOlK13dPaJ5SUnAELCbrEANokfzqtnuyyLKamZiAdx1WsBXpPAsWpVQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536503; c=relaxed/simple;
	bh=hXqcsPpRih55X6qbkKifrC4azWi5ZS32nt4esjIky/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ky+2OhVnKKjTwaCtZ+MTrKP+VZfz4QuHi/wMZAAZgT2dFQ6b3XJ3Jqh0uIYW764WKOGayspQSxBQ4iz350vNNk1p0GZSH2jcZeV5t8vc8Bu2b6KPN5wl1JDQH8oDn2bxzT38TLdEz2+9VezRThbO8U6NllQcdO3M/8YbofVpSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axhGrnhV; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea2436de79so3380661a34.1;
        Tue, 30 Apr 2024 21:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536501; x=1715141301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzHEIPYot6c8NAo7TIBriZfyyuOfBQrBEKWQMBGEIB8=;
        b=axhGrnhVzaPsCNBXQdH4rxY6OrdrskZ/Ech0JPdiAlGmnKtbVKlSZLfyDcn+sDvO2E
         4ELcPp1HL4Qo08u6NSQur5NiQyq1UGnYSyGBYau72NEKHVdcVGZaMrgI0f2SXiPg8rVg
         x/dbn1PQK/QZXNnWNsezqNSRUrGkKh9CNZ4AwR1Eb5TdgjJclgsPO4NZKOWkkiKcLNh2
         MsmitoPdmQuslc877DJQjFMsA2lsBnnnqjtSaHAlvSIXH8ubx7mNFLSmd8rI86qzwIO3
         gPVe5klWySCsioQTT5BYAkIAapSWDE97uyKZj2ktN9o+jREEpqu4oBIMcuHEAytCQW6G
         S1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536501; x=1715141301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzHEIPYot6c8NAo7TIBriZfyyuOfBQrBEKWQMBGEIB8=;
        b=Yad2xylyA8K5Z6cMifmjYPAWTL/LLAYrYZbp6x/AbAciUsJMTHznobtyuMQnR8SfE/
         a4/f7680acipP27QIgSOfrXsN03WKJy/w7GcNP5oU8DVcZAot3iPbmOvBJ9mR8+25HAG
         Gzz+Aqs/oLPNFWPbb2FgrMeM5W/h7U0fB9bS07PSVT4yIKUHpSQtrj2vNLFUN1N6ZJWL
         VG9psWjX/LpVfO9xr/AIlsMK4ZOCq1FRILV7l3WirhZTpSCsnN5RZNVii5lfbXffBiRn
         wQgDQAniEvjRreVlKuC+oPGEkt7fKEcsSXAgyQ3swnEOA96IrLCVpxMGiB+CwvOWXeTN
         dtHg==
X-Forwarded-Encrypted: i=1; AJvYcCVKN97D7b7VQ+nLBAi+WivzsYtZ4AnCc9CGODao4PAoa6sy7Ow6Ky+P5qb+dYhq7Ii282SgXxQrel5NipJFMXZKqDR8nPH2ALvjT18Kf7Ibv650FYCuWg5D+5x7rCxGq2UKZWshQgX7zg==
X-Gm-Message-State: AOJu0YxgH7Q5vbUOX2mcAs8a0cgB5iEuO0M+wqSFirKWU8dy3JMqV/Ui
	50c/IEAgQDAkQPU1QnvVzv1RAuoAAneLjxIMua0EDrgHznZxb0PS
X-Google-Smtp-Source: AGHT+IFDDSZTtQ2oDGM/IsqigtXfaxqv00IURKwtKmjP5arAqOItQfEhFVYs2gOM0BVg+Hefi/l3Pw==
X-Received: by 2002:a05:6808:2cf:b0:3c7:128f:8742 with SMTP id a15-20020a05680802cf00b003c7128f8742mr1692271oid.43.1714536500717;
        Tue, 30 Apr 2024 21:08:20 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:20 -0700 (PDT)
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
Date: Tue, 30 Apr 2024 23:07:53 -0500
Message-Id: <20240501040800.1542805-12-mr.nuke.me@gmail.com>
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


