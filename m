Return-Path: <linux-kernel+bounces-100521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A9D87990A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBCB1F22FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD417E588;
	Tue, 12 Mar 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="oy6s3xtd"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD87C091;
	Tue, 12 Mar 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261365; cv=none; b=ce6PJanakhdxhYX0kmMnkwxPUk/ryQhWSfQOzu7mLdv4rB9XnN1EmG7VeEerbaVcOSeRWkC+6cqAk/h2EaxoXYSXlMEHAwU1FhnWRPGdgW1u98lvbENECleIbRoUFjZswUs9vh1Al/0m3EGuHlo8Nq8QjhPYrCQRdtiam6jBTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261365; c=relaxed/simple;
	bh=h0m6V52SrJe1v2wSyxARFMDVuZtknqDrGF7IJd8CboE=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=fC6c1lzo4aoXih6+NITgLjDJZkKqLPQHxkkVwz2NpVD+2MjNF2NxWzuuzVhOGClNtAVj587DxH7CmEvdSA5vi4qgLYhDG62zUppoy8id0mchg2iVJzTW1drTMVX7W1ZhJKim1pXyuhHGNqYAkwJJ1mNpB520ZR3jSBpGqeC6nHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=oy6s3xtd; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=yg+g+abNrGcwEzQSWBbG2h+JPGpvEcqsYIaVOBM+AUA=; b=oy6s3xtd7jDtGp
	6RPb1fsedIa8PfieDnwpdvgYnnczVWLLrzOAQzhyGUwfduVZbZDsS+yrEvgA0HDclaUMieAQRVn9/
	H7XKezlmXa83mffFgtPLjzZDO2FiGPa1xuyDZ4bjqfiz3XbKzMTxfNuWvhLcvTiHV72LDMtxyhyeL
	2whpDNtHlKk89s1WmLKSEgsDMZrfqYnblmj84LfBWsfWTmOXAyCgBL+8XtxRgkvBk8A3XbJ4ijESZ
	rL8GyZ5auxRApC6T097AoG+7oZZG6RbE1KFVqpMzKSDfEudsvVorEI+q8ZpjU2dJNdfG+Gf06KrM6
	o9JMgRLlDbOd/cNfgu4w==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rk56N-007QAO-TD; Tue, 12 Mar 2024 18:35:47 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rk56H-0004yq-Ib; Tue, 12 Mar 2024 18:35:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 12 Mar 2024 18:35:37 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian
 Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
In-Reply-To: <9a7c29b51575083201b963638bdb9fa5@risingedge.co.za>
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>
 <d45083788db8b0b1ace051adecfe6a3a@risingedge.co.za>
 <1bfd93f1-36d5-436e-818e-2ebdcf475b44@arinc9.com>
 <0439f80319127b6a4a9c19108bcc0065@risingedge.co.za>
 <6df6db7e-7842-4194-b429-ab7443a18ccb@arinc9.com>
 <9a7c29b51575083201b963638bdb9fa5@risingedge.co.za>
