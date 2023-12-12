Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7380F62D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376964AbjLLTLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjLLTLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:11:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF589F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:11:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d08fba6a49so20375ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702408307; x=1703013107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIguWzkvYltOpnG/cXi7wP26kF3E2cDcptp5e/K12Jo=;
        b=XwK8wiElneYQmXQCEI0uagFXqXTIlXCPeUtQPeaRulax3ajANE6SN0FXuG42DyxADf
         JYqTdjFPcfFfy3mRXtoCzp25wPc2BgTL+qU6d2O6gUxoSTm3tv+Zdhur1hHVXEDJBldN
         crPO15PNVePWr79483AfOJlHCGunkos+Uj5p/6F4++YXIK1+Q4xAPZg5Gg+s5RAsSv8O
         QvhnRRBesVNHPsSusITfD3/GJnm5bRsItDrOp8Xe8I01SU/i58AO6UjsLK8yS8wNGXsC
         suCZ03qz1Gx2Fr3cF87WR6fOQIwMidtHGMITWJcgImiAPHH7P+hOJVzHIGko04zPMFCY
         JCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408307; x=1703013107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIguWzkvYltOpnG/cXi7wP26kF3E2cDcptp5e/K12Jo=;
        b=HqrOObMpdB0pwGd0Q0H75zbmN8Fpxgj4c5KvhNHcZkyOckMriUSS8baKragk6jkAn9
         jbU1sHtbix3WL57XzSGi7qBwzK9JPzJUchzxJ79ZRgwPwlguF3Djla6GNQhyOd2QXt58
         4NSdB6czkda/hktNxhPycG6R0Oj0kDG/zCfoq0Wlq6QzP2KeiuWlbm1pCVU0lI7xHGzq
         YBX2xJSl+9/8QbjRNBqMDXPVFhRrU0QMFs6d1Wg75DzC0XK2fXHjRTKnRdslFIv2Wc6i
         LrvOPENA8vTuscT1UxbzVGsI8MdWwaJ0v5TyPeGv9UcPxcAm+jRRKXB58tvIdrBdEElp
         1R9A==
X-Gm-Message-State: AOJu0YxVfB9pXwysN+Lg36zAB1bImQZolAI7uEQniHoS5obMH43bO4Rv
        F66HysUK75o4VM7H8FOJnTqPJJHGqG8yXqbR0yMTyA==
X-Google-Smtp-Source: AGHT+IHt0Qmog3mUK5T+kUE0Q2Kof6YqrUXeTpM7Ux6Zk+sJp0dumG1J+s5VjauZ8OeIU0gS8MCxg1ZOOAnY4ZGrZCw=
X-Received: by 2002:a17:902:dacb:b0:1cf:aa8f:56b3 with SMTP id
 q11-20020a170902dacb00b001cfaa8f56b3mr896582plx.24.1702408307029; Tue, 12 Dec
 2023 11:11:47 -0800 (PST)
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
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Dec 2023 11:11:35 -0800
Message-ID: <CALvZod6LcJbAQYpV6jnX=tWbJe-4i9guAax1E71gG7Q6OfVoBg@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Wei Xu <weixugc@google.com>,
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

OK from me.
