Return-Path: <linux-kernel+bounces-109057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DCD881411
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352DB1F23E59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46664D11D;
	Wed, 20 Mar 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="RfSA+UhG"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495414A96;
	Wed, 20 Mar 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947076; cv=none; b=pycuaz93X5tbYIxwTxq+SeZ758fHhypJzxkTpFRWSItwft8Ej2D5ctyKmGcTWgbNvwOow85nskyp2RbTT1Q/CmYyD4kCjExu/B8wekcHVhqs3VmULBY3OdxePLiDWEdYVmofeijarxRvJRp6b4Dqg+tTuBrjMfKXH91w7jGjmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947076; c=relaxed/simple;
	bh=r4qoU7caFTXFSMlxngYHYAdTz9WvdriqwGcpKPfwAew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Si8kDR0CxLKDgzPf+XOztJgX+Q9r7/cAGEodJGrmJ2M4uObQ5l+jAIm53rGjtCs2gCW5CA3lqNePTug5WNEbtP2Zu45DnU4tzGRa629xR1NLALIt8KBorz3sMcU0Q7fcAUtW9k7vfXyN0EqJxciPJ15qZLD6InObQi0tDCd+Dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=RfSA+UhG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58E531BF20E;
	Wed, 20 Mar 2024 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710947064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPnVyRoNctObdniIj1LYajBfdJ4KCDXA+i1lA4eN1Ok=;
	b=RfSA+UhG2CCvT8s3keKol+jqb3t/l0Vw21Xp4Ejm+XNwtdyVT4kjlB4XEFKVcqv5bzcEc6
	wX2fJI42+LksHzhgi+T8TAmfla9hnLdU+63L5FqEOR4RrIYVfXmtUA/3sJowNB6/+arSRJ
	3dFMAdGdEzNXaiy8FAEvb8FtIzrr5Vxb9YQ7bKsxPoC8ZgCMnQnAxL22vjNo5Fq3DMpZUm
	Kke1u5XpWYxbbu46BlExMVGZnIoUjRccIf7WwxCtnHn+6L53zQ+ApgAEm+geG9ansi2ZK8
	+CmSUNTM/kXi9eyCtDL/HRfWUApIC3Ffp4N1/L3Y20iQ+oCjVqfw8FzG3GvelQ==
Message-ID: <3ee60bfe-1283-46b3-9b7e-07526912f763@arinc9.com>
Date: Wed, 20 Mar 2024 18:03:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
 <9d111cc9-c73a-4d3c-83f5-3f59e6c8841f@arinc9.com>
 <ZfrDnFyGay5YTTFg@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZfrDnFyGay5YTTFg@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 20.03.2024 14:08, Daniel Golle wrote:
> On Wed, Mar 20, 2024 at 11:10:19AM +0300, Arınç ÜNAL wrote:
>> On 18.03.2024 10:46, Arınç ÜNAL via B4 Relay wrote:
>>> Hi.
>>>
>>> This patch series fixes EEE support for MT7531 and the switch on the MT7988
>>> SoC. EEE did not work on MT7531 on most boards before this, it is unclear
>>> what's the status on MT7988 SoC switch as I don't have the hardware.
>>>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> I see the state of this patch series is deferred on patchwork. I see that I
>> forgot to delegate this to the net tree. As I don't see any objections in
>> this series, I'll send v2 with it tomorrow.
> 
> Sorry, but imho it should go to net-next, and you might have overlook
> it but there have been some concerns.

I don't believe I overlooked anything. I've come to this conclusion after
reading every response in this thread.

> 
> For sure it should not go to net tree as you are enabling a new feature
> and not fixing anything which is broken. EEE on MT7988 works fine as

EEE support exists since the commit which I've mentioned on my patches
here. I am fixing it. I thought I had explained this clearly on the
patches.

> of now (see my reply), EEE on MT7531 was supposedly intentionally
> disabled for reasons we should ask MTK people about.

Are you talking about the EEE_DIS bit on the trap? There's no default
setting there, it's up to the board vendor to enable/disable EEE by pulling
the affine pin low or high. So there's no intentional disabling by MediaTek
there. I see no need to ask the corporate regarding this.

This patch series does not in any way enable EEE on the switch PHYs and
MACs when it's disabled by default.

Arınç

