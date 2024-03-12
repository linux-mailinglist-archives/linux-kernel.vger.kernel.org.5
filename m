Return-Path: <linux-kernel+bounces-99793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1D878D73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D751F21FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA2B642;
	Tue, 12 Mar 2024 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="TDHOAvTc"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12CBE47;
	Tue, 12 Mar 2024 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213468; cv=none; b=FI7wdVAiBUqpoXFsNO1VlDKGh/BrJ4LBUiX/eXqr/NI+hMjgFa4BCLsq5EoXxz2IMiw1c90gAP2jjsJKs7VXOhQO9kvJhaWJ/DJOXxchUeYva0ttJjTZSAYsIFTxclSn7ZohLpzrpmgRZ/i/YqCe5fQOPW03w+sP4wOADuMlBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213468; c=relaxed/simple;
	bh=gCU/8+rGJquOzWlNFTKioOfIucB/209HLTC6XzQ2oO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEZaW4AoLMxGiRWpBBfYWxK6dcmVgpCTOqto6NorDiuuxfyvfKi+JSOMfwhbt3wApMTX4x7lFw5726Lwizz/HzwmKxTYtE8KrqbwzONcx3pm9E3euNowCO8SnomhpSKcvWWyN2NHjHmO77TXzZ5YN8pbBjv66Dz+e2ab/6lQEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=TDHOAvTc; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4B9E20004;
	Tue, 12 Mar 2024 03:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710213463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFmSRgpKIHH0ycxxrAMw+1qR99TDGu7qYDmZTP8gJrs=;
	b=TDHOAvTc6rbQ6YCr1txxvT1IGNL5xX5QrU5j0HpZXu+C4q26mETHl3rgkfsn2xUClcTtNz
	S4AFgqnUXX+UWzm7gKJq3NGQ2FMybEkhgrY8p4/trE26tsZwSrMETeYEgUhNlgJQ382HFe
	b9O/kLchk+8zreKrdBkGhkeiFoSl5WDIH/XAi/H+GSSRK79J+jOutb7tal0FSlqHBSr41R
	Pk1BGEq/8WV5c0iY4hq/xOaLWRUEBaPPS4hnsPWilfFheyY4DvOpGYYYQGY34CleZefl7x
	LH6EvOY0r6HIb/vcmGBXBFPmFEcOpCc6b8QgX3lRyyjN9w0W6mB8rNNJVHWW7w==
Message-ID: <6d601f06-7760-41d7-a190-2f370f7827ba@arinc9.com>
Date: Tue, 12 Mar 2024 06:17:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: patchwork-bot+netdevbpf@kernel.org,
 Justin Swartz <justin.swartz@risingedge.co.za>, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <171019143163.14853.15330891015381229970.git-patchwork-notify@kernel.org>
 <2d206dbb-a27b-4139-a49e-331797d8ba34@arinc9.com>
 <Ze9-mp269h43WGD3@makrotopia.org>
 <2846b377-f45b-45fd-9fe2-cb22615e0fd5@arinc9.com>
 <Ze-XHH4yFjXC0p11@makrotopia.org>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Ze-XHH4yFjXC0p11@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 12.03.2024 02:43, Daniel Golle wrote:
> On Tue, Mar 12, 2024 at 02:27:25AM +0300, Arınç ÜNAL wrote:
>> On 12.03.2024 00:58, Daniel Golle wrote:
>>> On Tue, Mar 12, 2024 at 12:22:48AM +0300, Arınç ÜNAL wrote:
>>>> Why was this applied? I already explained it did not achieve anything.
>>>
>>> I agree that we were still debating about it, however, I do believe
>>> Justin that he truely observed this problem and the fix seemed
>>> appropriate to me.
>>>
>>> I've explained this in my previous email which you did not notice
>>> or at least haven't repied to:
>>>
>>> https://patchwork.kernel.org/project/netdevbpf/patch/20240305043952.21590-1-justin.swartz@risingedge.co.za/#25753421
>>
>> I did read that and I did not respond because you did not argue over any of
>> the technical points I've made. All you said was did I repeat the test
>> enough, on a technical matter that I consider adding two and two together
>> and expecting a result other than four.
>>
>> How I interpreted your response was: I don't know much about this, maybe
>> you're wrong. Justin must've made this patch for a reason so let's have
>> them elaborate further.
>>
>>>
>>> In the end it probably depends on the electric capacity of the circuit
>>> connecting each LED, so it may not be reproducible on all boards and/or
>>> under all circumstances (temperature, humindity, ...).
>>
>> I'm sorry, this makes no sense to me. I simply fail to see how this fits
>> here. Could you base your argument over my points please?
> 
> Sure, will happily do so.
> 
>>
>> Do you agree that the LED controller starts manipulating the state of the
>> pins used for LEDs and bootstrapping after a link is established?
> 
> Yes. But a reset may happen while a link is already up because the switch IC
> was initialized and in use by the bootloader. And hence LED may be powered
> by the LED controller in that moment **just before reset**.

