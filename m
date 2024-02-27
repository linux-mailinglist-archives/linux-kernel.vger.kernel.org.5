Return-Path: <linux-kernel+bounces-82980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5E6868C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA726281524
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90D1369BC;
	Tue, 27 Feb 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G7jS74uR"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397701369A3;
	Tue, 27 Feb 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026852; cv=none; b=YHfgAmfqKV8elq+w8o5m6GQH9VxTOt5FdxzZCE44als8/kmKbatnjQ9LTvjloGOSvicOl3SfDy9ruKOaVBSP4nt/1/4TBXxhikfkpjFEgqZYPyoRRIhCVrX+vbHM3cDXjYJSog7TsEAAYP1Wbfi4WutekPy4La4Qkg9HuOYnLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026852; c=relaxed/simple;
	bh=1RTEAdFFHOEmxNBmqAuXPQRIA7GMEv6Hxi5j0Y8gqRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmOmy039iAfGkmCA9NiPllzi17Ky1NJxoqeNlVlPlzGE/Bi/OnVk3jRWTrjww2uD6viCe9WvkoR0Y0EoOb3bnwxbYqAEkJdHj1jBSWgoEp9nBFs4KR9vcV9V5Li3Kn6XTgUqHLrnbvAIbdBuKCz/V6yyQboS1FYkprkjtOXEQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G7jS74uR; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFAB5C0002;
	Tue, 27 Feb 2024 09:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709026848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmn0FjbhKH+X6W94t2nXwylEPzw7F/tZLjHorPr0+mk=;
	b=G7jS74uRsUCaZ5E75Nq45zmqM7nb7gdxLE+r0CITcsJKVEX8RwON39N9Bn/jSuuRlsV+jz
	1ZKUSEdlhJJVXYwUpUv/vcv1vqQKj7GcWNEczMtfO7Uy2UxLbtcRyvPIJEl1O6CHkwoH/B
	OPc55phx1zLp4VtCbEf6OUzVc3z2rq9it5Y4ZkWc4SOv4QovWrBCZxe8dlim1WJN+FWgz3
	As8H6DwpFXG/KWoFsnFudAH2f2xXQ6xFn8USrBpUJa9S1Mteb5ScZKfgWOsg5IQBZx/EKK
	rDoo8GPQxSvegGQe92oUwtIHM1O6xNsyXMI2sw7XSSWrheyISovuX7EEmWz8Gg==
Message-ID: <951bc29a-4483-4f4a-9c4e-900db9391112@bootlin.com>
Date: Tue, 27 Feb 2024 10:40:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit statistics
 counters
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Jisheng Zhang <jszhang@kernel.org>, Petr Tesarik <petr@tesarici.cz>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 Marc Haber <mh+netdev@zugschlus.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org
References: <20240203190927.19669-1-petr@tesarici.cz>
 <ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>
 <Zct5qJcZw0YKx54r@xhacker>
 <CANn89i+4tVWezqr=BYZ5AF=9EgV2EPqhdHun=u=ga32CEJ4BXQ@mail.gmail.com>
 <20d94512-c4f2-49f7-ac97-846dc24a6730@roeck-us.net>
 <CANn89iL1piwsbsBx4Z=kySUfmPa9LbZn-SNthgA+W6NEnojgSQ@mail.gmail.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <CANn89iL1piwsbsBx4Z=kySUfmPa9LbZn-SNthgA+W6NEnojgSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello, 
FWIW I'm seeing this splat too on STM32MP157 with 6.8.0-rc5 (from wireless tree). It happens systematically a few seconds after link up

