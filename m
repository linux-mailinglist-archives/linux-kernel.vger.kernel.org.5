Return-Path: <linux-kernel+bounces-107605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA07A87FF01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35349282B79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848D8061F;
	Tue, 19 Mar 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLeeeXAa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373980601;
	Tue, 19 Mar 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855813; cv=none; b=tGraBs1jLY9/JLefztiQEJUDPttIb5SBgvkyMEQXdw3cZmbwlGRRZYcPfe33rkq3kmoK9qfxkgV89UAf2gjcGYmDNYgygBdkPK18Q0eOI4i4Yp18j6k0qIwHlY8RJgvT+YKH0fPJD4egR3HxbaabDOl6yFhNVXocbqtCToULMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855813; c=relaxed/simple;
	bh=CYKpUSoyIN982RAd9PT7IWWxc/kQtgWF+GoaKirqFkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPFg0fibjSEcqbDmfOyEeEixrdXkUalUoUGx3TImeai0yzW7VUOKt8kaCRBrtHqril8fLGXKDQVfVcK801CRYaPK9be7J3g/Dr/OTeetqNEFVzr11oqi1d9KR6Al698J568KlI0L3UkWaT2emalSfaNCJ19yOdqp9qSibhYAPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLeeeXAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB205C433F1;
	Tue, 19 Mar 2024 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710855812;
	bh=CYKpUSoyIN982RAd9PT7IWWxc/kQtgWF+GoaKirqFkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLeeeXAapwzjPw69WzvV5X8GYDrtRA/KhDF4hXDeAH8iXeSNXb6gi6zQwxBiGdhJF
	 MAWTX7E33tWGq0dZiKtpDaPYR6ibCjA6G7YyLZ2ZWj3U6caa9c8qpLLHdQDyK5LsiN
	 YpwTnV6idbc+yz8+CIobxp5BG83x4jw9szGEwNMgieR5/BfvRQbemMY9vg3pJRvpbz
	 Gd43S85qiTPpwr4iL2rFM0UrjoaLfVx/wOkN/AWxGe7AQUqfCd7rJMY9G5ZyD3b58d
	 rrZtb7yJdG0qCE6FU1fenr+5tvKE1kf/UJ013FxwYO5o1pJNxTqCpjtnWKDPVel+zP
	 tY1dN8+tEzboA==
Date: Tue, 19 Mar 2024 10:43:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 01/23] perf dwarf-aux: Remove unused pc argument
Message-ID: <ZfmWgbkApCMoeWHm@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
 <20240319055115.4063940-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319055115.4063940-2-namhyung@kernel.org>

On Mon, Mar 18, 2024 at 10:50:53PM -0700, Namhyung Kim wrote:
> It's not used, let's get rid of it.

I looked for data->pc, there is usage somewhere else, but not via
__die_find_var_addr_cb() nor match_var_offset().

I think renaming:

  struct find_var_data data;

to:

  struct find_var_data var;

And:

  struct find_scope_data data;

to:

  struct find_scope_data scope;

Helps with grepping for 'data->pc', but that can be left for later.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 4 ++--
>  tools/perf/util/dwarf-aux.c     | 7 ++-----
>  tools/perf/util/dwarf-aux.h     | 6 ++----
>  3 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 30c4d19fcf11..59ce5f4f4a40 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -263,7 +263,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
>  	offset = loc->offset;
>  
>  	if (reg == DWARF_REG_PC) {
> -		if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
> +		if (die_find_variable_by_addr(&cu_die, addr, &var_die, &offset)) {
>  			ret = check_variable(&var_die, type_die, offset,
>  					     /*is_pointer=*/false);
>  			loc->offset = offset;
> @@ -312,7 +312,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
>  	/* Search from the inner-most scope to the outer */
>  	for (i = nr_scopes - 1; i >= 0; i--) {
>  		if (reg == DWARF_REG_PC) {
> -			if (!die_find_variable_by_addr(&scopes[i], pc, addr,
> +			if (!die_find_variable_by_addr(&scopes[i], addr,
>  						       &var_die, &offset))
>  				continue;
>  		} else {
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 2791126069b4..e84d0d6a7750 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1456,7 +1456,6 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
>  /**
>   * die_find_variable_by_addr - Find variable located at given address
>   * @sc_die: a scope DIE
> - * @pc: the program address to find
>   * @addr: the data address to find
>   * @die_mem: a buffer to save the resulting DIE
>   * @offset: the offset in the resulting type
> @@ -1464,12 +1463,10 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
>   * Find the variable DIE located at the given address (in PC-relative mode).
>   * This is usually for global variables.
>   */
> -Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
> -				     Dwarf_Addr addr, Dwarf_Die *die_mem,
> -				     int *offset)
> +Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
> +				     Dwarf_Die *die_mem, int *offset)
>  {
>  	struct find_var_data data = {
> -		.pc = pc,
>  		.addr = addr,
>  	};
>  	Dwarf_Die *result;
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 85dd527ae1f7..9973801a20c1 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -146,9 +146,8 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
>  				    Dwarf_Die *die_mem);
>  
>  /* Find a (global) variable located in the 'addr' */
> -Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
> -				     Dwarf_Addr addr, Dwarf_Die *die_mem,
> -				     int *offset);
> +Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
> +				     Dwarf_Die *die_mem, int *offset);
>  
>  #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
> @@ -170,7 +169,6 @@ static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unus
>  }
>  
>  static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unused,
> -						   Dwarf_Addr pc __maybe_unused,
>  						   Dwarf_Addr addr __maybe_unused,
>  						   Dwarf_Die *die_mem __maybe_unused,
>  						   int *offset __maybe_unused)
> -- 
> 2.44.0.291.gc1ea87d7ee-goog
> 

