Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA2792D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbjIESZ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjIESZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:25:58 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F227619B;
        Tue,  5 Sep 2023 11:25:29 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-794c7d95ba5so108709739f.0;
        Tue, 05 Sep 2023 11:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693938206; x=1694543006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxX1X1j/fywNnxeJETa5SKqpVl9n1CDPD3uaNFdTeIA=;
        b=TEZt/mpaxP4o6Da8zI0NcwUXxdzD0C9ZTo963yVTAUJ9PsY62KZKlqGhDkGxnAe5NV
         Xq02n5o69LIQXokDkp1bw3uEVhFE1C94Dk13uRTsZ4EraPO6eAyTzp2uctMAJe/RB09A
         p6Vh1iADG+UBdJ0v0kA/gpEbdbscVzEEqNzHlSwoJsYrOGHzsEq/68/z/S1Dddb8cBvz
         sxF56xF4j6OzIINGPV5gXVRut9kEFVkZiTzt6bBJ/o6eZGgLV6LTpg7Em0t8tnikaEgx
         lfC8/88hKv+JLmgYuRrr1HIuvSw5JAH56w9j2yGtLIvOltAhyyB/AxnzRFlMuE38Cwvn
         LoTw==
X-Gm-Message-State: AOJu0YzN3v2C/GkaG7S8W1YqpDsSZgGodcMUoo/LQuumvx2Z3Gj80vFR
        b+DIkiroB2YPX5yBPbJcSksbLXZ2iiMd7+Zuhbg=
X-Google-Smtp-Source: AGHT+IFdsXyewg79sxgJDZU3WEmPZE1K/300agF+YggqNZmuovlyZ8d3WuM3D9CJ2I8K5RL1OfzEVcpjiW6WY+XMcg0=
X-Received: by 2002:a5e:a713:0:b0:78b:b892:e334 with SMTP id
 b19-20020a5ea713000000b0078bb892e334mr14957651iod.11.1693938206573; Tue, 05
 Sep 2023 11:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230905181554.3202873-1-irogers@google.com> <20230905181554.3202873-2-irogers@google.com>
In-Reply-To: <20230905181554.3202873-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Sep 2023 11:23:15 -0700
Message-ID: <CAM9d7ci-MZsJFKOtk2YebJSmarbkO_zaAmVgug8Ymbi6sev-QQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf completion: Support completion of libpfm4 events
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
> Use `perf list --raw-dump pfm` to support completion of libpfm4 events.
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
> index 40cfc30ad7ad..319ad724b97a 100644
> --- a/tools/perf/perf-completion.sh
> +++ b/tools/perf/perf-completion.sh
> @@ -198,6 +198,10 @@ __perf_main ()
>                 else
>                         __perfcomp_colon "$evts" "$cur1"
>                 fi
> +       elif [[ $prev == @("--pfm-events") &&
> +               $prev_skip_opts == @(record|stat|top) ]]; then
> +               local evts=$($cmd list --raw-dump pfm)
> +               __perfcomp "$evts" "$cur"
>         else
>                 # List subcommands for perf commands
>                 if [[ $prev_skip_opts == @(kvm|kmem|mem|lock|sched|
> --
> 2.42.0.283.g2d96d420d3-goog
>
