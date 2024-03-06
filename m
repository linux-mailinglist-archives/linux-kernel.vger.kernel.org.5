Return-Path: <linux-kernel+bounces-93999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD87873819
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCF2B227CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AC5131751;
	Wed,  6 Mar 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifg9OjED"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D3131735;
	Wed,  6 Mar 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732906; cv=none; b=k6Ib7M07w/np5oWzpsHj9vwyw2yqYPPPUhOHiYbA6jkTDPacNSPr2R/MQfuOuElJ0xv/ice9zRmgMvYd1m9JtYYb7q38R5skB9U4eXObvF7S9328XC8x6crce/GDVcdXBnmQ1y44+cKtbzE+OF5BrdvMZnnJLohDYcZhBe5vtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732906; c=relaxed/simple;
	bh=VDpu+cZ5zhuVvsVsTCuRVqA9E8ZW3/PpKW/5AAaYH/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0/vcK9NoiOr+VKFu7MY4oR7Gt2K3jxIbzNrFJVN48qqLv+VwjkGVJ5xzg9J95eSEPDcomxsLhX1Lj0Oz84eSO1pJiduIT+sJH7IQFbxuOz7Y/8sMev894UWHN2iSqDhr+xlffu/CjelrTb36I1mCMmg21tl5HX6VgxgxeThH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifg9OjED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C44AC433C7;
	Wed,  6 Mar 2024 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709732906;
	bh=VDpu+cZ5zhuVvsVsTCuRVqA9E8ZW3/PpKW/5AAaYH/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ifg9OjEDqjVXKXLDmpO4SCEBdlsfBBcnZ8ZKk+7pZyKeRpXEo5x9Yup3aKaXnEnyj
	 LJ8Q4G84VFcz2nG2o65TwiB3Qxnz6Er9ZJ81Mjk/8yttaBdX60g/YSu7U4/PHOmfh4
	 O9IGCRMeZzR7BZrX/E1TR//IqLXmQffo2f82EBAia8xhjTSXRCbuhCbOfJ+/j71LY6
	 bwXjrxCzh/yANUKzZPoUm7A5UoHxAzx8YxCdAeLpEFkaaO3QskrqqRLu2YoY7dw6Ji
	 jwrfuUJ8PZ9czksjfAnaLt04UZ2/5vWz8IyRV6tWH3i9fr/LCji74UD7WdUgG2Xw64
	 GdC3RFFKG2ifQ==
Message-ID: <8a8b4320-924a-4dd3-973b-ca941489f19b@kernel.org>
Date: Wed, 6 Mar 2024 15:48:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add
 IFF_UNICAST_FLT flag to port device
Content-Language: en-US
To: =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?=
 <Jorge.SanjuanGarcia@duagon.com>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>
Cc: "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Pekka Varis <p-varis@ti.com>
References: <20240228111300.2516590-1-jorge.sanjuangarcia@duagon.com>
 <20240228200516.1166a097@kernel.org>
 <03bf515c-9f90-487c-ecfa-90d407dc5d86@ti.com>
 <20240301154957.xex75zuijptswcf3@skbuf>
 <7a39e5266fa3ac781f1eda7ee0b2526bd2f164d0.camel@duagon.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <7a39e5266fa3ac781f1eda7ee0b2526bd2f164d0.camel@duagon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/03/2024 12:27, Sanjuán García, Jorge wrote:
