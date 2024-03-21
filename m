Return-Path: <linux-kernel+bounces-110100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3BA885A06
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC113B22663
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA584A54;
	Thu, 21 Mar 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWL3OMvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E925810B;
	Thu, 21 Mar 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028151; cv=none; b=o0jYGmLChB8zhsFlUKvFMN4It2Y7gGVQss0r6rTAMilPZYucKBM7zJej64O+mc4nJ4F1EEhDEJm7xaL0U6Yl5Kw4pebhLvnrWZFR8Rj0UdlV7e3k7NaSSKVgLB6/eMkl7hX2Ifhw7B0scdTZsaT9lUq9qH4nEk7YTEHMkcdSLRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028151; c=relaxed/simple;
	bh=fYG4E4wFakwbj3fhrxbqt2XkujIXeIIfV+EnH3hriVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6Qydh7+v7Fx5AH1lT/R45qHTAZ65btKYUILK2yV6YRjNUV37FAcCWE7HaVuPdzXAPbea+XhwNLVGjxTA53x7vpZAlscP9KZtzQTsT1lpRlFagXkWCbcDCcMDtzaTSqMHOgESq/cVeOD0zC+Ip56vZp7cWie8GLErKVyxeN8c7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWL3OMvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33725C433F1;
	Thu, 21 Mar 2024 13:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711028148;
	bh=fYG4E4wFakwbj3fhrxbqt2XkujIXeIIfV+EnH3hriVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWL3OMvAh+ElF/VUhZ0KMxI0c3OGNrXWdU89Qndzm30HdLttjDBbytGBGm+ZKGGxr
	 /ZDjPlJ2b3WgNPNl2kNDpOPl7sYsFHqjBL4EeH+4QG0BTxmH99DhLwtoE8XeDYxD5H
	 Xje8VqXOhHjlI+o1tODEpGtBtJM2lQ5ydgHn1BRur3eDQgd3fEEvw4hDdiK6FNu042
	 E4PoAN6lcZoSfw4Zmre3F+ovsfU/pRAlbP8lW4l2Y0UggQthuxlFUkPBrK6rum6PfG
	 uebbkN6Db7OL2XKiFa8sSqWpMd+/vsixn5BsyzJD+kb56iazj2t6GvQ/WzqeOiAU0R
	 DuuqNKMOb7dXw==
Date: Thu, 21 Mar 2024 10:35:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/5] perf beauty: Introduce scrape script for various fs
 syscalls 'flags' arguments
Message-ID: <Zfw3sRGespUx-qQ4@x1>
References: <20240320193115.811899-1-acme@kernel.org>
 <20240320193115.811899-2-acme@kernel.org>
 <CAP-5=fWXCL0AAdp4bSQHPo_XR1iiF8KY4=Bo4756XC1tE0PDUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWXCL0AAdp4bSQHPo_XR1iiF8KY4=Bo4756XC1tE0PDUw@mail.gmail.com>

On Wed, Mar 20, 2024 at 06:47:28PM -0700, Ian Rogers wrote:
> On Wed, Mar 20, 2024 at 12:31 PM Arnaldo Carvalho de Melo
> > +++ b/tools/perf/Makefile.perf
> > @@ -489,6 +489,12 @@ beauty_ioctl_outdir := $(beauty_outdir)/ioctl
> >  # Create output directory if not already present
> >  $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outdir)')
> >
> > +fs_at_flags_array := $(beauty_outdir)/fs_at_flags_array.c
> > +fs_at_flags_tbl := $(srctree)/tools/perf/trace/beauty/fs_at_flags.sh
> > +
> > +$(fs_at_flags_array): $(beauty_uapi_linux_dir)/fcntl.h $(fs_at_flags_tbl)
> > +       $(Q)$(SHELL) '$(fs_at_flags_tbl)' $(beauty_uapi_linux_dir) > $@
> > +
> 
> I wonder if rather than update Makefile.perf, we could push more of
> the logic into tools/perf/trace/beauty/Build. It would also be nice to
> add there the shellcheck logic:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/Build?h=perf-tools-next#n81

Sure, I thought about consolidating lots of boilerplate there and also
to move it to tools/perf/trace/beauty/Build. Will see if I can do it in
this series at some point.

Thanks for reviewing the patches,

- Arnaldo

