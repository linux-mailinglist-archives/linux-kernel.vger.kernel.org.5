Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48711776762
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHIScL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjHIScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:32:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6571FEF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:32:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d6349472de6so56130276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691605927; x=1692210727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHnmTAuuBkyhoSRjvMGvUMrCpJOQs8BtVZXDTIE3D1s=;
        b=rywljwLIMkcUe/YouOhrAjqUwmYZFHGlRvJkNcRn5ctb15/YefUGojXuTwdE1uTPfy
         z7+DRg3M0BP6u9lbezVX9xsRVVMfvwtxWBIyXU6yq/vJ6PqMNX2H+ooCyWhrrBhAJTjj
         doVQpEDnLLMdWmcDIW+Bmg7sGsL5tsXTb1SuL9HNqqP3+b4ZvQA2tUsQPOYF0FKAb7VW
         2b3QswTGoJm3Bt17FOhWNpGmRLp4i2i70OVatE8klenARqBCv7Vah7om/ivHOYcBLHEo
         IZWGu4gxXg3hE04YAUSMnd9WqZscfLlOwR34jn/RSlMuqj4bEFpB14Kwi6AV1Y79r9YA
         M27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691605927; x=1692210727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHnmTAuuBkyhoSRjvMGvUMrCpJOQs8BtVZXDTIE3D1s=;
        b=SmC605oKfE2A/skTei1gYww2ReHzYoiV2tU2Xe0FZDN+rDu7Ramuiphs7l85zc8qI2
         f1nmTfqCBQ2CUSTSKzMTQ56Ae8YXXpSFPblZbFeMGdc9yFPLgosYzUj1rJOXqF4GqHaP
         F8a+jKlrAyNDNE7iye/JmHPu6P9v9J5C5w+0owVWsGPJMjNqwRT/RVyOQhmJfll3SgSU
         NIkZyHO9tYPPeM4HRrTBPq0UOKabKT3OmYdQc3EaH0QoJD3qie5qR0YFIdeKyi3ZyKd4
         +P3mWdi5A4uT/rrf20LoD0tYpnRQanaBYlj5vq8K79rQ4ps8BOU3gyY+33LdVHD0tSUa
         axnQ==
X-Gm-Message-State: AOJu0YzBZ/hk2n7thu2UwU3fEsohFCiZDswBGsnL1mHPSTqU5DYKaaHs
        ITi4QeFFfbmChUcWt5gLUPA6ydUm/m8QJMwK6X+9YA==
X-Google-Smtp-Source: AGHT+IHK3Dcqy/WID1j0pyzQGlfiiQHINDsBbv4x+B/a8SreFNWZoniInr0UtM8vfLTJTv4ZPWpC0P1nvbhvVKlVIK8=
X-Received: by 2002:a25:d304:0:b0:d44:3ad2:42e5 with SMTP id
 e4-20020a25d304000000b00d443ad242e5mr275771ybf.4.1691605926873; Wed, 09 Aug
 2023 11:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com> <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
In-Reply-To: <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Aug 2023 11:31:54 -0700
Message-ID: <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 11:08=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 9, 2023 at 11:04=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > >>>> Which ends up being
> > >>>>
> > >>>> VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > >>>>
> > >>>> I did not check if this is also the case on mainline, and if this =
series is responsible.
> > >>>
> > >>> Thanks for reporting! I'm checking it now.
> > >>
> > >> Hmm. From the code it's not obvious how lock_mm_and_find_vma() ends =
up
> > >> calling find_vma() without mmap_lock after successfully completing
> > >> get_mmap_lock_carefully(). lock_mm_and_find_vma+0x3f/0x270 points to
> > >> the first invocation of find_vma(), so this is not even the lock
> > >> upgrade path... I'll try to reproduce this issue and dig up more but
> > >> from the information I have so far this issue does not seem to be
> > >> related to this series.
> >
> > I just checked on mainline and it does not fail there.

Thanks. Just to eliminate the possibility, I'll try reverting my
patchset in mm-unstable and will try the test again. Will do that in
the evening once I'm home.

> >
> > >
> > > This is really weird. I added mmap_assert_locked(mm) calls into
> > > get_mmap_lock_carefully() right after we acquire mmap_lock read lock
> > > and one of them triggers right after successful
> > > mmap_read_lock_killable(). Here is my modified version of
> > > get_mmap_lock_carefully():
> > >
> > > static inline bool get_mmap_lock_carefully(struct mm_struct *mm,
> > > struct pt_regs *regs) {
> > >       /* Even if this succeeds, make it clear we might have slept */
> > >       if (likely(mmap_read_trylock(mm))) {
> > >           might_sleep();
> > >           mmap_assert_locked(mm);
> > >           return true;
> > >       }
> > >       if (regs && !user_mode(regs)) {
> > >           unsigned long ip =3D instruction_pointer(regs);
> > >           if (!search_exception_tables(ip))
> > >               return false;
> > >       }
> > >       if (!mmap_read_lock_killable(mm)) {
> > >           mmap_assert_locked(mm);                     <---- generates=
 a BUG
> > >           return true;
> > >       }
> > >       return false;
> > > }
> >
> > Ehm, that's indeed weird.
> >
> > >
> > > AFAIKT conditions for mmap_read_trylock() and
> > > mmap_read_lock_killable() are checked correctly. Am I missing
> > > something?
> >
> > Weirdly enough, it only triggers during that specific uffd test, right?
>
> Yes, uffd-unit-tests. I even ran it separately to ensure it's not some
> fallback from a previous test and I'm able to reproduce this
> consistently.
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
