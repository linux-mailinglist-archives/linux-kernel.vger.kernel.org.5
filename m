Return-Path: <linux-kernel+bounces-161193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAD18B484E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 23:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D4EB22356
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83DC145FE5;
	Sat, 27 Apr 2024 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4wz3AAVO"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7533C8;
	Sat, 27 Apr 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252673; cv=none; b=irVxm3PDYukU40Cu6O46/ODuv2m12BAskdvZKfPPWzXab1tLDXq47gdd6ZPOzLUOL9EcYKQ+7U6U72vprHx+1tUdXnNpsycJ6ht2qIRIDIMWvhMN5y0bFUVWq9GCoEkP7FpxfSvXNQ1s15eZm8UEJtxg+IJ1aUzGAQ4Kqx7KrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252673; c=relaxed/simple;
	bh=lri6YROTIADX74D4tW59eSZSL8gtWsyE9zcdY7AhXNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFFIz8aLHkGsHeddos3/IVUo4SAPD5X0VU7MC/PIfRZsBj8Y7OmwP6u70oNpAoyFEoaWReiTkRcoVPjWJvYIEoF4lqasyiM6S6Rl3U19b2qqyIkVt9grUP8eWcEjPEZaIBQl6aGEp2CO4Se0CrWtbhCPEYlz+g32osMyvLr6Cy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4wz3AAVO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wlif7CHx7sEisoS17oJIkYIDPayl4RDiml1kpVEfL/I=; b=4w
	z3AAVO6ByxmQ08Jcub4NyyGgs1HtWknw4vw4eXMG78e8VSoOkgPGzZXAPUwqSuLNMmklndnfed+3h
	+Hd1E8tlcmgdRTImfeSmplEIRCtViBaTAfzwH10GPW8Nd3LPp/AzFrjtGcspVyH/u89q/c3QWTWzv
	A2E3E/sN6X6q2Z4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0pQP-00EA3g-Ey; Sat, 27 Apr 2024 23:17:37 +0200
Date: Sat, 27 Apr 2024 23:17:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zi1Xbz7ARLm3HkqW@builder>

On Sat, Apr 27, 2024 at 09:52:15PM +0200, Ramón Nordin Rodriguez wrote:
> > +static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
> > +{
> > +	u32 regval;
> > +	int ret;
> > +
> > +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
> > +		    INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
> > +		    INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
> > +		    INT_MASK0_HEADER_ERR_MASK);
> > +
> > +	return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
> > +}
> > +
> 
> This togheter with patch 11 works poorly for me. I get alot of kernel
> output, dropped packets and lower performance.
> Below is an example for a run when I curl a 10MB blob
> 
> time curl 20.0.0.55:8000/rdump -o dump -w '{%speed_download}'
>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                  Dload  U[  387.944737] net_ratelimit: 38 callbacks suppressed
> pload   Total   Spent    Left  Sp[  387.944755] eth0: Receive buffer overflow error
> eed
>   0     0    0     0    0     0      0      0 --:--:-- --:-[  387.961424] eth0: Receive buffer overflow error
>   0 10.0M    0  2896    0     0  13031      0  0:13:24 --:--:--  0:13:24 12986[  388.204257] eth0: Receive buffer overflow error
> [  388.209848] eth0: Receive buffer overflow error

How fast is your SPI bus? Faster than the link speed? Or slower?

It could be different behaviour is needed depending on the SPI bus
speed. If the SPI bus is faster than the link speed, by some margin,
the receiver buffer should not overflow, since the CPU can empty the
buffer faster than it fills.

If however, the SPI bus is slower than the link speed, there will be
buffer overflows, and a reliance on TCP backing off and slowing down.
The driver should not be spamming the log, since it is going to happen
and there is nothing that can be done about it.

> I tried this patch
> 
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 9f17f3712137..bd7bd3ef6897 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -615,21 +615,9 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
>         return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
>  }
> 
> -static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
> +static int oa_tc6_disable_imask0_interrupts(struct oa_tc6 *tc6)
>  {
> -       u32 regval;
> -       int ret;
> -
> -       ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
> -       if (ret)
> -               return ret;
> -
> -       regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
> -                   INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
> -                   INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
> -                   INT_MASK0_HEADER_ERR_MASK);
> -
> -       return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
> +       return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, (u32)-1);

So this appears to be disabling all error interrupts?

This is maybe going too far. Overflow errors are going to happen if
you have a slow SPI bus. So i probably would not enable that. However,
are the other errors actually expected in normal usage? If not, leave
them enabled, because they might indicate real problems.

> Which results in no log spam, ~5-10% higher throughput and no dropped
> packets when I look at /sys/class/net/eth0/statistics/rx_dropped

You cannot trust rx_dropped because you just disabled the code which
increments it! The device is probably still dropping packets, and they
are no longer counted.

It could be the performance increase comes from two places:

1) Spending time and bus bandwidth dealing with the buffer overflow
interrupt

2) Printing out the serial port.

Please could you benchmark a few things:

1) Remove the printk("Receive buffer overflow error"), but otherwise
keep the code the same. That will give us an idea how much the serial
port matters.

2) Disable only the RX buffer overflow interrupt

3) Disable all error interrupts.

   Andrew

