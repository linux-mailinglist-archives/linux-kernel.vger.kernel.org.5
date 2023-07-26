Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151AE763AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjGZPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjGZPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:24:08 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C082118
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:24:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b962c226ceso100940681fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690385045; x=1690989845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58XKjPnpcFetGx5j3YOj8ywrrvgND/+/csGew57bsKg=;
        b=OlqpMj+GOS6ZN29CPLOgmWPUTKJLvmKWzkTTSdYpl46AgLMkxw8fOF+mtvOAo6uKGw
         BU1mIXEbmud8kylbCkDkljLAe+cEFLqct3ZmildAwKoGHvviUlWbWr+Y0MvgAvdo0GCm
         IFWkLuTqknhFTwZsZU80GeZNh1HZKFFYudgvxei7dSa6G8pi7JG4cbAdq9DX7RjhOjIS
         8OKqAgPf23lAp6Z9r1I32Xl2sCvNHyxhfmhDHLByuBwju6fPvKtB8zl9D9phh8q/TsPS
         duXmA+dpyypvPqf7Uk44/0skEuLF0fYkSrd0i9D/anETUf4RnkyPK3vyujElRaqdoAaN
         7q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385045; x=1690989845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58XKjPnpcFetGx5j3YOj8ywrrvgND/+/csGew57bsKg=;
        b=Ai3oy/dWB2evaR38Yd1rFt32PoxXySv8IQwbHH7m+VX06/iXjXlvTtYjGtyjgzOWif
         9FOOerB+3Rh0HVNj9akTSEiCbsUM0voUE/Rkp9p3aMTdfk6ep+C3m/yhjJqyBNSVoeT5
         OdtvVzbX4BKGnhj7moGCxaPCzxS+sqKYxDrP9bFi0Y2e7aSvau8EYefKSA4yS7fWBMxe
         vPabCmNRgVmAvayPMeAcN60lYQblSIGitpaMt80lrpLQdKb/cvdnv4Hxu7g2Mf9Vsrta
         iP9T2xnQ8HnwIWD0IDwBVoqib3/HABuGbwDseCBt24seDOt4dghxtNqHEFkzYAzqa8kZ
         IhZg==
X-Gm-Message-State: ABy/qLYh/ENA2ww/cm7Ju/C4OpsXFPOARDCyZbiqy4RpkdK/IUQ+wr0U
        KkgX2XYRc4bf59WmubYnR8hQ/aF8lMnDN/tFq3zdNg==
X-Google-Smtp-Source: APBJJlH6LRLHMYyUPxbbdYvBigh0lZYZNWQkOWBwTlewLNCo9+ByxiwgI6ui0oTlneWmcU3cOv+tL80ENg/9TN3zB+o=
X-Received: by 2002:a2e:7a19:0:b0:2b9:4841:9652 with SMTP id
 v25-20020a2e7a19000000b002b948419652mr1723353ljc.25.1690385044959; Wed, 26
 Jul 2023 08:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230726002904.655377-1-yosryahmed@google.com>
 <20230726002904.655377-2-yosryahmed@google.com> <ZMCBzUH7qIdc3Y2X@P9FQF9L96D>
 <CAJD7tkZDpni+VM61i-jUgvn=TkZ5CySotTmUAFQPwMSjDfOEWQ@mail.gmail.com> <20230726152055.GC1365610@cmpxchg.org>
In-Reply-To: <20230726152055.GC1365610@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 26 Jul 2023 08:23:28 -0700
Message-ID: <CAJD7tkb6SmCDLDSCciPfXGK7Z_zyr4vh_XKvhysL6pci88WjKw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
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

On Wed, Jul 26, 2023 at 8:20=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jul 25, 2023 at 07:20:02PM -0700, Yosry Ahmed wrote:
> > On Tue, Jul 25, 2023 at 7:15=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> > >
> > > On Wed, Jul 26, 2023 at 12:29:04AM +0000, Yosry Ahmed wrote:
> > > > Currently, memcg uses rstat to maintain hierarchical stats. Counter=
s are
> > > > maintained for hierarchical stats at each memcg. Rstat tracks which
> > > > cgroups have updates on which cpus to keep those counters fresh on =
the
> > > > read-side.
> > > >
> > > > For non-hierarchical stats, we do not maintain counters. Instead, t=
he
> > >                                                 global?
> >
> > Do you mean "we do not maintain global counters"? I think "global" is
> > confusing, because it can be thought of as all cpus or as including
> > the subtree (as opposed to local for non-hierarchical stats).
>
> "global" seems fine to me, I don't think it's ambiguous in the direct
> comparison with per-cpu counts.
>
> Alternatively, rephrase the whole thing? Something like:
>
> "Non-hierarchical stats are currently not covered by rstat. Their
> per-cpu counters are summed up on every read, which is expensive."

Rephrasing sounds good to me.

I will send a v3 with the correct commit log and collected Acks to
make Andrew's life easier.
