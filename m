Return-Path: <linux-kernel+bounces-99704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B57878C02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D9D1F21DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896620E3;
	Tue, 12 Mar 2024 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="N7e4NFYx"
Received: from outgoing11.flk.host-h.net (outgoing11.flk.host-h.net [188.40.208.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68757E6;
	Tue, 12 Mar 2024 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.208.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204462; cv=none; b=PKfQ5oCTnFlebRaHVXYU32pm90D3C22qZIaYO9LepfGeLorOEZBCrvKBKAdyPUoQNETLVHYbPQFnPaJrsQ0CztIF7aAirQnWF3iPuk98CPAA3ZnMwhZGjEO+CxyL8t8dG4dQOckYSfszyyyXx19TQTe3KKPDG2cQuSRUDn/blzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204462; c=relaxed/simple;
	bh=RD4oSrphGT/zs1LTG38hThA+QnLosCmnD2Ovdh5Q5B0=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=mTDu/8FIzRWfhvhqEhDEjMNgVh+2WJSG/z5SXFQz79ZTaUm5Xrr4riWXvWCqTI2lKYL9AQ/q+o3GlVR/vK5sGIGPlgPgaF5N2WhEJuLZhBkNvWCcUDHjT98nFc9cx1d2NDjBm1jkUYykNi4/L+7l1vk8o/F4Cg4xVyfsZP6oqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=N7e4NFYx; arc=none smtp.client-ip=188.40.208.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=DIe14zhXB/BBuR0DwhsMmlCYnn58097mBh1HWwUKLNk=; b=N7e4NFYxjohlVa
	u8S0lxHCdV7jlpFYVA38SbI1E0r8iC4ymYE7Tp6NXAhs3jxYGEQgZVqk9xcR7tdnRoikqzwgZq1Iv
	yc5+PAssswEbbHvlAIM3g2nCAnP6U2+8GqeqDRzCQKJ4Iz/FS9+QHDN6rDR1hfuIsFdeutzRFiI9M
	kK6jxuhx7AUy5m8yORS/nwC9P4xm8whSIvAqRISgSBDB9qE3iDhAkjiDu5EW9T6rrlReOGlbav417
	U7pmYek3fICm+SlacdOTiAZPuFZcm9HrhAiOEiMKhiRAcunFAMBES1XblMnLCb+GhIvgga45xDn9k
	iPISo/8JMptUjpMQsbaQ==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rjpgJ-006aE8-BO; Tue, 12 Mar 2024 02:07:51 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rjpgE-0004e4-Rd; Tue, 12 Mar 2024 02:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 12 Mar 2024 02:07:42 +0200
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
In-Reply-To: <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>
Message-ID: <d45083788db8b0b1ace051adecfe6a3a@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/kCf5rqZQbPtgsYo3czMdXPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIv+fXqqb3FJ1Z7kkAIev0U9CKH/oA07tJunDPm536TODb5GPR
 oyaaXp1VNA9dXvxV+mFktoWo3CKg4C3LDJ75vu2U4GT70q7ZqN/P49BncZ5XB7lfx9K88uL/WnJE
 LAEP514Y/yfAEbrTclu3OeNcbACmFr3ts0d2E6vXySsvfMaT9Bjf4etJ827HW1/sdZ81dz6BqXHU
 oYg+nmOeSIjjxA24TPuOyBrko5yKpcR03QEJ9DjWmjcfK/FpTD0spWG+rMYoj8CdNq4vLYsMDbt4
 2oUP1Ae/eGZl2OLANHAHEjHENEhX9cq65nsXPA0MIFDIPOMDW/6+MC+5Mq5RH9OoW0W22an/ubzj
 InB/ImqScRfGyrhHVstPeAuxsRhUFJC4TtSvIahFt3uEpT0304dV2Yoz1SesQUA6bnjJZT6m9lal
 9vikoy50DqR3hu/rL5PGAoTDzn0QdoxFeruM0Uhu+bywTjP/IjZyZOEqQdmUpe0ihnVW8zB2Qi26
 vkVALycwzSdeC1kd8cXa71WqOc72jXbRpMw6Agze1f399OurHEyYS7nq+EBNvgiWKNNSkdVDZOrL
 5kxgO94lq2025NSImfKeGaSpuwkt9kMFaoxOFH2cp4YsTYwGNGW12ki18UnPMs4VIrisX+dtrxYn
 /0jYEvj5QBAPtzfeVlNHdCJmwgf0M7fnqgzRvCMiN68tcHQey84mBB4XoB473XOJmIRPynE3O7YZ
 oFBs6I7QuC1BjGNT52hVLEr/9PrrMm81h6IAYzikeIJfw26MB/V1E5BP9Gv0xI1YXOxC1lZqyFpL
 AwQr6muMti2YanICQnMITeB2fd0UyjU/MIq3Vtx6CgQGHtezYqxGMqsKjARq8PBC4qgGsfAERwCB
 JFs7XjZYbJPBsmpIto2O4JO2fx1gIuNHgi11AwJSTGCrOFs22K1ZnDqAw3gLmOBPHazhChxq9nGW
 aSi6bFHidB1VgzDzDZn/+QEiRQv+PVjjwa+Z5RFCOMTMctdsTl1csEqhToiNz8IDdfFYVDBYJee7
 gx/u82RtU18XNrKeU1CASw2/Ip5a4J80mVfWLKEgol9rYV4JEcNP1rJoln/cD8h/RIvkzXRTCYvX
 WLQhlD92+1l+zHfJg1FMwntsduNBxKPaTpE5L8d4VqFy6yKUFQtzhTlGiGL9B/tA9KNRpNaNtViv
 IKQDqep0GsMfhkO3dGlpFuRVkSMvIIDSVMZhrIoAWTF5tIdhy/UIEBYDcZg+Q8UhuRLyBn1+pvlH
 hV6a5QjptwQBGybQyDQ2/GYwPjlMcE57ESN6G+kn87CtwPdB/10jfVNpDbYnXJdSRQj8460WHJib
 IxmU2pb4i4DTkMZeMiNI9JSIyUbtnrlbG4BI8o81FOo91axhCaqPShJzgHH7y4ZfQxML
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Hi Arınç

This reply will be best read with a fixed-width font.

On 2024-03-08 11:51, Arınç ÜNAL wrote:
> Hey Justin.
> 
> I couldn't find anything on the MT7621 Giga Switch Programming Guide 
> v0.3
> document regarding which pin corresponds to which bit on the HWTRAP
> register. There's only this mention on the LED controller section,
> "hardware traps and LEDs share the same pins in GSW". But page 16 of 
> the
> schematics document for Banana Pi BPI-R2 [1] fully documents this.

There is also a table in the "MT7530 Giga Switch Programming
Guide" that describes which pins correspond to the bits of
HWTRAP, but beware of typos.


> The HWTRAP register is populated right after power comes back after the
> switch chip is reset [2]. This means any active link before the reset 
> will
> go away so the high/low state of the pins will go back to being 
> dictated by
> the bootstrapping design of the board. The HWTRAP register will be
> populated before a link can be set up.

> In conclusion, I don't see any need to disable the LED controller 
> before
> resetting the switch chip.

I should have included more evidence to support my claim.


> [1] https://wiki.banana-pi.org/Banana_Pi_BPI-R2#Documents
> 
> [2] I've tested it on my MT7621AT board with a 40MHz XTAL frequency and 
> a
> board with standalone MT7530 with 25MHz XTAL frequency.
> 
> While the kernel was booting, before the DSA subdriver kicks in:
> - For the board with 40 MHz XTAL: I've connected a Vcc pin to 
> ESW_P3_LED_0
>   to set it high.

My board has a 40MHz crystal between XPTL_XI and XPTL_XO,
ESW_P4_LED_0 has a 4.7k pull up to 3.3V, and ESW_P3_LED_0
has a 4.7k pull down to GND.

For testing, I'm relying on the MT7530 itself to change the
ESW_P3_LED_0 level according to the link state.


> - For the board with 25 MHz XTAL: I've connected a GND pin to 
> ESW_P3_LED_0
>   to set it low.
> 
> Board with 40 MHz XTAL:
> [    2.359428] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip 
> module
> [    2.374918] mt7530-mdio mdio-bus:1f: xtal is 25MHz
> 
> Board with 25 MHz XTAL:
> [    4.324672] mt7530-mdio mdio-bus:1f: xtal is 40MHz
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 51d7b816dd02..beab5e5558d0 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2216,6 +2216,15 @@ mt7530_setup(struct dsa_switch *ds)
>  		return ret;
>  	}
>  +	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_25MHZ)
> +		dev_info(priv->dev, "xtal is 25MHz\n");
> +
> +	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
> +		dev_info(priv->dev, "xtal is 40MHz\n");
> +
> +	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_20MHZ)
> +		dev_info(priv->dev, "xtal is 20MHz\n");
> +
>  	id = mt7530_read(priv, MT7530_CREV);
>  	id >>= CHIP_NAME_SHIFT;
>  	if (id != MT7530_ID) {
> 
> Arınç

I took a similar approach, with calls to dev_info()
throughout mt7530_setup() plus mt7530_write(), mt7530_read()
and mt7530_rmw() to get an idea of the flow of execution and
which registers were being manipulated.

Calls to dev_info() affected timing, so I switched to using
trace_printk() and then read the output from the debugfs's
tracing/trace file instead of from the console.

I attached a logic analyzer to ESW_P4_LED_0 and ESW_P3_LED_0,
and manually triggered sampling as soon as execution of the
kernel was reported on UART1.


-- Test #1 -----------------------------------------------------------

For the sake of maximal reproducability, I removed the delay
between the assertion and deassertion of reset and added
HWTRAP value tracing:

---%---
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2243,7 +2243,6 @@ mt7530_setup(struct dsa_switch *ds)
	 */
	if (priv->mcm) {
		reset_control_assert(priv->rstc);
-		usleep_range(1000, 1100);
		reset_control_deassert(priv->rstc);
	} else {
		gpiod_set_value_cansleep(priv->reset, 0);
@@ -2260,6 +2259,10 @@ mt7530_setup(struct dsa_switch *ds)
		return ret;
	}

+	static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", "25MHz" 
};
+	trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
+		val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
+
         id = mt7530_read(priv, MT7530_CREV);
         id >>= CHIP_NAME_SHIFT;
         if (id != MT7530_ID) {
---%---

(a) Without a cable connected to Port 3 (lan4) before reset, the
correct external crystal frequency is selected:

               [3]      [4]     [6]
               :        :       :
               _________         ______________________________________
ESW_P4_LED_0           |_______|
                         _______
ESW_P3_LED_0  _________|       |______________________________________

                         :     :
                         [5]...:

[3] Port 4 LED Off. Port 3 LED On.
[4] Signals inverted. (reset_control_assert; reset_control_deassert)
[5] Period of 310 usec.
[6] Signals reflect the bootstrapped configuration.


~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
     2.432646: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz


(b) When a cable attached to an active peer is connected to
Port 3 (lan4) before reset, the incorrect crystal frequency
selection (0b11 = 25MHz) always occurs:

               [7]      [8]     [10]    [12]
               :        :       :       :
               _________         ______________________________________
ESW_P4_LED_0           |_______|
               _________         _______
ESW_P3_LED_0           |_______|       |______________________________

                         :     : :     :
                         [9]...: [11]..:

  [7] Port 4 LED Off. Port 3 LED Off.
  [8] Signals inverted. (reset_control_assert; reset_control_deassert)
  [9] Period of 320 usec.
[10] Signals inverted.
[11] Period of 300 usec.
[12] Signals reflect the bootstrapped configuration.

~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
     2.432884: mt7530_setup: HWTRAP = 7fcf, HT_XTAL_FSEL = 25MHz


-- Test #2 -----------------------------------------------------------

To attempt to determine which transitions are associated
with asserting and deasserting reset, I performed another
test with a delay of what I intended to be a 1 sec period
where the MT7530 is held in reset:

---%---
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2243,7 +2243,7 @@ mt7530_setup(struct dsa_switch *ds)
	 */
	if (priv->mcm) {
		reset_control_assert(priv->rstc);
-		usleep_range(1000, 1100);
+		usleep_range(1000000, 1000000);
		reset_control_deassert(priv->rstc);
	} else {
		gpiod_set_value_cansleep(priv->reset, 0);
@@ -2260,6 +2260,10 @@ mt7530_setup(struct dsa_switch *ds)
		return ret;
	}

+	static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", "25MHz" 
};
+	trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
+		val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
+
	id = mt7530_read(priv, MT7530_CREV);
	id >>= CHIP_NAME_SHIFT;
	if (id != MT7530_ID) {
---%---

(a) Without a cable connected to Port 3 (lan4) before reset, the
correct external crystal frequency is again selected:

               [13]     [14]    [16]
               :        :       :
               _________         ______________________________________
ESW_P4_LED_0           |_______|
                         _______
ESW_P3_LED_0  _________|       |______________________________________

                         :     :
                         [15]..:

[13] Port 4 LED Off. Port 3 LED On.
[14] Signals inverted. (reset_control_deassert?)
[15] Period of 310 usec.
[16] Signals reflect the bootstrapped configuration.


~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
     3.437461: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz


No difference is apparent in the timing diagram, compared
to the result from Test #1a, but it is obvious that the code
which follows the reset was executed about 1 second later.


(b) With a cable from an active peer connected to Port 3
(lan4) before reset, the correct crystal frequency
(0b10 = 40MHz) is selected:

               [17]     [18]                    [20]   [22]
               :        :                       :      :
               ______________________ \ \ ______        _______________
ESW_P4_LED_0                         / /       |______|
               _________              \ \        ______
ESW_P3_LED_0           |____________ / / ______|      |_______________
                                      \ \
                         :                     : :    :
                         [19]..................: [21].:

[17] Port 4 LED Off. Port 3 LED Off.
[18] ESW_P3_LED_0 set low. (reset_control_assert?)
[19] Period of 1000.325 msec.
[20] Signals inverted. (reset_control_deassert?)
[21] Period of 310 usec.
[22] Signals reflect the bootstrapped configuration.


~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
     3.433235: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz


So it appears that when reset is deasserted, the ESW_P4_LED_0
and ESW_P3_LED_0 levels are inverted for a period of about
300 - 310 usec in Test #1a, #1b, #2a, and #2b.

Co-incidentally, these inverted levels are the active low
representation of what ends up in HT_XTAL_FSEL. And in all
four examples, have been the inversion of what immediately
preceded reset_control_deassert().


-- Test #3 -----------------------------------------------------------

Now it seems that there is a signature that can be used
to identify when reset_control_deassert() is executed,
the time of reset_control_assert()'s execution should be
between (at most) 1100 and (at least) 1000 usec prior
based on the unmodified reset logic.

So this patch only includes the HT_XTAL_FSEL trace.

---%---
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2260,6 +2260,10 @@ mt7530_setup(struct dsa_switch *ds)
                 return ret;
         }

