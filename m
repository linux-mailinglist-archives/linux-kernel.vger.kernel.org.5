Return-Path: <linux-kernel+bounces-22057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04930829884
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD4C1F2849E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14C47786;
	Wed, 10 Jan 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Lpkh2SCb"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F543FB34;
	Wed, 10 Jan 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83115FF809;
	Wed, 10 Jan 2024 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704885365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esqVAeFguK1WuZvtxZXY5PD9UqDdBuwkKAf6r4Z6RBA=;
	b=Lpkh2SCb+qZtcgGcqghZA9pk/9RmHEpOG6N3CxfbO1NQFSZbSkqMhx5HhPHY9cRK5I/z3L
	JtnbQYLM2iO/BMSfhp5nmNBWYmFvJtCz/rp7qBt/+hq20CHfPbl49VsHRdFTpedWrlugdR
	yychWVEjI/VznMOXiZsVtOH1KAGtbzOqGFVA20396iXKc4v4Qmc68HZKiN+v6w6j2s/Giy
	cgJguxkCqEuUvuT5vIzCswQZMwzkvatSP/403HWNH9HDPoW5YOuTRxTtXQN0BMCX/wdyJh
	tnIBRMuz7OERq0JGUe+3fS9vI8yWCwPwtCNXIgQ/sfz9lBjQGPnxisqaf+o/NQ==
Message-ID: <9308fa1a-6de3-490b-9aeb-eb207b0432df@arinc9.com>
Date: Wed, 10 Jan 2024 14:15:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/30] net: dsa: mt7530: change p{5,6}_interface
 to p{5,6}_configured
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Sean Wang <sean.wang@mediatek.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Richard van Schagen <richard@routerhints.com>,
 Richard van Schagen <vschagen@cs.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, erkin.bozoglu@xeront.com,
 mithat.guner@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <826fd2fc-fbf8-dab7-9c90-b726d15e2983@arinc9.com>
 <ZHyA/AmXmCxO6YMq@shell.armlinux.org.uk>
 <20230604125517.fwqh2uxzvsa7n5hu@skbuf>
 <ZHyMezyKizkz2+Wg@shell.armlinux.org.uk>
 <d269ac88-9923-c00c-8047-cc8c9f94ef2c@arinc9.com>
 <ZHyqI2oOI4KkvgB8@shell.armlinux.org.uk>
 <ZHy1C7wzqaj5KCmy@shell.armlinux.org.uk>
 <ZHy2jQLesdYFMQtO@shell.armlinux.org.uk>
 <0542e150-5ff4-5f74-361a-1a531d19eb7d@arinc9.com>
 <7c224663-7588-988d-56cb-b9de5b43b504@arinc9.com>
 <20230610175553.hle2josd5s5jfhjo@skbuf>
 <22fba48c-054d-ff0a-ae2c-b38f192b26f7@arinc9.com>
In-Reply-To: <22fba48c-054d-ff0a-ae2c-b38f192b26f7@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 11.06.2023 10:23, Arınç ÜNAL wrote:
> 
> On 10.06.2023 20:55, Vladimir Oltean wrote:
>> On Sat, Jun 10, 2023 at 01:57:27PM +0300, Arınç ÜNAL wrote:
>>> I was able to confirm all user ports of the MT7531BE switch transmit/receive
>>> traffic to/from the SGMII CPU port and computer fine after getting rid of
>>> priv->info->cpu_port_config().
>>>
>>> Tried all user ports being affine to the RGMII CPU port, that works too.
>>>
>>> https://github.com/arinc9/linux/commit/4e79313a95d45950cab526456ef0030286ba4d4e
>>
>> Did you do black-box testing after removing the code, or were you
>> also able to independently confirm that the configurations done by
>> cpu_port_config() were later overwritten? I'm trying to disambiguate
>> between "works by coincidence" and "works because the analysis was
>> correct".
> 
> I did my testing, merely to make sure we didn't miss anything as Russell already stated that the configuration from cpu_port_config() is later overwritten.
> 
> I could put some dev_info around to confirm the code path that overwrites the configuration.

I have finally tested this.

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index a4468468b53c..7b60a67d016a 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -968,9 +968,11 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
  
  	/* Setup max capability of CPU port at first */
  	if (priv->info->cpu_port_config) {
+		dev_info(priv->dev, "running cpu_port_config()\n");
  		ret = priv->info->cpu_port_config(ds, port);
  		if (ret)
  			return ret;
+		dev_info(priv->dev, "cpu_port_config() ran\n");
  	}
  
  	/* Enable Mediatek header mode on the cpu port */
