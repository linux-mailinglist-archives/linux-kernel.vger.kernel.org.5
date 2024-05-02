Return-Path: <linux-kernel+bounces-166189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F28B9757
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88531C214F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8975337E;
	Thu,  2 May 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LkfbHs/k"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2CD4778B;
	Thu,  2 May 2024 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641274; cv=none; b=cFO02Ov2VKWsvIvSW6nwA2Bz3GE9woEC1Cm9GZjjUlDKb1oiJAPvVVT/Nr+COCuJFrlss4ID1N21H64ks7KazGjgXL7yR3HSeMTkBKUWSFQ5FOsAEBWUlOzP8n1XkP0tiDpiZ74y6cmORIVGs9vCrq/+x0yfKzZuz9lDyC5P2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641274; c=relaxed/simple;
	bh=b0K7N5VFNQhgz8A7fXjMU5postVykzp+1WBrbx0HmIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HloaSawd09twH1oKulzrchdclAT/rrHEFNu8r22m6MeLDOFhR0Yg8mxbIDn59OTlMnL3egojQnJdUrwq5cUXbAwWKjsdmZKMvowuV6MBaMqID5yZSA0E3FXms2U6AxHJ1/DQFo0CPeW2w87rI63xdf9DEa4Z6DtvjfrH1tsv3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LkfbHs/k; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/NoG3XHUWmdniOQeHszLWB0bpcAI3VvsLE8CKkJdHFk=; b=LkfbHs/kiemciZ+KBclNVjo+5i
	owEwK121ksZa5gsrjbj+gmNjRh9unNi3UKTF5YTfhpNvWuqnRpdOHMBzOZzaNWX+Ah90WZ03lTsxI
	djRFv661Sm9QpE7pzz8PcEr++Zu//MugKgZtgrg+09lyvCcHE+2Mle32eBrLCBUWXwr8ZjgNiN1fc
	5Yt2BbgYY1skbfgtsRUB5WoOHSSkDAmNtD1q2rnhmVJP9VoFdO1IEhHF81WGDY2gRIN1gAtizuSXA
	UcadbFoxtBJ35l32msLOTCok72N7n+XzOfEQWx23SkiN4As2dRzrycPcqdlyPmXXSKrlSEY8k6qMs
	ihfcVQfg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1s2SWJ-000KDR-JC; Thu, 02 May 2024 11:14:27 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1s2SWI-0003XL-2e;
	Thu, 02 May 2024 11:14:26 +0200
From: Esben Haabendal <esben@geanix.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Sergey Organov
 <sorganov@gmail.com>,  Jiri Slaby <jirislaby@kernel.org>,  Shawn Guo
 <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-serial@vger.kernel.org,  imx@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] serial: imx: Introduce timeout when waiting on
 transmitter empty
In-Reply-To: <919647898c337a46604edcabaf13d42d80c0915d.1712837613.git.esben@geanix.com>
	(Esben Haabendal's message of "Thu, 11 Apr 2024 14:19:23 +0200")
References: <cf197182beab7acf6ea7ead54fb4324e97e18cbc.1712733269.git.esben@geanix.com>
	<919647898c337a46604edcabaf13d42d80c0915d.1712837613.git.esben@geanix.com>
Date: Thu, 02 May 2024 11:14:26 +0200
Message-ID: <87sez060el.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27263/Thu May  2 10:23:13 2024)

Esben Haabendal <esben@geanix.com> writes:

> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
> deadlock.
>
> In case of the timeout, there is not much we can do, so we simply ignore
> the transmitter state and optimistically try to continue.
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>
> v2:
> - Fixed commit message typo
> - Remove reference to patch series it originated from. This is a
>   stand-alone patch
>
> v3:
> - Moved this version information into the correct patch section

Anything more needed in order to get this merged?

/Esben

>
>  drivers/tty/serial/imx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e14813250616..09c1678ddfd4 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/dma-mapping.h>
>  
>  #include <asm/irq.h>
> @@ -2010,7 +2011,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>  	struct imx_port *sport = imx_uart_ports[co->index];
>  	struct imx_port_ucrs old_ucr;
>  	unsigned long flags;
> -	unsigned int ucr1;
> +	unsigned int ucr1, usr2;
>  	int locked = 1;
>  
>  	if (sport->port.sysrq)
> @@ -2041,8 +2042,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>  	 *	Finally, wait for transmitter to become empty
>  	 *	and restore UCR1/2/3
>  	 */
> -	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC));
> -
> +	read_poll_timeout_atomic(imx_uart_readl, usr2, usr2 & USR2_TXDC,
> +				 0, USEC_PER_SEC, false, sport, USR2);
>  	imx_uart_ucrs_restore(sport, &old_ucr);
>  
>  	if (locked)

