Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1C812672
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjLNE3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjLNE31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:29:27 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D328109
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:29:33 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1f8a1e9637so41192366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702528171; x=1703132971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrJKnh7rQalxBTETxx0mDtTP7C8D7JFwx9paPElxJ0A=;
        b=iZ7iI1c0bscnoDKVDtwt6c43pv5OEWCCzNMHqdJwwZWhs4XPkRWqmhmCMtuogzGclX
         V4GZTR/6x0nTqrcQnogIj+ab8/Tx+y9oGkMZuU5ZDcm+GRuZDQvuIpi+LtSHH5FdfZfk
         gcnl5c+1x4ZSyiW6pwzJ9dLAUdhmChWU1h2M2CcDcYEfE9YJ09Kf8oSfo7Nt1PtogDJh
         h6q+X9l5aG3vgS91hXRqZdQiXxtVir6jSmhXTfiAk0ayrCNck0G5cekK3SkClUU9kVjV
         pB8sT/3Ij6JuHrufjr1UaAiWy5XHUEEwEPzRcKPBzQMwFmunPuUR9ewUYLdbV2ASvLL5
         6R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702528171; x=1703132971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrJKnh7rQalxBTETxx0mDtTP7C8D7JFwx9paPElxJ0A=;
        b=rEsMsW1OgOvo1Z4SCnS9lnJL/zHgoyxxGCehx1tbrflN4eZGVAJXgTsI5dzQGdY2Dd
         P0nDl0m4Ly2aUsOP3FREaP02J3RrC3KaEvNOds6Udq96ODVZtT2nZdq/gF6Qg6vZsSzT
         d0gYTLyAu28M6cwaH3OlGdqKm3lcYmVp6ocLBiCsL20KgIi8fDMT8DyXisL3eeyWtLoi
         dp3ZKl06PTOjllfSwS4oW2O8HWJp5uk5grDc4oqC/LqebAswXA9r1fTIlHB04anSmnX7
         2GlCJVUBsPYKAxwnaLVboYsHreKQ2QBkIHSrFtAmgFlkxdRMsR6SiKQuYgtE9fx3QkkE
         MtXw==
X-Gm-Message-State: AOJu0YzgOI+krAORyGqXhJY9eI8n/5fumT0t7CgHI7WYN93ATDaUO1N5
        Bjf+bN0j0EOy/mCUulzhHPaDkXweFBX85kPeltqDLQ==
X-Google-Smtp-Source: AGHT+IF2ysdaKi0/4cWuvP0ESjKBjqyr35uOzZgLtm21MWAnyPwgiig7C13qI6K6cwlt+VbUCfaj23WiFvcTno8KwPI=
X-Received: by 2002:a17:907:b5a2:b0:a1f:6ead:c119 with SMTP id
 qx34-20020a170907b5a200b00a1f6eadc119mr9472498ejc.21.1702528171233; Wed, 13
 Dec 2023 20:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com> <CAOUHufarKA5-NGErYzvqeKKJze1XSUcMx4ntBHx2jmAUeqAioA@mail.gmail.com>
 <ZXneCaeJjHvFvecK@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZXneCaeJjHvFvecK@dschatzberg-fedora-PF3DHTBV>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 13 Dec 2023 20:28:53 -0800
Message-ID: <CAJD7tkY3t92A2ky4788hNBBZFafNeOjy_F6+E+62mySB5UGYug@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
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

On Wed, Dec 13, 2023 at 8:38=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> On Tue, Dec 12, 2023 at 07:05:36PM -0700, Yu Zhao wrote:
> > On Tue, Dec 12, 2023 at 6:39=E2=80=AFPM Dan Schatzberg <schatzberg.dan@=
gmail.com> wrote:
> > >
> > > Allow proactive reclaimers to submit an additional swappiness=3D<val>
> > > argument to memory.reclaim. This overrides the global or per-memcg
> > > swappiness setting for that reclaim attempt.
> > >
> > > For example:
> > >
> > > echo "2M swappiness=3D0" > /sys/fs/cgroup/memory.reclaim
> > >
> > > will perform reclaim on the rootcg with a swappiness setting of 0 (no
> > > swap) regardless of the vm.swappiness sysctl setting.
> > >
> > > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> >
> > NAK.
> >
> > Please initialize new variables properly and test code changes
> > thoroughly before submission.
>
> Could you be a bit more specific? The patch is compiling and working
> locally but perhaps there's some configuration or behavior that I
> haven't been testing.

scan_control.swappiness is only initialized from
try_to_free_mem_cgroup_pages(), which means that swappiness is now 0
for all other types of reclaim, which can be a huge problem.

It might be easier to restore a special value (-1, 201, whatever) that
means "use mem_cgroup_swappiness()".
