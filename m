Return-Path: <linux-kernel+bounces-40940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B02DA83E88A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41529B22660
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CE83D75;
	Sat, 27 Jan 2024 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmrEkJ7f"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DB7F0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315829; cv=none; b=hXyB6f6Ul6xwMYIrpj489O8ou1pIHq9b8pV8NNa1DPdDDnLNjcl8WzxhdcMu9xhqUzxmo/5JdXFeizxg1l5Tc286H7DVXH7Y23yWITMe0ARv9SXEPO2hGCxJ7xtcUJtE6PsxeBHcRJsTEjSWmRqSf/13ZjmjMlczA8Q55pJgjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315829; c=relaxed/simple;
	bh=rzK2gsXIFXMN1iIdN0KgaFNnktatZIe6QYPzL8EVCkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slLooH1EUlshwcH5ILJm75hPZKbe5r05XozTa4BuEZdl5g6Z0ddlWLyiqZWOJFWhHU4UCsTyQ6AaKkPCwSrqud83o5jw0iMVauG7JauNJtadE+bL30UH8JpjMPBR60a7A9ei7K7/h6SaV48tAV9j7PgvNu97Ijv7lgRr2xZsj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wmrEkJ7f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so17130305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706315825; x=1706920625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTtyOoMvI5/Gh43pPNKlry47E9NXmSJ8tqA/H0tsxRY=;
        b=wmrEkJ7faNowhsrvvP/1ZLLy0JxwSO4c6O0IGy+JE8xG1vMD6y6lMDt2neYy6qrOOx
         CNUATPSezNk08n7y7V4xdXzcJsTjw1d75rSlJLjamfzqpU2URhX8bKQkmgKu0X6jnnpv
         pxDF/+OpAmvhDFsRi6XapsOs3DNgCw8aeBLQbTSoMVYBA6whjrEEDwVcMEYb5inSdb9k
         gsqr54N1kR00svK4USFn6Ghwx5YzXKTbb18Jr5tWVhtiI3ssbUI1c0Mxqw/q4ek58v2m
         yhDbcpPdzauY8Rk47V+WogdQl2S4OZhPzF5Y8oXrGzLfroog5X7yZq+tcrb2f/J1yly2
         N6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706315825; x=1706920625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTtyOoMvI5/Gh43pPNKlry47E9NXmSJ8tqA/H0tsxRY=;
        b=DKx4mpJKU8EdFRM88TxPgMN+70SkcbdD+Y2H2vhCL3nfRaLd04VJWdC7ubzo3/P56m
         vrJenLHdH+hxQTF620rAyL5YoIQiV9N8ji8qFwN8Tkv3daGyOWXJXaQTBlfuoYVlvBcT
         j56y97lScnpGVmMR8hk27Tgcw4UHJfCNZPmiFBu3T0csX7XbQ297jQ/2y7l9KSuCazmF
         6Z3lU9F2O+0cifpD8nWxzi7pmqqDzN7D/QiIqq2Xx9/Piq11mUrs7FetHNR+P5LhIx1W
         O05COChnel4djNWz2pwZ549ym3q+DsI3AN2eWP9/RsRiZG7HBmG47lGDgqDPcivnx9db
         Qa5A==
X-Gm-Message-State: AOJu0Yz+J5UzrE7RQ1vqgkVw4MJ7zJ9yPLwUnM6gpcodDDksMVApcQc8
	Cw+2bMl8iAvRSHSLoLaQ0bJYOGeRifh7ku7Z5lFMxApBpeEl4H5F+uUxT1u6Ht0=
X-Google-Smtp-Source: AGHT+IEqhBCkPxBNM5yN/bsGN5bmEvcY2rByUECx6W6OGKyFKLAR68SPfXkpZIRtnmsO6KTR1r2mtA==
X-Received: by 2002:a05:600c:a03:b0:40e:b107:9e16 with SMTP id z3-20020a05600c0a0300b0040eb1079e16mr394989wmp.230.1706315825219;
        Fri, 26 Jan 2024 16:37:05 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id vi1-20020a170907d40100b00a2f48a43c3esm1152235ejc.7.2024.01.26.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:37:04 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/5] clk: samsung: gs101: gpio_peric0_pclk needs to be kept on
Date: Sat, 27 Jan 2024 00:35:50 +0000
Message-ID: <20240127003607.501086-2-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240127003607.501086-1-andre.draszik@linaro.org>
References: <20240127003607.501086-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This pclk clock is required any time we access the pinctrl registers of
this block.

Since pinctrl-samsung doesn't support a clock at the moment, we just
keep the kernel from disabling it at boot, until we have an update for
pinctrl-samsung to handle this required clock, at which point we'll be
able to drop the flag again.

Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 4a0520e825b6..61bb0dcf84ee 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -2848,7 +2848,7 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_PERIC0_GPIO_PERIC0_PCLK,
 	     "gout_peric0_gpio_peric0_pclk", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_GPIO_PERIC0_IPCLKPORT_PCLK,
-	     21, 0, 0),
+	     21, CLK_IGNORE_UNUSED, 0),
 	/* Disabling this clock makes the system hang. Mark the clock as critical. */
 	GATE(CLK_GOUT_PERIC0_LHM_AXI_P_PERIC0_I_CLK,
 	     "gout_peric0_lhm_axi_p_peric0_i_clk", "mout_peric0_bus_user",
-- 
2.43.0.429.g432eaa2c6b-goog


