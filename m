Return-Path: <linux-kernel+bounces-100229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475E8793BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB4BB24BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CFD7AE74;
	Tue, 12 Mar 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="bqkjwvVw"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA079B98;
	Tue, 12 Mar 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244933; cv=none; b=k7ETOV3oNkM0BsLkRIf24n+ESTlpaLdqFozYKo2oXgc9w30uIepROQXeIeV6ppYpMkljyeNteoTKLQVs/yK1MPgdDUTJG6+wlnuOZRUwCkDX3PteL0z/AYepn3isASIlZpyLsWmEKWFtuU4p26eLHgut7p8Oo+ldtUhPxKU1pHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244933; c=relaxed/simple;
	bh=PFir74js1/jsm+Pi6ENClPp+4rtu2s9272C9olrx/Dw=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=nKZAAeU/YpvVFdf98JDh6lq1gGdhUMq2MJmFVehDZbHnyLmttdVpKzgIZIEkEDcDCwfN3SWxAARdEsbzJJOZx5JXh1mOwY4RsOZ5+AlzRFOy9N/U5qV69LwRETv23JEg2Mo+TGhRzRPLNDu9EZoi44coeI4Bijm0VmF3uG7xcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=bqkjwvVw; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=NNhoH3kZBU3wEA79UQzA8t2bW/QxrUW4IGrPs5jo6lw=; b=bqkjwvVw9xy3pQ
	mMCv0Su65/2DT8Mrrk2w+RbI2wOz/XftwpphqycRF7AyijTdMdKvR5fnf12Rf5pWhq0QS5vOG1Mwt
	lQq9Jwkmk/Iik9INnbwBtSeCTFT7yDOah7vU93vUc8xJv4jtYtko7+oEfoflyB9lECZ+hUwQF3+Fo
	O60BsInX7lGVbJ4NJYawQt1rYfYuY5XFuDoSIsF02vM15t7KfVgYKQMGtNaoFO6oyWhgeU7sOWJKl
	LPYx09pGUzZdzUhvkihl6Gow9YiZSrZ//zdj9jf/53E4czDtw1My6yxRKF1BRHthmljZrDmh5Vc2O
	nY3hcn3jJQ13bKdKfUjg==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rk0pK-0012xT-Q1; Tue, 12 Mar 2024 14:01:54 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rk0pF-00064x-6Q; Tue, 12 Mar 2024 14:01:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 12 Mar 2024 14:01:44 +0200
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
In-Reply-To: <1bfd93f1-36d5-436e-818e-2ebdcf475b44@arinc9.com>
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>
 <d45083788db8b0b1ace051adecfe6a3a@risingedge.co.za>
 <1bfd93f1-36d5-436e-818e-2ebdcf475b44@arinc9.com>
