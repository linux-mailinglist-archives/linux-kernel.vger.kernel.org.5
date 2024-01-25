Return-Path: <linux-kernel+bounces-38266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E339683BDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF95B2E14D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970E200C0;
	Thu, 25 Jan 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="H6pVcBwO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYyNxe/g"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE71D559;
	Thu, 25 Jan 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174949; cv=none; b=TNaBxKyKHY4oTkR4wuSF9JLc3I3gF8sx2pKigPheSco5S91kdXAzqzYiw2euuTE/BVu2cZgyqTSE0f2aRX2eQ52PBHuTnjpCSC3Bsy98xzv5ueTfF/Qhd0F6yKfLA7aUDddAgkhdUyKW0Jy5kXDkCx24ZIY/uBvmngthcgy9VbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174949; c=relaxed/simple;
	bh=K/9JKflS9axsLrR15vQW/TMGMDqOa6Hya/B30Dusweg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ae5zcey6CG0xYH7+Kt3IZlb3cSqyJ1IefF+98+0sLn/rzVsnhepzQvsqfku+JoBdihrZsbTm0WTT5N2gNH9SpF4cwYQcdHX7FvNaRZdL9MbKHDRQqwIEiiXfEEl/T1HBrlyxLOwP2w/X88y6K8Jv2+SuPNjwgXo52GSJfii1B5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=H6pVcBwO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYyNxe/g; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9DB603200BB7;
	Thu, 25 Jan 2024 04:29:04 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 04:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706174944;
	 x=1706261344; bh=i0i8PWJmZEIkk+qKWWCdcOgFw5jqjthhyPV0wFojKbQ=; b=
	H6pVcBwO4ZLaGUzpBTECLQ40+Mm+pEnyKTDjgZdFJ8Y1TsT1ON1s2ELdQrlEH6BU
	cgUO71RyLbCfAj5g86T3buVZnH0ROTXRAIicxrC3LqI6yaaWOOmNtaSd/kr1gwHL
	OodId6jl3iSqNdPnTHT+Ax6vbN6ESIypN/+WEUQHvyo9C+Z9WHw6rUp88bJyiGXY
	aoUdZP83FOfUvWsiAXLJtSKxljh6Pg0/5jEr1ub9yiw4R5uAmCIEu1WADbBCO0CJ
	07q7VK5e9bPb9jgcT//yAEYR901RBjEgPYKFSYpJ4j+lkGkghysG/y89kodK9Wk7
	rZ/kWLSH9OCP3D8gLZeDCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706174944; x=
	1706261344; bh=i0i8PWJmZEIkk+qKWWCdcOgFw5jqjthhyPV0wFojKbQ=; b=T
	YyNxe/gap3a1Ds7o35cEU4eoD2hL/lLjyRrQ8FcKoji7qh+TjeUeWJ5lGVgFLE1x
	ZJCGjkVygP49mRc81E2QmexP2bxGbXrOctbw+Vy/bKGq8wTydaIJC1MmaFlBJXuk
	DFcFYSqWMHu2yvIQri/nA32t0eTD79ru2Qzo8NZ/fKXPKXy7/BKSjiRC8bGOnmOU
	DUI5rndTjp48GgQIPOHa3/3AyfaMX0i39eBEFkB3FrTC9fHwkljpBZ7Z8EBtmCEn
	Lba2+kPJRAB8anHmy2Fv6AhaLPEOD7mA4B7UluGFJx4XvteVFIF6aProT+t7pzZX
	Yz1F1vP7//Qhqq1kYfLaA==
X-ME-Sender: <xms:3ymyZVs21U8ZqnsOuXOaazdG7GlnzqP9TsgXip3xB7VzwWRfAKiHIw>
    <xme:3ymyZecCeNqV4wXeVIvmIxFUA_rUxbWDOwhCUFCXucHHy-KSkdahQ-VWTVFimWZAm
    G2D9bonnlbDNb3RQ6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelfedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:3ymyZYweCc5AvRnJAGpEFU4N4LYF2pZai5DeZhNKmGt1aU5g8_OhIQ>
    <xmx:3ymyZcM1R8HPm5mcwokD8eY6L7t3vbn8VRUoZh3SbpbCZerQqxwcKw>
    <xmx:3ymyZV_apitg7LRwV1kIf6usBWUhq5LZLX6KR7Tg-iRwVoScGwunYA>
    <xmx:4CmyZYkrjz7lcycg6O5LWtTHhKz6m4i46xXuqhYIEYJEXO1sjrZGvA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 46B4136A0076; Thu, 25 Jan 2024 04:29:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00d1b813-c55f-4365-8d81-d70258e10b16@app.fastmail.com>
In-Reply-To: 
 <CAHk-=whkEXGOCEZFO2vAZ9rDd8uW8MJwFNYg9KXaC_vZVso6iA@mail.gmail.com>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
 <mvmplxraqmd.fsf@suse.de>
 <9481b6d9d015aea25d8f2563bf7bd6f6462f758f.camel@xry111.site>
 <0be1203c9df55432548c92281c8392dfa2f7d6bf.camel@xry111.site>
 <e8583a3ab0522b4e75ba0ada47b6f093b186fa81.camel@xry111.site>
 <CAHk-=wgVrw+8P68Sy2krcc3QFbm_eu_DRs0-i7mct_0BDORZuA@mail.gmail.com>
 <CAHk-=whkEXGOCEZFO2vAZ9rDd8uW8MJwFNYg9KXaC_vZVso6iA@mail.gmail.com>
Date: Thu, 25 Jan 2024 09:28:41 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Xi Ruoyao" <xry111@xry111.site>, tsbogend@alpha.franken.de
Cc: "Andreas Schwab" <schwab@suse.de>, "Ben Hutchings" <ben@decadent.org.uk>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: Strange EFAULT on mips64el returned by syscall when another thread is
 forking
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B41=E6=9C=8824=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=8810:10=EF=BC=8CLinus Torvalds=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> Anyway, I'm pretty sure this is the bug, now some MIPS person just
> needs to fix the MIPS version of "instruction_pointer()" to do what
> "exception_epc()" already does.

Hi folks,

Kinda MIPS person here, I looked into the problem, and it's not that
easy to fix.

I inspected some existing usage of "instruction_pointer()", and some
of them do want exception return address (which is always CP0_EPC).
Others like this case they want the precise exception instruction
pointer ("exception_epc()" for MIPS).

I'm planning to make "instruction_pointer()" always point to exception
instructions, and implemented a new function called "return_pc()"or
whatever for "exception_epc()". Do you have a better name in mind?

Besides isa16 stuff do require kernel to read user space fault
instruction to determine delay slot size... I don't think it's always
possible when "instruction_pointer()" is called. MIPS16/microMIPS
is rarely used today though.

Thanks

>
>               Linus

--=20
- Jiaxun

