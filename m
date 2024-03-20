Return-Path: <linux-kernel+bounces-109033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F18813B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318251C2226F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45774C61C;
	Wed, 20 Mar 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utU2qiEf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84B4AECF;
	Wed, 20 Mar 2024 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946448; cv=none; b=mbg67HbYoTzRtmuvGobZeHmAIDVi0f4ioohRpJyYjJgvaA0Oeix+mD9vhXu5u+P2E+4GHyy9QM/6qeaxDwVmBVaMibdnDP4rCDoAjUxrWUuxGHyq+xunRZ4JDSzg69ATfdmqelKY6QOytzOdRxayyAWRROw1708knnBAn7/BpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946448; c=relaxed/simple;
	bh=6xGklQNGbFkNZFhkj91Z7jnuhVtnP2riuP9QNjlSbko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSbRqivmA0f/I8U51qa32fHS4eXaOfdJ+pczH8b3gajHmlvq++lEG3iuPpSVrcmQsHmzupv+6QQMw9QU31o9CW9W2QIl5ZjDgvgJuPINcDEm3w3FwWtTC4Pkn+eFZA58DQ7VNoSfHgEdKFflk71xeMtTeLH0yK8n1FunYLT00Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utU2qiEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552A6C433C7;
	Wed, 20 Mar 2024 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710946448;
	bh=6xGklQNGbFkNZFhkj91Z7jnuhVtnP2riuP9QNjlSbko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utU2qiEfaChUDz67ams9qMH9uEXZKmngT+A7+9ymNRyj6cPi2QRs061blBCfEdkWC
	 CiNDbhQgLNp5nPe/q+kL3w/X3Dwf8cZm9SIggQgy4bQiSmCgICyQHMxqfCaykDzP5Q
	 aykqNFdjuaUGAp1LzOiHvgKViFVHKg9VB75/86WkxriAiKek/RVHh2kOagPfOTIcel
	 Vt3B878OsnxJ5xco+zPf68DpFjBaEjFEXF2JfpxAQA2BP15gtemuE0UaaPu7+24XwL
	 fXsleQCwQH6mEOO0MwbISJhT/0r8n4O0sihOhptXFH6xUJ1/UO7y3W5y/1fSawTBh1
	 9n2neKq/ztrXQ==
Date: Wed, 20 Mar 2024 11:54:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
Message-ID: <Zfr4jX_b8FCOG_x_@x1>
References: <20240301201306.2680986-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301201306.2680986-1-irogers@google.com>

