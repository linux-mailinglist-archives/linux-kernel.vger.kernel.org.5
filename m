Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3FF75B504
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGTQxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjGTQxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:53:32 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378692
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:53:30 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5704fce0f23so11031557b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689872010; x=1690476810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afUwPeZDgES71SVrZPVCgwP/hpGD5z58VLoiPj5sM7Y=;
        b=Nux4DICX4FPvUdzUa82d9VQtoJbLwxOQFwg1iE4FTTT0cQulb4kEHiLA5fjeKiatt6
         08pW7Iq4QoQ8I7yIoIZGYU6mL5XLGm7NUJDRj1WvUSn+5zrkAMH40OrC0ytszPbL80/X
         LwxffghmZUn48Ej1/ciLLRLt5pV+lqLqQRvjJEXdmgS2WDZ2ByJc5ELG+ynOM4dwvNwt
         II6rkqBK8kkMViTU7eOXUiaxIrWiBpvRRHXDYJgcosAjeQLh9hx4YPRZM1WXobB3ZGLV
         mokBwmLO+jAWbJweoI38HWnmsUBK27R7Rmfn6e6DJ4U0DEg2y+kTsfPP4zS3VfcOQgeF
         P7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689872010; x=1690476810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afUwPeZDgES71SVrZPVCgwP/hpGD5z58VLoiPj5sM7Y=;
        b=Z3AM/csEpUvJQCwcyceiTccRAljZQlsUQBAY8wkiE3fj6Xb2twM70pR7zKuUB9JJU9
         SJYCDlVa1N6LVN6x/eBkNezphBsyqaM181t217MWIZTFCClaKTBDZG04/ZJQU4clAast
         bLeONoh5yIY+9xO5O2TbNJDVbfn5DJnMen/0X40RSs18fdI5tOCkqmMqUqsuweiE+RSy
         3tNT4f4soxI+TAaeGdESpeTa8ySyFhU1PQ5QmYL04nwZ3zMTRTio5Ym65pe+pjlWFQPu
         Bz+D+7fT+qecHiVCuAZzPJcE2ixB3fPWITN9f6qaIiy6KMZfe34xmFLssI4k0Hf8lNwW
         NUzA==
X-Gm-Message-State: ABy/qLYIIpJsVEU4J42Pyfx2nuoeudryTR+BPFl+JBxT7e8K2OH4QM1/
        7KWV+SflEsm2JtwyDKOXx8WoO3LouB5NYDUUcxC7HQ==
X-Google-Smtp-Source: APBJJlGEoD1ID63gguX/BQy+QoSeuwk25jEhSpxWpmXM9YSjJkwOC9KMJA1v50LvSLks7bqCB1Xc5pzVcZD7oawxhM0=
X-Received: by 2002:a25:aba1:0:b0:c6f:db67:cbf7 with SMTP id
 v30-20020a25aba1000000b00c6fdb67cbf7mr5114750ybi.16.1689872009815; Thu, 20
 Jul 2023 09:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230720013249.199981-1-jannh@google.com> <CAJuCfpEs=jwaJEJQV9=Qo4h9JobrR1S=vETy1h8Q7TfS3eF_Qw@mail.gmail.com>
In-Reply-To: <CAJuCfpEs=jwaJEJQV9=Qo4h9JobrR1S=vETy1h8Q7TfS3eF_Qw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 Jul 2023 09:53:18 -0700
Message-ID: <CAJuCfpH-iwwzudP-RVd981fAdZnBOWxE=Z-kH3xQbwEN2=N0rw@mail.gmail.com>
Subject: Re: [PATCH] mm: Don't drop VMA locks in mm_drop_all_locks()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jul 20, 2023 at 9:51=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
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

s/of/on in the above statement

> mm_drop_all_locks() and this will not unlock already locked VMAs.
> Other than that LGTM. Thanks!
>
> >
> > Fixes: eeff9a5d47f8 ("mm/mmap: prevent pagefault handler from racing wi=
th mmu_notifier registration")
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> > ---
> >  mm/mmap.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 3eda23c9ebe7..1ff354b1e23c 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3758,7 +3758,6 @@ void mm_drop_all_locks(struct mm_struct *mm)
> >                 if (vma->vm_file && vma->vm_file->f_mapping)
> >                         vm_unlock_mapping(vma->vm_file->f_mapping);
> >         }
> > -       vma_end_write_all(mm);
> >
> >         mutex_unlock(&mm_all_locks_mutex);
> >  }
> >
> > base-commit: bfa3037d828050896ae52f6467b6ca2489ae6fb1
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
