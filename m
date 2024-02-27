Return-Path: <linux-kernel+bounces-83519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E20869AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5FD286C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C2145351;
	Tue, 27 Feb 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Rtc0sWpG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JW9+Yjqu"
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E05145B19;
	Tue, 27 Feb 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048460; cv=none; b=pouVPgXlHqcsVRAGMPtRb9pEsosbK/xgAb7DfNAnP3BhDBoOMX3431Q6zsfd3JNq/+HnIMRjtEIBNsQZbC6+MC+XLmr649dD4B0K/1uskMec0sbSod8PlXBOm2tgAgb3cA3XRy50nZyLa+xBD/jc3n/XiHPR/6p+yrghzJ0FxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048460; c=relaxed/simple;
	bh=+DlqbZvhvHagnqQzGfbqgDo46cq+yV/JshhSuIzwyC4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PgVKeW7yHL9d9wUEYF628QIIXVdCCUhECtNb5zI357o5p1867ClzUoy905fMuqKnBACHYf1bKK1zxPpP2OVvaWC/4of8dLj3Rd5zsLFKMKLCB/ZNVdJg0CTCfW42j8o1oDaF/QUsqNqudwPSzHFhPPyTViTGIhBSbC6wue/3xbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Rtc0sWpG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JW9+Yjqu; arc=none smtp.client-ip=66.111.4.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id C50BC581673;
	Tue, 27 Feb 2024 10:40:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 10:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709048456; x=1709055656; bh=lT/5Xxdnqx
	5CMYADxupUohV9DQkUzUShK5fUq//vk/8=; b=Rtc0sWpGwr1a2ypPut3gLf8atr
	meNXRUSYs2A6Hh4w7+CTYSB6z44OoztdFsDfwmRhAuSRfZs+txW0KNRVDfs+K3n+
	odTYi2ZQlT7s+E0LFaLC7ar/Z4FD+HK9HhZAJiOw+OgQPbgrBWz8VJ+exLNnlzg+
	1LS7GuIOq0sceldQ44JsIMlow7bhpI2GxOgAzs3axuijpISknEFSGq7x6bvtwoC+
	p+hQROmI2qyGkEqbTnYhToPicndBF1DMV0pOJj+WFtfKtWpYwdWnSRNn3VI0XYSw
	rKIYecBNWF5GYiJ7+9wJ1D3mIc0crUYWjJ9ATjE3f1mVy8Wvhr2QzIYBlkWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709048456; x=1709055656; bh=lT/5Xxdnqx5CMYADxupUohV9DQkU
	zUShK5fUq//vk/8=; b=JW9+YjquNnm7o12jdkN5mfx60FJfx8wDhr9OmpbxP3lG
	9cvvv30icSLXu5LQ2wzCYFyfyb71a46fbn1t+Z0Lu9+GBDCOFSjqELt0zbOxC6LZ
	0Oeyvvkzv1yTBIDAKFYI7PqcjoiiSe9lBeKab9Hr2IQZf1E7+rdWITwKMv3VJPUX
	HOIlG6q95Nc7cZjs/HAVbRcvsDMGhIzcU4s1QIiv8t6ivmDQ0zZnnJNBNUH5JMQx
	Rei8lc492TZG3LNU8wmSjCzIoHONeOUx/0Pws8OKhYkcghtRvGS0r7pTxdDkbIu5
	HBIHtV8YNK4lNwxjhk9MOg2xf2TnRvLmW0T6J9Bz5A==
X-ME-Sender: <xms:hgLeZWfF-qbqrdbj0IagYAhSiOEfi5UCEmS_u4yoNDvztXrTURK7_Q>
    <xme:hgLeZQOzCvuUNg6EuvevTGxYCQO8msOkil0RbDijwSzGYe7psl9pT8BWvheUEhZ7C
    Pdo_I4MBhOfPArk7QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hgLeZXhChxgS4QEqTAxLAOZKAoZBKHRRZvGb10gAMk9IE2OsKRsW-w>
    <xmx:hgLeZT-J0pIyrYHvMmgFCCI0MMwJYL79LAConhB9Au0fTd7J2iLO_A>
    <xmx:hgLeZSvOSg8KjmfvYvE-AbxbFQDQ5C9PhmVFAKv9zOm-h-ZQxjKSYA>
    <xmx:iALeZfob0-nwdlhgZy11nclfVztI8phtznS1Je_w6icjY0iJt68yOA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CBF71B6008D; Tue, 27 Feb 2024 10:40:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83450530-c908-4abc-bab7-88c50a3143ff@app.fastmail.com>
In-Reply-To: <764fafb0-2206-4ab1-84ea-ebb7848c8ff2@sifive.com>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-2-arnd@kernel.org>
 <764fafb0-2206-4ab1-84ea-ebb7848c8ff2@sifive.com>
Date: Tue, 27 Feb 2024 16:40:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Samuel Holland" <samuel.holland@sifive.com>,
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
Subject: Re: [PATCH 1/4] arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
Content-Type: text/plain

On Mon, Feb 26, 2024, at 17:55, Samuel Holland wrote:
> On 2024-02-26 10:14 AM, Arnd Bergmann wrote:
>>  
>> +config HAVE_PAGE_SIZE_4KB
>> +	bool
>> +
>> +config HAVE_PAGE_SIZE_8KB
>> +	bool
>> +
>> +config HAVE_PAGE_SIZE_16KB
>> +	bool
>> +
>> +config HAVE_PAGE_SIZE_32KB
>> +	bool
>> +
>> +config HAVE_PAGE_SIZE_64KB
>> +	bool
>> +
>> +config HAVE_PAGE_SIZE_256KB
>> +	bool
>> +
>> +choice
>> +	prompt "MMU page size"
>
> Should this have some generic help text (at least a warning about 
> compatibility)?

Good point. I've added some of this now, based on the mips
text with some generalizations for other architectures:

config PAGE_SIZE_4KB
        bool "4KiB pages" 
        depends on HAVE_PAGE_SIZE_4KB
        help 
          This option select the standard 4KiB Linux page size and the only
          available option on many architectures. Using 4KiB page size will
          minimize memory consumption and is therefore recommended for low
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
          Using 32KiB page size will result in slightly higher performance
          kernel at the price of higher memory consumption compared to
          16KiB pages.  This option is available only on cnMIPS cores.
          Note that you will need a suitable Linux distribution to
          support this.

config PAGE_SIZE_64KB
        bool "64KiB pages"
        depends on HAVE_PAGE_SIZE_64KB
          Using 64KiB page size will result in slightly higher performance
          kernel at the price of much higher memory consumption compared to
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

>> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
>> index a880ee067d2e..aac46ee1a000 100644
>> --- a/arch/hexagon/Kconfig
>> +++ b/arch/hexagon/Kconfig
>> @@ -8,6 +8,11 @@ config HEXAGON
>>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>>  	select ARCH_NO_PREEMPT
>>  	select DMA_GLOBAL_POOL
>> +	select FRAME_POINTER
>
> Looks like a paste error.
>

Fixed, thanks! I think that happened during a rebase.

>>  #ifdef CONFIG_PAGE_SIZE_1MB
>> -#define PAGE_SHIFT 20
>>  #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_1MB
>>  #endif
>
> The corresponding Kconfig option does not exist (and did not exist before this
> patch).

Yes, I noticed that as well. It's clearly harmless.

     Arnd

