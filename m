Return-Path: <linux-kernel+bounces-161089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0D8B46E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232541F238ED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0033214F7A;
	Sat, 27 Apr 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Eq6oBAyk"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD11A5A2;
	Sat, 27 Apr 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714232621; cv=none; b=sw19pNBrrZRtzU0sSn9jYqpTVKJ+qhZEnJja7c5rKXM+SnM73PK1Eex9MmqsVx4uIoy5CwUUDc/PDQp4wjMVA9sqWCXPb6jYFOSaizj2vizloG6LW+gwDBEf8057hlsPZKY2dVJ4PneCDcGyKiC8HTYmjDYdrhr2ixxsODG5AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714232621; c=relaxed/simple;
	bh=MUPyksaMnqMHR3rhg2pHvS7eabTrvdA8JEqSZc1k2yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izcWu3Durd85pcXcnwqtNPz7cirOgK0GkrsyaHypF6qUTqzI5JqgkzwEjJ7HbJheqIQUhoUH2YZSJr/CAvh/GkpD8p1KypW1saFFD2W7yW7Oyo8yPJkznDaYQ0dDVlRB96ETkV+35VKT3req7DyWE/yiluol4AC16ZLvEXZwuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Eq6oBAyk; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D524C1BF203;
	Sat, 27 Apr 2024 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1714232611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHffaf6MDxa8ECiqE5Vi9zLtI98CHdrDDXTGIYN72xw=;
	b=Eq6oBAykWZPY6GDMA4LSkKisBPZVfPxAjf89dyIQEVNNaoC3265TX/4x0kp76tqoJDpAQi
	UhLULDiNaPF5Inm3ZThvJF7k+dLf1lT9c/myv9sLB0M6bqLSNmD1LQRXDMFJpMwwcIKgmb
	76rRoWWDV4ZdQ55EfrdG5VBsatVhmXRaZ5+VazQMJ6VEe8dBFn6Uy5dsFpPV92cZih82so
	c10GSPuSPiQf/wuyuCv9ptx4oymOHXIovRGmGCYhhIsCi1nJT/bZbS0/+pgRutMAyht7nx
	6FGycRbeSgifOvXaSUKW+vxamba5EBqILD5VvFO7gWyhnuVeBHYE9239zsWByw==
Message-ID: <5acf02b1-8af4-4259-9ce1-c7c7ae00ae9d@arinc9.com>
Date: Sat, 27 Apr 2024 18:43:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: do not set MT7530_P5_DIS when
 PHY muxing is being used
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240427-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v1-1-793cdf9d7707@arinc9.com>
 <7c476e63-5747-4128-af97-13edc252a263@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <7c476e63-5747-4128-af97-13edc252a263@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 27.04.2024 16:31, Andrew Lunn wrote:
> On Sat, Apr 27, 2024 at 02:24:42PM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> When the PHY muxing feature is in use, port 5 won't be defined in the
>> device tree. Because of this, the type member of the dsa_port structure for
>> this port will be assigned DSA_PORT_TYPE_UNUSED. The dsa_port_setup()
>> function calls ds->ops->port_disable() when the port type is
>> DSA_PORT_TYPE_UNUSED.
>>
>> The MT7530_P5_DIS bit is unset when PHY muxing is being used.
>> mt7530_port_disable() which is assigned to ds->ops->port_disable() is
>> called afterwards. Currently, mt7530_port_disable() sets MT7530_P5_DIS
>> which breaks network connectivity when PHY muxing is being used.
>>
>> Therefore, do not set MT7530_P5_DIS when PHY muxing is being used.
>>
>> Fixes: 377174c5760c ("net: dsa: mt7530: move MT753X_MTRAP operations for MT7530")
>> Reported-by: Daniel Golle <daniel@makrotopia.org>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>> Hello.
>>
>> I've sent this to net-next as the patch it fixes is on the current
>> development cycle.
>> ---
>>   drivers/net/dsa/mt7530.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index 2b9f904a98f0..07b6da3ae97c 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -1220,7 +1220,7 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
>>   	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
>>   		return;
>>   
>> -	if (port == 5)
>> +	if (port == 5 && priv->p5_mode == GMAC5)
>>   		mt7530_set(priv, MT753X_MTRAP, MT7530_P5_DIS);
> 
> 
> It might be worth a comment. It is not obvious that
> priv->p5_mode == GMAC5 means the PHY MUX is being used.
> mt7530_setup_port5() thinks it is sufficiently obscure that
> it comments each case.

priv->p5_mode == GMAC5 means PHY muxing is not being used. That is why
MT7530_P5_DIS is set when priv->p5_mode is GMAC5. Anyway, I believe this
proves your point.

Arınç

