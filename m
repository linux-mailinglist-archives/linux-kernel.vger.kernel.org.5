Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A0805E71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjLETOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLETOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:14:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE6B0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 11:14:59 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bf09be81bso420e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701803697; x=1702408497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjNkOH41w29ta79KWUOUY4u7veXqkuV98gB+b0cOvYw=;
        b=1IRwzlicKqhGEkRpjKUmlmXh1FebwZ/Y6kFA87IqK+PiGwp7LvB17Z2/0/UUi5J+5w
         CJbSadIr7krBOjv5sFtFtmsX/20EIg/woY7Pja6TVaHZumJ5xYKnRLk29ifPwQv91NRk
         ZvYIuj5lxErYkBB143x7Tuf0hvlduk0KtVsyxq2mJz8HhyA8Dm3t8FBDSn+lzWJSb9si
         DS42QKHcVpETpgYEtAHZq7kcNcxmkBlq3nQgWvGQFnx+ygSDJWjTh9TQH9DhC6Id57Dk
         gprQbvygEV2TB8BGHEkKpppHEGJmgzRw2M1FKYLNpI4SVw2nOc9nJ9dtkgQvt4n5tZJ7
         kzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803698; x=1702408498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjNkOH41w29ta79KWUOUY4u7veXqkuV98gB+b0cOvYw=;
        b=iiht6DnQU2S0QXdGzwcYCOSsmoI2tY8khEq0Jska3UH9gnn92D3E5dQHo38P5xh6Fq
         g1vCbIe4dZgzgGK1diPyaWGUu278qC2RmQR2y5vt46Tp0jH/uHEJUPa8n0gN9NlHGYKm
         KCdNzDvnmx0dBIOdB8WfLZTVbvQIrUuGy9PlWIG81asBfoU2V/rD+2nRUcN+slaV2ndg
         oa7G+6Tpin7e/bnAa4kwfVrp7U8+uf4l9StZkH2nzUaYfN+Ed+OI3dqOGfFwW06KhCfk
         qMVvJShWUEpsNZ76USvXGGUYDgdcpOZdpzpY+QnwUhVYOONlNLR/ZiToDtNGQN5OhPUU
         rZ8w==
X-Gm-Message-State: AOJu0YxcV683jYfukUnNbFD6frqWeA6Yhs9+4ik/PLeoD8GP17tuAzBN
        8SdGahw1ldxc5WEi5+eK4g+TE9o9FMbEOSdOn6XdrA==
X-Google-Smtp-Source: AGHT+IECevghSTxbCpO5I8Hw921Kb+KJQSWhdrSSOCD26W7F8IdQsEZHah0UJbWLkpKj8oahEcpogeAaeah6fypFdDA=
X-Received: by 2002:a05:6512:e81:b0:50b:ea5c:2823 with SMTP id
 bi1-20020a0565120e8100b0050bea5c2823mr9416lfb.2.1701803697521; Tue, 05 Dec
 2023 11:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com> <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
 <ZW9G8Clxwl6bd0H6@kernel.org> <CAM9d7ciOp_O5N1TDX0HyKavykirByAYrqzcmM-_6ZWjMv-47WQ@mail.gmail.com>
 <ZW9whqUEILWMdcmi@kernel.org> <CAM9d7ciqm2NLt5kxjVdOP2y-KV30_CRsSjHpcQgntvNGWukx9g@mail.gmail.com>
In-Reply-To: <CAM9d7ciqm2NLt5kxjVdOP2y-KV30_CRsSjHpcQgntvNGWukx9g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 Dec 2023 11:14:45 -0800
Message-ID: <CAP-5=fXpsGNVfz+jyu7A=uhrJVQ2xeQ_Forq7CJ4YSjFp-UWnw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 11:11=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Dec 5, 2023 at 10:48=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Dec 05, 2023 at 09:24:42AM -0800, Namhyung Kim escreveu:
> > > Hi Arnaldo,
> > >
> > > On Tue, Dec 5, 2023 at 7:51=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > >
> > > > Em Mon, Dec 04, 2023 at 07:33:18PM -0800, Namhyung Kim escreveu:
> > > > > On Mon, Dec 4, 2023 at 2:45=E2=80=AFPM Ilkka Koskinen <ilkka@os.a=
mperecomputing.com> wrote:
> > > > > > On Mon, 4 Dec 2023, Ian Rogers wrote:
> > > > > > > A metric is default by having "Default" within its groups. Th=
e default
> > > > > > > metricgroup name needn't be set and this can result in segv i=
n
> > > > > > > default_metricgroup_cmp and perf_stat__print_shadow_stats_met=
ricgroup
> > > > > > > that assume it has a value when there is a Default metric gro=
up. To
> > > > > > > avoid the segv initialize the value to "".
> > > >
> > > > > > > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgr=
oup")
> > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > > > Thanks! I was going to look for the bug but got pulled to other
> > > > > > tasks. The patch looks good to me and I tested it successfully =
on
> > > > > > AmpereOne.
> > > >
> > > > > >    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecompu=
ting.com>
> > > >
> > > > > Looks like it needs to go through perf-tools for v6.7.
> > > > > Ian, do you think this one is enough?
> > > >
> > > > So I had this on my local perf-tools-next, removed now, I also have=
 some
> > > > other fixes by Ian on the tmp.perf-tools-next, please let me know w=
hat
> > > > you guys decide to have in perf-tools for v6.7 so that I can remove=
 it
> > > > from there.
> > >
> > > I think we need this one and the Ampere default-metric-group fix.
> > >
> > > https://lore.kernel.org/r/20231201021550.1109196-2-ilkka@os.amperecom=
puting.com/
> > >
> > > Also perf list JSON fix can go to v6.7.
> > >
> > > https://lore.kernel.org/r/20231129213428.2227448-2-irogers@google.com=
/
> >
> > Ok, removed both, please augment the later description to:
> >
> > "perf list: Fix JSON segfault by setting the used skip_fuplicate_pmus c=
allback"
> >
> > The original description was vague, improving it a bit like that helps
> > when just looking at the output of "git log --oneline".
>
> Done and pushed to tmp.perf-tools!

Thanks Namhyung, there was a typo in Arnaldo's commit message
"s/fuplicate/duplicate/" could you fix?

Ian

> Thanks,
> Namhyung
