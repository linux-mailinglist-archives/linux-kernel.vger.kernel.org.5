Return-Path: <linux-kernel+bounces-75029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0D85E1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23D5B2326F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB1811E0;
	Wed, 21 Feb 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="U0AjhVBP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARCCDyO9"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0980C1F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530729; cv=none; b=BzkWPivUuX8TkZuvkzGxHptj1QguN2fSQW8Ll1wst7Qez9qKKgd8FvdQM5i4J/onlXG7v8YEXqQpcKEcLi1Y5IhZRDYb3qPrTU1owJZTCJG1HGJVaugU1cTQSUi0AD68FrpMoZMqXn5s3JDFqJvsZJYwYDIyrP5aBFiDGul74Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530729; c=relaxed/simple;
	bh=rQmpyHEDfBCAE14U6pAgMeOsLNXeFl8eCY13ffT3wJs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oDlL0JVNibWuwWQpZTR6YYgHkb6Pl/EP2W/pGmuqxai3LpQYQ2YNDF3A/MetgJbBgnNhqgtoLF77NMP7P5LyZovN+yI9GBx5bkXatlaQnlJBjDBNmLoUq7QWNWToeSC9wbJd13NT3qc+Zisc2zRvnlweLvNoFu6AnPPM/gf4rGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=U0AjhVBP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARCCDyO9; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 22AEB32009F4;
	Wed, 21 Feb 2024 10:51:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 10:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708530717;
	 x=1708617117; bh=gVu1iI5vdx9XToGEy4tfJPs0uFj04KlwRACeTsBwi+k=; b=
	U0AjhVBPYH0d3c2Xs3nzmoYNEESQlxSQVJVV+6wGIimUNHLBLBuuIANw4g2PAnqF
	RZwvds/nPFaQbaI0HNp/SPhoiPjx/qEXBGKoxI82t4t2XrZaVRcrexrLt1Bj36zr
	ra/bFA6iZ+b6Qbw/tDzBJsJ6dyf1nM4ZP8woBKVrm50/iPtB7KTArK7hr4G64BJf
	30TA1hjAQHBziLYFkcj1PtzGLJDKqncMfWJsrFI4GW2lHzvuF6BoPOBiBnHTljzO
	VjLGcdAzsE4YSHaP+05JPFqNoHOdMrdVNO9mTi8LtlyUZTGOHgSsI7GWniyciPQH
	kBmf5DpPPDMGwpggeaH/xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708530717; x=
	1708617117; bh=gVu1iI5vdx9XToGEy4tfJPs0uFj04KlwRACeTsBwi+k=; b=A
	RCCDyO9Ws/OjxYAJaB5XYuGLjqbC3+KECAZNSEanu6luWAxv7wMOB/BMprheLN6g
	y+jU98831ShlHXtb1M87JprIxQN/35KmleYshkHl3YIWA5fduNdDIoJYcDGgR4zj
	Pn6dEXf91Z0+Rv07sZbwFMPdlYfVvXfqNV96LckSpiNN6txgD9IpvGrMOrvjeJkr
	g8fFA6lZBXxGkIb5oLGwvGSlJmbOXLJGt9cbgpdxhdRIQ+ZzVheRsSu8+dbcBrrV
	NOBoFHfTRDzBSvU/edZVUHgOqEKyyc7Gb88XQi/+LLymZnWGSHqgmmCupkszXHkm
	5PH6sGEfYsMvZRh56Zk2A==
X-ME-Sender: <xms:GxzWZaGqZ9QRBIAPBQ02N2zq1jHKtJjHXF4q8YJnZ5iHTahCukU6IA>
    <xme:GxzWZbVo0sW2Lzk5gM9OTUMHWnPhp5TghH5tSI83x3_wWlU5mgT2YduFA0TOxrvk-
    Qx4Bgiwku0k3_gBm9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:HBzWZUKL5bjW7Cww8j_PCzYWSswEPiy1v3wsjs0PdIAfSSHoEMdMBw>
    <xmx:HBzWZUEDldZ3veiExkPMYUntaSg7UqjGvQyHUiRv9Gu61hN56ddJSw>
    <xmx:HBzWZQWNjtgK1Jbk7L6YNAB_2k-eJp5A_UC5qYo-GDeMPt4LciHqHw>
    <xmx:HRzWZRsvItpu3oVcJFAxMh3MVz0bZhIcd2QTupPcwC6w-Z29iX_ahg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D5BD9B6008D; Wed, 21 Feb 2024 10:51:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