> On Fri, 2024-03-01 at 17:49 +0200, Vladimir Oltean wrote:
>> [No suele recibir correo electrónico de olteanv@gmail.com. Descubra
>> por qué esto es importante en
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On Fri, Mar 01, 2024 at 04:39:50PM +0530, Ravi Gunasekaran wrote:
>>> On 2/29/24 9:35 AM, Jakub Kicinski wrote:
>>>> On Wed, 28 Feb 2024 11:13:23 +0000 Sanjuán García, Jorge wrote:
>>>>> Since commit 8940e6b669ca ("net: dsa: avoid call to
>>>>> __dev_set_promiscuity()
>>>>> while rtnl_mutex isn't held") when conecting one of this
>>>>> switch's port
>>>>> to a DSA switch as the conduit interface, the network interface
>>>>> is set to
>>>>> promiscuous mode by default and cannot be set to not
>>>>> promiscuous mode again
>>>>> from userspace. The reason for this is that the cpsw ports net
>>>>> devices
>>>>> do not have the flag IFF_UNICAST_FLT set in their private
>>>>> flags.
>>>>>
>>>>> The cpsw switch should be able to set not promiscuous mode as
>>>>> otherwise
>>>>> a '1' is written to bit ALE_PORT_MACONLY_CAF which makes
>>>>> ethernet frames
>>>>> get an additional VLAN tag when entering the port connected to
>>>>> the DSA
>>>>> switch. Setting the IFF_UNICAST_FLT flag to all ports allows us
>>>>> to have
>>>>> the conduit interface on the DSA subsystem set as not
>>>>> promiscuous.
>>>>
>>>> It doesn't look like am65-cpsw-nuss supports unicast filtering,
>>>> tho, does it? So we're lying about support to work around some
>>>> CPSW weirdness (additional VLAN tag thing)?
>>>
>>> CPSW driver does not support unicast filtering.
>>
>> Then the driver can't declare IFF_UNICAST_FLT.
>>
>> Why does enabling promiscuous mode cause Ethernet frames to get an
>> additional VLAN tag? 802.3 clause 4.2.4.1.1 Address recognition only
>> says "The MAC sublayer may also provide the capability of operating
>> in
>> the promiscuous receive mode. In this mode of operation, the MAC
>> sublayer recognizes and accepts all valid frames, regardless of their
>> Destination Address field values.". Absolutely nothing about VLAN.
> 
> Hi,
> 
> Thank you all very much for the reviews. It is clear now we should not
> add this IFF_UNICAST_FLT flag to this driver.
> 
> I may do some new investigations to find out exactly why this CPSW
> driver is adding VLAN tags when set to promiscuous mode. The CPSW HW is
> definetly adding VLAN tags whenever bit Iy_REG_Py_MACONLY of register
> CPSW_Iy_ALE_PORTCTL0_y gets a "1". Maybe there is some extra

MAC_ONLY and MAC_ONLY_CAF are different bits in the
CPSW_ALE_PORT_CONTROL_REG_y register [1].

Promiscuous mode sets the MAC_ONLY_CAF bit.

From TRM [1] , MAC =
"
Mac Only Copy All Frames.
When set a Mac Only port will transfer all received good frames to
the host.
When clear a Mac Only port will transfer packets to the host based
on ALE destination address lookup operation (which operates more
like an Ethernet Mac).
A Mac Only port is a port with maconly set.
"

Since you are operating the CPSW in MAC mode I believe MAC_ONLY is
set as well for you. That is fine.

Now, from [2], the CPSW hardware seems to poke around VLAN tags
only if VLAN_AWARE bit in CPSW_CONTROL_REG is set which seems
to be the case by default.

> static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
> {
>         struct am65_cpsw_host *host_p = am65_common_get_host(common);
>         int port_idx, i, ret, tx;
>         struct sk_buff *skb;
>         u32 val, port_mask;
> 
>         if (common->usage_count)
>                 return 0;
> 
>         /* Control register */
>         writel(AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
>                AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
>                common->cpsw_base + AM65_CPSW_REG_CTL);

One thing you could try is to not set AM65_CPSW_CTL_VLAN_AWARE here
and see if it resolves your case.

There was a patch sent recently [3] to play around this bit but it was
not clear why it was required. If AM65_CPSW_CTL_VLAN_AWARE is indeed the
cause of trouble here then it should be disabled by default.

[1] - https://www.ti.com/lit/pdf/spruid7
12.2.1.6.10.12 CPSW_ALE_PORT_CONTROL_REG_y Register

[2] - https://www.ti.com/lit/pdf/spruid7
12.2.1.4.6.4.1 Transmit VLAN Processing

[3] - https://lore.kernel.org/all/20240227082815.2073826-1-s-vadapalli@ti.com/

> configuration needed but as far a the current am65-cpsw-nuss.c
> implementation goes, am65_cpsw_slave_set_promisc() only sets that bit.
> 
> Best regards,
> Jorge

-- 
cheers,
-roger

