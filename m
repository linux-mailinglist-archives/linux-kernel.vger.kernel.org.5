Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52E7A9005
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjIUACl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUACk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:02:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6AC83
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:02:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414ba610766so204481cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695254553; x=1695859353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6HEO0H3o1+RAwm8QmL0zjdZlLfQpbik9NYH5igrRNU=;
        b=nXHPJb2Iwt6N/HapTWoA0frXSIPZV+xRODm159030NlcS/JVxhTCK63WjiqdouBfd1
         TcsX5fXaLlqdnhY09E3QNst/6Sv4prDYQ2B34QgU3yfewoeqSdRoXhdc99/NyKn+4cMr
         Sa2NGnJqYxSHdCxDnWARKEjFrMGqBxUOFOGmLJbfhaaDF+OduFiymH0/0wBi3c/z/3w8
         kjAd5FgREye0e5tiMxMR7ffy/FQG/ASN2H7F91SdFhvNu2U7dVGKqHvnPt0lsVHXHCFd
         zYXRW7d6ch36rKEXCpHCgl/Et32voJbthcoqldLEFHssbK8ysRNIQGLu+99Tsa8FGiGR
         dT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695254553; x=1695859353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6HEO0H3o1+RAwm8QmL0zjdZlLfQpbik9NYH5igrRNU=;
        b=DFofyz02Q4J+9BccP5dGCIshTDWZmqjhBMKToRKD0kkZW0XgtA6mpXVCyRtE7OP+Rt
         pEkPKGl+IFeJg9qjxlrVzqj86wLtnetuA13PUWyt9xH2ap1Gtc341vyghXq86bsq5Kd6
         bCanM8/+dXSTafelKMQ4ONQr7Ltj/wqHUQgUYmdWKnf3PGRNxx1HM+GJ859w0dPh3tr3
         Y1LogFb+hxIG2h/UWGyxgxIMk5237nCIxGDrbCASmDYRGDsHc3MdX7RCkoODShIIIW3L
         PWKuQQ5EgEqJ2R9404UkWPMzhZNrdcDW6c+3pSnrYAG/txdba21r886nI94A+gmJIyG3
         pNyw==
X-Gm-Message-State: AOJu0YxP/ETZrNKcmsnrUcxf4okIBLaxdRCJTbP9l8LX0V2s4PuZEJG9
        iSllVKZ21SjC8+cWGFuR4REjB76RA9dD+ucjvmhlZA==
X-Google-Smtp-Source: AGHT+IHo9IeURtDyIKZfA64YeXX+LJ//CkLpVHvMbOZcIbwvGvXveiQdbvrlElgDIHw/lF09OXtDeiKpU1Cgsv8Gb+s=
X-Received: by 2002:a05:622a:34b:b0:417:5a8c:a104 with SMTP id
 r11-20020a05622a034b00b004175a8ca104mr118640qtw.26.1695254553042; Wed, 20 Sep
 2023 17:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230918033623.159213-1-hanchunchao@inspur.com>
In-Reply-To: <20230918033623.159213-1-hanchunchao@inspur.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Sep 2023 17:02:20 -0700
Message-ID: <CAP-5=fWUDgrD-Ehw1hk+L0bYeCVwve+J+=EptgUM4o+GR55YzQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendors events: Remove repeated word in comments
To:     Charles Han <hanchunchao@inspur.com>
Cc:     john.g.garry@oracle.com, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, nick.forrington@arm.com,
        ilkka@os.amperecomputing.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 8:36=E2=80=AFPM Charles Han <hanchunchao@inspur.com=
> wrote:
>
> Remove the repeated word "of" in comments.
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/arm64/mapfile.csv   | 2 +-
>  tools/perf/pmu-events/arch/nds32/mapfile.csv   | 2 +-
>  tools/perf/pmu-events/arch/powerpc/mapfile.csv | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pm=
u-events/arch/arm64/mapfile.csv
> index 32674ddd2b63..5b58db5032c1 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -4,7 +4,7 @@
>  # where
>  #      MIDR    Processor version
>  #              Variant[23:20] and Revision [3:0] should be zero.
> -#      Version could be used to track version of of JSON file
> +#      Version could be used to track version of JSON file
>  #              but currently unused.
>  #      JSON/file/pathname is the path to JSON file, relative
>  #              to tools/perf/pmu-events/arch/arm64/.
> diff --git a/tools/perf/pmu-events/arch/nds32/mapfile.csv b/tools/perf/pm=
u-events/arch/nds32/mapfile.csv
> index efb395f26883..c76e5fbdac23 100644
> --- a/tools/perf/pmu-events/arch/nds32/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/nds32/mapfile.csv
> @@ -4,7 +4,7 @@
>  # where
>  #      MIDR    Processor version
>  #              Variant[23:20] and Revision [3:0] should be zero.
> -#      Version could be used to track version of of JSON file
> +#      Version could be used to track version of JSON file
>  #              but currently unused.
>  #      JSON/file/pathname is the path to JSON file, relative
>  #              to tools/perf/pmu-events/arch/arm64/.
> diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/=
pmu-events/arch/powerpc/mapfile.csv
> index 4abdfc3f9692..a534ff6db14b 100644
> --- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> @@ -3,7 +3,7 @@
>  #
>  # where
>  #      PVR     Processor version
> -#      Version could be used to track version of of JSON file
> +#      Version could be used to track version of JSON file
>  #              but currently unused.
>  #      JSON/file/pathname is the path to JSON file, relative
>  #              to tools/perf/pmu-events/arch/powerpc/.
> --
> 2.31.1
>
