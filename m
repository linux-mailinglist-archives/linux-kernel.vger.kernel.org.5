Return-Path: <linux-kernel+bounces-123075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDF8901D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039D41C2C8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736012FB05;
	Thu, 28 Mar 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Pk5BsZ+o"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF112F399;
	Thu, 28 Mar 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636303; cv=none; b=BfsQxlgrIU0F3Y7vqOX593NghEhOYpiQkZs+m69OiHcj2srHKGsHoLC2pAI/PHcBxW/HunZJSfO/dvW1by/l7H0B/49/S5Gb8CS/d0YA+HXZ7zOMKPU4IQ8AQQ77zENjixmlfQvfY1MMSOCb0aFEUbXpRDTFuvrF8LmTZ7DLqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636303; c=relaxed/simple;
	bh=NITox4+FrndX/NhdALUGS7D3C0hjAjcbTr0ZTp+Btho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hflnmwCZXJOuZ9SId9jNw45Y58G2VrAaWgj3K+M9dTmmjDdOwzVGRmYYAqR5wl0+OB6ZUk71mUlRIpdFEITrsciAJBe3YlhFtBQGxGkoMxzDukGhKuL3//7vRbf20xzgiQI1W9B0FpbSWMikTda2+dhb6ImMYiJke0vISt21ydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Pk5BsZ+o; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 929AA1BF209;
	Thu, 28 Mar 2024 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711636293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYWVfKrJL6hIDcIva1S4oog1NNIiLD3QDC7pM2Qb8is=;
	b=Pk5BsZ+oC8umyAEWskhtsC4o3UVgPuxV33dBHjdmkV48Q1leAPEte5DlbDEamFNxydrzOp
	K/1vy4rpS7l0pgYrad767/QoneFn/6VKcDt09e4u8NXx07dYykjYAeVKxOOPeIH0cwsR2B
	grH2IpBhu+p9gfsGU/FzPRHcCVVTh20+jzya7zbWH5VTjbJEGAP355OliVszhi5bZW+U+6
	1JaagfzZQ9mxtzhUK6NzGdrsGkPVjFKzBdfZGsPN6Zkbt9SWH41wXTQLw18YpvlMjGFq0d
	tZ9vufrtLF2AoKDLLZB9WNnsoikdl9RJvRJQZn5NnTFyaRC+tSZGAstjlrIkyw==
Message-ID: <7695599e-3f74-4901-a9a4-adbbc79e1eff@arinc9.com>
Date: Thu, 28 Mar 2024 17:31:26 +0300
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
 <ZgRAQFfKWR1skCMo@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZgRAQFfKWR1skCMo@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 27.03.2024 18:50, Russell King (Oracle) wrote:
> On Tue, Mar 26, 2024 at 12:19:40PM +0300, Arınç ÜNAL wrote:
>> Whether a problem would happen in practice depends on when phy_init_eee()
>> fails, meaning it returns a negative non-zero code. I requested Russell to
>> review this patch to shed light on when phy_init_eee() would return a
>> negative non-zero code so we have an idea whether this patch actually fixes
>> a problem.
> 
> Urgh, so I need to read the code and report back?
> 
> Well, looking at phy_init_eee(), it could return a negative vallue when:
> 
> 1. phydev->drv is NULL
> 2. if genphy_c45_eee_is_active() returns negative
> 3. if genphy_c45_eee_is_active() returns zero, it returns
>     -EPROTONOSUPPORT
> 4. if phy_set_bits_mmd() fails (e.g. communication error with the PHY)
> 
> If we then look at genphy_c45_eee_is_active(), then:
> 
> genphy_c45_read_eee_adv() and genphy_c45_read_eee_lpa() propagate their
> non-zero return values, otherwise this function returns zero or positive
> integer.
> 
> If we then look at genphy_c45_read_eee_adv(), then a failure of
> phy_read_mmd() would cause a negative value to be returned.
> 
> Looking at genphy_c45_read_eee_lpa(), the same is true.
> 
> So, it can be summarised as:
> 
> - phydev->drv is NULL
> - there is a communication error accessing the PHY
> - EEE is not active
> 
> otherwise, it returns zero on success.
> 
> If one wishes to determine whether an error occurred vs EEE not being
> supported through negotiation for the negotiated speed, if it returns
> -EPROTONOSUPPORT in the latter case. Other error codes mean either the
> driver has been unloaded or communication error.
> 
> This has been expertly determined by reading the code, which only a
> phylib maintainer has the capability of doing. Thank you for using this
> service.

Thanks for explaining it. I believe determining enabling/disabling EEE on
the switch MAC by polling the PHY, when one of the last two conditions in
your summary is true, wouldn't result in having EEE enabled. And it seems
to me that if phydev->drv is NULL, there would be bigger problems with the
device. So I think it'll be more fitting to submit this patch to net-next.

Arınç

