Return-Path: <linux-kernel+bounces-107624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834287FF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5DE1C224CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB1281746;
	Tue, 19 Mar 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB559RHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568517D3EA;
	Tue, 19 Mar 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857120; cv=none; b=O3jB8jp0mRAfBTxZzIdh/CbLLw53iitpu5c8wBJ65wUXg/xUKCe9PTkpp5YgK4v7jqq2tdV4rpTZhZD5NBM/lB0DvSr+BmcLaAK2G5YGgKnsCDuoQ52hcSGsgpUjdMdGTEKUQKFzqrez94MAc2aMG+NOmTvlwQvCWlYWMFE+e50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857120; c=relaxed/simple;
	bh=A3OBWupXAPJhB+00pELDv4wUixrLARkkrZPDw2jcyuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6iQnfT22cv7WcOszWWolDhtCd2IMkWSRXvvmm8A1J1CL7uuAR1r8FAgMwO3T0yd9zWx+OVAwsYXYNm41iRAxRxq+q6PF42yyy8/XUQrexWmwHXCaxe+xp3Ye/z7CW9bs+PB6phHD4r7dIUqT40+QjpVV33m/nvU/S7WOEbIVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB559RHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65210C433F1;
	Tue, 19 Mar 2024 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710857119;
	bh=A3OBWupXAPJhB+00pELDv4wUixrLARkkrZPDw2jcyuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB559RHOyVE9o0r7yTnaNBLXpgrGhnr63Q193jVaxIDfzfpFX0JrudTFglwkJovKe
	 MITkHjmXP+qq3y0JEVsJX8xDMllNHGDfq5XJXQRgrW04gtXKWmkDGBFQ7CgyNQ5hO5
	 sxfUG0uk3dgPvhrNXnOmmKAxivaoZl5qC9sQggsMrJeyk+3o9CySW1vgkqJ+txO1b2
	 5+NWfmwhRLaSnQ2xQV0x9rtSCLS2KA82qGyI17j88VOxTNflb3DHF9CLBjCaB70jEE
	 EpBT6cT8CXn7WOT0A/iW39XBscWozp1dY0smfcg7W4BD8BxBWlTN1+aLUkoGMtBFXj
	 gOdlP+bwbc3qQ==
Date: Tue, 19 Mar 2024 11:05:16 -0300
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
Subject: Re: [PATCH 08/23] perf annotate-data: Add debug messages
Message-ID: <ZfmbnBBn5qqzQd5D@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
 <20240319055115.4063940-9-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319055115.4063940-9-namhyung@kernel.org>

On Mon, Mar 18, 2024 at 10:51:00PM -0700, Namhyung Kim wrote:
> Add a new debug option "type-profile" to enable the detailed info during
> the type analysis especially for instruction tracking.  You can use this
> before the command name like 'report' or 'annotate'.
> 
>   $ perf --debug type-profile annotate --data-type

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

First get some memory events:

  $ perf mem record ls

