Return-Path: <linux-kernel+bounces-81245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B38673C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F497B27B82
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147D21CD2B;
	Mon, 26 Feb 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="1cDbI1KF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOmOhPS9"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1871CFBB;
	Mon, 26 Feb 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945471; cv=none; b=o/obUQfd1sNBA657S6qmI46QJ9vpEdIUfQFV7tkJl3ZlQBZD2SqwXB4AO1oGkjDecOeZlWTUzKTKV8WQSbDWCDhIHvzrAedKmIRa8dGAULbvVptuVXpacDW8fmZRxFNyY3+FxPGaHzIp6JH4ENYLNHqDADuMwAwhj3kdkmLHHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945471; c=relaxed/simple;
	bh=wCOmd+l5m9r5bzHyaJa9PVhFFirSiX7036ruKNxn+9E=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=bvW/bAlY7u9G684H8/dSD0yu/aggHzCa/VC19KwSYZ6p16EctnGZ1Yq5ssU1ky7PRdN5fLlei/OvNxKx9UdPebzWTjjn7LxQmFBLfpbNcCDfvOz+wA9agrkyDuCH/VYQDy+J4j4aLbvLtw7JLjWBn7lMrYvgOnmDY7h95/+kvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=1cDbI1KF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOmOhPS9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 73FA111400C7;
	Mon, 26 Feb 2024 06:04:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 06:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708945468; x=1709031868; bh=4rftxlO4TG
	0vRu6X+oJU8zpjfmLQJkJVGVso4QepWqk=; b=1cDbI1KFvBc9zDWdjjLJLrpwyA
	ecEkMLjCS6VUTdctTFO5goa+OkF2E9fi8I+8wF/nKDmBMDs7v3DPxWH5cTHDEmN1
	Fg5J+D+XqrGWQDHFi+zBxy2Fl1u+ho6km/C+80HrIeO9H8Ep+7VngJ8COI7dzBb7
	dSNwq00RAeNeQPIMcz69BuDXMx1OjBvJ8EvtUByEzIPm7rscvEMbJeNXAb6Ec5ak
	xl1PZhkEHZXXmJ31FjBkN7A5rBXLSx+GGbChzSwpZkS5oWgEDKopvVDb9KwMSTwn
	UK5+pks/4aY+KGsh4CaHaoZY4sts4/lNZgmSAU3mL8c4E0+88Vkx9+ICbopg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708945468; x=1709031868; bh=4rftxlO4TG0vRu6X+oJU8zpjfmLQ
	JkJVGVso4QepWqk=; b=BOmOhPS9oaUZApfgx0rsoe5nefS7g5iisxLtCytK6TGw
	aGGdaD5Co6riRsdz+z1oICJ38mu6zDPJdwEaAho2oL6SL9uyI9MLoQ9Y+adgQ5Et
	hRXdomuknUugMO5mOB2kR4W6A6dsB4fFQRHp2hPaxhoFE5oi+ttOb4JO+UDHbKoG
	qlkSAEm8jkaDaCWFZhZGtP+5OY07i+hG73DiOyt/GTThTvfFGHmw+r8TJ0/ja3xW
	+u4ajGWFV2i0/ImJ2MFpyZe7+/T5nfgIj+gMXn+KYg7Dc7fSykgDHYvujK/fwyfN
	MAqpWYE+UxnjaiVl0pBxnhVhJSi+jToinDs283K+jQ==
X-ME-Sender: <xms:O3DcZTFoLQ_yO25OJCOVy9S2JnIR4c_V4bJHUFkIouO546PeVEJ6gw>
    <xme:O3DcZQV_ExWh1YD0XxdWIRJgc5VWXfkEJ2bGqmjL3OFcsVNcPfGDOkHrPnV5Marqd
    57gTpfVEbK-Y6-Iwd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:O3DcZVLrZ-OTQ2b1gWT7TcXhEW1S55fIU6WBRzcx6gh8rSTYVJC-oA>
    <xmx:O3DcZRFKJoHWmR_N9u1Oy_71HzsBFU1jDDbsAle-g1zT-Q46tLtKow>
    <xmx:O3DcZZWTyKXdU4NJuBfYll0thz03CXH1fgBuz6rOPkdoOONjY8QIpg>
    <xmx:PHDcZbI7-XZSrQo7UBstceqoZX3UO_ULf0sunxdBRL4_0Ibao7Y4VQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 03ED7B6008F; Mon, 26 Feb 2024 06:04:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <34af21b5-a878-418e-a70b-299cab61b37e@app.fastmail.com>
In-Reply-To: <20240226105427.7191-2-fancer.lancer@gmail.com>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
 <20240226105427.7191-2-fancer.lancer@gmail.com>
Date: Mon, 26 Feb 2024 12:04:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Serge Semin" <fancer.lancer@gmail.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Alexey Malahov" <Alexey.Malahov@baikalelectronics.ru>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: cm: Convert __mips_cm_l2sync_phys_base() to weak
 function
Content-Type: text/plain

On Mon, Feb 26, 2024, at 11:54, Serge Semin wrote:
> The __mips_cm_l2sync_phys_base() and mips_cm_l2sync_phys_base() couple was
> introduced in commit 9f98f3dd0c51 ("MIPS: Add generic CM probe & access
> code") where the former method was a weak implementation of the later
> function. Such design pattern permitted to re-define the original method
> and to use the weak implementation in the new function. A similar approach
> was introduced in the framework of another arch-specific programmable
> interface: mips_cm_phys_base() and __mips_cm_phys_base(). The only
> difference is that the underscored method of the later couple was declared
> in the "asm/mips-cm.h" header file, but it wasn't done for the CM L2-sync
> methods in the subject. Due to the missing global function declaration
> the "missing prototype" warning was spotted in the framework of the commit
> 9a2036724cd6 ("mips: mark local function static if possible") and fixed
> just be re-qualifying the weak method as static. Doing that broke what was
> originally implied by having the weak implementation globally defined.
>
> Let's fix the broken CM2 L2-sync arch-interface by dropping the static
> qualifier and, seeing the implemented pattern hasn't been used for over 10
> years but will be required soon (see the link for the discussion around
> it), converting it to a single weakly defined method:
> mips_cm_l2sync_phys_base().
>
> Fixes: 9a2036724cd6 ("mips: mark local function static if possible")
> Link: 
> https://lore.kernel.org/linux-mips/20240215171740.14550-3-fancer.lancer@gmail.com
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

I'm sorry I introduced the regression here, thanks for addressing it.

> -static phys_addr_t __mips_cm_l2sync_phys_base(void)
> +phys_addr_t __weak mips_cm_l2sync_phys_base(void)
>  {
>  	u32 base_reg;
> 
> @@ -217,9 +217,6 @@ static phys_addr_t __mips_cm_l2sync_phys_base(void)
>  	return mips_cm_phys_base() + MIPS_CM_GCR_SIZE;
>  }
> 
> -phys_addr_t mips_cm_l2sync_phys_base(void)
> -	__attribute__((weak, alias("__mips_cm_l2sync_phys_base")));
> -

I generally have a bad feeling about weak functions, as they tend
to cause more problems than they solve, specifically with how they
hide what's going on, and how I still can't figure out what this
one aliases to.

Since the resolution of the alias is all done at link time
anyway, could you just convert these to an #ifdef check
that documents exactly when each of the versions is used?

      Arnd

