Return-Path: <linux-kernel+bounces-163340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484C68B69A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BE02822E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAD15AF1;
	Tue, 30 Apr 2024 04:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="GvqvmYBT"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD6125BA;
	Tue, 30 Apr 2024 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453100; cv=none; b=o4x05HsiZTx0XEVq654DZUi6CMVfkmhO6DTHT/FbZF07zrkVPoFHpl73tCGOTnRfbznhBz9AZ1vwr/yX687UBedI5Rp060SElw4+MtAFFjfUR5ekzFjZlugQ5fuiuH7MNykmk/JdEPym57mwUpnUwvywWLGZIml8pP2iFvnOmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453100; c=relaxed/simple;
	bh=FxARK+Ac1zGzaPGYkJ1m/SwB3s0XeVwOgtFDsG9w8NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JdBkZslRQVF8E2k1NQJ9Xrl/tLpaub5jNBgHkNfogsOQChMfxxJnLgM7nzP5t7HEoKqjsrAFSfyg5Qom4y86+cE3lIkgZ2WP/Lhqbf8yChlJwYHfEYmQtHYwfo8TzhZvgy7RHNx1ohGISJuOdmcR18HRHIACa9Ywp7CkrDUzC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=GvqvmYBT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C189240002;
	Tue, 30 Apr 2024 04:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1714453095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxARK+Ac1zGzaPGYkJ1m/SwB3s0XeVwOgtFDsG9w8NQ=;
	b=GvqvmYBTMir6yilmStEchowgXWLuj9LMkK0Iegexk6xEuqA/fTZrDaF9sc6ox/iy88ofS1
	VeiY3TWT7VwSe0yIpNZrAryXpqBSGu4LpGjYjKjWi5e92jReF5OWMflTn0GMF0I2yVJ0pV
	hWyxbhqP7Qte/5DmFp3NPvMwBe24f4Vx4JrMEKPxO2n3vPgwHn63UnmaY511Q3OV7T/990
	K6VXaKbbpeOMUNnGjfuuooSaLfFfV68W62qT+7An4iCTrkL1vDAPMfl3NgUgzH8xj7dC+5
	ARtBmgiKmlgl229n0IU8wHbfyBSxqTvH9A27v7E861JDg+wNAzkw5viozmMN/Q==
Message-ID: <ded0ee71-dfa5-497e-a579-c212185f23ba@arinc9.com>
Date: Tue, 30 Apr 2024 07:58:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
To: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 4/30/24 02:45, Daniel Golle wrote:
> The MDIO address of the MT7530 and MT7531 switch ICs can be configured
> using bootstrap pins. However, there are only 4 possible options for the
> switch itself: 7, 15, 23 and 31 (ie. only 3 and 4 can be configured, bit
> 0~2 are always 111). Practically all boards known as of today use the
> default setting which is to have the switch respond to address 31, while
> the built-in switch PHYs respond to address 0~4 in this case.

I'm not aware of the MT7531 switch having bootstrap pins to configure the
PHY address. Are you sure this is the case?

Arınç