@@ -1024,6 +1026,9 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
  		   priv->ports[port].pm);
  	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
  
+	if ((port == 5 || port == 6) && dsa_port_is_cpu(dp))
+		dev_info(priv->dev, "MT7530_PMCR_P%d PMCR_LINK_SETTINGS_MASK is cleared\n", port);
+
  	mutex_unlock(&priv->reg_mutex);
  
  	return 0;
@@ -2693,6 +2698,9 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
  	mcr_new |= PMCR_IFG_XMIT(1) | PMCR_MAC_MODE | PMCR_BACKOFF_EN |
  		   PMCR_BACKPR_EN | PMCR_FORCE_MODE_ID(priv->id);
  
+	if ((port == 5 && dsa_is_cpu_port(ds, 5)) || (port == 6 && dsa_is_cpu_port(ds, 6)))
+		dev_info(priv->dev, "MT7530_PMCR_P%d PMCR_CPU_PORT_SETTING equivalent is set\n", port);
+
  	/* Are we connected to external phy */
  	if (port == 5 && dsa_is_user_port(ds, 5))
  		mcr_new |= PMCR_EXT_PHY;
@@ -2760,6 +2768,9 @@ static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
  	}
  
  	mt7530_set(priv, MT7530_PMCR_P(port), mcr);
+
+	if ((port == 5 && dsa_is_cpu_port(ds, 5)) || (port == 6 && dsa_is_cpu_port(ds, 6)))
+		dev_info(priv->dev, "MT7530_PMCR_P%d PMCR_LINK_SETTINGS_MASK equivalent is set\n", port);
  }
  
  static int
@@ -2796,6 +2807,9 @@ mt7531_cpu_port_config(struct dsa_switch *ds, int port)
  
  	mt7530_write(priv, MT7530_PMCR_P(port),
  		     PMCR_CPU_PORT_SETTING(priv->id));
+
+	dev_info(priv->dev, "MT7530_PMCR_P%d PMCR_CPU_PORT_SETTING is set\n", port);
+
  	mt753x_phylink_mac_link_up(ds, port, MLO_AN_FIXED, interface, NULL,
  				   speed, DUPLEX_FULL, true, true);
  

[    1.763066] mt7530-mdio mdio-bus:00: running cpu_port_config()
[    1.769237] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_CPU_PORT_SETTING is set
[    1.776724] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK equivalent is set
[    1.785254] mt7530-mdio mdio-bus:00: cpu_port_config() ran
[    1.792098] mt7530-mdio mdio-bus:00: running cpu_port_config()
[    1.798019] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_CPU_PORT_SETTING is set
[    1.805502] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK equivalent is set
[    1.814023] mt7530-mdio mdio-bus:00: cpu_port_config() ran
[    1.844941] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK is cleared
[    1.852972] mt7530-mdio mdio-bus:00: configuring for fixed/rgmii link mode
[    1.859944] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_CPU_PORT_SETTING equivalent is set
[    1.868658] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK equivalent is set
[    1.868913] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK is cleared
[    1.877190] mt7530-mdio mdio-bus:00: Link is Up - 1Gbps/Full - flow control rx/tx
[    1.885179] mt7530-mdio mdio-bus:00: configuring for fixed/2500base-x link mode
[    1.899973] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_CPU_PORT_SETTING equivalent is set
[    1.910147] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK equivalent is set
[    1.918681] mt7530-mdio mdio-bus:00: Link is Up - 2.5Gbps/Full - flow control rx/tx
[    1.920654] mt7530-mdio mdio-bus:00 wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7531 PHY] (irq=137)
[    1.948453] mt7530-mdio mdio-bus:00 lan0 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7531 PHY] (irq=138)
[    1.970382] mt7530-mdio mdio-bus:00 lan1 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7531 PHY] (irq=139)
[    1.992423] mt7530-mdio mdio-bus:00 lan2 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7531 PHY] (irq=140)
[    2.014310] mt7530-mdio mdio-bus:00 lan3 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7531 PHY] (irq=141)
[    2.025396] mtk_soc_eth 1b100000.ethernet eth1: entered promiscuous mode
[    2.032160] mtk_soc_eth 1b100000.ethernet eth0: entered promiscuous mode
[    2.038912] DSA: tree 0 setup

Arınç

