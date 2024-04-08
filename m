Return-Path: <linux-kernel+bounces-135627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC4089C8C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB1A1C24365
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4B1422A2;
	Mon,  8 Apr 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIH6r3wf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6771420C8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591440; cv=none; b=VObGWHujkPPm07+SQ/yPi7BVtiTSsEBYynd03LAWmwwGtzNnzMdUBoIAtY4wsNxRfqhfh9KOuIAk6fwKfObLH1rSSM1ztGCygFRtZaEZrfkFhRYLWcAIC9yVkvnIfQm4S8tqNCJPO277ApEfh0zpBTgOHyddiu//ZpVx3WJ6e6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591440; c=relaxed/simple;
	bh=BnzHtJP+mzhnx61ojSEFsfHzwz1nj3hUWfsnlB/PFvo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uvsvn/1R0k0pY+WXAFX7HZAmdfme5WM/lq4c1ICLb0wR/nOcATs59IQwGlZIpDkUJkyaEYZyUQo538LUQxXSOahYx2uc9c2/idTJQjoLZUKXgjfIdiA7aC4nhTPFJdHaiSRlIOzODauInSEHS2htZw/5l9K0G4p3AkOMq0iAoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIH6r3wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F7EC433C7;
	Mon,  8 Apr 2024 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712591440;
	bh=BnzHtJP+mzhnx61ojSEFsfHzwz1nj3hUWfsnlB/PFvo=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=XIH6r3wfe9Z591QUfyJ9MM03ZOVDxbmIZV35Xizr8iyWHYE2q+emfaXxZ0oi6eI82
	 ObISCgeFUhbbvEtIAPOCXAhVGBsuGb8Pr5fZctSj0IVo7dq+/xODyux61Rzmdqlpi6
	 0xpfWd1wPwduWsKUA7mWtTMB17YIBVyvOsYJGVRQG/BDzsyDb4e4ONV/U6yGEbe8Kt
	 LjFcWhVkG1gMoH8UYWPVClq5q82CUmWmv66x9OzXaLPEWQ+lN3SgabhS6MEIniNvSJ
	 xsA9QcZLpHMPVWO/Nqz4TGPwbnMmRSwdk9CdhTO2bMYbsmWP1pMCsDCHC69gPiC75i
	 GfvVqTSdV1CRA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1F7C91200068;
	Mon,  8 Apr 2024 11:50:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 11:50:39 -0400
X-ME-Sender: <xms:ThIUZh8Hzo7qekgKGngjNy1UvK2pDfMmMumuTXIfHa9SSqu56viiXw>
    <xme:ThIUZlv-qKLAcXT1bCBwhxVwx2mMRKaRw4i2NZ35NRso0QgsjiGNH6_aeikHzUs4n
    GKBLeeLxf05cwIPIF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtffejfeeggefgleefgfeghfehfeefffetgffgleegudevveet
    hfefjeevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:ThIUZvBmvnPqxs_thxB3r6rGCRDtjpQRQZayIYVH4GFqkJi90bp9og>
    <xmx:ThIUZlfgsKI5zb31ZSYxZvTI6Edi1yCeP2OybAl34lhpgegavol0-A>
    <xmx:ThIUZmNzVa1QN3-IOl-Qwm5KoiQ-Zf9yzS3poKE3U07grIoCZvJXSQ>
    <xmx:ThIUZnmvN030T2sMwAFWnWY-SbKKZB4QWqIzkt2qgo1gqzOekwfOjg>
    <xmx:TxIUZgv-hQw70Hfhyf9OklY5ogxyXbCda5MWggI9NyVZuUyXiVYdj5WF>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D3686B6008D; Mon,  8 Apr 2024 11:50:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a78fae4c-6ab4-4ac1-ae72-c68b24ebb640@app.fastmail.com>
In-Reply-To: <6251fc72-21ca-aba6-c70a-eefdbc046951@linux.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <1a14ac6e-30e9-048e-50cc-c1c3aacc2118@linux.intel.com>
 <a98fdeca857f4eb1e3513a8658ef55f89ac45e8b.camel@linux.ibm.com>
 <6251fc72-21ca-aba6-c70a-eefdbc046951@linux.intel.com>
Date: Mon, 08 Apr 2024 17:50:11 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024, at 17:41, Ilpo J=C3=A4rvinen wrote:
> On Mon, 8 Apr 2024, Niklas Schnelle wrote:
>> On Mon, 2024-04-08 at 12:54 +0300, Ilpo J=C3=A4rvinen wrote:
>> > On Fri, 5 Apr 2024, Niklas Schnelle wrote:
>> ---8<---
>> > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial=
/8250/Kconfig
>> > > index 47ff50763c04..54bf98869abf 100644
>> > > --- a/drivers/tty/serial/8250/Kconfig
>> > > +++ b/drivers/tty/serial/8250/Kconfig
>> > > @@ -6,7 +6,6 @@
>> > > =20
>> > >  config SERIAL_8250
>> > >  	tristate "8250/16550 and compatible serial support"
>> > > -	depends on !S390
>> >=20
>> > Why? Your changelogs gives zero insight on this change.
>>=20
>> I used this for compile testing since I build on s390 natively and th=
is
>> would have hidden the missing HAS_IOPORT dependencies I'm pretty sure
>> it was added because of the I/O port problem too. I'll either add to
>> the commit description that it is no longer needed or drop this. Any
>> preference?
>
> Okay, we might never know the reason for sure if that's old enough.
> I think the best approach would be to put it into own patch so this=20
> guessimation is limited to a single liner patch instead of it being=20
> hidden among the other clearer cases.

From the description in commit 1598e38c0770 ("serial: forbid
8250 on s390") I would just leave the dependency there.

     Arnd

