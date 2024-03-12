Return-Path: <linux-kernel+bounces-99773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D258E878D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615F11F21C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA88821;
	Tue, 12 Mar 2024 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ZA5cl/PO"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E016FF5D;
	Tue, 12 Mar 2024 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211317; cv=none; b=Qh/iBnrxHAxWOubk9ZDPJB0/7wqAEyz8wYGer3EQhoQ3jLveO21EzHEr80FnChCXqiHPIIHOf6I4BKanw9CtNvycTUMMHCQVGZu1d1Ojv7gGCsEqwErOHUF1snSitSlt43r3jz62CY0/9saIk6koQ7SAa4SQfXhVw6BCcVsTLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211317; c=relaxed/simple;
	bh=WghVTLJ/pNL9tqJAipEvCZNZRvyB2Rzf2GsLBlWTzSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXly0gVkrD1vaFA2ykvGacEo8T9r6vBWyvEMk5FeNdtZywF4qOe8x36jM6ACUhCrJzh7zBgtvXy+HhZIqd3JHe+EVNC8DmBWHpOTqHUyyxYIn7jhRnOGp7SDwWCcxJ6rlan7BLVLX7yLckXjNv0YfFZrbiXT4jbBylAseHqAF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ZA5cl/PO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35A22240002;
	Tue, 12 Mar 2024 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710211312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJTPKj60zcN9dfLjCmksy1GRGg5SNemdWJWV0WcBEcs=;
	b=ZA5cl/POcCQ8VUi89UNJHBVbi+RfVeT8PJAzEidNYwxJp4Ujd6xmGMh1L0hCOdGqoRWIWW
	kpw5PRSc0zXebXOS/TYFMEy5siY2Hj6egAbvCjjVp7bo7Im2t0CndNxlYxjXAYI41BXff0
	jr1Tf3vdu0MwI1qT6PzEgLsaIsGtBy2/wYddOY0H66VFt3PHe4DmK4livXLhM2BTreOvU4
	i88dty58H27aVmyG0+H+nugRJiovZEc77yA5BOjI8F5CHwWxvdHSgAG4OUMnNUOql4U3mo
	EuypFdicgiPLnsh3yhBH4Eu6aFViQCESPSuOP2VUc7ZrMXlEXd4JGdYcVYo6Qg==
