Return-Path: <linux-kernel+bounces-144039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C118A4123
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EFEB21289
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5428224EF;
	Sun, 14 Apr 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="GW+EhPMw"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE12261D;
	Sun, 14 Apr 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713082691; cv=none; b=GxliNWLcxXRFD5SNbgMbc4PtR8s8eUM407+RJfa4yH3jQbOUmH9MZiy7tZ6tGcK6/zc4Kk5ef5lIIWBE96E0ulOBFNHuk3AX8idQxIXczZCwNn273HOSP1avqv9KxqKL2+jDPeBW10VPru2l1SM+HQG4M7Fd8Hh00uveYf+RQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713082691; c=relaxed/simple;
	bh=KB8qdh5o/GPwlry7+MlQQYfG88tTRD4vhTfEdFqOGMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U59OuU3yrv38OZybcNAU33nswFxn539noUHTezt90gecvfUvkM6Dd3NvKx1HlNXGq+S3gfKzjE+Kiw0ACGhU1oV+prMlE2NoWIGJ8pJ+6TXuxuSEqQjwTX48svXikfQHQTg1jVqfrayOF81RxZOwCR9t360oqyexjmDeIWwr5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=GW+EhPMw; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2402E0002;
	Sun, 14 Apr 2024 08:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713082686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfwBj4vjnnl0637/puHgd5sch6iAATiC8ktUrfFMQW0=;
	b=GW+EhPMwCld/Lg8sXJgylZKh/8bNa61mqz3fV32It1OjNzlMzH+1ePtSWPCOoc8aDDDktC
	2wMV5aFTlvpGX4M1CJRVqN0CHQ7kRT9kvdxkayIQzP+Q7ANptYf/IgGSHlvuDKB3SfH4vG
	3JKnl+/s1t7emgiuviNuIQ3gR+1eQiuyZivtsgMmhitODgXclIp5NrN0zgbuHlF3Rc0yjG
	4h1FJZhsa4/1ZAjhotlm4hsmmeJ2wFzDv6bXD4laysb7YtNlkEc664XznZ/NedoIUk/5n9
	9uIV2ZAg/3BCFBYg8GANKB4qen0CY4FM3LrhNZNyACpBR/gkzrWHItFQPJqHRQ==
Message-ID: <4ba57ce2-bd8a-43e8-93b4-155499d59db8@arinc9.com>
Date: Sun, 14 Apr 2024 11:17:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mt7530-mdio: read PHY address
 of switch from device tree
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-0-1a7649c4d3b6@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-1-1a7649c4d3b6@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-1-1a7649c4d3b6@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 14.04.2024 09:07, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Read the PHY address the switch listens on from the reg property of the
> switch node on the device tree. This change brings support for MT7530
> switches on boards with such bootstrapping configuration where the switch
> listens on a different PHY address than the hardcoded PHY address on the
> driver, 31.
> 
> As described on the "MT7621 Programming Guide v0.4" document, the MT7530
> switch and its PHYs can be configured to listen on the range of 7-12,
> 15-20, 23-28, and 31 and 0-4 PHY addresses.
> 
> There are operations where the switch PHY registers are used. For the PHY
> address of the control PHY, transform the MT753X_CTRL_PHY_ADDR constant
> into a macro and use it. The PHY address for the control PHY is 0 when the
> switch listens on 31. In any other case, it is one greater than the PHY
> address the switch listens on.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>   drivers/net/dsa/mt7530-mdio.c | 28 ++++++++++++++--------------
>   drivers/net/dsa/mt7530.c      | 35 ++++++++++++++++++++++-------------
>   drivers/net/dsa/mt7530.h      |  4 +++-
>   3 files changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 585db03c0548..dc48715f6534 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -625,7 +625,7 @@ enum mt7531_clk_skew {
>   #define  MT7531_PHY_PLL_OFF		BIT(5)
>   #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
>   
> -#define MT753X_CTRL_PHY_ADDR		0
> +#define MT753X_CTRL_PHY_ADDR(phy_addr)	(phy_addr + 1 & 0x1f)

Whilst compiling, GCC suggests parentheses around ‘+’ in operand of ‘&’. I
will send another version in the upcoming days.

Arınç

