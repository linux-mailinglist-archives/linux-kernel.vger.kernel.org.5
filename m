Return-Path: <linux-kernel+bounces-44747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574378426E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D539C1F2AB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7C745E7;
	Tue, 30 Jan 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="lIpVxYMX"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369906E2C1;
	Tue, 30 Jan 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624799; cv=none; b=Y+PPAl3wMpt+gGdf74b9my3sdU1Ho1JgmbXyVDz6QyITe0aq3VI4JK0WzrZAlwzerkQ/lkHkkvM6aZz+fvoIUf0SlOXaT2Kl3Ni6+SQeEStbuoyHMbwM+62uh//SvpuhpMQhANfe5BRwBVT+Jai9Rln/cF4iaIBX8hpqj9iIjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624799; c=relaxed/simple;
	bh=f9nVK+++urQNiYuRkZtGBcJA2X/ZFOMRIO09d7zR0Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJHZjqI+X6cwjdM4AR2nIkodAwl3JdSYi0C5Grr3V4We5nEtZvxm18G042t+89af5UuUoAWkdZjm9VfCVq8BfoySeTd57rXAVqZfLP8Qzi0TZ06yt4qOv5bCEJPfai1+LPKX6HJqK4+RiAc4rAgZN7dyB7uZKlpY6OFo6ixTnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=lIpVxYMX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E3C81C000E;
	Tue, 30 Jan 2024 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706624795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiU+vp3jmxj1RQvTE/aNTb9Remw5rmZoUoKv2t5MunA=;
	b=lIpVxYMXZCa4HN5li0menqRxSUg6vkEUPhvFUqJ5VTxetW7YHyR0ScfsR5g7qFNFfQFhsU
	/GRQVAzrasNhW3ICz/tX6L/w3LV2YslSM2K9TCMk14M7u60E0lSISz63YaS/yKVmfzFyXN
	La1rgFSd4Wg22M/jvjqLFGvyAXXclRwiNc0cpQJkY+iVUO5v0BZH4e/PTBE2xYRyGRFOn0
	6ZLys8l9Cl/y/3+x2mcuOVqm4b7ctVFruZkFU9CWmQc0zjDRQG4cvgbQXf64kxuzbuiggH
	3LB5RhFoLEwzk2Ah0CiuvGh5lHSNE9Inw99BkBBpBWsZ37RHmjJf1Tjg8frtEA==
Message-ID: <8b7e1d9d-70ec-4664-be04-48a2e2877891@arinc9.com>
Date: Tue, 30 Jan 2024 17:26:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
 <20240129125241.gu4srgufad6hpwor@skbuf>
 <431750cc-fb6b-4f7a-9123-b6986d359742@arinc9.com>
 <20240129083152.34d899cd@kernel.org> <20240129165201.s4oiuk3sxtk6zcsw@skbuf>
 <20240129090034.01c11667@kernel.org>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240129090034.01c11667@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com



On 29.01.2024 20:00, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 18:52:01 +0200 Vladimir Oltean wrote:
>>>> I still see deferred. I guess I'll have to submit this again. :/
>>>
>>> Took me an hour to fix the mailbot:
>>> https://github.com/kuba-moo/nipa/commit/6766e97e72ac91ffb42ed2259bc8e2ace446d0ef
>>> email is the most quirky thing ever.
>>
>> Ah, so it was my neomutt encoding email as base64...
> 
> Something magical going on there, the email is encoded.. twice?
> See the attachment. That's already thru a round of base64 decode
> and there's another copy of the email with base64 inside it :o
> Anyway, unwrapping it once is good enough for the bot to see the
> command, and enough time spent on this ;)

I don't claim to be an email expert. I've received Vladimir's email with
the "Content-Transfer-Encoding: 8bit" header. The body was plaintext, not
base64 encoded. I have checked how the netdev mailing list distributed
Vladimir's email, its body is plaintext as well, not base64 encoded. Only
the linux-arm-kernel mailing list distributed the body base64 encoded, the
header is "Content-Transfer-Encoding: base64".

And the attachment you've provided seems to be from the raw output of
lore.kernel.org/all which seems to put together the email distribution from
all mailing lists.

raw from all:

https://lore.kernel.org/all/20240129125241.gu4srgufad6hpwor@skbuf/raw

raw from netdev:

https://lore.kernel.org/netdev/20240129125241.gu4srgufad6hpwor@skbuf/raw

raw from linux-arm-kernel:

https://lore.kernel.org/linux-arm-kernel/20240129125241.gu4srgufad6hpwor@skbuf/raw

I don't know which mailing list mailbot looks at in case of an email is
sent with multiple mailing lists being CC'd or TO'd. It seems to be that it
looked at linux-arm-kernel in this instance.

Arınç