Message-ID: <1bfd93f1-36d5-436e-818e-2ebdcf475b44@arinc9.com>
Date: Tue, 12 Mar 2024 05:41:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <d45083788db8b0b1ace051adecfe6a3a@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 12.03.2024 03:07, Justin Swartz wrote:
> I took a similar approach, with calls to dev_info()
> throughout mt7530_setup() plus mt7530_write(), mt7530_read()
> and mt7530_rmw() to get an idea of the flow of execution and
> which registers were being manipulated.
> 
> Calls to dev_info() affected timing, so I switched to using
> trace_printk() and then read the output from the debugfs's
> tracing/trace file instead of from the console.
> 
> I attached a logic analyzer to ESW_P4_LED_0 and ESW_P3_LED_0,
> and manually triggered sampling as soon as execution of the
> kernel was reported on UART1.
> 
> 
> -- Test #1 -----------------------------------------------------------
> 
> For the sake of maximal reproducability, I removed the delay
> between the assertion and deassertion of reset and added
> HWTRAP value tracing:
> 
> ---%---
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2243,7 +2243,6 @@ mt7530_setup(struct dsa_switch *ds)
>       */
>      if (priv->mcm) {
>          reset_control_assert(priv->rstc);
> -        usleep_range(1000, 1100);
>          reset_control_deassert(priv->rstc);
>      } else {
>          gpiod_set_value_cansleep(priv->reset, 0);
> @@ -2260,6 +2259,10 @@ mt7530_setup(struct dsa_switch *ds)
>          return ret;
>      }
> 
> +    static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", "25MHz" };
> +    trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
> +        val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
> +
>          id = mt7530_read(priv, MT7530_CREV);
>          id >>= CHIP_NAME_SHIFT;
>          if (id != MT7530_ID) {
> ---%---
> 
> (a) Without a cable connected to Port 3 (lan4) before reset, the
> correct external crystal frequency is selected:
> 
>                [3]      [4]     [6]
>                :        :       :
>                _________         ______________________________________
> ESW_P4_LED_0           |_______|
>                          _______
> ESW_P3_LED_0  _________|       |______________________________________
> 
>                          :     :
>                          [5]...:
> 
> [3] Port 4 LED Off. Port 3 LED On.
> [4] Signals inverted. (reset_control_assert; reset_control_deassert)
> [5] Period of 310 usec.
> [6] Signals reflect the bootstrapped configuration.
> 
> 
> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>      2.432646: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz
> 
> 
> (b) When a cable attached to an active peer is connected to
> Port 3 (lan4) before reset, the incorrect crystal frequency
> selection (0b11 = 25MHz) always occurs:
> 
>                [7]      [8]     [10]    [12]
>                :        :       :       :
>                _________         ______________________________________
> ESW_P4_LED_0           |_______|
>                _________         _______
> ESW_P3_LED_0           |_______|       |______________________________
> 
>                          :     : :     :
>                          [9]...: [11]..:
> 
>   [7] Port 4 LED Off. Port 3 LED Off.
>   [8] Signals inverted. (reset_control_assert; reset_control_deassert)
>   [9] Period of 320 usec.
> [10] Signals inverted.
> [11] Period of 300 usec.
> [12] Signals reflect the bootstrapped configuration.
> 
> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>      2.432884: mt7530_setup: HWTRAP = 7fcf, HT_XTAL_FSEL = 25MHz
> 
> 
> -- Test #2 -----------------------------------------------------------
> 
> To attempt to determine which transitions are associated
> with asserting and deasserting reset, I performed another
> test with a delay of what I intended to be a 1 sec period
> where the MT7530 is held in reset:
> 
> ---%---
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2243,7 +2243,7 @@ mt7530_setup(struct dsa_switch *ds)
>       */
>      if (priv->mcm) {
>          reset_control_assert(priv->rstc);
> -        usleep_range(1000, 1100);
> +        usleep_range(1000000, 1000000);
>          reset_control_deassert(priv->rstc);
>      } else {
>          gpiod_set_value_cansleep(priv->reset, 0);
> @@ -2260,6 +2260,10 @@ mt7530_setup(struct dsa_switch *ds)
>          return ret;
>      }
> 
> +    static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", "25MHz" };
> +    trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
> +        val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
> +
>      id = mt7530_read(priv, MT7530_CREV);
>      id >>= CHIP_NAME_SHIFT;
>      if (id != MT7530_ID) {
> ---%---
> 
> (a) Without a cable connected to Port 3 (lan4) before reset, the
> correct external crystal frequency is again selected:
> 
>                [13]     [14]    [16]
>                :        :       :
>                _________         ______________________________________
> ESW_P4_LED_0           |_______|
>                          _______
> ESW_P3_LED_0  _________|       |______________________________________
> 
>                          :     :
>                          [15]..:
> 
> [13] Port 4 LED Off. Port 3 LED On.
> [14] Signals inverted. (reset_control_deassert?)
> [15] Period of 310 usec.
> [16] Signals reflect the bootstrapped configuration.
> 
> 
> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>      3.437461: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz
> 
> 
> No difference is apparent in the timing diagram, compared
> to the result from Test #1a, but it is obvious that the code
> which follows the reset was executed about 1 second later.
> 
> 
> (b) With a cable from an active peer connected to Port 3
> (lan4) before reset, the correct crystal frequency
> (0b10 = 40MHz) is selected:
> 
>                [17]     [18]                    [20]   [22]
>                :        :                       :      :
>                ______________________ \ \ ______        _______________
> ESW_P4_LED_0                         / /       |______|
>                _________              \ \        ______
> ESW_P3_LED_0           |____________ / / ______|      |_______________
>                                       \ \
>                          :                     : :    :
>                          [19]..................: [21].:
> 
> [17] Port 4 LED Off. Port 3 LED Off.
> [18] ESW_P3_LED_0 set low. (reset_control_assert?)
> [19] Period of 1000.325 msec.
> [20] Signals inverted. (reset_control_deassert?)
> [21] Period of 310 usec.
> [22] Signals reflect the bootstrapped configuration.
> 
> 
> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>      3.433235: mt7530_setup: HWTRAP = 7dcf, HT_XTAL_FSEL = 40MHz
> 
> 
> So it appears that when reset is deasserted, the ESW_P4_LED_0
> and ESW_P3_LED_0 levels are inverted for a period of about
> 300 - 310 usec in Test #1a, #1b, #2a, and #2b.
> 
> Co-incidentally, these inverted levels are the active low
> representation of what ends up in HT_XTAL_FSEL. And in all
> four examples, have been the inversion of what immediately
> preceded reset_control_deassert().
> 
> 
> -- Test #3 -----------------------------------------------------------
> 
> Now it seems that there is a signature that can be used
> to identify when reset_control_deassert() is executed,
> the time of reset_control_assert()'s execution should be
> between (at most) 1100 and (at least) 1000 usec prior
> based on the unmodified reset logic.
> 
> So this patch only includes the HT_XTAL_FSEL trace.
> 
> ---%---
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2260,6 +2260,10 @@ mt7530_setup(struct dsa_switch *ds)
>                  return ret;
>          }
> 
> +       static char ht_xtal_fsel[4][6] = { "?????", "20MHz", "40MHz", "25MHz" };
> +       trace_printk("HWTRAP = %x, HT_XTAL_FSEL = %s\n",
> +               val, ht_xtal_fsel[(val & HWTRAP_XTAL_MASK) >> 9]);
> +
>          id = mt7530_read(priv, MT7530_CREV);
>          id >>= CHIP_NAME_SHIFT;
>          if (id != MT7530_ID) {
> ---%---
> 
> The purpose of the following examples are to show the
> variance in how long it takes for ESW_P3_LED_0 to go low.
> 
> (a) With a cable from an active peer connected to Port 3
> (lan4) before reset, the correct crystal frequency
> (0b10 = 40MHz) is selected.
> 
>                [23]    [24]       [26]      [28]    [30]
>                :       :          :         :       :
>                _____________________________         __________________
> ESW_P4_LED_0                               |_______|
>                ___________________           _______
> ESW_P3_LED_0                     |_________|       |__________________
> 
>                         :          :       : :     :
>                         :          [27]....: [29]..:
>                         [25]...............:
> 
> [23] Port 4 LED Off. Port 3 LED Off.
> [24] Approximate point of reset_control_assert?
> [25] Period of approximately 1000 - 1100 usec.
> [26] ESW_P3_LED_0 finally goes low.
> [27] Period of 415 usec.
> [28] Signals inverted. (reset_control_deassert?)
> [29] Period of 310 usec.
> [30] Signals reflect the bootstrapped configuration.
> 
> 
> (b) With a cable from an active peer connected to Port 3
> (lan4) before reset, the correct crystal frequency
> (0b10 = 40MHz) is selected.
> 
>                [31]    [32]            [34] [36]    [38]
>                :       :                  : :       :
>                _____________________________         __________________
> ESW_P4_LED_0                               |_______|
>                ___________________________   _______
> ESW_P3_LED_0                             |_|       |__________________
> 
>                         :                  : :     :
>                         :               [35] [37]..:
>                         :                  :
>                         [33]...............:
> 
> [31] Port 4 LED Off. Port 3 LED Off.
> [32] Approximate point of reset_control_assert?
> [33] Period of approximately 1000 - 1100 usec.
> [34] ESW_P3_LED_0 finally goes low.
> [35] Period of 50 usec.
> [36] Signals inverted. (reset_control_deassert?)
> [37] Period of 310 usec.
> [38] Signals reflect the bootstrapped configuration.
> 
> 
> (c) With a cable from an active peer connected to Port 3
> (lan4) before reset, an incorrect crystal frequency
> (0b11 = 25MHz) is selected.
> 
>                [45]    [46]                 [48]    [50]
>                :       :                    :       :
>                _____________________________         __________________
> ESW_P4_LED_0                               |_______|
>                _____________________________
> ESW_P3_LED_0                               |__________________________
> 
>                         :                  : :     :
>                         :                  : [49]..:
>                         :                  :
>                         [47]...............:
> 
> [45] Port 4 LED Off. Port 3 LED Off.
> [46] Approximate point of reset_control_assert?
> [47] Period of approximately 1000 - 1100 usec.
> [48] Signals inverted. (reset_control_deassert?)
> [49] Period of 315 usec.
> [50] Signals reflect the bootstrapped configuration.
> 
> ~ # sed -n -e '$s/^.*\. //p' /sys/kernel/debug/tracing/trace
>      2.617819: mt7530_setup: HWTRAP = 7fcf, HT_XTAL_FSEL = 25MHz
> 
> ~ # cat /proc/cmdline
> console=ttyS0,57600 loglevel=7 printk.time=1 root=/dev/ram0 debug rdinit=/linuxrc
> 
> 
> -- End of Tests ------------------------------------------------------
> 
> It seems that the incorrect crystal frequency is selected more
> often when debugging messages are present (such as printk()
> based approaches) and especially when loglevel=7 and printk.time=1
> are specified on the command line.
> 
> For the sake of reference: I disabled ethernet support in my build
> of (mainline) U-boot, and my kernel configuration is a very lean
> selection of options suited for IP routing and a few peripherals
> on the I2C and SPI buses.
> 
> My userland is confined to an initramfs built around busybox.
> 
> I also disable gmac1 because I need a few of the rgmii2 pins for
> modem control signalling.
> 
> Regards
> Justin
> 
> PS: Yes, I only have access to MT7621AT SoCs.

Thanks for the detailed presentation. I've simplified it to this, from what
I understood.

--- Currently -------------------------------------------------------------

With a cable from an active peer connected to Port 3 (lan4) before
reset:

Test 1, the correct crystal frequency (0b10 = 40MHz) is selected.

                       [1]        [2-1]     [3]     [5]
                       :          :         :       :
               _____________________________         __________________
ESW_P4_LED_0                               |_______|
               ___________________           _______
ESW_P3_LED_0                     |_________|       |__________________

                        :          :       : :     :
                        :          [2-2]...: [4]...:
                        [2]................:

[1] reset_control_assert.
[2] Period of 1000 - 1100 usec.
[2-1] ESW_P3_LED_0 goes low.
[2-2] Period of 415 usec.
[3] reset_control_deassert.
[4] Period of 310 usec. HWTRAP register is populated with bootstrapped
     XTAL frequency.
[5] Signals reflect the bootstrapped configuration.

Test 2, an incorrect crystal frequency (0b11 = 25MHz) is selected.

                       [2]                  [4]     [6]
                       :                    :       :
               _____________________________         __________________
ESW_P4_LED_0                               |_______|
               _____________________________
ESW_P3_LED_0                               |__________________________

                        :                  : :     :
                        :                  : [5]...:
                        :                  :
                        [3]................:

[1] reset_control_assert.
[2] Period of 1000 - 1100 usec.
[3] reset_control_deassert.
[5] Period of 315 usec. HWTRAP register is populated with incorrect
     XTAL frequency.
[6] Signals reflect the bootstrapped configuration.

--- 1 second delay between assert and deassert ----------------------------

With a cable from an active peer connected to Port 3 (lan4) before
reset, the correct crystal frequency (0b10 = 40MHz) is selected:

                       [1]        [2-1]     [3]     [5]
                       :          :         :       :
               _____________________________         __________________
ESW_P4_LED_0                               |_______|
               ___________________           _______
ESW_P3_LED_0                     |_________|       |__________________

                        :          :       : :     :
                        :          [2-2]...: [4]...:
                        [2]................:

[1] reset_control_assert.
[3] Period of 1000.325 msec.
[2-1] ESW_P3_LED_0 goes low.
[2-2] Remaining period of 1000.325 msec.
[3] reset_control_deassert.
[4] Period of 310 usec. HWTRAP register is populated with bootstrapped
     XTAL frequency.
[5] Signals reflect the bootstrapped configuration.

---

Wouldn't it be a better idea to increase the delay between
reset_control_assert() and reset_control_deassert(), and
gpiod_set_value_cansleep(priv->reset, 0) and
gpiod_set_value_cansleep(priv->reset, 1) instead of disabling the LED
controller and delaying before reset?

One MT7531 pin used for an LED is also used to decide the crystal frequency
between 40MHz and 25Mhz. We should implement this there as well.

Arınç

