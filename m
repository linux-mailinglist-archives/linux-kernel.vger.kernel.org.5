Return-Path: <linux-kernel+bounces-109968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF86188585A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9AD1F23D02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8358AC6;
	Thu, 21 Mar 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="c3AQ44u9"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209EA5821C;
	Thu, 21 Mar 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020589; cv=none; b=eyHVcC3VnFbGwHCulKJBkOW2QgjhMAbk05c7/2VWNIqEYv1pQKhtlQW29xr294nzOl4NVejmt6dl7xIuOumYrWAvWysDQxjh3h5FRbfzifi8PBlIHUMmLuTaFQh6TXLFQXxKn6zwhsENa/clWe6Q2DUWUGtrEc9ndy6yumGvdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020589; c=relaxed/simple;
	bh=ksSyNW0wNrkEBNSoVV67M2aOFO6/uzRBSWFIG87WRmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EN5cbKmnVKB3Q6TK5OImOFEFbYC/c3LjWGM+zMB5X6tBYbnZ3Ee2kq41DkleIkOTyxg95Gsd7JqA17dHdxNZqDDxJWPe9Pa7zU6eCcRrb0Y9oZBheOFBDRq9hSwiq+pfYsDa8Us0P8zOCQzgXOVWW5bibi1lUzfCDyzKPLa4vHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=c3AQ44u9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4CA11C0005;
	Thu, 21 Mar 2024 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711020585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeLG59GiMIC7TpDQreGN4Aqa0n5VIMq4qD3CPUv15rQ=;
	b=c3AQ44u9VSNtVM9V18+m1ULhvTv/RSHzhf10eB/a8aBI7AJ54a9jcW7KiHA1INt545vWu9
	mFu9f1WZImT+SmLgniWC6K9MSNK7xKSiFVG85tmKts/qFnOpc6hQ89w7bz6eVg6hr7w1io
	i8jTOtYtZAgidSmML778xymJ15qWecwmqTc46ZMcOuzjsFHl56FoDXuqNUrf7geO60LRLQ
	XttjEBy95jFqiVwpSzUtTvjhTRnPRhK79DgOIgFpvkCg1fx5tJKjmvR/ttswS1tfoRmilP
	ApljAwD+kcDtte5h244c0O+3UqLM8kvIjZqr/vWhgD3Me/D6y/CGFY+LEXjJzw==
Message-ID: <7a7e6c46-03a4-48eb-9f46-84a05259cf26@arinc9.com>
Date: Thu, 21 Mar 2024 14:29:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] MT7530 DSA subdriver fix VLAN egress and
 handling of all link-local frames
To: Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
 <f6f064b8-efb2-4ab0-94f1-468d5d273d6e@arinc9.com>
 <49d23df1340f342822702de0439674ddbc5bff6f.camel@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <49d23df1340f342822702de0439674ddbc5bff6f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 21.03.2024 14:18, Paolo Abeni wrote:
> On Wed, 2024-03-20 at 19:41 +0300, Arınç ÜNAL wrote:
>> On 14.03.2024 12:33, Arınç ÜNAL via B4 Relay wrote:
>>> Hi.
>>>
>>> This patch series fixes the VLAN tag egress procedure for link-local
>>> frames, and fixes handling of all link-local frames.
>>>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> For future memory: I think the SoB in the cover letter is not required,
> and is, at least to me, a bit confusing.
> 
> No action needed here, I'll keep this unmodified, but I suggest to omit
> it in future submission.

b4 puts it on the cover letter so it's not my doing.

Arınç