Message-ID: <0439f80319127b6a4a9c19108bcc0065@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8LFbNrmGJV48kijLFgdH0+PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIv+fXqqb3FJ1Z7kkAIev0U9CKH/oA07tJunDPm536TODb5GPR
 oyaaXp1VNA9dXvxV+mFktoWo3CKg4C3LDJ75vu2U4GT70q7ZqN/P49BncZ5XB7lfx9K88uL/WnJE
 LAEP514Y/yfAEbrTclu3OeNcbACmFr3ts0d2E6vXySsvfMaT9Bjf4etJ827HW1/sdZ81dz6BqXHU
 oYg+nmOeSIjjxA24TPuOyBrko5yKpcR03QEJ9DjWmjcfK/FpTD0spWG+rMYoj8CdNq4vLYsMDbt4
 2oUP1Ae/eGZl2OLANHAHEjHENEhX9cq65nsXPA0MIFDIPOMDW/6+MC+5Mq5RH9OoW0W22an/ubzj
 InB/ImqScRfGyrhHVstPeAuxsRhUFJC4TtSvIahFt3uEpT0304dV2Yoz1SesQUA6bnjJZT6m9lal
 9vikoy50DqR3hu/rL5PGAoTDzn0QdoxFeruM0Uhu+abwd56m3P3V2gI/b7jbaHMihnVW8zB2Qi26
 vkVALycwzSdeC1kd8cXa71WqOc72jXbRpMw6Agze1f399OurHEyYS7nq+EBNvgiWKNNSkdVDZOrL
 5kxgO94lq2025NSImfKeGaSpuwkt9kMFaoxOFH1hIqsDqiY5NFuEmlCmGLsHMs4VIrisX+dtrxYn
 /0jYEvj5QBAPtzfeVlNHdCJmwgf0M7fnqgzRvCMiN68tcHQey84mBB4XoB473XOJmIRPynE3O7YZ
 oFBs6I7QuC1BjGNT52hVLEr/9PrrMm81h6IAYzikeIJfw26MB/V1E5BP9Gv0xI1YXOxC1lZqyFpL
 AwQr6muMti2YanICQnMITeB2fd0UyjU/MIq3Vtx6CgQGHtezYqxGMqsKjARq8PBC4qgGsfAERwCB
 JFs7XjZYbJPBsmpIto2O4JO2fx1gIuNHgi11AwJSTGCrOFs22K1ZnDqAw3gLmOBPHazhChxq9nGW
 aSi6bFHidB1VgzDzDZn/+QEiRQv+PVjjwa+Z5RFCOMQwU3LvoOQWIGmR34v72byEdfFYVDBYJee7
 gx/u82RtU9N+avzH2dtCj9RPurLgE5Q0mVfWLKEgol9rYV4JEcNP1rJoln/cD8h/RIvkzXRTCYvX
 WLQhlD92+1l+zHfJg1FMwntsduNBxKPaTpE5L8d4VqFy6yKUFQtzhTlGiGL9B6FGD04nL794T5Dd
 GySA/i8IRmZnsBkNt3HcPVt1DPuPIIDSVMZhrIoAWTF5tIdhy/UIEBYDcZg+Q8UhuRLyBn1+pvlH
 hV6a5QjptwQBGybQyDQ2/GYwPjlMcE57ESN6G+kn87CtwPdB/10jfVNpDbYnXJdSRQj8460WHJib
 IxmU2pb4i4DTkMZeMiNI9JSIyUbtnrlbG4BI8o81FOo91axhCaqPShJzgHH7y4ZfQxML
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Arınç

