Return-Path: <linux-kernel+bounces-130401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D552889782E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F45B30214
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290B15573A;
	Wed,  3 Apr 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybs71K4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424221DFD6;
	Wed,  3 Apr 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167046; cv=none; b=UE24PMMsTN6kWzCDeoiSl2SB4eJE+pgjlOSTQehEUwdY9yNOZAsLLMfhq2bIkL811whDWtdDpfjpq+rSInMb2hiwBUJoQhK8yA8z3qMumbE8oCRjUrxNDjBArBTbWWqvHyu3GPNWMObuvBQZIZBGqsr92/9xcJK2FjH/AnjBv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167046; c=relaxed/simple;
	bh=d+ZUMUm1KAc8rkyq6ddYBLNSuuaZzHkrsJHewdp8CGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YClaAySQJpoP1jcxva1w3EXgG/Lnfr/oIZxo3nC/FfRpbad9fDTsgN1Jyynd210RCh9TlUEhj5NPa7AZbVYf/2WDHMcUHLI/hONw1+pedrd3bnqaz8vlS/dDGfoh6EqwjoL4ceiUdEEvniCbdRhY7Ts5xbxsA3Y8X/3HByZ9Knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ybs71K4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF24C433F1;
	Wed,  3 Apr 2024 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712167045;
	bh=d+ZUMUm1KAc8rkyq6ddYBLNSuuaZzHkrsJHewdp8CGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ybs71K4CaHKCzezTzi0rrbC9vZx7neRUWRqt0aX2rOcjTwvDoefIzHsDVku6laGq7
	 uMP5K+CXvfXbI5o1I/ywjXvdPXxOWxkisQwEODDMRC1ggUb76Nf5ZnlZ5dYrNaNwAr
	 H8rBZRb9iAdZGfr1wTRJ8Kw39dNDmcDLFW2juM1zHafyo4Nx3KuQ3ldxH4piv0Cd8w
	 VU5iHl0yU8wHyQJg2aR4g/w2IKiOwhTK+EDAwgvUt6gjsAPEvZ3YjYVtqp65oAbz9Y
	 Irsm/lDhIrVYlVVk8QBeI65oL0h5mgEYc7s4WrdLVZN1q12s/YPasYkhGEinwr/fCq
	 fwxyPPYmRu75w==
Date: Wed, 3 Apr 2024 10:57:23 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Sparse Mailing-list <linux-sparse@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, llvm@lists.linux.dev
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <20240403175723.GA2667607@dev-arch.thelio-3990X>
References: <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx>
 <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx>
 <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
 <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
 <87bk7ux4e9.ffs@tglx>
 <CAFULd4aEe2KU=UXEt2=GeLQq2uTSFvydBiwAdSa7B6T61Am=5w@mail.gmail.com>
 <878r2ywk3k.ffs@tglx>
 <CAFULd4YG21NdF_qNVBGDtXO6xnaYFeRPvKicB=gpgUUqYE=4jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4YG21NdF_qNVBGDtXO6xnaYFeRPvKicB=gpgUUqYE=4jw@mail.gmail.com>

On Tue, Apr 02, 2024 at 01:43:00PM +0200, Uros Bizjak wrote:
> On Mon, Mar 4, 2024 at 8:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, Mar 04 2024 at 06:42, Uros Bizjak wrote:
> >
> > > On Mon, Mar 4, 2024 at 12:49 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >>
> > >> On Sun, Mar 03 2024 at 21:24, Uros Bizjak wrote:
> > >> > On Sun, Mar 3, 2024 at 9:21 PM Uros Bizjak <ubizjak@gmail.com> wrote:
> > >> >> On Sun, Mar 3, 2024 at 9:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> >> > That's so sad because it would provide us compiler based __percpu
> > >> >> > validation.
> > >> >>
> > >> >> Unfortunately, the c compiler can't strip qualifiers, so typeof() is
> > >> >> of limited use also when const and volatile qualifiers are used.
> > >> >> Perhaps some extension could be introduced to c standard to provide an
> > >> >> unqualified type, e.g. typeof_unqual().
> > >> >
> > >> > Oh, there is one in C23 [1].
> > >>
> > >> Yes. I found it right after ranting.
> > >>
> > >> gcc >= 14 and clang >= 16 have support for it of course only when adding
> > >> -std=c2x to the command line.
> > >>
> > >> Sigh. The name space qualifiers are non standard and then the thing
> > >> which makes them more useful is hidden behind a standard.
> > >
> > > With GCC, you can use __typeof_unqual__ (please note underscores)
> > > without -std=c2x [1]:
> > >
> > > "... Alternate spelling __typeof_unqual__ is available in all C modes
> > > and provides non-atomic unqualified version of what __typeof__
> > > operator returns..."
> > >
> > > Please also see the example in my last post. It can be compiled without -std=...
> >
> > With gcc >= 14. Not so with clang...
> 
> Please note that clang-17.0.6 currently fails to compile kernel with
> named address spaces [1]. So perhaps kernel can use __typeof_unqual__
> (available without -std=c2x) in the hope that clang implements
> __typeof_unqual__ in one of its next releases, following the examples
> of GCC [2] and MSVC[3].

This is now supported in clang 19.0.0 (main):

https://github.com/llvm/llvm-project/commit/cc308f60d41744b5920ec2e2e5b25e1273c8704b

I have inquired about applying this to the 18.x series, such that it
would either make 18.1.3 or 18.1.4, but that is still open for
discussion.

I think the error that I mentioned at [1] is resolved with using
__typeof_unqual__, I tested this diff, which is likely incorrect but
allows me to continue testing without that warning/error due to -Werror:

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 20696df5d567..fc77c99d2e80 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -95,7 +95,7 @@
 
 #endif /* CONFIG_SMP */
 
-#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
+#define __my_cpu_type(var)	__typeof_unqual__(var) __percpu_seg_override
 #define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr)*)(__force uintptr_t)(ptr)
 #define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
 #define __percpu_arg(x)		__percpu_prefix "%" #x

However, I get a crash in LLVM's backend with that diff applied on top
of commit 034dd140a6d8 ("Merge branch into tip/master: 'x86/shstk'"),
which appears to be another tangential issue. I've filed
https://github.com/ClangBuiltLinux/linux/issues/2013 so that we don't
lose track of this.

Cheers,
Nathan

