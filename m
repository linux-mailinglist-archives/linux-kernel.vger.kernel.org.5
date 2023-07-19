Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05267599A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjGSP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGSPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:25:59 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E519B3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:25:44 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4036bd4fff1so712421cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689780343; x=1692372343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M1BBdEHDBoPsh/DmUv/sc/XnFZ0Pzg3BftIrHOClRA=;
        b=OvjlRbCUddNpA4vWruqqFPH80nEF9HwVGqHV38YGVKY8iy1zdnFdPa8aq6TOhKXVOE
         EBpKEgmS9p16HESxlFewuVXWbJbzURjLoZGl1sGXPiZVX1K6JYHUUSzTief2mib7gP3P
         cMyW5yw9hx7mOvAG0nGBqLSCn7Hb1LRPKY1CJ3dLO7okqxUqHSOEi2Uc4FFEIkCmF2nI
         ZxBu3neb8deas1yMxVjLO3kRKGuE1ckE4E8pqz9TO2TsoNb9WbDdxJAYFKwPcYt5029U
         DQlFecZdPmkAfSb93N/gf+leheU/mMxPCb6LlferSus09SxhFfKyuwCHGjcIUKHEwSXB
         ExjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780343; x=1692372343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M1BBdEHDBoPsh/DmUv/sc/XnFZ0Pzg3BftIrHOClRA=;
        b=EapAlPVkqMjbV/LKjJT9BRXg1zaJ061noS5mNKztA7Jjnmbow2zhvzgqj7KEQ/o9Qy
         X5ldzNV03femMideVNRr9I+qY7i6pJaDToAVfPTaNXLAH6BOAYChZGqMF5Ma6nv6EZ5g
         JbKTGcWXx2zuSIl95aXpTetHcDweUmLQtTRVbiKMWojaigrT8ftz0aGWwUT1TpbB++jT
         yFjDKgwUEOCDN+w9BXJAqipCijsVm7FGpYoYV5Ae5wT455yBri/1NHLzS/gRKoK27GmP
         uAMluz9DFMDZZT/gTJPwAjVQAWpWY8nDOx0rnFt4K4KuOmas2NygIIHylyDvLSm5Bd/P
         OO1A==
X-Gm-Message-State: ABy/qLYaDa7EjoC/U6nUQ8h5AR8mLJ16WiVC4gGl50qzQFYToV3WYkai
        lTYP6pPNiSKD3PZsV7QQM4h4VHG5/dZx0impP2VSxQ==
X-Google-Smtp-Source: APBJJlET2AN6m0Loi6c3dLeib6bW3pw0QAOKahVIsshzPt7U5Ft0nDdrdxw4BBDswTKK7r4WZ6xEr3lqsfWpx5iZL0g=
X-Received: by 2002:a05:622a:1207:b0:404:132d:1127 with SMTP id
 y7-20020a05622a120700b00404132d1127mr302085qtx.19.1689780343102; Wed, 19 Jul
 2023 08:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com> <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com> <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com> <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com> <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
 <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com> <CAP-5=fXJxVpYQ84hXiMxy4LUi7xs1puXdDhbp6d6N2ArnqKJuQ@mail.gmail.com>
 <0d6e41d1-2f27-9a90-1516-c4e50bad1c21@oracle.com> <CAP-5=fXKqZM=RMB-+ooKEKfGw=KdCVU0UbVQ9+XrDOAWpoYAdw@mail.gmail.com>
 <4f0355ec-8bc6-e51a-ab5b-61d555a68b6c@oracle.com>
In-Reply-To: <4f0355ec-8bc6-e51a-ab5b-61d555a68b6c@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 08:25:31 -0700
Message-ID: <CAP-5=fVGOP6-k=BTRd_bn=N0HVy+1ShpdW5rk5ND0ZGhm_fQkg@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 2:32=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 17/07/2023 22:39, Ian Rogers wrote:
> > On Mon, Jul 17, 2023 at 12:41=E2=80=AFAM John Garry<john.g.garry@oracle=
.com>  wrote:
> >> On 14/07/2023 16:55, Ian Rogers wrote:
> >>> In this
> >>> series my main concern was in the changes of the event lookup and
> >>> having implied PMUs. You mentioned doing these changes so I was
> >>> waiting for a v2.
> >> OK, fine, I can look to do this now.
>
> I was thinking about this a little further. So you suggest that the
> metric expression contains PMU name per term, like
> "cpu_atom@instructions@ / cpu_atom@cycles@" - how would/could this work
> for PMUs with more complex naming, like the form hisi_siclXXX_cpa_YYY?
> Would we use the "Unit" expression for the metric name, like
> "@hisi_sicl,cpa@event_foo"?

How does this work for events? The "@hisi_sicl,cpa@event_foo" looks
strange, shouldn't it be "hisi_sicl,cpa@event_foo@" but then hisi_sicl
looks like an event name.

>
> >>
> >> BTW, which git repo/branch do you guys use for dev? I thought that it
> >> would be acme git, but Namhyung says "We moved to new repos from acme =
to
> >> perf/perf-tools and perf/perf-tools-next" - where is repo "perf"?
> > Current development is here now:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/perf/perf-tools-next.git/log/?h=3Dperf-tools-next__;!!ACWV5N9M2RV99hQ!=
OQDHOClSjd6nVZhmgzrK3RwzXuQpP54QhqyIKpITa_MFD4PLdS7yPYSnvInFja9nrFx9Sd-Unls=
J6XUqAh4$
>
> Can that be added to the MAINTAINERS file? I suppose it is ok under
> "PERFORMANCE EVENTS SUBSYTEM", since the two would-be git repos listed
> under that same entry would be pretty obvious in purpose.

Arnaldo could you take a look at doing this?

Thanks,
Ian

> Cheers,
> John
>
