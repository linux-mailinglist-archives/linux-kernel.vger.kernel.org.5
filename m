Return-Path: <linux-kernel+bounces-2580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5212815F0D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37411B21E5C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287B43148;
	Sun, 17 Dec 2023 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="b9wK5mg0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1944360;
	Sun, 17 Dec 2023 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97A3F1BF205;
	Sun, 17 Dec 2023 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1702816962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53VdKDpJcL+9oYwjSNytfeRiAIyPbKa7FVqLsuZATU8=;
	b=b9wK5mg0uUyb2cQPYJNlayYJcOEtfwb7WbqhgIe1HbMH7LeT6fvWNpOxUlGJafWs5WBVzP
	jMVU/V4yxtxr0mfbAHDE+iuPKfshri1J1SEXaq2O0QOYtzTmpJT0F/Kntq8d1XCvUFpIbd
	reBH+mlTqOqPc+Iq0dogGtnEEssPAB7UDZUFkD3ob8G6xeBuI8oV9OuV6D+NAKDdm5xGDO
	Wy6UUwAxVQnp6akeFmO11Gjv73DM39HVAOuu3+QC+YcJncxOVJ1/hmBxBRBre4dPD4nr4D
	L8HRuTGci9PwaO4rZljAxu8vQDITXI4FwRQL17inlZcz0chhVUAOcI21JMavlQ==
Message-ID: <a01fa1eb-be77-4da1-bfa5-3e3c20bc08a7@arinc9.com>
Date: Sun, 17 Dec 2023 15:42:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/15] net: dsa: mt7530: do not set
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
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-7-arinc.unal@arinc9.com>
 <20231207181858.ojbgt5pwyqq3tzjk@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231207181858.ojbgt5pwyqq3tzjk@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 7.12.2023 21:18, Vladimir Oltean wrote:
> On Sat, Nov 18, 2023 at 03:31:56PM +0300, Arınç ÜNAL wrote:
>> Do not set priv->p5_interface on mt7530_setup_port5(). There isn't a case
>> where mt753x_phylink_mac_config() runs after mt7530_setup_port5() which
>> setting priv->p5_interface would prevent mt7530_setup_port5() from running
>> more than once.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   drivers/net/dsa/mt7530.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index 069b3dfca6fa..fc87ec817672 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -978,8 +978,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
>>   	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, intf_sel=%s, phy-mode=%s\n",
>>   		val, p5_intf_modes(priv->p5_intf_sel), phy_modes(interface));
>>   
>> -	priv->p5_interface = interface;
>> -
>>   unlock_exit:
>>   	mutex_unlock(&priv->reg_mutex);
>>   }
>> -- 
>> 2.40.1
>>
> 
> Purely as a matter of theory, mt753x_phylink_mac_config() itself could
> be called more than once, at any time there is a phylink_major_config() -
> first during initial one, then upon any change of the phy_interface_t.
> With the port being fixed and internal, maybe that is unlikely.
> 
> Destroying and re-creating the phylink instance could also make the
> driver see more than 1 mt753x_phylink_mac_config() call. During periods
> of -EPROBE_DEFER, maybe this could even happen.
> 
> I think what we need to see is a description of what the priv->p5_interface
> test is really protecting against, because it certainly is uncommon in other
> drivers to have this much logic to avoid mt753x_mac_config() being
> called twice.
> 
> If there's nothing wrong with calling it twice and it's just an optimization,
> I think that's enough of a justification for removing that extra protection.
> At the same time, the optimization (and simplification) that we should
> pursue is that we should remove the overlap between phylink and the
> initial port setup made by the driver.

priv->p5_interface and priv->p6_interface were actually intended to apply
only for MT7531. It prevents the CPU ports to be configured again. CPU
ports are unnecessarily configured before phylink. I intend to address that
with the patch below. I'll submit it after the current patches here go
through. There's a lot to clean up in this driver.

https://github.com/arinc9/linux/commit/80efcb1870530ef5526d7feda625374b8f308369

If you can recall, this is where me and Russell mostly left off on my 30
patch series. I was supposed to run some debug info prints to make sure
that the MT7531 CPU ports are still configured as they were with
priv->info->cpu_port_config().

https://lore.kernel.org/netdev/ZHy2jQLesdYFMQtO@shell.armlinux.org.uk/

For this patch, I can change the patch log to state that priv->p5_interface
and priv->p6_interface are intended for use on the MT7531 switch.

Arınç

