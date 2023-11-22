Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB27F3E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjKVGn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjKVGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:43:26 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EEAF9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:43:22 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so85844571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700635401; x=1701240201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uRNxGcgpOf3kB+VZZJCqD3x4MZNwnwcErCoCSbGzaE=;
        b=R9dffkDIJVdZLFiyfhAsMXlySD/tZlYWzFVxij0E4/5bORt3O4nBWUf704z3ITXxs0
         xKmlvW0EUbkzUBKbKj7sKv9/0gQF0Fwq4guL3iQ5wyDz5vX5AbRP7B499WdLw0+F+Tb9
         YAoeo34N0HlosCK5kbFICFu36j2O0P12d69nKdBOn1C2Dn2WcFon0P0Nv7nbtn9ENRwN
         dKEa/h7OuZM5iGOHqBNHuviOODjbgG/uiYLaec/5aYdFXo04B8DZ9M8OrBODhPxLpKqY
         Dt2W0L5Gr0yVHhAcgSdkmwYPBSe3pRvImWQ0jBWNYqPVQY7mhHA6BvtfXt7rb6Ls7ix0
         Zyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700635401; x=1701240201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uRNxGcgpOf3kB+VZZJCqD3x4MZNwnwcErCoCSbGzaE=;
        b=taiuNJWgQI8gsD+6EOhkYIPoGNV/CEknWy6p5GjZ++UWqcFwrSKnt8l/syArK8FCVl
         SwWtahpzhte++VNlgxPMTofiuC0ZpTfWtCbUAEUCfZtRw76Sgg7Tf2wIjLH8ke1wl3v8
         V7uBDhJFotGQ5u/K9xMVwMB781Xze3dX9B/TKqd7ykpAhYjjc9OrGghS/Bo3BWsljD0C
         gXup8tcBz3aeFUoB9qLaqoIbR5Hpvd1mhYHBKOcv7LQMK/W/dyFC61Kiau021pPCodYe
         0TMsYtjapdSOH83Qjg0tmqS/r/sa2+IeSXtZFE+8wuWPlFQnTFBeKAPeYZRqAuNRkw6/
         suiQ==
X-Gm-Message-State: AOJu0YybpmaYhOEltVVDPnHxOCwufG5wAPeFFCVwgkhMoMLMdHJtjLkn
        I5fGyTUAFpQtAsj/ZCTmASeMzcJ6jUBpKUagzMY=
X-Google-Smtp-Source: AGHT+IGSUqKgWEL+EYO/kobnJgdaq8c8AP53UBRrYJkvO09xGuE3mMLoFP9slL9nLe+LjIgFiNa0ZRd/A7hy6P+p0Y8=
X-Received: by 2002:a2e:98d5:0:b0:2c5:174b:9a53 with SMTP id
 s21-20020a2e98d5000000b002c5174b9a53mr842521ljj.26.1700635400512; Tue, 21 Nov
 2023 22:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <CAJD7tkYXcQkTZkUnAz89dR0O1YmEUr29UFeg3142t6Y09aaSpg@mail.gmail.com>
In-Reply-To: <CAJD7tkYXcQkTZkUnAz89dR0O1YmEUr29UFeg3142t6Y09aaSpg@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Wed, 22 Nov 2023 14:43:02 +0800
Message-ID: <CAMgjq7DgHvcU6gTWhzPY8By8DCx5TzYViKaiuSSxh-zofuV1HQ@mail.gmail.com>
Subject: Re: [PATCH 00/24] Swapin path refactor for optimization and bugfix
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=8C 03:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > This series tries to unify and clean up the swapin path, fixing a few
> > issues with optimizations:
> >
> > 1. Memcg leak issue: when a process that previously swapped out some
> >    migrated to another cgroup, and the origianl cgroup is dead. If we
> >    do a swapoff, swapped in pages will be accounted into the process
> >    doing swapoff instead of the new cgroup. This will allow the process
> >    to use more memory than expect easily.
> >
> >    This can be easily reproduced by:
> >    - Setup a swap.
> >    - Create memory cgroup A, B and C.
> >    - Spawn process P1 in cgroup A and make it swap out some pages.
> >    - Move process P1 to memory cgroup B.
> >    - Destroy cgroup A.
> >    - Do a swapoff in cgroup C
> >    - Swapped in pages is accounted into cgroup C.
> >
> >    This patch will fix it make the swapped in pages accounted in cgroup=
 B.
> >
>
> I guess this only works for anonymous memory and not shmem, right?

Hi Yosry,

Yes, this patch only changed the charge target for anon page.

>
> I think tying memcg charges to a process is not something we usually
> do. Charging the pages to the memcg of the faulting process if the
> previous owner is dead makes sense, it's essentially recharging the
> memory to the new owner. Swapoff is indeed a special case, since the
> faulting process is not the new owner, but an admin process or so. I
> am guessing charging to the new memcg of the previous owner might make
> sense in this case, but it is a change of behavior.

After discuss with others I also found this is a controversial issue,
will send separate series for this, I think it needs more discuss.
