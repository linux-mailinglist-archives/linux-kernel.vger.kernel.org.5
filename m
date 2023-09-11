Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C764E79C0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378063AbjIKWaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbjIKRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:48:26 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D8D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:48:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c0f2addaefso486311a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694454500; x=1695059300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hSkF4G7D+DMTQqfN/xQdy5YEnnHg545lD9jlBghqJY=;
        b=SJ3IedrMGyAg5hY3TlHhr4lWl4IzrzRMKnGpyjz/Zkcbn2VJb9ImNxNt7/oX2FMFMx
         I/o85qH1yl/ntCTOH2TzAlmeiRN8YFVTYkLbPyG3N8PpVt3Daoq03MD+ADs2yvngnR4u
         R2eVRvO6skWmZxIUrUhpJsP/YjcwJxNBnV7777fD4x3NvDGqbCNuS5gYsmDGHhiQloX0
         gRbmGBBmQ5ukeg1V7JHjFR7/RN2iyqx1L02rjhghKyScPT4mgAB+eTcwJe5Fgzk7cEPy
         LQonJzvwpzm2HCN19Yyr86BG/q6q6/u5pjBUlgLPSUPIuTWtLMTnEhNMKKA2U/PhuGDa
         HOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694454500; x=1695059300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hSkF4G7D+DMTQqfN/xQdy5YEnnHg545lD9jlBghqJY=;
        b=j6VJmI9Z47FF6gidiZSNtLneS3yqIHVjoLGbMC9ornR8yf8NhDLiUD5NcCM2xUoulz
         eSn++U8Xx7YAtYmoXQIinTlT1/qMtYFGPyEiEbtnqaqhQNCoj+nQOjAIab68LgCgi2ff
         YXa5iQObjHJAfYNa6G0bwXvp6382Wk3gy4msFpMSsPMuBbC17BUSArCWedKDUjQIpflH
         7mONHY810MTidYRMfit0Qsv2FxxEDCw4zalwKEOnsQ0WuztlKtbUmUzbb4nRD4EVKD1+
         pHJ74TWwKz4NfRv6/Enbpzzsa1bEjOebLY+ll1JBL7Fqr5Z3viIBIS7NrSEj2uvR6D4N
         N51w==
X-Gm-Message-State: AOJu0YzxpVsdtEE/Qk+CNACLSAzs298yUb8+bAnbnpGNzMYkGy+RlAnj
        +EbeDKxoKlkYmrBG0ElTA/PQwg==
X-Google-Smtp-Source: AGHT+IHwt6mnDFsT/FZeN9vv3psdxiwo8JNMZ/EaAjjHvHw9cN9CgvQ7wJOofon3lvpxgkdR7aaJqg==
X-Received: by 2002:a05:6358:4319:b0:13c:dd43:f741 with SMTP id r25-20020a056358431900b0013cdd43f741mr6184850rwc.24.1694454500466;
        Mon, 11 Sep 2023 10:48:20 -0700 (PDT)
Received: from maple.home ([142.114.20.193])
        by smtp.gmail.com with ESMTPSA id h4-20020a0cf204000000b0065160a2c8f0sm3075658qvk.138.2023.09.11.10.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:48:20 -0700 (PDT)
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: 
Date:   Mon, 11 Sep 2023 13:46:28 -0400
Message-Id: <20230911174628.262950-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 122610b072fcb44c7491eb5b9a59a221967ac99b Mon Sep 17 00:00:00 2001
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Mon, 11 Sep 2023 13:30:47 -0400
Subject: [PATCH] clk: renesas: r9a06g032: fix kerneldoc warning

This fixes the following W=1 warning during build:
> drivers/clk/renesas/r9a06g032-clocks.c:119: warning: Function parameter or member 'dual' not described in 'r9a06g032_clkdesc'

