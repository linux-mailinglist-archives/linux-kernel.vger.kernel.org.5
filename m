Return-Path: <linux-kernel+bounces-100168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BBF8792E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC851C20B76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A779B7F;
	Tue, 12 Mar 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="e2rYS5fY"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A520304;
	Tue, 12 Mar 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242525; cv=none; b=JQNzKE6GFdG/iwTjNLpzBpzxFwLlzKlt0Dsoy9lb5qSQlppbrS1cRokztVZ4wo8fn53AauHM5hA4POakBfOX1vcty5NggaDXtcldT4+pFcUNLOW/B2Wpvk57sgr7kPvqYiyLRVPciDsKf5Ys0fb2GOHLptkMsSzbDFjmXDZjY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242525; c=relaxed/simple;
	bh=Z0TSylZlSlnWy9qRsvC4bqqwk7tdSqUZP0+E5DtexE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPDmKw/LNP9u5fFFTvW7FMuRRtwfQ/u+AVcDik8nAT3MJgV68JAPZHuS2Cpm50X0YVuHJ/FIEAiUU6Eib8PFL7BGQl3662wKBy4lF6czmStS3XD2WgQlTQaMfOLUWyCq/jdMi8EsABCdiT0gxKlLxd/VW/TeNVFSmYqlbDNh+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=e2rYS5fY; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAF94C0002;
	Tue, 12 Mar 2024 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710242515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOdo/1mCWJYcxEKaBRYTzgE0ZAGk9OmOvt81SZQggfg=;
	b=e2rYS5fYWK1UsqRzdoJvxmWsFEW5R/stulHvr/IRvZMqd8xQ1kXaphv1yGlWUkqMm3sbqt
	mDkD+/xCZ19gLSuDFIe4REOLdWMIz6ysjUjOmU5WRdq/breAHOft0O4/yNbdSn4RLibxWz
	l/2UKwNDAgfDaA6Z5EBVyFBs4DgShMIDfuK/HmsYa55/INONdz7yFYMNKlJ2HNNToR1IjL
	hHHyIOQkbMtZjGELXf/D67xTTQjHdEKBllaTjK4ayndNwL+3zawidrcmV+PATJoWbsJJSI
	ZS5Y5uum0JmJi9ELMRMlDZD6g+0DIclL2Bvw4PqpNsT5vPu5WkhZZR92L/sTPg==
Message-ID: <941e7c70-a90f-4e6b-a2b7-867fc798d693@arinc9.com>
Date: Tue, 12 Mar 2024 14:21:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, patchwork-bot+netdevbpf@kernel.org,
 Justin Swartz <justin.swartz@risingedge.co.za>
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <171019143163.14853.15330891015381229970.git-patchwork-notify@kernel.org>
 <7780460c-abc3-4009-9f95-28d123a9a23d@arinc9.com>
 <4fb0b96fe4049578718befc41f2121ce18c30fbe.camel@redhat.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <4fb0b96fe4049578718befc41f2121ce18c30fbe.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 12.03.2024 13:46, Paolo Abeni wrote:
> On Tue, 2024-03-12 at 11:38 +0300, Arınç ÜNAL wrote:
>> I am once again calling for this patch to be reverted on the net-next tree
>> on the basis of:
>>
>> - This patch did not go through a proper reviewing process. There are
>>     proposed changes on the code it changes regarding the scope and the
>>     method of the patch, and improvements to be made on the patch log.
>>
>> - This patch should be backported to stable releases, therefore it
>>     shouldn't be on the net-next tree and should be submitted to the net tree
>>     instead.
> 
> The net-next pull request is out:
> 
> https://lore.kernel.org/netdev/20240312042504.1835743-1-kuba@kernel.org/
> 
> at this point I believe we can't retract it unless there is a very
> serious regression affecting most/all users. This does not look such
> case.

It seems so. This patch was not tested on standalone MT7530 at submission.
Whilst the patch is useless for standalone MT7530, it doesn't seem to break
anything either, from my simple test on a board with it.

> 
> I think the better option is follow-up on net with follow-up fixes if
> any.
> 
> All the relevant patches could be sent to the stable tree later:
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/stable-kernel-rules.rst#L47
> 
> To try to reduce the possibilities of this kind of situation in the
> future, may I kindly ask you to invest some more little time to help
> the reviewers and the maintainers? e.g. trimming the replies explicitly
> cutting all the unneeded parts in the quoted code/text would make the
> whole conversation much easier to follow (at least to me). The netdev
> volume is insane, it's very easy to get lost in a given thread and miss
> relevant part of it.

I already try to do this. Here's my proposal that would not reduce but
completely avoid this kind of situation in the future, and at the same time
reduce the workload of the netdev maintainers. Do not apply patches without
ACKs. Ask for reviews at least once if the patch had been stale for a
while, and wait a bit for reviews. Only then apply the patch with/without
ACKs.

Arınç

