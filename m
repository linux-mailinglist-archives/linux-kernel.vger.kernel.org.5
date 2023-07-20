Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC82375B54A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjGTROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGTROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:14:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08101B3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:14:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so4495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689873246; x=1690478046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4Y03rAkNqCt5Z1k6DcGBxBkwsMLJ+wU/AutVSSMAN8=;
        b=PDGGXvYQRpL6m2UfvJe1nbfMDURy5iUxtugVbwOqWaSQPrLv1WC1AEPWglyrIz9LGw
         S8iv7yjmYQXA/2/TAtpofD+zjk894+pxOEZeTjFcmighBWiJ02M/gC7SR2UuJLS4p4fX
         KVIMDzrgQYVatzrZS3HF36WhjxFo3K47h6mJPDlE/x8SLxBByqPz1G/5r3ZTasVvNwNq
         UmXv77aNDNthkmigNIEGLSI3Jpd9BD6CuCA18WuyMUk1KmEPN3OzgU71rOzEBpV24dB0
         lvMZjfQZHY4GMdU2kCTAwSwCIIZDm1w0uRfRJn2Fw5cu/NHZ5M9Y/pQDRm4sO1DnQuvv
         BZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873246; x=1690478046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4Y03rAkNqCt5Z1k6DcGBxBkwsMLJ+wU/AutVSSMAN8=;
        b=T85A2tDHZk1pGYUkfkKz5gI4B40X4Nbed3n05naQsOMT16R97nrWsdrL7MA35MZ580
         lEnU7wAtPEH8oidWb6osak/AoG/HPJocNILNY4iBjLAJEHdYMsJ2lRaJo1z7ZAvQK4xr
         YjbnGiMbV4JzOwincVsQvsuU5HbFnypW3j1jwJrwq+hrrxzz/B7zyIe73EAfqBxh4yPB
         pLJSkESnGI/kHrJQnPNNjWzVq9Fa58Yvhas4J/SCozE23WXdqyD7xq1hiyGP4hw5Udnw
         P9AKHYi89ESenpltwT0kSmb0ClJfzfFDJfjbKrVEl2zpPTb9iqJRDEpMUKVqDVEMbcx6
         h8TQ==
X-Gm-Message-State: ABy/qLbzGZv4IUxKuZE1op/b5DBIB8DrZ3iMqmNb5yB4qz/uZWq7yD84
        8TF4BbDF5/31Mjw67V1W1d47RzfBTWPINyNQo6grLw==
X-Google-Smtp-Source: APBJJlGIi5rUga4ez2Y2JH9AiMsdM5lCMyHAYCWLLn5IWxGgU2OiKgJJXtsJeLKXMukAdYKMWWJkotIdruJmUwPiaFQ=
X-Received: by 2002:a05:600c:3516:b0:3f4:fb7:48d4 with SMTP id
 h22-20020a05600c351600b003f40fb748d4mr109817wmq.3.1689873246368; Thu, 20 Jul
 2023 10:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230720013249.199981-1-jannh@google.com> <CAJuCfpEs=jwaJEJQV9=Qo4h9JobrR1S=vETy1h8Q7TfS3eF_Qw@mail.gmail.com>
In-Reply-To: <CAJuCfpEs=jwaJEJQV9=Qo4h9JobrR1S=vETy1h8Q7TfS3eF_Qw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 20 Jul 2023 19:13:29 +0200
Message-ID: <CAG48ez0MSS47TkrV47R9P7uXtOgrLW3_hK0Od263JZmBoiczVw@mail.gmail.com>
Subject: Re: [PATCH] mm: Don't drop VMA locks in mm_drop_all_locks()
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 6:52=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Wed, Jul 19, 2023 at 6:33=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Despite its name, mm_drop_all_locks() does not drop _all_ locks; the mm=
ap
> > lock is held write-locked by the caller, and the caller is responsible =
for
> > dropping the mmap lock at a later point (which will also release the VM=
A
> > locks).
> > Calling vma_end_write_all() here is dangerous because the caller might =
have
> > write-locked a VMA with the expectation that it will stay write-locked
> > until the mmap_lock is released, as usual.
> >
> > This _almost_ becomes a problem in the following scenario:
> >
> > An anonymous VMA A and an SGX VMA B are mapped adjacent to each other.
> > Userspace calls munmap() on a range starting at the start address of A =
and
> > ending in the middle of B.
> >
> > Hypothetical call graph with additional notes in brackets:
> >
> > do_vmi_align_munmap
> >   [begin first for_each_vma_range loop]
> >   vma_start_write [on VMA A]
> >   vma_mark_detached [on VMA A]
> >   __split_vma [on VMA B]
> >     sgx_vma_open [=3D=3D new->vm_ops->open]
> >       sgx_encl_mm_add
> >         __mmu_notifier_register [luckily THIS CAN'T ACTUALLY HAPPEN]
> >           mm_take_all_locks
> >           mm_drop_all_locks
> >             vma_end_write_all [drops VMA lock taken on VMA A before]
> >   vma_start_write [on VMA B]
> >   vma_mark_detached [on VMA B]
> >   [end first for_each_vma_range loop]
> >   vma_iter_clear_gfp [removes VMAs from maple tree]
> >   mmap_write_downgrade
> >   unmap_region
> >   mmap_read_unlock
> >
> > In this hypothetical scenario, while do_vmi_align_munmap() thinks it st=
ill
> > holds a VMA write lock on VMA A, the VMA write lock has actually been
> > invalidated inside __split_vma().
> >
> > The call from sgx_encl_mm_add() to __mmu_notifier_register() can't
> > actually happen here, as far as I understand, because we are duplicatin=
g an
> > existing SGX VMA, but sgx_encl_mm_add() only calls
> > __mmu_notifier_register() for the first SGX VMA created in a given proc=
ess.
> > So this could only happen in fork(), not on munmap().
> > But in my view it is just pure luck that this can't happen.
> >
> > Also, we wouldn't actually have any bad consequences from this in
> > do_vmi_align_munmap(), because by the time the bug drops the lock on VM=
A A,
> > we've already marked VMA A as detached, which makes it completely
> > ineligible for any VMA-locked page faults.
> > But again, that's just pure luck.
> >
> > So remove the vma_end_write_all(), so that VMA write locks are only eve=
r
> > released on mmap_write_unlock() or mmap_write_downgrade().
>
> Your logic makes sense to be. mm_drop_all_locks() unlocking all VMAs,
> even the ones which were locked before mm_take_all_locks() seems
> dangerous.
> One concern I have is that mm_take_all_locks() and mm_drop_all_locks()
> become asymmetric with this change: mm_take_all_locks() locks all VMAs
> but mm_drop_all_locks() does not release them. I think there should be
> an additional comment explaining this asymmetry.
> Another side-effect which would be nice to document in a comment is
> that when mm_take_all_locks() fails after it locked the VMAs, those
> VMAs will stay locked until mmap_write_unlock/mmap_write_downgrade.
> This happens because of failure mm_take_all_locks() jumps to perform
> mm_drop_all_locks() and this will not unlock already locked VMAs.
> Other than that LGTM. Thanks!

But this is not specific to mm_drop_all_locks() at all, right? It's just
fundamentally how per-VMA locks are used everywhere. Somewhere deep
down in some call path, while the mmap lock is held in write mode, a
VMA is marked as being written to, and then this marking persists
until the mmap lock is dropped.

If we want to clarify this, I guess some comments on
vma_end_write_all() and vma_start_write() might help, but I think
that's independent of this patch.
