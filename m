Return-Path: <linux-kernel+bounces-120566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D388D96D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F06B242F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B137162;
	Wed, 27 Mar 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="fUI+UlYj"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B035881;
	Wed, 27 Mar 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529186; cv=none; b=GKkFvx7yLJOPXiq5efGkcipiuo/KJdl66OWaPC9mPfUcYwhTnGnfKebHySnJVBuI4MRlO19rAm5x5ZE6CXjUM14kphTkL/18Rw90F+kgrm2w8h8gmoB+ztl3hinhbxYPUONuZNAvddPbkv6s6/nKjRb4BUPD9SGagimh57zt0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529186; c=relaxed/simple;
	bh=hjuB1NTOIJIDWdrjxrlzbkyEhKqeT0IDibX9JMRk5l0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Xyk2bjxPFsQPOLRv/KAet8Tw8wuH+fQL2Yv4VVKbednyatXX5zuqJKZDJnUiADZPVQIPBNJA440DjBKum4tq0ALwtLBaFMVxpXH/npdVJQsSd1PbF9VdU5vVIxVFAiT5x9or6XQal+bx1WABweLgpuLpt2uB3/pPkcMgl7Hhwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=fUI+UlYj; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 44BE120003;
	Wed, 27 Mar 2024 08:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711529182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6/9Lbi9NXGVyx2M/GwqTcAQaMos4oEM2EADJm5/7JA=;
	b=fUI+UlYj89U6BM+J15/EBp0MtnKjFnJM6AomUDVdkohOldxf0oyoLbAIL84DEZ3jAOfGWs
	L+AC0AAU6+p5tirDlSTz3J/v6xQjw42EECSdNlDtPqpT9Pj3o8DCrIksLLU2aTOjLGkx+b
	7Z0Rd9C9Ul0nT5abGD/q8OI1CKyxJSGDbEtHjIwO6qyp6ZDJrP0j0Phg15ZpmrfeAjJ6WM
	hjAmEkoGMLuMAeLhF9rMqSc4RxR8Z6I2dNzIYpDN1KrqEK71NlDsRk3CL5sc0CLYg+Jr9x
	9/Rq+6LqG++FKKGK6WX6GOfrb0A42Qj6rwlTF7zyIsQStaKSG88rOllE1rlhKg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Mar 2024 11:46:19 +0300
From: arinc.unal@arinc9.com
To: Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, =?UTF-8?Q?Ren=C3=A9_van_Dor?=
 =?UTF-8?Q?st?= <opensource@vdorst.com>, Russell King
 <linux@armlinux.org.uk>, SkyLake Huang <SkyLake.Huang@mediatek.com>, Heiner
 Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 2/2] net: dsa: mt7530: fix disabling EEE on failure
 on MT7531 and MT7988
In-Reply-To: <d65f4c45-e616-4157-a769-c285cbad575c@arinc9.com>
References: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
 <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-2-9af9d5041bfe@arinc9.com>
 <799572b672ea8b4756236b14068aef7c8fa726a6.camel@redhat.com>
 <d65f4c45-e616-4157-a769-c285cbad575c@arinc9.com>
Message-ID: <530da7c1-c058-44ef-84fd-86ff58f1501b@arinc9.com>
X-Sender: arinc.unal@arinc9.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 26.03.2024 12:19, Arınç ÜNAL wrote:
> On 26.03.2024 12:02, Paolo Abeni wrote:
>> If I read the past discussion correctly, this is a potential issue
>> found by code inspection and never producing problem in practice, am I
>> correct?
>> 
>> If so I think it will deserve a 3rd party tested-by tag or similar to
>> go in.
>> 
>> If nobody could provide such feedback in a little time, I suggest to
>> drop this patch and apply only 1/2.
> 
> Whether a problem would happen in practice depends on when 
> phy_init_eee()
> fails, meaning it returns a negative non-zero code. I requested Russell 
> to
> review this patch to shed light on when phy_init_eee() would return a
> negative non-zero code so we have an idea whether this patch actually 
> fixes
> a problem.

I don't suppose Russell is going to review the patch at this point. I 
will
submit this to net-next then. If someone actually reports a problem in
practice, I can always submit it to the stable trees.

Arınç

