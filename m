Return-Path: <linux-kernel+bounces-1128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BAA814AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78852833AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6931734;
	Fri, 15 Dec 2023 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnRoYV0G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367BD1E52D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F79C433C7;
	Fri, 15 Dec 2023 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702651565;
	bh=jzFDNJuLJ6cwKQpJEqNkqbBl62KO2NbbGtnvRVADlZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnRoYV0GsxYWyoEIY20WQJJidmceglphxlMhQ3EjEzFb8hP+8jCFMKvLOz2+djyJ1
	 GZJPl0RT0rkGMHyXkNoaeI0nsPc/Dg9kTKYrn43OkKwVJp/2AiuQoBRayqNZHHwFO5
	 4z2y1VJ1h5ktdmFcu3zW34W12H3UysqzkIPoTY0bVyF2j4A4zMdZMbI6xtZiZ3jZDR
	 /kdibaVCfBfAJG6SOKlzZKA2W7L1ot6/0jFqtmDUnnTmPWFECzgdp0ADylIcz2MNY0
	 EIasHAt3t/Yxar14og65MzqyVlxZNwN9EfBZ2RGnh3SzGHPsfpmgayljpaqMZvlpOZ
	 9bGNm95aBVwIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B7AA3403EF; Fri, 15 Dec 2023 11:46:02 -0300 (-03)
Date: Fri, 15 Dec 2023 11:46:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: kajoljain <kjain@linux.ibm.com>,
	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
	Ian Rogers <irogers@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: perf tools arch Arm CMN PMU JSON files build breakage on ubuntu
 18.04 cross build
Message-ID: <ZXxmqmBrxe5o0Ytk@kernel.org>
References: <ZBxP77deq7ikTxwG@kernel.org>
 <a21aa4e1-506a-916c-03bd-39d7403c7941@linux.ibm.com>
 <ZXxlERShV-TIGVit@kernel.org>
 <ZXxlj3g-KMG3iYjx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXxlj3g-KMG3iYjx@kernel.org>
X-Url: http://acmel.wordpress.com

Em Fri, Dec 15, 2023 at 11:41:19AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Dec 15, 2023 at 11:39:14AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Mar 27, 2023 at 09:52:11AM +0530, kajoljain escreveu:
> > > > UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 55090: ordinal not in range(128)
> > > >   CC      /tmp/build/perf/tests/expr.o
> > > > pmu-events/Build:35: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
> > > > make[3]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 1
> > > > make[3]: *** Deleting file '/tmp/build/perf/pmu-events/pmu-events.c'
> > > > Makefile.perf:679: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
> > > > make[2]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> > > > make[2]: *** Waiting for unfinished jobs....
> > 
> > > > Now jevents is an opt-out feature so I'm noticing these problems.
> >  
> > >     Thanks for raising it. I will check this issue.
> > 
> > Now I'm seeing this on:
> 
> Jing,
> 
> 	Please take a look at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d9df8731c0941f3add30f96745a62586a0c9d52
> 
> 	For the fix for the ppc case above.

Its the only .json file with that issue:

⬢[acme@toolbox perf-tools-next]$ find tools/perf/pmu-events/ -name "*.json" | xargs file -i | grep -v us-ascii
tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json:                   application/json; charset=utf-8
⬢[acme@toolbox perf-tools-next]$

- Arnaldo

