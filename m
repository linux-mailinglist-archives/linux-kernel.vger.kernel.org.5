Return-Path: <linux-kernel+bounces-51763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC2B848F0B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571A5B226B0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2B2261B;
	Sun,  4 Feb 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Zsi3a1I4"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2D225DC;
	Sun,  4 Feb 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062132; cv=none; b=C+UkeEx+ZNIcqXGbk/w7GbNynSM1460FR/YiR496z6SNrsSg3HQ0/owVWubmTZ/Qrl1jIOIQKwbW5z0L21jJ0/J9+xfm5aqzLEUvtFGOnG721wwLWeMbkkHcSLvpBCc5qxiQVf0Eg4QPftVQUYT5/7VcoBFRZ0AgUxTqeC6lJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062132; c=relaxed/simple;
	bh=onuDlZjPiNMdYkqwugLEX7fz2s7+xlvOdrQ9LlHd4ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDKpb84ZRzdvQr6KBCIGyc+59Q2NxpuYRXtM/BP1XB21wSX9cSshNsgCMn5/S0AclmpaU1g5lX5YIVeZu717h+teCIAW+xnAFUT7KJCNoJHakkbe+QbzrKkcGh3Z6kjDsKDUomGIXUq/1EhtMKMV/RDJpqsu19NRviTGo3r0IEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Zsi3a1I4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F69AC0004;
	Sun,  4 Feb 2024 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1707062121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw/KaLqyNXN7B46B9Layw79P/0my6PltB7XkP8ad8AY=;
	b=Zsi3a1I4x8UIMP+yLCiVz83TQxWgGQm/ZMkkbXAmXyuZsBORrwDbyXEtbnKt42BFJkIJH0
	4fa1GLCiscX/G+oULpJt7cAQ70E6BPyYd8i01Pe5HU21TqbNFVJXrclrVXP0VF2KCwk13g
	M0pPbT0EXdA7jk6N6hAkchT4bEiuq/jkwdkPH+GckWWa5hmoNjiRuovm9yHSauWw2QMFUp
	+LwpBjD1VK2HOFaramUEHxD5FaRool2EE1geTIx0l9X8w0BquumaKGjy95aVe7I816n6NR
	lCahbfbhKBWyzGii0KaXl4eKkTNSNlnSv3x1TaFkcBIljC+7a/opKSMIyyWZDw==
Message-ID: <4fa2ff0d-2804-4a58-980f-162e62b3dc9c@arinc9.com>
Date: Sun, 4 Feb 2024 18:55:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/7] net: dsa: mt7530: move XTAL check to
 mt7530_setup()
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-4-63d5adae99ca@arinc9.com>
 <ZbzWpmZrukknMsYf@shell.armlinux.org.uk>
 <5b744f7f-2f63-4219-a0e9-8f08267b1fdd@arinc9.com>
 <Zb021ozEQSbU-gPd@makrotopia.org>
 <f6234b46-ce30-4b2a-9681-15633a06feff@arinc9.com>
 <Zb+ctEe9TVA3zhv8@shell.armlinux.org.uk>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Zb+ctEe9TVA3zhv8@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 4.02.2024 17:18, Russell King (Oracle) wrote:
> On Sun, Feb 04, 2024 at 04:55:40PM +0300, Arınç ÜNAL wrote:
>> This is not about laziness. This is before patch 2:
>>
>> phylink_mac_ops :: mac_config() -> dsa_port_phylink_mac_config()
>> -> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
>>     -> mt753x_mac_config()
>>        -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
>>           -> mt7530_setup_port5()
>>     -> mt753x_pad_setup()
>>        -> mt753x_info :: pad_setup() -> mt7530_pad_clk_setup()
>>
>> This is after:
>>
>> phylink_mac_ops :: mac_config() -> dsa_port_phylink_mac_config()
>> -> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
>>     -> mt753x_mac_config()
>>        -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
>>           -> mt7530_setup_port5()
>>           -> mt7530_setup_port6()
>>
>> Patch 2 does not move mt7530_setup_port6() to be called from
>> phylink_mac_ops :: mac_config(), it already is. There is no valid reason to
>> reorder the patches.
>>
>> My response to Russell should've stated this instead of focusing on his
>> second sentence.
> 
> This patch moves the test for a 20MHz crystal to mt7530_setup(),
> which is something that is entirely orthogonal to patch 2, which
> can be done cleanly (I've just applied the patches in the original
> order and then reordered them:
> 
> 98c481f5d706 net: dsa: mt7530: do not clear config->supported_interfaces
> 93c6b53b17f4 net: dsa: mt7530: correct port capabilities of MT7988
> c9c6d4c51a1d net: dsa: mt7530: simplify mt7530_setup_port6() and change to void
> adfa948253e0 net: dsa: mt7530: remove pad_setup function pointer
> 57e21e6c2fc0 net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
> 959a0f9323c8 net: dsa: mt7530: move XTAL check to mt7530_setup()
> 856ab64a22ef net: dsa: mt7530: empty default case on mt7530_setup_port5()
> 
> No problems. The end result is identical comparing the git tree at the
> original "move XTAL" patch with adfa948253e0.
> 
> Now, if we look at "net: dsa: mt7530: remove pad_setup function pointer"
> we can see that yes, the pad_setup() method was called from mac_confing,
> but this is the exact contents of that patch removing the callsite:
> 
> -               mt753x_pad_setup(ds, state);
> 
> This returns an integer, which may be an error code, which is ignored.
> Therefore, if the XTAL frequency check fires, and mt753x_pad_setup()
> returns an error, it is ignored today.
> 
> After "net: dsa: mt7530: call port 6 setup from mt7530_mac_config()"
> the renamed pad_setup() method is now called from mac_config() thusly:
> 
> +               ret = mt7530_setup_port6(priv->ds, interface);
> +               if (ret)
> +                       return ret;
> 
> So now the error checks cause mt7530_mac_config() to return an error
> which in turn causes mt753x_mac_config() to fail, and therefore
> mt753x_phylink_mac_config() has different behaviour.
> 
> So, patch 2 changes the driver behaviour in the case of a 20MHz XTAL,
> which is then changed again by patch 4.
> 
> It would be better to have only one change of behaviour by moving
> patch 4 before patch 2.

If the idea is to not bring any more error returns to mt753x_mac_config()
because the return code is actually checked for that, I should do a bit
more effort and put patch 5 before patch 2 as well, to live up to what you
originally requested. Because, to get rid of all error returns on
mt7530_setup_port6(), both "net: dsa: mt7530: move XTAL check to
mt7530_setup()" and "net: dsa: mt7530: simplify mt7530_setup_port6() and
change to void" patches are needed. After these patches, I can move
mt7530_setup_port6() to mt7530_mac_config() and there won't be any error
returns being brought under mt753x_mac_config().

pw-bot: cr

Arınç

