Return-Path: <linux-kernel+bounces-118262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A088B6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E4E2A8198
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75E62137F;
	Tue, 26 Mar 2024 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge0K347m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087281C6BE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417334; cv=none; b=gIdvXH/E7TnuSV3DaGtwh1vdPnRVejZaricCqsuwpVtUcWWJs+/lG4k0UHCaRWD6ioIIm+rc0JhdKxJGUEOGOJD5RC5Q/ulOm/xamM1sMrUMJOSOuzyXq00KzfVFaUn9+pipS0UBb9fIkiNOXUS1Kq5JjWHz2+LLykcWLNW9pOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417334; c=relaxed/simple;
	bh=OWRGZAoTwlD15MOqhJjmQoMizKHAtbh8DHOT9VrE1lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/R43foSjSLJzunZiSEYWW4oiSLPu3y563QPpx0CCqu/G/gCllwoYc8ly4x3bkTMFkJMQFImM8+AwuxXvOT8C2rSppvId16seuTN6gKrtTM55ViBvGjm5Wlp9pn0LBjLqpiV4Avfy2607IrX2JDs77bymLLG9Ax47ce7QC5zTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge0K347m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FD2C433C7;
	Tue, 26 Mar 2024 01:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711417333;
	bh=OWRGZAoTwlD15MOqhJjmQoMizKHAtbh8DHOT9VrE1lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge0K347meeUSw5Cf4GUHdgcKEF+N9hl6GJfOzMa4jy+1DnbHNS+nFmpJlDxQV9Z4F
	 e9azU+DSqzdGM4VcSCl9hwAU2NbL7fVL82sAVhASLKTGFah5GSfx6BpLHCFvz7b53V
	 1VIjaQV/3QZfwWXInM8YE5q/UNf1azpCW/E1M7ljohoX/Rbk/ghiEdJ+bn7h7pU6Am
	 uGzBFD3TOCUPzjEI/6XA6h+JsV5PQNMOLOCLQH4Nn6RFYwEXVF2H2MhhYSCCAX14Xs
	 SXCHYkUyyBzWiBVPx1kuXgEl6YZG591UGkJ/u/ZYzY4fo9mt7inhSI/C56d4JrsyY/
	 mpgAV2lI4B0Jg==
Date: Tue, 26 Mar 2024 09:28:58 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Bo Gan <ganboing@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 1/5] riscv: nommu: remove PAGE_OFFSET hardcoding
Message-ID: <ZgIk2hmprnyGr_ce@xhacker>
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-2-jszhang@kernel.org>
 <37d456c1-f0bd-1a78-2d0c-350ca25c6b8d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37d456c1-f0bd-1a78-2d0c-350ca25c6b8d@gmail.com>

On Mon, Mar 25, 2024 at 03:46:01PM -0700, Bo Gan wrote:
> On 3/25/24 9:40 AM, Jisheng Zhang wrote:
> > Currently, PAGE_OFFSET is hardcoded as 0x8000_0000, it works fine since
> > there's only one nommu platform in the mainline. However, there are
> > many cases where the (S)DRAM base address isn't 0x8000_0000, so remove
> > the hardcoding value, and introduce DRAM_BASE which will be set by
> > users during configuring. DRAM_BASE is 0x8000_0000 by default.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   arch/riscv/Kconfig | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 7895c77545f1..afd51dbdc253 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -247,10 +247,16 @@ config MMU
> >   	  Select if you want MMU-based virtualised addressing space
> >   	  support by paged memory management. If unsure, say 'Y'.
> > +if !MMU
> > +config DRAM_BASE
> > +	hex '(S)DRAM Base Address'
> > +	default 0x80000000
> > +endif
> > +
> >   config PAGE_OFFSET
> >   	hex
> >   	default 0xC0000000 if 32BIT && MMU
> > -	default 0x80000000 if !MMU
> > +	default DRAM_BASE if !MMU
> >   	default 0xff60000000000000 if 64BIT
> >   config KASAN_SHADOW_OFFSET
> > 
> 
> Thanks for this patch. I did something similar in my local nommu
> linux-6.8 tree in order to run it on the S7 hart of JH7110. I have
> another suggestion for you. Perhaps we should also make TASK_SIZE
> configurable, and let it default to `0xffffffff if 32BIT && !MMU`
> and `DRAM_BASE + DRAM_SIZE if 64BIT && !MMU`. Currently TASK_SIZE
> is effectively `0xffffffff if !MMU`, which doesn't work if I run
> rv64 linux-nommu with DDR that spans across 4G boundary.

I must admit that there's such nommu linux with 4GB DDR case in
theory, but it doesn't exist in real world: who will make such
strange platform ;) But anyway this improvement can be made when
the patchset talking about TASK_SIZE_MAX is settled down.

> 
> I see there's another patchset that tries to define TASK_SIZE_MAX
> for __access_ok(). Looks like that only affects the MMU case, and
> NOMMU is not touched. My aforementioned change won't conflict with
> it should it get merged.
> 
> Bo

