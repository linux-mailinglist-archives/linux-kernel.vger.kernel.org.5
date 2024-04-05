Return-Path: <linux-kernel+bounces-132906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E481899BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0198282E89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F4516C458;
	Fri,  5 Apr 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCHLFEzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183A16132B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316366; cv=none; b=A/zFpJ2czuI5tEyxPEL/btGsmURy0mXp1HT0QWHQG0NdJW0Un4f5NAEalKb6XiaJopNcgBSh+r9KEnD3KBf846imtLlLFeBTe5uP/tW1hPrdZWogxMnv09h03581GfBKrYx60bp4ikErEgHQ+jPgT8lwObilto7OPHrrdUqf9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316366; c=relaxed/simple;
	bh=AMRPVsvI5Nb+bU3i5rw5NJTnOuE7WZWcpxBq0NNIJW8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CgsVQHVgMNUwnL71depc0M95E3uWs1qoQjvuZLTYqcJP6j9abP5EmwRii3Cy9uC/M0GJJ/GVGu3oxK0HtSSpErh+lT7Buh2lJd4xVTSJ/SQzI7Ba0oMEoN1SCSm06yM6Ppq19y6K/fhaq+f4tDLIK9GFweVySEg7q1O9tGON1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCHLFEzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15543C433F1;
	Fri,  5 Apr 2024 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712316366;
	bh=AMRPVsvI5Nb+bU3i5rw5NJTnOuE7WZWcpxBq0NNIJW8=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=ZCHLFEzu7ooQeu3JhW5gMzG4vZ3pI/Zr22X4uVkkpnHQxTbi086KWJkbCAuWzmDZu
	 ezFa8bbN3Z44L9Krtg1jPB9gxHSxv7C1bhZhf0TlW0I6pbfGpyLtmvItzOo1byjDky
	 CHforGBTC++H1YqaqqWu0vTuAKrqgQmg3DczMUXla+gy4kwddNB5dbTQkqpy2BUW5H
	 wCl8zGuyKbY/lOvYljmGxOYkW/S47hXx/Qn1/6lCiBmcTGpLsX5EtL/aFPnkbBpqWm
	 ycfIsOvpomjcd80TsS7kGtlzw6sNhMFPiKgaSpbfbwqECH/ej+SYURUftAyn73so3k
	 uxkec+udmKhpQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1AD4F1200066;
	Fri,  5 Apr 2024 07:26:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Apr 2024 07:26:05 -0400
X-ME-Sender: <xms:zN8PZtl8dBQOoFn0pPzpIk9HVbL9UPQI-O1zmnA_eHHNtqfyps_aZw>
    <xme:zN8PZo06xuvzAZ-9kvmxg3gER3llDPRWTk6dX59ZeuCGgzSgd8vFUQa_7E_u3t2d7
    TnQZWUIAPGSDYk39i4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtffejfeeggefgleefgfeghfehfeefffetgffgleegudevveet
    hfefjeevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:zN8PZjr0XbPifJ8DapHQtMO0amYb56bWiyejGHmxV5bIPMAk8IsU4w>
    <xmx:zN8PZtmEyH6ShLFD8pXH0vpOb3mvuEqoZmXHR4Od683sO2IEOfys7A>
    <xmx:zN8PZr1KCwVkF_wuMUx6mwWb4dGEvThXKKB5APwcv2S1H-4KRWS1rw>
    <xmx:zN8PZss8F5hk-MMH16sN-fAbhnaVzWoxeWBAwXfKiZLZgPBmynzrvw>
    <xmx:zd8PZsxQwM37j_3ARK_qh-hUkR-BTEpl1AClH80twVE9GHmEOZdicu-H>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6DB2EB6008D; Fri,  5 Apr 2024 07:26:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11fdef9b-413d-4f88-b3d3-e5b27a88cf6f@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com>
 <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
Date: Fri, 05 Apr 2024 13:24:28 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Michael Schmitz" <schmitzmic@gmail.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, linux-m68k@lists.linux-m68k.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024, at 12:16, Geert Uytterhoeven wrote:
> On Wed, Apr 3, 2024 at 8:35=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>> On Wed, Apr 3, 2024, at 20:11, Michael Schmitz wrote:
>>
>> For the Q40, it may be better in the long run to change the
>> drivers to just use MMIO directly though.
>
> Q40 uses ISA.

Ah, indeed. I got confused by  the NE2000 example as that
contains "depends on (ISA || (Q40 && m)", which would have
indicated that it's not actually using CONFIG_ISA.

> Michael is worried about non-ISA drivers using inb() and friends.
> At some point in time (i.e. eons ago), we were told it was better to
> use in[bwl]()/read[bwl]() instead of directly dereferencing volatile
> pointers...

It's definitely still better to use an abstraction layer for MMIO
accesses using inline asm instructions than open-coding the
volatile pointer dereferences. Over time we have gotten better
at defining which of the available abstractions should be used
for a given bus, so inb()/outb() is now only really used for
things derived from ISA in some form, including e.g. PCI and LPC.

> Anyway, I don't think we have many users of inb() and friends left, and
> I assume the bots should have detected any/most remaining users in Nik=
las'
> branch...
>
> arch/m68k/include/asm/floppy.h on Sun-3x might be the only offender?

Could be. I think we can leave this one to whoever tries to get
sun3x floppy support working, it's been marked broken for a while
(see below). If there are any others, they will cause pretty
obvious build failures once inb()/outb() are removed from the
build, and they should be trivial to fix then.

     Arnd

commit f1e0f28a85001f4faa3ea930fcf201933f42340e
Author: akpm <akpm>
Date:   Mon Jan 19 18:31:30 2004 +0000

    [PATCH] M68k floppy selection
   =20
    From: Geert Uytterhoeven <geert@linux-m68k.org>
   =20
    Floppy: On m68k, PC-style floppies are used on Q40/Q60 and Sun-3x on=
ly. Sun-3x
    floppy is currently broken (needs I/O abstractions)
   =20
    BKrev: 400c2282G1O-TsH5FiwzPbOorftQhg

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 2dce1d2699a9..32fdec34568e 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -6,7 +6,7 @@ menu "Block devices"
=20
 config BLK_DEV_FD
        tristate "Normal floppy disk support"
-       depends on !X86_PC9800 && !ARCH_S390
+       depends on (!X86_PC9800 && !ARCH_S390 && !M68K) || Q40 || (SUN3X=
 && BROKEN)
        ---help---
          If you want to use the floppy disk drive(s) of your PC under L=
inux,
          say Y. Information about this driver, especially important for=
 IBM

