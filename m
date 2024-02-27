Return-Path: <linux-kernel+bounces-83540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7170869B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784B01F2390B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4531468F4;
	Tue, 27 Feb 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Uj8nTtuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hY1txy5S"
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34771482E3;
	Tue, 27 Feb 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048933; cv=none; b=ZBg4CWtSrc8LmWfWL8jKQzXFNh/Dw9OcRqvuW6VD/4BqJGzckUxQbw2IVyTGU8GEM3J5IACSdAKKIltD4i2Hahu8uDffPKib9D7eSBaE2uBUsLoUAkYSsgwl39M0AaX4cTWvxnD4sYSe/Iwc1LzQQvGxzGvURlMaUrdiq7WLCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048933; c=relaxed/simple;
	bh=2jqupzrqvGkM46I6Bvk5B+arL4luMkNH22lQhJoirTk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=B1LamLEP3lgcYXgwJTylSDWCOlmt8mcjzNEjswsfFjE+h0l1LuR//3hKCGEvbRL6ESl46U5j4qwyBXvp+6+HYD3ZHf3SoLtI5BIobLNevdjNYfPADKIvM7mp1cjXJQTm2NtUISQbqS7D7s/OmNqkDcb55umtmqAhqk+WeceT5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Uj8nTtuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hY1txy5S; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 0E22F200094;
	Tue, 27 Feb 2024 10:48:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 10:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709048931;
	 x=1709056131; bh=ybbnN0+SobfyxbHHH4ZELWrRQvYBzt/PThTgohkZVK8=; b=
	Uj8nTtuXWeEi/jXfJb5n+JbsF1HSR0x3KgfCm6wqbBwTdbvkhRqJ3Yq98CMAeG5r
	D/GO+gsxXcyWzUSYVXbRGbhBL/Z62QpHxQL4Nwm51CeelVfQrM0VsRmYU5oQiksk
	K0/XMoHjN3ofZ1Z5lt03aTV2rHIKloqb+z/hoNnTFtklsNNfr3RZjbgENs0es2gb
	IDGbBSGW0xc7Je2i9GyV0TikqeTQ8ZIH5rJ4x5Zc8k491PIy0z0afqdlN46J0Dyh
	GwV1UL/IypRhnck5jK4xrsxLBGUV4OhZP+DMMw5EqYb3GTEee00bKrSNOVOQW2Of
	C/8GqY9nA4ZbWGv/r1HmIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709048931; x=
	1709056131; bh=ybbnN0+SobfyxbHHH4ZELWrRQvYBzt/PThTgohkZVK8=; b=h
	Y1txy5S4iu4CgzO1d33RQRTVdIFEUhjhCu5bud7oeKr3YK+aS49Q7U3ClfbHqdDi
	1Qn/NXLKPd6IvD9u+mdo6jUi/KerXGwKqXU19Z54fEINfjHSApkWghFTcS4W/D9z
	bsuvJAFYYdOULYWSgsXdENf8NuVwaZV5nSsSdhul8qQvwBokhTpI/C4zH6thcdJh
	bnr/GHXwlUup2+3kPL1y1HI4RcBsijL0XYOj/FHZT6izdSVL9jmjE+Sv7hDo4FzA
	ReVIikHX+Zzdb6tpZ5dMHS/HBnj9HUKp1GKOSPqZGRRmEAJNIjOaV9BN4ViQqd2y
	/UEth2/MdcbGXPG2wRf0g==
X-ME-Sender: <xms:YgTeZTjQ2h_cNZ8jalaG9yLuQqXC07isf9GGcrOmBfNOKOEulyuU8A>
    <xme:YgTeZQAU0_LLiTKPpNYMDEOZ3KF4sj8-pyoo1S0mcZ4WuXW9vxRtrWSOshLIwEkGN
    rSu-Vae63C6tVsVR-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YgTeZTHcN2-Yez8UX5mfvZ1mSJnr_0tSCCXpqVxUG-IHqIPIoNvmcg>
    <xmx:YgTeZQQzrErr268F2CxBpd9lwv9mwfSPdqVRsNCxYMDirZwuyZpTug>
    <xmx:YgTeZQwVGz3Yu09b5df-6afMzKl0E5RnQicJLgSLEI6srfnAno_efg>
    <xmx:YwTeZaeeqww0pq-Uj1Spmu0Q0w5FIsyXzvjrxIQzMA-5KGL3vLMjzLwEdE0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 407DCB6008F; Tue, 27 Feb 2024 10:48:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b857914-bc1d-4b9a-b3f1-4eabd8db9810@app.fastmail.com>
In-Reply-To: <b737a088-c811-45eb-b143-d24e6cdf7eea@csgroup.eu>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-2-arnd@kernel.org>
 <764fafb0-2206-4ab1-84ea-ebb7848c8ff2@sifive.com>
 <83450530-c908-4abc-bab7-88c50a3143ff@app.fastmail.com>
 <b737a088-c811-45eb-b143-d24e6cdf7eea@csgroup.eu>
Date: Tue, 27 Feb 2024 16:48:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Max Filippov" <jcmvbkbc@gmail.com>, guoren <guoren@kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "Jan Kiszka" <jan.kiszka@siemens.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Helge Deller" <deller@gmx.de>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Vineet Gupta" <vgupta@kernel.org>, "Matt Turner" <mattst88@gmail.com>,
 "linux-snps-arc@lists.infradead.org"
 <linux-snps-arc@lists.infradead.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "Kieran Bingham" <kbingham@kernel.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "Brian Cain" <bcain@quicinc.com>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/4] arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024, at 16:44, Christophe Leroy wrote:
> Le 27/02/2024 =C3=A0 16:40, Arnd Bergmann a =C3=A9crit=C2=A0:
>> On Mon, Feb 26, 2024, at 17:55, Samuel Holland wrote:
>
>
> For 256K pages, powerpc has the following help. I think you should hav=
e=20
> it too:
>
> 	  The kernel will only be able to run applications that have been
> 	  compiled with '-zmax-page-size' set to 256K (the default is 64K) us=
ing
> 	  binutils later than 2.17.50.0.3, or by patching the ELF_MAXPAGESIZE
> 	  definition from 0x10000 to 0x40000 in older versions.

I don't think we need to mention pre-2.18 binutils any more, but the
rest seems useful, changed the text now to

config PAGE_SIZE_256KB
        bool "256KiB pages"
        depends on HAVE_PAGE_SIZE_256KB
        help
          256KiB pages have little practical value due to their extreme
          memory usage.  The kernel will only be able to run applications
          that have been compiled with '-zmax-page-size' set to 256KiB
          (the default is 64KiB or 4KiB on most architectures).

      Arnd

