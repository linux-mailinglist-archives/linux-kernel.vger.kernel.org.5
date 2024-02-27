Return-Path: <linux-kernel+bounces-83085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F9868E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DFC281E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8891386C3;
	Tue, 27 Feb 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KreeJwgJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBO3jySl"
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCC2A8C1;
	Tue, 27 Feb 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031567; cv=none; b=YqUssA0lhjM4PNKZQgepVXLtBiHFwH8x7Tv+Qw7BORph5Iejwj6hhuiNVffcY6RnlPC4AkQ18ueEeS1mgOafcEHZcBlKOrL2kJUGmFkvi9mIYdlk/mvDMfcc05BwOLFBt3E++4sIsURBObrVMfoQuj/26B/HxnlJ4K0P0RfU1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031567; c=relaxed/simple;
	bh=Z8dw8VXWA+48h8Uwo/1LAJcvTxClQqn0y2pXceSZ2RM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FIJddVbxh5LIxyp1rQUQ6Ho/Nt6BxtK5RyLrXuKmbLl+RbG3sVXZUxVTxPZc9h5ERnqnw4XYdlWolgANkY/HeQOcGnGSD7TzfMZIIHHvE0JWy03hA8yniMudGoUNWszjBZoF3qOp8Aq4PxGryxqp8ToCDRlPCT9eBorb9iZRt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KreeJwgJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bBO3jySl; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 78DBA200138;
	Tue, 27 Feb 2024 05:59:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 05:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709031564; x=1709038764; bh=ALe4jRIpXw
	GFVbo3YEKz32tiMZckplvn+7Agjim/VUs=; b=KreeJwgJS47kfteNF0Atm9VoLT
	mRfGs//TxfpC0fFZ9SEmCaC2swxwVrdN/3Ir+9oF+fbHxOtydzs0GOj0O1ITDp51
	ZhOnnsY7S3TnCZ4KCQAKSLYiFfKjoPsBoAlA8dApodL0QZ6nRCISIYBeFh2ul3w/
	q59zfzcWezxy3DWuubch7g8lA2Drw5Ez0jYc9VWGFhZDa2LlhFdeHC7I+E7yatGM
	hJNcDmI6gI3Zx71w11VLK+zKbOxBUMm1nalGz6w7e9Wc1kc8YztPLUVQ8LkOyg65
	8WPuiETbWNlfqV0KEzh2qfROCbOq47LpMKoQbeNARU2PmuDi7KJ3PGB2mQlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709031564; x=1709038764; bh=ALe4jRIpXwGFVbo3YEKz32tiMZck
	plvn+7Agjim/VUs=; b=bBO3jySluCJ8iVd9SgGyaduu/7B7YWQLFiJ9Ps7xlapC
	2Lu1jhKLr4XQz6dXwNluypZlvD7ktNGmEBmDx+l/7yB8xrGle+W+vyms/K+FVKb6
	vfmssdRCf1wqieikEjJKlb4PL5URebMEeI7syXqZL8FtQxHCsQt7H3xzRq5ndzoQ
	oZYNOTsMDpvjTL6WgQqY2GdPhVBq45+29NWAcjyYpqxh67E2AyyZ323tgVUDvNzD
	j1qYSIwN2bTbtxvpO5Qnw5eDvGuNoreXZ4SGviyGwWwNwe24kyiKu1PnLoTqm6Hx
	IZfTtcsnJMRwsibpxr+rL7unENDS3lSef9Mi0eR4QA==
X-ME-Sender: <xms:isDdZafoyfIa2slvrGRb4QuGqlhK60arMii6iYL9riKPHpp4cGpkDg>
    <xme:isDdZUM16FrnZSoIWKFKjkea6vNGsbbxm1_XQpYP7hU7n55KtwCjU4HyZXe4xvGnR
    al4oJbACmXVdB8-sZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeggddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:isDdZbg33X-NA4Q4g8hs1l1s2knS3VeDh75_ybtft9UbLAD21da0lQ>
    <xmx:isDdZX91w2MZ5hgE7eH834qgzVQv9GUyFiDnpUSBzy5R9xSTy3NkLA>
    <xmx:isDdZWvlIMVHAGfyORa7V5l8neOSYMEy4LWAa7attify04IxVKQb6Q>
    <xmx:jMDdZVrJHSt9kALdLSyweF2DkUkEC1DI1fmVrfUCTkdSqb87F7HE81ozT4I>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9822DB6008D; Tue, 27 Feb 2024 05:59:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <164616c2-94f6-40e8-86e0-850dc8da212e@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-4-arnd@kernel.org>
 <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
Date: Tue, 27 Feb 2024 11:59:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Helge Deller" <deller@gmx.de>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>, x86@kernel.org,
 "Max Filippov" <jcmvbkbc@gmail.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Jan Kiszka" <jan.kiszka@siemens.com>,
 "Kieran Bingham" <kbingham@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
Content-Type: text/plain

On Tue, Feb 27, 2024, at 09:54, Geert Uytterhoeven wrote:
> Hi Arnd,
>> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
>> index 9dcf245c9cbf..c777a129768a 100644
>> --- a/arch/m68k/Kconfig.cpu
>> +++ b/arch/m68k/Kconfig.cpu
>> @@ -30,6 +30,7 @@ config COLDFIRE
>>         select GENERIC_CSUM
>>         select GPIOLIB
>>         select HAVE_LEGACY_CLK
>> +       select HAVE_PAGE_SIZE_8KB if !MMU
>
> .... if you would drop the !MMU-dependency here.
>
>>
>>  endchoice
>>
>> @@ -45,6 +46,7 @@ config M68000
>>         select GENERIC_CSUM
>>         select CPU_NO_EFFICIENT_FFS
>>         select HAVE_ARCH_HASH
>> +       select HAVE_PAGE_SIZE_4KB
>
> Perhaps replace this by
>
>     config M68KCLASSIC
>             bool "Classic M68K CPU family support"
>             select HAVE_ARCH_PFN_VALID
>   +         select HAVE_PAGE_SIZE_4KB if !MMU
>
> so it covers all 680x0 CPUs without MMU?

I was a bit unsure about how to best do this since there
is not really a need for a fixed page size on nommu kernels,
whereas the three MMU configs clearly tie the page size to
the MMU rather than the platform.

There should be no reason for coldfire to have a different
page size from dragonball if neither of them actually uses
hardware pages, so one of them could be changed later.

Let me know if that makes sense to you, or you still
prefer me to change it like you suggested.

      Arnd

