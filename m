Return-Path: <linux-kernel+bounces-161196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD408B486D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 23:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD5D1F21A70
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0D146D60;
	Sat, 27 Apr 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="AZs/6L0V"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3614601D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714254918; cv=none; b=eDa5B1i6d0vuLPZ9L5/ReazB3f9u/EvqyfKliFIcpzFCLAT1N4AHkNJSwXd7M93amgSxI5ngGLUdE6VtqAGlKfR8La54YFOF7FzPhoLf3N6MgMnvl3u6oLtLfcXQIkiqrWqKUtZ0vhLxa02D3eS4YD9SPWoKRvBM4wsIyCAZLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714254918; c=relaxed/simple;
	bh=qTuigNDdiHEJoWocTvujjWAtm0BR7RewD/9z6NMtGVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZTqVhxz43nzqaVME88xqkfVULpDaqtY0KKJ3n3QAWDRqWYsUJwcNDR7Tfg5owjjvQ5r+r90fCSUlS0sel7ZsNF7rA86GhzOfuqSnExT2cJF/38BBPCG2rBTfO6CClFswdz2z8D0qOYyMy8O10Rh4EfjfcStJshbb+mpMQI0NYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=AZs/6L0V; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so2995171e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714254915; x=1714859715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLlP8BQFTBi5+r04P6ikzCsGSqpejVR29HttdqjKMoM=;
        b=AZs/6L0VKdX+VNy1x+r2Gu4DNGy0TFGBOQl8aCj9DNehRcK3jMgzuEL3U49u8IfnPl
         iTFZy7avAw68JQlS44+YDDfvJF/LyRrj+WRkPlgFsnJQHkJH5cVKOLYGeJiCq1/WFCXy
         ijVaAqGQlgO0IDYTl83z7cphUrMVBfFeGdObesXjumUc80mJ8xecNK3s9N7CW7rlfURw
         uadPbjJMcTHMY2e0ZT3EgpgKbZi8jSYfYgrS640qeKtBgA+WitkdBYPH0imc+jGJeDuV
         XXbxzYRrf+EICUAYS3JTwzzdDmM3cQqctMgVsQiN1jZq520wSvKh/wI8E84RppPc3yP4
         ALSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714254915; x=1714859715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLlP8BQFTBi5+r04P6ikzCsGSqpejVR29HttdqjKMoM=;
        b=o1p1rVyiNvthrASSQtJAulcAKyMRnma9CVRh3AAlyyEbSMoRddY+pKVsO7tsYhTpdD
         1c+gMNNSmxP1toW561jWqd/kE7dX+jCxIos9iimtfEokPAC2Hu9CRnrzgQZyr9YTybCe
         HrBKkbxBwwJlzHr+kvs3XFtE9E9pPsFXzDcu8UdLWCTabwxWyRVy25ML/EnqoO35S1+t
         nrx+4OR3KzOEObZ11+gmHGrz7qn4vEaq7djtSa72N6wJvVVTKKgtvAq8x+LHxi9Myf/C
         TeDsmbvz3r15rFNtUFiYWemsB5a9Y++y/I38VJcxprdd8VDZrnSWZmrahXo/YVLaS0Cv
         zzGw==
X-Forwarded-Encrypted: i=1; AJvYcCU3/MtBq5R4Y6SwrOSkiF9bKPQdDr0rzkJ1v/P2MjV1KZgf2lI4I4472+VkpPGpfAHS001rtufxHvh+pq41RQN65Jg3qHWFIWFKP7kp
X-Gm-Message-State: AOJu0YySfo/I6ew/J0e4lfynKcjnJ4Y6K9srCRrV0OI+ykQSqoXG5x23
	i0yLQnrczNB/uwX+UjtyFf5GzdpjYEATyFxHO3IuIKyfq01H8Ert2Q8t/oD6L7A=
