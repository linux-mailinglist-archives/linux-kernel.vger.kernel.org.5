Return-Path: <linux-kernel+bounces-118525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CBE88BC21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD021F3707A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68213340F;
	Tue, 26 Mar 2024 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc8a5xJ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264B21A0D;
	Tue, 26 Mar 2024 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441098; cv=none; b=D7YaqpICqmZCzJCN+y1QJcw2oxI+RSGsUD4T/vXL4NsPTkjxMvgxajVdWbka/wkXiZNjfijzqkyT1OUCpSxZk1db/2p7ziRzgughgFoIcIQDY6EmUqyIfVCl38NFxw5oviOM6ZLrtg10drTOF8fedzYeLnhVp93QxrCBi1q7Lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441098; c=relaxed/simple;
	bh=M/XyZ/Z+QBR65BVhuTqcNZ0wsFkc0/b4T3XmpOmoruo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRXac8ImZtchiBFk4thE9DtZXCGz9nJ+iZ2VjaeYwG9BqGmOL2ZeAWjYPI4BD7s5ROU5co9tCe0he4daCXctpFA914aj7cESYbzymcw3u5mfwLHmH/VOmGRBY8OYnTZxBBUatyzVYY52tPUzNu4UVFQDv5Xb30XHzhx5ASGq0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc8a5xJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3853C43390;
	Tue, 26 Mar 2024 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711441097;
	bh=M/XyZ/Z+QBR65BVhuTqcNZ0wsFkc0/b4T3XmpOmoruo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kc8a5xJ72UrCiowd/D+/6dcTC177LepbBe5CCJ1VxL9LDPvfQ1uiIDRKrd8vVGHNs
	 CWrGENPXYaCH3rutS82h99rVzz5tjagR9ly/EH2o3hGrpdD4j81TEW0lmjnEJBvEQm
	 n8cRshukS5TYFz/OLP3Pvo/u89AHfMKEPSb3Z4U5dc7lxLUJvtgKsfAzy1i2k/3VBj
	 XM5ceIXvquQ217Vu0Gy9ohXxNrvAvfiuXgVcvPPbwQLLAC5ZN95aggYz3m/S4hHKqR
	 YS9H1CkQilaVaw2Z7Bjw/t+7m/HVkwLjJ9XsJov0FFz5KHlNDJ2jakKXKccX+OgxMI
	 ouqx8EWW71opQ==
Date: Tue, 26 Mar 2024 01:18:16 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH 1/6] x86: add kconfig symbols for assembler VAES and
 VPCLMULQDQ support
Message-ID: <20240326081816.GA431948@sol.localdomain>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <20240326080305.402382-2-ebiggers@kernel.org>
 <ZgKC5dcqWSEkwuTX@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgKC5dcqWSEkwuTX@gmail.com>

On Tue, Mar 26, 2024 at 09:10:13AM +0100, Ingo Molnar wrote:
> 
> * Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Add config symbols AS_VAES and AS_VPCLMULQDQ that expose whether the
> > assembler supports the vector AES and carryless multiplication
> > cryptographic extensions.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  arch/x86/Kconfig.assembler | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
> > index 8ad41da301e5..59aedf32c4ea 100644
> > --- a/arch/x86/Kconfig.assembler
> > +++ b/arch/x86/Kconfig.assembler
> > @@ -23,9 +23,19 @@ config AS_TPAUSE
> >  config AS_GFNI
> >  	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
> >  	help
> >  	  Supported by binutils >= 2.30 and LLVM integrated assembler
> >  
> > +config AS_VAES
> > +	def_bool $(as-instr,vaesenc %ymm0$(comma)%ymm1$(comma)%ymm2)
> > +	help
> > +	  Supported by binutils >= 2.30 and LLVM integrated assembler
> 
> Nit: any reason it isn't called AS_VAESENC, like the instruction itself?
> 
> The other new AS_ Kconfig symbols follow the same nomenclature:

The CPU feature flag is called VAES.  It guards the vaesenc, vaesenclast,
vaesdec, and vaesdeclast instructions when used on ymm and zmm registers.

So the name AS_VAES seems fine as-is.

I think you may have been confused by AS_VPCLMULQDQ, because in that case the
feature happens to provides a single instruction with the same name as the CPU
feature flag.

- Eric

