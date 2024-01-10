Return-Path: <linux-kernel+bounces-22516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E533829EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D9A1F25F18
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26CE4CE1B;
	Wed, 10 Jan 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="FhyoUe+u"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D94CDFE;
	Wed, 10 Jan 2024 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D7B920009;
	Wed, 10 Jan 2024 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704906926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzyB6wNv+2OfPxh+xHT2t9nufYyVx1z7KimPJQBeCd4=;
	b=FhyoUe+uhfXEbbPmVmUKDsCpxcLYkCRNx9NhccrAdUIVvERMQfLEi0eYwgz5xHVxY9fXgQ
	7F3czjEK5tQuAdEp55gj2cBNSrWxC5vGSDjAvdyEplcUhDAIqU835V3GAIo/5hecRsw+Sw
	uO6SNk0Ce0/9ySAJiij7+VtpUH8KqMRdzmsjj5uLDaxR+ab6sFMP6YzMJmBSOBnr7cSqLM
	nKbnpd9InTunvQ018zUqSO0CnLSht97hCHpuJ7Wu51v4lL567CqtMGmKwRNnQ9SycsLhq9
	k/ughPTxFkRir/0vwvF33wA1mAvpBL2HdZ/TwKYseKmvQR309H2rwyeyjbXJNQ==
Message-ID: <b47311f8-315d-46d9-bd5b-757141708a3f@arinc9.com>
Date: Wed, 10 Jan 2024 20:15:20 +0300
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
References: <d269ac88-9923-c00c-8047-cc8c9f94ef2c@arinc9.com>
 <ZHyqI2oOI4KkvgB8@shell.armlinux.org.uk>
 <ZHy1C7wzqaj5KCmy@shell.armlinux.org.uk>
 <ZHy2jQLesdYFMQtO@shell.armlinux.org.uk>
 <0542e150-5ff4-5f74-361a-1a531d19eb7d@arinc9.com>
 <7c224663-7588-988d-56cb-b9de5b43b504@arinc9.com>
 <20230610175553.hle2josd5s5jfhjo@skbuf>
 <22fba48c-054d-ff0a-ae2c-b38f192b26f7@arinc9.com>
 <9308fa1a-6de3-490b-9aeb-eb207b0432df@arinc9.com>
 <9308fa1a-6de3-490b-9aeb-eb207b0432df@arinc9.com>
 <20240110142721.vuthnnwhmuvghiw4@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240110142721.vuthnnwhmuvghiw4@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 10.01.2024 17:27, Vladimir Oltean wrote:
> On Wed, Jan 10, 2024 at 02:15:57PM +0300, Arınç ÜNAL wrote:
>> I have finally tested this.
> 
> Replying to a question from 6 months ago is nice of you, like replying
> to any question is. But everybody's short memory is by now hit like a
> cold cache, everything has been forgotten. I don't even have this thread
> in my inbox anymore, it's in the "seen" folder.
> 
> There's something to be said about having to re-read a long thread and
> the code for 30 minutes, just to reply "Ok".
> 
> I think you need to develop a better feeling for when to let go of past
> discussions when they become stale, summarize the essence in the commit
> description of a patch, and then just resubmit that new patch. People
> will have to open the code and make a fresh analysis anyway, so just
> help them skip reading past discussions and just focus on the conclusion.

I agree, thanks for bearing with me here.

> 
> FYI, you can prefix your prints with something like this to make the log
> easier to follow in terms of code paths taken.
> 
> 	"%s called from %pS <- %pS: ...\n",
> 		__func__, __builtin_return_address(0), __builtin_return_address(1)

__builtin_return_address(1) doesn't seem to work. I'm running this on
arm64. Apart from that, it works well. Thank you.

[    1.863034] mt7530-mdio mdio-bus:00: mt753x_cpu_port_enable called from mt7531_setup_common+0x32c/0x370 <- 0x0: running cpu_port_config()
[    1.875736] mt7530-mdio mdio-bus:00: mt7531_cpu_port_config called from mt753x_cpu_port_enable+0x64/0x23c <- 0x0: MT7530_PMCR_P5 PMCR_CPU_PORT_SETTING is set
[    1.889922] mt7530-mdio mdio-bus:00: mt753x_phylink_mac_link_up called from mt7531_cpu_port_config+0xe8/0x12c <- 0x0: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK equivalent is set
[    1.905491] mt7530-mdio mdio-bus:00: cpu_port_config() ran
[    1.912336] mt7530-mdio mdio-bus:00: mt753x_cpu_port_enable called from mt7531_setup_common+0x32c/0x370 <- 0x0: running cpu_port_config()
[    1.924777] mt7530-mdio mdio-bus:00: mt7531_cpu_port_config called from mt753x_cpu_port_enable+0x64/0x23c <- 0x0: MT7530_PMCR_P6 PMCR_CPU_PORT_SETTING is set
[    1.938953] mt7530-mdio mdio-bus:00: mt753x_phylink_mac_link_up called from mt7531_cpu_port_config+0xe8/0x12c <- 0x0: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK equivalent is set
[    1.954525] mt7530-mdio mdio-bus:00: cpu_port_config() ran
[    1.985409] mt7530-mdio mdio-bus:00: mt7530_port_enable called from dsa_port_enable_rt+0x2c/0x98 <- 0x0: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK is cleared
[    1.999378] mt7530-mdio mdio-bus:00: configuring for fixed/rgmii link mode
[    2.006347] mt7530-mdio mdio-bus:00: mt753x_phylink_mac_config called from dsa_port_phylink_mac_config+0x30/0x3c <- 0x0: MT7530_PMCR_P5 PMCR_CPU_PORT_SETTING equivalent is set
[    2.022197] mt7530-mdio mdio-bus:00: mt753x_phylink_mac_link_up called from dsa_port_phylink_mac_link_up+0x48/0x74 <- 0x0: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK equivalent is set
[    2.022645] mt7530-mdio mdio-bus:00: mt7530_port_enable called from dsa_port_enable_rt+0x2c/0x98 <- 0x0: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK is cleared
[    2.038203] mt7530-mdio mdio-bus:00: Link is Up - 1Gbps/Full - flow control rx/tx
[    2.052090] mt7530-mdio mdio-bus:00: configuring for fixed/2500base-x link mode
[    2.066894] mt7530-mdio mdio-bus:00: mt753x_phylink_mac_config called from dsa_port_phylink_mac_config+0x30/0x3c <- 0x0: MT7530_PMCR_P6 PMCR_CPU_PORT_SETTING equivalent is set
[    2.084406] mt7530-mdio mdio-bus:00: mt753x_phylink_mac_link_up called from dsa_port_phylink_mac_link_up+0x48/0x74 <- 0x0: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK equivalent is set
[    2.095093] mt7530-mdio mdio-bus:00 wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7531 PHY] (irq=137)
[    2.100427] mt7530-mdio mdio-bus:00: Link is Up - 2.5Gbps/Full - flow control rx/tx

