Return-Path: <linux-kernel+bounces-163954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07B28B7687
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67591F224D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98335171664;
	Tue, 30 Apr 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="d65giP2e"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C217106E;
	Tue, 30 Apr 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482003; cv=none; b=TAKNOgjaEERYmmhhDwurqsd9xJj7pd+3U30kl0VZq50eC4v1e/TMtCW7UGFOYEbr+Brr0j45D5vtlbM5TQKSr6zE3AeZJ7XfKiMSsTJSePmSrcU4pSIA2UDfbN1fXmvt0oIti2NN5EAP/pX94kQmbPFJADhAiTVOT0qgU9arbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482003; c=relaxed/simple;
	bh=UMZaNGe7QnAugACQXwrO9a+rEKCYn71GJR5PuFqiQdg=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=BK9MuBseGKb/1DN+VxWE34p6x6icJIRf/xpjMLjaozlItFG2zUm6zETJuwRhl+mPwk5U722LzCJ0xXnqwooRRkAVq25g28GKQNFn5jYHFEFMkbyvp75dvd+JlHyYKtDnnYd4jtJeOuZ4uks1cJZLOPD6WeQP6lY4Jco6Bsc5y/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=d65giP2e; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=M/QoApjdCuoD3z41eYPaP9f9N+N5yYGGcDa+/3o9sWU=; b=d65giP2esg8toD56CmvT0uTjbv
	m36EyH9rtwY/ivUSbLbcLqQC5qKri6fJNKOix9G3HkHgHxFsSkYaTcDa+KNKSGKcNLW+d078SAAP0
	5btBeS9yQ6r8pLX+TdzRGKDu+zdSi7u+CcOrA+c+0vETqX6UKPUMjjiHLsyz9+CSh4Fo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54324 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1s1n5P-00038o-6Y; Tue, 30 Apr 2024 08:59:55 -0400
Date: Tue, 30 Apr 2024 08:59:54 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Ringle
 <jringle@gridpoint.com>, ria.freelander@gmail.com, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-Id: <20240430085954.1ac828e0d2c64cccdf47bdfc@hugovil.com>
In-Reply-To: <af116cb5-41d8-4a33-97ba-0c7cc821add1@kernel.org>
References: <20240426135937.3810959-1-hugo@hugovil.com>
	<17d2cc58-cf68-430d-9248-25abe4c5b0f0@kernel.org>
	<20240429094717.de45ad35814e3c618e08c36b@hugovil.com>
	<af116cb5-41d8-4a33-97ba-0c7cc821add1@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.1 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when
 using prescaler
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 30 Apr 2024 07:22:54 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 29. 04. 24, 15:47, Hugo Villeneuve wrote:
> > On Mon, 29 Apr 2024 08:39:22 +0200
> > Jiri Slaby <jirislaby@kernel.org> wrote:
> > 
> >> On 26. 04. 24, 15:59, Hugo Villeneuve wrote:
> >>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >>>
> >>> When using a high speed clock with a low baud rate, the 4x prescaler is
> >>> automatically selected if required. In that case, sc16is7xx_set_baud()
> >>> properly configures the chip registers, but returns an incorrect baud
> >>> rate by not taking into account the prescaler value. This incorrect baud
> >>> rate is then fed to uart_update_timeout().
> >>>
> >>> For example, with an input clock of 80MHz, and a selected baud rate of 50,
> >>> sc16is7xx_set_baud() will return 200 instead of 50.
> >>>
> >>> Fix this by first changing the prescaler variable to hold the selected
> >>> prescaler value instead of the MCR bitfield. Then properly take into
> >>> account the selected prescaler value in the return value computation.
> >>>
> >>> Also add better documentation about the divisor value computation.
> >>>
> >>> Fixes: dfeae619d781 ("serial: sc16is7xx")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >>> ---
> >>>    drivers/tty/serial/sc16is7xx.c | 23 ++++++++++++++++++-----
> >>>    1 file changed, 18 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> >>> index 03cf30e20b75..dcd6c5615401 100644
> >>> --- a/drivers/tty/serial/sc16is7xx.c
> >>> +++ b/drivers/tty/serial/sc16is7xx.c
> >>> @@ -555,16 +555,28 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
> >>>    	return reg == SC16IS7XX_RHR_REG;
> >>>    }
> >>>    
> >>> +/*
> >>> + * Configure programmable baud rate generator (divisor) according to the
> >>> + * desired baud rate.
> >>> + *
> >>> + * From the datasheet, the divisor is computed according to:
> >>> + *
> >>> + *              XTAL1 input frequency
> >>> + *             -----------------------
> >>> + *                    prescaler
> >>> + * divisor = ---------------------------
> >>> + *            baud-rate x sampling-rate
> >>> + */
> >>>    static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> >>>    {
> >>>    	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
> >>>    	u8 lcr;
> >>> -	u8 prescaler = 0;
> >>> +	int prescaler = 1;
> >>
> >> Ugh, why do you move to signed arithmetics?
> > 
> > Hi Jiri,
> > before this patch, the variable prescaler was used to store an 8 bit
> > bitfield. Now the variable meaning is changed to be used as the
> > prescaler value, which can be 1 or 4 in this case. Leaving
> > it as u8 would still be ok, or making it "unsigned int" maybe?
> 
> Both :). What you prefer -- uint matches more IMO, given it's now a 
> value and not a register...

Hi Jiri,
I will go with uint.

Thank you,
Hugo.


> 
> thanks,
> -- 
> js
> suse labs
> 
> 


-- 
Hugo Villeneuve

