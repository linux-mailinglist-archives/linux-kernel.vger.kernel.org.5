Return-Path: <linux-kernel+bounces-9715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A4281CA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E2B1F223B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490FD1CF8C;
	Fri, 22 Dec 2023 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="hAm6/qYB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WISsgU0G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC31C6A5;
	Fri, 22 Dec 2023 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id D46313200A7F;
	Fri, 22 Dec 2023 07:40:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 22 Dec 2023 07:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703248842;
	 x=1703335242; bh=GO9NK/oMxldoqSl6p4S7Ql47dZzBoFszKsa2cO9zpxk=; b=
	hAm6/qYBG+9uhPArBnEjQ3Zby39vQEi2rZpEs2MvxcBdsoQ8Hp/CPw2mgHoGULL8
	gvhtLRiC7qQv8FmDS7OXLxPFpnbQpZOL79sVcP404fH5J/HNCRdA89zj4T+GhGcb
	IPYnD1iWi/r5xpRZ761Wcssb4BEpXd7y5YKXojW32KojVUTbv9vwIwZXUlWbnCD1
	unxZSoDQGCjS4dFJ2jDm0nqkifYYmdqV1yXE9jRg0Gwj5Qb6I/50XQeDv9g+JcIG
	yPVgQEtU62ZGn09rI8lXua1AH7ztx0XqGp1aSoJFAKYEjK85x0EU0mipgXLRvSZJ
	Z+kIYFW/DklJr1fm08mzJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703248842; x=
	1703335242; bh=GO9NK/oMxldoqSl6p4S7Ql47dZzBoFszKsa2cO9zpxk=; b=W
	ISsgU0Gsk9tA1y1Jl7dOOgHl/8Mba0+Qml036Mf3DqQSpr0s5n972bhPWBtC77vz
	CGmU6Z7n2F/q2LbZft4j8vu7c8gAjxS6wtCyM5i8slUjsdFoSVXEwv9+4urPlF79
	If4FvOR/D2zl2zj3vJ/tFk/kjIdwiEzvZxKLNkiBmMLW/nsm7X9iNcHdscye/oYT
	SFn3KQNCVrFutBAfWVPGUAe3UOXfQHvlSAV9LF0O5b5uxXStdN6UuriaTPNLwoB4
	jnZWD7Yg9q8C2CDfaAWp1F+yC/K4GT83irSUNyQ+9XdA5es1kId1fvUuVCo/BQad
	WiJ6ae5n3dKhIT/2cuUCw==
X-ME-Sender: <xms:yoOFZSfdR0F_IP3LBTV_kuwFOmFVfRXWPCz-z_nEIqSftywPZItaMQ>
    <xme:yoOFZcNPNFabivgRxh1jAsCXd7XlH0j9AovPzxZdXkBhz_1sXS-9sqIjd6uRb8I-V
    8RtgSvQuKmQQJ7x4IE>
X-ME-Received: <xmr:yoOFZTiAE03A-kV5Arx9phjxMR2osc8xwY9Y2szHTqPIbwEkZpymISyAFR3A2qKEGbjDWzJXXWaHEo74jFYAp6jc2yzWTg0qAHZ1X8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:yoOFZf9TA1_w48TCfMk5uSJaW4qfkrmMOEMZiJ2P89V8P3sBCvcUaA>
    <xmx:yoOFZeuhOT-oqm7u0ETBmrWxK1_QbFfZtm3ketCSFwFz7Hy2NwRIfg>
    <xmx:yoOFZWGvjUIwpHTG9lYld6lfBcxuUadj2xFbLkFQcxSzN20I7z0COQ>
    <xmx:yoOFZSJA3hGEO4NDTEau02X31dIOcxAoVzUI3aeGEl4WflBgkXh76g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 07:40:41 -0500 (EST)
Message-ID: <d3a80bd0-6316-42af-a09a-172a026f19a6@flygoat.com>
Date: Fri, 22 Dec 2023 12:40:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] MIPS: Refactor mips_cps_core_entry
 implementation
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregory.clement@bootlin.com, vladimir.kondratiev@intel.com
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
 <20231027221106.405666-6-jiaxun.yang@flygoat.com>
 <ZYV+jQ5M/Hu2aTgq@alpha.franken.de>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <ZYV+jQ5M/Hu2aTgq@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/22 12:18, Thomas Bogendoerfer 写道:
> On Fri, Oct 27, 2023 at 11:11:01PM +0100, Jiaxun Yang wrote:
>> Now the exception vector for CPS systems are allocated on-fly
>> with memblock as well.
>>
>> It will try to allocate from KSEG1 first, and then try to allocate
>> in low 4G if possible.
>>
>> The main reset vector is now generated by uasm, to avoid tons
>> of patches to the code. Other vectors are copied to the location
>> later.
> this patch does way to many things in one go. What is needed to
> make a kernel working with an ebase anyware in XPHYS ?

As we have some silly restrictions on the placement of CPS reset_base, it's
impossible to put CPS's cluster reset base "anywhere".

You'll have to make entry code in cps-vec.S relocatable to allow it to 
be moved
by kernel at run time. Either patching the code or generate by uasm.

Thanks
- Jiaxun
>
> Thomas.
>


