Return-Path: <linux-kernel+bounces-133973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D189AB9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF152823C0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F43BBC1;
	Sat,  6 Apr 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpEUpiap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388263B18D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417246; cv=none; b=kEXOSfyzRJo6RWZAuHI/JCHRbEr1oiqwm/6D7GVVdg+EzQtqCZeduGZDNO+QVxHPkE2FyuS/NXNRPEHXIQV2c2DrYz1LHOEmSoZfNAytwdREOLAiPX7rSYGblR34EUiFTJ3iwywYhQ1+iLq/64EpXjVuWC2+8jVUeo2zea91I/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417246; c=relaxed/simple;
	bh=2rySa9t9VCItK6MZJ9ubIFsysl4IsjaeTxE0EGK1V7Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PqmSMxFcQUKb1NobbxXTVuGjPCNA//5W+BVFWMorC1GI0GK/rZ7kbmmGNKTBjtcoOEcPTKcJVgj7vhBcZceAOyE3XjQdEIeccK61wq3kVrPhY9vbD0GgsRIk2/JyJQBr9sc55fNa4R5PNr2czLH2SVdJvUp76VQARqBU8MleNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpEUpiap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7CBC43394;
	Sat,  6 Apr 2024 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712417245;
	bh=2rySa9t9VCItK6MZJ9ubIFsysl4IsjaeTxE0EGK1V7Y=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=EpEUpiapYMNcn35KoFQr4r+T1mq/Xd3hUqTVaf8wQNm+LyGBNgGJSk6Jq+Zr+1FtM
	 jJChI1nJUcSosMep32XCj8ED5WtTPxzXXmSafxBDhVv0U1VZwX02xQ+19aW9xBUaUA
	 hCg42yKaJHuVBtE/AWkKBi0y6kdUWb/YwVAZx5JC90P38+OCekI1gaFlJoDV4cNRxg
	 8D9+0PnomvKXelAqBK8PSVmuXJt3GP3JEMm3HeUUl5762Y5c/3cV+BPeQs7c9fOsPX
	 W5uk5ar3DohzQIgNGPmWdcryh7QKZ3c7l/sGEoygzsew9XGkNjj2dJbBS9gUxEYaCE
	 8imEslZThxkdQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8BF731200069;
	Sat,  6 Apr 2024 11:27:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 06 Apr 2024 11:27:24 -0400
X-ME-Sender: <xms:22kRZlsFp_T1WwQn928fD_jbxXHhE4ITfSHocl2i5kAuKiGAquD8ww>
    <xme:22kRZuclx1vQFSw5zyQdmjVPfVG1VHmDaKkWJ8EY_vL9qxzXwpXDPDyMDy-OhQoUA
    YabVi6n3Rkx43G5QKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:22kRZowFLTpjaL3u8-TU7vPcd4A3UWz6hDpT4XeZJ7yWn8bgsFRqmw>
    <xmx:22kRZsOQGgL6Li7qRu9GsbHvSESchvaCPJXqk3ElA_lwVEYUgiWOzA>
    <xmx:22kRZl-ZZo3cNB6G5zFTLZ1QH5RResmXcQlEu2w_VRAdyV2e2SyAKw>
    <xmx:22kRZsVD9agyG3_Sa88JFjG_Upt46Cpu9hjwWPJjoP_ecZgeAzgMMA>
    <xmx:3GkRZgZ91igurCppLipewiLvjADvGbRTQRgRJ6zeWcM2GvjBEFtRkqMF>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CC89EB6008D; Sat,  6 Apr 2024 11:27:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a5bca6fc-1720-45cf-8cf3-3f129e699d79@app.fastmail.com>
In-Reply-To: <ff54515f-3fc1-8f5f-8a15-d4ebbeb2035b@gmail.com>
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com>
 <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
 <d9bdfa48-572a-caa1-229b-44565690d9e6@gmail.com>
 <6b308ab0-dda7-4052-98b3-cb03e17e3e12@app.fastmail.com>
 <ff54515f-3fc1-8f5f-8a15-d4ebbeb2035b@gmail.com>
