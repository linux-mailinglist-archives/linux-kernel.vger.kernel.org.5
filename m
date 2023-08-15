Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8696677CB46
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbjHOKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjHOKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:43:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764D199F;
        Tue, 15 Aug 2023 03:43:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so715392366b.2;
        Tue, 15 Aug 2023 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692096220; x=1692701020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izO0tZzm3QLcY+sUcTdrcBNTqHL831hXZtp+UuXI19g=;
        b=S/WIormd94u7em4MZjGUFv8zIwrpEoyaTwbXs+rlOhpgq4lFQBYGWilNdyZiFCd4Oc
         eOLIju7rRkIgqloXyVFSdcUj5Fet4XAXLWf/7HGUbx/mpqg9SPLBmLwacuef15Ave6vA
         38hQUkZ+qKOk6WyPOMqa1fT3LKDNkA/iJpX6PjCOD/ALXzJwxiE8aPATuzpZbMtD8Rki
         R7ny3A6XVRQJ/So0+CZeN9VaIBVW0YaNNOsmJOaDrEmScgJW60fcx7J4Zvrvq3hFUW+3
         /P8y+PVV07Ngfevc0la8N3s3oWjrSqFpsaRcdH2PQmpn9JFYyN+Uw7vyq0hrD6Iqi9y1
         e+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692096220; x=1692701020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izO0tZzm3QLcY+sUcTdrcBNTqHL831hXZtp+UuXI19g=;
        b=YGy8PTlz8xEEUsjR5EAVXbXT9LXTxGZO7zCPGdW4viwAJsADYyzmYFyhs9HByzf1Ql
         K+R25+ZjaRS3tabJXCCb3Hh6IMLCpAo8xEG38HpFlNgtHkVtCCMwzO1RiniqiRSPXmQ1
         ULep5M8kZCoPNOQjoVEj5l10ATLK26FiknXu9t2PNR1GF7IyM6Pm1AEvEeQBB7NGoaD2
         2CN+p07VPJlzdgBPOBsji/nm0cyF/AfiSqQC4W5WVopifynWc6Wox0ho8o3naf1H1HZX
         ZpKfldVRenCVna+cWgeySWjQZJpocHnBChQ/5R0m339zVRIpUNYjj/BfpoS7RmkjCTaH
         PWCA==
X-Gm-Message-State: AOJu0YxGNg/sEPo0N6cddQIS6CiwEBePcOZ6w/ju9f8iIuFINJI50l64
        ceRQ1yFzrOAGAUnLSwoza6U=
X-Google-Smtp-Source: AGHT+IEjn0TgKyCUAw/r/ZD1Yio4oGXG55KLp3wwLdcgB2uGZ7G7CxI+L1GmvoL+wV+Z6boGgz3n0g==
X-Received: by 2002:a17:906:20d7:b0:99b:c949:5ef8 with SMTP id c23-20020a17090620d700b0099bc9495ef8mr10187701ejc.54.1692096220330;
        Tue, 15 Aug 2023 03:43:40 -0700 (PDT)
Received: from localhost.localdomain (pd9e9e2b1.dip0.t-ipconnect.de. [217.233.226.177])
        by smtp.gmail.com with ESMTPSA id md15-20020a170906ae8f00b0098d486d2bdfsm6944627ejb.177.2023.08.15.03.43.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Aug 2023 03:43:39 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
X-Google-Original-From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] pwm: imx27: fix race condition .apply,.get_state
Date:   Tue, 15 Aug 2023 12:43:29 +0200
Message-Id: <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
References: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>

With CONFIG_PWM_DEBUG=y after writing a value to the PWMSAR
register in .apply(), the register is read in .get_state().
Unless a period completed in the meantime, this read yields the
previously used duty cycle configuration. As the PWM_DEBUG code
applies the read out configuration for testing purposes this
effectively undoes the intended effect by rewriting the previous
hardware state.

Note that this change merely implements a sensible heuristic.
The i.MX has a 4 slot FIFO to configure the duty cycle. This FIFO
cannot be read back in its entirety. The "write x then read back
x from hw" semantics are therefore not easily applicable.
With this change, the .get_state() function tries to wait for some
stabilization in the FIFO (empty state). In this state it keeps
applying the last value written to the sample register.

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
---
 drivers/pwm/pwm-imx27.c | 50 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 29a3089c534c..32389ca2da3e 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -75,6 +75,7 @@
 						   (x)) + 1)
 
 #define MX3_PWM_SWR_LOOP		5
+#define MX3_PWM_FIFOAV_EMPTY_LOOP	4
 
 /* PWMPR register value of 0xffff has the same effect as 0xfffe */
 #define MX3_PWMPR_MAX			0xfffe
@@ -118,8 +119,28 @@ static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
 	clk_disable_unprepare(imx->clk_ipg);
 }
 
+static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
+				     struct pwm_device *pwm)
+{
+	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
+	struct device *dev = chip->dev;
+	unsigned int period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm), NSEC_PER_MSEC);
+	int tries = MX3_PWM_FIFOAV_EMPTY_LOOP;
+	int fifoav;
+	u32 sr;
+
+	while (tries--) {
+		sr = readl(imx->mmio_base + MX3_PWMSR);
+		fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
+		if (fifoav == MX3_PWMSR_FIFOAV_EMPTY)
+			return;
+		msleep(period_ms);
+	}
+	dev_warn(dev, "FIFO has been refilled concurrently\n");
+}
+
 static int pwm_imx27_get_state(struct pwm_chip *chip,
-			       struct pwm_device *pwm, struct pwm_state *state)
+				struct pwm_device *pwm, struct pwm_state *state)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	u32 period, prescaler, pwm_clk, val;
@@ -161,10 +182,33 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
 	 * use the cached value.
 	 */
-	if (state->enabled)
+	if (state->enabled) {
+		/*
+		 * From the i.MX PWM reference manual:
+		 * "A read on the sample register yields the current FIFO value that
+		 *  is being used, or will be used, by the PWM for generation on the
+		 *  output signal. Therefore, a write and a subsequent read on the
+		 *  sample register may result in different values being obtained."
+		 * Furthermore:
+		 * "When a new value is written, the duty cycle changes after the
+		 *  current period is over."
+		 * Note "changes" vs. "changes to the given value"!
+		 * Finally:
+		 * "The PWM will run at the last set duty-cycle setting if all the
+		 *  values of the FIFO has been utilized, until the FIFO is reloaded
+		 *  or the PWM is disabled."
+		 * Try to be at least a bit more deterministic about which value is
+		 * read by waiting until the FIFO is empty. In this state the last/most
+		 * recently pushed sample (duty cycle) value is continuously applied.
+		 * Beware that this approach is still racy, as a new value could have
+		 * been supplied and a period expired between the call of the wait
+		 * function and the subsequent readl.
+		 */
+		pwm_imx27_wait_fifo_empty(chip, pwm);
 		val = readl(imx->mmio_base + MX3_PWMSAR);
-	else
+	} else {
 		val = imx->duty_cycle;
+	}
 
 	tmp = NSEC_PER_SEC * (u64)(val) * prescaler;
 	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, pwm_clk);
-- 
2.39.2 (Apple Git-143)