Yes.

> 
>>
>> Do you agree that after power is cut from the switch IC and then given
>> back, any active link from before will go away, meaning the pins will go
>> back to the state that is being dictated by the bootstrapping design of the
>> board?
> 
> I don't see how this could be related. We are not talking about power cuts
> here, but rather use of a RESET signal (typically a GPIO on standalone MT753x
> or reset controller of the CPU-part of the MCM).

Ok that makes sense. Thanks for clearing that up for me.

> 
>>
>> Do you agree that with power given back, the HWTRAP register will be
>> populated before a link is established?
> 
> Yes sure, but see above.
> 
>>
>>>
>>> Disabling the LEDs and waiting for around 1mS before reset seems like
>>> a sensible thing to do, and I'm glad Justin took care of it.
>>
>> Let's ask Justin if they tested this on a standalone MT7530. Because I did.
>> The switch chip won't even be powered on before the switch chip reset
>> operation is done. So the operation this patch brings does not do anything
>> at all for standalone MT7530.
> 
> This is not true in case the bootloader has already powered on the
> switch in order to load firmware via TFTP. In this case the link may
> be up (and hence LEDs may be powered on) at the moment the reset
> triggerd by probe of the DSA driver kicks in.

This diff works on MCM MT7530 on MT7621AT. Not on standalone MT7530 on
MT7623NI SoC. Also, I believe the LEDs turn off at the first mt7530_probe()
which returns -EPROBE_DEFER.

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index b012cbb249e4..f1a5673baa55 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2247,6 +2247,24 @@ mt7530_setup(struct dsa_switch *ds)
  		}
  	}
  
+	/* Waiting for MT7530 got to stable */
+	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_HWTRAP);
+	ret = readx_poll_timeout(_mt7530_read, &p, val, val != 0,
+				 20, 1000000);
+	if (ret < 0) {
+		dev_err(priv->dev, "reset timeout\n");
+		return ret;
+	}
+
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_25MHZ)
+		dev_info(priv->dev, "xtal is 25MHz\n");
+
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
+		dev_info(priv->dev, "xtal is 40MHz\n");
+
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_20MHZ)
+		dev_info(priv->dev, "xtal is 20MHz\n");
+
  	/* Reset whole chip through gpio pin or memory-mapped registers for
  	 * different type of hardware
  	 */

