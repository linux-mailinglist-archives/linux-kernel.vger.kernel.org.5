Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1628479C65C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjILF6g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 01:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjILF6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:58:34 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A2E6F;
        Mon, 11 Sep 2023 22:58:30 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d776e1f181bso4550363276.3;
        Mon, 11 Sep 2023 22:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498309; x=1695103109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzNC+0OhuunUarOHTZE8fkSETZJ/UvD+n1Tp93c3ctM=;
        b=GYKTrGyW5Iz4sVTwCK/xif4HvPFXCwSDU3/9D+7bq68HGYDfzvSfTFsbf+jSTSbsaA
         COKC6otVZ739Q3vRv1Yp6JEpgKcJlKpAnBCdNDVhUCCyURWz50p6YrK3OOGrxyQqAefW
         Cxj5Y3OU7Di/w4G5O9iUBsnj7KJt1y+dw7Llmp6NITFVuru1rPlt85foep1w/hUxXmZ/
         uWg1cB+OuVwe44EL+aiBFgAAgH/eai8TxLa9zfwm/QttTycvjLV58+ATBlbn5ujwHYj4
         u4Bp0mfb3FelAj0YqEfeSiN46GweJuyScqM+qYmdwCT2M+XcC6n08kWLw1dUbzxOk3Rl
         Pmpw==
X-Gm-Message-State: AOJu0YyXTuPehnKkuYqynt44M0Vxezfh/dNtFScnn/ya0TdI4fJrnSug
        7OR6/liVjKKWBJV46JC98IpbwydyqGQ/YNzPtjOKtqIO
X-Google-Smtp-Source: AGHT+IGqk2pHdFI97hJjtxdveBCMtzd46ihdDOdI5NFuC2aGoVGOHFQcmDZVzP8sL9zzjHf3Mv01sD/ZXnUL4OTKTLw=
X-Received: by 2002:a25:cc4c:0:b0:d7f:374b:638c with SMTP id
 l73-20020a25cc4c000000b00d7f374b638cmr12389850ybf.14.1694498309407; Mon, 11
 Sep 2023 22:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 11 Sep 2023 22:58:18 -0700
Message-ID: <CAM9d7cg4nc5rpW9jL-RPJP7w4Rg8h7t4A-EkHTE9rWF=Nm6bBQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] perf parse-events: Remove unused header files
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
> The fnmatch header is now used in the PMU matching logic in pmu.c.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/parse-events.y | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 21bfe7e0d944..ef03728b7ea3 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -9,11 +9,8 @@
>  #define YYDEBUG 1
>
>  #include <errno.h>
> -#include <fnmatch.h>
> -#include <stdio.h>
>  #include <linux/compiler.h>
>  #include <linux/types.h>
> -#include <linux/zalloc.h>
>  #include "pmu.h"
>  #include "pmus.h"
>  #include "evsel.h"
> --
> 2.42.0.283.g2d96d420d3-goog
>
