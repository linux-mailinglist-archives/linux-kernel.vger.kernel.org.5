Return-Path: <linux-kernel+bounces-137035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060289DB6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA74287DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11112F58C;
	Tue,  9 Apr 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed1/+PuG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301C129A7B;
	Tue,  9 Apr 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671101; cv=none; b=dpJ3cDfn3ZHOafWlFG31Es8+ikTok9AZQYRuUJUKZOgcwCfqA7XbZFlN3Evb3OZpzniCmiItdspCg08RUTOEDhhTNbChTjXCaK72zAtxuecQw7actYOBR5br0ssEVy/NG8tHgvlB9DiI4k6MA1O+r+PV6aJxMsWvCzG6M1O/IzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671101; c=relaxed/simple;
	bh=WX7OkY7CVHINe0hCmrN5mpbxfqBRioMt9jnMFYip5ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWewLQy69Hj1vrEDEZpokR+fVoFttG0Cn+A7+2zt5L67m7GoZHWBE3/pUVKXbpiHOpGfGP2ErMj1G65/oeTTTgz6Q50dK2UKgh4l/TN7o8wnpGd3o3Tax2z/H65f9m7J2nb3Rqcc1r/iZxqY4SJiy2JY4PbKXPLJz25ZEXuyQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed1/+PuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3D6C433F1;
	Tue,  9 Apr 2024 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671101;
	bh=WX7OkY7CVHINe0hCmrN5mpbxfqBRioMt9jnMFYip5ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ed1/+PuGWgtawyw19WFFuYWcXVi5vFGTNd9Fg5PFDNYdZJLoMZzp6Cpl9Zyv5Fmbj
	 +mcDesp5Hp0VoSS6eVMTJCjeRCEI1megT30lSTJPtgxNBE0pA8gU5tov3ZOolBHj8J
	 ExYuM2dPkofKuqahT/LC+AdOekWbEsGFQRBOjdwQ3Jl0UCKwEu9UL16uOe6Hh03GUG
	 rGEyNN7IYcoFV/Rea+xRdg/S/C/k8IxqDtifSLEJkceJqQSgCYGl0z15boSj8Ia6XL
	 yQdBO09xAwy/c8NnoJ5J7qENf+az1preMr2Ue1KHsNXorodcArQAjfk2DOuL4ja7V/
	 uRUGbNLqbzJRA==
Date: Tue, 9 Apr 2024 10:58:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/9] Sync tools headers with the kernel source
Message-ID: <ZhVJegoH7FKVtp0F@x1>
References: <20240408185520.1550865-1-namhyung@kernel.org>
 <ZhRB4BULj1Y1f1TN@x1>
 <ZhTw7e+sy0wfzgR5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhTw7e+sy0wfzgR5@gmail.com>

On Tue, Apr 09, 2024 at 09:40:29AM +0200, Ingo Molnar wrote:
> 
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > On Mon, Apr 08, 2024 at 11:55:11AM -0700, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > I'm gonna carry these changes on the perf tools tree.  I'll update the
> > > vhost.h once it lands on the mainline.
> > 
> > Humm, maybe its not a good idea to do that this cycle?
> 
> Maybe it's just me, but I've been looking sadly at all the header warnings 
> for months. :-) Would be better to keep them in sync with a bit higher 

I backtracked from asking for a delay, the reason for me first thinking
about not doing it this time is because in perf-tools-next we have, to
be merged for 6.10:

⬢[acme@toolbox perf-tools-next]$ git log --oneline torvalds/master.. | tail
f324b73c2c05832b perf beauty: Stop using the copy of uapi/linux/prctl.h
c8bfe3fad4f86a02 perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the directory used to build perf
7050e33e86ad03d2 perf beauty: Move uapi/sound/asound.h copy out of the directory used to build perf
44512bd6136ec7bb perf beauty: Move uapi/linux/usbdevice_fs.h copy out of the directory used to build perf
ab3316119f9d0b3a perf beauty: Move uapi/linux/mount.h copy out of the directory used to build perf
22916d2cbad9a20d perf beauty: Don't include uapi/linux/mount.h, use sys/mount.h instead
faf7217a397f041f perf beauty: Move uapi/linux/fs.h copy out of the directory used to build perf
5d8c646038f2f173 perf beauty: Fix dependency of tables using uapi/linux/mount.h
4b3761eebb1c5c1b perf c2c: Fix a punctuation
a9f4c6c999008c92 perf trace: Collect sys_nanosleep first argument
⬢[acme@toolbox perf-tools-next]$

The reasoning for these changes is in the csets, for instance:

⬢[acme@toolbox perf-tools-next]$ git show 7050e33e86ad03d2 | head -21
commit 7050e33e86ad03d26d7b969bba1d48ee159be496
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Mar 11 17:07:33 2024 -0300

    perf beauty: Move uapi/sound/asound.h copy out of the directory used to build perf
    
    It is used only to generate string tables, not to build perf, so move it
    to the tools/perf/trace/beauty/include/ hierarchy, that is used just for
    scraping.
    
    This is a something that should've have happened, as happened with the
    linux/socket.h scraper, do it now as Ian suggested while doing an
    audit/refactor session in the headers used by perf.
    
    Suggested-by: Ian Rogers <irogers@google.com>
    Reviewed-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: https://lore.kernel.org/lkml/CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
⬢[acme@toolbox perf-tools-next]$

I.e. I had moved some of the stuff that is being updated, but nah,
better to have v6.9 tools/perf building without warnings, I'll fixup the
merge when I merge perf-tools-next with torvalds/master after the
updates are merged upstream.

This is sometimes difficult to achieve tho or would require more pull
requests to be sent to Linus to get some last minute changes, its not
something common, but I think happened a few times.

> frequency, IMO - which would reduce the pain and churn rate:
> 
> > >  16 files changed, 809 insertions(+), 740 deletions(-)
> 
> That's like about a year of changes missed? An update once per cycle and 
> this wouldn't be nearly as painful, right?

Humm, I haven't checked if it stays that long without merging, what I've
agreed with Namhyung is to wait a bit for things to reach upstream, say
-rc3, and then do the update, trying not to do these things nor early
not late in the -rc sequence, to pick a sweet spot where most likely no
changes will be made, we make the update and the perf build has no
warnings in the final release.

- Arnaldo