Then, without data-type profiling debug:

  $ perf annotate --data-type | head
  Annotate type: 'struct rtld_global' in /usr/lib64/ld-linux-x86-64.so.2 (1 samples):
  ============================================================================
      samples     offset       size  field
            1          0       4336  struct rtld_global  {
            0          0          0      struct link_namespaces*        _dl_ns;
            0       2560          8      size_t _dl_nns;
            0       2568         40      __rtld_lock_recursive_t        _dl_load_lock {
            0       2568         40          pthread_mutex_t    mutex {
            0       2568         40              struct __pthread_mutex_s       __data {
            0       2568          4                  int        __lock;
  $

And with only data-type profiling:

  $ perf --debug type-profile annotate --data-type | head
  -----------------------------------------------------------
  find_data_type_die [1e67] for reg13873052 (PC) offset=0x150e2 in dl_main
  CU die offset: 0x29cd3
  found PC-rel by addr=0x34020 offset=0x20
  -----------------------------------------------------------
  find_data_type_die [2e] for reg12 offset=0 in __GI___readdir64
  CU die offset: 0x137a45
  frame base: cfa=1 fbreg=-1
  found "__futex" in scope=2/2 (die: 0x137ad5) 0(reg12) type=int (die:2a)
  -----------------------------------------------------------
  find_data_type_die [52] for reg5 offset=0 in __memmove_avx_unaligned_erms
  CU die offset: 0x1124ed
  no variable found
  Annotate type: 'struct rtld_global' in /usr/lib64/ld-linux-x86-64.so.2 (1 samples):
  ============================================================================
      samples     offset       size  field
            1          0       4336  struct rtld_global  {
            0          0          0      struct link_namespaces*        _dl_ns;
            0       2560          8      size_t _dl_nns;
            0       2568         40      __rtld_lock_recursive_t        _dl_load_lock {
            0       2568         40          pthread_mutex_t    mutex {
            0       2568         40              struct __pthread_mutex_s       __data {
            0       2568          4                  int        __lock;
  $
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 74 +++++++++++++++++++++++++++++----
>  tools/perf/util/debug.c         |  3 ++
>  tools/perf/util/debug.h         |  1 +
>  3 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index ff81d164aa57..f482ccfdaa91 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -23,6 +23,29 @@
>  #include "symbol.h"
>  #include "symbol_conf.h"
>  
> +#define pr_debug_dtp(fmt, ...)					\
> +do {								\
> +	if (debug_type_profile)					\
> +		pr_info(fmt, ##__VA_ARGS__);			\
> +	else							\
> +		pr_debug3(fmt, ##__VA_ARGS__);			\
> +} while (0)
> +
> +static void pr_debug_type_name(Dwarf_Die *die)
> +{
> +	struct strbuf sb;
> +	char *str;
> +
> +	if (!debug_type_profile && verbose < 3)
> +		return;
> +
> +	strbuf_init(&sb, 32);
> +	die_get_typename_from_type(die, &sb);
> +	str = strbuf_detach(&sb, NULL);
> +	pr_info(" type=%s (die:%lx)\n", str, (long)dwarf_dieoffset(die));
> +	free(str);
> +}
> +
>  /*
>   * Compare type name and size to maintain them in a tree.
>   * I'm not sure if DWARF would have information of a single type in many
> @@ -201,7 +224,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
>  
>  	/* Get the type of the variable */
>  	if (die_get_real_type(var_die, type_die) == NULL) {
> -		pr_debug("variable has no type\n");
> +		pr_debug_dtp("variable has no type\n");
>  		ann_data_stat.no_typeinfo++;
>  		return -1;
>  	}
> @@ -215,7 +238,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
>  		if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
>  		     dwarf_tag(type_die) != DW_TAG_array_type) ||
>  		    die_get_real_type(type_die, type_die) == NULL) {
> -			pr_debug("no pointer or no type\n");
> +			pr_debug_dtp("no pointer or no type\n");
>  			ann_data_stat.no_typeinfo++;
>  			return -1;
>  		}
> @@ -223,14 +246,15 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
>  
>  	/* Get the size of the actual type */
>  	if (dwarf_aggregate_size(type_die, &size) < 0) {
> -		pr_debug("type size is unknown\n");
> +		pr_debug_dtp("type size is unknown\n");
>  		ann_data_stat.invalid_size++;
>  		return -1;
>  	}
>  
>  	/* Minimal sanity check */
>  	if ((unsigned)offset >= size) {
> -		pr_debug("offset: %d is bigger than size: %" PRIu64 "\n", offset, size);
> +		pr_debug_dtp("offset: %d is bigger than size: %"PRIu64"\n",
> +			     offset, size);
>  		ann_data_stat.bad_offset++;
>  		return -1;
>  	}
> @@ -251,6 +275,19 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  	int fb_offset = 0;
>  	bool is_fbreg = false;
>  	u64 pc;
> +	char buf[64];
> +
> +	if (dloc->op->multi_regs)
> +		snprintf(buf, sizeof(buf), " or reg%d", dloc->op->reg2);
> +	else if (dloc->op->reg1 == DWARF_REG_PC)
> +		snprintf(buf, sizeof(buf), " (PC)");
> +	else
> +		buf[0] = '\0';
> +
> +	pr_debug_dtp("-----------------------------------------------------------\n");
> +	pr_debug_dtp("%s [%"PRIx64"] for reg%d%s offset=%#x in %s\n",
> +		     __func__, dloc->ip - dloc->ms->sym->start,
> +		     dloc->op->reg1, buf, dloc->op->offset, dloc->ms->sym->name);
>  
>  	/*
>  	 * IP is a relative instruction address from the start of the map, as
> @@ -261,7 +298,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  
>  	/* Get a compile_unit for this address */
>  	if (!find_cu_die(dloc->di, pc, &cu_die)) {
> -		pr_debug("cannot find CU for address %" PRIx64 "\n", pc);
> +		pr_debug_dtp("cannot find CU for address %"PRIx64"\n", pc);
>  		ann_data_stat.no_cuinfo++;
>  		return -1;
>  	}
> @@ -269,12 +306,17 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  	reg = loc->reg1;
>  	offset = loc->offset;
>  
> +	pr_debug_dtp("CU die offset: %#lx\n", (long)dwarf_dieoffset(&cu_die));
> +
>  	if (reg == DWARF_REG_PC) {
>  		if (die_find_variable_by_addr(&cu_die, dloc->var_addr, &var_die,
>  					      &offset)) {
>  			ret = check_variable(&var_die, type_die, offset,
>  					     /*is_pointer=*/false);
>  			dloc->type_offset = offset;
> +
> +			pr_debug_dtp("found PC-rel by addr=%#"PRIx64" offset=%#x\n",
> +				     dloc->var_addr, offset);
>  			goto out;
>  		}
>  
> @@ -310,6 +352,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  			default:
>  				break;
>  			}
> +
> +			pr_debug_dtp("frame base: cfa=%d fbreg=%d\n",
> +				     dloc->fb_cfa, fbreg);
>  		}
>  	}
>  
> @@ -334,6 +379,19 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  		/* Found a variable, see if it's correct */
>  		ret = check_variable(&var_die, type_die, offset,
>  				     reg != DWARF_REG_PC && !is_fbreg);
> +		if (ret == 0) {
> +			pr_debug_dtp("found \"%s\" in scope=%d/%d (die: %#lx) ",
> +				     dwarf_diename(&var_die), i+1, nr_scopes,
> +				     (long)dwarf_dieoffset(&scopes[i]));
> +			if (reg == DWARF_REG_PC)
> +				pr_debug_dtp("%#x(PC) offset=%#x", loc->offset, offset);
> +			else if (reg == DWARF_REG_FB || is_fbreg)
> +				pr_debug_dtp("%#x(reg%d) stack fb_offset=%#x offset=%#x",
> +					     loc->offset, reg, fb_offset, offset);
> +			else
> +				pr_debug_dtp("%#x(reg%d)", loc->offset, reg);
> +			pr_debug_type_name(type_die);
> +		}
>  		dloc->type_offset = offset;
>  		goto out;
>  	}
> @@ -343,8 +401,10 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  		goto retry;
>  	}
>  
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pr_debug_dtp("no variable found\n");
>  		ann_data_stat.no_var++;
> +	}
>  
>  out:
>  	free(scopes);
> @@ -373,7 +433,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
>  
>  	dloc->di = debuginfo__new(dso->long_name);
>  	if (dloc->di == NULL) {
> -		pr_debug("cannot get the debug info\n");
> +		pr_debug_dtp("cannot get the debug info\n");
>  		return NULL;
>  	}
>  
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index c39ee0fcb8cf..d633d15329fa 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -41,6 +41,7 @@ static int redirect_to_stderr;
>  int debug_data_convert;
>  static FILE *_debug_file;
>  bool debug_display_time;
> +int debug_type_profile;
>  
>  FILE *debug_file(void)
>  {
> @@ -231,6 +232,7 @@ static struct sublevel_option debug_opts[] = {
>  	{ .name = "data-convert",	.value_ptr = &debug_data_convert },
>  	{ .name = "perf-event-open",	.value_ptr = &debug_peo_args },
>  	{ .name = "kmaps",		.value_ptr = &debug_kmaps },
> +	{ .name = "type-profile",	.value_ptr = &debug_type_profile },
>  	{ .name = NULL, }
>  };
>  
> @@ -270,6 +272,7 @@ int perf_quiet_option(void)
>  	redirect_to_stderr = 0;
>  	debug_peo_args = 0;
>  	debug_kmaps = 0;
> +	debug_type_profile = 0;
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
> index 35a7a5ae762e..a4026d1fd6a3 100644
> --- a/tools/perf/util/debug.h
> +++ b/tools/perf/util/debug.h
> @@ -14,6 +14,7 @@ extern int debug_peo_args;
>  extern bool quiet, dump_trace;
>  extern int debug_ordered_events;
>  extern int debug_data_convert;
> +extern int debug_type_profile;
>  
>  #ifndef pr_fmt
>  #define pr_fmt(fmt) fmt
> -- 
> 2.44.0.291.gc1ea87d7ee-goog
> 

