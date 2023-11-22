Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019F7F3E50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjKVGql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjKVGqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:46:38 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92FFB9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:46:33 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so571631e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700635592; x=1701240392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLpj7I2dn2hL6qNFfAxI4zgm0V/CFVJO01lnaJ3CWag=;
        b=UUV77lNVEHihm6IglVrJuxSlqmv99q3UeIzyMm06ypreVwH6t+csVP4qkWsKywgIgA
         t/edDlB5UfLKBbr2NiU3CwQd9l0Pn9Df/AmL3fw8bC0O1EEP76L1tJU0Zl6kEFXgYJt+
         FSdDxMl80uMJNIpkwYoz5OZv9FvpKFIHatN7GClI2czQZCeo0Jr+gp9LpV/XDtEg9idN
         +BKbMrYTwvzgreVOYx4x4b9y92rbdOLHcwnSJ7x3rGFRvT51T5nyQIlC39FrgmgmUmJa
         FL29/4WAimeUnXOVVZsMrhk+Cq8+OLwyFurKpXc+X24b2N/61Eu3TokICZaDnFwqNXo1
         XPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700635592; x=1701240392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLpj7I2dn2hL6qNFfAxI4zgm0V/CFVJO01lnaJ3CWag=;
        b=sADoDjhujy37POUcCdGwzRUTfjh2RbuuO3ug3ZE4SRh27V4GNwHLHoA4Y2UqI9aFl6
         lJdlDk2rAe+njvUiJcRWoH/hsxBznYk+ZFNe7XkJqvsXEQtdFtMnTOebg1BOQ0s8l/Z4
         flKk1dGtfRd7At8eywcabLbnbMaKaCAqHwIwl461drixkk237Ui3paQaiNOSoxWyECHX
         pheRd4wlpwSch8578esLx2sGeZR4Y+wRCRP3f4S7R/ZzTC9cy1oKnd02QOsP5DPC9gMe
         tn90Qd0YzwEECrdTJhoG+i2DjSaXqibH2HQdU9CVUFF80Yos9EuF+5i3s8RC8IB7ml49
         EY6w==
X-Gm-Message-State: AOJu0YyU41KVydMTMh7aBngmQL6n3Canb1x44yc/uqHoB7x/t55i7Qnd
        B4x1rbHWY+4NhIuZhA068NFBsNZg+C6oBYYbVoA=
X-Google-Smtp-Source: AGHT+IFlkkWDAkupiUpy/GhOtUb8PgZAwdVLENmzaDv8yP4v9hdXBesgirzRpdNoBhVERrGyzGcRmXrZHX5NeL3iKXo=
X-Received: by 2002:ac2:5d66:0:b0:50a:9ef7:531c with SMTP id
 h6-20020ac25d66000000b0050a9ef7531cmr1284854lft.33.1700635591863; Tue, 21 Nov
 2023 22:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <CAJD7tkYXcQkTZkUnAz89dR0O1YmEUr29UFeg3142t6Y09aaSpg@mail.gmail.com>
 <CAF8kJuNWj_2tQA+0D-hpQgeJwWZRaQWxOCF=qagFnA8+yb3R1Q@mail.gmail.com>
In-Reply-To: <CAF8kJuNWj_2tQA+0D-hpQgeJwWZRaQWxOCF=qagFnA8+yb3R1Q@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Wed, 22 Nov 2023 14:46:13 +0800
Message-ID: <CAMgjq7CyRa9Sz7ri+L0Nz=GVOqFtyWt6dKont0Kvks6K5Ei45g@mail.gmail.com>
Subject: Re: [PATCH 00/24] Swapin path refactor for optimization and bugfix
To:     Chris Li <chrisl@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C 04:23=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kairui,
>
> On Mon, Nov 20, 2023 at 11:10=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > This series tries to unify and clean up the swapin path, fixing a few
> > > issues with optimizations:
> > >
> > > 1. Memcg leak issue: when a process that previously swapped out some
> > >    migrated to another cgroup, and the origianl cgroup is dead. If we
> > >    do a swapoff, swapped in pages will be accounted into the process
> > >    doing swapoff instead of the new cgroup. This will allow the proce=
ss
> > >    to use more memory than expect easily.
> > >
> > >    This can be easily reproduced by:
> > >    - Setup a swap.
> > >    - Create memory cgroup A, B and C.
> > >    - Spawn process P1 in cgroup A and make it swap out some pages.
> > >    - Move process P1 to memory cgroup B.
> > >    - Destroy cgroup A.
> > >    - Do a swapoff in cgroup C
> > >    - Swapped in pages is accounted into cgroup C.
> > >
> > >    This patch will fix it make the swapped in pages accounted in cgro=
up B.
> > >
> >
> > I guess this only works for anonymous memory and not shmem, right?
> >
> > I think tying memcg charges to a process is not something we usually
> > do. Charging the pages to the memcg of the faulting process if the
> > previous owner is dead makes sense, it's essentially recharging the
> > memory to the new owner. Swapoff is indeed a special case, since the
> > faulting process is not the new owner, but an admin process or so. I
> > am guessing charging to the new memcg of the previous owner might make
> > sense in this case, but it is a change of behavior.
> >
>
> I was looking at this at patch 23 as well. Will ask more questions in
> the patch thread.
> I would suggest making these two behavior change patches separate out
> from the clean up series to give it more exposure and proper
> discussion.
> Patch 5 and patch 23.
>
> Chris
>

Hi Chris,

Thank you very much for reviewing these details, it's really helpful.

I'll send out new serieses after checking your suggestions on these patches=
.
