Return-Path: <linux-kernel+bounces-83523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64210869AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826431C249BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049121482EE;
	Tue, 27 Feb 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rDZztf+E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sy6F6rzy"
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE4145FEF;
	Tue, 27 Feb 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048586; cv=none; b=p/tQtbfqSd4uoZYftAHEwoCKffnrJhPtetSezIiITLJa+Cp67YsfuOZm5iit+75x2qA4yFwpgkj/PQCEeUr0Xj4+adHTonxXPT6SyZMnUXFXWOtHuo8vsr64iZDjH6LehO08IvC0WDn8NCg86TS0+W43ADit8We8JUariuGhK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048586; c=relaxed/simple;
	bh=uuo2wH2LS7D4jDwdhBqpJEDvc7Dp5jbrG+PQmJJASog=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FfZryfWi++Oq6Y7YvKJFZzAmUNxDPJAAiJVltR2kmG2hI9+1l9gwbezSZloZLOnDwWAMsPUzyKssnJyVF2lK+wf1akX/eSsvgX716X8Pea5myW92oPvY3uwJZqkLJJhpqpTFI5IkGYSsleiVVzedMliIEZgSdicTJ75yR3ZscT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rDZztf+E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sy6F6rzy; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id F2D5720008F;
	Tue, 27 Feb 2024 10:43:03 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 10:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709048583;
	 x=1709055783; bh=rCK/UfqbDu4ldnegzmSK0UKvclJAYdVrTkCZN4NB1xI=; b=
	rDZztf+EZEmbYIIZ7K/BZsGWztOvaw0wL+R1NkEaGPDWSws5dUN+RIpfm1kT9ymI
	ows+zMsmMVnXCAO8Pzidm6a++lXC/Ten//T66Ew2JODUoNckYQNa9HTdBG8kKzyf
	Suej1YRfWtmbrV1ZODw4orTErVizwvwJmRcOC7CWmQVrBkqwrKRbDsUHJZYoDIze
	XKPwfs+Fh03PV0sivL4vKav0n4NzCW4fuNNRtiZf6cUtds9qey1Xef4aEXJwkba8
	xLl6wEAa488pjmfGf8D1AN6iPSngdkkfhqwWz2TCBv+rzUkVoby7hEYUXTLfmyS8
	SsjkHFi66V+ZqoeoMFeVyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709048583; x=
	1709055783; bh=rCK/UfqbDu4ldnegzmSK0UKvclJAYdVrTkCZN4NB1xI=; b=S
	y6F6rzybn9EGdSOYXZNXjq9Jc08BcyWDVLk5vtfltqR/0N3QejLBvtuH1nM61fB/
	IpxgH5KgpJ/goepKpnHxdwuGRVsuDrcCX1H4gPQWgRJoNbFmpcyfCmoyZeAIT+Px
	e2jmbnjPrwHxEK7UsLFt/0pzARlBBj2xO1hKShLE3owgixW9wRybOa7Jmi+zD7/5
	wrgeY6P3WATH6wneKFBpQ59A1ZEeGzGbkNFXebbVdc5nkEAO/2kPx47NpcIHD1sz
	r1UEtZnsz/CRAFLkaE9NR5PTmwRoxMZTi7HCro+oB8aZqqOydQ+HgAQtqRiN5Wr+
	+g2GTOK/SO4LXnM3FOlvw==
X-ME-Sender: <xms:BwPeZS47SiblYbq7KodBAl_Vc4Q9Y5qZlFxO6xcw7TfMbjq8SYvnPg>
    <xme:BwPeZb6iJLmH3mKw8HMCI9wL5vjkcISz55DV2rBlEfop_Dhd351GNWpdWcaduCc_F
    4h6LT4oizGD01noD2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:BwPeZRdXWIE5kOTCERrtcwBtgdmrzQx7Zxk1nJMXDnP15whFzvolnw>
    <xmx:BwPeZfIq8_C9BA8eTIRSxwKMtaC4-DCaunMnbd1Z7sOfTzTyzfNmJA>
    <xmx:BwPeZWJ5er8j5CGFNjxyS-0pKZukwg0k31oFVMfRzmxPIG9heixJsw>
    <xmx:BwPeZcVl_5_jsCSftcKQxQLVmz2VxDWr5GmFcuI1KfH_6G4hprdKi3j4jWg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 897ACB6008D; Tue, 27 Feb 2024 10:43:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e49232e2-9fa9-4f83-9471-a3852b83c113@app.fastmail.com>
