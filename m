Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102DF7C95EB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 20:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjJNSUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 14:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjJNSUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 14:20:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08598D6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:20:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso6455016a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697307610; x=1697912410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXvJpV0gpvSkUrAaGppJnbjeNlJABP+T2f/Ne1XnKTw=;
        b=RI+jY0sMHVhhAR+3ZdaRjXN+4ZDMvXXS+S9JzsDaLsLQC+SQkL1p+ILcmy2jvgi67H
         qNqgtC6DpPT7Aem17eCkKDUX5NgnXGYwRoSqn4NxaFEkLa2IsSZQ8AsP/VLICVueJhen
         fZCCmX/qjan5ZGlCAnBt3Bm+7TmpSgg9IEtmByH2+fOu8JKRnXl9DaLfLtH9AeMXVuU8
         +oh4s3E13nIQl+7diD0YmQQINVDWmtInZWKSuzV8DhGtNjqXX764ygZQKT3mg7Z+oDno
         Pl+THsy/XiDeuSPvN1EviOKtZYc3VpRLvl//WcurH+2lktVeC3D/g7ENO2x9hyhe4cUt
         tAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697307610; x=1697912410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXvJpV0gpvSkUrAaGppJnbjeNlJABP+T2f/Ne1XnKTw=;
        b=Cq2VfDbV/Bar/Ax8j+82EAEbyUkGnK1E5XNkN/sT9xkQGYuZxXgUhanP57KFwkL+sj
         2WUiyZDRXMQ62/EhBtpX5L2Ty66BS5yQGEYYJXP+GroZMRyPNEhpVikmXtstVmdB3NgH
         cBFUXTMyXuVYU45HV2/TJIV0Mpjk1bkMixXttBsLtC6XRxdJgmv6EJkuLftnBhf8tHdV
         ZTYurm5KcmqsgfYPyhURtFS0S43/aGOCDp6Xp5ycGug01vA54mBjufY6Kd2M8jQEJmsE
         ZFQaMOQqIyc8UTo22bOwHUFouDsrRzU9bDW72OvlQ8vADpLPqkO5GTySrt1rAakjNUEZ
         ypNQ==
X-Gm-Message-State: AOJu0YxXkdLrO2y+GiukRuOJHXr+xc+F55FWiffpvpCYWFf4XYmKTqL+
        KodYIlAuOiTwn1ioXzU7qqgafw==
X-Google-Smtp-Source: AGHT+IFpMPMxqmm1/q2aXFgzeolFogULQXPqEmGQ0Sn8Amf9QTXO64WJwphv1hY4vv8lNMCSYe1+fA==
X-Received: by 2002:a50:cd16:0:b0:53e:2309:fae with SMTP id z22-20020a50cd16000000b0053e23090faemr2918367edi.16.1697307610575;
        Sat, 14 Oct 2023 11:20:10 -0700 (PDT)
Received: from capella.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b005231e3d89efsm13032574edx.31.2023.10.14.11.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 11:20:09 -0700 (PDT)
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date:   Sat, 14 Oct 2023 20:19:43 +0200
Subject: [PATCH v4 3/3] clk: si5351: allow PLLs to be adjusted without
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231014-alvin-clk-si5351-no-pll-reset-v4-3-a3567024007d@bang-olufsen.dk>
References: <20231014-alvin-clk-si5351-no-pll-reset-v4-0-a3567024007d@bang-olufsen.dk>
In-Reply-To: <20231014-alvin-clk-si5351-no-pll-reset-v4-0-a3567024007d@bang-olufsen.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Introduce a new PLL reset mode flag which controls whether or not to
reset a PLL after adjusting its rate. The mode can be configured through
platform data or device tree.

Since commit 6dc669a22c77 ("clk: si5351: Add PLL soft reset"), the
driver unconditionally resets a PLL whenever its rate is adjusted.
The rationale was that a PLL reset was required to get three outputs
working at the same time. Before this change, the driver never reset the
PLLs.