Message-ID: <f594a72a91d12f1d027a06962caa9750@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+lUXMrY4PnmjnViZCjXhQaPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIv+fXqqb3FJ1Z7kkAIev0U9CKH/oA07tJunDPm536TODb5GPR
 oyaaXp1VNA9dXvxV+mFktoWo3CKg4C3LDJ75vu2U4GT70q7ZqN/P49BncZ5XB7lfx9K88uL/WnJE
 LAEP514Y/yfAEbrTclu3OeNcbACmFr3ts0d2E6vXySsvfMaT9Bjf4etJ827HW1/sdZ81dz6BqXHU
 oYg+nmOeSIjjxA24TPuOyBrko5yKpcR03QEJ9DjWmjcfK/FpTD0spWG+rMYoj8CdNq4vLYsMDbt4
 2oUP1Ae/eGZl2OLANHAHEjHENEhX9cq65nsXPA0MIFDIPOMDW/6+MC+5Mq5RH9OoW0W22an/ubzj
 InB/ImqScRfGyrhHVstPeAuxsRhUFJC4TtSvIahFt3uEpT0304dV2Yoz1SesQUA6bnjJZT6m9lal
 9vikoy50DqR3hu/rL5PGAoTDzn0QdoxFeruM0Uhu+RLoZIyBwur4TJrMt0TK0/cihnVW8zB2Qi26
 vkVALycwzSdeC1kd8cXa71WqOc72jXbRpMw6Agze1f399OurHEyYS7nq+EBNvgiWKNNSkdVDZOrL
 5kxgO94lq2025NSImfKeGaSpuwkt9kMFaoxOFH3nT6Zph4wUZj+IQLUKRJzeMs4VIrisX+dtrxYn
 /0jYEvj5QBAPtzfeVlNHdCJmwgf0M7fnqgzRvCMiN68tcHQey84mBB4XoB473XOJmIRPynE3O7YZ
 oFBs6I7QuC1BjGNT52hVLEr/9PrrMm81h6IAYzikeIJfw26MB/V1E5BP9Gv0xI1YXOxC1lZqyFpL
 AwQr6muMti2YanICQnMITeB2fd0UyjU/MIq3Vtx6CgQGHtezYqxGMqsKjARq8PBC4qgGsfAERwCB
 JFs7XjZYbJPBsmpIto2O4JO2fx1gIuNHgi11AwJSTGCrOFs22K1ZnDqAw3gLmOBPHazhChxq9nGW
 aSi6bFHidB1VgzDzDZn/+QEiRQv+PVjjwa+Z5RFCOMRmYvGVP5J/K7tDFQHNyAqzdfFYVDBYJee7
 gx/u82RtU9UW3dl9fwt0Tdq4PMjNsqE0mVfWLKEgol9rYV4JEcNP1rJoln/cD8h/RIvkzXRTCYvX
 WLQhlD92+1l+zHfJg1FMwntsduNBxKPaTpE5L8d4VqFy6yKUFQtzhTlGiGL9B0nAIzS3VGMYMsaD
 t/vlLode8ZEQhyUpJRaYI785W4/hIIDSVMZhrIoAWTF5tIdhy/UIEBYDcZg+Q8UhuRLyBn1+pvlH
 hV6a5QjptwQBGybQyDQ2/GYwPjlMcE57ESN6G+kn87CtwPdB/10jfVNpDbYnXJdSRQj8460WHJib
 IxmU2pb4i4DTkMZeMiNI9JSIyUbtnrlbG4BI8o81FOo91axhCaqPShJzgHH7y4ZfQxML
X-Report-Abuse-To: spam@antispamquarantine.host-h.net