> 
>> [    1.763066] mt7530-mdio mdio-bus:00: running cpu_port_config()
>> [    1.769237] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_CPU_PORT_SETTING is set
>> [    1.776724] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK equivalent is set
>> [    1.785254] mt7530-mdio mdio-bus:00: cpu_port_config() ran
> 
> This is from mt7531_setup_common(), for port 5.
> 
>> [    1.792098] mt7530-mdio mdio-bus:00: running cpu_port_config()
>> [    1.798019] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_CPU_PORT_SETTING is set
>> [    1.805502] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK equivalent is set
>> [    1.814023] mt7530-mdio mdio-bus:00: cpu_port_config() ran
> 
> This is from mt7531_setup_common(), for port 6.
> 
>> [    1.844941] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK is cleared
> 
> This is from mt7530_port_enable() for port 5, undoing what mt7531_setup_common() has done.
> It also seems bogus BTW, the enable() function is doing the same "clear"
> as mt7530_port_disable() is doing, rather than mt7530_set(). Were it not
> for what's to come [1], this would be a bug with an actual user impact.
> 
>> [    1.852972] mt7530-mdio mdio-bus:00: configuring for fixed/rgmii link mode
>> [    1.859944] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_CPU_PORT_SETTING equivalent is set
> 
> This is from mt753x_phylink_mac_config(), for port 5, partially
> overwriting what mt7531_setup_common() has done.
> 
>> [    1.868658] mt7530-mdio mdio-bus:00: MT7530_PMCR_P5 PMCR_LINK_SETTINGS_MASK equivalent is set
> 
> [1] This is from mt753x_phylink_mac_link_up(), for port 5, overwriting what
> mt7530_port_enable() has done. I suspect that, in addition to Russell's
> analysis, modifying PMCR_LINK_SETTINGS_MASK from the port_enable()/
> port_disable() ops is also something that can be removed.
> 
>> [    1.868913] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK is cleared
>> [    1.877190] mt7530-mdio mdio-bus:00: Link is Up - 1Gbps/Full - flow control rx/tx
>> [    1.885179] mt7530-mdio mdio-bus:00: configuring for fixed/2500base-x link mode
>> [    1.899973] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_CPU_PORT_SETTING equivalent is set
>> [    1.910147] mt7530-mdio mdio-bus:00: MT7530_PMCR_P6 PMCR_LINK_SETTINGS_MASK equivalent is set
>> [    1.918681] mt7530-mdio mdio-bus:00: Link is Up - 2.5Gbps/Full - flow control rx/tx
>> [    1.920654] mt7530-mdio mdio-bus:00 wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7531 PHY] (irq=137)
>> [    1.948453] mt7530-mdio mdio-bus:00 lan0 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7531 PHY] (irq=138)
>> [    1.970382] mt7530-mdio mdio-bus:00 lan1 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7531 PHY] (irq=139)
>> [    1.992423] mt7530-mdio mdio-bus:00 lan2 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7531 PHY] (irq=140)
>> [    2.014310] mt7530-mdio mdio-bus:00 lan3 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7531 PHY] (irq=141)
>> [    2.025396] mtk_soc_eth 1b100000.ethernet eth1: entered promiscuous mode
>> [    2.032160] mtk_soc_eth 1b100000.ethernet eth0: entered promiscuous mode
>> [    2.038912] DSA: tree 0 setup
>>
>> Arınç
> 
> And this is all the same for port 6.
> 
> So yes, it would be good to consolidate the code to follow a simple principle.
> Any register fields should be modified only by the set of methods that
> they pertain to. In this case, MT7530_PMCR_P appears to only hold link
> control information, so it pertains to phylink's methods. Otherwise,
> the natural consequence is that they will get unexpectedly overwritten.
> 
> It seems outside of the competence of ds->ops->port_enable() and
> ds->ops->port_disable(). Those would be appropriate, for example, to
> control the switching matrix settings between a user port and its
> corresponding CPU port (but not any more switching matrix settings -
> those pertain to port_bridge_join() and port_bridge_leave()).
> 
> I hope this helps.

This is very helpful, thank you very much. This is what I deduct I should
do:

First patch: Get rid of cpu_port_config().

Second patch: Collect port link control register operations from
port_enable/port_disable and phylink_mac_config to
phylink_mac_link_up/phylink_mac_link_down.

Arınç

