Return-Path: <linux-kernel+bounces-137023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A063189DB39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F31628A610
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D0B131185;
	Tue,  9 Apr 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqQ3pwPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3FB130E3B;
	Tue,  9 Apr 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670467; cv=none; b=K98w4w0cjVGsQh3huPpMryCrdGBDs6KukNgHGt0hvTegZ9l9HOW3T7f5si1dCkpoxv82rZBXEgou3ZkGqc14Cb0guJp9V9WrS7zWVahAg9IlLGeStDSjTFb/swedRQY7KX0SUys6QyOCG76VbxhXDXHz6/7fT4MM9/iI4TY8h0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670467; c=relaxed/simple;
	bh=cgXhwNqAUlv7uKKki90yp7H4uGeRWUSAoQWHH9FoDUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq46K4YsEh/nooyjwJl4bSr2HJvViqePE55B/cu0LmJ7X38cMyuY3IAhIl8p5ZKwGNi15p2heFiXMIKp9qeC3ax2jcL8lq6b5OppIfp57jnxWguYEDiM97QHReZxTGMCAgeRzeicGvOYm90p/CRw7fgmHk+MPJpOFoBYiuSXN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqQ3pwPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B72C433F1;
	Tue,  9 Apr 2024 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712670466;
	bh=cgXhwNqAUlv7uKKki90yp7H4uGeRWUSAoQWHH9FoDUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqQ3pwPpoETGT/zEAhvXKp0U2TRxKtJRJtPHXw8CE2X5dDNx3EayRhtuT1IW4MdWC
	 8pmS2sbX5GoJVyF9sBmiJaHKzHm7FIxNeBKIKZwlQxPi24Rt0zcNKsi90POcZ1P1Q2
	 OJuGrGahSuNw080QuesKgxOlf08SX+zUzM6S4FiYfOpj+b/YUi/HShEocMAqHXOxMA
	 VIINHZJiKb83JNxNa+2BOO59hZvYSbOMk3xhcYmJ5PFowvtwLGwxgGvOHh3RZkTC1R
	 +Mpc+2P/0EmOuofMuVDxI8gxxaRUZNYwfE7H6q4iV2PdcDmW8VAf510DIExeSXZACY
	 TsJvyd45opZ3A==
Date: Tue, 9 Apr 2024 10:47:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/9] Sync tools headers with the kernel source
Message-ID: <ZhVG_9KpcWLLhc-s@x1>
References: <20240408185520.1550865-1-namhyung@kernel.org>
 <CAMuHMdXQ_osFeknmg=oR6-fMH_MkVqabCtbynxQ6UvpZRwry3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXQ_osFeknmg=oR6-fMH_MkVqabCtbynxQ6UvpZRwry3Q@mail.gmail.com>

On Tue, Apr 09, 2024 at 09:15:02AM +0200, Geert Uytterhoeven wrote:
> Hi Namhyung, Arnaldo,
> 
> On Mon, Apr 8, 2024 at 8:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > I'm gonna carry these changes on the perf tools tree.  I'll update the
> > vhost.h once it lands on the mainline.
> >
> > This is the full explanation from Arnaldo:
> >
> > There used to be no copies, with tools/ code using kernel headers
> > directly. From time to time tools/perf/ broke due to legitimate kernel
> > hacking. At some point Linus complained about such direct usage. Then we
> > adopted the current model.
> 
> Do you have a reference to that?

I would have to do a search on the mailing list to find the exact
exchange, this is from memory and from people asking this repeatedly.

Ingo replied with reasons similar to the ones I use in this canned
explanation when sending the notice of updating the files.

- Arnaldo

> I was gonna reply to [PATCH 8/9] (where I was CCed) with "why can't
> you use the original include file directly?", then read the cover letter.
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

