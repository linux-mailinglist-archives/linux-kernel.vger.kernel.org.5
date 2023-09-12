Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DCD79C665
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjILGAj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 02:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjILGAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:00:38 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA46E6F;
        Mon, 11 Sep 2023 23:00:34 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7260fae148so4720990276.1;
        Mon, 11 Sep 2023 23:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498433; x=1695103233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDoTwLrmKoaof/JBEdXQtP7jXktkcDfzwol6kevEdW8=;
        b=IarhDHeF7n5n70eyxZKmlYaKBBcGoWyf0ELfvDj26eLkp+CHXP53hqrf/JyXjDtCsB
         6/H9YrTWiGn6sLeBHUG0za/rWEqpXxHIDzD1G+h9dEXQNc86DBAODbj8KSeQb8FUFHHU
         QBR+oD6GsHPz124Ol6zJnTOjEKT6iFyyTN1I91OINV0q5ePaS0DKuMpu//FnbG8BuvQ4
         2q1O/NiQOrLe8Hpy54hMq2n5NblVl3v7rr3nWT6Y91Bdz1brGwPTc4eCurHGfLRCJ2kZ
         0BpYgyr6sxBmFkcBAj7+s8kCt199tCfxbOi/Ii5wFctNBY79JFMeOvniWQyTc+mjqddZ
         pqPg==
X-Gm-Message-State: AOJu0YyxDQr2SZIj17+8juhl1+DFvvuRmFqY5iVQdOGApugJQc+6zXk3
        /fB+mK9DpZqr7WsNQ0RJLWmf11SZ4zstv0iJyMw=
X-Google-Smtp-Source: AGHT+IEeQqeGHD5ch9foXElxvq/LQHou9Bk52NTpKY74rsmw/sFu7nNbCODY6AX5F8jHKO87v6ruNzIC/O+pWfwD758=
X-Received: by 2002:a25:ab33:0:b0:d05:59cd:a89d with SMTP id
 u48-20020a25ab33000000b00d0559cda89dmr11590307ybi.30.1694498433253; Mon, 11
 Sep 2023 23:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com> <20230911170559.4037734-4-irogers@google.com>
In-Reply-To: <20230911170559.4037734-4-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 11 Sep 2023 23:00:22 -0700
Message-ID: <CAM9d7ciY9Od8mLg7Qd2cy+RObH5dCKRe3A-DzVt66QWgzDfdKQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf pmu: Add YYDEBUG
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
> pmu-bison.c. Conditionally enabled only for debug builds.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/pmu.y | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> index 600c8c158c8e..198907a8a48a 100644
> --- a/tools/perf/util/pmu.y
> +++ b/tools/perf/util/pmu.y
> @@ -5,6 +5,10 @@
>
>  %{
>
> +#ifndef NDEBUG
> +#define YYDEBUG 1
> +#endif
> +
>  #include <linux/compiler.h>
>  #include <linux/list.h>
>  #include <linux/bitmap.h>
> --
> 2.42.0.283.g2d96d420d3-goog
>
