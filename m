Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3D77BF16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjHNRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjHNRgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:36:21 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78257133
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:36:20 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-407db3e9669so23291cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034579; x=1692639379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nezIMeQVI/coqQm4cEiygAngrUHrjvD9ah/qFQLbofg=;
        b=RY6OAETd5OfPN1mjkKSF54kvhlpncn28oQRxkYqxBww9vv/fazE9jfmV0o4mHE8yTH
         SRbtH6W++lKf7SBz3oql3p65RzUZvftNHlFlanbDFkdILu0tBG7uiX74Qp0Z2agGNkKN
         9akPDEuRsmIEVzcUHU61bmJJTacJBPXYkgOeXU9y/3a3UuN8hbSpVL6udI/vKyxsV5eB
         CInQe0Q8XPxRycYvGqNNavRuDsMaIA8EJq6hVDaYWHxnJKg96spxXctcrrkxqmtJOHj0
         wNpfyNsqkwHaGhfhf2jP2Cs35chxM4T0+D7lsL9wuhD1WO+rkqcJKu/HjF0Sp9HMwmeO
         MPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034579; x=1692639379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nezIMeQVI/coqQm4cEiygAngrUHrjvD9ah/qFQLbofg=;
        b=gAYjpe5z269mE7IWKLp7jmF94M1kAPI+E5hzJuDwzsPXdlUMkrIWl2PhJToPnOgXlC
         Hp9nbDpUdlqCq5T0TpejdcyfncVsALzosZc5LXn0KzQdye9zCjnKtE0oNm0A0FEvVlwS
         MSqoLqGvEjkqnD0zRLIcFK7HzQRQqdCYi9GG4JOOqr3dFTi4RA50Z7e8Be30A8IFDtJ1
         bAjnneHtXGs835Z4StlK2DM+/yEzUPJo/Q/qUOzR8tvtnSMSg427mEBHaCiRUjY6OrIU
         X5Nc7FO+C723az53YV8Z6vVrWTGM6V31jBl7av3kobPQ8KdOuj5CrAai2AYBH/Sz6etG
         LcgA==
X-Gm-Message-State: AOJu0YypUFYDhs62ENM0Y9CmIYXxyuk5P0rvTiV/FXg3vEGdSqz5XtS6
        na8+bPATuoVKdUVgAmNKDrV02df6s+dIfjbstRf40Q==
X-Google-Smtp-Source: AGHT+IGc+G4K6OEf6vdlaaKeywz8co8Q6qYJYXMlr+M6vLVyR+QtiyiLz1zjwnmqetqLdt01dD0x7HNbJXFWr9v7qa4=
X-Received: by 2002:a05:622a:1b8c:b0:403:e1d1:8b63 with SMTP id
 bp12-20020a05622a1b8c00b00403e1d18b63mr602344qtb.24.1692034579524; Mon, 14
 Aug 2023 10:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
 <20230803211331.140553-2-ilkka@os.amperecomputing.com> <9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com>
In-Reply-To: <9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 10:36:08 -0700
Message-ID: <CAP-5=fX2uE=B_Vb90nn5EV0mw+AJBpjDecP9w29OUn=j7HKPPg@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf vendor events arm64: Remove L1D_CACHE_LMISS from
 AmpereOne list
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
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

On Fri, Aug 4, 2023 at 4:02=E2=80=AFAM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 03/08/2023 22:13, Ilkka Koskinen wrote:
> > amperene/cache.json file tried to include L1D_CACHE_LMISS while it
> > doesn't exist in common-and-microarch.json. While this bug doesn't seem=
 to
> > cause issue in newer kernels with jevents.py script, it prevents buildi=
ng
> > older perf tools with the backported patch.

Fwiw, newer perf tool on old kernel should always be fine. But I
understand that if you are trying to build a tree with backports in
it...

>
> jevents.py needs to be improved so it errors on these events which
> cannot be fixed up, like it used to. I'll look to do that when I get a
> chance.
>
> >
> > Fixes: a9650b7f6fc0 ("perf vendor events arm64: Add AmpereOne core PMU =
events")
> > Reported-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> > Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/76bb2e4=
7-ce44-76ae-838e-53279047084d@oracle.com/__;!!ACWV5N9M2RV99hQ!IlO3yUW8jhm6w=
p8BJalODmD7WjzJleyREtTWS2pdn90Af5BD3P7g0fTGldbw15pSn49ycWiKpWDysjXw_ECS4Xbb=
JQ$
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >   tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.js=
on b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > index fc0633054211..7a2b7b200f14 100644
> > --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > @@ -92,9 +92,6 @@
> >       {
> >           "ArchStdEvent": "L1D_CACHE_LMISS_RD"
> >       },
> > -    {
> > -        "ArchStdEvent": "L1D_CACHE_LMISS"
> > -    },
> >       {
> >           "ArchStdEvent": "L1I_CACHE_LMISS"
> >       },
>
