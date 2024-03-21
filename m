Return-Path: <linux-kernel+bounces-109858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5188569F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F1A1C21374
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6809454BDB;
	Thu, 21 Mar 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="kbh53oNI"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2FC2E6;
	Thu, 21 Mar 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013749; cv=none; b=eSjRpkewsOQy9JgVQokuE86OmVd6KZgokKkzLDJFzxv6rIO5FGM7WzFRQ1yD2PfC2tfvu/oi9zBMbDf166z42s9QS9vUG6t3PlUe9OONkcr3CIwr0a0vi7np64P3Twd4TH2WtfUFD1Ccg1+jSqr8dUmUe9az8l5ORGAekUVpqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013749; c=relaxed/simple;
	bh=yC8T7DEpTLZYJHID9PjAHySKLfNAf2ftqvmmAA3S9dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzWw7e5unBuO913vnYZY2GRVWNpSlyRR9iy+hQ7v6nodZVCkbXPi7MtJXfawM3KVtJmpCk7ZItBy/YwXzKgnP0uiMqBLkN/LaV4d6xWYirBQ+ZSjtyo2Wkk1S4D2XV2e8CG3t1IPOcSAkCj/bYNPZiMSR4DVJcLd+qVYdb/eoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=kbh53oNI; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52CC7FF803;
	Thu, 21 Mar 2024 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711013739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+rBfIRgdxEs51rdHUYVQ/1yd5TKf+EWpb7ciHqkYBQ=;
	b=kbh53oNIAEdV5keF04s/uI5E0To0uvj8OoQ68AdJvnq0A+7IKcBHmCFDbi8kr75Craa13D
	T9iT6zbTzks/LC1LT950Y5LFXg10GlbSbi1M0LNWxR4dQI6nzxKXSN2wsvPZ+pRMJx+bHX
	i3wP/ii9tp8ZA5FKFur5sZ5eKPNzDXbOr7+KS8lTHPE5qWervRh7rlp2G5YVLPhUFGZUy6
	WpdmYLhITI7h3V+L5cB9/vBeams9gkdqEQnI8Mm6OZea3mAnuWVZgcu+7K5leO583caOA6
	d0jXU5sVLwRS6k4CDn+iHidyJfFeh/x2WcK5UFDCW4pcK2RFs1bbo3xFS52Hqg==
Message-ID: <68b7908d-1756-4a0f-b0fc-7c0fb806ff9f@arinc9.com>
Date: Thu, 21 Mar 2024 12:35:11 +0300
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
 <9762d71f1b3858c6b362696277702409e885fa1d.camel@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <9762d71f1b3858c6b362696277702409e885fa1d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 21.03.2024 12:29, Paolo Abeni wrote:
> On Wed, 2024-03-20 at 19:41 +0300, Arınç ÜNAL wrote:
>> On 14.03.2024 12:33, Arınç ÜNAL via B4 Relay wrote:
>>> Hi.
>>>
>>> This patch series fixes the VLAN tag egress procedure for link-local
>>> frames, and fixes handling of all link-local frames.
>>>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>> ---
>>> Changes in v2:
>>> - Add Fixes: tag to both patches.
>>> - Link to v1: https://lore.kernel.org/r/20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-0-d67e6cc31af2@arinc9.com
>>>
>>> ---
>>> Arınç ÜNAL (2):
>>>         net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports
>>>         net: dsa: mt7530: fix handling of all link-local frames
>>>
>>>    drivers/net/dsa/mt7530.c | 52 ++++++++++++++++++++++++++++++++++++++++--------
>>>    drivers/net/dsa/mt7530.h | 22 +++++++++++++++++++-
>>>    2 files changed, 65 insertions(+), 9 deletions(-)
>>> ---
>>> base-commit: d7d75124965aee23e5e4421d78376545cf070b0a
>>> change-id: 20240208-b4-for-net-mt7530-fix-link-local-vlan-af6e9928ad8d
>>>
>>> Best regards,
>>
>> Reminder this patch series is waiting to be applied.
> 
> I hoped to get some feedback from the DSA crew, so it waited a bit in
> patchwork. Anyway it looks like it staged long enough and I'll go
> through it soon.

Vladimir used to help me a lot. I hope everything's okay on their end.

Arınç

