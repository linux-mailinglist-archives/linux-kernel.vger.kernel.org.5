Return-Path: <linux-kernel+bounces-22669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE8082A133
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C121F21245
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800324E1DC;
	Wed, 10 Jan 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="YZBo5PnG"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2241770;
	Wed, 10 Jan 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=+XzKXfSadvaCNVpGY5ezuiBYAOTedLFUK1xvme6w4JQ=; b=YZBo5PnGWtH6VqzBCnNB+NCUxl
	p0AjY62HM6w//52PhwfAzs4zsALgfjFXCVHt7WFtGxl73weBA7xqqsGZdYvVvD8LPyHWT1tdFNbBx
	/fA0ihW5S/c6eqVOFFvGmc3e8FK2FH8DhooOKLMl+L4YRt6XjGC47wctJgm0BZ18jyLE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49606 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rNeWb-00009K-FZ; Wed, 10 Jan 2024 14:46:06 -0500
Date: Wed, 10 Jan 2024 14:46:05 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rengarajan S <rengarajan.s@microchip.com>, Kumaravel Thiagarajan
 <kumaravel.thiagarajan@microchip.com>, Tharun Kumar P
 <tharunkumar.pasumarthi@microchip.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Message-Id: <20240110144605.2a8813d4bfaff1a55edb9938@hugovil.com>
In-Reply-To: <ZZ7vIfj7Jgh-pJn8@moroto>
References: <ZZ7vIfj7Jgh-pJn8@moroto>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -3.1 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2] serial: 8250_pci1xxxx: fix off by one in
 pci1xxxx_process_read_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,
it is not simply a matter of adding "fix" to the title.

You must explain what and why vs. how.

Please see:
  https://cbea.ms/git-commit/#why-not-how

for some guidelines on writing a good commit message.

Hugo Villeneuve


On Wed, 10 Jan 2024 22:25:21 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> These > comparisons should be >= to prevent writing one element beyond
> the end of the rx_buff[] array.  The rx_buff[] buffer has RX_BUF_SIZE
> elements.  Fix the buffer overflow.
>
> Fixes: aba8290f368d ("8250: microchip: pci1xxxx: Add Burst mode reception support in uart driver for writing into FIFO")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Add "fix" to the subject.  Fix a typo in the commit message as well.
> 
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 558c4c7f3104..cd258922bd78 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -302,7 +302,7 @@ static void pci1xxxx_process_read_data(struct uart_port *port,
>  	 * to read, the data is received one byte at a time.
>  	 */
>  	while (valid_burst_count--) {
> -		if (*buff_index > (RX_BUF_SIZE - UART_BURST_SIZE))
> +		if (*buff_index >= (RX_BUF_SIZE - UART_BURST_SIZE))
>  			break;
>  		burst_buf = (u32 *)&rx_buff[*buff_index];
>  		*burst_buf = readl(port->membase + UART_RX_BURST_FIFO);
> @@ -311,7 +311,7 @@ static void pci1xxxx_process_read_data(struct uart_port *port,
>  	}
>  
>  	while (*valid_byte_count) {
> -		if (*buff_index > RX_BUF_SIZE)
> +		if (*buff_index >= RX_BUF_SIZE)
>  			break;
>  		rx_buff[*buff_index] = readb(port->membase +
>  					     UART_RX_BYTE_FIFO);
> -- 
> 2.43.0