Date: Sat, 06 Apr 2024 17:27:03 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Michael Schmitz" <schmitzmic@gmail.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 linux-m68k@lists.linux-m68k.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
Content-Type: text/plain

On Sat, Apr 6, 2024, at 03:14, Michael Schmitz wrote:
> Am 06.04.2024 um 09:13 schrieb Arnd Bergmann:
>> On Fri, Apr 5, 2024, at 20:36, Michael Schmitz wrote:
>>> Am 05.04.2024 um 23:16 schrieb Geert Uytterhoeven:
>>> The last time I tried to add support for a different PCMCIA ethernet
>>> adapter to apne.c _without_ adding to the hacks in io_mm.h, I wasn't
>>> getting anywhere with the netdev crowd. That was ages ago, and I doubt
>>> their enthusiasm for a rewrite of the 8390 code base to avoid using
>>> inb() on MMIO architectures will be any better now.
>>
>> From what I can see, there is already an abstraction layer in
>> these drivers that is used by all m68k drivers except apne:
>
> As well as ne ... which uses the 8390p.c helper.

Is there any machine using ne.c that doesn't set HAS_IOPORT though?
Q40 and ATARI_ETHERNEC both have custom inb()/outb(), so
those are not affected by the change.

>> $ git grep -w 'define\sei_inb'
>> drivers/net/ethernet/8390/8390.h:#define ei_inb(_p)     inb(_p)
>> drivers/net/ethernet/8390/8390p.c:#define ei_inb(_p)    inb(_p)
>> drivers/net/ethernet/8390/ax88796.c:#define ei_inb(_a) readb(ax_convert_addr(_a))
>> drivers/net/ethernet/8390/etherh.c:#define ei_inb(_p)    readb((void __iomem *)_p)
>> drivers/net/ethernet/8390/hydra.c:#define ei_inb(port)   in_8(port)
>> drivers/net/ethernet/8390/mac8390.c:#define ei_inb(port)        in_8(port)
>> drivers/net/ethernet/8390/mcf8390.c:#define     ei_inb  ei_inb
>> drivers/net/ethernet/8390/xsurf100.c:#define ei_inb(_a) z_readb(ax_convert_addr(_a))
>> drivers/net/ethernet/8390/zorro8390.c:#define ei_inb(port)              in_8(port)
>>
>> Can't apne.c just do the same here? The patch below didn't
>> take that long to come up with, but I may be missing something
>> here of course.
>
> The address translation from ISA IO ports to MMIO addresses needs to be 
> added as well (in_8() does not use address translation on m68k).

Indeed, I totally missed that bit.

> apne.c also uses inw() which does have a different address translation
> yet, but that's only for data transfer from the ring buffers and can
> be handled entirely inside apne.c.

and this as well.

> Now that is all limited to m68k. I might be able to submit a patch, but 
> I cannot test any of this.
>
> ne.c needs the same treatment as far as I can see, and I could actually 
> test that one (on Atari, not actually on a PC ISA card). I'll see what I 
> can come up with.

ATARI_ROM_ISA turns on HAS_IOPORT, so this one doesn't need any
immediate changes as a result of Niklas's series. I see now that
the apne driver doesn't actually need changes either since
AMIGA_PCMCIA turns on ISA.

I don't think there is an easy way to rework ne.c to avoid
inb()/outb(), but you could consider splitting the atari
support out into a separate module the same way as apne.c
to make it use the atari operations directly.

> I might well be missing something else here - as I said, it's been a few 
> years since I worked on the apne driver, and experimented with IO 
> abstractions in that context. The problem has always been making sure 
> drivers shared by different m68k platforms need only be built once and 
> still work on e.g. Q40 and Atari.

Do you know of any other ISA style drivers that are used with the
amiga pcmcia or the atari rom I/O operations, aside from the 8390
family? If this is the only one using it, it does sound like this
could be simplified a lot by just making those two not share the
object code with the ISA-style ne.c.

      Arnd

