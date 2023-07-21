Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BFC75CA68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGUOoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGUOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:44:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11F30C4;
        Fri, 21 Jul 2023 07:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF63461CB8;
        Fri, 21 Jul 2023 14:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653C2C433C8;
        Fri, 21 Jul 2023 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689950642;
        bh=TEmnsWmXJDUs/JVBHZ1mm0YYVwodKZrB/M5+cGLFQSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ff2bfvQPYK3WN0eWpu7T2UKzfeJr2bzFGQxDpiQZ0fRjVznK3erjY1q6B8hxx4lYh
         LeyACy60yUzdqJgjVOnnf/niMMTsCoylFMJK6VfdeAqVd0VdaDFhZjGIemImOXUM7l
         dzmm4Tjnus4jMwVOgh93PSTcp+7seP7+2STiwsm83AmBDMHpY98BCu+U/Qn8XhUFRG
         BgVz1rsPOA44KAG2xm+efmIwoh2FPUdtVAaxg/UwpFObnM1grgnh8dIL1ORaVMPISX
         qp3G0XpELX7LA1f2H5DPbyIMl+oe9QIvdRH9wYT/doahGagoWYXANv10wgrygEQn62
         rC9dubqze14Nw==
Date:   Fri, 21 Jul 2023 23:43:55 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andre Fredette <anfredet@redhat.com>,
        Dave Tucker <datucker@redhat.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/5] perf bench uprobe: Print diff to baseline
Message-Id: <20230721234355.b0a7ae245a2010d4a5c08a52@kernel.org>
In-Reply-To: <20230719204910.539044-3-acme@kernel.org>
References: <20230719204910.539044-1-acme@kernel.org>
        <20230719204910.539044-3-acme@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 17:49:07 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> This is just prep work to show the diff to the unmodified workload.

Looks good to me, just one comment below.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andre Fredette <anfredet@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Dave Tucker <datucker@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/bench/uprobe.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
> index 707174220a76701f..60e7c43298d8cf56 100644
> --- a/tools/perf/bench/uprobe.c
> +++ b/tools/perf/bench/uprobe.c
> @@ -34,6 +34,29 @@ static const char * const bench_uprobe_usage[] = {
>  	NULL
>  };
>  
> +static int bench_uprobe_format__default_fprintf(const char *name, const char *unit, u64 diff, FILE *fp)
> +{
> +	static u64 baseline;
> +	s64 diff_to_baseline = diff - baseline;
> +	int printed = fprintf(fp, "# Executed %'d %s calls\n", loops, name);
> +
> +	printed += fprintf(fp, " %14s: %'" PRIu64 " %ss", "Total time", diff, unit);
> +
> +	if (baseline)
> +		printed += fprintf(fp, " %s%'" PRId64 " to baseline", diff_to_baseline > 0 ? "+" : "", diff_to_baseline);
> +
> +	printed += fprintf(fp, "\n\n %'.3f %ss/op", (double)diff / (double)loops, unit);

Just a nit, do we need to repeat (double) cast on the denominator side too?

> +
> +	if (baseline)
> +		printed += fprintf(fp, " %'.3f %ss/op to baseline", (double)diff_to_baseline / (double)loops, unit);
> +	else
> +		baseline = diff;
> +
> +	fputc('\n', fp);
> +
> +	return printed + 1;
> +}
> +
>  static int bench_uprobe(int argc, const char **argv)
>  {
>  	const char *name = "usleep(1000)", *unit = "usec";
> @@ -56,9 +79,7 @@ static int bench_uprobe(int argc, const char **argv)
>  
>  	switch (bench_format) {
>  	case BENCH_FORMAT_DEFAULT:
> -		printf("# Executed %'d %s calls\n", loops, name);
> -		printf(" %14s: %'" PRIu64 " %ss\n\n", "Total time", diff, unit);
> -		printf(" %'.3f %ss/op\n", (double)diff / (double)loops, unit);
> +		bench_uprobe_format__default_fprintf(name, unit, diff, stdout);
>  		break;
>  
>  	case BENCH_FORMAT_SIMPLE:
> -- 
> 2.41.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