On Fri, Mar 01, 2024 at 12:13:05PM -0800, Ian Rogers wrote:
> The existing unknown command code looks for perf scripts like
> perf-archive.sh and perf-iostat.sh, however, inbuilt commands aren't
> suggested. Add the inbuilt commands so they may be suggested too.
> 
> Before:
> ```
> $ perf reccord
> perf: 'reccord' is not a perf-command. See 'perf --help'.
> ```
> 
> After:
> ```
> $ perf reccord
> perf: 'reccord' is not a perf-command. See 'perf --help'.
> 
> Did you mean this?
>         record
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2. Drops a merged patch and rebases. No functional change. Arnaldo
>     reported the patch not working for him, but I've not found a

Not working:

root@number:~# perf reccord
Failed to run command 'reccord': No such file or directory
root@number:~# 

⬢[acme@toolbox perf-tools-next]$ git log --oneline -1
a65ef8052854ba75 (HEAD) perf: Suggest inbuilt commands for unknown command
⬢[acme@toolbox perf-tools-next]$

I use O= with install-bin, trying:

⬢[acme@toolbox perf-tools-next]$ make -C  tools/perf install-bin
⬢[acme@toolbox perf-tools-next]$ perf raccord
Failed to run command 'raccord': No such file or directory
⬢[acme@toolbox perf-tools-next]$

Also didn't work

Trying to figure this out...

- Arnaldo

>     reproduction and it works for me:
>     https://lore.kernel.org/lkml/ZZcdDyyADG8dP8LM@kernel.org/
> ---
>  tools/perf/builtin.h               |  4 ++-
>  tools/perf/perf.c                  | 21 +++++++++++---
>  tools/perf/util/help-unknown-cmd.c | 45 ++++++++++++++----------------
>  3 files changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> index f2ab5bae2150..f4375deabfa3 100644
> --- a/tools/perf/builtin.h
> +++ b/tools/perf/builtin.h
> @@ -2,8 +2,10 @@
>  #ifndef BUILTIN_H
>  #define BUILTIN_H
>  
> +struct cmdnames;
> +
>  void list_common_cmds_help(void);
> -const char *help_unknown_cmd(const char *cmd);
> +const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds);
>  
>  int cmd_annotate(int argc, const char **argv);
>  int cmd_bench(int argc, const char **argv);
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 921bee0a6437..c719e6ccd9e2 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -18,6 +18,7 @@
>  #include <subcmd/run-command.h>
>  #include "util/parse-events.h"
>  #include <subcmd/parse-options.h>
> +#include <subcmd/help.h>
>  #include "util/debug.h"
>  #include "util/event.h"
>  #include "util/util.h" // usage()
> @@ -557,7 +558,7 @@ int main(int argc, const char **argv)
>  	pthread__block_sigwinch();
>  
>  	while (1) {
> -		static int done_help;
> +		int done_help;
>  
>  		run_argv(&argc, &argv);
>  
> @@ -565,14 +566,26 @@ int main(int argc, const char **argv)
>  			break;
>  
>  		if (!done_help) {
> -			cmd = argv[0] = help_unknown_cmd(cmd);
> +			struct cmdnames main_cmds;
> +
> +			for (unsigned int i = 0; i < ARRAY_SIZE(commands); i++) {
> +				add_cmdname(&main_cmds,
> +					    commands[i].cmd,
> +					    strlen(commands[i].cmd));
> +			}
> +			cmd = argv[0] = help_unknown_cmd(cmd, &main_cmds);
> +			clean_cmdnames(&main_cmds);
>  			done_help = 1;
> +			if (!cmd)
> +				break;
>  		} else
>  			break;
>  	}
>  
> -	fprintf(stderr, "Failed to run command '%s': %s\n",
> -		cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
> +	if (cmd) {
> +		fprintf(stderr, "Failed to run command '%s': %s\n",
> +			cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
> +	}
>  out:
>  	if (debug_fp)
>  		fclose(debug_fp);
> diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
> index eab99ea6ac01..2ba3369f1620 100644
> --- a/tools/perf/util/help-unknown-cmd.c
> +++ b/tools/perf/util/help-unknown-cmd.c
> @@ -52,46 +52,44 @@ static int add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
>  	return 0;
>  }
>  
> -const char *help_unknown_cmd(const char *cmd)
> +const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds)
>  {
>  	unsigned int i, n = 0, best_similarity = 0;
> -	struct cmdnames main_cmds, other_cmds;
> +	struct cmdnames other_cmds;
>  
> -	memset(&main_cmds, 0, sizeof(main_cmds));
> -	memset(&other_cmds, 0, sizeof(main_cmds));
> +	memset(&other_cmds, 0, sizeof(other_cmds));
>  
>  	perf_config(perf_unknown_cmd_config, NULL);
>  
> -	load_command_list("perf-", &main_cmds, &other_cmds);
> +	load_command_list("perf-", main_cmds, &other_cmds);
>  
> -	if (add_cmd_list(&main_cmds, &other_cmds) < 0) {
> +	if (add_cmd_list(main_cmds, &other_cmds) < 0) {
>  		fprintf(stderr, "ERROR: Failed to allocate command list for unknown command.\n");
>  		goto end;
>  	}
> -	qsort(main_cmds.names, main_cmds.cnt,
> -	      sizeof(main_cmds.names), cmdname_compare);
> -	uniq(&main_cmds);
> +	qsort(main_cmds->names, main_cmds->cnt,
> +	      sizeof(main_cmds->names), cmdname_compare);
> +	uniq(main_cmds);
>  
> -	if (main_cmds.cnt) {
> +	if (main_cmds->cnt) {
>  		/* This reuses cmdname->len for similarity index */
> -		for (i = 0; i < main_cmds.cnt; ++i)
> -			main_cmds.names[i]->len =
> -				levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
> +		for (i = 0; i < main_cmds->cnt; ++i)
> +			main_cmds->names[i]->len =
> +				levenshtein(cmd, main_cmds->names[i]->name, 0, 2, 1, 4);
>  
> -		qsort(main_cmds.names, main_cmds.cnt,
> -		      sizeof(*main_cmds.names), levenshtein_compare);
> +		qsort(main_cmds->names, main_cmds->cnt,
> +		      sizeof(*main_cmds->names), levenshtein_compare);
>  
> -		best_similarity = main_cmds.names[0]->len;
> +		best_similarity = main_cmds->names[0]->len;
>  		n = 1;
> -		while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
> +		while (n < main_cmds->cnt && best_similarity == main_cmds->names[n]->len)
>  			++n;
>  	}
>  
>  	if (autocorrect && n == 1) {
> -		const char *assumed = main_cmds.names[0]->name;
> +		const char *assumed = main_cmds->names[0]->name;
>  
> -		main_cmds.names[0] = NULL;
> -		clean_cmdnames(&main_cmds);
> +		main_cmds->names[0] = NULL;
>  		clean_cmdnames(&other_cmds);
>  		fprintf(stderr, "WARNING: You called a perf program named '%s', "
>  			"which does not exist.\n"
> @@ -107,15 +105,14 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  	fprintf(stderr, "perf: '%s' is not a perf-command. See 'perf --help'.\n", cmd);
>  
> -	if (main_cmds.cnt && best_similarity < 6) {
> +	if (main_cmds->cnt && best_similarity < 6) {
>  		fprintf(stderr, "\nDid you mean %s?\n",
>  			n < 2 ? "this": "one of these");
>  
>  		for (i = 0; i < n; i++)
> -			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
> +			fprintf(stderr, "\t%s\n", main_cmds->names[i]->name);
>  	}
>  end:
> -	clean_cmdnames(&main_cmds);
>  	clean_cmdnames(&other_cmds);
> -	exit(1);
> +	return NULL;
>  }
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

