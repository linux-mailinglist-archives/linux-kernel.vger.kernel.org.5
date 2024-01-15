Return-Path: <linux-kernel+bounces-25650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA482D418
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1463A1C210AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2183D72;
	Mon, 15 Jan 2024 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="of+JNQdv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DEC23C5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e7d8d119aso1773095e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705298905; x=1705903705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psrO8ysP5KQkyXx2iDli7R9JaH/czE23JBWLZP2hF6Y=;
        b=of+JNQdvV+y0T6efuQKInZXfrYeq7oRuwGXp+gPHSW94NGQvx71MxTNdP9F7mIccv/
         Z8Awxe0BwJaRs7Tk2+ys4/dxesxHVOUgZBatiEA6iKM46AcUZasIBO9l4/0ME9+rXhZ+
         KdAkCQnMCM77yTK6w34Au3bde3r7ap/Gmim8faC3ebSGuaknht2yWNS8gSfyT4kXg+5j
         QilO9r8eL/5RgMpLreKpIiMdN2eWdWnkcQ9s9gxfM9PYbupmAxT1n0+ACS3Gn0Lle26A
         CkcQ/h+YlrsTVZccFuVFsRSFCmq9LOdY5pyOxsWOG60zjIRNtWmMjy3ywDIu/+VBi8ri
         oJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705298905; x=1705903705;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psrO8ysP5KQkyXx2iDli7R9JaH/czE23JBWLZP2hF6Y=;
        b=qwxTXcKYS2wmJbwb8jnJ5wmMnMQ/J28HYIyD3qg95aIlXl8MrCAxjkrN5GbEbPn5/t
         MNp9KXoKxxyKSlvedz802V60FLqV3RqV6ewQ6b2Twkdd/F1u5UwyNDmVWlLzqgNZhqHC
         EO/cjGbU/DMsiyAnzrIv6IM4TEASSK+cO6CLGoseYsmHzXhjIPcaz7i+gW5iTWgJYClK
         CNZuDQ1fbslje/81WL2P9RCcRLij/U+DZrrJd/rYX0pwOJVlr3Fp+sFZQRKCLHzdnxtW
         sLU+/r3AeXaTDYVbRChdIJbMCI4NxvyRR6B4Gk3zNAW+SwOAXcQ+j7EwLFlfbh/i9Xc+
         Dw1w==
X-Gm-Message-State: AOJu0Yw1b/IxI5tE8hjCIiLYpwLj24tZ7gmNshJdhzkZMDMjKQP5sGJz
	cp6Y57T8+IX9R6KPxxWQkchTTt+ZoNgjGg==
X-Google-Smtp-Source: AGHT+IH5OShb4hhtSROS3CploGhi1S8b/OCgr07G0OUJA+ZIGTCrkqbF2Da08w9/6IjxEf6TjbE5nA==
X-Received: by 2002:a05:600c:3c84:b0:40d:8587:a781 with SMTP id bg4-20020a05600c3c8400b0040d8587a781mr1496032wmb.188.1705298904551;
        Sun, 14 Jan 2024 22:08:24 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b0040d6ffae526sm18649129wmq.39.2024.01.14.22.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 22:08:24 -0800 (PST)
Message-ID: <720e045a-1d5e-432e-9da8-5508eaa96720@tuxon.dev>
Date: Mon, 15 Jan 2024 08:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 17/19] net: ravb: Return cached statistics if
 the interface is down
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, geert+renesas@glider.be,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-18-claudiu.beznea.uj@bp.renesas.com>
 <af5ab82e-5904-c33b-983e-b37844dab3f5@omp.ru>
 <aed6534b-ad5e-4f5c-9861-9a784968adcc@tuxon.dev>
 <28754087-8685-015e-7e8a-d8c3ed26930c@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <28754087-8685-015e-7e8a-d8c3ed26930c@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.01.2024 14:22, Sergey Shtylyov wrote:
> On 1/10/24 4:17 PM, claudiu beznea wrote:
> 
> [...]
> 
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Return the cached statistics in case the interface is down. There should be
>>>> no drawback to this, as cached statistics are updated in ravb_close().
>>>>
>>>> The commit prepares the code for the addition of runtime PM support.
>>>>
>>>> Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> [...]
>>>
>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>> index 76035afd4054..168b6208db37 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>>> @@ -2117,6 +2117,9 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
>>>>  	const struct ravb_hw_info *info = priv->info;
>>>>  	struct net_device_stats *nstats, *stats0, *stats1;
>>>>  
>>>> +	if (!(ndev->flags & IFF_UP))
>>>
>>>    Well, I guess it's OK to read the counters in the reset mode... BUT
>>> won't this race with pm_runtime_put_autosuspend() when its call gets added
>>> to ravb_close()?
>>
>> I re-checked it and, yes, this is true. A sync runtime suspend would be
>> better here. But, as of my current investigation, even with this
> 
>    No, the sync form of the RPM call won't fix the race...
> 
>> ravb_get_stats() can still race with ravb_open()/ravb_close() as they are
>> called though different locking scheme (ravb_open()/ravb_close() is called
>> with rtnl locked while ravb_get_stats() can be called only with
>> dev_base_lock rwlock locked for reading).
>>
>> A mutex in the driver should to help with this.
> 
>    Why don't you want to mimic what the sh_eth driver does?

I thought it can be replaced by the already existing IFF_UP flag from
ndev->flags.

Investigating it further while trying to address this concurrency issue
made me realize that it fits to address the issue you mentioned here.

Thank you,
Claudiu Beznea

> 
>> Thank you,
>> Claudiu Beznea
> 
> [...]
> 
> MBR, Sergey

