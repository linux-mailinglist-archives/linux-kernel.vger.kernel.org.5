Return-Path: <linux-kernel+bounces-10650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A40081D81C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3025C2827FE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E815C2;
	Sun, 24 Dec 2023 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="YVheBZkd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5A10F8;
	Sun, 24 Dec 2023 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77AFCE0002;
	Sun, 24 Dec 2023 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703403455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJeCIB0MUy6a0K9bJwBkE5sgfhPIDLdWREiwE76A+mY=;
	b=YVheBZkd+rhv1Xtb3FKA22bt980BBrx4xCqK/81PQCTxpyc5Wk49AigoBhuQ9fKYYlW1p0
	IIWVefIMrIamZxJF/PY8MnLwj/iknBUDOSFyLFEtFD5elyOcEaKd+kRR2ct9f3If72F+YI
	EXZI3H0bUn0o/VGWn5C9ADlUaYxmfAfQgil1ZVNUVzibym7PA4Gug4OltqiagqG8khm0D+
	kYJarMXArnOvwAcGrUVo/6izvnHh07Pkbu/VU+vh7fLZhDoc2fcvtou8y7k9CjEO21qxME
	lQVIzqBJ5Hsl5LNUWGVinF5UWhaYk4r/3uKFLW25b8Za7R+mY5++YahAwiNfDg==
Message-ID: <6600c6b1-2230-4963-940c-8b95a01750fd@arinc9.com>
Date: Sun, 24 Dec 2023 10:37:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: register OF node for internal
 MDIO bus
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231221151607.ujobhh4aet4obxdz@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231221151607.ujobhh4aet4obxdz@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 21.12.2023 18:16, Vladimir Oltean wrote:
> On Wed, Dec 20, 2023 at 07:35:39PM +0200, Arınç ÜNAL wrote:
>> From: David Bauer <mail@david-bauer.net>
>>
>> The MT753x switches provide a switch-internal MDIO bus for the embedded
>> PHYs.
>>
>> Register a OF sub-node on the switch OF-node for this internal MDIO bus.
>> This allows to configure the embedded PHYs using device-tree.
>>
>> Signed-off-by: David Bauer <mail@david-bauer.net>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
> 
> Can you please not assign "bus" to ds->user_mii_bus unless there is no
> "mdio" OF node? We don't need ds->user_mii_bus populated when it is
> described in device tree.

Do you mean like this:

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..d239462a4bd8 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2155,15 +2155,21 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
  {
  	struct dsa_switch *ds = priv->ds;
  	struct device *dev = priv->dev;
+	struct device_node *np, *mnp;
  	struct mii_bus *bus;
  	static int idx;
  	int ret;
  
+	np = priv->dev->of_node;
+	mnp = of_get_child_by_name(np, "mdio");
+
  	bus = devm_mdiobus_alloc(dev);
  	if (!bus)
  		return -ENOMEM;
  
-	ds->user_mii_bus = bus;
+	if (mnp == NULL)
+		ds->user_mii_bus = bus;
+
  	bus->priv = priv;
  	bus->name = KBUILD_MODNAME "-mii";
  	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
@@ -2177,7 +2183,8 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
  	if (priv->irq)
  		mt7530_setup_mdio_irq(priv);
  
-	ret = devm_mdiobus_register(dev, bus);
+	ret = devm_of_mdiobus_register(dev, bus, mnp);
+	of_node_put(mnp);
  	if (ret) {
  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
  		if (priv->irq)

If the MDIO bus of the switch is defined on the devicetree, the
(!ds->user_mii_bus && ds->ops->phy_read) check in dsa_switch_setup will be
true so the MDIO bus will be attempted to be registered again, resulting in
a kernel panic.

[    1.369012] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module
[    1.391552] CPU 0 Unable to handle kernel paging request at virtual address 00000700, epc == 802eb948, ra == 802eb938
[    1.402205] Oops[#1]:
[    1.404481] CPU: 0 PID: 26 Comm: kworker/u5:1 Not tainted 6.7.0-rc6-next-20231222-00012-g9997041f4e67-dirty #281
[    1.414622] Hardware name: UniElec U7621-06 (16M flash)
[    1.419829] Workqueue: events_unbound deferred_probe_work_func
[    1.425664] $ 0   : 00000000 00000001 00000011 00000700
[    1.430895] $ 4   : 00000700 814d0000 00000000 00000000
[    1.436123] $ 8   : 00000001 00000011 00000011 81595a80
[    1.441353] $12   : 81595a80 81595ad8 81595a80 81595ad8
[    1.446585] $16   : 81589a80 00000000 82019000 81589600
[    1.451815] $20   : 807d4a88 8205a280 00000005 00000000
[    1.457045] $24   : 00000000 802efd60
[    1.462274] $28   : 81594000 81595c18 80760000 802eb938
[    1.467505] Hi    : 00000000
[    1.470371] Lo    : 00000000
[    1.473235] epc   : 802eb948 mt753x_setup+0x39c/0x3bc
[    1.478283] ra    : 802eb938 mt753x_setup+0x38c/0x3bc
[    1.483324] Status: 11000403	KERNEL EXL IE
[    1.487508] Cause : 4080000c (ExcCode 03)
[    1.491502] BadVA : 00000700
[    1.494367] PrId  : 0001992f (MIPS 1004Kc)
[    1.498446] Process kworker/u5:1 (pid: 26, threadinfo=(ptrval), task=(ptrval), tls=00000000)
[    1.506853] Stack : 7fffffff 00000000 8205a280 00000000 806a8ab8 81589a80 8205a280 81521f00
[    1.515224]         81521f08 8157dc00 806ba49c 8205a280 00000001 804c6374 81589e00 81589c80
[    1.523601]         806a5ed0 81589600 00000000 81595c9c 805cab30 806d0000 8069e96c 806b99cc
[    1.531971]         00000006 00000dc0 ffffffff 802bd188 81589600 802bd29c fffffff4 fffffff4
[    1.540341]         8205a480 807d339c 00000000 00000000 00000000 00000000 00000000 00000000
[    1.548707]         ...
[    1.551150] Call Trace:
[    1.553583] [<802eb948>] mt753x_setup+0x39c/0x3bc
[    1.558286] [<804c6374>] dsa_register_switch+0x924/0xcc4
[    1.563592] [<802ddad0>] mdio_probe+0x34/0x6c
[    1.567943] [<802b95d0>] really_probe+0x16c/0x2dc
[    1.572639] [<802b995c>] driver_probe_device+0x40/0xd0
[    1.577767] [<802b9a4c>] __device_attach_driver+0x60/0xe8
[    1.583154] [<802b7694>] bus_for_each_drv+0xc8/0xf4
[    1.588042] [<802b9d8c>] __device_attach+0xd8/0x14c
[    1.592912] [<802b831c>] bus_probe_device+0x48/0xd8
[    1.597788] [<802b8f5c>] deferred_probe_work_func+0xb4/0xcc
[    1.603348] [<8003ab1c>] process_scheduled_works+0x1dc/0x2b8
[    1.609015] [<8003b1b0>] worker_thread+0x2dc/0x330
[    1.613804] [<80041d4c>] kthread+0xf8/0x100
[    1.617996] [<80002a18>] ret_from_kernel_thread+0x14/0x1c
[    1.623385]
[    1.624869] Code: 8ea30030  00042080  00641821 <ac620000> 26310001  1636fff1  00003825  1000ff67  02803025
[    1.634638]
[    1.636435] ---[ end trace 0000000000000000 ]---

Arınç