In-Reply-To: <9aae81d0-dfaf-423c-8ceb-72829a98420d@csgroup.eu>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-2-arnd@kernel.org>
 <9aae81d0-dfaf-423c-8ceb-72829a98420d@csgroup.eu>
Date: Tue, 27 Feb 2024 16:42:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Arnd Bergmann" <arnd@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>
Cc: "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Helge Deller" <deller@gmx.de>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>, "x86@kernel.org" <x86@kernel.org>,
 "Max Filippov" <jcmvbkbc@gmail.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Jan Kiszka" <jan.kiszka@siemens.com>,
 "Kieran Bingham" <kbingham@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux-snps-arc@lists.infradead.org"
 <linux-snps-arc@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Subject: Re: [PATCH 1/4] arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024, at 20:02, Christophe Leroy wrote:
> Le 26/02/2024 =C3=A0 17:14, Arnd Bergmann a =C3=A9crit=C2=A0:
>> From: Arnd Bergmann <arnd@arndb.de>
>
> That's a nice re-factor.
>
> The only drawback I see is that we are loosing several interesting=20
> arch-specific comments/help text. Don't know if there could be an easy=20
> way to keep them.

This is what I have now, trying to write it as generic as
possible while still giving useful advice:

config PAGE_SIZE_4KB
        bool "4KiB pages"
        depends on HAVE_PAGE_SIZE_4KB
        help
          This option select the standard 4KiB Linux page size and the o=
nly
          available option on many architectures. Using 4KiB page size w=
ill
          minimize memory consumption and is therefore recommended for l=
ow
          memory systems.
          Some software that is written for x86 systems makes incorrect
          assumptions about the page size and only runs on 4KiB pages.

config PAGE_SIZE_8KB
        bool "8KiB pages"
        depends on HAVE_PAGE_SIZE_8KB
        help
          This option is the only supported page size on a few older
          processors, and can be slightly faster than 4KiB pages.

config PAGE_SIZE_16KB
        bool "16KiB pages"
        depends on HAVE_PAGE_SIZE_16KB
        help
          This option is usually a good compromise between memory
          consumption and performance for typical desktop and server
          workloads, often saving a level of page table lookups compared
          to 4KB pages as well as reducing TLB pressure and overhead of
          per-page operations in the kernel at the expense of a larger
          page cache.

config PAGE_SIZE_32KB
        bool "32KiB pages"
        depends on HAVE_PAGE_SIZE_32KB
          Using 32KiB page size will result in slightly higher performan=
ce
          kernel at the price of higher memory consumption compared to
          16KiB pages.  This option is available only on cnMIPS cores.
          Note that you will need a suitable Linux distribution to
          support this.

config PAGE_SIZE_64KB
        bool "64KiB pages"
        depends on HAVE_PAGE_SIZE_64KB
          Using 64KiB page size will result in slightly higher performan=
ce
          kernel at the price of much higher memory consumption compared=
 to
          4KiB or 16KiB pages.
          This is not suitable for general-purpose workloads but the
          better performance may be worth the cost for certain types of
          supercomputing or database applications that work mostly with
          large in-memory data rather than small files.

config PAGE_SIZE_256KB
        bool "256KiB pages"
        depends on HAVE_PAGE_SIZE_256KB
        help
          256KB pages have little practical value due to their extreme
          memory usage.

Let me know if you think some of this should be adapted further.

>>  =20
>> +#define PAGE_SHIFT CONFIG_PAGE_SHIFT
>>   #define PAGE_SIZE  (1UL << PAGE_SHIFT)
>>   #define PAGE_MASK  (~((1 << PAGE_SHIFT) - 1))
>>  =20
>
> Could we move PAGE_SIZE and PAGE_MASK in a generic/core header instead=20
> of having it duplicated for each arch ?

Yes, but I'm leaving this for a follow-up series, since I had
to stop somewhere and there is always room for cleanup up headers
further ;-)

      Arnd