X-Google-Smtp-Source: AGHT+IEkK6xoPaL6AbQGT5BbsmF2Hzb/99RIByBNxh6oxjLHRWnJqaoDT3kxQEGfmN/14L+wPO5Z8w==
X-Received: by 2002:a05:6512:3b91:b0:519:5fb9:832b with SMTP id g17-20020a0565123b9100b005195fb9832bmr1201223lfv.12.1714254915122;
        Sat, 27 Apr 2024 14:55:15 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651236c700b0051b81ab0002sm1825348lfs.45.2024.04.27.14.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 14:55:14 -0700 (PDT)
Date: Sat, 27 Apr 2024 23:55:13 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <Zi10QS6UGGaNVRaB@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>

> How fast is your SPI bus? Faster than the link speed? Or slower?
> 
> It could be different behaviour is needed depending on the SPI bus
> speed. If the SPI bus is faster than the link speed, by some margin,
> the receiver buffer should not overflow, since the CPU can empty the
> buffer faster than it fills.

I'm running at 25MHz, I'm guessing that should translate to fast enough
for the 10MBit half duplex link.
But I'm not sure how the spi clock translates to bps here.

> 
> If however, the SPI bus is slower than the link speed, there will be
> buffer overflows, and a reliance on TCP backing off and slowing down.
> The driver should not be spamming the log, since it is going to happen
> and there is nothing that can be done about it.
> 

I agree, I think the print could be a DBG if deemed necessary, but there
is also the dropped counter to look at.

> > I tried this patch
> > 
> > diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> > index 9f17f3712137..bd7bd3ef6897 100644
> > --- a/drivers/net/ethernet/oa_tc6.c
> > +++ b/drivers/net/ethernet/oa_tc6.c
> > @@ -615,21 +615,9 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
> >         return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
> >  }
> > 
> > -static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
> > +static int oa_tc6_disable_imask0_interrupts(struct oa_tc6 *tc6)
> >  {
> > -       u32 regval;
> > -       int ret;
> > -
> > -       ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
> > -       if (ret)
> > -               return ret;
> > -
> > -       regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
> > -                   INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
> > -                   INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
> > -                   INT_MASK0_HEADER_ERR_MASK);
> > -
> > -       return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
> > +       return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, (u32)-1);
> 
> So this appears to be disabling all error interrupts?

Yes, and I think you are right in that it's an overcorrection. There is
a secondary interrupt mask register as well that is not touched by the
driver, so that's left at whatever the chip defaults to on reset.

> 
> This is maybe going too far. Overflow errors are going to happen if
> you have a slow SPI bus. So i probably would not enable that. However,
> are the other errors actually expected in normal usage? If not, leave
> them enabled, because they might indicate real problems.

I'm guessing you are right and that the others actually would be
meningful to log.
There is a nested question here as well, and that is wheter to keep or
drop the code that drops the rx buffer on overflow interrupt.
I think not dropping the full buffer could be one of the reasons for the
perf change.

> 
> > Which results in no log spam, ~5-10% higher throughput and no dropped
> > packets when I look at /sys/class/net/eth0/statistics/rx_dropped
> 
> You cannot trust rx_dropped because you just disabled the code which
> increments it! The device is probably still dropping packets, and they
> are no longer counted.

I'll curb my enthusiasm a bit :)

> 
> It could be the performance increase comes from two places:
> 
> 1) Spending time and bus bandwidth dealing with the buffer overflow
> interrupt
> 
> 2) Printing out the serial port.
> 

I think it's possible that the buffer cleanup triggered after the
overflow interrupt hits could be cause 3) here, but just a guess.

> Please could you benchmark a few things:
> 
> 1) Remove the printk("Receive buffer overflow error"), but otherwise
> keep the code the same. That will give us an idea how much the serial
> port matters.
> 
> 2) Disable only the RX buffer overflow interrupt
> 
> 3) Disable all error interrupts.
> 

Thanks for layout it out so clearly. I'll run through the scenarios!

R

