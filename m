Return-Path: <linux-kernel+bounces-50303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8176E847735
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368781F24BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB614D43E;
	Fri,  2 Feb 2024 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="KSYCbLwL"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477CA14A4DB;
	Fri,  2 Feb 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897774; cv=none; b=QBOR8+w2MynFKnY/FIY1R0exq6EK5DI9hy6t3uZiRIdrOggQytVnCBw8GlUPO23yEaPKLdwsAKpNi5ZZzaRVaXtEJyVUtBVjS5yw2AwpOVUzmaE4n6xiiEI4svKJ8Y2w6aOQlopDQ2Kpm1Moq5io/Ztc9J1vYAmQnXwaQ5h65fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897774; c=relaxed/simple;
	bh=NjO4eKATb1ZVzlEJYvDOvITgk+VfeuI9bh96oQ6EXhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QInhMb6M08AoeMg3bFrhmKsTso+jjaBVNsITDIcg7QynErh6Htu3HveTDeBS+2afk/R2ZcWIBeo8bpwMMllXZ5+ebsWOXPBs/WQ+2VXxeeRMyy1cQnedeDoQEZRh3mycnKusqYGbUEo2uAlRmgFCQ43SUr0+6XzO4Uzrxz/Rmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=KSYCbLwL; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A90240006;
	Fri,  2 Feb 2024 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706897769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtiYOXFMPoLKKMTHGF2JB2BrNN/qXiq/VP/qdA5HoGY=;
	b=KSYCbLwLFuzIuoUaJtpjQGUzO1il4uWXGQ0IExPOpAKFe7gDSiBo3Zdbi+kNccBwAl2Yec
	RB4VAVK7NrOrl2YBoFuidSJZRkL57a+WmQ7lxqCmdkMTKSimnimlSsAPH7WhtbnHjbmMcf
	Brarti0Ozcpa7hCbnOYI4yB13yrzhLSjSpAK46Pa9PfMOyQvZ6mFY4LCTUz7gg2v+t58AH
	FQ/pnWSOQKp8/Tk0nqzBxPiQrbKbulmAa9H0zHfhFbRZcJpiGj9EBCWqfWD83X5GtIW303
	dVMZ7x0vg+AKUWJCm1WjaDAps1zeUQIli0oh+MpNDLKQ9OWItA/vUi6aa1Nujw==
Message-ID: <5b744f7f-2f63-4219-a0e9-8f08267b1fdd@arinc9.com>
Date: Fri, 2 Feb 2024 21:16:02 +0300
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
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZbzWpmZrukknMsYf@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 2.02.2024 14:48, Russell King (Oracle) wrote:
> On Fri, Feb 02, 2024 at 12:19:10PM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> The crystal frequency concerns the switch core. The frequency should be
>> checked when the switch is being set up so the driver can reject the
>> unsupported hardware earlier and without requiring port 6 to be used.
>>
>> Move it to mt7530_setup(). Drop the unnecessary function printing.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 
> I would prefer this to be earlier in the series, before patch 2 which
> moves mt7530_setup_port6() to be called from mac_config(). mac_config()
> is supposed to be configuration error-free - in other words, all state
> should have been checked before hand.

I agree but mt7530_mac_config() is not a void function yet. The
mac_port_config member of the mt753x_info structure points to this
function. My next patch series gets rid of all useless error returns on the
phylink path and change mac_port_config to void. So I don't think working
on this patch series further will worth the effort. I'd rather have this
version applied as is.

Arınç

