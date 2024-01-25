Return-Path: <linux-kernel+bounces-38736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0983C510
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B126294510
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5866E2C7;
	Thu, 25 Jan 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2SJsb2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B25DF32;
	Thu, 25 Jan 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193938; cv=none; b=QmAAR6iUz05iBRx+8Bbcquje3RqQiVJvrHw4F8sQDlg2UkmAlL3hlntIlqIgAR1T1FP7Fpcfo9YxoDvDkw/yDeOKw88bvbWoouMU4Lg4v5JSXcpsVEyPySqJlqu+pZJZtXlQvB+2HRWo7EQQx8zqyzhPchdhn5k2yk7ahD17Qbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193938; c=relaxed/simple;
	bh=yAbogpXndtoZKLrZHxVbYr0m4Eqw8wm5YjgaFBUP2o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRyg6ypKroT4gqvyb+935B/MhLj6s+SAfjChztZsXLrfNqlqFlitUV/UDC1zeaCDoSOd7vo/EYIOWABXDUb5MAIQuTpnnsO+H4mNxQwcnVceuH1UvKxS27UvBBLGVV2JngQpiAvgQukR1RkOs8ELyh6ZRYRblwvmwbSew/nBoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2SJsb2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A27C433C7;
	Thu, 25 Jan 2024 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706193937;
	bh=yAbogpXndtoZKLrZHxVbYr0m4Eqw8wm5YjgaFBUP2o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2SJsb2zTgPxeRd3Usls2naa5E3F/yUgSYiDxCE0ElziFKwBAgE7cKzAXceKJnjMP
	 D495+J8GkV05X8Kj9Ig4uNl/9S9J/bf0pVfO18CUf5gXw1ARDa0twhTNRb5dlLeGrN
	 iXj/k/a0ErzI7M7wIIrv2Ooy45LYYW36te7QqjkZbk/n4rQHy/xS85LWDAgXCUVO7l
	 Di4jOQZ8uepNNACUydpxImWTZZNykraTtErMG1EHA+y/RKu1u3TudPIAJsX6UdDGRF
	 bY4mjzlhMh8v1lqZWHsc4Tb+8AjANk1POZzyj/YdlVd3YWgaIjEj0Ah98rR0aRxnD5
	 qBHg8EJNdVIMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 21ECE405B2; Thu, 25 Jan 2024 11:45:35 -0300 (-03)
Date: Thu, 25 Jan 2024 11:45:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RESEND] perf tools: Add -H short option for --hierarchy
Message-ID: <ZbJ0DyIx9bW-7HjM@kernel.org>
References: <20240125055124.1579617-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125055124.1579617-1-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Jan 24, 2024 at 09:51:24PM -0800, Namhyung Kim escreveu:
> I found the hierarchy mode useful, but it's easy to make a typo when
> using it.  Let's add a short option for that.

Fair enough, but:

[root@quaco ~]# perf report --hi + head -15
 Error: Ambiguous option: hi (could be --hide-unresolved or --hierarchy)

 Usage: perf report [<options>]

    -U, --hide-unresolved
                          Only display entries resolved to a symbol
        --hierarchy       Show entries in a hierarchy
	[root@quaco ~]# perf report --hie | head -15
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 56  of event 'cycles:P'
# Event count (approx.): 13456952
#
#       Overhead  Command / Shared Object / Symbol
# ..............  ........................................
#
    72.56%        swapper
       72.56%        [kernel.kallsyms]
          72.56%        [k] intel_idle_ibrs
    18.53%        perf
[root@quaco ~]#
 
> Also update the documentation. :)

Thanks, as a suggestion maybe we should have a:

  $ perf config ui.hierarchy 

as we have:

