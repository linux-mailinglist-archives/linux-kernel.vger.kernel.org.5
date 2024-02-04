Return-Path: <linux-kernel+bounces-51687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD644848E3E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0551C21038
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628C225AA;
	Sun,  4 Feb 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="R8R/F5p+"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993022611;
	Sun,  4 Feb 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707055243; cv=none; b=YeLwmvhAWiTZOyDvEVYw7Y90KBiSTRJzJo+FBjMWw4A0PzWc6pf34kkl6FL6j+B8P+lFT9lLDntaSkejo/vgEHfVRkmH+X8FW+q8RkBFeH947FHFHYryglntYUrVBwTOPE3Qxm3+RM8EiXf8YiZ9t+qzygp3MiTlyMHl+dNYEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707055243; c=relaxed/simple;
	bh=Vf8alaPRUSd87sz0uhqcA3Em4cAEUY1UWVa53iKMltQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uw+LomRnLlJZAb6Vv/1wsz+6MhLyYSmmLpAN7mQ5j71PiH7OLrfbx/Xk4/e2abg3rwZkGz7tZFICP8kNyamuN0c+0tD4iW6fW/cR0tfHHV7H213TSOnXbrWf6ozAyc6ITJ6+rOwG2Mp8tNI3qYFSgIGJleGYISE6K6FAwRQiDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=R8R/F5p+; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EE2F0C19EC;
	Sun,  4 Feb 2024 13:55:55 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64D3A40002;
	Sun,  4 Feb 2024 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1707054947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT0/6zQt68cW/v3LjBVmp3jhbfU8KRIHt1R6FOnr5Ug=;
	b=R8R/F5p+3gb8fz+0YdlFYto2IronmylP4tdxdS6FlqK8FtbhiCNwwd7Cs0h0di9wJ5lMp+
	jENMaTbvWyxdgWORNDJ/YWw57xPdPhAb2Ddczh71LaLghV6CEg8N2ZsmiDY1mA6Tyw7v6J
	HixUudJmnf8VbXdPqfZ5aDYlv1+WnwpIOTGGq1N2tgZA0UEUR1MHtdxS8za3lIMih2fMLZ
	eagalIfv0VE074zMGTx9Y1bGwKafqle+FzXW6/76LwTfC9CJRQZgrF4HeEegDXjTBGDd5C
	IoOhCQJnGDwoQ8b2wYKaApGIPa5KiEP3PgG7e5qczsYevON2b8b9NzAC67c2gw==
Message-ID: <f6234b46-ce30-4b2a-9681-15633a06feff@arinc9.com>
Date: Sun, 4 Feb 2024 16:55:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/7] net: dsa: mt7530: move XTAL check to
 mt7530_setup()
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Zb021ozEQSbU-gPd@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 2.02.2024 21:39, Daniel Golle wrote:
> On Fri, Feb 02, 2024 at 09:16:02PM +0300, Arınç ÜNAL wrote:
>> On 2.02.2024 14:48, Russell King (Oracle) wrote:
>>> On Fri, Feb 02, 2024 at 12:19:10PM +0300, Arınç ÜNAL via B4 Relay wrote:
>>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>
>>>> The crystal frequency concerns the switch core. The frequency should be
>>>> checked when the switch is being set up so the driver can reject the
>>>> unsupported hardware earlier and without requiring port 6 to be used.
>>>>
>>>> Move it to mt7530_setup(). Drop the unnecessary function printing.
>>>>
>>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>>>
>>> I would prefer this to be earlier in the series, before patch 2 which
>>> moves mt7530_setup_port6() to be called from mac_config(). mac_config()
>>> is supposed to be configuration error-free - in other words, all state
>>> should have been checked before hand.
>>
>> I agree but mt7530_mac_config() is not a void function yet. The
>> mac_port_config member of the mt753x_info structure points to this
>> function. My next patch series gets rid of all useless error returns on the
>> phylink path and change mac_port_config to void. So I don't think working
>> on this patch series further will worth the effort. I'd rather have this
>> version applied as is.
> 
> I agree regarding not changing the patch itself, but I also agree
> with Russell regarding the patch ordering. I know it's a 10-minute
> git headache to rebase the patches on top of each other in a different
> order, but you can easily compare the end result being identical to
> what you had before and hence don't need to retest.

This is not about laziness. This is before patch 2:

phylink_mac_ops :: mac_config() -> dsa_port_phylink_mac_config()
-> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
    -> mt753x_mac_config()
       -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
          -> mt7530_setup_port5()
    -> mt753x_pad_setup()
       -> mt753x_info :: pad_setup() -> mt7530_pad_clk_setup()

This is after:

phylink_mac_ops :: mac_config() -> dsa_port_phylink_mac_config()
-> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
    -> mt753x_mac_config()
       -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
          -> mt7530_setup_port5()
          -> mt7530_setup_port6()

Patch 2 does not move mt7530_setup_port6() to be called from
phylink_mac_ops :: mac_config(), it already is. There is no valid reason to
reorder the patches.

My response to Russell should've stated this instead of focusing on his
second sentence.

pw-bot: under-review

Arınç

