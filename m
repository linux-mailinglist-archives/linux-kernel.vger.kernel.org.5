Return-Path: <linux-kernel+bounces-100318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F28795AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445331C21563
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52A7AE40;
	Tue, 12 Mar 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="nJW62fuh"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4697A71F;
	Tue, 12 Mar 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252412; cv=none; b=iI6WCjzChPUjbLr3F7qQWqdmZkVtjmX6TxCKObkaNPMBL81nZ12G13QjY+AkZqd9TvTYvmNBAsPafpnPSRTLaqXgRKFw8ljQmCpv7ZkE1MnrRnzWpr+2LaiPmdMDuRdQnuBwJPbGUCptsqo4awS1btHEuhwE31Ztydt3skExeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252412; c=relaxed/simple;
	bh=Bwm0HDc0zofJAig1H850rm/5X2T903tkVizEp9Zgv7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRS9EPMMb8jItxE9Xvl69G4Bpu9JQC7guUOXkgLM2v5G4AMTflpvB0lOxC13SAqpt3+fBfrfEaglhFoVr+r0osKYdPumx51ai2z8mb/LL9mPYlk+IRzkBvEYpBlQWI89EC5o2+1DWyvJ3UbFZu+98oNpqDwu1vt8nIDFxJAQTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=nJW62fuh; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 299F34000A;
	Tue, 12 Mar 2024 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710252402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=078Q91kxFkJtbqNYLQudCalSSfSi16PLPA+QyKk374Q=;
	b=nJW62fuhcnXVtmrAnvE5qxf0sDTktEsGw0AZWRdF4J6S9n5qFi0R69+M6+OVWCrd9BBROp
	jZ3Y4C/fdyQ6JzF5zB+Ne8jBVF/2IoklvBVRrK3SntLR9/gzetNkIIZq+IRHrmVDyRMJPy
	jbceSAY3Lt/MvBS/Jv6myWRwxomZETJ1u7Pc0Mf7aFVPn9AbANeck/KfWIvtGskRm1k92R
	YaNsUzK/6SocHm6LbpLt3mgT1/tm/8W3jCpICa+fdQxJhePS3Crg3cQMiFUs/zKOskaMZI
	IOcg8Ad9KskRHeCXpOgNnUGnFIu1+0ZD0IdiC2hhn8CqvGTdFuJQyFL1ccGqUQ==
Message-ID: <6df6db7e-7842-4194-b429-ab7443a18ccb@arinc9.com>
Date: Tue, 12 Mar 2024 17:06:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>
 <d45083788db8b0b1ace051adecfe6a3a@risingedge.co.za>
 <1bfd93f1-36d5-436e-818e-2ebdcf475b44@arinc9.com>
 <0439f80319127b6a4a9c19108bcc0065@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <0439f80319127b6a4a9c19108bcc0065@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 12.03.2024 15:01, Justin Swartz wrote:
> Arınç
> 
> On 2024-03-12 04:41, Arınç ÜNAL wrote:
>> Wouldn't it be a better idea to increase the delay between
>> reset_control_assert() and reset_control_deassert(), and
>> gpiod_set_value_cansleep(priv->reset, 0) and
>> gpiod_set_value_cansleep(priv->reset, 1) instead of disabling the LED
>> controller and delaying before reset?
> 
> I've done some additional tests to see what the difference would be
> between increasing the reset hold period vs. disabling the LEDs then
> sleeping before reset.
> 
> 
> I wanted to know:
> 
> When an active link is present on Port 3 at boot, what are the
> minimum, maximum and average periods between ESW_P3_LED_0
> going low and the signal inversion that seems to co-incide with
> reset_control_deassert() for each approach?
> 
> 
> I created two patches:
> 
> WITH INCREASED RESET DELAY
> 
> As I submitted a patch that added an intended 1000 - 1100 usec delay
> before reset, I thought it would be fair to increase the reset hold
> period by the same value.
> 
> ---%---
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2243,11 +2243,11 @@ mt7530_setup(struct dsa_switch *ds)
>           */
>          if (priv->mcm) {
>                  reset_control_assert(priv->rstc);
> -               usleep_range(1000, 1100);
> +               usleep_range(2000, 2200);
>                  reset_control_deassert(priv->rstc);
>          } else {
>                  gpiod_set_value_cansleep(priv->reset, 0);
> -               usleep_range(1000, 1100);
> +               usleep_range(2000, 2200);
>                  gpiod_set_value_cansleep(priv->reset, 1);
>          }
> ---%---
> 
> 
> DISABLE LEDS BEFORE RESET
> 
> Reset hold period unchanged from the intended 1000 - 1100 usec.
> 
> ---%---
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2238,6 +2238,12 @@ mt7530_setup(struct dsa_switch *ds)
>                  }
>          }
> 
> +       /* Disable LEDs before reset to prevent the MT7530 sampling a
> +        * potentially incorrect HT_XTAL_FSEL value.
> +        */
> +       mt7530_write(priv, MT7530_LED_EN, 0);
> +       usleep_range(1000, 1100);
> +
>          /* Reset whole chip through gpio pin or memory-mapped registers for
>           * different type of hardware
>           */
> ---%---
> 
> 
> I ran 20 tests per patch, applied exclusively. 40 tests in total.
> 
>       <-- ESW_P3_LED_0 Low Period before Reset Deassertion -->
> 
>    TEST    WITH INCREASED RESET DELAY    DISABLE LEDS BEFORE RESET
>       #                        (usec)                       (usec)
> -------------------------------------------------------------------
>       1                           182                         4790
>       2                           370                         3470
>       3                           240                         4635
>       4                          1475                         4850
>       5                            70                         4775
>       6                          2730                         4575
>       7                          3180                         4565
>       8                           265                         5650
>       9                           270                         4690
>      10                          1525                         4450
>      11                          3210                         4735
>      12                           120                         4690
>      13                           185                         4625
>      14                           305                         7020
>      15                          2975                         4720
>      16                           245                         4675
>      17                           350                         4740
>      18                            80                        17920
>      19                           150                        17665
>      20                           100                         4620
> 
>     Min                            70                         3470
>     Max                          3210                        17920
> 
>    Mean                           270                         4720
>     Avg                       923.421                     6161.579
> 
> 
> Every test resulted in a 40MHz HT_XTAL_FSEL, but after seeing 70 usec
> and 80 usec periods I wondered how many more tests it may take before
> an 25MHz HT_XTAL_FSEL appears.
> 
> I was also surprised by the 17920 usec and 17665 usec periods listed
> under the DISABLED LEDS BEFORE RESET column. Nothing unusual seemed
> to be happening, at least as far as the kernel message output was
> concerned.
> 
> What do you make of these results?

What I see is setting ESW_P3_LED_0 low via reset assertion is much more
efficient than doing so by setting the LED controller off. So I'd prefer
increasing the delay between assertion and reassertion. For example, the
Realtek DSA subdriver has a much more generous delay. 25ms after reset
assertion [1].

Looking at your results, 2000 - 2200 usec delay still seems too close, so
let's agree on an amount that will ensure that boards in any circumstances
will have these pins back to the bootstrapping configuration before reset
deassertion. What about 5000 - 5100 usec?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/dsa/realtek/rtl83xx.c#n205

Arınç

