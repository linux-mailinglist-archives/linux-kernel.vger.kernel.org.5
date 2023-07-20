Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235B475B5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGTRcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGTRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:32:20 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF7CC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:32:19 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-cefa8fe4cc2so965897276.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874338; x=1690479138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7AsfnIKmvyvCsY6eDxujX+cY5xcSctl9uuvFHitDZk=;
        b=SNcnLekrZaJog6vk/L9FFl7FENC68LdFzyguxofqO5rjDrFBU1VyfCTUCGu5pl40YD
         x1CoIbXBVOvEaRxzsaebCQy8Wh459IA4W4f2QrbvLJeyRGhOtxZHIlUe28Vvs95ELCUB
         9JLC7/XkBK8T1IsdCbsmIqoX3HYjJd/vTctzd1AWOiaF8ChN7x+u/HjcOaH+JqdUq0Cd
         eKML85R4ZCOO36K/1Ms1hwC6yT2N6ZzKzGYuDNnaHZ82GF87Oqv9TftafmpTKiMQQJQ8
         dCd/Nh1LCQLZdbQjpC+9EJ3Qni/xFEwPRwW0+u8zo1QwxV5TnDqwiY6I+lNZy2wjMQZB
         OElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874338; x=1690479138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7AsfnIKmvyvCsY6eDxujX+cY5xcSctl9uuvFHitDZk=;
        b=j9Jogk0uKu0T8EkHeiNNbOSIX3TWsFkCZwB0vkD2m7QfYGrhrsN3TUwjglkDgadjs2
         KCAoTMpfQeRimbVDgXvNjBKLWvZzdwSCcEzuUHb9vQcBTiTuLTNyJhwFEmJCMsecRiKm
         e4k1/6+orUnV9MzX3v2sa96kq85Ff5mH16wvFdYKGOMagtQA3wPCXWFPnETsZgosIA6h
         erpj3F3NrSlENvDdvUyZrMvTqE7D/kmjfC8Tm7RmUEjU6qJERyL3sZt0GIyuB67O3KBf
         YZ2994A4eFxHToZ6Tjg1nuaw6WkRyFhmxlyVSa2uNNGgkqYqmEMRpQ+B7xQ+Go5AwsJl
         BNJA==
X-Gm-Message-State: ABy/qLaNNqTjJLiGUd/daROjmBLOmBm3svcyNyAy5vsSyeD1jkmx6HXf
        vghWLC2zgL6m5VAS1ngkl54DKRDWoTm3Id+d3+ZKJg==
X-Google-Smtp-Source: APBJJlEFop1syaIXXs0KPjhh/vJPKg2FJq6CjVuGelPVbfq1a04Opzv5Nq7Gm+9/RLEq0m7QQ7FqN73if5Ra1FCwTY8=
X-Received: by 2002:a25:8046:0:b0:c18:4f16:aaf6 with SMTP id
 a6-20020a258046000000b00c184f16aaf6mr5473058ybn.58.1689874338052; Thu, 20 Jul
 2023 10:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230720013249.199981-1-jannh@google.com> <CAJuCfpEs=jwaJEJQV9=Qo4h9JobrR1S=vETy1h8Q7TfS3eF_Qw@mail.gmail.com>
 <CAG48ez0MSS47TkrV47R9P7uXtOgrLW3_hK0Od263JZmBoiczVw@mail.gmail.com>
