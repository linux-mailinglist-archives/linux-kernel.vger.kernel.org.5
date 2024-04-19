Return-Path: <linux-kernel+bounces-151029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E638AA823
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2AF282BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C0C2D6;
	Fri, 19 Apr 2024 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EQY9hGj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0Gglyzl"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D0B66C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506345; cv=none; b=GTqt3D7wtE2AmiVXPgMUR+scl7hqaiRCtUpsbSOY806rYWl3S3AMhZywuYNvYwaAZ07J/Vb9GyrIYnPT8Z4LkuUIYxteIV6DxlumaJQ2B0ofHsRSjUmPT48fHTsJaz7z7pZSMghZYZeXuK0Ppd/OtoR8iwqZXv08ZmS1F7VXSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506345; c=relaxed/simple;
	bh=HbMut8+4I5sKFilkUUeQWBZu6z3cx93G8usHc8s11uQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dw/2f6V8avN7JYkVr7ftfSrpyu4ZHxNocN8UrvhLFPLucg7E/aO0vcxVc1rqAgaZ3vxveC//9BKl77lajlqpiYUUBilBUYzLqQcNW89O4nbriV9GwuJvqx6BJ00Z7yGXap4Nou0Vq0GlEMGhHzFDXkGGRegMzd3E8IyitDAPU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EQY9hGj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0Gglyzl; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8DAF71800114;
	Fri, 19 Apr 2024 01:59:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 19 Apr 2024 01:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713506341; x=1713592741; bh=twE9hPw421
	uwlIXvbIk9nVD0d1HoYErN3gfFf2Hfffc=; b=EQY9hGj5l9JyxvZ70GZq9nQETO
	uwLsZOlrUQaSWAgkGZZjvcZQvSZh/nWjlSgZrTS+4Pzzm3SAAAHnUVfmumM6od1K
	sznDivemgKi9uE0Cm/vIFeLQ4KnrRL4u5+4L150cymlcEaRZNOV84grgnPUZT7iW
	QZkwYkVFxtIGBOwuxmeY74eXYVw3Q7dFVawIiZPt4d6Qsc+Tuhk21Th4+x0+ZzHf
	pJykxSI6UZapcVXAjr91z6HEzxnmCtsSIkYSfB61i0GkVJqBzmdQdhOAjc1oplBK
	knLgz9DVU64kLaHoxou1ifG0OUnM9nGFSLASnIETcYxFwablKFBGOMnfd12Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713506341; x=1713592741; bh=twE9hPw421uwlIXvbIk9nVD0d1Ho
	YErN3gfFf2Hfffc=; b=g0GglyzliV8fxL5FMqE/lxwcCXfB21Am5LxcxSeDKHcI
	V6dL8b1j5zQMlsk0YMvc/M6/sWBOOSLNn/0+FW+FPfw0UKRnULFo9TafBOzvIVAx
	tDtF444Xy/QqeDYalPO8qfMj7UYfujmasmbYEyiFVvrDqY8pZ7FlSuJndjQxyh18
	vmwBc/RZlQXNLmZXfLh64HbcxUQQfZSRU7kSj2VXs9uD8HsmFdZ905gOS9yfbkGE
	bIHpFu8LrjIjY/3SYnMosa0oyCS9lx9aEZOXJ39Ny8bNmfZFzfI2kt/mNWTBDB0N
	IDjZZGOtLRyaOQI+U3YEuAuiN5kRvJAfQ0Jj6R8kVw==
X-ME-Sender: <xms:JAgiZjlXf1yM4t9lvpcaOYV_UTSFGa8ciAuGs_AsOFlc1a3gJKagAQ>
    <xme:JAgiZm11F-n_hyUfpz4jctClD7y2gV09oSUsEUrEZHdzZJgQJqtGQp0_Bppzn61nM
    q8rCYwBcbaSkBnoF-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:JAgiZppFWRClZCi9ea3JoXNhZQH6tQUZTzHp18I57y8XfOBQ09bdQw>
    <xmx:JAgiZrlqZiWcBQ-12n62wIHQuvwibd6B0DLyNFY6yyNIm3wPMmkL4w>
    <xmx:JAgiZh1rTf0mrzpX3fy6IuHn4xunCG4VhMiMcZ7uTY3IOQ4L-5jPAQ>
    <xmx:JAgiZqtF1c1p3s5Q2jVvjUo6PIUlJnu8-Dh1MOLuKR-70Iol4SHd_g>
    <xmx:JQgiZu7EeMkqBiw5VB01T2WGOWG8PZOFGM6vDG9uDkZViGr7Ro5bq0mM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C2904B6008D; Fri, 19 Apr 2024 01:59:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <16334340-d409-4be4-a89d-981baa7a4b82@app.fastmail.com>
