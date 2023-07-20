Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC6775B372
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjGTPvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjGTPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:51:08 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A78FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:51:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40371070eb7so300821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689868266; x=1690473066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YK0KVqgT80x9gtOq8ZA4JrTzkCJPsXRqm4bTuq2qlc=;
        b=Ux7AodmvVSgABqN8P9sESis9DMtsCCYYycRlF3jYnEXnLRqzslfx+efIH3YOOlY0V5
         xXMYjhh3QKN5JUMlxLaRoHULgvNR0gdfhl0RsOSpwLan84ipcIZWY9IKLff+elYshUEB
         dbU/Rq+bMdZ92ziIkBxmO21TQrdVA7M3LDPdqky2fIEDYRhoHWHEiK8ve6udyd4qlKlJ
         Ja3wf8udsBgNgKWc0BCGqnXey0COz3h6a+M127j54JftWLipcQthgFUTgajCGF44mfhk
         WNi1MK3PD2N9j4dxU6ZbgdLoM/DOQ3vMco7weu1xBemc9MXM91q6oqPeD7MZDxwXwnq0
         QnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868266; x=1690473066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YK0KVqgT80x9gtOq8ZA4JrTzkCJPsXRqm4bTuq2qlc=;
        b=KK+qJh6M84QItZDAt1Mah+RQvxPUDlSrDpkCSNPFrGlMW0+BpVGKIdudGAVH1Pnb5k
         8wj1wsCK+JKTAGm6D+zCHJyTQdTiVqKF4Fz/mmQym9qMVufOS83JNzvGjYAhOFiHdrsJ
         h6NExXyywm8/rEWStTWmHLqiou5JXOcFlnrc+laA6Uhzg/I5gAw6S+hdLSm87lpipkgy
         4Z4UNO6pT9bv3277ETFlgAQGx9nTkGw6JjCU1lCH7WGyuw+mWSOhNPEROozsaq/c9oVM
         9imyV/aM/FtJxSwlB/YSYzwQuSsjFcyhwF8Tc7rxG8Duu8P32HBIu9coOcYNYM3EQYmQ
         G0EQ==
X-Gm-Message-State: ABy/qLa7iMHSwJ4Am8aD+kLPpl6jeTsylEzM2W2aRbU1fTMqIrkfizR8
        ss77RA1oVDnCXYcYPeunGiHnzHNkxUQBO1fYS7C7NaIMCzdVVOvS3pquMw==
X-Google-Smtp-Source: APBJJlEBDbt+lYzvGvMdMQJx6mphhH/41Ih+Sj4asX1FokH/uh8yfDLqFyjOqh05Q0xlYUlT0WwMUSay6wyjGUPP/y0=
X-Received: by 2002:a05:622a:101:b0:3f4:f0fd:fe7e with SMTP id
 u1-20020a05622a010100b003f4f0fdfe7emr231958qtw.3.1689868266021; Thu, 20 Jul
 2023 08:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748843.git.sandipan.das@amd.com> <a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com>
 <CAP-5=fX1NQzus3MQapmBrdgEhDG4+XmawgytfugHHOKD0E-COg@mail.gmail.com> <fef0492b-60c3-70ea-c7f1-370bf2734fc3@amd.com>
In-Reply-To: <fef0492b-60c3-70ea-c7f1-370bf2734fc3@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Jul 2023 08:50:54 -0700
Message-ID: <CAP-5=fX=1t51+a9=Fj-xt4zyLw9OG44bu9wRdPsu2hPoh8cNZQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] perf vendor events amd: Add Zen 4 memory controller events
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:23=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> On 7/19/2023 9:42 PM, Ian Rogers wrote:
> > On Tue, Jul 18, 2023 at 11:58=E2=80=AFPM Sandipan Das <sandipan.das@amd=
.com> wrote:
> >>
> >> Make the jevents parser aware of the Unified Memory Controller (UMC) P=
MU
> >> and add events taken from Section 8.2.1 "UMC Performance Monitor Event=
s"
> >> of the Processor Programming Reference (PPR) for AMD Family 19h Model =
11h
> >> processors. The events capture UMC command activity such as CAS, ACTIV=
ATE,
> >> PRECHARGE etc. while the metrics derive data bus utilization and memor=
y
> >> bandwidth out of these events.
> >>
> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> >
> >> ---
> >>  .../arch/x86/amdzen4/memory-controller.json   | 101 +++++++++++++++++=
+
> >>  .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
> >>  tools/perf/pmu-events/jevents.py              |   2 +
> >>  3 files changed, 187 insertions(+)
> >>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-cont=
roller.json
> >>
> >> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.=
json b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
> >> new file mode 100644
> >> index 000000000000..55263e5e4f69
> >> --- /dev/null
> >> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
> >> @@ -0,0 +1,101 @@
> >> +[
> >> +  {
> >> +    "EventName": "umc_mem_clk",
> >> +    "PublicDescription": "Number of memory clock cycles.",
> >> +    "EventCode": "0x00",
> >> +    "PerPkg": "1",
> >> +    "Unit": "UMCPMC"
> >
> > nit: Why use UMCPMC and then rewrite to amd_umc, why not just use "amd_=
umc" ?
> >
>
> I followed the convention that has been historically used for AMD uncore =
PMUs e.g.
> the "Unit" for amd_df is "DFPMC" and for amd_l3 is "L3PMC". I do agree th=
at its
> simpler to use the same naming so will change this. If you prefer, I can =
send out
> a separate patch to change the unit naming for amd_df and amd_l3.

Thanks for the explanation. I don't mind but it is nicer to have fewer
renames imo. If we get rid of one, perhaps we can get rid of them all?
Perhaps merge this and follow up with simplification.

Thanks,
Ian

> - Sandipan
>
