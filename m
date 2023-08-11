Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C5778DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjHKLgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B8626A6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329226401E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12872C433C7;
        Fri, 11 Aug 2023 11:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691753774;
        bh=xRu+pR8rNM6P/49jAfekeDEB6v+U7lfnBNFrWdKQ8xU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WMEguqU633ytuCCNaO42JVU6J9ebH6yLc90Uh355xyEGATJH9LtqwcGwfRdicXrsD
         zsCQE2WlBhtJt/LA1ErDINBKmxic25DgTwHt+lmsR8auQgqW/Da0n7SRNQ/Li+Cxdj
         ZGCcc3qKaIHyT9mNm5r0fsjWRYQybIozs3GT1+fDpWfOfarWAqxZ3NALe5fmR/lLaK
         VPRY6yQW6JbzPl7W+6tbiZQbBr+RKR0p2JqatA9c+mf3FDLlPLlAOI6/2aP+tNr5D7
         3MuE/qs4185GJQEcxi1GtaQLaPw5Ij/PI0bUnqXRnuEbebU8df/P2gkqUAk8hwtIOo
         gbT0xFwbxKcHg==
Date:   Fri, 11 Aug 2023 20:36:10 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf probe: Make synthesize_perf_probe_point()
 private to probe-event.c
Message-Id: <20230811203610.0b14078452d97058a1f2a7c0@kernel.org>
In-Reply-To: <ZM0pjfOe6R4X/cql@kernel.org>
References: <ZM0pjfOe6R4X/cql@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 13:38:37 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Not used in any other place, so just make it static.
> 

Looks good to me. 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/probe-event.c | 4 +++-
>  tools/perf/util/probe-event.h | 1 -
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 2835d87cb97771f9..1a5b7fa459b23204 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -53,6 +53,8 @@
>  bool probe_event_dry_run;	/* Dry run flag */
>  struct probe_conf probe_conf = { .magic_num = DEFAULT_PROBE_MAGIC_NUM };
>  
> +static char *synthesize_perf_probe_point(struct perf_probe_point *pp);
> +
>  #define semantic_error(msg ...) pr_err("Semantic error :" msg)
>  
>  int e_snprintf(char *str, size_t size, const char *format, ...)
> @@ -2010,7 +2012,7 @@ char *synthesize_perf_probe_arg(struct perf_probe_arg *pa)
>  }
>  
>  /* Compose only probe point (not argument) */
> -char *synthesize_perf_probe_point(struct perf_probe_point *pp)
> +static char *synthesize_perf_probe_point(struct perf_probe_point *pp)
>  {
>  	struct strbuf buf;
>  	char *tmp, *ret = NULL;
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 8ad5b1579f1d37b6..7e3b6c3d1f7447a7 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -137,7 +137,6 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev);
>  char *synthesize_perf_probe_command(struct perf_probe_event *pev);
>  char *synthesize_probe_trace_command(struct probe_trace_event *tev);
>  char *synthesize_perf_probe_arg(struct perf_probe_arg *pa);
> -char *synthesize_perf_probe_point(struct perf_probe_point *pp);
>  
>  int perf_probe_event__copy(struct perf_probe_event *dst,
>  			   struct perf_probe_event *src);
> -- 
> 2.37.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