On 2024-03-12 17:25, Justin Swartz wrote:
> On 2024-03-12 16:06, Arınç ÜNAL wrote:
>> On 12.03.2024 15:01, Justin Swartz wrote:
>>> Arınç
>>> 
>>> On 2024-03-12 04:41, Arınç ÜNAL wrote:
>>>> Wouldn't it be a better idea to increase the delay between
>>>> reset_control_assert() and reset_control_deassert(), and
>>>> gpiod_set_value_cansleep(priv->reset, 0) and
>>>> gpiod_set_value_cansleep(priv->reset, 1) instead of disabling the 
>>>> LED
>>>> controller and delaying before reset?
>>> 
>>> I've done some additional tests to see what the difference would be
>>> between increasing the reset hold period vs. disabling the LEDs then
>>> sleeping before reset.
>>> 
>>> 
>>> I wanted to know:
>>> 
>>> When an active link is present on Port 3 at boot, what are the
>>> minimum, maximum and average periods between ESW_P3_LED_0
>>> going low and the signal inversion that seems to co-incide with
>>> reset_control_deassert() for each approach?
>>> 
>>> 
>>> I created two patches:
>>> 
>>> WITH INCREASED RESET DELAY
>>> 
>>> As I submitted a patch that added an intended 1000 - 1100 usec delay
>>> before reset, I thought it would be fair to increase the reset hold
>>> period by the same value.
>>> 
>>> ---%---
>>> --- a/drivers/net/dsa/mt7530.c
>>> +++ b/drivers/net/dsa/mt7530.c
>>> @@ -2243,11 +2243,11 @@ mt7530_setup(struct dsa_switch *ds)
>>>           */
>>>          if (priv->mcm) {
>>>                  reset_control_assert(priv->rstc);
>>> -               usleep_range(1000, 1100);
>>> +               usleep_range(2000, 2200);
>>>                  reset_control_deassert(priv->rstc);
>>>          } else {
>>>                  gpiod_set_value_cansleep(priv->reset, 0);
>>> -               usleep_range(1000, 1100);
>>> +               usleep_range(2000, 2200);
>>>                  gpiod_set_value_cansleep(priv->reset, 1);
>>>          }
>>> ---%---
>>> 
>>> 
>>> DISABLE LEDS BEFORE RESET
>>> 
>>> Reset hold period unchanged from the intended 1000 - 1100 usec.
>>> 
>>> ---%---
>>> --- a/drivers/net/dsa/mt7530.c
>>> +++ b/drivers/net/dsa/mt7530.c
>>> @@ -2238,6 +2238,12 @@ mt7530_setup(struct dsa_switch *ds)
>>>                  }
>>>          }
>>> 
>>> +       /* Disable LEDs before reset to prevent the MT7530 sampling a
>>> +        * potentially incorrect HT_XTAL_FSEL value.
>>> +        */
>>> +       mt7530_write(priv, MT7530_LED_EN, 0);
>>> +       usleep_range(1000, 1100);
>>> +
>>>          /* Reset whole chip through gpio pin or memory-mapped 
>>> registers for
>>>           * different type of hardware
>>>           */
>>> ---%---
>>> 
>>> 
>>> I ran 20 tests per patch, applied exclusively. 40 tests in total.
>>> 
>>>       <-- ESW_P3_LED_0 Low Period before Reset Deassertion -->
>>> 
>>>    TEST    WITH INCREASED RESET DELAY    DISABLE LEDS BEFORE RESET
>>>       #                        (usec)                       (usec)
>>> -------------------------------------------------------------------
>>>       1                           182                         4790
>>>       2                           370                         3470
>>>       3                           240                         4635
>>>       4                          1475                         4850
>>>       5                            70                         4775
>>>       6                          2730                         4575
>>>       7                          3180                         4565
>>>       8                           265                         5650
>>>       9                           270                         4690
>>>      10                          1525                         4450
>>>      11                          3210                         4735
>>>      12                           120                         4690
>>>      13                           185                         4625
>>>      14                           305                         7020
>>>      15                          2975                         4720
>>>      16                           245                         4675
>>>      17                           350                         4740
>>>      18                            80                        17920
>>>      19                           150                        17665
>>>      20                           100                         4620
>>> 
>>>     Min                            70                         3470
>>>     Max                          3210                        17920
>>> 
>>>    Mean                           270                         4720
> -1s/  Mean/Median/
> 
>>>     Avg                       923.421                     6161.579
>>> 
>>> 
>>> Every test resulted in a 40MHz HT_XTAL_FSEL, but after seeing 70 usec
>>> and 80 usec periods I wondered how many more tests it may take before
>>> an 25MHz HT_XTAL_FSEL appears.
>>> 
>>> I was also surprised by the 17920 usec and 17665 usec periods listed
>>> under the DISABLED LEDS BEFORE RESET column. Nothing unusual seemed
>>> to be happening, at least as far as the kernel message output was
>>> concerned.
>>> 
>>> What do you make of these results?
>> 
>> What I see is setting ESW_P3_LED_0 low via reset assertion is much 
>> more
>> efficient than doing so by setting the LED controller off. So I'd 
>> prefer
>> increasing the delay between assertion and reassertion. For example, 
>> the
>> Realtek DSA subdriver has a much more generous delay. 25ms after reset
>> assertion [1].
>> 
>> Looking at your results, 2000 - 2200 usec delay still seems too close, 
>> so
>> let's agree on an amount that will ensure that boards in any 
>> circumstances
>> will have these pins back to the bootstrapping configuration before 
>> reset
>> deassertion. What about 5000 - 5100 usec?
> 
>    TEST    ESW_P3_LED_0 LOW PERIOD
>       #                     (usec)
> ----------------------------------
>       1                       5410
>       2                       5440
>       3                       4375
>       4                       5490
>       5                       5475
>       6                       4335
>       7                       4370
>       8                       5435
>       9                       4205
>      10                       4335
>      11                       3750
>      12                       3170
>      13                       4395
>      14                       4375
>      15                       3515
>      16                       4335
>      17                       4220
>      18                       4175
>      19                       4175
>      20                       4350
> 
>     Min                       3170
>     Max                       5490
> 
>  Median                   4342.500
>     Avg                   4466.500
> 
> Looks reasonable to me.

I had messed up the Median/Average calculation with the data
I had pasted earlier after copying and pasting formulas without
double checking how they had been affected.

So here's the table again, now with the 5000 - 5100 usec test
run tacked on for easier comparison:

              2000 usec                      5000 usec
            - 2200 usec    DISABLE LEDS    - 5100 usec
    TEST     RESET HOLD    BEFORE RESET     RESET HOLD
       #         (usec)          (usec)         (usec)
--------------------------------------------------------
       1            182            4790           5410
       2            370            3470           5440
       3            240            4635           4375
       4           1475            4850           5490
       5             70            4775           5475
       6           2730            4575           4335
       7           3180            4565           4370
       8            265            5650           5435
       9            270            4690           4205
      10           1525            4450           4335
      11           3210            4735           3750
      12            120            4690           3170
      13            185            4625           4395
      14            305            7020           4375
      15           2975            4720           3515
      16            245            4675           4335
      17            350            4740           4220
      18             80           17920           4175
      19            150           17665           4175
      20            100            4620           4350

     Min             70            3470           3170
     Max           3210           17920           5490

  Median        267.500            4705       4342.500
     Avg        901.350            6093       4466.500


>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/dsa/realtek/rtl83xx.c#n205
>> 
>> Arınç

