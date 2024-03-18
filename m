Return-Path: <linux-kernel+bounces-105682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFDA87E292
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB681C2146E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37761EB39;
	Mon, 18 Mar 2024 03:30:30 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D9208A4;
	Mon, 18 Mar 2024 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732630; cv=none; b=rdwgFdKavxg1/9+VglQ3dwaBCMX/HYy5tJ0xh3ftNpicIHtYeRMzuT9TE8vNAr4/ttPhdNcpzU6L67oRSmzFLcm52YcRlDmofn1SvR42OtpSvmcwM77uegNOKuVmUP6dZUyXCMDhhp/COpjP3s8mlovEYE147yr8uNIhpKgh7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732630; c=relaxed/simple;
	bh=EMgNM80bPZ4CDOuBL+T0inL+ZN+YgA6L9AcGFFdTTR4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=pX6t/s/v0G9ygE+wq9U28zjVlHb1GMYhmFstdL4JBYjmx9bAAaKfJZkPrzVBvk0LDJPtIFgr6+4w20R5NNOqWK2dZZp+lhR/xCnIAwMCH4yEe268WqjGDiMzJ+G6dIQFRoI8zSjve6fX/yJ39NfYQ+RjZSE9rFm4OKzXZA+wq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tyg1H2ZSjz1FMlh;
	Mon, 18 Mar 2024 11:13:55 +0800 (CST)
Received: from dggpemd100002.china.huawei.com (unknown [7.185.36.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 23FF1140381;
	Mon, 18 Mar 2024 11:14:16 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemd100002.china.huawei.com
 (7.185.36.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 18 Mar
 2024 11:14:15 +0800
Message-ID: <07a3c30d-5a81-4b99-8090-38753b650432@huawei.com>
Date: Mon, 18 Mar 2024 11:14:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 5.10] serial: sc16is7xx: convert from _raw_ to
 _noinc_ regmap functions for FIFO
Content-Language: en-US
From: Gong Ruiqi <gongruiqi1@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
CC: Jon Ringle <jringle@gridpoint.com>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wang Weiyang <wangweiyang2@huawei.com>,
	<stable@vger.kernel.org>
References: <20240318025259.1412353-1-gongruiqi1@huawei.com>
In-Reply-To: <20240318025259.1412353-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100002.china.huawei.com (7.185.36.164)

Oops. + Cc stable@vger.kernel.org

On 2024/03/18 10:52, GONG, Ruiqi wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> commit dbf4ab821804df071c8b566d9813083125e6d97b upstream.
> 
> The SC16IS7XX IC supports a burst mode to access the FIFOs where the
> initial register address is sent ($00), followed by all the FIFO data
> without having to resend the register address each time. In this mode, the
> IC doesn't increment the register address for each R/W byte.
> 
> The regmap_raw_read() and regmap_raw_write() are functions which can
> perform IO over multiple registers. They are currently used to read/write
> from/to the FIFO, and although they operate correctly in this burst mode on
> the SPI bus, they would corrupt the regmap cache if it was not disabled
> manually. The reason is that when the R/W size is more than 1 byte, these
> functions assume that the register address is incremented and handle the
> cache accordingly.
> 
> Convert FIFO R/W functions to use the regmap _noinc_ versions in order to
> remove the manual cache control which was a workaround when using the
> _raw_ versions. FIFO registers are properly declared as volatile so
> cache will not be used/updated for FIFO accesses.
> 
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Link: https://lore.kernel.org/r/20231211171353.2901416-6-hugo@hugovil.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
> 
> The mainline commit dbf4ab821804 ("serial: sc16is7xx: convert from _raw_
> to _noinc_ regmap functions for FIFO") by Hugo has been assigned to be
> CVE-2023-52488, but for stable branches lower than 6.1 there's no
> official backport.
> 
> I made up this backport patch for 5.10, and its correctness has been
> confirmed in previous communication with Hugo. Let's publicize it and
> merge it into upstream.
> 
>  drivers/tty/serial/sc16is7xx.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 31e0c5c3ddea..29f05db0d49b 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -376,9 +376,7 @@ static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
>  	const u8 line = sc16is7xx_line(port);
>  	u8 addr = (SC16IS7XX_RHR_REG << SC16IS7XX_REG_SHIFT) | line;
>  
> -	regcache_cache_bypass(s->regmap, true);
> -	regmap_raw_read(s->regmap, addr, s->buf, rxlen);
> -	regcache_cache_bypass(s->regmap, false);
> +	regmap_noinc_read(s->regmap, addr, s->buf, rxlen);
>  }
>  
>  static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
> @@ -394,9 +392,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
>  	if (unlikely(!to_send))
>  		return;
>  
> -	regcache_cache_bypass(s->regmap, true);
> -	regmap_raw_write(s->regmap, addr, s->buf, to_send);
> -	regcache_cache_bypass(s->regmap, false);
> +	regmap_noinc_write(s->regmap, addr, s->buf, to_send);
>  }
>  
>  static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
> @@ -489,6 +485,11 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
>  	return false;
>  }
>  
> +static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
> +{
> +	return reg == SC16IS7XX_RHR_REG;
> +}
> +
>  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>  {
>  	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
> @@ -1439,6 +1440,8 @@ static struct regmap_config regcfg = {
>  	.cache_type = REGCACHE_RBTREE,
>  	.volatile_reg = sc16is7xx_regmap_volatile,
>  	.precious_reg = sc16is7xx_regmap_precious,
> +	.writeable_noinc_reg = sc16is7xx_regmap_noinc,
> +	.readable_noinc_reg = sc16is7xx_regmap_noinc,
>  };
>  
>  #ifdef CONFIG_SERIAL_SC16IS7XX_SPI