+       static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", 
"25MHz" };
+       trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
+               val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
+
         id = mt7530_read(priv, MT7530_CREV);
         id >>= CHIP_NAME_SHIFT;
         if (id != MT7530_ID) {
---%---

The purpose of the following examples are to show the
variance in how long it takes for ESW_P3_LED_0 to go low.

(a) With a cable from an active peer connected to Port 3
(lan4) before reset, the correct crystal frequency
(0b10 = 40MHz) is selected.

               [23]    [24]       [26]      [28]    [30]
               :       :          :         :       :
               _____________________________         __________________
ESW_P4_LED_0                               |_______|
               ___________________           _______
ESW_P3_LED_0                     |_________|       |__________________

                        :          :       : :     :
                        :          [27]....: [29]..:
                        [25]...............:

[23] Port 4 LED Off. Port 3 LED Off.
[24] Approximate point of reset_control_assert?
[25] Period of approximately 1000 - 1100 usec.
[26] ESW_P3_LED_0 finally goes low.
[27] Period of 415 usec.
[28] Signals inverted. (reset_control_deassert?)
[29] Period of 310 usec.
[30] Signals reflect the bootstrapped configuration.


(b) With a cable from an active peer connected to Port 3
(lan4) before reset, the correct crystal frequency
(0b10 = 40MHz) is selected.

               [31]    [32]            [34] [36]    [38]
               :       :                  : :       :
               _____________________________         __________________
ESW_P4_LED_0                               |_______|
               ___________________________   _______
ESW_P3_LED_0                             |_|       |__________________

                        :                  : :     :
                        :               [35] [37]..:
                        :                  :
                        [33]...............:

[31] Port 4 LED Off. Port 3 LED Off.
[32] Approximate point of reset_control_assert?
[33] Period of approximately 1000 - 1100 usec.
[34] ESW_P3_LED_0 finally goes low.
[35] Period of 50 usec.
[36] Signals inverted. (reset_control_deassert?)
[37] Period of 310 usec.
[38] Signals reflect the bootstrapped configuration.


(c) With a cable from an active peer connected to Port 3
(lan4) before reset, an incorrect crystal frequency
(0b11 = 25MHz) is selected.

               [45]    [46]                 [48]    [50]
               :       :                    :       :
               _____________________________         __________________
ESW_P4_LED_0                               |_______|
               _____________________________
ESW_P3_LED_0                               |__________________________

                        :                  : :     :
                        :                  : [49]..:
                        :                  :
                        [47]...............:

[45] Port 4 LED Off. Port 3 LED Off.
[46] Approximate point of reset_control_assert?
[47] Period of approximately 1000 - 1100 usec.
[48] Signals inverted. (reset_control_deassert?)
[49] Period of 315 usec.
[50] Signals reflect the bootstrapped configuration.

~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
     2.617819: mt7530_setup: HWTRAP = 7fcf, HT_XTAL_FSEL = 25MHz

~ # cat /proc/cmdline
console=ttyS0,57600 loglevel=7 printk.time=1 root=/dev/ram0 debug 
rdinit=/linuxrc


-- End of Tests ------------------------------------------------------

It seems that the incorrect crystal frequency is selected more
often when debugging messages are present (such as printk()
based approaches) and especially when loglevel=7 and printk.time=1
are specified on the command line.

For the sake of reference: I disabled ethernet support in my build
of (mainline) U-boot, and my kernel configuration is a very lean
selection of options suited for IP routing and a few peripherals
on the I2C and SPI buses.

My userland is confined to an initramfs built around busybox.

I also disable gmac1 because I need a few of the rgmii2 pins for
modem control signalling.

Regards
Justin

PS: Yes, I only have access to MT7621AT SoCs.


> On 5.03.2024 07:39, Justin Swartz wrote:
>> Disable LEDs just before resetting the MT7530 to avoid
>> situations where the ESW_P4_LED_0 and ESW_P3_LED_0 pin
>> states may cause an unintended external crystal frequency
>> to be selected.
>> 
>> The HT_XTAL_FSEL (External Crystal Frequency Selection)
>> field of HWTRAP (the Hardware Trap register) stores a
>> 2-bit value that represents the state of the ESW_P4_LED_0
>> and ESW_P4_LED_0 pins (seemingly) sampled just after the
>> MT7530 has been reset, as:
>> 
>>      ESW_P4_LED_0    ESW_P3_LED_0    Frequency
>>      -----------------------------------------
>>      0               1               20MHz
>>      1               0               40MHz
>>      1               1               25MHz
>> 
>> The value of HT_XTAL_FSEL is bootstrapped by pulling
>> ESW_P4_LED_0 and ESW_P3_LED_0 up or down accordingly,
>> but:
>> 
>>    if a 40MHz crystal has been selected and
>>    the ESW_P3_LED_0 pin is high during reset,
>> 
>>    or a 20MHz crystal has been selected and
>>    the ESW_P4_LED_0 pin is high during reset,
>> 
>>    then the value of HT_XTAL_FSEL will indicate
>>    that a 25MHz crystal is present.
>> 
>> By default, the state of the LED pins is PHY controlled
>> to reflect the link state.
>> 
>> To illustrate, if a board has:
>> 
>>    5 ports with active low LED control,
>>    and HT_XTAL_FSEL bootstrapped for 40MHz.
>> 
>> When the MT7530 is powered up without any external
>> connection, only the LED associated with Port 3 is
>> illuminated as ESW_P3_LED_0 is low.
>> 
>> In this state, directly after mt7530_setup()'s reset
>> is performed, the HWTRAP register (0x7800) reflects
>> the intended HT_XTAL_FSEL (HWTRAP bits 10:9) of 40MHz:
>> 
>>    mt7530-mdio mdio-bus:1f: mt7530_read: 00007800 == 00007dcf
>> 
>>    >>> bin(0x7dcf >> 9 & 0b11)
>>    '0b10'
>> 
>> But if a cable is connected to Port 3 and the link
>> is active before mt7530_setup()'s reset takes place,
>> then HT_XTAL_FSEL seems to be set for 25MHz:
>> 
>>    mt7530-mdio mdio-bus:1f: mt7530_read: 00007800 == 00007fcf
>> 
>>    >>> bin(0x7fcf >> 9 & 0b11)
>>    '0b11'
>> 
>> Once HT_XTAL_FSEL reflects 25MHz, none of the ports
>> are functional until the MT7621 (or MT7530 itself)
>> is reset.
>> 
>> By disabling the LED pins just before reset, the chance
>> of an unintended HT_XTAL_FSEL value is reduced.
>> 
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>> ---
>>   drivers/net/dsa/mt7530.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>> 
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index 3c1f65759..8fa113126 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2238,6 +2238,12 @@ mt7530_setup(struct dsa_switch *ds)
>>   		}
>>   	}
>>   +	/* Disable LEDs before reset to prevent the MT7530 sampling a
>> +	 * potentially incorrect HT_XTAL_FSEL value.
>> +	 */
>> +	mt7530_write(priv, MT7530_LED_EN, 0);
>> +	usleep_range(1000, 1100);
>> +
>>   	/* Reset whole chip through gpio pin or memory-mapped registers for
>>   	 * different type of hardware
>>   	 */

