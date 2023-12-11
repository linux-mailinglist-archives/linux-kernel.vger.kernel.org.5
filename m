Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B6580DF95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbjLKXiZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 18:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKXiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:38:22 -0500
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F749CB;
        Mon, 11 Dec 2023 15:38:29 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4569315a12.0;
        Mon, 11 Dec 2023 15:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337909; x=1702942709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHpTfcyEiSTL+Iiy4h09/0w/ff7Mj2tSbGaHW/cYLyA=;
        b=T2Kwi0LCSCwD/ZpCvx58zqth91J+IUDNe5Ys9tf9uYJaAaSpKZ0PMXqEwECQI6sa0E
         5OoT3dhnH0y3Am8DCNtuCCCAq55ho+Aw/ERg98cZLhfvnLp29nAqq28B9R3ylaPryk8x
         dsE4MUOkm1pul/f/oYEfHDokX41fd8l+ISgHathEEO43Uthg5wYcwj2o0h4pmeqdx8qD
         Du4AKHV0HnY7QkYjuPCso8Cuob+zblECT+Lp9mLHzqTbAxG5pw+6OcmrQ14G/jk4Lagl
         LW34/4fqsn2lwf/HD/I2qlAMQ+JSl7ZD1NgUM4kBJAA5R9JL3/DmGL918smqpROV3mMe
         kucA==
X-Gm-Message-State: AOJu0YzgXBwycHTZfHhaFZ3j+hJmuo1DPHJlKwI35zr9ohg7oaYmCJnU
        ZK5HEcXy9NM6IcepJkz5stGZtRnUwvxHWkOndT8=
X-Google-Smtp-Source: AGHT+IG6XeG2QHBItXCy7jlLpitpWE5WDX6fF+j8UTcmkqlO011/5wKWPuqSYXO/CiPnBl4Ca/kyQ+uMui58XQRhKF8=
X-Received: by 2002:a17:90a:5b08:b0:286:9212:a7cf with SMTP id
 o8-20020a17090a5b0800b002869212a7cfmr5765857pji.44.1702337908760; Mon, 11 Dec
 2023 15:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com> <20231207011722.1220634-2-irogers@google.com>
In-Reply-To: <20231207011722.1220634-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 11 Dec 2023 15:38:17 -0800
Message-ID: <CAM9d7cjUVCWpiy0ZsdaWQ5RtrULJSQsggZwz1wJNfeb1kXBwtw@mail.gmail.com>
Subject: Re: [PATCH v6 01/47] perf map: Improve map/unmap parameter names
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 5:17 PM Ian Rogers <irogers@google.com> wrote:
>
> The u64 values are either absolute or relative, try to hint better in
> the parameter names.
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/map.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 3a3b7757da5f..49756716cb13 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -105,25 +105,25 @@ static inline u64 map__dso_map_ip(const struct map *map, u64 ip)
>  }
>
>  /* dso rip -> ip */
> -static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> +static inline u64 map__dso_unmap_ip(const struct map *map, u64 rip)
>  {
> -       return ip + map__start(map) - map__pgoff(map);
> +       return rip + map__start(map) - map__pgoff(map);
>  }
>
> -static inline u64 map__map_ip(const struct map *map, u64 ip)
> +static inline u64 map__map_ip(const struct map *map, u64 ip_or_rip)

I'm afraid it's gonna be more confusing.  Can we say just 'rip'?

>  {
>         if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
> -               return map__dso_map_ip(map, ip);
> +               return map__dso_map_ip(map, ip_or_rip);
>         else
> -               return ip;
> +               return ip_or_rip;
>  }
>
> -static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> +static inline u64 map__unmap_ip(const struct map *map, u64 ip_or_rip)

Ditto.

Thanks,
Namhyung


>  {
>         if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
> -               return map__dso_unmap_ip(map, ip);
> +               return map__dso_unmap_ip(map, ip_or_rip);
>         else
> -               return ip;
> +               return ip_or_rip;
>  }
>
>  /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
