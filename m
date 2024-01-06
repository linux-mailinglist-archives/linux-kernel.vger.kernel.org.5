Return-Path: <linux-kernel+bounces-18613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA7826006
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBA31C210E2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C178480;
	Sat,  6 Jan 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="pSMwvwgc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD479EC;
	Sat,  6 Jan 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 567EF60002;
	Sat,  6 Jan 2024 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704553261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skoV/MYNvEJ7Q4zca+8v7GcUrjuUMIoeHzDPlkaXyPY=;
	b=pSMwvwgcVeeUxycO6OHaK+SCwICC7DmsXLDD+dHVpiqvO0ehxBcQ5/MPqdsrxBg/NXWYMM
	LWoCT1PqXQ24WS2lXN2D5dqv2Vqjli/duePWnVZeanTB3qG0b76eiJlmonD8EHlv7rkxSJ
	Xh7FC1AtuLcuVZBtJgSYMqofRC9mW3j09DgkAQqE9zR2KePRaDbzjry3Vda0HQw94rQSO5
	soUQPqFEhdcHl+p2Wme3AP/3ba68cDNQHbbCAMWx1yO35E66jANw6LaREYVSA5xcIZU9rM
	o1AtHTvKj1UeMjIKlfQRGy4cYpC/AlkfK4WYg8jDYiwdEc42jrmIs/P6U0zWGw==
Message-ID: <f9ad000a-2e42-4ddf-89a4-9a3ff452dc4b@arinc9.com>
Date: Sat, 6 Jan 2024 18:00:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-7-arinc.unal@arinc9.com>
 <20240104154241.rxjins4mi5zkbhia@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240104154241.rxjins4mi5zkbhia@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 4.01.2024 18:42, Vladimir Oltean wrote:
> On Wed, Dec 27, 2023 at 07:43:46AM +0300, Arınç ÜNAL wrote:
>> priv->p5_interface and priv->p6_interface are for use on the MT7531 switch.
>> They prevent the CPU ports of MT7531 to be configured again. They are
>> useless for MT7530. Therefore, remove setting priv->p5_interface for
>> MT7530.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
> 
> What makes priv->p5_interface and priv->p6_interface useless for MT7530
> as you say? This code in mt753x_phylink_mac_config() seems executed
> regardless of switch family:
> 
> 	case 5:
> 		if (priv->p5_interface == state->interface)
> 			break;
> 
> 		if (mt753x_mac_config(ds, port, mode, state) < 0)
> 			goto unsupported;
> 
> 		if (priv->p5_intf_sel != P5_DISABLED)
> 			priv->p5_interface = state->interface;
> 		break;
> 	case 6:
> 		if (priv->p6_interface == state->interface)
> 			break;
> 
> 		mt753x_pad_setup(ds, state);
> 
> 		if (mt753x_mac_config(ds, port, mode, state) < 0)
> 			goto unsupported;
> 
> 		priv->p6_interface = state->interface;
> 		break;

This is also useless for non-MT7531 switches in the sense that it
unnecessarily prevents port 5 and 6 from being reconfigured. There's
nothing wrong with configuring them multiple times. These are the remains
of before phylink was implemented on this driver so the thought of changing
phy_interface_t on the fly was non existent. At that time, it was probably
made to apply to all switch models for convenience, as port 5 and 6 are CPU
ports so they're highly likely to be fixed links.

The reason I don't deal with this code block now is because I will get rid
of priv->p5_interface and priv->p6_interface when I also get rid of
priv->info->cpu_port_config() with a later patch.

Arınç