[   27.884703] ================================
[   27.888988] WARNING: inconsistent lock state
[   27.893271] 6.8.0-rc5-g59460f7f45e6-dirty #16 Not tainted
[   27.898671] --------------------------------
[   27.902951] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[   27.908954] swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[   27.914155] d7b764ac (&syncp->seq#3){?.-.}-{0:0}, at: dwmac4_dma_interrupt+0xc4/0x2a8
[   27.921974] {HARDIRQ-ON-W} state was registered at:
[   27.926863]   lock_acquire+0x12c/0x388
[   27.930563]   __u64_stats_update_begin+0x138/0x214
[   27.935372]   stmmac_xmit+0x55c/0xd80
[   27.939064]   dev_hard_start_xmit+0xec/0x2f4
[   27.943362]   sch_direct_xmit+0x94/0x310
[   27.947255]   __dev_queue_xmit+0x3f8/0xd04
[   27.951347]   ip6_finish_output2+0x2fc/0xbc0
[   27.955642]   mld_sendpack+0x268/0x594
[   27.959329]   mld_ifc_work+0x268/0x568
[   27.963115]   process_one_work+0x20c/0x618
[   27.967216]   worker_thread+0x1e8/0x4ac
[   27.971009]   kthread+0x110/0x130
[   27.974296]   ret_from_fork+0x14/0x28
[   27.977982] irq event stamp: 12456
[   27.981353] hardirqs last  enabled at (12455): [<c08e3558>] default_idle_call+0x1c/0x2cc
[   27.989507] hardirqs last disabled at (12456): [<c0100b74>] __irq_svc+0x54/0xd0
[   27.996844] softirqs last  enabled at (12440): [<c010162c>] __do_softirq+0x318/0x4dc
[   28.004586] softirqs last disabled at (12429): [<c012b2a8>] __irq_exit_rcu+0x130/0x184
[   28.012530]
[   28.012530] other info that might help us debug this:
[   28.019040]  Possible unsafe locking scenario:
[   28.019040]
[   28.025043]        CPU0
[   28.027400]        ----
[   28.029857]   lock(&syncp->seq#3);
[   28.033253]   <Interrupt>
[   28.035912]     lock(&syncp->seq#3);
[   28.039410]
[   28.039410]  *** DEADLOCK ***
[   28.039410]
[   28.045416] no locks held by swapper/0/0.
[   28.049395]
[   28.049395] stack backtrace:
[   28.053781] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc5-g59460f7f45e6-dirty #16
[   28.061819] Hardware name: STM32 (Device Tree Support)
[   28.066918]  unwind_backtrace from show_stack+0x18/0x1c
[   28.072140]  show_stack from dump_stack_lvl+0x58/0x70
[   28.077253]  dump_stack_lvl from mark_lock+0xc40/0x12fc
[   28.082478]  mark_lock from __lock_acquire+0x968/0x2c20
[   28.087703]  __lock_acquire from lock_acquire+0x12c/0x388
[   28.093131]  lock_acquire from __u64_stats_update_begin+0x138/0x214
[   28.099372]  __u64_stats_update_begin from dwmac4_dma_interrupt+0xc4/0x2a8
[   28.106219]  dwmac4_dma_interrupt from stmmac_napi_check+0x48/0x1d0
[   28.112558]  stmmac_napi_check from stmmac_interrupt+0xa4/0x184
[   28.118490]  stmmac_interrupt from __handle_irq_event_percpu+0xb0/0x308
[   28.125036]  __handle_irq_event_percpu from handle_irq_event+0x40/0x88
[   28.131578]  handle_irq_event from handle_fasteoi_irq+0xa4/0x258
[   28.137610]  handle_fasteoi_irq from generic_handle_domain_irq+0x30/0x40
[   28.144348]  generic_handle_domain_irq from gic_handle_irq+0x7c/0x90
[   28.150682]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
[   28.156911]  generic_handle_arch_irq from __irq_svc+0x8c/0xd0
[   28.162631] Exception stack(0xc2201f30 to 0xc2201f78)
[   28.167732] 1f20:                                     ffffffff ffffffff 00000001 000030a7
[   28.175974] 1f40: c220c780 c0178dc4 c2208d54 c22c2e10 00000000 00000000 c0b06d28 c220c22c
[   28.184114] 1f60: 00000000 c2201f80 c08e3558 c08e355c 600f0013 ffffffff
[   28.190727]  __irq_svc from default_idle_call+0x20/0x2cc
[   28.196045]  default_idle_call from do_idle+0xd8/0x144
[   28.201165]  do_idle from cpu_startup_entry+0x30/0x34
[   28.206181]  cpu_startup_entry from rest_init+0xf4/0x198
[   28.211502]  rest_init from arch_post_acpi_subsys_init+0x0/0x18


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


