Return-Path: <linux-kernel+bounces-108021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3C8804DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A9D283602
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3C139847;
	Tue, 19 Mar 2024 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="JW2NWByy"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC537153;
	Tue, 19 Mar 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873126; cv=none; b=tbRtYX35V7Tsve7zZOqf1IMgmyPZbAp+S26egonl5Itod4ubSQGDo8bD2leMp3rCa7s77u7XXfatLY/MP1c2bxEeCy5j+3O9ix8l0KGK+KNgJEtkUno7P2gxDPinFNVLbBJKspx32nj8HHnR9nEvlRkt27FaH48INcUv+kgpIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873126; c=relaxed/simple;
	bh=l2xJ9fdw3Iac+xKZNJ31dBECtTRDzpxHKSWbAQkc4Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwT1EyIGa336/LCss7TcDy80Lad6huCWilpzRWdOSE+I5KsDMq4SGs/29Rq5kE42K3RLKXY6wHbqS2DUMmo3VSD1trb7SjxHSyCL3B6ewQXS7d1XtE68bWxcA/8MDvtVuIylWmKg+mrJUb+aXKmWhvySjZAL66aC/Q3kluYx+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=JW2NWByy; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69BDF40002;
	Tue, 19 Mar 2024 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710873115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv2051snAyT0eeP1g4GETpuY9+iur6NRFV2erufXG04=;
	b=JW2NWByy238c24phHn4JpfEO3P6V7hpHACDjy/m4b/etcLoLcmwdnfx53P5crc1HKnSnYj
	ypP6+Gv72ZtAs0Cn+a8xYEWIrJHLKpl5+2FytO5g0/NWeqhxXQ4Ylo97zmccJ0IEU4U1QP
	YfSZYfUmQ8Zbf9NOUacBX9q2KxfgXmGivXITX+vb7fIM/MY1AemqLU/FR734BU2hAiN/S9
	KnkmN+6sGX1WiM3nhHmhv02s0QAxZVseXIyyUjfD5dvznT6rbye18t7PZHz1xqXvzXfj7O
	djP8vh9Bff4YlwV3yHK2xw5lHZBcnsAljQLEJ0Ko3DJYD+If1can1iaXqCfakQ==
Message-ID: <8c50fc86-256d-416a-ad58-1620b8fd848e@arinc9.com>
Date: Tue, 19 Mar 2024 21:31:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <65f7f17d.050a0220.3c75a.cde3SMTPIN_ADDED_BROKEN@mx.google.com>
 <5514243b-c795-436e-8628-8f421c900bcb@gmail.com>
 <ea889226-3649-4f74-8c38-67c459e4ea4d@arinc9.com>
 <20240318-quizzical-raven-of-plenty-ef21f5@lemur>
 <20240319-uppish-idealistic-giraffe-e17cb4@lemur>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240319-uppish-idealistic-giraffe-e17cb4@lemur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 19.03.2024 19:03, Konstantin Ryabitsev wrote:
> On Mon, Mar 18, 2024 at 02:01:58PM -0400, Konstantin Ryabitsev wrote:
>>> It looks like my branch name was too long again. b4 0.13.0 cannot handle
>>> branch names that are too long. I'll keep it shorter for future
>>> submissions. It'd be great if Konstantin could provide a specific limit.
>>
>> It's not really b4, it's the web endpoint and the version of python it's
>> running. I hope to fix it soon by applying the same workarounds as we ended up
>> doing for b4 itself.
> 
> I've deployed the version of endpoint that works around this bug. Hopefully,
> you won't see it again regardless of the message-id length.

Thank you very much!

Arınç

