Return-Path: <linux-kernel+bounces-119434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2EE88C8C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62682E8088
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11E13C9B6;
	Tue, 26 Mar 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1WL0R3I"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03131A8F;
	Tue, 26 Mar 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469720; cv=none; b=dXfqgRMQpVaycWqcCx9sBZOEpbeMn7AagevBOSFfrM6gNXwscjp8NPyJFDqaAbbMYC4xPotr81CB+U0Y1lNOuC6cVfkWXtAD7B1em1qe+RTVZWbFr4cZVYBZSQUBUALZBRYONBjRJksYDi9hhogC6riv9Rmd8wI3RfZtk/YPBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469720; c=relaxed/simple;
	bh=fAX6/aKekDwYTkK3cCceiafJa452aYapgiyokZFWAlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR+y6zRlQWM4ISzeZM8spFK3XMj/bbpQykqwRv4BSj3a1wc7Lpher9BICyjoenm03KAtP5gjZbFOYTZ+DoLXBTQtzmwtdgBY2BJmAENJ3rUf+Vd4dv6RHMmeBOStybZx0dhMNymN80DTyMUpzcUUcIxezKBShRyXq7W4jxvqfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1WL0R3I; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so3596554a12.0;
        Tue, 26 Mar 2024 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711469718; x=1712074518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwEvwMyXDex0JX3rRhVE/vA0sINsepXr/+05Cuki61c=;
        b=B1WL0R3IXg6BsE8863lJAkB9nz2+4cQ+I28MKRdXWXmBvQGfjrOr6wQ6AeHMCnZrIn
         mJFno4wnegxiaTPGMSfFPIF3bAjkD7lZ44E4f/U325R5kiyskfsXfs1mSOulPJSDwZCg
         yQWjyCx0tiK2vDAbZDoPDelZOUgsdATOt3iFMNZoQUoGtsDALiYCM8dcmnOy52VWdkOr
         6+YEQoPZ1JaT4nhrTJWauolUSWcNxBy/TEUy4lOaz3+n9uO8QgpHSpodPkHoxZiFxclt
         sT2o7Ckj5kmnyovKJ2NCXyba0el9X8WTT79dqTw9nFvsbzF1nhzIgj90iAzz4bODPQs7
         Kd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469718; x=1712074518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwEvwMyXDex0JX3rRhVE/vA0sINsepXr/+05Cuki61c=;
        b=FVh6AWQBptQeDUmGFsCpj9EhuMPx7t+eGAASl2IBiPF7uAyAeU9Gh+u6on4OdA9DVz
         7Xmb5SML5A/zmVYXNoDnp4ZmhiWdsN/4gvOl57mKpNMmp4lFa8g8wVrJwX/N2Nq+DeHS
         SkD643QoXtqWVRgTwa85o6DCk34gPzAsBwG7vCUdJHdpKvzuoOuUOg3EskqNyHwjPFqN
         bi1LAv4KSug9rvh4GPMmloMrwMzyOMgj0cZ/OmFexXXE4UdkY2BRpLy65MDzroVGXiPj
         IJn9I7sb4LA/IMt4+HFDKIY4ZVwwvaSh3wbs3aw6bNvLvrtKLWw4s4kYLHl08gIMdaTG
         qbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRPOuJB6DVip+TenTZU5z4sLeXn8RZrMzAT6K0fPV3FBLk1k+vxfA1cE0iwRfuOrcrUOtejGT1jcI9pEOnQ7CSN/KWpeoj+X/oWt4E5G7LBmJSSb56SxG5FS41R5wua7B2KBbTbsldWYSRq3KqirsP
X-Gm-Message-State: AOJu0YzX1PIOmhnW7SRcQq/FjUkW6nDljrqsuBqfA8K5U2yRW1tK/WBn
	yTM2sgiiMAd/nChrnswhFG+ZvBDg2Gs6HQ+Htb9uEQsKfa0HQ/NI
X-Google-Smtp-Source: AGHT+IEkibn+nUd92RiN0uy5s0uPI4JYPnqu175YVKXXwbIe74xTGn2WxRgDtfptUVEKhMO9c0jF7w==
X-Received: by 2002:a05:6a20:ce4b:b0:1a3:bdd2:a9a0 with SMTP id id11-20020a056a20ce4b00b001a3bdd2a9a0mr2678228pzb.20.1711469718235;
        Tue, 26 Mar 2024 09:15:18 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([192.184.165.229])
        by smtp.gmail.com with ESMTPSA id y14-20020a056a00180e00b006e68b422850sm6120298pfa.81.2024.03.26.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:15:17 -0700 (PDT)
