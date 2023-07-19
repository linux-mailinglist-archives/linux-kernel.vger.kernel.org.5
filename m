Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898BE759A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjGSPuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjGSPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:50:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CAE210B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:50:05 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403f21d3c2dso653401cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689781804; x=1692373804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFrUgOBRU5LRkuOibj1Wn78oyPKuJ5PufyYoH6fT47g=;
        b=00U7y2p7FCFTHRuDKA8GkLL/EgkMGu4khpifCIb9d8bFmxz8H8KWNLSxDaUHd7wRDA
         /wBzLAua2eKqbFnXFxirIfycCDqN3yFZQWGwFQybFp+gTIHEPPIoE0ruO/T+BfME2FLq
         ZxMu3pcVlWyCl1GSNevoRC9Kfij09d6qVGt9RGA8bc5Wcxvow8ceXmLleiiHvG/jVXfb
         ZHhKo5SWu6rkJpu1ebt6LLllkBIdCVwMbGPb+bqFFPBcbxEMuwyzR1xM6VyWpEKnsvKX
         WKz0FKlJManx1+TwQu5oEDmHwe4PviQWyKSX/qsbdDL3QnbdPUBa8uCoJWoxGMiaNkp3
         Exug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781804; x=1692373804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFrUgOBRU5LRkuOibj1Wn78oyPKuJ5PufyYoH6fT47g=;
        b=kaGQsmZ9dq6ba6lffxqtkRX8Czh70SrjPUGK4nY8JMtQ5pA5zcMgCVcSoh2pMuVHb1
         SmZ7190GnHXxNhACpASZLqi1ZBBosqcdMnGPOCKMh7jwMvyFbLBWoMFMZCqxczUJptp1
         gpSX1iSYGOVmJX1HyFLMgWTw3ai7UurtZjE2pJPuldLSF2WqjDhvkcysWBmVI39Beseu
         Jz6fUpSKjzdrXmM6OsjrSTFSgFbdhn5Qmsz+a/DKS8jQ5hxE7xTUsCP3qo8kY6+uH62+
         4LntWUNHXsMsyIa1Oks6J4qggc7MN0GDRl5vIdbp5DusbFkgf7Q5VRR2eZGTVpJ68T1F
         kthw==
X-Gm-Message-State: ABy/qLZKs/CxNPB3M+62Hx+Vy6gbq6NRSgAfJzE2GYmfj9WuqUWKM45A
        hBcJ41FUFRtxPxdK+uw4dv6237vyiSituqPL9x7ooQ==
X-Google-Smtp-Source: APBJJlFmIi7M2rW34hvn/P2sLljtDbqNDzKEFsQVEgFF03q5+81wL4xxP/HEonTbMImrALOqwf7EO8fPsokB7tEtQcU=
X-Received: by 2002:ac8:7dd6:0:b0:403:b1d0:2f0a with SMTP id
 c22-20020ac87dd6000000b00403b1d02f0amr599239qte.28.1689781804546; Wed, 19 Jul
 2023 08:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com> <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com> <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com> <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com> <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
 <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com> <CAP-5=fXJxVpYQ84hXiMxy4LUi7xs1puXdDhbp6d6N2ArnqKJuQ@mail.gmail.com>
 <0d6e41d1-2f27-9a90-1516-c4e50bad1c21@oracle.com> <CAP-5=fXKqZM=RMB-+ooKEKfGw=KdCVU0UbVQ9+XrDOAWpoYAdw@mail.gmail.com>
 <4f0355ec-8bc6-e51a-ab5b-61d555a68b6c@oracle.com> <CAP-5=fVGOP6-k=BTRd_bn=N0HVy+1ShpdW5rk5ND0ZGhm_fQkg@mail.gmail.com>
 <a5082f3b-58a4-0773-2608-2e2647459d3c@oracle.com>
In-Reply-To: <a5082f3b-58a4-0773-2608-2e2647459d3c@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 08:49:53 -0700
Message-ID: <CAP-5=fVjfR2jpVDbqiBTXRoCStwsTZ9sEZAY-PZCLAiVjy4yzA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     John Garry <john.g.garry@oracle.com>
Cc:     namhyung@kernel.org, acme@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
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

On Wed, Jul 19, 2023 at 8:37=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 19/07/2023 16:25, Ian Rogers wrote:
> >> I was thinking about this a little further. So you suggest that the
> >> metric expression contains PMU name per term, like
> >> "cpu_atom@instructions@ / cpu_atom@cycles@" - how would/could this wor=
k
> >> for PMUs with more complex naming, like the form hisi_siclXXX_cpa_YYY?
> >> Would we use the "Unit" expression for the metric name, like
> >> "@hisi_sicl,cpa@event_foo"?
> > How does this work for events? The "@hisi_sicl,cpa@event_foo" looks
> > strange, shouldn't it be "hisi_sicl,cpa@event_foo@" but then hisi_sicl
> > looks like an event name.
>
> Yeah, that was a typo from me - like you say, it would be
> hisi_sicl,cpa@event_foo@
>
> So is that what you would be suggesting then, such that we specify the
> PMU in the metric terms? It does look a bit odd :)

I guess there could be some kind of regular expression syntax:
(hisi_scl|cpa)@event_foo

We have the "has_event" function now in the metric expressions:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/expr.c?h=3Dperf-tools-next#n480

So it could be:
hisi_scl@event_foo@ if has_event(hisi_scl@event_foo@) else cpa@event_foo@

Which has the advantage of working today, but the disadvantage of being ver=
bose.

Thanks,
Ian


> >
> >>>> BTW, which git repo/branch do you guys use for dev? I thought that i=
t
> >>>> would be acme git, but Namhyung says "We moved to new repos from acm=
e to
> >>>> perf/perf-tools and perf/perf-tools-next" - where is repo "perf"?
> >>> Current development is here now:
> >>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kern=
el/git/perf/perf-tools-next.git/log/?h=3Dperf-tools-next__;!!ACWV5N9M2RV99h=
Q!OQDHOClSjd6nVZhmgzrK3RwzXuQpP54QhqyIKpITa_MFD4PLdS7yPYSnvInFja9nrFx9Sd-Un=
lsJ6XUqAh4$
> >> Can that be added to the MAINTAINERS file? I suppose it is ok under
> >> "PERFORMANCE EVENTS SUBSYTEM", since the two would-be git repos listed
> >> under that same entry would be pretty obvious in purpose.
> > Arnaldo could you take a look at doing this?
>
> Thanks,
> John
