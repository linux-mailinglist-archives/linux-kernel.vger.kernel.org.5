Return-Path: <linux-kernel+bounces-105141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A099287D998
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD221C20EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74E914F70;
	Sat, 16 Mar 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQ9d3b//"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B01012B79
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710581417; cv=none; b=XiCBe8ch5rnPyDWQ1rqJzWQD1E8SkkLvFla4GMGdlfNyMW9xeS4oE4oTjRkF9dUOH0kJhEyJ8+tkmO3vWTv4kxivozABQZLTpsHsEv4QL5Xuq31Cc6leX+AhTCE9ophmVurBAMil5N5yOEfq3amh6ZibzLdNDI4z1i/7so0fOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710581417; c=relaxed/simple;
	bh=3a6ZkGbC6qnjXSvnaDZPukV97lFmXpUpFjamuzvR7e4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LPpRDc4KEn/Ejtie/08AKsZ6GaYgEmMjBdJDrunL0gOIEMVCr7Ut5na8KW0zMIqBkivrXG4EEAJlWxhz3McOg6ULFFayJdTt89wDnRel9AYhHrG5sJXEeWPt+/7772vJSWJXJItUj2XCuByVSvPNAOS3R/f5DhNuVtQ0P/PbFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hQ9d3b//; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51381021af1so4098704e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710581413; x=1711186213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGUAB3UIw3E7EFrzYS72iNT6shEEycV/Wx4kFX1KU/c=;
        b=hQ9d3b//VyzUIh/rdiLQt7Jdf7l7DRhbvVjrM2jerO3K8r8lcPflktsdqZzAKdG2Gb
         r0uX1uPuTE3P2HGfIwI7PD91N/oo7N6LHth+E2FAfx0TBhaMusUhBjG/3l/T6T/BCqxU
         Gh3nHg0mX4Xl9KA6Bb89tgU90Lft241uyOtVmOzasW9D45XD/A+gHDGP0mnPPZWR7Yrg
         0wmrtvTwbmm63bHBWh9A4PbsXvGjEFiIegt82bZERiZRP0NGH6z7CKVHX+0BeS07NUDu
         hauV/Z7OpE/xAr+hnxaOkt27TWlLhBQ5iFR3rnY4oYKN7ivCOGGu0Vpz75gqWMA9diQ7
         2R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710581413; x=1711186213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGUAB3UIw3E7EFrzYS72iNT6shEEycV/Wx4kFX1KU/c=;
        b=qU7Anp/8Ofz2oMXRbAw0AZYWMS4ooBE7bprskwVvaspTrvR4Cam6Wl84TjqRYyasYJ
         NE9XlXa2ptX5Rz0eZIE/gzCIhuaIEiICtRf8inT0F2g3wwuCTVIGmqaZXd7dVnTpF+JA
         H3JlsATgE++U/AGI3CQbr3MbIGal/x1ZPLFHiiETtWWuoONOVoDnmWFhlwO0pxfnVJb3
         r053p8apVklxzcT3igNo/aw3GZsX+cgV/HSCxjHSxyYEPjdFlI0023FpCIA/nivrxjaK
         MKse+oa1Gm92UOScXLWQd71syptTusaFxIOwGp6vZK6fdAFZ4QJJXoFE36uo+K2jexbY
         hrSg==
X-Forwarded-Encrypted: i=1; AJvYcCWOzoQmtvHCGfl4ViDmVr/6hT/0U5Ey242WmddiwPQIxTfPCk9RV60fkC5wdWB8WKcLkRUtC71GZNZRFUBxu26ZVHxJfbeqsMwRQNAn
X-Gm-Message-State: AOJu0Yz6OvnYMqJ+d0T5Fjgcd6fmqE5l8lW6HIJ1T2EwTFeNkJJlfD+E
	DGCsqrCt+WOGJczyDZoW0i4gbmfgXHFkAhea9d6bHY9JoMqBXLCdAa/TdkYG4cY=
X-Google-Smtp-Source: AGHT+IHaVTRcQ6GSzZTIOX7uqn97na0aCbldg2yl3L19ISK8nvKzKRYsmj4GCGkP1PGTK3RRw+8UUw==
X-Received: by 2002:a19:914c:0:b0:513:c223:f0e4 with SMTP id y12-20020a19914c000000b00513c223f0e4mr1128678lfj.10.1710581413374;
        Sat, 16 Mar 2024 02:30:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b004132901d73asm8228520wmb.46.2024.03.16.02.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 02:30:13 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:30:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: 8250_lpc18xx: disable clks on error in probe()
Message-ID: <92646c10-e0b5-4117-a9ac-ce9987d33ce3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Goto the clean up path to clean up a couple clocks before returning
on this error path.

Fixes: 0087b9e694ee ("serial: 8250_lpc18xx: Switch to use uart_read_port_properties()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tty/serial/8250/8250_lpc18xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 7984ee05af1d..47e1a056a60c 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -151,7 +151,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 
 	ret = uart_read_port_properties(&uart.port);
 	if (ret)
-		return ret;
+		goto dis_uart_clk;
 
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.regshift = 2;
-- 
2.43.0


