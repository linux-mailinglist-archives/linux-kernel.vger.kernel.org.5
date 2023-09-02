Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5800C7908FA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjIBRem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjIBRed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:34:33 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CAAA4;
        Sat,  2 Sep 2023 10:34:27 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7EF76CF376;
        Sat,  2 Sep 2023 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1693676066; bh=4AwTwBIRZzliGYZREHlXp1lG8UPu59oASjiNI3bF69E=;
        h=From:Date:Subject:To:Cc;
        b=c/NZHMQW118TC49OMKDBUTT5pzfgJXnGA+hPJBBd8dXvBCG2p5jAKWpwyd839MVrs
         MEX56NJjEvGXAF8pLYgtvsDUQ4cFekeWREK9cpTxixxKFmBKhdETznERNFI6RP4WMz
         fSZBPnq6FWyFJS8mA7h41cplQbZ5hb7u/J00l0ME=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 02 Sep 2023 19:34:23 +0200
Subject: [PATCH] clk: qcom: mmcc-msm8974: remove ocmemcx_ahb_clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230902-msm8226-ocmemcx_ahb_clk-remove-v1-1-8124dbde83b9@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAB5y82QC/x3NQQqDQAxA0atI1g2MUYt6lVJEY6xB48gMiCDev
 YPLt/n/gihBJUKbXRDk0Kh+S8hfGfDcbz9BHZOBHBWucYQWrSZ6o2cT47Pr56HjdcEg5g/Buhr
 ZlQXzlBOkyB5k0vMZfL73/QdBLv5VcAAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3142; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=4AwTwBIRZzliGYZREHlXp1lG8UPu59oASjiNI3bF69E=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBk83Ihgntx2p7Pa8+ZtqGg0lBSF3+6uCpxhNDkE
 HWdALklowyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZPNyIQAKCRBy2EO4nU3X
 VmMRD/41WapwOh7gw0YxXKz1jni5oxzXtDIBedeyoNFO9qwQcC08VyjBE4qoDJv2liQ4qF71/lI
 R0767d4pFaZTq+acl1cOi9nqQk7E9uuWOHv3u9FH9kRjC+R9pfDz8N4zaiYlkUFOCQi3Wm3wtE4
 yVcZ09hiURCB7nhSjRj2rpypLr9HTzyr/Sj5H6tQ8CgWAuw6q0nRjBcgvP3707g/0MyIA+wH7+M
 hnP3nELVChPMXMhrd+/6US4NYNxAYkvyDiNvHbvnphAQvkQdKSSPeJTrO1H92hc7ZBJquAJpcAq
 +M42mk4yapK/QsrYBpyB2L9qkCHOfyvhQ5u+0MQI/rdxaSBeYUFKAaFSGj1B83yBxme5fth8se/
 IcUQVodOGg19X3eJ3Ea7zlQ02cm4A/Mx8SpFi9DRdck+GUcQVOqTvbZ/kklVrplCxUO2ywy7TR0
 Ip2qewZt4Em2smnEVui8Cu+KfxJnC4oKU4QcYRVPJ03XvmF9FQVimCoRrmb2c8deso9czgwCTK0
 6+b0BxTAnUFa6xmVRoBsn9It2QRMVw0P8ecAMQdd/pw2Z9p0OH4oaXRaNMpeVGm4lQv1uOgwnsQ
 LlWrUuTJ6IydYIg0eZkzSRRIBbdp/62rhrbnP2xUoB68WLcb8uZIX+ecngjvurC8dUG7kFJMP10
 Pnm3RuTPCcu0VTw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to a commit in the 3.4 vendor kernel sources[0] the
ocmemcx_ahb_clk clock "is controlled by RPM and should not be touched by
APPS.".

[0] https://git.codelinaro.org/clo/la/kernel/msm/-/commit/37df5f2d91b4d5768b37fcaacaeea958dd683ebc

And indeed, when using MDSS+GPU+OCMEM on MSM8226 and not using
clk_ignore_unused, when Linux tries to disable the clock the device
crashes and reboots.

And since there's also no evidence of this clock in msm8974 vendor
kernel sources, remove the clock for msm8226 and msm8974.

Fixes: d8b212014e69 ("clk: qcom: Add support for MSM8974's multimedia clock controller (MMCC)")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/mmcc-msm8974.c               | 18 ------------------
 include/dt-bindings/clock/qcom,mmcc-msm8974.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index c37524d55d8e..3ce40c80666b 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2171,22 +2171,6 @@ static struct clk_branch mmss_s0_axi_clk = {
 	},
 };
 
-static struct clk_branch ocmemcx_ahb_clk = {
-	.halt_reg = 0x405c,
-	.clkr = {
-		.enable_reg = 0x405c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "ocmemcx_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&mmss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch ocmemcx_ocmemnoc_clk = {
 	.halt_reg = 0x4058,
 	.clkr = {
@@ -2504,7 +2488,6 @@ static struct clk_regmap *mmcc_msm8226_clocks[] = {
 	[MMSS_MMSSNOC_BTO_AHB_CLK] = &mmss_mmssnoc_bto_ahb_clk.clkr,
 	[MMSS_MMSSNOC_AXI_CLK] = &mmss_mmssnoc_axi_clk.clkr,
 	[MMSS_S0_AXI_CLK] = &mmss_s0_axi_clk.clkr,
-	[OCMEMCX_AHB_CLK] = &ocmemcx_ahb_clk.clkr,
 	[OXILI_GFX3D_CLK] = &oxili_gfx3d_clk.clkr,
 	[OXILICX_AHB_CLK] = &oxilicx_ahb_clk.clkr,
 	[OXILICX_AXI_CLK] = &oxilicx_axi_clk.clkr,
@@ -2661,7 +2644,6 @@ static struct clk_regmap *mmcc_msm8974_clocks[] = {
 	[MMSS_MMSSNOC_BTO_AHB_CLK] = &mmss_mmssnoc_bto_ahb_clk.clkr,
 	[MMSS_MMSSNOC_AXI_CLK] = &mmss_mmssnoc_axi_clk.clkr,
 	[MMSS_S0_AXI_CLK] = &mmss_s0_axi_clk.clkr,
-	[OCMEMCX_AHB_CLK] = &ocmemcx_ahb_clk.clkr,
 	[OCMEMCX_OCMEMNOC_CLK] = &ocmemcx_ocmemnoc_clk.clkr,
 	[OCMEMNOC_CLK] = &ocmemnoc_clk.clkr,
 	[OXILI_GFX3D_CLK] = &oxili_gfx3d_clk.clkr,
diff --git a/include/dt-bindings/clock/qcom,mmcc-msm8974.h b/include/dt-bindings/clock/qcom,mmcc-msm8974.h
index a62cb0629a7a..743ee60632eb 100644
--- a/include/dt-bindings/clock/qcom,mmcc-msm8974.h
+++ b/include/dt-bindings/clock/qcom,mmcc-msm8974.h
@@ -121,7 +121,6 @@
 #define MMSS_MMSSNOC_BTO_AHB_CLK			112
 #define MMSS_MMSSNOC_AXI_CLK				113
 #define MMSS_S0_AXI_CLK					114
-#define OCMEMCX_AHB_CLK					115
 #define OCMEMCX_OCMEMNOC_CLK				116
 #define OXILI_OCMEMGX_CLK				117
 #define OCMEMNOC_CLK					118

---
base-commit: 7c2878be573282a9961c359b806ccf70afe1a6b6
change-id: 20230902-msm8226-ocmemcx_ahb_clk-remove-85dc043ccf12

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