[    5.319534] mt7530-mdio mdio-bus:1f: reset timeout
[    5.324371] mt7530-mdio: probe of mdio-bus:1f failed with error -110
[    5.330803] ------------[ cut here ]------------
[    5.335427] WARNING: CPU: 2 PID: 36 at drivers/regulator/core.c:2398 _regulator_put+0x15c/0x164
[    5.344180] Modules linked in:
[    5.347248] CPU: 2 PID: 36 Comm: kworker/u19:0 Not tainted 6.8.0-rc7-next-20240306+ #36
[    5.355264] Hardware name: Mediatek Cortex-A7 (Device Tree)
[    5.360841] Workqueue: events_unbound deferred_probe_work_func
[    5.366694] Call trace:
[    5.366710]  unwind_backtrace from show_stack+0x10/0x14
[    5.374487]  show_stack from dump_stack_lvl+0x54/0x68
[    5.379551]  dump_stack_lvl from __warn+0x94/0xc0
[    5.384272]  __warn from warn_slowpath_fmt+0x184/0x18c
[    5.389431]  warn_slowpath_fmt from _regulator_put+0x15c/0x164
[    5.395283]  _regulator_put from regulator_put+0x1c/0x2c
[    5.400611]  regulator_put from devres_release_all+0x98/0xfc
[    5.406290]  devres_release_all from device_unbind_cleanup+0xc/0x60
[    5.412577]  device_unbind_cleanup from really_probe+0x25c/0x3f4
[    5.418603]  really_probe from __driver_probe_device+0x9c/0x130
[    5.424543]  __driver_probe_device from driver_probe_device+0x30/0xc0
[    5.431003]  driver_probe_device from __device_attach_driver+0xa8/0x120
[    5.437639]  __device_attach_driver from bus_for_each_drv+0x90/0xe4
[    5.443927]  bus_for_each_drv from __device_attach+0xa8/0x1d4
[    5.449692]  __device_attach from bus_probe_device+0x88/0x8c
[    5.455370]  bus_probe_device from deferred_probe_work_func+0x8c/0xd4
[    5.461829]  deferred_probe_work_func from process_one_work+0x158/0x2e4
[    5.468465]  process_one_work from worker_thread+0x264/0x488
[    5.474142]  worker_thread from kthread+0xd4/0xd8
[    5.478865]  kthread from ret_from_fork+0x14/0x28
[    5.483583] Exception stack(0xf08bdfb0 to 0xf08bdff8)
[    5.488642] dfa0:                                     00000000 00000000 00000000 00000000
[    5.496829] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.505015] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.511688] ---[ end trace 0000000000000000 ]---
[    5.516493] ------------[ cut here ]------------
[    5.521153] WARNING: CPU: 2 PID: 36 at drivers/regulator/core.c:2398 _regulator_put+0x15c/0x164
[    5.529904] Modules linked in:
[    5.532970] CPU: 2 PID: 36 Comm: kworker/u19:0 Tainted: G        W          6.8.0-rc7-next-20240306+ #36
[    5.542462] Hardware name: Mediatek Cortex-A7 (Device Tree)
[    5.548038] Workqueue: events_unbound deferred_probe_work_func
[    5.553890] Call trace:
[    5.553900]  unwind_backtrace from show_stack+0x10/0x14
[    5.561673]  show_stack from dump_stack_lvl+0x54/0x68
[    5.566737]  dump_stack_lvl from __warn+0x94/0xc0
[    5.571457]  __warn from warn_slowpath_fmt+0x184/0x18c
[    5.576615]  warn_slowpath_fmt from _regulator_put+0x15c/0x164
[    5.582465]  _regulator_put from regulator_put+0x1c/0x2c
[    5.587794]  regulator_put from devres_release_all+0x98/0xfc
[    5.593471]  devres_release_all from device_unbind_cleanup+0xc/0x60
[    5.599757]  device_unbind_cleanup from really_probe+0x25c/0x3f4
[    5.605784]  really_probe from __driver_probe_device+0x9c/0x130
[    5.611724]  __driver_probe_device from driver_probe_device+0x30/0xc0
[    5.618184]  driver_probe_device from __device_attach_driver+0xa8/0x120
[    5.624819]  __device_attach_driver from bus_for_each_drv+0x90/0xe4
[    5.631106]  bus_for_each_drv from __device_attach+0xa8/0x1d4
[    5.636871]  __device_attach from bus_probe_device+0x88/0x8c
[    5.642549]  bus_probe_device from deferred_probe_work_func+0x8c/0xd4
[    5.649009]  deferred_probe_work_func from process_one_work+0x158/0x2e4
[    5.655644]  process_one_work from worker_thread+0x264/0x488
[    5.661321]  worker_thread from kthread+0xd4/0xd8
[    5.666042]  kthread from ret_from_fork+0x14/0x28
[    5.670759] Exception stack(0xf08bdfb0 to 0xf08bdff8)
[    5.675818] dfa0:                                     00000000 00000000 00000000 00000000
[    5.684004] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.692189] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.698858] ---[ end trace 0000000000000000 ]---

> 
>>
>> My conclusion to this patch is Justin tested this only on an MCM MT7530
>> where the switch IC still has power before the DSA subdriver kicks in. And
>> assumed that disabling the LED controller before switch chip reset would
>> "reduce" the possibility of having these pins continue being manipulated by
>> the LED controller AFTER power is cut off and given back to the switch
>> chip, where the state of these pins would be back to being dictated by the
>> bootstrapping design of the board.
>>
>> Jakub, please revert this. And please next time do not apply any patch that
>> modifies this driver without my approval if I've already made an argument
>> against it. I'm actively maintaining this driver, if there's a need to
>> respond, I will do so.
>>
>> This patch did not have any ACKs. It also did not have the tree described
>> on the subject. More reasons as to why this shouldn't have been applied in
>> its current state.
> 
> It was clearly recognizable as a fix.

I see that it was applied to the net-next tree[1], not net[2]. Looks like
it wasn't clear enough. Let's follow the rules.

> 
> However, I agree that applying it after Ack from an active maintainer
> would have been better.
> 
> I don't see a need to revert it before this debate (which starts to
> look like an argument over authority) has concluded.

Let's hope this patch makes its way to the net tree.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/drivers/net/dsa/mt7530.c
[2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/drivers/net/dsa/mt7530.c

Arınç

