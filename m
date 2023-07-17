Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CABC756F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjGQVj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQVj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:39:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C2136
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:39:55 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40371070eb7so37981cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689629994; x=1692221994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0L/u4EOmvOeOcserJ539wNSDT1o1b20dAGizzxViNs=;
        b=RxtqQLtW7DdEzo5+tf95lbnEIv1JAmjlyjxRoJLX2jgMnwORuVUk9LBGWdd1UJ/R5U
         XAfcuvHzPJ4zwe+lXEIk1+03O7iBmcisIuB2uTuf5iaMEaPQvzTY76UeojoV9M7Aggbe
         SyNH3deKSrDEbINh+6SJZwOuuUw1WP/TMpoOwHt7o+SpVARmIoQz/8joC1EVzP8CZh+U
         szeZb6V9QBUle8p+OCa3Ahxgo3NuaY9v+f3kx1XWSf5UYKpL1zl66ZMQ7TDZi2V7uahd
         M9qlGbJ3Yfs9h7R8Gm0N/060DDnCqHLg0nFr2CsUFr1t8YxEe2+Q+5dXek2smcCumKVQ
         Br6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689629994; x=1692221994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0L/u4EOmvOeOcserJ539wNSDT1o1b20dAGizzxViNs=;
        b=jLq0shKVNY5auqN35dHDWHYi69jZx7V7MEawd2vVddeHY1c4Nrl7Him+R9Y9HNCxHD
         em/qOMAEO0F+uL1G7rCf34Qy9iYas9pAVTYul4ekmKLX7ecNcZVj7iX0l9JnuvB0udnK
         rMGzqSOpI9JdELF+LBSF05SxL9U9e/66zXVtWiaaovDl7eSr9BQPwEHc2I9NN2CRchaY
         UlKcNmGdj7g61gwjl6xk5v8pZEZ7fG2bFKFh69SMn7cEU/0oW1+e+cHD4n5dV6B5ZPYy
         keAjvxKHLpQpDnDBrwbANGIvD5lydDxIHJ105p7iCrwptkTQinWvthc9IXysuNHCWc1M
         u6rw==
X-Gm-Message-State: ABy/qLbXGAsRABoQmVh546nguEgmnjQjNnlqAXEJS6uD/QP5VpNoziS5
        9J+eNpEc/0cYmOBh2WUZ+Fl3heV5oCnxC2+gq9fWkQ==
X-Google-Smtp-Source: APBJJlG3lB6qPRXlnq3d5cJ9d5igRaJW+2bseuqlKvyNGEZ8Ww7iLOlmS2ifwXL6zyEHRZ0gyne93dLLMJekm7tMsFQ=
X-Received: by 2002:ac8:5a92:0:b0:403:ac9c:ac2f with SMTP id
 c18-20020ac85a92000000b00403ac9cac2fmr20018qtc.17.1689629994153; Mon, 17 Jul
 2023 14:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com> <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com> <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com> <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com> <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
 <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com> <CAP-5=fXJxVpYQ84hXiMxy4LUi7xs1puXdDhbp6d6N2ArnqKJuQ@mail.gmail.com>
 <0d6e41d1-2f27-9a90-1516-c4e50bad1c21@oracle.com>
In-Reply-To: <0d6e41d1-2f27-9a90-1516-c4e50bad1c21@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Jul 2023 14:39:42 -0700
Message-ID: <CAP-5=fXKqZM=RMB-+ooKEKfGw=KdCVU0UbVQ9+XrDOAWpoYAdw@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:41=E2=80=AFAM John Garry <john.g.garry@oracle.co=
m> wrote:
>
> On 14/07/2023 16:55, Ian Rogers wrote:
> > In this
> > series my main concern was in the changes of the event lookup and
> > having implied PMUs. You mentioned doing these changes so I was
> > waiting for a v2.
>
> OK, fine, I can look to do this now.
>
> BTW, which git repo/branch do you guys use for dev? I thought that it
> would be acme git, but Namhyung says "We moved to new repos from acme to
> perf/perf-tools and perf/perf-tools-next" - where is repo "perf"?

Current development is here now:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/lo=
g/?h=3Dperf-tools-next

Thanks,
Ian

> Thanks,
> John
