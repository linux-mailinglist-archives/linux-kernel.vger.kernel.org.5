Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7727D763B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjGZPsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjGZPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:48:39 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5711FDA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:48:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40550136e54so408291cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690386517; x=1690991317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut/OLnGvSUcwp0SDm9TE1oM6DEmiwkjd+qReZtNtjNs=;
        b=VsS+2GiOBjBU/fbu4y4kSJp6AV2eQoMCG8HLnqx5YVCQ6dz4wXNHlG/wrkMUWoU+1N
         5NsTHjtRSOeEI7EjrarEoKoSfeUje2rhD6MqK6XOlvSBKxsbBiUo2oMCPDVRRP+wgqam
         OCCg45w5yTGvagFVGfYZ+wyFAOOoX0mH6mt0gis4jrHBVRSanpz1UNksHFElZw2RMJfH
         99uCJc0gi0RmDxn7Euktt6eVzsygxYcASLsE5xndnEPx8WFd/yvibJ7RqtgmUp9TSaoN
         jAbJlkDX6Dwg/rYYKHOcYh8NVLFdrnJ8XFVBpi74jwU7G69V1HHZP6ZkZeUL0UW5cApK
         hm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690386517; x=1690991317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ut/OLnGvSUcwp0SDm9TE1oM6DEmiwkjd+qReZtNtjNs=;
        b=gBrWik+U8qkn64GpknxfCcuRjWnLCWE3Nlb9CxbOs5YyiqFsQsANtTt9FLi9TzcTIg
         nAks0YXTdCFRTb483hIPdR7e12ZdoRIM4FemWoII1iGF052Jp1LldyPdnyV+DOYIoenn
         IDA2EhzymzOpvKX260L9jyu1SXmDM73Cduj5yjAcCPxBxmZa451J4zB90tcCGiVQccC5
         lF7liUznqiIhm5teU7g8uK4IzLClP8bFT+s6PB5dYnowlnNzBaiUhqD8/TqNrLcu5GBO
         H4jQVToLZKwG+tvem50Ms5DV9DCCZQwA1Vj1K3bcotf17+EQJf6tLrOsG4tZLqkNKob4
         LK4g==
X-Gm-Message-State: ABy/qLYlff2PCSVLy635Uudh2/CqECOtS8hZcZaxb7r3Ujmwr2PDNRv+
        47OtIchcBKwvq1hm5gnsIzU97oyMYV90acXHwXlpAw==
X-Google-Smtp-Source: APBJJlFAmkaXOtb8THGu7IQnr+RHR95akaw9tZl1QWkzbkFdkoRezoi/bskARgwANoV0jMaM1qFSCot+pg+R8e2pRCo=
X-Received: by 2002:ac8:7f56:0:b0:405:3a65:b3d6 with SMTP id
 g22-20020ac87f56000000b004053a65b3d6mr509723qtk.13.1690386516582; Wed, 26 Jul
 2023 08:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230726133642.750342-1-namhyung@kernel.org>
In-Reply-To: <20230726133642.750342-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Jul 2023 08:48:24 -0700
Message-ID: <CAP-5=fWM9Fhq5WvsBf2n=hGwwwRDt3-mUQ=_qzu8qYGtD1OeWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf build: Update build rule for generated files
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
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

On Wed, Jul 26, 2023 at 6:36=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The bison and flex generate C files from the source (.y and .l)
> files.  When O=3D option is used, they are saved in a separate directory
> but the default build rule assumes the .C files are in the source
> directory.  So it might read invalid file if there are generated files
> from an old version.  The same is true for the pmu-events files.
>
> For example, the following command would cause a build failure:
>
>   $ git checkout v6.3
>   $ make -C tools/perf  # build in the same directory
>
>   $ git checkout v6.5-rc2
>   $ mkdir build  # create a build directory
>   $ make -C tools/perf O=3Dbuild  # build in a different directory but it
>                                 # refers files in the source directory
>
> Let's update the build rule to specify those cases explicitly to depend
> on the files in the output directory.
>
> Note that it's not a complete fix and it needs the next patch for the
> include path too.
>
> Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/Makefile.build  | 8 ++++++++
>  tools/perf/pmu-events/Build | 4 ++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index 89430338a3d9..f9396696fcbf 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -117,6 +117,14 @@ $(OUTPUT)%.s: %.c FORCE
>         $(call rule_mkdir)
>         $(call if_changed_dep,cc_s_c)
>
> +$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> +       $(call rule_mkdir)
> +       $(call if_changed_dep,$(host)cc_o_c)
> +
> +$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
> +       $(call rule_mkdir)
> +       $(call if_changed_dep,$(host)cc_o_c)
> +

Hi Namhyung,

as we have:
```
$(OUTPUT)%.o: %.c FORCE
       $(call rule_mkdir)
       $(call if_changed_dep,$(host)cc_o_c)
```
I'm not sure what the 2 additional rules achieve.

>  # Gather build data:
>  #   obj-y        - list of build objects
>  #   subdir-y     - list of directories to nest
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 150765f2baee..f38a27765604 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -35,3 +35,7 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(M=
ETRIC_PY) $(METRIC_TEST_L
>         $(call rule_mkdir)
>         $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $=
(JEVENTS_MODEL) pmu-events/arch $@
>  endif
> +
> +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> +       $(call rule_mkdir)
> +       $(call if_changed_dep,$(host)cc_o_c)

If we add this, do the Makefile.build changes still need to happen?

Thanks,
Ian

> --
> 2.41.0.487.g6d72f3e995-goog
>
