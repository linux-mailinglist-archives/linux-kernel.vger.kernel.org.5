Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2B7CD716
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjJRIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:55:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C286F9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:55:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ad8a822508so1069747466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697619299; x=1698224099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL/UZARaAWUIf6+4o54rQD6Gfs68ZHxoU8jk1dJAyXQ=;
        b=kk/2/pPkkiZmVUHI2gAJs5ixlwqzBytCoss2FWxrBodYlEMyl+CesseG89gfUQ073i
         7UWs0zfmq38UuCFIa+1jJbU9O2q0ymh7YpDkIa2KQu46g+YkbFskBjy+95hNUEJqtQmL
         n4T2zr2WblAx9Ok8Z3DdhuX+nfLiNy2yK1haqi11I8M5S8OIUi8Az+xGel8+IETsOkGy
         BzwVnQLEvSKCmHc5uAqD5TWpoY7JoVDMGrJm5H/PAJrNeLGxiB9z3tSYcLdsiSzQq66A
         lKrrk86Yc3aOyuptGvBUyfoWI3eZYJ+5yOz33ijcVXbF8r9y8/lrcZWO/PAlY71PJOzJ
         wqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619299; x=1698224099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL/UZARaAWUIf6+4o54rQD6Gfs68ZHxoU8jk1dJAyXQ=;
        b=FRDVVGX7NQ5q/YBm6Elt/1M/d0bP3L5j8zGfmeTqroh4CHLvipbYQ4Wt7hQo8LFLFC
         cTh4AYFRXzigk4b/TMVOSNOwrar9l0vQQZI5bnnEOem8SgMhEbr5O1ljizWV9Crx4xfO
         m6oqDM5KiuBP5RYpNzwmrD+jaMNC3SlaR62aIHqPgRrVBZ8yG5yEe4KkUuvurH6hbYFc
         E1gZuLEGvDU5oV1+gRxRlBxl7rkdtZitSCUKUiCVnlhSLcChIKmO6dYOAx9Cj7Vt0FOZ
         zfq4BIDXUPzD4E8swqfv5ZAdv6r+uDsY9U7klWqBnF3p+pZsn/kztdJn/kGqpoDtkJfd
         j7xg==
X-Gm-Message-State: AOJu0YxD2zvehSI3cwBjcC5ZAiCk1v/1VseP8Pn1lEPeI41GcOCfcTyC
        WkWZei+3uU7WJdcNubPSy2e7uRLFJ7iMjaAdoIWnOg==
X-Google-Smtp-Source: AGHT+IGGtmOH11oZ1Cb59UA//7N6str2jENUft6xZQE93G81xgY9OLXEg+0bgebtR43pEb9PTMWIKAdCJH6cxE6feGU=
X-Received: by 2002:a17:907:9712:b0:9ae:50e3:7e40 with SMTP id
 jg18-20020a170907971200b009ae50e37e40mr3787316ejc.52.1697619299344; Wed, 18
 Oct 2023 01:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
 <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
 <CAJD7tkbSwNOZu1r8VfUAD5v-g_NK3oASfO51FJDX4pdMYh9mjw@mail.gmail.com>
 <CALvZod5fWDWZDa=WoyOyckvx5ptjmFBMO9sOG0Sk0MgiDX4DSQ@mail.gmail.com>
 <CAJD7tkY9LrWHX3rjYwNnVK9sjtYPJyx6j_Y3DexTXfS9wwr+xA@mail.gmail.com>
 <CALvZod6cu6verk=vHVFrOUoA-gj_yBVzU9_vv7eUfcjhzfvtcA@mail.gmail.com>
 <CAJD7tkavJDMSZdwtfxUc67mNBSkrz7XCa_z8FGH0FGg6m4RuAA@mail.gmail.com> <ZS+VqgmMVStQ9X8m@xsang-OptiPlex-9020>
In-Reply-To: <ZS+VqgmMVStQ9X8m@xsang-OptiPlex-9020>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 18 Oct 2023 01:54:20 -0700
Message-ID: <CAJD7tkY9KTwDWJUtnQ8qygeHkWvzyFSM7w07z_=PYLh1kHcRMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        michael@phoronix.com, Feng Tang <feng.tang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 1:22=E2=80=AFAM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Yosry Ahmed, hi, Shakeel Butt,
>
> On Thu, Oct 12, 2023 at 03:23:06PM -0700, Yosry Ahmed wrote:
> > On Thu, Oct 12, 2023 at 2:39=E2=80=AFPM Shakeel Butt <shakeelb@google.c=
om> wrote:
> > >
> > > On Thu, Oct 12, 2023 at 2:20=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > [...]
> > > > >
> > > > > Yes this looks better. I think we should also ask intel perf and
> > > > > phoronix folks to run their benchmarks as well (but no need to bl=
ock
> > > > > on them).
> > > >
> > > > Anything I need to do for this to happen? (I thought such testing i=
s
> > > > already done on linux-next)
> > >
> > > Just Cced the relevant folks.
> > >
> > > Michael, Oliver & Feng, if you have some time/resource available,
> > > please do trigger your performance benchmarks on the following series
> > > (but nothing urgent):
> > >
> > > https://lore.kernel.org/all/20231010032117.1577496-1-yosryahmed@googl=
e.com/
> >
> > Thanks for that.
>
> we (0day team) have already applied the patch-set as:
>
> c5f50d8b23c79 (linux-review/Yosry-Ahmed/mm-memcg-change-flush_next_time-t=
o-flush_last_time/20231010-112257) mm: memcg: restore subtree stats flushin=
g
> ac8a48ba9e1ca mm: workingset: move the stats flush into workingset_test_r=
ecent()
> 51d74c18a9c61 mm: memcg: make stats flushing threshold per-memcg
> 130617edc1cd1 mm: memcg: move vmstats structs definition above flushing c=
ode
> 26d0ee342efc6 mm: memcg: change flush_next_time to flush_last_time
> 25478183883e6 Merge branch 'mm-nonmm-unstable' into mm-everything   <----=
 the base our tool picked for the patch set
>
> they've already in our so-called hourly-kernel which under various functi=
on
> and performance tests.
>
> our 0day test logic is if we found any regression by these hourly-kernels
> comparing to base (e.g. milestone release), auto-bisect will be triggnere=
d.
> then we only report when we capture a first bad commit for a regression.
>
> based on this, if you don't receive any report in following 2-3 weeks, yo=
u
> could think 0day cannot capture any regression from your patch-set.
>
> *However*, please be aware that 0day is not a traditional CI system, and =
also
> due to resource constraints, we cannot guaratee coverage, we cannot tigge=
r
> specific tests for your patchset, either.
> (sorry if this is not your expectation)
>

Thanks for taking a look and clarifying this, much appreciated.
Fingers crossed for not getting any reports :)
