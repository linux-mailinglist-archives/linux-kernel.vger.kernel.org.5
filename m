Return-Path: <linux-kernel+bounces-90669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4608702F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830A41C23D66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BA3EA90;
	Mon,  4 Mar 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R1IAOTmu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FaZwP54C"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CC3E476;
	Mon,  4 Mar 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559624; cv=none; b=nZkYKkT08BJCo3ofgGPRXrsKUZHFePRVqYedeFo6+omleRhloDV/1DF7r5DbRCGAMLdZ/tvK5+SyGw3BHaVxw7ZfITGTLk38w2Y/wp9HsCNngWcx4fQWg17p1uNbhqnSokDvlIwwF/sAytU8iLa7AqsxCxWXukkSJp2qZiEK1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559624; c=relaxed/simple;
	bh=ZYdT3iItmnJruFC6xF2d6YKkBaBHtFkEgc66Mn+LbDA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GkRywtZwVk4qP7A+GgyDA8gb1YHHzoSFqBkGJzCPj2yuQqfIIrK0DrPmKgfuJTQ7h9Ct3tA0XkHICEr0sNCNJET8IpiRHdcZMXZP2tocjdOms9cvFK6CrygPLHhbqXBhjEcqBWrSLZ5973Z1IqI8s1rKLHXaOo7Oz4EUEJpRv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R1IAOTmu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FaZwP54C; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A761911400DD;
	Mon,  4 Mar 2024 08:40:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 08:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709559620;
	 x=1709646020; bh=JnzQU3YalCI4TUT6McBMmglHS9rL937qY3XCJY4+tWs=; b=
	R1IAOTmuHYh/L9nU2wUO4yjoilzH/7UeExzcIC7wN48zdUlWj5pXl/G6iLyGQsr/
	KRUcUWKQ1+8ggMtWRexdqjQjUtrgnqCEL/I4NiXKvgIQFPjFiIpZPzvx0Iamv512
	/JyFscks0xzqY9h9ImXlxNjk7imAnpsntRmLQruHEONvu2eGv5lYxBjgpURRRwI4
	Le5khxEVavZn4Q/PbUlMNu0xRAvF/6ifEzDsNBBnb6b0cImRr+5KP2RIojbxCG2v
	Tn5qwyF5vZdJMZtX5DPyexKt8UhsM1TiNDdV558CAr6z9tdU2KQ4Ei5VDOwEMgwB
	9HH8k/cjE6iXLqVLwxhVCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709559620; x=
	1709646020; bh=JnzQU3YalCI4TUT6McBMmglHS9rL937qY3XCJY4+tWs=; b=F
	aZwP54CYz0azzKBZjvVUZa4ySeDNIFp82WhOaKz2iOk9HC48IggbeBdgZNp8t4n/
	WhnfMXoBif/O2Q+bcSXJnaHbr0HQ7bItBOLyty0X/5vv5tCxPcOUuRz/Z2nJhZGS
	K+TLfB5maHfobLuw95teIkjeoitWFQqMMvyFYeRfQnQzijy01QNnt3WM3969xuc3
	f5F5lTrG5jihL4XA6XqAT7KIu/+KMlFvtYh3ZL/drdO0BpSXceRmMOPSBbs8W0vE
	+yScoOyV4S250CgIAXXswLwEVThOb7FK6f082CECW8S8c5GZku9IiBzerUTw/7n4
	omeRU3juKFerdJyyv0QGw==
X-ME-Sender: <xms:Q8_lZWaF3erXnPemV_ybMe2YIKHDF0Bd-SRQtWojiJKncLFwmzHolw>
    <xme:Q8_lZZaMKbw95sy8_1sc-EafpCGAT8eb_0Bxx_JnO3De_436UGaWXGDDxztmwjiO7
    mPptVo8sy_ueoOFGqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepleelgfdtjeevjeehiefhueeuffdtkeduhfelueeiledthfffieejveeuteel
    leefnecuffhomhgrihhnpegtshhumhhiphhviedrshgsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Q8_lZQ_4pxd2WUcbIldtNPn0qqPJj1wJTElNWz5R43TDcdTKmC1BeA>
    <xmx:Q8_lZYqEGfCmf-IyVWi250m1sOeQykqsrtott7zIwpGFwywy6U_iRQ>
    <xmx:Q8_lZRovbT97p-VV4TqjcDGD41cvY9fUAkZYOIVHXSJhYxud-colJQ>
    <xmx:RM_lZS5h0Ymxx80f01HCHd7TjLf2GKci2waMNyinrlZ2XH2vpC6vqA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C63AAB6008D; Mon,  4 Mar 2024 08:40:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a254a52c-340d-47ba-9a69-b5144dc75e4e@app.fastmail.com>
