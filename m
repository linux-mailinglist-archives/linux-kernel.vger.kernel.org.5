Return-Path: <linux-kernel+bounces-101237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86C87A46A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0129A2834B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BBB1B7F8;
	Wed, 13 Mar 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="S4yrSkfF"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC812B93;
	Wed, 13 Mar 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320387; cv=none; b=XCR7+NCbMSJRdRclfZBXnUDYddWBX6jijtasH2kcoSEQPHmCWkqAkcysI3z2fEYPLcVLSMgSSt4NY7dySZvC0M0VYjh/Z2IJBYJQ5El59SNSig1l2zEFrnknH0vxctCdlJIJneN9QrXzq0OxFf47EqC5OY1MUnGV0QUaLAaCddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320387; c=relaxed/simple;
	bh=Nf31kQK77CE/5iZUQr8OaiVUFvX8lf5qat1P9+9FJ5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poSl+enkZS/idkllul6+LWBjDYq57GpyUyKkp5exUVt7xy0YuR8Y3eYXOh56V2758LiSIQWYS4f0JD+cTi+bCmbo3Ubs7U0p+CV+DYJ6U6YhZmYvuqcowfp0OK7f71tS4Dm+nuzi6L0klBObiEbfadQr6c0UmUdBHfBI+IFoslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=S4yrSkfF; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8E521C0002;
	Wed, 13 Mar 2024 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710320383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KllXQ52SSC7jQLSK+2YhVf2cI0gP4JWuXEq89gqM2Wo=;
	b=S4yrSkfFJw35bZjc2WGscyANqHuBgISTUw7npMyVKjH2otM+w+OInxoMSWPlQxIruG7MuT
	4FpGDS6gXSOQ08QMa9poehcXYz7/sV3mpU2PGydaq0OsY0GUByyba3K694tbm8ZGlbqWzZ
	ldAa6D6e0r+/2rofqW2kivJbPBaiXiM/x/2u1BwOh4A/g9pZ2RzQ6lyFyJBdkyInNBIHbm
	TqOODbYkaYE7XHcHaDsRLH3rwmgDgfCdyCByCAioJUJmwuZg6nYoxoayhmmNsS+a7Wr1Xc
	1a59unBX8ICRrtyRu5Huefe0UlVmPebH517fKQtenEOYiOoVexViB9hrmpfyNw==
Message-ID: <bf0ed70f-e106-4a7f-a98c-de34658feb4d@arinc9.com>
Date: Wed, 13 Mar 2024 11:59:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: increase reset hold time
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <f594a72a91d12f1d027a06962caa9750@risingedge.co.za>
 <20240312192117.7789-1-justin.swartz@risingedge.co.za>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240312192117.7789-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 12.03.2024 22:21, Justin Swartz wrote:
> Increase the MT7530 reset hold period from 1000-1100 usec
> to 5000-5100 usec.
> 
> This should reduce the likelihood of an incorrect external
> crystal frequency selection which may occur when reset is
> deasserted too early under certain link conditions.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>   drivers/net/dsa/mt7530.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 3c1f65759..5e9e1381a 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2243,11 +2243,11 @@ mt7530_setup(struct dsa_switch *ds)
>   	 */
>   	if (priv->mcm) {
>   		reset_control_assert(priv->rstc);
> -		usleep_range(1000, 1100);
> +		usleep_range(5000, 5100);
>   		reset_control_deassert(priv->rstc);
>   	} else {
>   		gpiod_set_value_cansleep(priv->reset, 0);
> -		usleep_range(1000, 1100);
> +		usleep_range(5000, 5100);
>   		gpiod_set_value_cansleep(priv->reset, 1);
>   	}
>   

Again, the patch subject is missing the indication of a tree. Read the
networking subsystem (netdev) development page [1].

This ship has sailed anyway. Now the changes the first patch did must be
reverted too. I will deal with this from now on, you can stop sending
patches regarding this.

[1] https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Arınç

