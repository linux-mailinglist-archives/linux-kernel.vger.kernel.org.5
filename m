Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74185765C03
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjG0TVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjG0TVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:21:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C3FA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:21:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so18275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690485670; x=1691090470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyLrRoHQVkp9Qk0bYrHm60ga1B7v8n8gCKHi/W5Wo6o=;
        b=vCkIm85UWeFtI32XPvpTC4L+NlRu6wGNi9GJm3U+PsEFcASlm+L39Id790PoDx0Z8M
         klz28LJqypGOuNTa+R/qvax46BAVeSVxXD3FyL5JtGIMzYhea/3Myb4D2c7MuA5kr612
         qfObrBrF52R6pap+CdSt0toROzcRADVA3WdrhroewE7DoCrpZm7p21pSDEZU1U1CLmUT
         TJFpFCMUpF2s6jSl0I3kEAA+TD9d0Xl5rVyIf3qoof6xlvkPrYYObzKicNnX6aJGozDl
         me6w4bGN2RjO6ShJRyoUEHrDm5K+Kids4i8jvbaTvoN+SVwGs076tc46fYgwZOwWGGZL
         UWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485670; x=1691090470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyLrRoHQVkp9Qk0bYrHm60ga1B7v8n8gCKHi/W5Wo6o=;
        b=kQUQUVEmkG44NTngxZsEzyS65eyxyxCo/SRC/PCGGT1hpCPJwhMNihhRl6W/HTNHkq
         PnRB+5fzWnrUZceNKxugvfvyu5BQzYnDGcYpZ39JEn+CjKtw7+JrJiaPE46JQdVRbBRk
         Xtj9v4rTmkLy+6Dr6NpWVM9JWO1yziIoeI6XJ7wfKO2LQzfWYC+Sh3wmalsgOow+URHo
         o7m6Bbpay1+S8csDO/zkxf5bFr0JClUkpLh2xWINABfW3JdifzpVRlaKt7vftX7FRgB0
         vLIpbssBs7ydx42gSbYUQOUlc0mw9TzgH1McPA/LGcUfYwT0aiI2gYAqg/9ZEwBzCr7j
         6ENA==
X-Gm-Message-State: ABy/qLadNp3x18U1LtibDNh2DMvLHoxYuDONAdGHlGGRBRjzZtYx47Qp
        fLe5MdwdBChIhKDKSB8h8OW1ycH46Rp5GfkN9e3zEz7JwTOLpXmpw95ENQ==
X-Google-Smtp-Source: APBJJlHzUz8IbElL2RzIXfyygRzF9aKFWJf2u1kth8hZi4M2zV3J9WjrTUfFqmWLQM2VhRNHHpXoqopHV6JRtBEPr/E=
X-Received: by 2002:a05:600c:1c16:b0:3f1:70d1:21a6 with SMTP id
 j22-20020a05600c1c1600b003f170d121a6mr27810wms.0.1690485670405; Thu, 27 Jul
 2023 12:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000607ff905ffc8e477@google.com> <0000000000000aeb7f06015e5cbd@google.com>
 <20230727164757.e2di75xjybxncohn@revolver> <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
 <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com> <ZMK0ony0LG2SL2Ha@casper.infradead.org>
In-Reply-To: <ZMK0ony0LG2SL2Ha@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Jul 2023 21:20:33 +0200
Message-ID: <CAG48ez0Qgtamxj7BieL5U+pWyQ3S+s3hVJfdJEevqk-hPAN3sA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
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

On Thu, Jul 27, 2023 at 8:17=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jul 27, 2023 at 07:59:33PM +0200, Jann Horn wrote:
> > On Thu, Jul 27, 2023 at 7:22=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > Hmm. lock_vma_under_rcu() specifically checks for vma->anon_vma=3D=3D=
NULL
> > > condition (see [1]) to avoid going into find_mergeable_anon_vma() (a
> > > check inside anon_vma_prepare() should prevent that). So, it should
> > > fall back to mmap_lock'ing.
> >
> > This syzkaller report applies to a tree with Willy's in-progress patch
> > series, where lock_vma_under_rcu() only checks for vma->anon_vma if
> > vma_is_anonymous() is true - it permits private non-anonymous VMAs
> > (which require an anon_vma for handling write faults)  even if they
> > don't have an anon_vma.
> >
> > The commit bisected by syzkaller
> > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co=
mmit/?id=3Da52f58b34afe095ebc5823684eb264404dad6f7b)
> > removes the vma_is_anonymous() check in handle_pte_fault(), so it lets
> > us reach do_wp_page() with a non-anonymous private VMA without
> > anon_vma, even though that requires allocation of an anon_vma.
> >
> > So I think this is pretty clearly an issue with Willy's in-progress
> > patch series that syzkaller blamed correctly.
>
> Agreed.  What do we think the right solution is?
>
> Option 1:
>
> +++ b/mm/memory.c
> @@ -3197,6 +3197,12 @@ static vm_fault_t wp_page_copy(struct vm_fault *vm=
f)
>         struct mmu_notifier_range range;
>         int ret;
>
> +       if (!vma->anon_vma) {
> +               // check if there are other things to undo here
> +               vma_end_read(vmf->vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         delayacct_wpcopy_start();
>
> Option 2:
>
> @@ -5581,7 +5587,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
>                 goto inval;
>
>         /* find_mergeable_anon_vma uses adjacent vmas which are not locke=
d */
> -       if (vma_is_anonymous(vma) && !vma->anon_vma)
> +       if ((vma_is_anonymous(vma) ||
> +            vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) && !vma->anon_vma=
)
>                 goto inval;
>
> The problem with option 2 is that we don't know whether this is a write
> fault or not, so we'll handle read faults on private file
> mappings under the mmap_lock UNTIL somebody writes to the mapping, which
> might be never.  That seems like a bad idea.
>
> We could pass FAULT_FLAG_WRITE into lock_vma_under_rcu(), but that also
> seems like a bad idea.  I dunno.  Three bad ideas.  Anyone think of a
> good one?

One kinda straightforward option would be to pass the vmf (or NULL if
it's not in fault context) to anon_vma_prepare(), teach it to bail if
it runs under the mm lock, and propagate a VM_FAULT_RETRY all the way
up? It can already fail due to OOM, so the bailout paths exist, though
you'd have to work a bit to plumb the right error code up.

And if you're feeling adventurous, you could try to build a way to
opportunistically upgrade from vma lock to mmap lock, to avoid having
to bail out all the way back up and then dive back in when that
happens. Something that does mmap_read_trylock(); on failure, bail out
with VM_FAULT_RETRY; on success, drop the VMA lock and change
vmf->flags to note the changed locking context.
