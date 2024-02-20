Return-Path: <linux-kernel+bounces-72583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA91585B58D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA591C22076
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F95CDF6;
	Tue, 20 Feb 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PzJo6xvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PdtZU4U4"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084F5C5FD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418427; cv=none; b=ucWYPGB7GEXWT6I4TFaAtBgXdllXMUgKAVfWwUdELp2UVosnwWrgKEp9LvuGuTp4bMQ22phV17ggI4veCn8Z68Z/EzSv5QqWiIpuP+6ZnJ3aBf3d9g9ie2x/aTEKLi+Xd7FuvUvUIiVzHghX7vFiM0PsrbdkH9EIHmQ9GeYfYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418427; c=relaxed/simple;
	bh=dxaxBS8jmYqcOqkjaYtMNhQG2V4y6G80HQUdF+lJ7vE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gpVyVQQxtT5kUl2Y/RfmrCVSOfl7c5eIHgmw+ZpkW2CkMoP+Z3Gy6CR/YO1d2IBNLqPXPti95qs/CvapiPKoEi2rmJwThv0O0Q9xwXIxraX+DAs3/ogqyKaZ2SXFY3skZn+vBRwvBezL/Mca26YMTJbmplfQvmO88YGTBuBXcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PzJo6xvj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdtZU4U4; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 6B0D01C0007F;
	Tue, 20 Feb 2024 03:40:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 03:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708418422; x=1708504822; bh=y+QzYtuHkA
	3z+CDN1PWEv7PYYZSw4ezn6k5UHcXkjdQ=; b=PzJo6xvjbfWOtKhDhXDwChOM9t
	6VQNEZg4sdP3k9731PtLlgnWPFoRx29R8j5eHsbNW8jBDa7QjeCuX3ivelkKKs1s
	2qbufcHzGFjI8egn1Uu2A6Fq3t0ZGPRcTh6vitpG5W5mWGHra0+GS/okKGFKA8iI
	w52gUur9Lq7QyI/jNW9BfkmnME1nN1kMacaKmdYpJ4sUVIdvYpoSItgBw3pQEFEZ
	ljmR4BWMztd8rP29nzODUnGce4oXhUVKwUhhF/h7VNCSR0QfuB+v/aHNNQAYp0Lb
	hwj30v0qgwu/l2SIrRUXjs1kazDUm7U5WWi1kLYAqeki2lmZ4U4Z1pXMONYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708418422; x=1708504822; bh=y+QzYtuHkA3z+CDN1PWEv7PYYZSw
	4ezn6k5UHcXkjdQ=; b=PdtZU4U4qgd+XhWlA54T8RBaS2qQVUGfInBB4lHESnK7
	MQRuKUJVTCWsU/8AYyklHSHcWOlQ8z7gkRneGkwY/L/dnUo89Uu7GTOFnTa11OhD
	Krr78EiJIIFdBBgrwpAF7HoKyNBLQlDuGul4prA/2X0R5H6pd106O5I6XDzjJoAt
	EQP5lCV5HcTEmfWCi8CWuSPFHmnvZJbZd16KyJQ3zipsyoZFPeYy6YzTjuNvoP8Z
	5ogCTGwO1l2MSOagZB1WcDW6n6LQgt9uqbvrDkklbXBwX74eIj3+KR/vFq/xBbH0
	iEngxUCta0ZnIKsYRUZraUCE92CClbweWILh42la0A==
X-ME-Sender: <xms:dWXUZYSNmo0XtgiheZJ_eSwvPmFvMqCtkwBty_VOs_SsIKBBxVVXCQ>
    <xme:dWXUZVz1mFttTfy8Djkas9wY2NQzM1b9hTsqPdxgSrmG0mbP9bJnE_jhJX3bWpqRH
    tGaFN7mYRp06oh-Y2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepiedukeegleegvdeugeevfeeuteehlefgkedvveegvedthfefteegueehhfej
    ledvnecuffhomhgrihhnpehlughsrdhssgdpvghfihhsthhusgdruggrthgrnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvg
