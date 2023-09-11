Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09E79ACF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbjIKVND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbjIKRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:52:45 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C999DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:52:40 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-655d1cf74faso19152156d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694454759; x=1695059559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSGb/bzAvx1o0jtUr8Ii5AAazodLa4hyLaXmw0np69Y=;
        b=DhEAam3BbR9XCuHzV3Zk9FzTUJlqSqrwI/VgC26QJ1qEZ+ltAQFtmJZVhlsux6Amb+
         3irAQup6LLL18AKJh/CoevutGZU/gFtiDZ6JDlusAuLEZvB5qZxQdpig9O4gDOJB7NSb
         p6xiYUzkRdd0OLaaRNuSFoe2VZM5kwx7/U483MFtvVFhbDGwuf7zJA/OpbW01QlQpmYf
         nZkvn9jSEhO5rjM6dU/KCd9driHN4I8/vLB1X2PZMy+LnIPEYtQgXWj2ozzg6qrWC1/H
         /kBqE2nM7RGXg3k6jz6JnoeYU1YyA4VAxslMASAwJCRPVGCHLNICHfZCDENFxkPJISXH
         TUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694454759; x=1695059559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSGb/bzAvx1o0jtUr8Ii5AAazodLa4hyLaXmw0np69Y=;
        b=uPoDa+/IYBDLZiqlnLwXDii3eIN9qI7STSbCzioac/kmpaQhdLKeRHjEnEf7QAMGRn
         kXprSDGlkp+S0Yfd1JPnnl8NPTKs3tDPKL8mifxWHWk0T6vOFcyi1rTcDOxzyLMi7NZy
         RpoPdvk9b1bbi/4Bud9VrWW58OVSD8g10+XrpV0A7S9Zv2cKY3sfgxhazMN1/9EjD72i
         Bz/1yxydMYpm/+XKT1gPiV632ZoSyCUaTJ3HgObrlC1Ocojy6FkuXZlTMdyJFNILXivi
         ucLqax1NPYqoJW9y0mR6b4xXc0DbhnmPGp6cJSSYgqUbWiM+sKuG1x0K14DGlF+t34DN
         p7Ew==
X-Gm-Message-State: AOJu0YyQ47pmX+FBCi0frF8lY2WUttNd0Eogm1uLO0kwWUPfdxBUdgiM
        I5f+YtVb+v8LGaPN4bu0948bSg==
X-Google-Smtp-Source: AGHT+IG65tLFaGRoRMpgzKk0ogF2TeonEdlTNo/aDVlOmsA1gbxv+nd8ZS7QwN4rpf1idWUNGwTTbA==
X-Received: by 2002:a0c:d610:0:b0:649:bf3:6dbe with SMTP id c16-20020a0cd610000000b006490bf36dbemr9680030qvj.62.1694454759379;
        Mon, 11 Sep 2023 10:52:39 -0700 (PDT)
Received: from maple.home ([142.114.20.193])
        by smtp.gmail.com with ESMTPSA id s17-20020a0ca611000000b006431027ac44sm3118898qva.83.2023.09.11.10.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:52:38 -0700 (PDT)
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: renesas: r9a06g032: fix kerneldoc warning
Date:   Mon, 11 Sep 2023 13:52:15 -0400
Message-Id: <20230911175215.263009-1-ralph.siemsen@linaro.org>
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

This fixes the following W=1 warning during build:
> drivers/clk/renesas/r9a06g032-clocks.c:119: warning: Function parameter or member 'dual' not described in 'r9a06g032_clkdesc'

Added documentation for member 'dual'. Also added names for the other
structures in the same union, with documentation. Adjusted names of
members within the 'div' structure to avoid duplication.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309101314.kTRoxND5-lkp@intel.com/
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Second post, as the Subject: line accidentally got messed up previously.

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

