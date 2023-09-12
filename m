Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC179C667
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjILGAx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 02:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjILGAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:00:52 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AB5AF;
        Mon, 11 Sep 2023 23:00:48 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d80089712e5so6199951276.1;
        Mon, 11 Sep 2023 23:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498448; x=1695103248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUILU1E0+FdlFdLUANe6gniGaPM89l1IGPrpgMyRN5I=;
        b=IRltfIMM1TXrcViGkNG/VK96IsT8nn517HsTaBAcVNPZhllEPrcf5LpVyrV/16Ejb6
         0Zo39/6wnk59EIQKH4ys6UGC4QNP9YB/5pLtLQkQskPVWYUBhtWglNJB8kz+uMbIT/4Q
         I3qm401yQCQN6rRVbmO/iasgbO3/LDhaS+GtlROGx2JPACVdDAkCEzOAcRc3B7TuUsS1
         /5da9rKMNpSKgqCE6vVDd41NgR6cgGxN8oslTgAN+v1RLSRPjbtZsN/BCu/txU3xk49u
         wLF3QkXD/WVLedc2CdezxKcGGP4hqhRnvqKMFH2TiiFdXzeqUjynYQ5SZYeDiCGnCkAf
         OmZA==
X-Gm-Message-State: AOJu0Yzor37LZBmzTkYR9Nc1wza50RF/2dgkX7k/7V4sWeVUKiCa1H7p
        zTaW9/70N0oP5GihcozBs2a4DV6zZM6nVY6+RSYb22S2hk0=
X-Google-Smtp-Source: AGHT+IF/lQdOP9qBizGBb21/Z1f2teVHR7FJHFpnrBDMARdoZAr7FlCDkEC5rQJErcxnOmRKhjLH+VTclPBLLqIxCAI=
X-Received: by 2002:a25:dc11:0:b0:d09:22c0:138d with SMTP id
 y17-20020a25dc11000000b00d0922c0138dmr2062829ybe.7.1694498447808; Mon, 11 Sep
 2023 23:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com> <20230911170559.4037734-5-irogers@google.com>
In-Reply-To: <20230911170559.4037734-5-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 11 Sep 2023 23:00:36 -0700
Message-ID: <CAM9d7cjj9V+tmrF_=8YgnxiLVGcGYKLZ-4pNgEgQM+3XSCHrsQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf bpf-filter: Add YYDEBUG
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:06 AM Ian Rogers <irogers@google.com> wrote:
>
> YYDEBUG enables line numbers and other error helpers in the generated
> bpf-filter-bison.c. Conditionally enabled only for debug builds.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/bpf-filter.y | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
> index 5dfa948fc986..0e4d6de3c2ad 100644
> --- a/tools/perf/util/bpf-filter.y
> +++ b/tools/perf/util/bpf-filter.y
> @@ -3,6 +3,10 @@
>
>  %{
>
> +#ifndef NDEBUG
> +#define YYDEBUG 1
> +#endif
> +
>  #include <stdio.h>
>  #include <string.h>
>  #include <linux/compiler.h>
> --
> 2.42.0.283.g2d96d420d3-goog
>
