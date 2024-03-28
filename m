Return-Path: <linux-kernel+bounces-123104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8129890233
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255FF1C2DD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6161A12D771;
	Thu, 28 Mar 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="jAu4ww4X"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BF80BF8;
	Thu, 28 Mar 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637176; cv=none; b=j88oyVUhwpdX7W55qnHRn1MKDn1MyLCiJeue/M213l0w76C6b58jfO3RP+S5iGXJuE2nvS1Yxa0ncC3aHIxnkm/k/6mL+sG7JUcD9Zjn5RlzLkAvPuqn+b1Xk7H3TcDZk8gxVuP1VtlSw43fwwTNO4hMJFLFPreMmvPj3ua+peY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637176; c=relaxed/simple;
	bh=p2J07VNUHUPvh5qAwaad4eJ9jVb4amixahDlgymiSlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVM4vu9ZaoMj/6ZPonhL4XhS7RWdo7AKLnzan7I/tno4uk45afgGVK1l/uKIrV9SEwBuzvG7qzJuLvsWihKqmmSbu99ahbcCDKi8PWn68VM1SGxAN8wTU6h7hnLf2Uu4Dky0UMNkry6G56swgRkgOFk4+s0sooVmDk7yqXIpHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=jAu4ww4X; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C15E460005;
	Thu, 28 Mar 2024 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711637172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvXc/6fB/STKMVpjx0LeFmiE8/rH1mB7ohtX7hXt9io=;
	b=jAu4ww4X3VxvcLdS3J00rkjW+Rwb2tH+izGCSUraHF5ssrjAwsT4npqWOf4+ih8U9oUZbP
	h3+iooEUdjyMVVH4Wx55xhtsOzafmrK/ZkwcO+drbk1tyFwDztVsZg/kp/IsF4oMEqH8ul
	U/I1akDNZo3t6twvO5EN+uaOrz5LtY/wXOHQriJcNxN4pKqBqbJ8nrdQn6Om0S5OiCODOt
	fSdB/V8CL+nSomrlHtFqpl3vdR2SwftbkBkPHjWlsgqXdOiwCdO4vrFkyi13xEeChmtujw
	B8jP565rNI5qmBmgWaW7EGprWyddbAvrsSbmpiLSh6bPAQ/8avXtYDwin9uPXw==
Message-ID: <515ca95e-7f7a-4eb7-9431-a297301ca55d@arinc9.com>
Date: Thu, 28 Mar 2024 17:46:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: dsa: mt7530: fix disabling EEE on failure
 on MT7531 and MT7988
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
 <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-2-9af9d5041bfe@arinc9.com>
 <799572b672ea8b4756236b14068aef7c8fa726a6.camel@redhat.com>
 <d65f4c45-e616-4157-a769-c285cbad575c@arinc9.com>
 <530da7c1-c058-44ef-84fd-86ff58f1501b@arinc9.com>
 <ZgRCFZBFvNSZ1a2U@shell.armlinux.org.uk>
 <ZgRCZSBniraUCuT2@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZgRCZSBniraUCuT2@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 27.03.2024 18:59, Russell King (Oracle) wrote:
> On Wed, Mar 27, 2024 at 03:58:13PM +0000, Russell King (Oracle) wrote:
>> On Wed, Mar 27, 2024 at 11:46:19AM +0300, arinc.unal@arinc9.com wrote:
>>> On 26.03.2024 12:19, Arınç ÜNAL wrote:
>>>> Whether a problem would happen in practice depends on when
>>>> phy_init_eee()
>>>> fails, meaning it returns a negative non-zero code. I requested Russell
>>>> to
>>>> review this patch to shed light on when phy_init_eee() would return a
>>>> negative non-zero code so we have an idea whether this patch actually
>>>> fixes
>>>> a problem.
>>>
>>> I don't suppose Russell is going to review the patch at this point. I will
>>> submit this to net-next then. If someone actually reports a problem in
>>> practice, I can always submit it to the stable trees.
>>
>> So the fact that I only saw your request this morning to look at
>> phy_init_eee(), and to review this patch... because... I work for
>> Oracle, and I've been looking at backporting Arm64 KVM patches to
>> our kernel, been testing and debugging that effort... and the
>> act that less than 24 hours had passed since you made the original
>> request... yea, sorry, it's clearly my fault for not jumping on this
>> the moment you sent the email.
>>
>> I get _so_ much email that incorrectly has me in the To: header. I
>> also get _so_ much email that fails to list me in the To: header
>> when the author wants me to respond. I don't have time to read every
>> email as it comes in. I certainly don't have time to read every
>> email in any case. I do the best I can, which varies considerably
>> with my workload.
>>
>> I already find that being single, fitting everything in during the
>> day (paid work, chores, feeding oneself) is quite a mammoth task.
>> There is no one else to do the laundry. There is no one else to get
>> the shopping. There is no one else to do the washing up. There is no
>> one else to take the rubbish out. All this I do myself, and serially
>> because there is only one of me, and it all takes time away from
>> sitting here reading every damn email as it comes in.
>>
>> And then when I end up doing something that _you_ very well could do
>> (reading the phy_init_eee() code to find out when it might return a
>> negative number) and then you send an email like this... yea... that
>> really gets my goat.

I've made the request on 21th of March. It must've been buried under the
other emails that are incorrectly sent to you as you've described. Of
course you're not in fault for not responding. I trust your expertise on
the topic so I requested your comment. You're not entitled to do that,
which is why, after waiting for about 6 days, I assumed that you're not
interested in looking at this patch, so I responded with the intention to
move on.

https://lore.kernel.org/netdev/dc487e20-7d6c-48b7-a590-cb3bd815cd21@arinc9.com/

> 
> ... and now I have a 1:1 with my manager for the next 30-60 minutes.
> Is it okay by you for me to be offline for that period of time while
> I have a chat with him?

That sounds exhausting. I wish things get easier for you.

Arınç

