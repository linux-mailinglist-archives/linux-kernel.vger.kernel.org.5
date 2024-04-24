Return-Path: <linux-kernel+bounces-157783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60038B1626
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1661F1C20FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414D16D32A;
	Wed, 24 Apr 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIs1tsG/"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAD19BDC;
	Wed, 24 Apr 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997586; cv=none; b=LmSiBGRzV9STNirPzIS654tLn8xzOvG4k5m/zNvnxLFwdN6s+0+jzg/LH/JTvYmgRmAilIjkYtnwKZCcYJ9tIPYWp4QSbz7/5Ze1GgA7GWcaKq6cMMiNAcSNy3y6XPkOgdZfFV3Uei3OAG4ih88CH0PaMwyuItMQh3vBn/QkuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997586; c=relaxed/simple;
	bh=kYSprDKt2ocCU0Du1HIsySgyKDzcYxzXurGCOXmZ1uM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SkgQqT+xmGZFznqfvrZcNtXSq50PZj/7KqO+nhVthuR/WE6ExuzhwDMzxmjJgurcp1lKkeY1kU3zgR1ZAJgwSaBqAiaFPKGpEQqkSC+iD/SqDUgiASV+ywnTctupCgZf1z2LlBZsyE2m8f7Asz+b/j/VBq5HwNYdYbB1Zc4HrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIs1tsG/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a05f376effso3488756d6.0;
        Wed, 24 Apr 2024 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713997584; x=1714602384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ym3VgXJbWcYcEe4KybsNIPr7idfeC5mrGPvyD3lUpGs=;
        b=CIs1tsG/pahpPBVmCEKkThJslTJCup/O2CfmzS72WzS4i5O6phJqHIHl/HngCecl+w
         XDy9U5/nR8QXaWuYGDZ2U6/ZjDDvTwqgo/7J0bYHwI52diFpgeAYArCMjaGjZkIZ+ctl
         FGjYWDMjVgdCw9Mfr7P0Og/dOrr0Uu3M4+J1ww3barnNuqpFQEIv9l73Fy7PtdlPq7zm
         QBWGMoNKE1nQS7noCLry6jKMMsZMVwtNgdpqBdngKx5G26Z4w3AjCdFdGGTjEstlKX5U
         +n460DPMRPPinMOz9vfGsC1KhVTdyt2g3SXIQQeqLHqvRuc4U1020pMITUU25KFjNFZn
         X+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997584; x=1714602384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ym3VgXJbWcYcEe4KybsNIPr7idfeC5mrGPvyD3lUpGs=;
        b=jSYHUVBsctNsCVq6CVooFrFt6na85+puQ57F258cCSHeo36Q3v3Wq7H3xbgse1l/MG
         AzQWOp1sQIrB5x2LZrwJGOvhJFIEZV5qdTFrn1ltjAWkPVRFKKlDpVds7XJLOmFqcCnT
         TNaQdUVQDvVD/RV5z0aJMfE2syY2Tg0tpwiI1CvhuPr6T+KjEiTysCxev9M+ZmRaC2fK
         u1jovAbDVceVwFFBk/UMGxgL7UE8Ji7c3y1w3M5Lq90yRUg8otbmLwCOQIxTUQ25uoL8
         1rNURjdjZ1zdyGhmJfl6oc+i0KI3QjTR9/TYFGk1yCYZNAI0DAj8KhLKZLi8bcK3S18U
         WSyg==
X-Forwarded-Encrypted: i=1; AJvYcCVThx/YlRPhGrgkIu5mcLCkN6RWQopxy4X90ZGej2muxoBVcHL/8ErFtN7yuc446lZdpI/ZgkKlcIJX9nu6i9pTR0iTVCaTKvmbdMdkAT+e5qqdMpj5v7DV9OuzffmwguUfCjF9ew2zFFdRBNqmJx2ULvYNqNM3wYqwBxFNqvdKl2+y
X-Gm-Message-State: AOJu0Yxh2i0vh5zAOhaufwTy/Pr+JByL+IcBWDR+X2gdEanizYtRMfzS
	Ur5r0db4b2O+COevlRYrGo93vFcpKEFIYr8jb48Snr41Re7VtqpI
X-Google-Smtp-Source: AGHT+IEN/eOmWKZtauJSE4F4dd5kc4I+58m1qeyQJ/7gAfOox+dXx4IJhkDrqvCUWvRqUWhtKTG3AA==
X-Received: by 2002:ad4:548c:0:b0:69f:793d:cade with SMTP id pv12-20020ad4548c000000b0069f793dcademr3983820qvb.19.1713997583805;
        Wed, 24 Apr 2024 15:26:23 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v15-20020a0c8e0f000000b0069b4ddcbd42sm5572591qvb.0.2024.04.24.15.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:26:23 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Al Cooper <alcooperx@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bcm-kernel-feedback-list@broadcom.com,
	Jiri Slaby <jirislaby@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: 8250_bcm7271: use default_mux_rate if possible