Date: Tue, 26 Mar 2024 09:15:14 -0700
From: Calvin Owens <jcalvinowens@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Message-ID: <ZgL0ks5gikCG7NBN@debian-BULLSEYE-live-builder-AMD64>
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
 <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
 <20240327002403.62649aee45508b7a16caedba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240327002403.62649aee45508b7a16caedba@kernel.org>

On Wednesday 03/27 at 00:24 +0900, Masami Hiramatsu wrote:
> On Tue, 26 Mar 2024 14:46:10 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Hi Masami,
> > 
> > On Mon, Mar 25, 2024 at 11:56:32AM +0900, Masami Hiramatsu wrote:
> > > Hi Jarkko,
> > > 
> > > On Sun, 24 Mar 2024 01:29:08 +0200
> > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > 
> > > > Tracing with kprobes while running a monolithic kernel is currently
> > > > impossible due the kernel module allocator dependency.
> > > > 
> > > > Address the issue by allowing architectures to implement module_alloc()
> > > > and module_memfree() independent of the module subsystem. An arch tree
> > > > can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.
> > > > 
> > > > Realize the feature on RISC-V by separating allocator to module_alloc.c
> > > > and implementing module_memfree().
> > > 
> > > Even though, this involves changes in arch-independent part. So it should
> > > be solved by generic way. Did you checked Calvin's thread?
> > > 
> > > https://lore.kernel.org/all/cover.1709676663.git.jcalvinowens@gmail.com/
> > > 
> > > I think, we'd better to introduce `alloc_execmem()`,
> > > CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
> > > 
> > >   config HAVE_ALLOC_EXECMEM
> > > 	bool
> > > 
> > >   config ALLOC_EXECMEM
> > > 	bool "Executable trampline memory allocation"
> > > 	depends on MODULES || HAVE_ALLOC_EXECMEM
> > > 
> > > And define fallback macro to module_alloc() like this.
> > > 
> > > #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> > > #define alloc_execmem(size, gfp)	module_alloc(size)
> > > #endif
> > 
> > Please can we *not* do this? I think this is abstracting at the wrong level (as
> > I mentioned on the prior execmem proposals).
> > 
> > Different exectuable allocations can have different requirements. For example,
> > on arm64 modules need to be within 2G of the kernel image, but the kprobes XOL
> > areas can be anywhere in the kernel VA space.
> > 
> > Forcing those behind the same interface makes things *harder* for architectures
> > and/or makes the common code more complicated (if that ends up having to track
> > all those different requirements). From my PoV it'd be much better to have
> > separate kprobes_alloc_*() functions for kprobes which an architecture can then
> > choose to implement using a common library if it wants to.
> > 
> > I took a look at doing that using the core ifdeffery fixups from Jarkko's v6,
> > and it looks pretty clean to me (and works in testing on arm64):
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kprobes/without-modules
> > 
> > Could we please start with that approach, with kprobe-specific alloc/free code
> > provided by the architecture?

Heh, I also noticed that dead !RWX branch in arm64 patch_map(), I was
about to send a patch to remove it.

> OK, as far as I can read the code, this method also works and neat! 
> (and minimum intrusion). I actually found that exposing CONFIG_ALLOC_EXECMEM
> to user does not help, it should be an internal change. So hiding this change
> from user is better choice. Then there is no reason to introduce the new
> alloc_execmem, but just expand kprobe_alloc_insn_page() is reasonable.

I'm happy with this, it solves the first half of my problem. But I want
eBPF to work in the !MODULES case too.

I think Mark's approach can work for bpf as well, without needing to
touch module_alloc() at all? So I might be able to drop that first patch
entirely.

https://lore.kernel.org/all/a6b162aed1e6fea7f565ef9dd0204d6f2284bcce.1709676663.git.jcalvinowens@gmail.com/

Thanks,
Calvin

> Mark, can you send this series here, so that others can review/test it?
> 
> Thank you!
> 
> 
> > 
> > Thanks,
> > Mark.
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

