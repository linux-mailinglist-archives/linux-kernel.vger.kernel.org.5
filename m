Return-Path: <linux-kernel+bounces-43070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CDF840B40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CD4B24EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF615696E;
	Mon, 29 Jan 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="h3InIN03"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAB155A58;
	Mon, 29 Jan 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545365; cv=none; b=GRRzOoZE2CaG8dV6HPvGbmDyGt2DzYEY6EzZqY9tVTiw6oo6CGoKLj0Q6BJAxQ8iYDgYAL/ueLc30s3eQi+dlNOrHWoewrk3ePaxzFq6T+BCkjf0YRCEwmFSxJaukUK+oCT98nufdqtQAbfpGVxG+nbcid5UiEROgngLC1r4nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545365; c=relaxed/simple;
	bh=dk2iePkKQ8WbTc/CyWOkKphWL6R6O1SRme8w1LVKSd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPZsthMTWwtdAk05VscNBFt7aIu7PWhp63Dpk5UOOUJF8oHWtqVThAjG94/4u0V7TlkVRdG1+FcaL7JhGrER5WokpvRKVJK9GA9E64j4WA/MyJfWprgLyFzsK7/brbBjAGm6kKQnNPSUDcimiFEwubqLb39yWuTCHm/wa6wklL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=h3InIN03; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 069DCE000D;
	Mon, 29 Jan 2024 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706545355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfalacopj05NBro973M+ZIGKXKczGFxAKP3QzKWb2R4=;
	b=h3InIN03yzv4r1p1AceaEKvatMaRv+Vz4cv+wuVpgHnZ99PedXpFWaffXGs9sQVzxtpO9l
	9gYZhkgjR7Vl3rpSK4+PSCeiwXtlSPaZFnuH8pjLDVqEkudBjE7Y32v64syOpZC8EnZVO5
	Z7WSrGvgYGaH0SAE+pNSt1yVxJnOPQTGnymjVcGmcdTLQuMJRjsUcXHWvRhFXlj57sMaZ/
	e/ZSUD6cYhjGOsYmBaAJ542QIU0lV57bMwCglw0MBXbH1D7pXz70MeSmB+Qjpk4YWSs+pw
	AyjokGotuJYUWPCgNGwfjtP7y1w+jKN+y2mtjRX3EnNjv67xx1WyMj/arujzfg==
Message-ID: <431750cc-fb6b-4f7a-9123-b6986d359742@arinc9.com>
Date: Mon, 29 Jan 2024 19:22:28 +0300
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
 <20240129125241.gu4srgufad6hpwor@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240129125241.gu4srgufad6hpwor@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 29.01.2024 15:52, Vladimir Oltean wrote:
> On Mon, Jan 22, 2024 at 08:35:57AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Running mt7530_setup_port5() from mt7530_setup() used to handle all cases
>> of configuring port 5, including phylink.
>>
>> Setting priv->p5_interface under mt7530_setup_port5() makes sure that
>> mt7530_setup_port5() from mt753x_phylink_mac_config() won't run.
>>
>> The commit ("net: dsa: mt7530: improve code path for setting up port 5")
>> makes so that mt7530_setup_port5() from mt7530_setup() runs only on
>> non-phylink cases.
>>
>> Get rid of unnecessarily setting priv->p5_interface under
>> mt7530_setup_port5() as port 5 phylink configuration will be done by
>> running mt7530_setup_port5() from mt753x_phylink_mac_config() now.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 
> I hope this moves the patch set out of the 'deferred' state.
> 
> ---
> pw-bot: under-review

I still see deferred. I guess I'll have to submit this again. :/

Arınç

