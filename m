Return-Path: <linux-kernel+bounces-79586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5567386247F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FDF1F22F55
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E9825756;
	Sat, 24 Feb 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnITihWZ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08425565;
	Sat, 24 Feb 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774153; cv=none; b=UASbM7ixlcXLnMRdW7fuBnLYL+t8UeW/RNsyA84KKj8BtsyfE2ObPEGBDjDmTApRRquuQtBDSnG4R9oo0B90hOWwHEQRRcHmsMbfYOzGq7YEQGxJNHrQArkFb5kZsMF27r1FOAO6v1YHtwtgoDOX5v3pHuPjSduX6bQJ+O32uhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774153; c=relaxed/simple;
	bh=8Wmjz1P/B2yK+9hfRLUJbl27WLHSx0xp5D2G5Vt/aLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnZMXaRHeBCNxS7Yc6ETRsaw/ESC+XYbSdeBa25rt8sRkrNUoA5aEouB4ooFHmXc2hfU5wW1pK0IYA6NaYBj8FRNOAXyiu3BXrrZzBnzm5yXP9TJtm/gIosfkeyxLS6BrMe9w2X78aposIxShpN5daR3V1uOeyDFi/fYlX7fNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnITihWZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3566c0309fso151004666b.1;
        Sat, 24 Feb 2024 03:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708774149; x=1709378949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYAho2X90qK7tOrS84lGLoReElvfwN9Vc1VtqG59PbA=;
        b=lnITihWZyVM8tLIkUE552jG2HVHhER9n8blbPFNfDqHIRArSD31rH1VUaeD2BGP+aB
         MYCU0lpg5ObZ7e9Odmw3+4MyqCvC5TnNR2xEj/I+fyAMaYaoLvyR5nrf/uuL4DhLlnUX
         P7z6BjIE0KwWmLCsrs3StImyToOgueBvXALM5r5mPk9OscdNkTkgeaF45zsTvubB5iC5
         L9oil7N8OBZ3NQ1VSsf3irRrhBtw0Ve/YfT1bEsew+99KzImf4vAkvC48oNXAezu9vkA
         +l8gZ/+cAoERGQCuSML/5dh4yHjFcvDyx9BX81Da/t8bSMljF551lqUOLj8mWXHtxczT
         ZaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774149; x=1709378949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYAho2X90qK7tOrS84lGLoReElvfwN9Vc1VtqG59PbA=;
        b=TMxtfKDXdyxTeUws2tbzoF2dBk3s0bLfQYfxj3ZsZgjDLTjk9XG5nHhivOKpLb4248
         V4Wa66/B3/bp+ZMv5z5wICxXu034ITixqk4YHZ3TJR+RuD3LViAYriK+AtMJjIxKouWQ
         yZqv1jUYoGOrG1FyIqxF5iJFNBXJMB/2txXLh+Zw5vvPvsrw0kdteEZIZe5ScuHde3HP
         oZ819OHJkx9dYp0v361oh1EnuRrf9vte1F+lOAE1+TVsde6Nk23zghZsT9arOsHgC4sc
         aCRRnPJaV9X1zSRLXoaEPphHSfsiKcADbKzjsT1/fGQcQ+qUNklcCu+ToPgtkiWZhHbn
         e2FA==
X-Forwarded-Encrypted: i=1; AJvYcCXk8BUpE9hlgWDNJvZn9gN+3O5Jf6z6IjBt9l1+VJcG6P7G7pX2XP8cK7PMUIk3FHjsb9KVaNoUArATyZv59ZxFscfmkwvJ5LQ99nDIFhyeAWzarl3R/64maXwsftSeFZF2cEuX1UZR
X-Gm-Message-State: AOJu0Yy/kBt3CxUuuOgd+vUuejBWyH1thI0yJaRDycKAuby8J5VdS8hZ
	2xEA8FgG8IwF63/h9UHu4psfvbTaAjLQkKgNpqQuUiNKTF+lksCsBJpqku1HmNI=
X-Google-Smtp-Source: AGHT+IFcZLVXuxBLLhhHFucSHV65YF5jlbWZN8OnRT43E3B5IERyuxH8H2URJWvmWc9ECMJuLJGqQg==
X-Received: by 2002:a17:906:2b05:b0:a40:65ea:61 with SMTP id a5-20020a1709062b0500b00a4065ea0061mr1475681ejg.46.1708774148756;
        Sat, 24 Feb 2024 03:29:08 -0800 (PST)
Received: from localhost.localdomain (p5dc68d61.dip0.t-ipconnect.de. [93.198.141.97])
        by smtp.gmail.com with ESMTPSA id s1-20020a170906060100b00a3d9e6e9983sm507181ejb.174.2024.02.24.03.29.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Feb 2024 03:29:08 -0800 (PST)
From: Leif Middelschulte <leif.middelschulte@gmail.com>
X-Google-Original-From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] pwm: imx27: fix race condition .apply,.get_state
Date: Sat, 24 Feb 2024 12:29:00 +0100
Message-Id: <20240224112902.55539-1-Leif.Middelschulte@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
References: <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/pwm/pwm-imx27.c | 55 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7d9bc43f12b0..cb564460b79c 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -75,6 +75,7 @@
 						   (x)) + 1)
 
 #define MX3_PWM_SWR_LOOP		5
+#define MX3_PWM_FIFOAV_EMPTY_LOOP	4
 
 /* PWMPR register value of 0xffff has the same effect as 0xfffe */
 #define MX3_PWMPR_MAX			0xfffe
@@ -118,6 +119,31 @@ static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
 	clk_disable_unprepare(imx->clk_ipg);
 }
 
+static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
+				     struct pwm_device *pwm)
+{
+	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
+	struct device *dev = chip->dev;
+	unsigned int period_ms = DIV_ROUND_UP_ULL(pwm->state.period, NSEC_PER_MSEC);
+	int tries = MX3_PWM_FIFOAV_EMPTY_LOOP;
+	int fifoav, previous_fifoav = INT_MAX;
+	u32 sr;
+
+	while (tries--) {
+		sr = readl(imx->mmio_base + MX3_PWMSR);
+		fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
+		if (fifoav == MX3_PWMSR_FIFOAV_EMPTY)
+			return 0;
+		/* if the FIFO value does not decrease, there is another problem */
+		if (previous_fifoav == fifoav)
+			break;
+		previous_fifoav = fifoav;
+		msleep(period_ms);
+	}
+
+	return -EAGAIN;
+}
+
 static int pwm_imx27_get_state(struct pwm_chip *chip,
 			       struct pwm_device *pwm, struct pwm_state *state)
 {
@@ -161,10 +187,35 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
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
+		ret = pwm_imx27_wait_fifo_empty(chip, pwm);
+		if (ret)
+			return ret;
 		val = readl(imx->mmio_base + MX3_PWMSAR);
-	else
+	} else {
 		val = imx->duty_cycle;
+	}
 
 	tmp = NSEC_PER_SEC * (u64)(val) * prescaler;
 	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, pwm_clk);
-- 
2.39.3 (Apple Git-145)


