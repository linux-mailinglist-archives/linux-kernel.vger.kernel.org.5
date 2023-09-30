Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4A7B3EAC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 08:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjI3GkQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Sep 2023 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjI3GkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 02:40:15 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD761B3;
        Fri, 29 Sep 2023 23:40:12 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-79fe6da0049so232738839f.1;
        Fri, 29 Sep 2023 23:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696056012; x=1696660812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgPppTpqKHjIbGMNvaSNbWXYlqW19K3ehBgJFQ3TzbI=;
        b=jRji9rgcUM9DdvkhPeHlVX4V2Un5V5NfIRiN5sM1Do7ynsFY9WdTZgmpu4DfBKV7VG
         EpNJLcGDnK8C/6yxniv4yWhUOsOttMea1uTa5j8oLIvxtBdwT+jTZcwZLIgIPcRs16MK
         4+pzVT4VLNtb3XE7ImxHvsU6nS0uhSFcy7nk7MMOU6ZIuACOqkTsqWFk+lQVl4WxQsyv
         54j2Kq1bBbQoWHyX1tECadV2o6r8QWqSZ/pmnCAq/3ziVGEpcimGwNC6KZXDAfNS/xag
         Wuj0hzLGPMuj3WV1ykJXQeTAzbVvcLsschjyWGnR0u3wxLkIlFWC7x4aZ9zK9E39Ub4i
         tuCw==
X-Gm-Message-State: AOJu0YwETtDi/9tbIXepagbMuLSxHXzg/dcCJJHu2vUCULdlvs1CuT7W
        /xhO7ZgqS8X6bdH11GlmOmmEr5vTfmYzZvsE0Ds=
X-Google-Smtp-Source: AGHT+IF7wmfHaApQNhYzN1c6ToWbIKSdWNBZMSrat/9ydm0q45dEjYEwRxSZzqXVo4WkLlKUYv1mGABLJbdavS8gVt0=
X-Received: by 2002:a6b:f207:0:b0:79f:9eb4:3ea1 with SMTP id
 q7-20020a6bf207000000b0079f9eb43ea1mr7041475ioh.3.1696056011798; Fri, 29 Sep
 2023 23:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230928071605.17624-1-adrian.hunter@intel.com>
In-Reply-To: <20230928071605.17624-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 29 Sep 2023 23:40:00 -0700
Message-ID: <CAM9d7ch5yZZU_bY=d+5wkvQDJKCuctabBu3AMuyp4UYRO0upYA@mail.gmail.com>
Subject: Re: [PATCH] perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_code()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Sep 28, 2023 at 12:16 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Stop calling addr_location__exit() when addr_location__init() was not
> called.
>
> Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/dlfilter.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index 1dbf27822ee2..4a1dc21b0450 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -282,13 +282,21 @@ static struct perf_event_attr *dlfilter__attr(void *ctx)
>         return &d->evsel->core.attr;
>  }
>
> +static __s32 code_read(__u64 ip, struct map *map, struct machine *machine, void *buf, __u32 len)
> +{
> +       u64 offset = map__map_ip(map, ip);
> +
> +       if (ip + len >= map__end(map))
> +               len = map__end(map) - ip;
> +
> +       return dso__data_read_offset(map__dso(map), machine, offset, buf, len);
> +}
> +
>  static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
>  {
>         struct dlfilter *d = (struct dlfilter *)ctx;
>         struct addr_location *al;
>         struct addr_location a;
> -       struct map *map;
> -       u64 offset;
>         __s32 ret;
>
>         if (!d->ctx_valid)
> @@ -298,27 +306,17 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
>         if (!al)
>                 return -1;
>
> -       map = al->map;
> -
> -       if (map && ip >= map__start(map) && ip < map__end(map) &&
> +       if (al->map && ip >= map__start(al->map) && ip < map__end(al->map) &&
>             machine__kernel_ip(d->machine, ip) == machine__kernel_ip(d->machine, d->sample->ip))
> -               goto have_map;
> +               return code_read(ip, al->map, d->machine, buf, len);
>
>         addr_location__init(&a);
> +
>         thread__find_map_fb(al->thread, d->sample->cpumode, ip, &a);
> -       if (!a.map) {
> -               ret = -1;
> -               goto out;
> -       }
> +       ret = a.map ? code_read(ip, a.map, d->machine, buf, len) : -1;
>
> -       map = a.map;
> -have_map:
> -       offset = map__map_ip(map, ip);
> -       if (ip + len >= map__end(map))
> -               len = map__end(map) - ip;
> -       ret = dso__data_read_offset(map__dso(map), d->machine, offset, buf, len);
> -out:
>         addr_location__exit(&a);
> +
>         return ret;
>  }
>
> --
> 2.34.1
>
