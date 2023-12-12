Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C471F80F809
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjLLUo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjLLUo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:44:56 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B49F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:45:02 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1ec87a7631so550666666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702413901; x=1703018701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE8RZVsLlDqV/tHQsV0pBVubgKNBa3FvWZVPRZsHSAs=;
        b=LFusca8XEG6vrc3V0kseEDVsm0MbUCjDN0LEI/ctRNOu2pVNuRhQOWy3mZHsoa3t+I
         adrd2ru3IIB+y2uQMG1rHZVp/l1KHFDF5Z++MoHSE81mkunSvf4gENnnlT27Jwpot/RG
         dEZB3MM63a1laGc0nDLEaUBqKz97rcHNwTYP8ZbidsVeRO1LjOuVLzIO2U6S2fyxRLiR
         YctSEuzLUuvrJvn64LY/3uKRMNmI72fF7yYRvyL3jDSLbR+6nLjSr3Olat/YtcT7HZtz
         iXKMU+eBQCN6hq1U3t5cOukwJpQTTz6x73eLXqQD2lnCRsOvjStapkMc8XRPm1mmYqJI
         1Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702413901; x=1703018701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE8RZVsLlDqV/tHQsV0pBVubgKNBa3FvWZVPRZsHSAs=;
        b=E+l26+cNb/kAAmaHCo/npVRvBKmjNQ8wMjjWXeZI1O326CljzeJYhTPjeGMebOdQ1Z
         SCHJ6YJijPiwvsseGbHuLh+r76/l+n7VQ473S45mKkg8hYNDXx+cbMsl6ePRGxaghKeW
         e9I4ldKZKo/7S9pBWxX/VNMWWZb6fEvc8Hc0hg246wyVclTuerO7oRcICtDn8dJBwW6r
         nHCzvZYBSWecpDbyMILMtGAcA438tZLHO21Bo0kgJatOidVFqb0FhFeTNrHjtGbwTjO7
         /13MgRWSg5wCFJupMEfIXiQCKzTG3PN4eV3AoAsnaKBEY4bcaH0gQpXn69JHmlzNPS9f
         aC3w==
X-Gm-Message-State: AOJu0Yz3SL56Mi9yo+jyHBaWTfN6T0n6qhyN/GHPtGh2dfw03mvdyb+4
        55mfjNZXGHws3Ysdfz7VDYXC+MsN1UgQGNa4S9vKnw==
X-Google-Smtp-Source: AGHT+IFAT5lsVwBH0E1qAd8i6cYOV214omt1/uBJz3rz4Sjo68LKbG5FT2JF7Tj9rLm3fl0eLDj2fJFUKGMgaDUislQ=
X-Received: by 2002:a17:906:5992:b0:9da:ee00:a023 with SMTP id
 m18-20020a170906599200b009daee00a023mr3752550ejs.30.1702413900702; Tue, 12
 Dec 2023 12:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
 <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
 <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
 <CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com>
 <CAAPL-u-Futq5biNhQKTVi15vzihZxoan-dVORPqpov1saJ99=Q@mail.gmail.com>
 <CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=tZZjJHj=dzD=CcSSpp2qg@mail.gmail.com>
 <20231204235856.k4izppfsrpg2rng7@google.com> <20231212104355.ba052748471e1e0ce5cc35a0@linux-foundation.org>
In-Reply-To: <20231212104355.ba052748471e1e0ce5cc35a0@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 12 Dec 2023 12:44:21 -0800
Message-ID: <CAJD7tkY-+2OzncG7kK=rkw3sAK6oAMHkoZuv8+vnxmt6N3ECgw@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:43=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 4 Dec 2023 23:58:56 +0000 Shakeel Butt <shakeelb@google.com> wrot=
e:
>
> > On Mon, Dec 04, 2023 at 03:49:01PM -0800, Yosry Ahmed wrote:
> > [...]
> > >
> > > From 19af26e01f93cbf0806d75a234b78e48c1ce9d80 Mon Sep 17 00:00:00 200=
1
> > > From: Yosry Ahmed <yosryahmed@google.com>
> > > Date: Mon, 4 Dec 2023 23:43:29 +0000
> > > Subject: [PATCH] mm: memcg: remove stats flushing mutex
> > >
> > > The mutex was intended to make the waiters sleep instead of spin, and
> > > such that we can check the update thresholds again after acquiring th=
e
> > > mutex. However, the mutex has a risk of priority inversion, especiall=
y
> > > since the underlying rstat lock can de dropped while the mutex is hel=
d.
> > >
> > > Synthetic testing with high concurrency of flushers shows no
> > > regressions without the mutex, so remove it.
> > >
> > > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> >
>
> I'd like to move this series into mm-stable soon.  Are we all OK with tha=
t?

Looking forward to that :)
