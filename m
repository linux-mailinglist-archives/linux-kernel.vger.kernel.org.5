Return-Path: <linux-kernel+bounces-17120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7492824886
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7096A2829B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623E2C195;
	Thu,  4 Jan 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su1nK90Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B328E3C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F26C433C8;
	Thu,  4 Jan 2024 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704394970;
	bh=pdDJqTosF1wpqmERsL7jceNVtd6FJ+CFB3Sn8PiagBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=su1nK90Q/5kiHsiIOBkGgj8NrS4dseBRz7EZ33bEovIH4NRBHkMi5qTsQrkvH1ZD9
	 VgtfWbNHi2zO7BKJceZmm+kC2BlFqzoehFmYnCopZAXXuGFEddyFUF4YfjM6vLffAf
	 xmw4X98h3NPFcCwO/T8GsI4APIJSoSHPpei3XWvtrFXDaXxlmD0gGMEooXwtVu65cL
	 b8dHGAQAkwxFg3XC8KKoF7p4cPQNG4NbasPqTMYrt9Ay9BYYZlCyo4oybh78L4R/TE
	 i0MmwTcvNLLzKBFDO1K5J5NqEkZ0WuvGOGMQj/Uwe+SNxePhsSFzENaJOrlSVGaO0d
	 a/lsoIPnaObrA==
Date: Thu, 4 Jan 2024 13:02:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH 2/8] ARC: Fix typos
Message-ID: <20240104190247.GA1823635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c7008e-d460-4314-b2af-2122b93d41dc@infradead.org>

On Wed, Jan 03, 2024 at 04:31:31PM -0800, Randy Dunlap wrote:
> On 1/3/24 15:15, Bjorn Helgaas wrote:
> ...

> > --- a/arch/arc/include/asm/pgtable-bits-arcv2.h
> > +++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
> > @@ -66,7 +66,7 @@
> >   * Other rules which cause the divergence from 1:1 mapping
> >   *
> >   *  1. Although ARC700 can do exclusive execute/write protection (meaning R
> > - *     can be tracked independet of X/W unlike some other CPUs), still to
> > + *     can be tracked independent of X/W unlike some other CPUs), still to
> 
>                          independently

Indeed, embarrassing, thanks.

> >   *     keep things consistent with other archs:
> >   *      -Write implies Read:   W => R
> >   *      -Execute implies Read: X => R
> 
> > diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
> > index 0b3bb529d246..5414d9f5c40c 100644
> > --- a/arch/arc/kernel/signal.c
> > +++ b/arch/arc/kernel/signal.c
> > @@ -9,7 +9,7 @@
> >   * vineetg: Nov 2009 (Everything needed for TIF_RESTORE_SIGMASK)
> >   *  -do_signal() supports TIF_RESTORE_SIGMASK
> >   *  -do_signal() no loner needs oldset, required by OLD sys_sigsuspend
> > - *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implemen
> > + *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implement
> 
>                                                                          implementation

Thanks again.

Added these and a couple other ones to my local copy in case there's a
v2:

diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index f8f85c04d7a8..8ebec1b21d24 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -66,7 +66,7 @@
  * Other rules which cause the divergence from 1:1 mapping
  *
  *  1. Although ARC700 can do exclusive execute/write protection (meaning R
- *     can be tracked independent of X/W unlike some other CPUs), still to
+ *     can be tracked independently of X/W unlike some other CPUs), still to
  *     keep things consistent with other archs:
  *      -Write implies Read:   W => R
  *      -Execute implies Read: X => R
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 5414d9f5c40c..3490d005e6d4 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -8,15 +8,16 @@
  *
  * vineetg: Nov 2009 (Everything needed for TIF_RESTORE_SIGMASK)
  *  -do_signal() supports TIF_RESTORE_SIGMASK
- *  -do_signal() no loner needs oldset, required by OLD sys_sigsuspend
- *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implement
+ *  -do_signal() no longer needs oldset, required by OLD sys_sigsuspend
+ *  -sys_rt_sigsuspend() now comes from generic code, so discard arch
+ *   implementation
  *  -sys_sigsuspend() no longer needs to fudge ptregs, hence that arg removed
  *  -sys_sigsuspend() no longer loops for do_signal(), sets TIF_xxx and leaves
  *   the job to do_signal()
  *
  * vineetg: July 2009
  *  -Modified Code to support the uClibc provided userland sigreturn stub
- *   to avoid kernel synthesing it on user stack at runtime, costing TLB
+ *   to avoid kernel synthesizing it on user stack at runtime, costing TLB
  *   probes and Cache line flushes.
  *
  * vineetg: July 2009

