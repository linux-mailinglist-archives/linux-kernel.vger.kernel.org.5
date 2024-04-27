Return-Path: <linux-kernel+bounces-160837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F558B4369
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400291F2267F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2892E651;
	Sat, 27 Apr 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpZDc5iP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0525777;
	Sat, 27 Apr 2024 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714180167; cv=none; b=R3iuUVhdQgyoTE+vGZGut1QPhdOlrBxHEqVN4qMFk+AGCTCr1p0SySDJTjoM/S0wlU9Qj8ruunpY0CD+aUCaj/lEIHnuOV8uHi1tQ1tzXTVOs2R0nHxbiEaG2ilRgj6eHIDkMEG7Nnkjs8yI8GpzQd/98LYz2iyMTnV1GlQ3A68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714180167; c=relaxed/simple;
	bh=5FyjjO3qI7vbvED0B+ufM1OwjTuy4FUUKvu2jkUC8Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9XRy/suoCMyvZf2dVsOjB4jDuDPSJxlsKMJZDJzr1C+3C+dHNgzB4G1fgSEh+08lJgDKMEZkhEyzhf2TjrVclhRC0iDnAXvNsrgnIoh5OFN3AML8NuR7/tTsKV1eRN8I4gyrvZHLu5YojVziTQmv+GspPOcgCbhrFeKQx9pOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpZDc5iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574C8C113CD;
	Sat, 27 Apr 2024 01:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714180166;
	bh=5FyjjO3qI7vbvED0B+ufM1OwjTuy4FUUKvu2jkUC8Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpZDc5iPFzgWaK3TksswV2zJtpSYA08GGt+Noe7CDPoWDJjEgx/2TtebKgiJTGWWS
	 QZ9YrdtdXwIhrVdL+Sqegl+T9vug5YMSYLyBMcvkGHy8909xIA6waJW7TjhVSYH5Qw
	 jHCuf2jl5l7gRFlJjhE1Csur7ony81mnev1zV2DWZm2s2ow8jeqGcffC32ugmW7HOj
	 ne30QdnrdWVkTEGD/59iXq5fwvE9i1ZsqwAvS7RNUKSxnsUCgOcoLyAfmg3vQ84Coi
	 +YFoZu3kOsNoE8bHBM0nrM3mCu4ikN04DK/ySAjQhlybogh4jY6l4NXSV/vh9U1JVl
	 666sD/fMDvcQw==
Date: Fri, 26 Apr 2024 22:09:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf annotate: Update dso binary type when try
 build-id
Message-ID: <ZixQQ_vKtmtvYSjS@x1>
References: <20240425005157.1104789-1-namhyung@kernel.org>
 <20240425005157.1104789-2-namhyung@kernel.org>
 <Zipk0p08bxO7werD@x1>
 <ZiptiObJxYPeXqK_@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiptiObJxYPeXqK_@x1>

On Thu, Apr 25, 2024 at 11:49:49AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Apr 25, 2024 at 11:12:40AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 24, 2024 at 05:51:57PM -0700, Namhyung Kim wrote:
> > > +++ b/tools/perf/util/disasm.c
> > > @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> > >  		mutex_unlock(&dso->lock);
> > > +	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
> > > +		dso->binary_type = DSO_BINARY_TYPE__BUILD_ID_CACHE;
> > >  	}
>  
> > Fixed up to take into account a recent patch by Ian that turned that
> > &dso->lock into dso__lock(dso):
>  
> > +++ b/tools/perf/util/disasm.c
> > @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> >  			}
> >  		}
> >  		mutex_unlock(dso__lock(dso));
> > +	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
> > +		dso->binary_type = DSO_BINARY_TYPE__BUILD_ID_CACHE;
> >  	}
> 
> Nah, I forgot some more stuff, this is what I have now:

Nah², I had to remove all these:

pick a58b4da77b40920f perf dsos: Switch backing storage to array from rbtree/list 
pick 7d91cefd1fb63068 perf dsos: Remove __dsos__addnew()
pick 80c3ccf05199dbb6 perf dsos: Remove __dsos__findnew_link_by_longname_id()
pick af3f8dea24f47802 perf dsos: Switch hand code to bsearch()
pick 7537b92b48318834 perf dso: Add reference count checking and accessor functions
pick 9bd7c6fe8de22b37 perf dso: Reference counting related fixes
pick 4de57b46a0cb2027 perf dso: Use container_of() to avoid a pointer in 'struct dso_data'

Due to a bisect that pointed "perf dsos: Switch backing storage to array
from rbtree/list" as the one where:

 
root@x1:~# perf test "kernel lock contention analysis test"
 87: kernel lock contention analysis test                            : FAILED!

- Arnaldo

