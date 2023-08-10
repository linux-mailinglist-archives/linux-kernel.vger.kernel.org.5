Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF86778369
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjHJWDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjHJWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:03:04 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5496D30C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:02:51 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3490b737f9aso20825ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704970; x=1692309770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WirRslw/0aDPkGhNScoiXM3zTY4G823fT91ETu+Lq6E=;
        b=UkdroNGwQrguLsDBgIEgrLvfKjn25h5tidmJjeYWOg8t5dssZ1517XjbYhdh/tiPNO
         EBpB6lGHrYvSxe5RzWSp9mAptNk9c7Meu+AWFWKissa9cQSd6+yCsJvq60LFZ+jCOIVe
         Rr9sVB8JIfibwVkOG/suomrjoOrY2Geo4BFVDD8CLiVSW1pNChr4tcICXZFee5TT8RAD
         PTG3bqf+yehy7fQNyjY/+xRXxvjckVSUSD5M+mjFhnQ5t5KXv1ApBtrP6GoofG9Sl8Hn
         9PCfxaJ/p5/oV6OwPWYN3qCFQUI38smFiA3zq2al3YjMc6Mg2brfo88yQImylhrW4ewn
         S55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704970; x=1692309770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WirRslw/0aDPkGhNScoiXM3zTY4G823fT91ETu+Lq6E=;
        b=Vw8XOuVrC7Et0AzhwSi8HhbLi05S6LYh4al08zSW4teTda85rxPOFb1jHRuzXuS658
         Bu5lV1nhgxfLh/JIcBhF3+hK6YQX+2ZQBd3R7BTURgPmg7/gy6KZ+HdmcH3grU1sHATc
         ZMxFhOefDxhag0FSGyBrSUyxWsxJ51bY4xROjlP/49XET+q6YmuCZA1+XQFXKDE+dF19
         N0Kt508hvwqZWTX5X+YcoZ+pukrKJQ2SmgD9drwecYcbLQ0MHXzE75Z7mX2wg11500wF
         CUvujyTfJFDlquzFSV1Jv3vyjTDmkrJQXS0PC9cuCWPHzlOa4QVtg7Lla3gaIMRvvsPR
         CV8w==
X-Gm-Message-State: AOJu0YyQQAPrm7qzI1A4fnfr7raiJ5femK7zOlopbrZY+dpfpayouTHv
        ilnFj93ZmXmVIpgEBZaCzV5Fszj5OSBXlG8fHNH+iw==
X-Google-Smtp-Source: AGHT+IEVz2QXUNlQHls+sgcBM1Gy6AYEvav8ViVH8f0MUbcqC3NuL9+xkH/d3pXnSUlrKBHYSG/nFcIRqELsmKHUvDg=
X-Received: by 2002:a05:6e02:1987:b0:346:1919:7c9b with SMTP id
 g7-20020a056e02198700b0034619197c9bmr112579ilf.26.1691704970628; Thu, 10 Aug
 2023 15:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230803-fix-typo-v1-1-b794378d594e@manank.me> <ZMwRzQC+wBgJpDfr@kernel.org>
In-Reply-To: <ZMwRzQC+wBgJpDfr@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Aug 2023 15:02:37 -0700
Message-ID: <CAP-5=fW_bC1s+43My1cXmF_og7SE4=8K=ZZn82WNSGqAo849oQ@mail.gmail.com>
Subject: Re: [PATCH] tools: perf: pmu-events: Fix typo poiint->point
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Edward <edward.baker@intel.com>
Cc:     Manank Patel <manank@manank.me>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Jens Schleusener <Jens.Schleusener@fossies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 1:45=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Thu, Aug 03, 2023 at 11:27:30AM +0530, Manank Patel escreveu:
> > Fix typo in file floating-point.json in /arch/x86/westmereep-dp
>
> AFAIK these are generated using a tool, so the fix needs to go to the
> file from where the JSON files are generated, Ian?

Yes, these are generated by the script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
Added Edward Baker at Intel who can correct these issues at source.

Thanks,
Ian

> - Arnaldo
>
> > Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D205891
> > Signed-off-by: Manank Patel <manank@manank.me>
> > ---
> >  tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json | 2 +=
-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-poin=
t.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> > index c03f8990fa82..196ae1d9b157 100644
> > --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> > +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> > @@ -8,7 +8,7 @@
> >          "UMask": "0x1"
> >      },
> >      {
> > -        "BriefDescription": "X87 Floating poiint assists for invalid i=
nput value (Precise Event)",
> > +        "BriefDescription": "X87 Floating point assists for invalid in=
put value (Precise Event)",
> >          "EventCode": "0xF7",
> >          "EventName": "FP_ASSIST.INPUT",
> >          "PEBS": "1",
> >
> > ---
> > base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> > change-id: 20230803-fix-typo-3cb207284310
> >
> > Best regards,
> > --
> > Manank Patel <manank@manank.me>
> >
>
> --
>
> - Arnaldo
