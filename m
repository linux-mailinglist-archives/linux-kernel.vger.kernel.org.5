Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC2759982
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGSPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGSPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:22:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02E19B9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:22:40 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so711421cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689780159; x=1692372159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B72UkkXxSYnbUsFY/YUEO+cQDrOpS7sEr3ObSScgRhE=;
        b=gMU01dt+lLh55R7AX3Hk7+fyFASXNlkl/+3gC3QqhooZOJiNeiOhwYBV6FMfCiCWvJ
         8yBTWf8jCnNXfYAJsZc3HGRQJ+3k3/MFifaij7cbXWeyM1cvDSYy9vqP5qxIzGd3KEZv
         5t8NmerDiBHSV4dIoq+b4b7De2ASocG2xTLEUA9kT5WZjF/Wp0Gyn1qN6RfYff6Bo8IJ
         7OIEGVcVfoyctj9F5uzS8V/VrDouwo2ozfB5BHxFFgYedAYTAl8Dlix5QOCUtquVI/Jq
         jJn5cvrja/GlrF8iR5pBhFCVqHcppVmXDsXiZvy4MNNpMoiqPRooTwKEOfqKcRSgqipX
         QBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780159; x=1692372159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B72UkkXxSYnbUsFY/YUEO+cQDrOpS7sEr3ObSScgRhE=;
        b=YHL98Ltu9nbP8ill2t15lT0AqCc3Stz/uMFTCyrtIZTWjSO2dQQoyK8rRZJO9tOpdE
         zwJhPqWNj97f5ToiN7SJFTm9vHwAfd6juaDuLoAqsV0vvFhfPbkluBHEp4HgiDRnPqXm
         7v1RA6YkpiJCw7GN3bGyEAD0sK0lJuvKmoA/fPS0r9HdgCwfRh4OXXrkeijdeqTt5IAv
         xdMaEPc4YMWsYv4jc73vLi3bhIjJ5ve2KgF/xTDxWIDKnzKP1beHgCbYRricsykx5xYG
         poDwD8/sjheC/+acNxT/R1vQOPiB+c1/MvblelwJExhwSyPQhL1OrMaMZXtjA4RuHkX2
         8fOw==
X-Gm-Message-State: ABy/qLZQOzil7NA1qFKG504vVfxGI0XduXSQylUn3/QAv/vo12jTKt84
        iIbexYMQCqBCOYfkqpOOrfoLg7aMptYkB6ZXs8iR/RbC2uBzETF612g=
X-Google-Smtp-Source: APBJJlFvJSbZ8xBnLgfIuzFE30MmDzLcOIGFY6sMLTSM66P9iy4b/F4ZwAquSqsG+u2lZyeklZqivh1tMWu62WEqlHk=
X-Received: by 2002:a05:622a:193:b0:3ef:5f97:258f with SMTP id
 s19-20020a05622a019300b003ef5f97258fmr595360qtw.16.1689780159248; Wed, 19 Jul
 2023 08:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689718662.git.anupnewsmail@gmail.com> <ZLfDPPYK1PXc9xOe@yoga>
In-Reply-To: <ZLfDPPYK1PXc9xOe@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 08:22:24 -0700
Message-ID: <CAP-5=fUzUoLEpjcrZTzX93TPFbRMUhZGF+BVLB9OiusmKJFYvA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add support for Firefox's gecko profile format
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 4:04=E2=80=AFAM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> On Wed, Jul 19, 2023 at 04:15:52AM +0530, Anup Sharma wrote:
> > This patch series adds support for Firefox's gecko profile format.
> > The format is documented here [1].
> >
> > I have incorporated several changes based on feedback from the
> > previous version of the patch.
> >
> > Changes in v3:
> a small typo here. It should be v4 instead of v3 (changes in v4).
> > - Implemented object-oriented programming (OOP) approach for Thread and=
 Sample
> >   to improve code organization and maintainability.
> > - Enhanced user experience by introducing argparse for changing color s=
ettings
> >   of user and kernel symbols during execution.
> > - Ensured proper module encapsulation by adding imports wherever necess=
ary.
> > - Improved code readability by adding descriptive comments and type ann=
otations.
> >
> > These changes focus on adopting OOP principles, enhancing user interact=
ion with argparse,
> > and making the code more readable with comments and type information.
> >
> > TODO:
> > - use cpu_mode to determine the category instead of finding it from sym=
bol name.
> > - Write a test.
> > - add direct execution command for this script under script/python/bin =
directory.
> >

Thanks Anup, is there a minimal TODO so that some code can be merged?
I didn't have any comments for this series so:
Acked-by: Ian Rogers <irogers@google.com>
I think even the test can be follow up as the code isn't on the critical pa=
th.

Thanks,
Ian

> > Committer Testing:
> > - Tested with a perf.data file generated for single and multiple cpu
> >   cores enabled.
> > - Uploaded the stdout into profiler.firefox.com and verified the
> >   output.
> > - Verified the output with the output generated by the existing
> >   script as mentioned here [2].
> > Method:
> > - perf record -F 99 -a -g -- sleep 5
> > - perf script firefox-gecko-converter.py > output.json
> > - upload output.json to profiler.firefox.com
> >
> > [1] https://github.com/firefox-devtools/profiler/blob/main/docs-develop=
er/gecko-profile-format.md
> > [2] https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler
> >
> > Anup Sharma (6):
> >   perf scripts python: Add initial script file with usage information
> >   perf scripts python: Extact necessary information from process event
> >   perf scripts python: Add classes and conversion functions
> >   perf scripts python: Add trace end processing and PRODUCT and
> >     CATEGORIES information
> >   perf scripts python: implement internal get or create frame, stack an=
d
> >     string function
> >   perf scripts python: Implement add sample function and thread
> >     processing
> >
> >  .../scripts/python/firefox-gecko-converter.py | 339 ++++++++++++++++++
> >  1 file changed, 339 insertions(+)
> >  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.p=
y
> >
> > --
> > 2.34.1
> >
