Return-Path: <linux-kernel+bounces-39979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112783D807
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F702835E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29955604B6;
	Fri, 26 Jan 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b4fW+oHU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB612B92;
	Fri, 26 Jan 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263274; cv=none; b=Yz3BAfFAWMQTGZRkZX4ojv58JLSCTxAYMkaubqH7ZSCMFyFdNtjt/XVhykmW8tmaMQ6Kme+ZfXWhmv5GTMQH8UZhoszHlwZR/wA/eeWi/Xchmu7/XsdGR1bhmWLc9HPCF0/vGr8ziaL+joxzXDlkmDXz0Ni07+gtL3cLQvKbOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263274; c=relaxed/simple;
	bh=eECiJReyNwvw/rXT1QSmi5UWyyWO8uENzGjBer4GzuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/NADbQyihaN4vwaW+EDLHJWeenyqj6RspwX0zFxDtQv6v8fJg1wvt355qqizA5OXonE81abrcYwbmdV8KEY1tpNJGDGX22qslZzt23G7cVgu8oMxNeJyB+xw/9HdI+m+YSXOfhFm/aLSkiQO3miXiMn2lUVf8UkK57bUqEj/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b4fW+oHU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 39B3B40E01BB;
	Fri, 26 Jan 2024 10:01:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eTt1M-NrNSY1; Fri, 26 Jan 2024 10:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706263265; bh=Hj9EgFz52qo2AnW945Th7wBHJu1vxTENf6ob5caQoc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4fW+oHUAd+zOJPLNRrv3SaUoakkduIucAMrU5NKfUCvweQt9A9yZRB/4zioVY/6o
	 MeYg+dD4Eu4uhK+ua1URvNgaJe/p5JjBL25wq4vlysTjlca1meCB9E/9TX0/yxMY2t
	 N5G2Tld+W4QaBVFU9WGlnOIh+T2uQMFud6XfLt1zfIhiOV+Vy4Y2VSvTSdWYi8BHxz
	 pTNhqXo/FqbNgDMb8titja9gvv2ATHyK9+JMVKJQxkabGGM5sUU4O0S9T/FOil21tU
	 557BG/MO4BJV7jSDdhJSed5HKN38eEQGrNlxWC07+tkhO1lovbzUK44jVH7JYLhJYE
	 jIuujPfK+mQSlb+X+WQ+vGbiXX0/ho4drWuFHYqg7P2V2Hg0K+VpiT+ancq3P6qtpq
	 6ErAzZhPBLb/E1DBJvhgKw5FtOkgGlBCC9yqeXOYe64rTZ8A4tJX0W12S714BgMNpG
	 HncIG5snKwRBywYZv/c+eKHY+V93k4n4wVGyWer9WokT5s+tqBXByWEA5gUdeffngA
	 O+M1ov3sRxMnookvuYR0pTZCJ10eZlpe1bGSqcHY2Ee1WNC7FG5fHQ/GqlXPiKhkJh
	 BqNL8Vchi5NDQFL6+LpB946AZflDkLAQZnfRGhrLuIoCKoxE5Uu9ZIESWanCcNGAaV
	 7PXkI1+/fdJHg9Albkyre3Ao=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E897740E01AE;
	Fri, 26 Jan 2024 10:00:56 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:00:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin (Intel)" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Megha Dey <megha.dey@intel.com>, Xin Li <xin3.li@intel.com>,
	Shan Kang <shan.kang@intel.com>, x86@kernel.org
Subject: Re: [tip: x86/fred] x86/fred: FRED entry/exit and dispatch code
Message-ID: <20240126100050.GAZbOC0g3Rlr6otZcT@fat_crate.local>
References: <20231209214214.2932-1-xin3.li@intel.com>
 <170620688145.398.5328359433342649832.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170620688145.398.5328359433342649832.tip-bot2@tip-bot2>

On Thu, Jan 25, 2024 at 06:21:21PM -0000, tip-bot2 for H. Peter Anvin (Intel) wrote:
> +SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
> +	FRED_ENTER
> +	call	fred_entry_from_user
> +	FRED_EXIT
> +	ERETU
> +SYM_CODE_END(asm_fred_entrypoint_user)
> +
> +.fill asm_fred_entrypoint_kernel - ., 1, 0xcc

me compiler no likey:

/tmp/entry_64_fred-de6f10.s:896:7: error: expected assembly-time absolute expression
fill asm_fred_entrypoint_kernel - ., 1, 0xcc
      ^
make[4]: *** [scripts/Makefile.build:361: arch/x86/entry/entry_64_fred.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:481: arch/x86/entry] Error 2
make[3]: *** Waiting for unfinished jobs....

config is x86_64 allmodconfig, compiler is

$ clang --version
Ubuntu clang version 14.0.0-1ubuntu1.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

