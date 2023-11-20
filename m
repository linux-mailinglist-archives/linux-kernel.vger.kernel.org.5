Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC27F11C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjKTLTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjKTLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:19:19 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F276FC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:17:56 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c88750e7d1so2562671fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700479074; x=1701083874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V2XDX61NY0tOMnwnrDCDr7g/yBsZgaDtQvnBOTZYnU=;
        b=E+x/GA9OrDl+OiOsvuYtGIzEJYjGJ3X4QV+jQa6vo2XWc5+teCsEJrSFQTZ5/JQ8E0
         PfgEwdF0/izTFNMGoW9KkuWMrfMiByLbCsp7flgU+6GOIfF5FJc8UN9s4/3QuRWMI/12
         zkdRbtC7jmDcpKd3A421TtkMKD4WsyVXwhu6HnEDMasrX4/0DH5kbvmkeg5GTGPd+Wgw
         RTiYmhA/HvOyAK3pYKkgC8+r9VCGrP8RY2c5xrcV43tlxLzUDc3TxHzA1AF96aau40XQ
         CknjWhl6qqFZb4114USjQmSnGIo+IS0kuJmixOmMy8Qqtp/LadKjCaK6sjS8pRqDMq0k
         Iwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479074; x=1701083874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V2XDX61NY0tOMnwnrDCDr7g/yBsZgaDtQvnBOTZYnU=;
        b=MeiFQOxbKvFbtckk/peypVHidPjxSAHSnp2jFM0OR7CF+394SxCk4OCJyccTnz8U7j
         b77Q5Hp2Wg6o8b+WRJMJlJJ0JrNniCmyW4SooFBAoeK6PYi2yo1at54QUYYEXpz9/qdR
         YJcTXp5x9LwPSW3JYd7Xxi02jSZaKNUwHZuHIqdIn0IzsUpsCyhKihCjMYzjBvk2ZmSP
         /3QMiMoKgv0ShpCyExIlUymlE4jR7UPvuRc6DPQ5M+cTqJzE6teFBfydCveShGW32gsG
         RIe/KKNEk9LzvYE8y8Ylfw1NsI2EXL2BGgnzi6P1U8I8uKdR0v6BrK9Yc9xfQ5ajwD4D
         YVzw==
X-Gm-Message-State: AOJu0YykUXHmVG2lchZC0GCZv4/CL0PxkZFad2qeECoZm5Lnz8tGiuuG
        MbFHZX5wrcFfNleUrHhfx1HN8mybkvHgEkWYapY=
X-Google-Smtp-Source: AGHT+IHVVN+CkY38GkgyVOlVqVlrcWmFlktP5IlMWMAbCfzH8W+BumO4kHgH/wjFPhhgU7yFdBvSD+5vP8/jVOmmMos=
X-Received: by 2002:a05:651c:2209:b0:2c8:87fe:2f4e with SMTP id
 y9-20020a05651c220900b002c887fe2f4emr112425ljq.8.1700479074189; Mon, 20 Nov
 2023 03:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-24-ryncsn@gmail.com>
 <87msv8c1xy.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87msv8c1xy.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 19:17:37 +0800
Message-ID: <CAMgjq7Ahh2HVA0ym2t0UdX=FYQ52mrKXDueK5GeNK9=2h+adwQ@mail.gmail.com>
Subject: Re: [PATCH 23/24] swap: fix multiple swap leak when after cgroup migrate
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
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

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 15:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > When a process which previously swapped some memory was moved to
> > another cgroup, and the cgroup it previous in is dead, then swapped in
> > pages will be leaked into rootcg. Previous commits fixed the bug for
> > no readahead path, this commit fix the same issue for readahead path.
> >
> > This can be easily reproduced by:
> > - Setup a SSD or HDD swap.
> > - Create memory cgroup A, B and C.
> > - Spawn process P1 in cgroup A and make it swap out some pages.
> > - Move process P1 to memory cgroup B.
> > - Destroy cgroup A.
> > - Do a swapoff in cgroup C
> > - Swapped in pages is accounted into cgroup C.
> >
> > This patch will fix it make the swapped in pages accounted in cgroup B.
>
> Accroding to "Memory Ownership" section of
> Documentation/admin-guide/cgroup-v2.rst,
>
> "
> A memory area is charged to the cgroup which instantiated it and stays
> charged to the cgroup until the area is released.  Migrating a process
> to a different cgroup doesn't move the memory usages that it
> instantiated while in the previous cgroup to the new cgroup.
> "
>
> Because we don't move the charge when we move a task from one cgroup to
> another.  It's controversial which cgroup should be charged to.
> According to the above document, it's acceptable to charge to the cgroup
> C (cgroup where swapoff happens).

Hi Ying, thank you very much for the info!

It is controversial indeed, just the original behavior is kind of
counter-intuitive.

Image if there are cgroup P1, and its child cgroup C1 C2. If a process
swapped out some memory in C1 then moved to C2, and C1 is dead.
On swapoff the charge will be moved out of P1...

And swapoff often happen on some unlimited cgroup or some cgroup for
management agent.

If P1 have a memory limit, it can breech the limit easily, we will see
a process that never leave P1 having a much higher RSS that P1/C1/C2's
limit.
And if there is a limit for the management agent cgroup, the agent
will be OOM instead of OOM in P1.

Simply moving a process between the child cgroup of the same parent
cgroup won't cause such issue, thing get weird when swapoff is
involved.

Or maybe we should try to be compatible, and introduce a sysctl or
cmdline for this?