In-Reply-To: <4e227412-ccac-4771-8aa6-a716e7c07090@csgroup.eu>
References: 
 <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <62b69aaf-7633-4bd8-aefe-5ba47147dba7@roeck-us.net>
 <f422742a-4c86-4cb0-a4f7-a62f0310eb23@csgroup.eu>
 <6df98c91-26b1-497a-9202-18bf86c0130d@roeck-us.net>
 <4e227412-ccac-4771-8aa6-a716e7c07090@csgroup.eu>
Date: Mon, 04 Mar 2024 14:39:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Guenter Roeck" <linux@roeck-us.net>, "Russell King" <linux@armlinux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "David Laight" <David.Laight@aculab.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Parisc List" <linux-parisc@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum and
 csum_ipv6_magic tests
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024, at 12:39, Christophe Leroy wrote:
> Le 03/03/2024 =C3=A0 16:26, Guenter Roeck a =C3=A9crit=C2=A0:
>> On 3/3/24 02:20, Christophe Leroy wrote:
>
> I don't know much about ARM instruction set, seems like the ldr=20
> instruction used in ip_fast_csum() doesn't mind unaligned accesses whi=
le=20
> ldmia instruction used in csum_ipv6_magic() minds. Or is it a wrong=20
> behaviour of QEMU ?

Correct.

On ARMv6 and newer, accessing normal unaligned memory with ldr/str
does not trap, and that covers most unaligned accesses.

Some of the cases that don't allow unaligned access include:

- ARMv4/ARMv5 cannot access unaligned memory with the same
  instructions. Apparently the same is true for ARMv7-M.

- multi-word accesses (ldrd/strd and ldm/stm) require 32-bit
  alignment. These are generated for most 64-bit variables
  and some arrays

- unaligned access on MMIO registers (__iomem pointers)
  always trap

- atomic access (ldrex/strex) requires aligned data

- The C standard disallows casting to a type with larger
  alignment requirements, and gcc is known to produce
  code that doesn't work with this (and other) undefined
  behavior.

> If I change the test as follows to only use word aligned IPv6 addresse=
s,=20
> it works:
>
> diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
> index 225bb7701460..4d86fc8ccd78 100644
> --- a/lib/checksum_kunit.c
> +++ b/lib/checksum_kunit.c
> @@ -607,7 +607,7 @@ static void test_csum_ipv6_magic(struct kunit *tes=
t)
>   	const int csum_offset =3D sizeof(struct in6_addr) + sizeof(struct=20
> in6_addr) +
>   			    sizeof(int) + sizeof(char);
>
> -	for (int i =3D 0; i < NUM_IPv6_TESTS; i++) {
> +	for (int i =3D 0; i < NUM_IPv6_TESTS; i +=3D 4) {
>   		saddr =3D (const struct in6_addr *)(random_buf + i);
>   		daddr =3D (const struct in6_addr *)(random_buf + i +
>   						  daddr_offset);
>
>
> If I change csum_ipv6_magic() as follows to use instruction ldr instea=
d=20
> of ldmia, it also works without any change to the test:
>
> diff --git a/arch/arm/lib/csumipv6.S b/arch/arm/lib/csumipv6.S
> index 3559d515144c..a312d0836b95 100644
> --- a/arch/arm/lib/csumipv6.S
> +++ b/arch/arm/lib/csumipv6.S
> @@ -12,12 +12,18 @@
>   ENTRY(__csum_ipv6_magic)
>   		str	lr, [sp, #-4]!
>   		adds	ip, r2, r3
> -		ldmia	r1, {r1 - r3, lr}
> +		ldr	r2, [r1], #4
> +		ldr	r3, [r1], #4
> +		ldr	lr, [r1], #4
> +		ldr	r1, [r1]
>
> So now we are back to the initial question, should checksumming on=20
> unaligned addresses be supported or not ?
>
> Russell I understand from previous answers from you that half-word=20
> alignment should be supported, in that case should ARM version of=20
> csum_ipv6_magic() be modified ? In that case can you propose the most=20
> optimised fix ?

The csumipv6.S code predates ARMv6 and is indeed suboptimal on v6/v7
processors with unaligned ipv6 headers. Your workaround looks like
it should be much better, but it would at the same time make the
ARMv5 case much more expensive because it traps four times instead
of just one.

> If not, then the test has to be fixed to only use word-aligned IPv6=20
> addresses.

Because of the gcc issue I mentioned, net/ipv6/ip6_checksum.c
and anything else that accesses misaligned ipv6 headers may need
to be changed as well. Marking in6_addr as '__packed __aligned(2)'
should be sufficient for that. This will prevent gcc from issuing
ldm or ldrd on ARMv6+ as well as making optimization based on
the two lower bits of the address being zero on x86 and others.
The downside is that it forces 16-bit loads and stores to be
used on architectures that don't have efficient unaligned
access (armv5, alpha, mips, sparc and xtensa among others)
even when the IP headers are fully aligned.

     Arnd

