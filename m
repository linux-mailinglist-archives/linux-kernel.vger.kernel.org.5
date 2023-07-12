Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0111750FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjGLR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGLR25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:28:57 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22A31BD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:28:55 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401d1d967beso24271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689182935; x=1691774935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf6jn4Tmh6XLNjLqmxZGPisxyJ73A2eJOVy3NQS6PLk=;
        b=gImBrw0t0mlBNIdvg2GkS2g94nraaakeN5+Br49MJyHjrMvlJK5XCtmIDFedMbMdd1
         ujJikBSb04kucgbR5hZkIqpv8jA/t3CMQyLI3K+4QhmH9qGNWSh7w3PpSVGdyYGJoq4G
         0fhFBjjWSJEY6ebihsAmdhf9vk/S1IcqokulaBoFu/OKxrVTUvvazboA0alD6VQwddug
         IKGSr5C8Ot53Js+sFpnigfBxJjmby/JwF0ZQU+nLCFtoru0GpULYlm+Hti5PMMOvbuHh
         uUY/aL8JW0OyCMoLRr3CF3W0Wa6Pz88G+JoaocPc9364U+XPy+DdLnXbWytx/BaVzBFU
         mP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689182935; x=1691774935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jf6jn4Tmh6XLNjLqmxZGPisxyJ73A2eJOVy3NQS6PLk=;
        b=OZzhsFtCDzIA+WViV+dmAsR9nTSkiG/ugK1RnFDQuRMWvmmlVfFXhgSpqlBQ4D39jf
         /18sQGFa/uGE57b01IzVuQ6n20QBWLshkCHiNm/1P3bcA8pYnRwpBH6OGl/ueRY9BEM6
         EugEGquRnOEFwxfL4MppyTWlabMxeUR1mqVfafx9wLLSSiwsZGDrW1aumnG5X18FFzUZ
         CRc9sFZoWLN+6UDjCFwd7ORUftcCDZw//KPoZNVwnwafUIPqJvBhw29PsovKvCHjNMDQ
         rceTR6k+WPLl6P0RrW4T6AhF0yAsZ3RNCAlgdmJ0P8GHJDLUH8KuG6KYUnsSKRY2BjVg
         9PAQ==
X-Gm-Message-State: ABy/qLanmbBlFTQpwdaj8yD/8C+VBMwO/VJSoiRvbMBd8drQtPec7hGv
        EqzQtaJ9skWdz/IVl0JiZOjWF/DC8Kvyn2GHo2CX5A==
X-Google-Smtp-Source: APBJJlFiEd58mMKPb53D3NFQACKs9rJ08QTBvtKayfJE2Kg/fvO/VuY1W/RjrtlNPXdR7s0pQ4k5iqg4njFJFhYd770=
X-Received: by 2002:ac8:5e0d:0:b0:3ed:6bde:9681 with SMTP id
 h13-20020ac85e0d000000b003ed6bde9681mr344009qtx.0.1689182934850; Wed, 12 Jul
 2023 10:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <11543b39f97a7e2f9eac76c1233f1b1caa3f2c48.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <11543b39f97a7e2f9eac76c1233f1b1caa3f2c48.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:28:42 -0700
Message-ID: <CAP-5=fXT3a4JE6u8zXf3=xFbOGTre3WD63SMPrA_iSVpgHjDVA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] scripts: python: Add trace end processing and JSON output
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:13=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> Inside the trace end function the final output will be dumped
> to standard output in JSON gecko format. Additionally, constants
> such as USER_CATEGORY_INDEX, KERNEL_CATEGORY_INDEX, CATEGORIES, and
> PRODUCT are defined to provide contextual information.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  .../scripts/python/firefox-gecko-converter.py | 34 ++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> index 0b8a86bdcab1..39818a603265 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -24,8 +24,40 @@ from Core import *
>  thread_map =3D {}
>  start_time =3D None
>
> +# Follow Brendan Gregg's Flamegraph convention: orange for kernel and ye=
llow for user
> +CATEGORIES =3D [
> +    {'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> +    {'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> +]

A follow up could be to make these command line options, defaulting to
orange and yellow.

Thanks,
Ian

> +
> +# The product name is used by the profiler UI to show the Operating syst=
em and Processor.
> +PRODUCT =3D os.popen('uname -op').read().strip()
> +
>  def trace_end():
> -       pass
> +    thread_array =3D thread_map.values()))
> +
> +    result =3D {
> +        'meta': {
> +            'interval': 1,
> +            'processType': 0,
> +            'product': PRODUCT,
> +            'stackwalk': 1,
> +            'debug': 0,
> +            'gcpoison': 0,
> +            'asyncstack': 1,
> +            'startTime': start_time,
> +            'shutdownTime': None,
> +            'version': 24,
> +            'presymbolicated': True,
> +            'categories': CATEGORIES,
> +            'markerSchema': []
> +            },
> +        'libs': [],
> +        'threads': thread_array,
> +        'processes': [],
> +        'pausedRanges': []
> +    }
> +    json.dump(result, sys.stdout, indent=3D2)
>
>  def process_event(param_dict):
>         global start_time
> --
> 2.34.1
>
