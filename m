Return-Path: <linux-kernel+bounces-45992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC418438E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AC4B26269
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B271660B92;
	Wed, 31 Jan 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtiVCS5/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15559140
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689507; cv=none; b=MzisS6XE/QtVwnu7viYJEBPgrFHsqZ7qwEgeHvWYAIO5g4lYZwT+zwfzev5z1AymezZ/LRTM/uaW4GNrpk3MoZGWeJ1PukImIrpCK+DeisJB1+T6JkPLqy5gQfOawiiklCkPPWvpjTAKHOFKs34p10jhhft0dJbODvnL3PqEXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689507; c=relaxed/simple;
	bh=m32rvnoHeDneErJtvFKjJCT1+v1UYtt13ihilo7pDBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sJ/J1slHNNBAK9/OS4jKcHkuswiEZFqmwQgDwOpW6dwp/KIufGvTaFPcbKexhRFjhSQ7xh5IAewuqinyI3GNUct3WD1BXb/htWf5pHWHDAWsiECD1I/90RFvw9CUzC5g4DHwZbbqLuPYLD2JMaRC5SPDqxgOaata2YV1WStIB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vtiVCS5/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so50321395e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689503; x=1707294303; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kjfr1JWWqOzBpF09vA5iofFwPy0q9GLVhIb7MB26bGk=;
        b=vtiVCS5/9LYvIczCo1dTkKjHd8K6tFOJ7jYfICwpunCl/BidSDeH/4ByXEujRI3E9Z
         345c3FzfjPkngk6Izs5/dIvCN4RRsZDUffL5aD5UhTGHT83RTMzI6TbfHWc5OvKgFr7z
         zB7gTmbfOqukmAhzw3VaWCdSV1h7hd+oJa+V4Vf6LhPe8vVRgt8fx4Ai3AmxyBeCwP/E
         m3XGHhgKq3fD+j+BN1g00cyKhi9yvH1VVJebaJ9dSY3wllWPI3Ult8TESpc1SvIqzkwM
         QM6OHMlBerwcVGKVLz7gWOL45juG7jJX9t0f1j+xxMFXHpYhKBUmXcUnUe584bg+UaOf
         4vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689503; x=1707294303;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjfr1JWWqOzBpF09vA5iofFwPy0q9GLVhIb7MB26bGk=;
        b=KNDmtp8/El8JeA2sV7YZRirVtosgVj8XKQdVqKMn8YWf+j1zpLJ2eq3kwJ+Hvg1iaq
         88TRaR8pmy0u9dnuJbu01haXMauOpPnLQfh7qTU7BHBfuFGG+f17TnoBagCdxHn/HXqI
         RIFk60VGdj2pGrMyu2xS5P2+OfNmPx3zDT4BDHLiZ4595Su3iL8xm5CpqjjelH8RpLJg
         MVqu2HaymOFYPvrzn+oVzvb+yFgOygedMTIHVwmayNH7HZ5pFDJrbUsVzZL4Rdqw0hos
         J1fuhp1vOULEmlbcyiyZT20gtKYeAN17i1pB81ZSJ2FzsgsyNxKzqDMTeVMiP/2chzh9
         2+3w==
X-Gm-Message-State: AOJu0Yz9fuISid7MNkdEO5DMw46vD4vrkwYR6LKkdjTcVYvrta3HX30+
	ivRb8b/ISfZ0ENM37MkcoKSCTEk65jmUo976sxUgn0KXOI/cnj9c/ByfH2IW8zU=
X-Google-Smtp-Source: AGHT+IHoltuxoKIeHVVpKUMTvfTCftXaiHZYAChZuYJHWMkSt7h0Ajid41fYMtToV3jNL4hkgTJq/g==
X-Received: by 2002:a05:6000:118f:b0:337:b9ac:97f6 with SMTP id g15-20020a056000118f00b00337b9ac97f6mr554324wrx.55.1706689503559;
        Wed, 31 Jan 2024 00:25:03 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id ch19-20020a5d5d13000000b00337b47ae539sm12799999wrb.42.2024.01.31.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:25:03 -0800 (PST)
Date: Wed, 31 Jan 2024 11:24:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: 8250_pci1xxxx: partially revert off by one patch
Message-ID: <bd6fb361-bbb9-427d-90e8-a5df4de76221@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

I was reviewing this code again and I realized I made a mistake here.
It should have been > instead of >=.  The subtract ensures that we
don't go out of bounds.  My patch meant that we don't read the last
chunk of the buffer.

Fixes: 86ee55e9bc7f ("serial: 8250_pci1xxxx: fix off by one in pci1xxxx_process_read_data()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Sorry about that.  The other part of my fix was correct though...

 drivers/tty/serial/8250/8250_pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 5cf0580f21cd..356972734b29 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -330,7 +330,7 @@ static void pci1xxxx_process_read_data(struct uart_port *port,
 	 * to read, the data is received one byte at a time.
 	 */
 	while (valid_burst_count--) {
-		if (*buff_index >= (RX_BUF_SIZE - UART_BURST_SIZE))
+		if (*buff_index > (RX_BUF_SIZE - UART_BURST_SIZE))
 			break;
 		burst_buf = (u32 *)&rx_buff[*buff_index];
 		*burst_buf = readl(port->membase + UART_RX_BURST_FIFO);
-- 
2.43.0


