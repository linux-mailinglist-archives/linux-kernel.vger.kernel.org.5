Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2B79C660
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjILGAD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 02:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjILGAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:00:02 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F085E6F;
        Mon, 11 Sep 2023 22:59:59 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5925e580e87so50235047b3.1;
        Mon, 11 Sep 2023 22:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498398; x=1695103198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUW3PBCAleAS9w3cdUEQTVpKbtiKssCpvnhKjHCXuM8=;
        b=TUD0VYPmgDvbLI0gy6/dWoxe8BmOlSNbLV2Db504Nkrc5zvXSrRNt4mbQompyEu7vY
         JY3Sh3+r9pjBzCIu3/znl3nBO32J/kLqz1U8RQpfN+dA6ttkO2a836AmAwubfjgmA1cm
         +Toghc1M5Uf2ubmN1Hz0jeOLUIOzZk4CAZnUCr+goBfiG21kr4lw3cyY1P4ys3fJ4Lpr
         Ocn8SCBD1F9qpyDHXnbI+H9JNFaUVJRyvz36jiJ8++q7IDxn0dnoWVzNsJyenr9tY5BH
         fVzAPESn7NSD6NkxxC1D6WtRiO8qi0AlKEaV4u9tew6VDHNoDP1FMnm5kBXeNODGOl9l
         8Azg==
X-Gm-Message-State: AOJu0YyxioXJ5gFJ2+VI0AuZaYisQRKsnTLGt354IsFCmIMnAvp/6AKm
        78CmIhgsSyFPeVz2jl48+HkaE234BA1O79e8ljg=
X-Google-Smtp-Source: AGHT+IEoHNMCHJZyv/uNV5Dj5rKhAEBidmiXQtHUVx5URAcQAqVPTLI/nlQs96VcgrF5crO5El6mX65aKktVUU0Xaec=
X-Received: by 2002:a25:a403:0:b0:d77:ff96:66ae with SMTP id
 f3-20020a25a403000000b00d77ff9666aemr9403254ybi.50.1694498398172; Mon, 11 Sep
 2023 22:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com> <20230911170559.4037734-2-irogers@google.com>
In-Reply-To: <20230911170559.4037734-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 11 Sep 2023 22:59:47 -0700
Message-ID: <CAM9d7cjDnATz-U60DiZr24rMZ-RPgOdf84Et_1XPwSE4qyk8ag@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] perf parse-events: Make YYDEBUG dependent on doing
 a debug build
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
> parse-events-bison.c. These shouldn't be generated when debugging
> isn't enabled.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/parse-events.y | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index ef03728b7ea3..786393106ae6 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -6,7 +6,9 @@
>
>  %{
>
> +#ifndef NDEBUG
>  #define YYDEBUG 1
> +#endif
>
>  #include <errno.h>
>  #include <linux/compiler.h>
> --
> 2.42.0.283.g2d96d420d3-goog
>
