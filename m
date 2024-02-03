Return-Path: <linux-kernel+bounces-51029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E1848533
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC8C1F27249
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39CE5D756;
	Sat,  3 Feb 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IrmA9Blo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6V7wSqY"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03E5C91A;
	Sat,  3 Feb 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706956859; cv=none; b=Z21adkW8EaUGo6rW7Fq6i/CamFXGSiFYRWu7/+ss8xGCvQFuD4KMIjFYVckWYsDS+lzZCjTPciB7F+l4i9xFEy1M8mrxtiRJvlYl29/vGGdJgWzf6OFDzcjtVwYLwSefNWExiBu73Az0dwZ1d/kb7zVYObUUxzD42YBlJ8IwcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706956859; c=relaxed/simple;
	bh=V7xBJrQen3yHaLq2IUHKBijYH6HFoMJbSIfYjSbeDuc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PKfivwcTIqbsKOl/xXr12wjm0snwlk6V0/uyrksiZmrHSuyDKR1eAYGe/YHZ/Acpgre64SraENRHbA4k3gxzISdwjNN3a+oYbCGqjxCvVrv2osKT/nJORvCdD4zREqwoBhK+3L0yN71tjQfOaKR60yDH/dq47fYhFTpQaxWndSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IrmA9Blo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6V7wSqY; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id F12FD3200B15;
	Sat,  3 Feb 2024 05:40:54 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sat, 03 Feb 2024 05:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706956854;
	 x=1707043254; bh=5i1vqb5NehMGoPuv1e9ZjiUnajUF+hzp+g2HFH1CXoM=; b=
	IrmA9BloMIRk9DuufY7g71TtazNUwzM2XjbIvTlrtEXjVpWOYaDrBH2jLTrx5kj6
	aihz+zqUEJuLokGHvt9HastOyFmGv1mOvwqxs/wQk2lhkt59+neUvR2gJNeTCs0R
	kd5yJOHMV5/bE9mH44VeXekDo8S1w27GP5CCUaVwHmqFpmB6Gns/GJC43HT+p2hE
	cGyoIRgV+b3LF2JN/+Rx53ppVeoIA5IjwwLnjfiIM/7GLzJIUgVd/Ry/YOwbuww/
	KDEP0tTyYzApTfsjMVh2DoLKs1VLbJe8/Pnfii1lH4YrxuRLtVXj+SZF2HdGmTz8
	mLMTMhnkYjjA7nkDI4yquw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706956854; x=
	1707043254; bh=5i1vqb5NehMGoPuv1e9ZjiUnajUF+hzp+g2HFH1CXoM=; b=A
	6V7wSqYX3vuYt8RellyWE0DmACaKNVt/mHGsbY5cC4G/0NTcawFPXRKH4YFe0Wsx
	7Y/cVwvjAvLc06E85s0ZtinCfcpTrcJEbDfg9nQEsfHRKtD8AokvMUSrMcXaaEkF
	zG55O3+jPraT02V4JT1azsIlNkMBER4/Sua2RZT0CJ21dlSFCDQHWhJqIK3Zxrm+
	1+aV8YrJ2cADWhQscfaD6SCIrxUyqjeJx1ABQAZFKAvQgl/T5XL1+3karPqOUNx2
	AnFrbN1wed3ABygMEfc6aO1fGyNTcorzJyhUWyH+cu32H6NqgNSt0k0wduF2lWwH
	tKS8rY7OCCnR12m3GgxOg==
X-ME-Sender: <xms:NRi-ZUNj4Dsw3FNu9ThpsIy_UJBzt9yJWyIiPSwBOQzhlpz_nkgwvw>
    <xme:NRi-Za-RcvvQhz6wNaNGhb_P49q155RPQPjXE5x5_ruJS8KCTxTr--r0ECctKjdq7
    vZFJ4mZP7pTWGFf0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhudfhffetvdegfeeiudduleekheelteefgfdtleffuddt
    ffduffeigffghfegieenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhinhhfrhgrug
    gvrggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Nhi-ZbSZXwUZnQWrffX5b9IabcbW8dAVCeBfnJCvx6MvYRLCU53u_w>
    <xmx:Nhi-ZcuVnzzuPDEjOv-exsaewy2a5lD1Ixvd4O1zxpWfRl-8fzc6Pg>
    <xmx:Nhi-Zcft7o0p5F6m2bvBaLIR1hwgdcaZ6F0Ao1f6mfYb5w0lwrid7Q>
    <xmx:Nhi-Zavl71KwJAgeAGvURdX7bSrP6FyGq9CVg0a-avtCKUXOJ-l2Pg>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DE8071700093; Sat,  3 Feb 2024 05:40:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5657c211-531b-4890-8c52-182b7b4eae7c@app.fastmail.com>
