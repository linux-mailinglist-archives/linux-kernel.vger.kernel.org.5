Return-Path: <linux-kernel+bounces-157773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA38B1603
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370B0284505
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93246165FC3;
	Wed, 24 Apr 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2rJnMIg"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFE1772F;
	Wed, 24 Apr 2024 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997016; cv=none; b=paQIfyd0r/Bmm6j/gOepSG+lXc0FVXB+vX9VElI/chh1WncinNksZYFrWyTolnGCfr/AzYyAHaZLbHQeUIhysqmQ2tDZR1VFZ4zh3mcOLQLA7xcW5WjZLRWhIOgKO4lXV7EV81x91RAsOOkkdC4PfSnKq0g6nGtmBerX+KYRFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997016; c=relaxed/simple;
	bh=/yLFzn2f7TzQB8zUF0y9sJy+jO37et3cW0yoOU8T9k8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cncRyKuFzUtO2nmpOqiqDaoNHeM2kO6ZYnUe2jJY+c5Df4u+62y0jdChwWQcY2yvtvnLCbYP35TrM8eB/r0SULsX6sr5kWZ5liIqzOxZnl/NplSwsL7/GRgXkRwlhGZ06GffGQIp0w2ismDvfg0y4D/EIM2ZTCRkU81tKI3aTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2rJnMIg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43716c1616dso2632041cf.2;
        Wed, 24 Apr 2024 15:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713997014; x=1714601814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6PS2pwOfBu3kj7Fmn59K60LPIRKsK3MY9Ejj2YtdjI=;
        b=K2rJnMIgRbkfibt+cMzhkpt7K4q70R2SnqXvAqF/H+5qN9YDVEJovN8oFu3kMT320g
         lrDp8Q7IF1yPFYywEed1lDJvMiX3m2zQV6APV3vta9iBYGZupD4WWyFGFTOuejkRXRwj
         vp/Y9U1V0ZYi8TXt48JVyPSPHAyM6XsMjKgcerSlV2L7UaNeS91yI4Xz8ZDO822/caqF
         /oG6fPoJMB/iryHicYIdzCe7GY2v8YrC0ExUjI3mJA78hCGWquI70kchqxJVQenT5Z54
         7vpI1lF+dAhUyQEaLU04yIv9Jg2ZjLqA44D3/T2AviHlLVnEcBBHAGSxXL8n3Xs2E+qf
         fXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997014; x=1714601814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6PS2pwOfBu3kj7Fmn59K60LPIRKsK3MY9Ejj2YtdjI=;
        b=p5linhvj1WkFY4+XKj/HzdXHH1oqZmnw/ZaDdidYNetF9F+1aoYVBMtJB3QMkHiuRx
         YdRforBVEGl396fP+eaOfHML9TMADu8Odi3GnYPHbf1fvV5GJeEtiZ7hUWLJ6xGndecx
         ZKwcdr07bbM4eeuxXp0G+jWEfVbEn7mMJccxVV4V+TRBfptFI2sWBbe6fOhBHbZVo3PY
         wL8/nHMrArQYUSXX13gbHUZcNCpAptkoNNcew7irHfNlVwIB6NbwnYP7uGCKGtQ0Veom
         xJcvFMvo/nrHgRp24e9hMxw/80aVZbASAsx+anv1OsPERH0dgdFsZ/h0LSVAZoRnMu8B
         OVVg==
X-Forwarded-Encrypted: i=1; AJvYcCVE9u0fhEYxRFvnoKgOrlH7vaEiQmgyF4oznDTZcSaFCcJvxz2HXVgcRooGg1WeSORQ+3AGoZDFmM9t+HDnqe7q9z1prqeltSBbiIEz8TJTLE1BzLejN6I8zpGpXgCGw8MaI/RYyEl0GmiE
X-Gm-Message-State: AOJu0YxVHmqnSavE0rCSI+vxULs1cfqtTsEVDz0n/lxUGZj+eKkeaELw
	9oX3KyGt1LQrM0kijeY+FAZOTqoeDR3pl08abRMVX1OTIWd1k3uF
X-Google-Smtp-Source: AGHT+IE0BMrTVL8aZCcSneN09lqvYXMx4Na7OUXXkHaYA2G9383ajw63HFXmbYbvv3JOvf5g4QHPOg==
X-Received: by 2002:a05:622a:20b:b0:431:5f79:6748 with SMTP id b11-20020a05622a020b00b004315f796748mr4257671qtx.51.1713997014061;
        Wed, 24 Apr 2024 15:16:54 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o14-20020ac841ce000000b00437a3bcc83asm6217997qtm.36.2024.04.24.15.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:16:53 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Al Cooper <alcooperx@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Jiri Slaby <jirislaby@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH] serial: 8250_bcm7271: use default_mux_rate if possible
Date: Wed, 24 Apr 2024 15:16:19 -0700
Message-Id: <20240424221619.1840014-1-opendmb@gmail.com>
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
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
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


