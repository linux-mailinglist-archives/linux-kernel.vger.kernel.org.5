Return-Path: <linux-kernel+bounces-28819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6ED83035E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7F728823A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DFA14A87;
	Wed, 17 Jan 2024 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="eevvGNsl"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558A1427E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486644; cv=none; b=uxmn5pN/hT+Pluc7YPkXtzhsjpg78HmB7GirlUQ3POd+nqWya+hSSFcJY0YyXgxXP4ojOR9Tt15MGgcz32XphknZyLRA1C5peM4/o6ZW5HkdIDq69Vmt1ieF0HtEVMV3E3ZmLQ0iMo1A/MYzprocSOYEMzQ9ttHNDMW1rGPAaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486644; c=relaxed/simple;
	bh=754t0uTULSRpJAMac1CD95NbzZnhj+FFC+mGT+l7NBs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer; b=dKV3F4C/WXkC5LnNsJofHSRkjDX6br4QchzRzhnxukFf3FOSQCCsLXspTpYpb8VeFT1I5cMeOIkAwlZJBCQlo4/0aSXiTzmN4c1RB/abTCh6hAV0/jLpIwH+vXnoer3AQFGIWafbzx+HWYGFhiXnGRMC9zUYPbsOMIvVJaSim84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=eevvGNsl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28a6cef709so1199195766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1705486641; x=1706091441; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrjlcWfn/pDpqQxIFmiRolfpjezwCtleMfj2jxEGGng=;
        b=eevvGNsl/Qb3lS8PTmOKBvhbO9UPT+rbpR5GQgPEuB53zNNZMVv7g+kSfgy853/IcG
         NXralb7aTjJQ+agQkMDmMTZ0RcGMt1th6zWD3TCzGe2JS9GFpaqQcCCCXPjIAi+ZuXVz
         b9H41hPSuJMSVg0OqvhOYAuSZmQvmF1MdEGBkPbEiRrK1LYciYe7b5cdBajd6AB/1+rc
         p3WuCESQD27ksH03Y451WxgalSHvyHfv9/M5iEmVB1ZqkZUJyFz173RxMzW+psqFmQNw
         h8gegC1Njm5QsCrtmdqAj8rViVqGyc6Lysq/QIZpJ+CGwq4O8xXZ70TisNlWA04p316Z
         3HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705486641; x=1706091441;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrjlcWfn/pDpqQxIFmiRolfpjezwCtleMfj2jxEGGng=;
        b=KlfaC6sSNtLEKVvOmRNRe/RCZHZS+3WkoICzv8IFbx2jRjVaNpbcjb6wL7v6/gENJp
         mtsTL26lDF/z1Tn0yfL4XRe0FBSAiGicuk4ZgYq/X+QOEccrz8MS+BwPQzyqAfym3kTH
         d/UqlLkWridQON0Bh+GpswAwqTvBi9liYnCYPhRakbNBDK+Oqmyws47rU9EN+U+ggHUF
         trc23xzDK2wRk+pvYqiShrIXleB7JqiO1UKX+Oj8Ep2nU4c0DCRNpDyH2ayh4eewbISI
         d74mnBWNsZEzuZhaQp8izYuJr3AVivkPZG/eHPsNVVuOPtTzP3bDfe4AEoLjZUQxTWSt
         WGYg==
X-Gm-Message-State: AOJu0Yy91DY5ZQf3QUj1ypfsV/z0PAMUBCODQiMlMhU9Gc/SRb+OHmf1
	mnXPx3/Ivdlv4XUMZUIgKF/vqwxSofLI6g==
X-Google-Smtp-Source: AGHT+IFnNFFKnBL/28HVHLl3XdPWmHosKITeRDNylFga0N9qWEwAjTFEOYHJ+jqRzPMlPYDHaq60+Q==
X-Received: by 2002:a17:906:2411:b0:a28:fd13:ecd with SMTP id z17-20020a170906241100b00a28fd130ecdmr3558696eja.129.1705486641393;
        Wed, 17 Jan 2024 02:17:21 -0800 (PST)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090653cc00b00a2c56fb5ad5sm7558767ejo.21.2024.01.17.02.17.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 02:17:21 -0800 (PST)
From: Mantas Pucka <mantas@8devices.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Mantas Pucka <mantas@8devices.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-ipq6018: add qdss_at clock needed for wifi operation
Date: Wed, 17 Jan 2024 12:17:08 +0200
Message-Id: <1705486629-25592-1-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Without it system hangs upon wifi firmware load. Bindings already exist
for it, so add it based on vendor code.

Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
 drivers/clk/qcom/gcc-ipq6018.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index b366912cd648..7cdaf7751566 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -3522,6 +3522,22 @@ static struct clk_branch gcc_prng_ahb_clk = {
 	},
 };
 
+static struct clk_branch gcc_qdss_at_clk = {
+	.halt_reg = 0x29024,
+	.clkr = {
+		.enable_reg = 0x29024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_qdss_at_clk",
+			.parent_hws = (const struct clk_hw *[]){
+				&qdss_at_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_qdss_dap_clk = {
 	.halt_reg = 0x29084,
 	.clkr = {
@@ -4361,6 +4377,7 @@ static struct clk_regmap *gcc_ipq6018_clks[] = {
 	[GCC_SYS_NOC_PCIE0_AXI_CLK] = &gcc_sys_noc_pcie0_axi_clk.clkr,
 	[GCC_PCIE0_PIPE_CLK] = &gcc_pcie0_pipe_clk.clkr,
 	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
+	[GCC_QDSS_AT_CLK] = &gcc_qdss_at_clk.clkr,
 	[GCC_QDSS_DAP_CLK] = &gcc_qdss_dap_clk.clkr,
 	[GCC_QPIC_AHB_CLK] = &gcc_qpic_ahb_clk.clkr,
 	[GCC_QPIC_CLK] = &gcc_qpic_clk.clkr,
-- 
2.7.4