On 2024-03-12 04:41, Arınç ÜNAL wrote:
> On 12.03.2024 03:07, Justin Swartz wrote:
>> I took a similar approach, with calls to dev_info()
>> throughout mt7530_setup() plus mt7530_write(), mt7530_read()
>> and mt7530_rmw() to get an idea of the flow of execution and
>> which registers were being manipulated.
>> 
>> Calls to dev_info() affected timing, so I switched to using
>> trace_printk() and then read the output from the debugfs's
>> tracing/trace file instead of from the console.
>> 
>> I attached a logic analyzer to ESW_P4_LED_0 and ESW_P3_LED_0,
>> and manually triggered sampling as soon as execution of the
>> kernel was reported on UART1.
>> 
>> 
>> -- Test #1 -----------------------------------------------------------
>> 
>> For the sake of maximal reproducability, I removed the delay
>> between the assertion and deassertion of reset and added
>> HWTRAP value tracing:
>> 
>> ---%---
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2243,7 +2243,6 @@ mt7530_setup(struct dsa_switch *ds)
>>       */
>>      if (priv->mcm) {
>>          reset_control_assert(priv->rstc);
>> -        usleep_range(1000, 1100);
>>          reset_control_deassert(priv->rstc);
>>      } else {
>>          gpiod_set_value_cansleep(priv->reset, 0);
>> @@ -2260,6 +2259,10 @@ mt7530_setup(struct dsa_switch *ds)
>>          return ret;
>>      }
>> 
>> +    static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", 
>> "25MHz" };
>> +    trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
>> +        val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
>> +
>>          id = mt7530_read(priv, MT7530_CREV);
>>          id >>= CHIP_NAME_SHIFT;
>>          if (id != MT7530_ID) {
>> ---%---
>> 
>> (a) Without a cable connected to Port 3 (lan4) before reset, the
>> correct external crystal frequency is selected:
>> 
>>                [3]      [4]     [6]
>>                :        :       :
>>                _________         
>> ______________________________________
>> ESW_P4_LED_0           |_______|
>>                          _______
>> ESW_P3_LED_0  _________|       |______________________________________
>> 
>>                          :     :
>>                          [5]...:
>> 
>> [3] Port 4 LED Off. Port 3 LED On.
>> [4] Signals inverted. (reset_control_assert; reset_control_deassert)
>> [5] Period of 310 usec.
>> [6] Signals reflect the bootstrapped configuration.
>> 
>> 
>> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>>      2.432646: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz
>> 
>> 
>> (b) When a cable attached to an active peer is connected to
>> Port 3 (lan4) before reset, the incorrect crystal frequency
>> selection (0b11 = 25MHz) always occurs:
>> 
>>                [7]      [8]     [10]    [12]
>>                :        :       :       :
>>                _________         
>> ______________________________________
>> ESW_P4_LED_0           |_______|
>>                _________         _______
>> ESW_P3_LED_0           |_______|       |______________________________
>> 
>>                          :     : :     :
>>                          [9]...: [11]..:
>> 
>>   [7] Port 4 LED Off. Port 3 LED Off.
>>   [8] Signals inverted. (reset_control_assert; reset_control_deassert)
>>   [9] Period of 320 usec.
>> [10] Signals inverted.
>> [11] Period of 300 usec.
>> [12] Signals reflect the bootstrapped configuration.
>> 
>> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>>      2.432884: mt7530_setup: HWTRAP = 7fcf, HT_XTAL_FSEL = 25MHz
>> 
>> 
>> -- Test #2 -----------------------------------------------------------
>> 
>> To attempt to determine which transitions are associated
>> with asserting and deasserting reset, I performed another
>> test with a delay of what I intended to be a 1 sec period
>> where the MT7530 is held in reset:
>> 
>> ---%---
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2243,7 +2243,7 @@ mt7530_setup(struct dsa_switch *ds)
>>       */
>>      if (priv->mcm) {
>>          reset_control_assert(priv->rstc);
>> -        usleep_range(1000, 1100);
>> +        usleep_range(1000000, 1000000);
>>          reset_control_deassert(priv->rstc);
>>      } else {
>>          gpiod_set_value_cansleep(priv->reset, 0);
>> @@ -2260,6 +2260,10 @@ mt7530_setup(struct dsa_switch *ds)
>>          return ret;
>>      }
>> 
>> +    static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", 
>> "25MHz" };
>> +    trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
>> +        val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
>> +
>>      id = mt7530_read(priv, MT7530_CREV);
>>      id >>= CHIP_NAME_SHIFT;
>>      if (id != MT7530_ID) {
>> ---%---
>> 
>> (a) Without a cable connected to Port 3 (lan4) before reset, the
>> correct external crystal frequency is again selected:
>> 
>>                [13]     [14]    [16]
>>                :        :       :
>>                _________         
>> ______________________________________
>> ESW_P4_LED_0           |_______|
>>                          _______
>> ESW_P3_LED_0  _________|       |______________________________________
>> 
>>                          :     :
>>                          [15]..:
>> 
>> [13] Port 4 LED Off. Port 3 LED On.
>> [14] Signals inverted. (reset_control_deassert?)
>> [15] Period of 310 usec.
>> [16] Signals reflect the bootstrapped configuration.
>> 
>> 
>> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>>      3.437461: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz
>> 
>> 
>> No difference is apparent in the timing diagram, compared
>> to the result from Test #1a, but it is obvious that the code
>> which follows the reset was executed about 1 second later.
>> 
>> 
>> (b) With a cable from an active peer connected to Port 3
>> (lan4) before reset, the correct crystal frequency
>> (0b10 = 40MHz) is selected:
>> 
>>                [17]     [18]                    [20]   [22]
>>                :        :                       :      :
>>                ______________________ \ \ ______        
>> _______________
>> ESW_P4_LED_0                         / /       |______|
>>                _________              \ \        ______
>> ESW_P3_LED_0           |____________ / / ______|      |_______________
>>                                       \ \
>>                          :                     : :    :
>>                          [19]..................: [21].:
>> 
>> [17] Port 4 LED Off. Port 3 LED Off.
>> [18] ESW_P3_LED_0 set low. (reset_control_assert?)
>> [19] Period of 1000.325 msec.
>> [20] Signals inverted. (reset_control_deassert?)
>> [21] Period of 310 usec.
>> [22] Signals reflect the bootstrapped configuration.
>> 
>> 
>> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>>      3.433235: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz
>> 
>> 
>> So it appears that when reset is deasserted, the ESW_P4_LED_0
>> and ESW_P3_LED_0 levels are inverted for a period of about
>> 300 - 310 usec in Test #1a, #1b, #2a, and #2b.
>> 
>> Co-incidentally, these inverted levels are the active low
>> representation of what ends up in HT_XTAL_FSEL. And in all
>> four examples, have been the inversion of what immediately
>> preceded reset_control_deassert().
>> 
>> 
>> -- Test #3 -----------------------------------------------------------
>> 
>> Now it seems that there is a signature that can be used
>> to identify when reset_control_deassert() is executed,
>> the time of reset_control_assert()'s execution should be
>> between (at most) 1100 and (at least) 1000 usec prior
>> based on the unmodified reset logic.
>> 
>> So this patch only includes the HT_XTAL_FSEL trace.
>> 
>> ---%---
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2260,6 +2260,10 @@ mt7530_setup(struct dsa_switch *ds)
>>                  return ret;
>>          }
>> 
>> +       static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", 
>> "25MHz" };
>> +       trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
>> +               val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
>> +
>>          id = mt7530_read(priv, MT7530_CREV);
>>          id >>= CHIP_NAME_SHIFT;
>>          if (id != MT7530_ID) {
>> ---%---
>> 
>> The purpose of the following examples are to show the
>> variance in how long it takes for ESW_P3_LED_0 to go low.
>> 
>> (a) With a cable from an active peer connected to Port 3
>> (lan4) before reset, the correct crystal frequency
>> (0b10 = 40MHz) is selected.
>> 
>>                [23]    [24]       [26]      [28]    [30]
>>                :       :          :         :       :
>>                _____________________________         
>> __________________
>> ESW_P4_LED_0                               |_______|
>>                ___________________           _______
>> ESW_P3_LED_0                     |_________|       |__________________
>> 
>>                         :          :       : :     :
>>                         :          [27]....: [29]..:
>>                         [25]...............:
>> 
>> [23] Port 4 LED Off. Port 3 LED Off.
>> [24] Approximate point of reset_control_assert?
>> [25] Period of approximately 1000 - 1100 usec.
>> [26] ESW_P3_LED_0 finally goes low.
>> [27] Period of 415 usec.
>> [28] Signals inverted. (reset_control_deassert?)
>> [29] Period of 310 usec.
>> [30] Signals reflect the bootstrapped configuration.
>> 
>> 
>> (b) With a cable from an active peer connected to Port 3
>> (lan4) before reset, the correct crystal frequency
>> (0b10 = 40MHz) is selected.
>> 
>>                [31]    [32]            [34] [36]    [38]
>>                :       :                  : :       :
>>                _____________________________         
>> __________________
>> ESW_P4_LED_0                               |_______|
>>                ___________________________   _______
>> ESW_P3_LED_0                             |_|       |__________________
>> 
>>                         :                  : :     :
>>                         :               [35] [37]..:
>>                         :                  :
>>                         [33]...............:
>> 
>> [31] Port 4 LED Off. Port 3 LED Off.
>> [32] Approximate point of reset_control_assert?
>> [33] Period of approximately 1000 - 1100 usec.
>> [34] ESW_P3_LED_0 finally goes low.
>> [35] Period of 50 usec.
>> [36] Signals inverted. (reset_control_deassert?)
>> [37] Period of 310 usec.
>> [38] Signals reflect the bootstrapped configuration.
>> 
>> 
>> (c) With a cable from an active peer connected to Port 3
>> (lan4) before reset, an incorrect crystal frequency
>> (0b11 = 25MHz) is selected.
>> 
>>                [45]    [46]                 [48]    [50]
>>                :       :                    :       :
>>                _____________________________         
>> __________________
>> ESW_P4_LED_0                               |_______|
>>                _____________________________
>> ESW_P3_LED_0                               |__________________________
>> 
>>                         :                  : :     :
>>                         :                  : [49]..:
>>                         :                  :
>>                         [47]...............:
>> 
>> [45] Port 4 LED Off. Port 3 LED Off.
>> [46] Approximate point of reset_control_assert?
>> [47] Period of approximately 1000 - 1100 usec.
>> [48] Signals inverted. (reset_control_deassert?)
>> [49] Period of 315 usec.
>> [50] Signals reflect the bootstrapped configuration.
>> 
>> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>>      2.617819: mt7530_setup: HWTRAP = 7fcf, HT_XTAL_FSEL = 25MHz
>> 
>> ~ # cat /proc/cmdline
>> console=ttyS0,57600 loglevel=7 printk.time=1 root=/dev/ram0 debug 
>> rdinit=/linuxrc
>> 
>> 
>> -- End of Tests ------------------------------------------------------
>> 
>> It seems that the incorrect crystal frequency is selected more
>> often when debugging messages are present (such as printk()
>> based approaches) and especially when loglevel=7 and printk.time=1
>> are specified on the command line.
>> 
>> For the sake of reference: I disabled ethernet support in my build
>> of (mainline) U-boot, and my kernel configuration is a very lean
>> selection of options suited for IP routing and a few peripherals
>> on the I2C and SPI buses.
>> 
>> My userland is confined to an initramfs built around busybox.
>> 
>> I also disable gmac1 because I need a few of the rgmii2 pins for
>> modem control signalling.
>> 
>> Regards
>> Justin
>> 
>> PS: Yes, I only have access to MT7621AT SoCs.
> 
> Thanks for the detailed presentation. I've simplified it to this, from 
> what
> I understood.
> 
> --- Currently 
> -------------------------------------------------------------
> 
> With a cable from an active peer connected to Port 3 (lan4) before
> reset:
> 
> Test 1, the correct crystal frequency (0b10 = 40MHz) is selected.
> 
>                       [1]        [2-1]     [3]     [5]
>                       :          :         :       :
>               _____________________________         __________________
> ESW_P4_LED_0                               |_______|
>               ___________________           _______
> ESW_P3_LED_0                     |_________|       |__________________
> 
>                        :          :       : :     :
>                        :          [2-2]...: [4]...:
>                        [2]................:
> 
> [1] reset_control_assert.
> [2] Period of 1000 - 1100 usec.
> [2-1] ESW_P3_LED_0 goes low.
> [2-2] Period of 415 usec.
> [3] reset_control_deassert.
> [4] Period of 310 usec. HWTRAP register is populated with bootstrapped
>     XTAL frequency.
> [5] Signals reflect the bootstrapped configuration.
> 
> Test 2, an incorrect crystal frequency (0b11 = 25MHz) is selected.
> 
>                       [2]                  [4]     [6]
>                       :                    :       :
>               _____________________________         __________________
> ESW_P4_LED_0                               |_______|
>               _____________________________
> ESW_P3_LED_0                               |__________________________
> 
>                        :                  : :     :
>                        :                  : [5]...:
>                        :                  :
>                        [3]................:
> 
> [1] reset_control_assert.
> [2] Period of 1000 - 1100 usec.
> [3] reset_control_deassert.
> [5] Period of 315 usec. HWTRAP register is populated with incorrect
>     XTAL frequency.
> [6] Signals reflect the bootstrapped configuration.
> 
> --- 1 second delay between assert and deassert 
> ----------------------------
> 
> With a cable from an active peer connected to Port 3 (lan4) before
> reset, the correct crystal frequency (0b10 = 40MHz) is selected:
> 
>                       [1]        [2-1]     [3]     [5]
>                       :          :         :       :
>               _____________________________         __________________
> ESW_P4_LED_0                               |_______|
>               ___________________           _______
> ESW_P3_LED_0                     |_________|       |__________________
> 
>                        :          :       : :     :
>                        :          [2-2]...: [4]...:
>                        [2]................:
> 
> [1] reset_control_assert.
> [3] Period of 1000.325 msec.
> [2-1] ESW_P3_LED_0 goes low.
> [2-2] Remaining period of 1000.325 msec.
> [3] reset_control_deassert.
> [4] Period of 310 usec. HWTRAP register is populated with bootstrapped
>     XTAL frequency.
> [5] Signals reflect the bootstrapped configuration.
> 
> ---
> 
> Wouldn't it be a better idea to increase the delay between
> reset_control_assert() and reset_control_deassert(), and
> gpiod_set_value_cansleep(priv->reset, 0) and
> gpiod_set_value_cansleep(priv->reset, 1) instead of disabling the LED
> controller and delaying before reset?

I've done some additional tests to see what the difference would be
between increasing the reset hold period vs. disabling the LEDs then
sleeping before reset.


I wanted to know:

When an active link is present on Port 3 at boot, what are the
minimum, maximum and average periods between ESW_P3_LED_0
going low and the signal inversion that seems to co-incide with
reset_control_deassert() for each approach?


I created two patches:

WITH INCREASED RESET DELAY

As I submitted a patch that added an intended 1000 - 1100 usec delay
before reset, I thought it would be fair to increase the reset hold
period by the same value.

---%---
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2243,11 +2243,11 @@ mt7530_setup(struct dsa_switch *ds)
          */
         if (priv->mcm) {
                 reset_control_assert(priv->rstc);
-               usleep_range(1000, 1100);
+               usleep_range(2000, 2200);
                 reset_control_deassert(priv->rstc);
         } else {
                 gpiod_set_value_cansleep(priv->reset, 0);
-               usleep_range(1000, 1100);
+               usleep_range(2000, 2200);
                 gpiod_set_value_cansleep(priv->reset, 1);
         }
---%---


DISABLE LEDS BEFORE RESET

Reset hold period unchanged from the intended 1000 - 1100 usec.

---%---
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2238,6 +2238,12 @@ mt7530_setup(struct dsa_switch *ds)
                 }
         }