In-Reply-To: <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
 <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
 <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
Date: Wed, 21 Feb 2024 16:51:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuntao Liu" <liuyuntao12@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Russell King" <linux@armlinux.org.uk>, "Andrew Davis" <afd@ti.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>,
 "Eric DeVolder" <eric.devolder@oracle.com>, "Rob Herring" <robh@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024, at 10:53, liuyuntao (F) wrote:
> =E5=9C=A8 2024/2/20 16:40, Arnd Bergmann =E5=86=99=E9=81=93:
>> On Tue, Feb 20, 2024, at 09:15, Yuntao Liu wrote:
> #
> # ARM discards the .data section because it disallows r/w data in the
> # decompressor. So move our .data to .data.efistub and .bss to .bss.ef=
istub,
> # which are preserved explicitly by the decompressor linker script.
> #
> STUBCOPY_FLAGS-$(CONFIG_ARM)	+=3D --rename-section .data=3D.data.efist=
ub	\
> 				   --rename-section .bss=3D.bss.efistub,load,alloc
>
> ---
>
> I think that .data.efistub represents the entire .data section, the sa=
me=20
> applies to .bss as well,
>
> so i move all .data and .bss into the stub here.
>

Ok, I see.=20

>>=20
>> I guess this prevents discarding any function that has a reference
>> from pv_table or ex_table, even if there are no other references,
>> right?
>
> Indeed so, if not keep ex_table,  the compilation process will result =
in
>
> an error:
>
>      no __ex_table in file: vmlinux
>
>      Failed to sort kernel tables

Sure, and without the ex_table contents, it would not be able
to recover from a failed uaccess either.

> and if not keep pv_table, It can be compiled successfully, but the QEM=
U=20
> boots will fail.

Right. The pv_table isn't technically necessary since it can
be disabled.  I think it was originally introduced in order
to avoid performance regressions when we introduced multiplatform
kernels that can run at arbitrary physical addresses rather than
having it as a build-time constant.

I don't know how much difference that actually makes for performance,
so turning it into a normal runtime lookup may or may not be
a good compromise when building with HAVE_LD_DEAD_CODE_DATA_ELIMINATION.

I have given your patch some build testing with random
configurations in my build setup and it seems to work
fine with gcc/binutils, but unfortunately I came across
a link failure using clang/lld:

ld.lld: error: ./arch/arm/kernel/vmlinux.lds:35: ( expected, but got }
>>>  __vectors_lma =3D .; OVERLAY 0xffff0000 : AT(__vectors_lma) { .vect=
ors { KEEP(*(.vectors)) } .vectors.bhb.loop8 { KEEP(*(.vectors.bhb.loop8=
)) } .vectors.bhb.bpiall { KEEP(*(.vectors.bhb.bpiall)) } } __vectors_st=
art =3D LOADADDR(.vectors); __vectors_end =3D LOADADDR(.vectors) + SIZEO=
F(.vectors); __vectors_bhb_loop8_start =3D LOADADDR(.vectors.bhb.loop8);=
 __vectors_bhb_loop8_end =3D LOADADDR(.vectors.bhb.loop8) + SIZEOF(.vect=
ors.bhb.loop8); __vectors_bhb_bpiall_start =3D LOADADDR(.vectors.bhb.bpi=
all); __vectors_bhb_bpiall_end =3D LOADADDR(.vectors.bhb.bpiall) + SIZEO=
F(.vectors.bhb.bpiall); . =3D __vectors_lma + SIZEOF(.vectors) + SIZEOF(=
vectors.bhb.loop8) + SIZEOF(.vectors.bhb.bpiall); __stubs_lma =3D .; .s=
tubs ADDR(.vectors) + 0x1000 : AT(__stubs_lma) { *(.stubs) } __stubs_sta=
rt =3D LOADADDR(.stubs); __stubs_end =3D LOADADDR(.stubs) + SIZEOF(.stub=
s); . =3D __stubs_lma + SIZEOF(.stubs); PROVIDE(vector_fiq_offset =3D ve=
ctor_fiq - ADDR(.vectors));
>>>                                                                     =
                      ^

I don't immediately see what the problem is here, I hope you
can address it before you send a v2.

     Arnd