Commit b26ff127c52c ("clk: si5351: Apply PLL soft reset before enabling
the outputs") subsequently introduced an option to reset the PLL when
enabling a clock output that sourced it. Here, the rationale was that
this is required to get a deterministic phase relationship between
multiple output clocks.

This clearly shows that it is useful to reset the PLLs in applications
where multiple clock outputs are used. However, the Si5351 also allows
for glitch-free rate adjustment of its PLLs if one avoids resetting the
PLL. In our audio application where a single Si5351 clock output is used
to supply a runtime adjustable bit clock, this unconditional PLL reset
behaviour introduces unwanted glitches in the clock output.

It would appear that the problem being solved in the former commit
may be solved by using the optional device tree property introduced in
the latter commit, obviating the need for an unconditional PLL reset
after rate adjustment. But it's not OK to break the default behaviour of
the driver, and it cannot be assumed that all device trees are using the
property introduced in the latter commit. Hence, the new behaviour is
made opt-in.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Jacob Siverskog <jacob@teenage.engineering>
Cc: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/clk/clk-si5351.c             | 47 +++++++++++++++++++++++++++++++++---
 include/linux/platform_data/si5351.h |  2 ++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index cbf7cde01157..bed0fe3bfa08 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -506,6 +506,8 @@ static int si5351_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct si5351_hw_data *hwdata =
 		container_of(hw, struct si5351_hw_data, hw);
+	struct si5351_platform_data *pdata =
+		hwdata->drvdata->client->dev.platform_data;
 	u8 reg = (hwdata->num == 0) ? SI5351_PLLA_PARAMETERS :
 		SI5351_PLLB_PARAMETERS;
 
@@ -518,9 +520,10 @@ static int si5351_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		(hwdata->params.p2 == 0) ? SI5351_CLK_INTEGER_MODE : 0);
 
 	/* Do a pll soft reset on the affected pll */
-	si5351_reg_write(hwdata->drvdata, SI5351_PLL_RESET,
-			 hwdata->num == 0 ? SI5351_PLL_RESET_A :
-					    SI5351_PLL_RESET_B);
+	if (pdata->pll_reset[hwdata->num])
+		si5351_reg_write(hwdata->drvdata, SI5351_PLL_RESET,
+				 hwdata->num == 0 ? SI5351_PLL_RESET_A :
+						    SI5351_PLL_RESET_B);
 
 	dev_dbg(&hwdata->drvdata->client->dev,
 		"%s - %s: p1 = %lu, p2 = %lu, p3 = %lu, parent_rate = %lu, rate = %lu\n",
@@ -1222,6 +1225,44 @@ static int si5351_dt_parse(struct i2c_client *client,
 		}
 	}
 
+	/*
+	 * Parse PLL reset mode. For compatibility with older device trees, the
+	 * default is to always reset a PLL after setting its rate.
+	 */
+	pdata->pll_reset[0] = true;
+	pdata->pll_reset[1] = true;
+
+	of_property_for_each_u32(np, "silabs,pll-reset-mode", prop, p, num) {
+		if (num >= 2) {
+			dev_err(&client->dev,
+				"invalid pll %d on pll-reset-mode prop\n", num);
+			return -EINVAL;
+		}
+
+		p = of_prop_next_u32(prop, p, &val);
+		if (!p) {
+			dev_err(&client->dev,
+				"missing pll-reset-mode for pll %d\n", num);
+			return -EINVAL;
+		}
+
+		switch (val) {
+		case 0:
+			/* Reset PLL whenever its rate is adjusted */
+			pdata->pll_reset[num] = true;
+			break;
+		case 1:
+			/* Don't reset PLL whenever its rate is adjusted */
+			pdata->pll_reset[num] = false;
+			break;
+		default:
+			dev_err(&client->dev,
+				"invalid pll-reset-mode %d for pll %d\n", val,
+				num);
+			return -EINVAL;
+		}
+	}
+
 	/* per clkout properties */
 	for_each_child_of_node(np, child) {
 		if (of_property_read_u32(child, "reg", &num)) {
diff --git a/include/linux/platform_data/si5351.h b/include/linux/platform_data/si5351.h
index c71a2dd66143..5f412a615532 100644
--- a/include/linux/platform_data/si5351.h
+++ b/include/linux/platform_data/si5351.h
@@ -105,10 +105,12 @@ struct si5351_clkout_config {
  * @clk_xtal: xtal input clock
  * @clk_clkin: clkin input clock
  * @pll_src: array of pll source clock setting
+ * @pll_reset: array indicating if plls should be reset after setting the rate
  * @clkout: array of clkout configuration
  */
 struct si5351_platform_data {
 	enum si5351_pll_src pll_src[2];
+	bool pll_reset[2];
 	struct si5351_clkout_config clkout[8];
 };
 

-- 
2.42.0