In-Reply-To: <87wmou9bqd.fsf@mail.lhotse>
References: <20240416153331.1617772-1-arnd@kernel.org>
 <878r1bb2zj.fsf@mail.lhotse>
 <59473eb6-1707-4bbf-85a3-ba4835f3ee7f@app.fastmail.com>
 <8734ribza2.fsf@mail.lhotse> <87wmou9bqd.fsf@mail.lhotse>
Date: Fri, 19 Apr 2024 07:58:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Nathan Chancellor" <nathan@kernel.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Kees Cook" <keescook@chromium.org>, "Baoquan He" <bhe@redhat.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 clang-built-linux <llvm@lists.linux.dev>,
 "Nick Desaulniers" <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 "Jeff Xu" <jeffxu@chromium.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Justin Stitt" <justinstitt@google.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Bill Wendling" <morbo@google.com>
Subject: Re: [PATCH] powerpc: drop port I/O helpers for CONFIG_HAS_IOPORT=n
Content-Type: text/plain

On Fri, Apr 19, 2024, at 07:12, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> "Arnd Bergmann" <arnd@arndb.de> writes:
>>>
>>> I had included this at first, but then I still ran into
>>> the same warnings because it ends up pulling in the
>>> generic outsb() etc from include/asm-generic/io.h
>>> that relies on setting a non-NULL PCI_IOBASE.
>>
>> Yes you're right. The above fixes the gcc build, but not clang.
>>
>> So I think I'll just cherry pick f0a816fb12da ("/dev/port: don't compile
>> file operations without CONFIG_DEVPORT") into my next and then apply
>> this. But will see if there's any other build failures over night.
>
> That didn't work. Still lots of drivers in my tree (based on rc2) which
> use inb/outb etc, and barf on the empty #define inb.

Right, the patches from Niklas only went into linux-next so far,
and a few are missing (including the 8250 one I think), so -rc2
at the moment regresses, but that doesn't have the warning either.

The idea of my patch was to both fix the current linux-next
build regression and have something that works in the long
run, I didn't expect it to work by itself. Sorry that wasn't
clear from my description.

> So I think this patch needs to wait until all the CONFIG_HAS_IOPORT
> checks have been merged for various drivers.
>
> For now the below fixes the clang warning. AFAICS it's safe because any
> code using inb() etc. with CONFIG_PCI=n is currently just doing a plain
> load from virtual address ~zero which should fault anyway.

If the port number is high enough, the current code might end
up referencing a user space address, depending on mmap_min_addr,
which defaults to 4096.

Using POISON_POINTER_DELTA is clearly an improvement over that.

> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index 08c550ed49be..1cd6eb6c8101 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -37,7 +37,7 @@ extern struct pci_dev *isa_bridge_pcidev;
>   * define properly based on the platform
>   */
>  #ifndef CONFIG_PCI
> -#define _IO_BASE       0
> +#define _IO_BASE       POISON_POINTER_DELTA
>  #define _ISA_MEM_BASE  0
>  #define PCI_DRAM_OFFSET 0
>  #elif defined(CONFIG_PPC32)

You may need to double-check, but I think for ppc64 we
can just unconditionally set _IO_BASE to ISA_IO_BASE
regardless of CONFIG_PCI. 3d5134ee8341 ("[POWERPC]
Rewrite IO allocation & mapping on powerpc64") ensured
that the I/O space is only ever mapped to this virtual
address, and the same method is used with the
asm-generic/io.h implementation on arm/arm64/loongarch/
m68k/riscv/xtensa. Using this would be both safer and
more efficient than the current version.
It should also not cause any regressions ;-)

Unfortunately, ppc32 never got that cleanup, so
POISON_POINTER_DELTA is probably still best until Niklas's
series is merged. You could set _ISA_MEM_BASE to the same 
here for good measure.

[another side note: the non-zero PCI_DRAM_OFFSET looks
unnecessary as well now, apparently this was meant for
ibm cpc710 and ppc440 platforms that are no longer
supported.]

     Arnd

