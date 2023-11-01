Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5852A7DDAA8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377020AbjKABlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjKABlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:41:47 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE0BED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:41:45 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a69a71cc1dso226882739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698802905; x=1699407705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBro9oe1zZ628ykQDCAf+JGt6uQlYsotXXea9Ml/Ecg=;
        b=JPjvenVDE9wb8glY2N3q8K6d3R4WZHOS4QHRVfJQIwJc2vuCpQZ3j+B0gtWwVufNOI
         2oSf63XGpInEEp40/YR1yEJVByJvCQpdIbQLGAREzFE8U2EMOuw/GHeZp1tFf3n5vHO3
         lSOSnmOkBmnp4uT4/AgyqlVCaQ52kU3U5shX3ByCdj//27pFnN762XF54VSnixLNqvWo
         4a4CEH18EpYV1/QI1cQAWNtkfk3UKL3UIPy5MMfDnRz0T9N/NA8B6Gir2uTn5GQU6aMn
         f64nzyls0vvf8fE6LSfxgHemgds7wXArJGEx7kzOdoecpMAlPLHs9uMkGot+hPXNc3iN
         Qxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698802905; x=1699407705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBro9oe1zZ628ykQDCAf+JGt6uQlYsotXXea9Ml/Ecg=;
        b=S1ZRcA3HP1z3DprTkZpQQabCT2V+K8z5ak4GPZCwnqz2CqH6EY/Fh+qCiVJq7E3YfZ
         Xav1QmZMdXVQ1hgmi53pcYLZ9lJ+0ryqCYvv2mpREL3bBTM2jouVANTjywzfWIlOT7LV
         GFtwfgxasWTs36SoumO5kZ04jXBrXb3uwNdPLglCMTqv5hkSvqzrCERWGqBzLg8ix4Q3
         nYgMRYB98H8FQ74mRaDx1Z8Q2u0pm6sWTpFhhlL0oCtN6wLEPQ8Nan3U//U5NAuSfxNo
         CqiM0Cghp+Zgx/hkFxk1C7k0W9ezrETz9/iBoys1EPIwkT4G7whgANS1gXp8tj77G03d
         bq5w==
X-Gm-Message-State: AOJu0YwBxJ4teIfDqBx4Zc3Lq0jrrQWXEKp283Te/WiZIuRRatzChGWK
        AQqZIxBaIavv08japBIgSOafCSJOWRPZIEl301JFI1ZYsgQ=
X-Google-Smtp-Source: AGHT+IFcLCrOGmA9ztpEwfKMHuMNJuvYheXneWeTkMPZswyZG+bUfW17ZWq1pqW3GmAZbWmjH6EFqFHzSB+zb1p1iVg=
X-Received: by 2002:a05:6602:3c8:b0:7a9:b1c9:4380 with SMTP id
 g8-20020a05660203c800b007a9b1c94380mr18950530iov.1.1698802904942; Tue, 31 Oct
 2023 18:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231024203302.1920362-3-nphamcs@gmail.com> <20231101012614.186996-1-nphamcs@gmail.com>
 <CAJD7tkZV9NaPUzjZYQAx=D-vDEXZH46=Dn5zEuMHnsybT+HLAw@mail.gmail.com>
In-Reply-To: <CAJD7tkZV9NaPUzjZYQAx=D-vDEXZH46=Dn5zEuMHnsybT+HLAw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 31 Oct 2023 18:41:33 -0700
Message-ID: <CAKEwX=N3MsBJ2YW7N=am4MSAqZC5O32Ooz96ec_J_RyhCts=qg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] zswap: make shrinking memcg-aware
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org
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

On Tue, Oct 31, 2023 at 6:33=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Oct 31, 2023 at 6:26=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > cc-ing Johannes, Roman, Shakeel, Muchun since you all know much more
> > about memory controller + list_lru reparenting logic than me.
> >
> > There seems to be a race between memcg offlining and zswap=E2=80=99s
> > cgroup-aware LRU implementation:
> >
> > CPU0                            CPU1
> > zswap_lru_add()                 mem_cgroup_css_offline()
> >     get_mem_cgroup_from_objcg()
> >                                     memcg_offline_kmem()
> >                                         memcg_reparent_objcgs()
> >                                         memcg_reparent_list_lrus()
> >                                             memcg_reparent_list_lru()
> >                                                 memcg_reparent_list_lru=
_node()
> >     list_lru_add()
> >                                                 memcg_list_lru_free()
> >
> >
> > Essentially: on CPU0, zswap gets the memcg from the entry's objcg
> > (before the objcgs are reparented). Then it performs list_lru_add()
> > after the list_lru entries reparenting (memcg_reparent_list_lru_node())
> > step. If the list_lru of the memcg being offlined has not been freed
> > (i.e before the memcg_list_lru_free() call), then the list_lru_add()
> > call would succeed - but the list will be freed soon after. The new
> > zswap entry as a result will not be subjected to future reclaim
> > attempt. IOW, this list_lru_add() call is effectively swallowed. And
> > worse, there might be a crash when we invalidate the zswap_entry in the
> > future (which will perform a list_lru removal).
> >
> > Within get_mem_cgroup_from_objcg(), none of the following seem
> > sufficient to prevent this race:
> >
> >     1. Perform the objcg-to-memcg lookup inside a rcu_read_lock()
> >     section.
> >     2. Checking if the memcg is freed yet (with css_tryget()) (what
> >     we're currently doing in this patch series).
> >     3. Checking if the memcg is still online (with css_tryget_online())
> >     The memcg can still be offlined down the line.
> >
> >
> > I've discussed this privately with Johannes, and it seems like the
> > cleanest solution here is to move the reparenting logic down to release
> > stage. That way, when get_mem_cgroup_from_objcg() returns,
> > zswap_lru_add() is given an memcg that is reparenting-safe (until we
> > drop the obtained reference).
>
> The objcgs hold refs to the memcg, which are dropped during
> reparenting. How can we do reparenting in the release stage, which
> IIUC happens after all refs are dropped?

Oh I meant just the list_lru reparenting. The list_lru themselves
don't hold any ref I believe, right? Then it's safe to perform this at
the release stage.

(also, I think I might have messed up the encoding for the email
above. Let me know if people cannot view it, and I'll resend it :( )