In-Reply-To: <CAG48ez0MSS47TkrV47R9P7uXtOgrLW3_hK0Od263JZmBoiczVw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 Jul 2023 10:32:04 -0700
Message-ID: <CAJuCfpGZQP3ozqxTRnpE8esNQCBCkUgmYr2miT9Ss5VzbZukyw@mail.gmail.com>
Subject: Re: [PATCH] mm: Don't drop VMA locks in mm_drop_all_locks()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jul 20, 2023 at 10:14=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Thu, Jul 20, 2023 at 6:52=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > On Wed, Jul 19, 2023 at 6:33=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > Despite its name, mm_drop_all_locks() does not drop _all_ locks; the =
mmap
> > > lock is held write-locked by the caller, and the caller is responsibl=
e for
> > > dropping the mmap lock at a later point (which will also release the =
VMA
> > > locks).
> > > Calling vma_end_write_all() here is dangerous because the caller migh=
t have
> > > write-locked a VMA with the expectation that it will stay write-locke=
d
> > > until the mmap_lock is released, as usual.
> > >
> > > This _almost_ becomes a problem in the following scenario:
> > >
> > > An anonymous VMA A and an SGX VMA B are mapped adjacent to each other=
.
> > > Userspace calls munmap() on a range starting at the start address of =
A and
> > > ending in the middle of B.
> > >
> > > Hypothetical call graph with additional notes in brackets:
> > >
> > > do_vmi_align_munmap
> > >   [begin first for_each_vma_range loop]
> > >   vma_start_write [on VMA A]
> > >   vma_mark_detached [on VMA A]
> > >   __split_vma [on VMA B]
> > >     sgx_vma_open [=3D=3D new->vm_ops->open]
> > >       sgx_encl_mm_add
> > >         __mmu_notifier_register [luckily THIS CAN'T ACTUALLY HAPPEN]
> > >           mm_take_all_locks
> > >           mm_drop_all_locks
> > >             vma_end_write_all [drops VMA lock taken on VMA A before]
> > >   vma_start_write [on VMA B]
> > >   vma_mark_detached [on VMA B]
> > >   [end first for_each_vma_range loop]
> > >   vma_iter_clear_gfp [removes VMAs from maple tree]
> > >   mmap_write_downgrade
> > >   unmap_region
> > >   mmap_read_unlock
> > >
> > > In this hypothetical scenario, while do_vmi_align_munmap() thinks it =
still
> > > holds a VMA write lock on VMA A, the VMA write lock has actually been
> > > invalidated inside __split_vma().
> > >
> > > The call from sgx_encl_mm_add() to __mmu_notifier_register() can't
> > > actually happen here, as far as I understand, because we are duplicat=
ing an
> > > existing SGX VMA, but sgx_encl_mm_add() only calls
> > > __mmu_notifier_register() for the first SGX VMA created in a given pr=
ocess.
> > > So this could only happen in fork(), not on munmap().
> > > But in my view it is just pure luck that this can't happen.
> > >
> > > Also, we wouldn't actually have any bad consequences from this in
> > > do_vmi_align_munmap(), because by the time the bug drops the lock on =
VMA A,
> > > we've already marked VMA A as detached, which makes it completely
> > > ineligible for any VMA-locked page faults.
> > > But again, that's just pure luck.
> > >
> > > So remove the vma_end_write_all(), so that VMA write locks are only e=
ver
> > > released on mmap_write_unlock() or mmap_write_downgrade().
> >
> > Your logic makes sense to be. mm_drop_all_locks() unlocking all VMAs,
> > even the ones which were locked before mm_take_all_locks() seems
> > dangerous.
> > One concern I have is that mm_take_all_locks() and mm_drop_all_locks()
> > become asymmetric with this change: mm_take_all_locks() locks all VMAs
> > but mm_drop_all_locks() does not release them. I think there should be
> > an additional comment explaining this asymmetry.
> > Another side-effect which would be nice to document in a comment is
> > that when mm_take_all_locks() fails after it locked the VMAs, those
> > VMAs will stay locked until mmap_write_unlock/mmap_write_downgrade.
> > This happens because of failure mm_take_all_locks() jumps to perform
> > mm_drop_all_locks() and this will not unlock already locked VMAs.
> > Other than that LGTM. Thanks!
>
> But this is not specific to mm_drop_all_locks() at all, right? It's just
> fundamentally how per-VMA locks are used everywhere. Somewhere deep
> down in some call path, while the mmap lock is held in write mode, a
> VMA is marked as being written to, and then this marking persists
> until the mmap lock is dropped.

Yes, but for all other locks mm_take_all_locks()/mm_drop_all_locks()
is perfectly symmetrical AFAIKT. I see pretty descriptive comment for
mm_take_all_locks() explaining locking rules, so mentioning this
asymmetry in there seems appropriate to me.

>
> If we want to clarify this, I guess some comments on
> vma_end_write_all() and vma_start_write() might help, but I think
> that's independent of this patch.

Yes and no. This patch changes vma_end_write_all() to be called
exclusively from mmap_write_unlock()/mmap_write_downgrade(), so it
introduces the notion that once VMA is write-locked it's never
released until mmap_lock is released/downgraded. So, I agree that a
comment for vma_start_write() is appropriate but I also think it does
belong in this patch.
Thanks,
Suren.