+       /* Disable LEDs before reset to prevent the MT7530 sampling a
+        * potentially incorrect HT_XTAL_FSEL value.
+        */
+       mt7530_write(priv, MT7530_LED_EN, 0);
+       usleep_range(1000, 1100);
+
         /* Reset whole chip through gpio pin or memory-mapped registers 
for
          * different type of hardware
          */
---%---


I ran 20 tests per patch, applied exclusively. 40 tests in total.

      <-- ESW_P3_LED_0 Low Period before Reset Deassertion -->

   TEST    WITH INCREASED RESET DELAY    DISABLE LEDS BEFORE RESET
      #                        (usec)                       (usec)
-------------------------------------------------------------------
      1                           182                         4790
      2                           370                         3470
      3                           240                         4635
      4                          1475                         4850
      5                            70                         4775
      6                          2730                         4575
      7                          3180                         4565
      8                           265                         5650
      9                           270                         4690
     10                          1525                         4450
     11                          3210                         4735
     12                           120                         4690
     13                           185                         4625
     14                           305                         7020
     15                          2975                         4720
     16                           245                         4675
     17                           350                         4740
     18                            80                        17920
     19                           150                        17665
     20                           100                         4620

    Min                            70                         3470
    Max                          3210                        17920

   Mean                           270                         4720
    Avg                       923.421                     6161.579


Every test resulted in a 40MHz HT_XTAL_FSEL, but after seeing 70 usec
and 80 usec periods I wondered how many more tests it may take before
an 25MHz HT_XTAL_FSEL appears.

I was also surprised by the 17920 usec and 17665 usec periods listed
under the DISABLED LEDS BEFORE RESET column. Nothing unusual seemed
to be happening, at least as far as the kernel message output was
concerned.

What do you make of these results?


> One MT7531 pin used for an LED is also used to decide the crystal 
> frequency
> between 40MHz and 25Mhz. We should implement this there as well.
> 
> Arınç

