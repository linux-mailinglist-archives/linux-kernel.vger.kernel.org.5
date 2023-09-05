Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAEA792D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjIES0N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjIES0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:26:12 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261BFCF9;
        Tue,  5 Sep 2023 11:25:41 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-794e0e8b588so127460739f.1;
        Tue, 05 Sep 2023 11:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693938220; x=1694543020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHEnGqxw8d4wb+1Vk/P+WvuthLFK4N5sRk7D0hL/o58=;
        b=S9g4I4xgRzogTOQFlMVzwfa/PAIIDLIw649TMGTBrmsmDffZi9JX6HtgYyg+J4inDj
         EfeQ7LD9OLlnUYseLUSZHWHkRWoekS5ZTnU61YtIzAI9PkQ65XQhNmaSaDX6xKFuV9iB
         enOruLYn3rIBm7XMdnVdUprSclmIqeOUrhk6GKF1lJV7+qLYbiSyYI8RXqKnBe4PVQbN
         USaWKRt41XRCCXYAu6Aic7mE2Z1Jdg1aPs6buhXSy3TQmztwWqfohH1hDonTFDUKhcOY
         s/buOeOKmjN4wjVEKRTGhAaSrUMbQ4XfLB7f/hakM43Pd0ZbOMlnC8AjBPu6+vHQTGwi
         26+Q==
X-Gm-Message-State: AOJu0Yx8bfbNA12lyncVjH3kICTPNSwFiSXM1paoh1NjzoVr/RYdIsR/
        xtxqX/yNEIsVCvR9NHKVnAxggvcNA7WZBDh+RaU=
X-Google-Smtp-Source: AGHT+IFEwGLfzplztPrYG3JDLWzONm1qK6Opfb76y8YjayHkuDO5ECFC3Z5goRWcyza2o5g0ZP4LOZyRF8UYj5yg1tw=
X-Received: by 2002:a5e:8f06:0:b0:787:1472:3181 with SMTP id
 c6-20020a5e8f06000000b0078714723181mr15644419iok.3.1693938219833; Tue, 05 Sep
 2023 11:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230905181554.3202873-1-irogers@google.com> <20230905181554.3202873-3-irogers@google.com>
In-Reply-To: <20230905181554.3202873-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Sep 2023 11:23:28 -0700
Message-ID: <CAM9d7cjFSBJV0H4Ai=oHA6CzdyACpoTyrq+LSuTfTJJfvkgndQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] perf completion: Support completion of metrics/metricgroups
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 11:16 AM Ian Rogers <irogers@google.com> wrote:
>
> Allow metrics to expand for -M or --metrics options.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/perf-completion.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
> index 319ad724b97a..f224d79b89e6 100644
> --- a/tools/perf/perf-completion.sh
> +++ b/tools/perf/perf-completion.sh
> @@ -202,6 +202,10 @@ __perf_main ()
>                 $prev_skip_opts == @(record|stat|top) ]]; then
>                 local evts=$($cmd list --raw-dump pfm)
>                 __perfcomp "$evts" "$cur"
> +       elif [[ $prev == @("-M"|"--metrics") &&
> +               $prev_skip_opts == @(stat) ]]; then
> +               local metrics=$($cmd list --raw-dump metric metricgroup)
> +               __perfcomp "$metrics" "$cur"
>         else
>                 # List subcommands for perf commands
>                 if [[ $prev_skip_opts == @(kvm|kmem|mem|lock|sched|
> --
> 2.42.0.283.g2d96d420d3-goog
>
