Return-Path: <linux-kernel+bounces-71806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64385AADE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0DD281CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656B5481DB;
	Mon, 19 Feb 2024 18:22:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA647F79
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366953; cv=none; b=ZsUjBlCpoOluCVbFtDK8FpzJFGOn3RAtwkjm/wx5d+k6KUM3QCcJSSfDNuEIBuIEHHb4exYNgEYsvdZkLYZ+5kM6sPPPI0mn2Ct4DRnpZPq1HPu6IRISoQUUUbetFyfVsbq2F+LbXw5CnGK7gtFqtAbFGwkL1BC6rQdPJwSAf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366953; c=relaxed/simple;
	bh=btrFO5+2vaS7IMyffuC98/87q7X/ok+FsHXq6YojZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW1mHI3uStxP8pXh9s68EKJSWniNn4MQNjr1AdJ59hBYb9vDwEly3PPh6lVNK3xi46ZtghxUOdV2kbv0b/lrTuCreFy2aw5v7gp1klDv82XQU6rm9ZfyGl6yWo7FbJ6ckT0c/c0xJc+5ZtRLmTsOoTfG4Q6bN9GnV3qAIWml3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63CFBFEC;
	Mon, 19 Feb 2024 10:23:10 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A623F73F;
	Mon, 19 Feb 2024 10:22:28 -0800 (PST)
Date: Mon, 19 Feb 2024 18:22:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Fangrui Song <maskray@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>,
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
Message-ID: <ZdOcXTvvHyl8s56I@FVFF77S0Q05N>
References: <20240206074552.541154-1-maskray@google.com>
 <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
 <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
 <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
 <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
 <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
 <dca5b082-90d1-40ab-954f-8b3b6f51138c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dca5b082-90d1-40ab-954f-8b3b6f51138c@app.fastmail.com>

On Mon, Feb 19, 2024 at 06:06:19PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 19, 2024, at 16:41, Ard Biesheuvel wrote:
> > On Mon, 19 Feb 2024 at 15:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> On Mon, Feb 19, 2024 at 11:57 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >> > On Mon, 19 Feb 2024 at 11:56, Ard Biesheuvel <ardb@kernel.org> wrote:
> 
> >> > https://godbolt.org/z/GTnf3vPaT
> >>
> >> I could reproduce the issue on v6.8-rc5 using arm64 defconfig
> >> and x86_64-gcc-5.5.0-nolibc-aarch64-linux.tar.xz from
> >> https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/:
> >>
> >
> > OK, I managed to do so as well.
> >
> > And GCC 6.4 from the same source works correctly.
> >
> > Not sure whether there are any plans to bump the minimal GCC version
> > any time soon (cc'ing Arnd), but we should probably drop this change
> > until that happens.
> 
> From what I can tell, we may as well formally raise the minimum
> gcc version to 8.1+ already, as that is a version that is
> actually used in distros, and we have been on 5.1+ for a few
> years already.
> 
> Not sure if there are any other benefits to gcc-8 besides
> allowing minor cleanups.

Arguably a minor cleanup, but on arm64 that'd allow us to get rid of the old
mcount-based ftrace implementation and rely on -fpatchable-function-entry.
On its own that'd save ~130 lines of asm and ~70 lines of C, but it'd also
remove some constraints on other features (e.g. the mcount-based form's graph
tracer isn't compatible with pointer authentication), it would simplify a few
things going forwards (e.g. the implementation of RELIABLE_STACKTRACE, since we
could rely on having ftrace_regs and a single trampoline), and the remaining
support would be better tested.

I've wanted to remove the old ftrace implementation for a while, but on its own
it was never important/urgent enough to justify bumping to GCC 8+.

Mark.

