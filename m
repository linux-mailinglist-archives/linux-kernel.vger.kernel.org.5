Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429DE788830
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbjHYNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244991AbjHYNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:14:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394A61FF5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:14:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40c72caec5cso270811cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692969253; x=1693574053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e30ygpUnem0hnNXEifSCeb6KdAoBljm9WluqG1YNW+c=;
        b=gOLCH/Lb00Mz/K9+MfGJuQI+gpTU/aXIcKyNJKEZRfJzEDN6z7Fjm/ZJJbJ3YFJf06
         eEZ9ldF7S/Icc5bzc0VKBYNbeU2Kclv78vSvHcQuMOjlEpzLqHoZr0NZMr5ruim/O7ku
         f/mAQ3KVcAv0X5g5UnawPC8HzBWAd9UaNmawz9AGlKCY7gPyLCEx+SvCVrh1lrTnmjzs
         548i5lqvLT7ftR1D1YkWUYT1TM0sdZ+nGgApO2nZWlaQ4yTyT5Z6APgHjuH3kPXYbpgm
         Cv4dERMbuC8XRr9opa0AA9JSfZYChbs/LgwDRIs3ry7dxIfK/yEXE89nkHKxoR4vXEAL
         3Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692969253; x=1693574053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e30ygpUnem0hnNXEifSCeb6KdAoBljm9WluqG1YNW+c=;
        b=KgSAI2FKaBKFaST5Rj384PMf3d7jlwNQPUeRszdrzPWBlfjof1DKa73/oCO5AXqn+r
         w9npE7/LFQJhp+xKrdd++3BjKn6brseBdBgTNC7IX23gqo1+k7vH2CKuzVZwb14kFe2s
         jiJvBLoaQR4vDM347qXatJxzYYCeKwrKC2z7Lijwvr9zoCW574a4xXbVig4sdqXSlUin
         W7K5Yk+NB2hxnt0S/wQbOPdjoN853qLLGVgCNV8Pj18iGiPKfxIrZpdCt77aiqsm8QYI
         Af1UosoEOLKs4VelpNkmpeY2skya1TuJMoz4UVYK529nhd+chpq8xkluZ+zGeQ6ocxyS
         vR7Q==
X-Gm-Message-State: AOJu0Yy+JXhLvydP9PtFXeak/D7VQu3dGOgmJprC5Qlw9TPgp4nVjYL1
        OOPnuckuzNRmPn7DrrK3/43PmlKVXXzMF0pbF4fcuw==
X-Google-Smtp-Source: AGHT+IH+VlhSr/7ethdftBz4x+JgfAMJPFqEn9CO5of2hOfCYJWtOCDujhaXCutycQfctL9dyoDM5xODuPjY8K50w8s=
X-Received: by 2002:ac8:7f96:0:b0:3f8:5b2:aef0 with SMTP id
 z22-20020ac87f96000000b003f805b2aef0mr295265qtj.24.1692969253167; Fri, 25 Aug
 2023 06:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com> <20230824041330.266337-7-irogers@google.com>
 <ZOdiX4eJHFfFbQhi@kernel.org> <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
In-Reply-To: <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Aug 2023 06:14:01 -0700
Message-ID: <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 25, 2023 at 1:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 8/24/23 15:59, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Aug 23, 2023 at 09:13:18PM -0700, Ian Rogers escreveu:
> >> Rather than scanning all PMUs for a counter name, scan the PMU
> >> associated with the evsel of the sample. This is done to remove a
> >> dependence on pmu-events.h.
> >
> > I'm applying this one, and CCing the S/390 developers so that they can
> > try this and maybe provide an Acked-by/Tested-by,
> >
> > - Arnaldo
>
>
> Arnaldo,
>
> I have downloaded this patch set of 18 patches (using b4), but they do no=
t
> apply on my git tree.
>
> Which git branch do I have to use to test this. Thanks a lot.

Hi Thomas,

the changes are in the perf-tools-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
