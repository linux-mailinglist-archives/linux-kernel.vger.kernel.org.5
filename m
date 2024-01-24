Return-Path: <linux-kernel+bounces-36470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A8283A159
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7033B24824
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BEBE573;
	Wed, 24 Jan 2024 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="K24ejKLW"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B55E541;
	Wed, 24 Jan 2024 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074222; cv=none; b=S4aYuLpEZu/AV5VpwMm+YE9EZPr9YWxXj7W7+7rROk+4sOOX//BfE1x56PIuF3WH21Zl4eRBpjJEWcd0DHvKGYc7FhME7hcFdJ/7cgqG4GkiHFleAG49nYPLfGu4U3vAuxxnqXLDxlkmMPq1T8olb8Yqyk8bBGhE3skbTy/Xdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074222; c=relaxed/simple;
	bh=FQavcIPjhmoM51UmzOB2B4P5+FJvpLKv8uux6tSCgXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2Ejo+jmGEweoivwGHzdjRMx0fhCfSLW05j7imUt58RGE+GWXoe1hGuZUnDWQHlGIVDodr6srpjgfI7jVOwos2GonnvCUwdKF4WHgLYQnAQ1sf+S76ISHGf/56VTVqbvTjhgN1Rwt+Mh5rxsNLrY+0pGaEYcCldkOAlqkp0KjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=K24ejKLW; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96D081C0006;
	Wed, 24 Jan 2024 05:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706074217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJwnEn/ClBtP3ilO+FcGRGFqim9G1t0Q9eGcA2ndZV0=;
	b=K24ejKLWtJLlFjyyw0WHOi7giHVPRfjCB0ExU2rC+g7FxNU8TDZY4ATBHzDeTbTDoppakj
	UAxBAlaE2+sgZkGna7eSp7xhbv2b7ak/PhvhPSziMG2a+R85HOQiJHmzlCgacNXqiDNbm+
	fMWFa9gcdtfeJVae+RZhL0MAbefpXIag5WsSstVHUFtLhnIsAK7kF1JIANGY5xtb9pHyX4
	cqrogJO+iiECfZcAHJecGOTD4Oq66z4ItswEPb+ZCOmvwy4qmG2LgOhAubWURbn90fRwr3
	8425xyQ2s1tYUbl3cZv0g7zeG5guBwgTmc5ztrUn/6tlFlX0yWqYW9GBFAMdtA==
Message-ID: <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com>
Date: Wed, 24 Jan 2024 08:30:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration
 from DSA core
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <ALSI@bang-olufsen.dk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240123154431.gwhufnatxjppnm64@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240123154431.gwhufnatxjppnm64@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 23.01.2024 18:44, Vladimir Oltean wrote:
> On Mon, Jan 22, 2024 at 08:33:48AM +0300, Arınç ÜNAL wrote:
>> These subdrivers which control switches [with MDIO bus] probed on OF, will
>> lose the ability to register the MDIO bus OF-based:
>>
>> drivers/net/dsa/b53/b53_common.c
>> drivers/net/dsa/lan9303-core.c
>> drivers/net/dsa/realtek/realtek-mdio.c
>> drivers/net/dsa/vitesse-vsc73xx-core.c
>>
>> These subdrivers let the DSA core driver register the bus:
>> - ds->ops->phy_read() and ds->ops->phy_write() are present.
>> - ds->user_mii_bus is not populated.
>>
>> The commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus") which brought
>> OF-based MDIO bus registration on the DSA core driver is reasonably recent
>> and, in this time frame, there have been no device trees in the Linux
>> repository that started describing the MDIO bus, or dt-bindings defining
>> the MDIO bus for the switches these subdrivers control. So I don't expect
>> any devices to be affected.
> 
> IIUC, Luiz made the original patch for the realtek switches. Shouldn't
> we wait until realtek registers ds->user_mii_bus on its own, before
> reverting? Otherwise, you're basically saying that Luiz made the DSA
> core patch without needing it.

My findings point to that. Luiz made the patch to optionally register the
MDIO bus of the MDIO controlled Realtek switches OF-based. So it's not
necessary to wait.

Arınç