[root@quaco ~]# perf config ui.show-headers=true
[root@quaco ~]# perf config ui.show-headers
ui.show-headers=true
[root@quaco ~]#


Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-report.txt | 29 ++++++++++++++++++++-
>  tools/perf/Documentation/perf-top.txt    | 32 +++++++++++++++++++++++-
>  tools/perf/builtin-report.c              |  2 +-
>  tools/perf/builtin-top.c                 |  2 +-
>  4 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 38f59ac064f7..d8b863e01fe0 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -531,8 +531,35 @@ include::itrace.txt[]
>  --raw-trace::
>  	When displaying traceevent output, do not use print fmt or plugins.
>  
> +-H::
>  --hierarchy::
> -	Enable hierarchical output.
> +	Enable hierarchical output.  In the hierarchy mode, each sort key groups
> +	samples based on the criteria and then sub-divide it using the lower
> +	level sort key.
> +
> +	For example:
> +	In normal output:
> +
> +	  perf report -s dso,sym
> +	  # Overhead  Shared Object      Symbol
> +	      50.00%  [kernel.kallsyms]  [k] kfunc1
> +	      20.00%  perf               [.] foo
> +	      15.00%  [kernel.kallsyms]  [k] kfunc2
> +	      10.00%  perf               [.] bar
> +	       5.00%  libc.so            [.] libcall
> +
> +	In hierarchy output:
> +
> +	  perf report -s dso,sym --hierarchy
> +	  #   Overhead  Shared Object / Symbol
> +	      65.00%    [kernel.kallsyms]
> +	        50.00%    [k] kfunc1
> +	        15.00%    [k] kfunc2
> +	      30.00%    perf
> +	        20.00%    [.] foo
> +	        10.00%    [.] bar
> +	       5.00%    libc.so
> +	         5.00%    [.] libcall
>  
>  --inline::
>  	If a callgraph address belongs to an inlined function, the inline stack
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 3c202ec080ba..a754875fa5bb 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -261,8 +261,38 @@ Default is to monitor all CPUS.
>  --raw-trace::
>  	When displaying traceevent output, do not use print fmt or plugins.
>  
> +-H::
>  --hierarchy::
> -	Enable hierarchy output.
> +	Enable hierarchical output.  In the hierarchy mode, each sort key groups
> +	samples based on the criteria and then sub-divide it using the lower
> +	level sort key.
> +
> +	For example, in normal output:
> +
> +	  perf report -s dso,sym
> +	  #
> +	  # Overhead  Shared Object      Symbol
> +	  # ........  .................  ...........
> +	      50.00%  [kernel.kallsyms]  [k] kfunc1
> +	      20.00%  perf               [.] foo
> +	      15.00%  [kernel.kallsyms]  [k] kfunc2
> +	      10.00%  perf               [.] bar
> +	       5.00%  libc.so            [.] libcall
> +
> +	In hierarchy output:
> +
> +	  perf report -s dso,sym --hierarchy
> +	  #
> +	  #   Overhead  Shared Object / Symbol
> +	  # ..........  ......................
> +	      65.00%    [kernel.kallsyms]
> +	        50.00%    [k] kfunc1
> +	        15.00%    [k] kfunc2
> +	      30.00%    perf
> +	        20.00%    [.] foo
> +	        10.00%    [.] bar
> +	       5.00%    libc.so
> +	         5.00%    [.] libcall
>  
>  --overwrite::
>  	Enable this to use just the most recent records, which helps in high core count
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index f2ed2b7e80a3..ccb91fe6b876 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1410,7 +1410,7 @@ int cmd_report(int argc, const char **argv)
>  		    "only show processor socket that match with this filter"),
>  	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
>  		    "Show raw trace event output (do not use print fmt or plugins)"),
> -	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
> +	OPT_BOOLEAN('H', "hierarchy", &symbol_conf.report_hierarchy,
>  		    "Show entries in a hierarchy"),
>  	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
>  			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index baf1ab083436..03cf45088fd8 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1573,7 +1573,7 @@ int cmd_top(int argc, const char **argv)
>  		    "add last branch records to call history"),
>  	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
>  		    "Show raw trace event output (do not use print fmt or plugins)"),
> -	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
> +	OPT_BOOLEAN('H', "hierarchy", &symbol_conf.report_hierarchy,
>  		    "Show entries in a hierarchy"),
>  	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
>  		    "Use a backward ring buffer, default: no"),
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

-- 

- Arnaldo

