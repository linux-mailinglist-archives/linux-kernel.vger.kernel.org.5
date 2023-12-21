Return-Path: <linux-kernel+bounces-9048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFA81BF96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FA0B22935
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F5760BD;
	Thu, 21 Dec 2023 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnVf6Zcc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D976DC7;
	Thu, 21 Dec 2023 20:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC38C433C8;
	Thu, 21 Dec 2023 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703190767;
	bh=SWGQ3MvJU+mQrrOMqKF9T8oXRlNV4a/s4URQh77R0iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnVf6ZccmMRLDXiuXjxoUqdQGEQAOt/UZDgfzk3uw/fWvORsbwnBN4sc93SICdqOm
	 j4a9ZAxBkVXiX0bLsU9mcoZ2Xt22s2gTRBPVDkxW/xcna2HpumyG60AuLilw4f/koB
	 8i7eAPIkeLGMDBx1sVXZOKErx9TVHAueMVUkmiznKXobyk5rljxV5gzx+fB9TFZC98
	 bgwYfJN6fvYAlFb9ypFreSQe7OCQptqkthdR5Kkja/feNIMb50OVnd/djidvPAteVr
	 bpd6kQ/1WPy3KjbYuUNJv0OIJ2xFGZisL4c1uWFTuj66Z8V7YtRWqoyZQSF33wrJZr
	 nF7Yy6aHv2LBA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id AB28D403EF; Thu, 21 Dec 2023 17:32:44 -0300 (-03)
Date: Thu, 21 Dec 2023 17:32:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Kleen <ak@linux.intel.com>, linux-trace-devel@vger.kernel.org,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 13/52] perf annotate-data: Add dso->data_types tree
Message-ID: <ZYSg7EO0j4y2z5LB@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
 <20231110000012.3538610-14-namhyung@kernel.org>
 <ZYSbzZv-Y-j0_feZ@kernel.org>
 <ZYScVwzbviHyVFHb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYScVwzbviHyVFHb@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 21, 2023 at 05:13:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> > At some point we need to make these feature specific members to be
> > associated on demand, maybe thru some hash table, etc.

> > I.e. the most basic workflow, what everybody needs should be in 'struct
> > dso', something one _may_ want, like data profiling, should be in
> > associated with that DSO thru some other way.

> > I'm applying this now as this is a super cool feature, but think about
> > it.

> I think I have this series applied up to this patch, the next one is not
> applying cleanly, so I'll do the usual set of build tests so that I can
> push this for linux-next consumption.

> This should be on tmp.perf-tools-next in a few jiffies, in
> perf-tools-next a bit later.

Ok, as discussed on google chat, I got v3, all is in my local tree,
build testing while I review.

- Arnaldo

