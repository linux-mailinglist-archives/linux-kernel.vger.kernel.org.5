Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92478053E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjLEMMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442295AbjLELfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:35:46 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4ED44;
        Tue,  5 Dec 2023 03:35:51 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca04b1cc37so18558941fa.1;
        Tue, 05 Dec 2023 03:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701776150; x=1702380950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFUnBzqKO7vXkwKNuN05fU5RZ3JQLYycUx9cdu4E62g=;
        b=mWB1UzFxeKyD4g6cMuUPbwMEYFkZebuzJ3Kp14nibsjhZTVFapME9ORS5wAMnovRTp
         M9UVb9PaqDBKNcbbXq4D6Pxs1mli+70545cEkaYppWDcU046gpPtxmKSej3wVIodFYff
         C0G4fx8o55OdNwEqpeNEkdL97d1kOq9tzBK73Yx9FTIh7zWCZ+2Y9yhthobIs8851u8w
         i0OpinY5s8zsBOdfu9apmaUyzFTcheYkwP21gvVnhfwRNEq3RaXzlkuZobUnwqMsdng5
         XBb8NFvNN2t/RJcSwYF303BazQYtpXU3vRn/+eWIiCKcT7zZtsRNehm8kb66P0tYR/j1
         FAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701776150; x=1702380950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFUnBzqKO7vXkwKNuN05fU5RZ3JQLYycUx9cdu4E62g=;
        b=pIJTcCAe/S79xPmnF1TyqMNHqoAnQS21Kn0UxY1Sr8Sk6uwJoj8c/VpiHVXbLFNILQ
         LLIKdLac1QANpxHLBedukGE3tB7F8V7nCe9aQTSIywaAYwxhWeipnSWQEDElTfTteznn
         qpUooBnzfkxKvGsdycxKIOWJk32azn6QDvtZpwW3hUFqUxpxCneNoDRsBs713khPyISR
         ZHDc0I7RLuwNrdcVF1XX+tfebGqNdd8hF5Za8YJ5rMA0lOPkIT/u0+2ZIp/7+UCC/qzl
         LduR3uV0Z/SoGi/3Uk6ePxWxiYPi6+fekOhKJwHoRSrI+dCbwHcLh0J4T4QVs9EhdRAw
         MVJQ==
X-Gm-Message-State: AOJu0YxD3Plu8Df5wsFXFk9axrQtLUq+cgMWIt5Ejr0jPsKWndluPOyB
        mpJBWRdxv0EAjJJRgUn9rOX2R/rh/RfQsQ==
X-Google-Smtp-Source: AGHT+IG58ujewcOvAWmiTKN0P+qMT6bC/XfYgEzpgLJEFdCwutvviFhsN2PUusD5dV487Mr1nZRarg==
X-Received: by 2002:a2e:3219:0:b0:2c9:f4f6:388b with SMTP id y25-20020a2e3219000000b002c9f4f6388bmr636999ljy.18.1701776149499;
        Tue, 05 Dec 2023 03:35:49 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g11-20020a2eb5cb000000b002c9ffbedc24sm788399ljn.122.2023.12.05.03.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:35:49 -0800 (PST)
Date:   Tue, 5 Dec 2023 14:35:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/16] net: pcs: xpcs: Add generic DW XPCS
 MDIO-device support
Message-ID: <uivunnjv5vi3w3fkc5w2f4lem5bingrgajgjfsu2ih7fuhz6hd@3naeubr5spak>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-11-fancer.lancer@gmail.com>
 <20231205111351.xjjuwpbf7kwg3vuh@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205111351.xjjuwpbf7kwg3vuh@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir

On Tue, Dec 05, 2023 at 01:13:51PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 05, 2023 at 01:35:31PM +0300, Serge Semin wrote:
> > @@ -1436,21 +1480,32 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
> >  	struct dw_xpcs *xpcs;
> >  	int ret;
> >  
> > +	ret = device_attach(&mdiodev->dev);
> > +	if (ret < 0 && ret != -ENODEV)
> > +		return ERR_PTR(ret);
> > +
> >  	xpcs = xpcs_create_data(mdiodev);
> >  	if (IS_ERR(xpcs))
> >  		return xpcs;
> >  
> > +	ret = xpcs_init_clks(xpcs);
> > +	if (ret)
> > +		goto out_free_data;
> > +
> >  	ret = xpcs_init_id(xpcs);
> >  	if (ret)
> > -		goto out;
> > +		goto out_clear_clks;
> >  
> >  	ret = xpcs_init_iface(xpcs, interface);
> >  	if (ret)
> > -		goto out;
> > +		goto out_clear_clks;
> >  
> >  	return xpcs;
> 
> [    4.083518] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
> [    4.092356] Mem abort info:
> [    4.095164]   ESR = 0x0000000096000004
> [    4.098932]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    4.104277]   SET = 0, FnV = 0
> [    4.107352]   EA = 0, S1PTW = 0
> [    4.110505]   FSC = 0x04: level 0 translation fault
> [    4.115408] Data abort info:
> [    4.118296]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    4.123807]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    4.128877]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    4.134214] [00000000000000d0] user address but active_mm is swapper
> [    4.140595] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    4.146882] Modules linked in:
> [    4.149944] CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.7.0-rc3-00719-g75be5ea8e111-dirty #1551
> [    4.164524] Workqueue: events_unbound deferred_probe_work_func
> [    4.177372] pc : __device_attach+0x3c/0x1bc
> [    4.181570] lr : __device_attach+0x38/0x1bc
> [    4.185767] sp : ffff8000800f3800
> [    4.189087] x29: ffff8000800f3820 x28: 0000000000000001 x27: ffff063781bda150
> [    4.196252] x26: ffff063781bda150 x25: ffff063780827480 x24: ffffcb9a08138a40
> [    4.203416] x23: ffff063781114080 x22: 0000000000000000 x21: 0000000000000004
> [    4.210579] x20: ffff06378123a400 x19: ffff06378123a480 x18: ffffcb9a07c703a0
> [    4.217743] x17: ffffcb9a07c703a4 x16: 00000000000000d4 x15: ffffcb9a07be70fc
> [    4.224906] x14: ffffcb9a08299638 x13: 0000000000000053 x12: ffff003000000200
> [    4.232069] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [    4.239233] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003a
> [    4.246396] x5 : ffff0637809a037b x4 : ffffcb9a087b0d47 x3 : ffff10300000020f
> [    4.253560] x2 : ffffcb9a0910c561 x1 : 0000000000000000 x0 : ffff06378123a480
> [    4.260724] Call trace:
> [    4.263172]  __device_attach+0x3c/0x1bc
> [    4.267020]  device_attach+0x14/0x20
> [    4.270606]  xpcs_create+0x24/0x384
> [    4.274107]  xpcs_create_byaddr+0x74/0xa0
> [    4.278129]  sja1105_mdiobus_register+0xf8/0x478
> [    4.282763]  sja1105_setup+0xb4/0x1194
> [    4.286524]  dsa_register_switch+0xab0/0x11f8
> [    4.290895]  sja1105_probe+0x2bc/0x2e4
> [    4.294654]  spi_probe+0xa4/0xc4
> [    4.297890]  really_probe+0x16c/0x3fc
> [    4.301564]  __driver_probe_device+0xa4/0x168
> [    4.305935]  driver_probe_device+0x3c/0x220
> [    4.310131]  __device_attach_driver+0x128/0x1cc
> [    4.314676]  bus_for_each_drv+0xf4/0x14c
> [    4.318610]  __device_attach+0xfc/0x1bc
> [    4.322457]  device_initial_probe+0x14/0x20
> [    4.326654]  bus_probe_device+0x94/0x100
> [    4.330587]  deferred_probe_work_func+0xa0/0xfc
> [    4.335132]  process_scheduled_works+0x210/0x318
> [    4.339764]  worker_thread+0x28c/0x450
> [    4.343523]  kthread+0xfc/0x184
> [    4.346669]  ret_from_fork+0x10/0x20
> [    4.350256] Code: 2a0103f6 f81f83a8 9431ccd8 f9402688 (39434109)
> [    4.356366] ---[ end trace 0000000000000000 ]---
> 
> I haven't looked at the code at all, but disassembling drivers/base/dd.lst,
> I think the NPD is at dev->p->dead (0xa68 + 0x3c = 0xaa4).
> 
> 0000000000000a68 <__device_attach>:
> ; {
>      a68: d503233f     	paciasp
>      a6c: d10143ff     	sub	sp, sp, #0x50
>      a70: a9027bfd     	stp	x29, x30, [sp, #0x20]
>      a74: a90357f6     	stp	x22, x21, [sp, #0x30]
>      a78: a9044ff4     	stp	x20, x19, [sp, #0x40]
>      a7c: 910083fd     	add	x29, sp, #0x20
>      a80: d5384108     	mrs	x8, SP_EL0
> ; 	mutex_lock(&dev->mutex);
>      a84: 91020013     	add	x19, x0, #0x80
>      a88: f9423508     	ldr	x8, [x8, #0x468]
>      a8c: aa0003f4     	mov	x20, x0
>      a90: aa1303e0     	mov	x0, x19
>      a94: 2a0103f6     	mov	w22, w1
>      a98: f81f83a8     	stur	x8, [x29, #-0x8]
>      a9c: 94000000     	bl	0xa9c <__device_attach+0x34>
> 		0000000000000a9c:  R_AARCH64_CALL26	mutex_lock
> ; 	if (dev->p->dead) {
>      aa0: f9402688     	ldr	x8, [x20, #0x48]
>      aa4: 39434109     	ldrb	w9, [x8, #0xd0]
>      aa8: 37000129     	tbnz	w9, #0x0, 0xacc <__device_attach+0x64>
> ; 	} else if (dev->driver) {
>      aac: f9403689     	ldr	x9, [x20, #0x68]
>      ab0: b40003e9     	cbz	x9, 0xb2c <__device_attach+0xc4>
> ; 	return dev->p && klist_node_attached(&dev->p->knode_driver);
>      ab4: b40002a8     	cbz	x8, 0xb08 <__device_attach+0xa0>
>      ab8: 91012100     	add	x0, x8, #0x48
>      abc: 94000000     	bl	0xabc <__device_attach+0x54>
> 		0000000000000abc:  R_AARCH64_CALL26	klist_node_attached
> ; 		if (device_is_bound(dev)) {
>      ac0: 34000240     	cbz	w0, 0xb08 <__device_attach+0xa0>
>      ac4: 52800035     	mov	w21, #0x1
>      ac8: 14000002     	b	0xad0 <__device_attach+0x68>
>      acc: 2a1f03f5     	mov	w21, wzr
> ; 	mutex_unlock(&dev->mutex);
>      ad0: aa1303e0     	mov	x0, x19
>      ad4: 94000000     	bl	0xad4 <__device_attach+0x6c>
> 		0000000000000ad4:  R_AARCH64_CALL26	mutex_unlock
>      ad8: d5384108     	mrs	x8, SP_EL0
>      adc: f9423508     	ldr	x8, [x8, #0x468]
>      ae0: f85f83a9     	ldur	x9, [x29, #-0x8]
>      ae4: eb09011f     	cmp	x8, x9
>      ae8: 540008c1     	b.ne	0xc00 <__device_attach+0x198>
> ; 	return ret;
>      aec: 2a1503e0     	mov	w0, w21
>      af0: a9444ff4     	ldp	x20, x19, [sp, #0x40]
>      af4: a94357f6     	ldp	x22, x21, [sp, #0x30]
>      af8: a9427bfd     	ldp	x29, x30, [sp, #0x20]
>      afc: 910143ff     	add	sp, sp, #0x50
>      b00: d50323bf     	autiasp
>      b04: d65f03c0     	ret
> ; 	ret = driver_sysfs_add(dev);
>      b08: aa1403e0     	mov	x0, x20
>      b0c: 97ffff21     	bl	0x790 <driver_sysfs_add>
> ; 	if (!ret) {
>      b10: 340006c0     	cbz	w0, 0xbe8 <__device_attach+0x180>
> ; 		bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
>      b14: aa1403e0     	mov	x0, x20
>      b18: 528000e1     	mov	w1, #0x7
>      b1c: 94000000     	bl	0xb1c <__device_attach+0xb4>
> 		0000000000000b1c:  R_AARCH64_CALL26	bus_notify
>      b20: 2a1f03f5     	mov	w21, wzr
> ; 			dev->driver = NULL;
>      b24: f900369f     	str	xzr, [x20, #0x68]
>      b28: 17ffffea     	b	0xad0 <__device_attach+0x68>
>      b2c: 120002c8     	and	w8, w22, #0x1
> ; 		if (dev->parent)
>      b30: f9402280     	ldr	x0, [x20, #0x40]
> ; 		struct device_attach_data data = {
>      b34: a900fff4     	stp	x20, xzr, [sp, #0x8]
>      b38: 39004bff     	strb	wzr, [sp, #0x12]
>      b3c: 390043e8     	strb	w8, [sp, #0x10]
> ; 		if (dev->parent)
>      b40: b4000060     	cbz	x0, 0xb4c <__device_attach+0xe4>
> ; 	return __pm_runtime_resume(dev, RPM_GET_PUT);
>      b44: 52800081     	mov	w1, #0x4
>      b48: 94000000     	bl	0xb48 <__device_attach+0xe0>
> 		0000000000000b48:  R_AARCH64_CALL26	__pm_runtime_resume
> ; 		ret = bus_for_each_drv(dev->bus, NULL, &data,
>      b4c: f9403280     	ldr	x0, [x20, #0x60]
>      b50: 90000003     	adrp	x3, 0x0 <driver_deferred_probe_add>
> 		0000000000000b50:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x17ac
>      b54: 91000063     	add	x3, x3, #0x0
> 		0000000000000b54:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x17ac
>      b58: 910023e2     	add	x2, sp, #0x8
>      b5c: aa1f03e1     	mov	x1, xzr
>      b60: 94000000     	bl	0xb60 <__device_attach+0xf8>
> 		0000000000000b60:  R_AARCH64_CALL26	bus_for_each_drv
>      b64: 39404be8     	ldrb	w8, [sp, #0x12]
> ; 		if (!ret && allow_async && data.have_async) {
>      b68: 7100001f     	cmp	w0, #0x0
>      b6c: 1a9f07e9     	cset	w9, ne
> ; 		ret = bus_for_each_drv(dev->bus, NULL, &data,
>      b70: 2a0003f5     	mov	w21, w0
>      b74: 7100011f     	cmp	w8, #0x0
> ; 		if (!ret && allow_async && data.have_async) {
>      b78: 520002c8     	eor	w8, w22, #0x1
>      b7c: 1a9f17ea     	cset	w10, eq
>      b80: 2a0a0108     	orr	w8, w8, w10
>      b84: 2a080136     	orr	w22, w9, w8
>      b88: 360000f6     	tbz	w22, #0x0, 0xba4 <__device_attach+0x13c>
> ; 	return __pm_runtime_idle(dev, RPM_ASYNC);
>      b8c: aa1403e0     	mov	x0, x20
>      b90: 52800021     	mov	w1, #0x1
>      b94: 94000000     	bl	0xb94 <__device_attach+0x12c>
> 		0000000000000b94:  R_AARCH64_CALL26	__pm_runtime_idle
> ; 		if (dev->parent)
>      b98: f9402280     	ldr	x0, [x20, #0x40]
>      b9c: b50000e0     	cbnz	x0, 0xbb8 <__device_attach+0x150>
>      ba0: 14000008     	b	0xbc0 <__device_attach+0x158>
> ; 	asm_volatile_goto(
>      ba4: d503201f     	nop

Omg, thank you very much for testing the series straight away and
sorry for the immediate trouble it caused. I'll need some more time
for investigation. I'll get back to this topic a bit later on this
week.

-Serge(y)