X-ME-Proxy: <xmx:dWXUZV14wVxYtlYYg4ZXNbPtC-_tCkAGgiRaXkJAYAitOy54NFKw-g>
    <xmx:dWXUZcA5IzHUFHEKth-OXNtm0q6tXouLHWxstpSMMK5XhO4CIPO0ng>
    <xmx:dWXUZRjbJYvA9FzFzoCesF5QGYUAKAsrq_mfRZ3tbulVruUtCeyEgA>
    <xmx:dmXUZURFH4TLu1xsuws88DZaW8yf3BjT3dygkC3asxnOaCptOisDkyVG_Go>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 78C0CB6008D; Tue, 20 Feb 2024 03:40:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
In-Reply-To: <20240220081527.23408-1-liuyuntao12@huawei.com>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
Date: Tue, 20 Feb 2024 09:40:01 +0100
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
Content-Type: text/plain

On Tue, Feb 20, 2024, at 09:15, Yuntao Liu wrote:
> The current arm32 architecture does not yet support the
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
> embedded scenarios, and enabling this feature would be beneficial for
> reducing the size of the kernel image.
>
> In order to make this work, we keep the necessary tables by annotating
> them with KEEP, also it requires further changes to linker script to KEEP
> some tables and wildcard compiler generated sections into the right place.

Thanks for the patch, I think this is a very useful feature
and we should get this upstream, especially if we can combine
it with CONFIG_LTO_CLANG (which is supported on arm64 at the
moment, but not on arm).

> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
>
> The size comparison of zImage is as follows:
> defconfig       vexpress_defconfig      tinyconfig
> 5137712         5138024                 424192          no dce
> 5032560         4997824                 298384          dce
> 2.0%            2.7%                    29.7%           shrink
>
> When using smaller config file, there is a significant reduction in the
> size of the zImage.
>
> We also tested this patch on a commercially available single-board
> computer, and the comparison is as follows:
> a15eb_config
> 2161384         no dce
> 2092240         dce
> 3.2%            shrink
>
> The zImage size has been reduced by approximately 3.2%, which is 70KB on
> 2.1M.

Nice description! I do suspect that there will be additional
bugs that we run into with some corner cases.

> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S 
> b/arch/arm/boot/compressed/vmlinux.lds.S
> index 3fcb3e62dc56..da21244aa892 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -89,7 +89,7 @@ SECTIONS
>       * The EFI stub always executes from RAM, and runs strictly before 
> the
>       * decompressor, so we can make an exception for its r/w data, and 
> keep it
>       */
> -    *(.data.efistub .bss.efistub)
> +    *(.data.* .bss.*)
>      __pecoff_data_end = .;
> 
>      /*

This doesn't seem right to me, or maybe I misunderstand what
the original version does. Have you tested with both
CONFIG_EFI_STUB on and off, and booting with and without
UEFI?

If I read this right, you would move all .data and .bss
into the stub here, not just the parts we actually want?

> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index bd9127c4b451..de373c6c2ae8 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -74,7 +74,7 @@ SECTIONS
>  	. = ALIGN(4);
>  	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>  		__start___ex_table = .;
> -		ARM_MMU_KEEP(*(__ex_table))
> +		ARM_MMU_KEEP(KEEP(*(__ex_table)))
>  		__stop___ex_table = .;
>  	}
> 
> @@ -116,7 +116,7 @@ SECTIONS
>  #endif
>  	.init.pv_table : {
>  		__pv_table_begin = .;
> -		*(.pv_table)
> +		KEEP(*(.pv_table))
>  		__pv_table_end = .;
>  	}

I guess this prevents discarding any function that has a reference
from pv_table or ex_table, even if there are no other references,
right?

I don't know how to solve this other than forcing all the
uaccess and virt_to_phys functions to be out of line
helpers. For uaccess, there are probably very few functions
that need this, so it should make little difference.

You might want to try changing CONFIG_ARM_PATCH_PHYS_VIRT
into a method that just always adds an offset from C code
instead of the boot time patching. That way the code would
be a bit less efficient but you might be able to get
a larger size reduction by dropping additional unused code.

Maybe test your patch both with and without
ARM_PATCH_PHYS_VIRT to see what the best-case impact would
be.

      Arnd