In-Reply-To: <701d3350-93d3-4235-aaf7-04c6492420a7@rivosinc.com>
References: <20240201140319.360088-1-cleger@rivosinc.com>
 <ZbxUUsKdKIPI8Fb/@ghost> <701d3350-93d3-4235-aaf7-04c6492420a7@rivosinc.com>
Date: Sat, 03 Feb 2024 05:40:06 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Robin Ehn" <rehn@rivosinc.com>
Subject: Re: [PATCH] riscv: hwprobe: export VA_BITS
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024, at 3:22 AM, Cl=C3=A9ment L=C3=A9ger wrote:
> On 02/02/2024 03:32, Charlie Jenkins wrote:
>> On Thu, Feb 01, 2024 at 03:02:45PM +0100, Cl=C3=A9ment L=C3=A9ger wro=
te:
>>> Some userspace applications (OpenJDK for instance) uses the free bits
>>> in pointers to insert additional information for their own logic.
>>> Currently they rely on parsing /proc/cpuinfo to obtain the current v=
alue
>>> of virtual address used bits [1]. Exporting VA_BITS through hwprobe =
will
>>> allow for a more stable interface to be used.
>>=20
>> mmap already supports this without a need for applications to know the
>> underlying hardware. If a hint address is passed into mmap, it will n=
ever
>> return an address that uses more bits than the hint address. I design=
ed
>> it that way so that something like this wasn't necessary.
>
> Ok even though probing this kind of thing is probably not what mmap is
> meant to do. IMHO, probing this through the regular hwprobe interface =
is
> probably more coherent but maybe Robin (which needs this information)
> can rely on that.

Both of these are useful, separately and in conjunction.

hwprobe allows applications which can adapt to different VA sizes to lea=
rn
which is in use prior to allocating memory.

mmap hints allow applications which require a fixed limit on the VA size=
 to
express that limit at the point of requirement, the hint can be set base=
d on
the hwprobe result to explicitly indicate its use.

-s

> Cl=C3=A9ment
>
>>=20
>> - Charlie
>>=20
>>>
>>> Link: https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/=
linux_riscv/vm_version_linux_riscv.cpp#L171 [1]
>>> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>>>
>>> ---
>>>  Documentation/arch/riscv/hwprobe.rst  | 3 +++
>>>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>>>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>>>  arch/riscv/kernel/sys_hwprobe.c       | 3 +++
>>>  4 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/ar=
ch/riscv/hwprobe.rst
>>> index b2bcc9eed9aa..6f198c6ed4f0 100644
>>> --- a/Documentation/arch/riscv/hwprobe.rst
>>> +++ b/Documentation/arch/riscv/hwprobe.rst
>>> @@ -210,3 +210,6 @@ The following keys are defined:
>>> =20
>>>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int w=
hich
>>>    represents the size of the Zicboz block in bytes.
>>> +
>>> +* :c:macro:`RISCV_HWPROBE_KEY_VA_BITS`: An unsigned long which
>>> +  represent the number of bits used to store virtual addresses.
>>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/a=
sm/hwprobe.h
>>> index 630507dff5ea..150a9877b0af 100644
>>> --- a/arch/riscv/include/asm/hwprobe.h
>>> +++ b/arch/riscv/include/asm/hwprobe.h
>>> @@ -8,7 +8,7 @@
>>> =20
>>>  #include <uapi/asm/hwprobe.h>
>>> =20
>>> -#define RISCV_HWPROBE_MAX_KEY 6
>>> +#define RISCV_HWPROBE_MAX_KEY 7
>>> =20
>>>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>>  {
>>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/incl=
ude/uapi/asm/hwprobe.h
>>> index 9f2a8e3ff204..2a5006cddb7b 100644
>>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>>> @@ -67,6 +67,7 @@ struct riscv_hwprobe {
>>>  #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>>>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>>>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>>> +#define RISCV_HWPROBE_KEY_VA_BITS		7
>>>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>> =20
>>>  /* Flags */
>>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys=
_hwprobe.c
>>> index a7c56b41efd2..328435836e36 100644
>>> --- a/arch/riscv/kernel/sys_hwprobe.c
>>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>>> @@ -202,6 +202,9 @@ static void hwprobe_one_pair(struct riscv_hwprob=
e *pair,
>>>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>>>  			pair->value =3D riscv_cboz_block_size;
>>>  		break;
>>> +	case RISCV_HWPROBE_KEY_VA_BITS:
>>> +		pair->value =3D VA_BITS;
>>> +		break;
>>> =20
>>>  	/*
>>>  	 * For forward compatibility, unknown keys don't fail the whole
>>> --=20
>>> 2.43.0
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

