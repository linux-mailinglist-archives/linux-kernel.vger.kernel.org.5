Return-Path: <linux-kernel+bounces-102479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE51787B2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0A11C2578D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5AD51037;
	Wed, 13 Mar 2024 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="WzTIhz4N"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EF51010;
	Wed, 13 Mar 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360764; cv=none; b=rz7xSRQuBnoslqI/tj2PxGGDvhU82lcS1ctJk+OgQlnd7owXN4LBSHoqS8kLxXMvrzmpAoSdmbt5InBeuwXaNTUSCvtWl1NUY1zwFhcDhJ3fLvw9qPVXFQ7gdJ3GVGCxHcLvqlWZzjIoLEi2CE7lNzJtzQZyV9qgugCZ4W0JN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360764; c=relaxed/simple;
	bh=S+PiGnOT6Rj42pB5IBf6tfImQCiJJZJG+AO254zHo1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0F952OBhcBhxklhe+stZ8zjUS2kZDBn2umvWUCYhV2Tf39UfcpRB0o8ACT6bfLdS4zDe19d8MOZLnlCt6lLJWA5cw/6v0Y2U5fLcwaitEkeB1ryx+dBmz3pdpqfjofTvVbaAnhh1UXUfyR06h92LTQw01CjqtDdwll96iZPNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=WzTIhz4N; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98BFCFF803;
	Wed, 13 Mar 2024 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710360756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0L9q2h8CYQgav6n1YqnS/t2FEJImcD0uzrXWt33zLYY=;
	b=WzTIhz4NH+AgR1EkATjBon5oOy+42v7M5LraE2D1hM726qOvt60LMbr0NHMMvYx0CSQVe3
	KmyyAvSCcIJ932cUajDFov4Xt+SOUhWdnKSLOwwKn6Rc7O5YseMAagkzf2h9Unhg5Khj6l
	noeCKKIpuYMfns0efz6lwMK6y8T8eBGdcgRnosXPUwzdIOjEQ4plA7SbnYxJ8VMSzowcbx
	JTcs+N0/dsVqR6Gb5TsTLFHpPD+921X90J7JTwokRi4Ad3OyabHYdvZNP977VUrDp2TjlH
	IrVU8DBgb/eq1ku0CKjYfa1Fwh6X4HvChT8lUU/Qt1vmAyiE/OTM+PjB+faw1g==
Message-ID: <48fadb58-4b81-4271-919c-102943354c01@arinc9.com>
Date: Wed, 13 Mar 2024 23:12:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mt7530: prevent possible incorrect XTAL
 frequency selection
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Landen Chao <Landen.Chao@mediatek.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Justin Swartz <justin.swartz@risingedge.co.za>
References: <20240313085546.710679b0@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240313085546.710679b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 13.03.2024 18:55, Jakub Kicinski wrote:
> On Wed, 13 Mar 2024 14:25:07 +0300 Arınç ÜNAL via B4 Relay wrote:
>> Reported-by: Justin Swartz <justin.swartz@risingedge.co.za>
> 
> That's way insufficient for the amount of diligence and work Justin did.
> Co-developed-by, at least, please.

Fine by me. Do I need to resubmit or can you add it while applying?

Arınç