Date: Wed, 24 Apr 2024 15:25:59 -0700
Message-Id: <20240424222559.1844045-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a scenario when resuming from some power saving states
with no_console_suspend where console output can be generated
before the 8250_bcm7271 driver gets the opportunity to restore
the baud_mux_clk frequency. Since the baud_mux_clk is at its
default frequency at this time the output can be garbled until
the driver gets the opportunity to resume.

Since this is only an issue with console use of the serial port
during that window and the console isn't likely to use baud
rates that require alternate baud_mux_clk frequencies, allow the
driver to select the default_mux_rate if it is accurate enough.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
Changes in v2:
  Added "Cc: stable@vger.kernel.org"

 drivers/tty/serial/8250/8250_bcm7271.c | 101 +++++++++++++++----------
 1 file changed, 60 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index de270863eb5e..2569ca69223f 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -673,18 +673,46 @@ static void init_real_clk_rates(struct device *dev, struct brcmuart_priv *priv)
 	clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
 }
 
+static u32 find_quot(struct device *dev, u32 freq, u32 baud, u32 *percent)
+{
+	u32 quot;
+	u32 rate;
+	u64 hires_rate;
+	u64 hires_baud;
+	u64 hires_err;
+
+	rate = freq / 16;
+	quot = DIV_ROUND_CLOSEST(rate, baud);
+	if (!quot)
+		return 0;
+
+	/* increase resolution to get xx.xx percent */
+	hires_rate = div_u64((u64)rate * 10000, (u64)quot);
+	hires_baud = (u64)baud * 10000;
+
+	/* get the delta */
+	if (hires_rate > hires_baud)
+		hires_err = (hires_rate - hires_baud);
+	else
+		hires_err = (hires_baud - hires_rate);
+
+	*percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
+
+	dev_dbg(dev, "Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
+		baud, freq, *percent / 100, *percent % 100);
+
+	return quot;
+}
+
 static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 			u32 baud)
 {
 	u32 percent;
 	u32 best_percent = UINT_MAX;
 	u32 quot;
+	u32 freq;
 	u32 best_quot = 1;
-	u32 rate;
-	int best_index = -1;
-	u64 hires_rate;
-	u64 hires_baud;
-	u64 hires_err;
+	u32 best_freq = 0;
 	int rc;
 	int i;
 	int real_baud;
@@ -693,44 +721,35 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 	if (priv->baud_mux_clk == NULL)
 		return;
 
-	/* Find the closest match for specified baud */
-	for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
-		if (priv->real_rates[i] == 0)
-			continue;
-		rate = priv->real_rates[i] / 16;
-		quot = DIV_ROUND_CLOSEST(rate, baud);
-		if (!quot)
-			continue;
-
-		/* increase resolution to get xx.xx percent */
-		hires_rate = (u64)rate * 10000;
-		hires_baud = (u64)baud * 10000;
-
-		hires_err = div_u64(hires_rate, (u64)quot);
-
-		/* get the delta */
-		if (hires_err > hires_baud)
-			hires_err = (hires_err - hires_baud);
-		else
-			hires_err = (hires_baud - hires_err);
-
-		percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
-		dev_dbg(up->dev,
-			"Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
-			baud, priv->real_rates[i], percent / 100,
-			percent % 100);
-		if (percent < best_percent) {
-			best_percent = percent;
-			best_index = i;
-			best_quot = quot;
+	/* Try default_mux_rate first */
+	quot = find_quot(up->dev, priv->default_mux_rate, baud, &percent);
+	if (quot) {
+		best_percent = percent;
+		best_freq = priv->default_mux_rate;
+		best_quot = quot;
+	}
+	/* If more than 1% error, find the closest match for specified baud */
+	if (best_percent > 100) {
+		for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
+			freq = priv->real_rates[i];
+			if (freq == 0 || freq == priv->default_mux_rate)
+				continue;
+			quot = find_quot(up->dev, freq, baud, &percent);
+			if (!quot)
+				continue;
+
+			if (percent < best_percent) {
+				best_percent = percent;
+				best_freq = freq;
+				best_quot = quot;
+			}
 		}
 	}
-	if (best_index == -1) {
+	if (!best_freq) {
 		dev_err(up->dev, "Error, %d BAUD rate is too fast.\n", baud);
 		return;
 	}
-	rate = priv->real_rates[best_index];
-	rc = clk_set_rate(priv->baud_mux_clk, rate);
+	rc = clk_set_rate(priv->baud_mux_clk, best_freq);
 	if (rc)
 		dev_err(up->dev, "Error selecting BAUD MUX clock\n");
 
@@ -739,8 +758,8 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 		dev_err(up->dev, "Error, baud: %d has %u.%u%% error\n",
 			baud, percent / 100, percent % 100);
 
-	real_baud = rate / 16 / best_quot;
-	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", rate);
+	real_baud = best_freq / 16 / best_quot;
+	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", best_freq);
 	dev_dbg(up->dev, "Requested baud: %u, Actual baud: %u\n",
 		baud, real_baud);
 
@@ -749,7 +768,7 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 	i += (i / 2);
 	priv->char_wait = ns_to_ktime(i);
 
-	up->uartclk = rate;
+	up->uartclk = best_freq;
 }
 
 static void brcmstb_set_termios(struct uart_port *up,
-- 
2.34.1


