Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A2578CCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbjH2TbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbjH2Tax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:30:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1711B;
        Tue, 29 Aug 2023 12:30:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500b6456c7eso4473187e87.2;
        Tue, 29 Aug 2023 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693337430; x=1693942230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eglkfRZu56bK3qZVs6wBq4nX9Ykg+M4S/tca+p9SQ30=;
        b=jruP9OV0Cp6ujyJehHhmSgckXYPv5kzIE/ofTujIZnvpA34/6dBmoxH1rbYtdMXFih
         kFpwPpfSFd9lXwbYzZTREjUW8uUS17xTiLWsgtlAiEIV2fj8UJ1ftWYc22ucfable8R/
         +fs39uyDtpOB0s9Gy9uLrL3MD+NfcnHcPKqB32H0L4Ax2/JpGmwznU96hZMth0CEDdDv
         4/csJoQbC+Vtt6evliCCQILLJAFConRiGU8t6N+uAM4yU2qQIj9DAnRP51VuMaAH/FmP
         OWq59Lar9SXHwEuebsNn4XBl4srthjzzheotqT6dLAcvLWt0e1RmkFBSuAF1a2f178HN
         htQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337430; x=1693942230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eglkfRZu56bK3qZVs6wBq4nX9Ykg+M4S/tca+p9SQ30=;
        b=W/4Q2vY1/3fgvUftfq7WwesuSSULxmFjDDqEoA043dhZ7E2gCtQqJwEjfUzgAsYrCv
         gdgZh0rQwzwoLpt01vmwNyLzbx3kDr/5y/lBHTQDMgXIQITbu4KVEbb3ajTpwLdVtB6G
         NZoIF8UDY//gykvtMiS2pp8NMJDD6TpZpj/oYRBI68RpSY78mtkmki56ORHkMC+k74J5
         O3v0m72wvtVGKUgfXm69x35p7qft7367Ful9SodPKkQjXEVvc4WuYq9zKgvK9EG/kpa7
         UASpSC+UciS4UKz9p2Xeyg8vAy13PP0MhXL3bTn8P0Ro86lXqgb5XaSJCqBge7Hugg23
         hM1g==
X-Gm-Message-State: AOJu0Ywt/WID0ijD7GhhZwXIReW4pj5y8GYVfsL/rm/pImqxl6SVbp3x
        pSr/JRnFBvpSTU68Q3UO1A==
X-Google-Smtp-Source: AGHT+IGKu0J2D48F+mooqlGIw6OnQ/YOnu4pF/VvL1n566pIMWV+tJNpWaqbTUwmm6Fet/DMD5rnUA==
X-Received: by 2002:a05:6512:ea4:b0:4ff:7602:5879 with SMTP id bi36-20020a0565120ea400b004ff76025879mr26903079lfb.55.1693337429715;
        Tue, 29 Aug 2023 12:30:29 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7d3c8000000b0052544bca116sm5940902edr.13.2023.08.29.12.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:30:29 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 1/3] clk: rockchip: rk3128: Fix aclk_peri_src parent
Date:   Tue, 29 Aug 2023 21:29:56 +0200
Message-ID: <20230829192958.250248-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829192958.250248-1-knaerzche@gmail.com>
References: <20230829192958.250248-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

gpll_div3_peri gates, but a single clk_peri_src gate.
The peri mux directly connects to the plls respectively the pll divider
clocks.
Fix this by creating a single gated composite.

Also rename all occurrences of aclk_peri_src to clk_peri_src, since it
is the parent for both peri aclks and hclks and that name also matches the
one used in the TRM.

Fixes: f6022e88faca ("clk: rockchip: add clock controller for rk3128")
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
[renamed aclk_peri_src -> clk_peri_src and added commit message]
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index aa53797dbfc1..fcacfe758829 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -138,7 +138,7 @@ PNAME(mux_pll_src_5plls_p)	= { "cpll", "gpll", "gpll_div2", "gpll_div3", "usb480
 PNAME(mux_pll_src_4plls_p)	= { "cpll", "gpll", "gpll_div2", "usb480m" };
 PNAME(mux_pll_src_3plls_p)	= { "cpll", "gpll", "gpll_div2" };
 
-PNAME(mux_aclk_peri_src_p)	= { "gpll_peri", "cpll_peri", "gpll_div2_peri", "gpll_div3_peri" };
+PNAME(mux_clk_peri_src_p)	= { "gpll", "cpll", "gpll_div2", "gpll_div3" };
 PNAME(mux_mmc_src_p)		= { "cpll", "gpll", "gpll_div2", "xin24m" };
 PNAME(mux_clk_cif_out_src_p)		= { "clk_cif_src", "xin24m" };
 PNAME(mux_sclk_vop_src_p)	= { "cpll", "gpll", "gpll_div2", "gpll_div3" };
@@ -275,23 +275,17 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 11, GFLAGS),
 
 	/* PD_PERI */
-	GATE(0, "gpll_peri", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "clk_peri_src", mux_clk_peri_src_p, 0,
+			RK2928_CLKSEL_CON(10), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "cpll_peri", "cpll", CLK_IGNORE_UNUSED,
-			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "gpll_div2_peri", "gpll_div2", CLK_IGNORE_UNUSED,
-			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "gpll_div3_peri", "gpll_div3", CLK_IGNORE_UNUSED,
-			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	COMPOSITE_NOGATE(0, "aclk_peri_src", mux_aclk_peri_src_p, 0,
-			RK2928_CLKSEL_CON(10), 14, 2, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", 0,
+
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "clk_peri_src", 0,
 			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 3, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "clk_peri_src", 0,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", 0,
+	GATE(ACLK_PERI, "aclk_peri", "clk_peri_src", 0,
 			RK2928_CLKGATE_CON(2), 1, GFLAGS),
 
 	GATE(SCLK_TIMER0, "sclk_timer0", "xin24m", 0,
-- 
2.42.0