Added documentation for member 'dual'. Also added names for the other
structures in the same union, with documentation. Adjusted names of
members within the 'div' structure to avoid duplication.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309101314.kTRoxND5-lkp@intel.com/
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 64 ++++++++++++++------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 55db63c7041a..61296c81f9b5 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -102,19 +102,22 @@ enum gate_type {
  * @source:    the ID+1 of the parent clock element.
  *             Root clock uses ID of ~0 (PARENT_ID);
  * @gate:      clock enable/disable
- * @div_min:   smallest permitted clock divider
- * @div_max:   largest permitted clock divider
- * @reg:       clock divider register offset, in 32-bit words
- * @div_table: optional list of fixed clock divider values;
+ * @div:       substructure for clock divider
+ * @div.min:   smallest permitted clock divider
+ * @div.max:   largest permitted clock divider
+ * @div.reg:   clock divider register offset, in 32-bit words
+ * @div.table: optional list of fixed clock divider values;
  *             must be in ascending order, zero for unused
- * @div:       divisor for fixed-factor clock
- * @mul:       multiplier for fixed-factor clock
- * @group:     UART group, 0=UART0/1/2, 1=UART3/4/5/6/7
- * @sel:       select either g1/r1 or g2/r2 as clock source
- * @g1:        1st source gate (clock enable/disable)
- * @r1:        1st source reset (module reset)
- * @g2:        2nd source gate (clock enable/disable)
- * @r2:        2nd source reset (module reset)
+ * @ffc:       substructure for fixed-factor clocks
+ * @ffc.div:   divisor for fixed-factor clock
+ * @ffc.mul:   multiplier for fixed-factor clock
+ * @dual:      substructure for dual clock gates
+ * @dual.group: UART group, 0=UART0/1/2, 1=UART3/4/5/6/7
+ * @dual.sel:  select either g1/r1 or g2/r2 as clock source
+ * @dual.g1:   1st source gate (clock enable/disable)
+ * @dual.r1:   1st source reset (module reset)
+ * @dual.g2:   2nd source gate (clock enable/disable)
+ * @dual.r2:   2nd source reset (module reset)
  *
  * Describes a single element in the clock tree hierarchy.
  * As there are quite a large number of clock elements, this
@@ -131,13 +134,13 @@ struct r9a06g032_clkdesc {
 		struct r9a06g032_gate gate;
 		/* type = K_DIV  */
 		struct {
-			unsigned int div_min:10, div_max:10, reg:10;
-			u16 div_table[4];
-		};
+			unsigned int min:10, max:10, reg:10;
+			u16 table[4];
+		} div;
 		/* type = K_FFC */
 		struct {
 			u16 div, mul;
-		};
+		} ffc;
 		/* type = K_DUALGATE */
 		struct {
 			uint16_t group:1;
@@ -178,26 +181,26 @@ struct r9a06g032_clkdesc {
 	.type = K_FFC, \
 	.index = R9A06G032_##_idx, \
 	.name = _n, \
-	.div = _div, \
-	.mul = _mul \
+	.ffc.div = _div, \
+	.ffc.mul = _mul \
 }
 #define D_FFC(_idx, _n, _src, _div) { \
 	.type = K_FFC, \
 	.index = R9A06G032_##_idx, \
 	.source = 1 + R9A06G032_##_src, \
 	.name = _n, \
-	.div = _div, \
-	.mul = 1 \
+	.ffc.div = _div, \
+	.ffc.mul = 1 \
 }
 #define D_DIV(_idx, _n, _src, _reg, _min, _max, ...) { \
 	.type = K_DIV, \
 	.index = R9A06G032_##_idx, \
 	.source = 1 + R9A06G032_##_src, \
 	.name = _n, \
-	.reg = _reg, \
-	.div_min = _min, \
-	.div_max = _max, \
-	.div_table = { __VA_ARGS__ } \
+	.div.reg = _reg, \
+	.div.min = _min, \
+	.div.max = _max, \
+	.div.table = { __VA_ARGS__ } \
 }
 #define D_UGATE(_idx, _n, _src, _g, _g1, _r1, _g2, _r2) { \
 	.type = K_DUALGATE, \
@@ -1063,14 +1066,14 @@ r9a06g032_register_div(struct r9a06g032_priv *clocks,
 
 	div->clocks = clocks;
 	div->index = desc->index;
-	div->reg = desc->reg;
+	div->reg = desc->div.reg;
 	div->hw.init = &init;
-	div->min = desc->div_min;
-	div->max = desc->div_max;
+	div->min = desc->div.min;
+	div->max = desc->div.max;
 	/* populate (optional) divider table fixed values */
 	for (i = 0; i < ARRAY_SIZE(div->table) &&
-	     i < ARRAY_SIZE(desc->div_table) && desc->div_table[i]; i++) {
-		div->table[div->table_size++] = desc->div_table[i];
+	     i < ARRAY_SIZE(desc->div.table) && desc->div.table[i]; i++) {
+		div->table[div->table_size++] = desc->div.table[i];
 	}
 
 	clk = clk_register(NULL, &div->hw);
@@ -1333,7 +1336,8 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 		case K_FFC:
 			clk = clk_register_fixed_factor(NULL, d->name,
 							parent_name, 0,
-							d->mul, d->div);
+							d->ffc.mul,
+							d->ffc.div);
 			break;
 		case K_GATE:
 			clk = r9a06g032_register_gate(clocks, parent_name, d);
-- 
2.25.1

