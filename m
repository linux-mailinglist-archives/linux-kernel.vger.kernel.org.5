Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25987D542A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbjJXOhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjJXOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:37:09 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4877EC4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:37:06 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso2985376a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698158225; x=1698763025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAOhUkJjCv880R1NKQbAjINSlXvyzmgC43sxJnCAkZ0=;
        b=fmFcvI/31jfAFpZyPTAkpth67CdokxZYXrakVccghD+qDbqZH0QaiFWFlCRNakWglu
         2g9v4IXx0DEalVoVrvWkr7SBUB6fEdNE1Hd/3nmED1BVjfofpWJi2qICBjDaXM/aiAKP
         XOK6WEnZl+EeRDomI+l/pF7W8K5LjWDeFAQopKf8K7PO5D+LYom2qrMFvlNqv0LTFkLu
         LWCQj8BE8O0ezpmUr2r7mVvu28qdjJ0VTYVGrO1vT2oQCzFYdeVSMxZJSRBxsftTibky
         BYhwnON1qkJivAAqiulMH18eYXy95fK7PiJvtzOw9UuZxtvI35npTwEyL4M2mc2E85+1
         26FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698158225; x=1698763025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAOhUkJjCv880R1NKQbAjINSlXvyzmgC43sxJnCAkZ0=;
        b=lrVJH1UvdSd1DY5NdI/ksVfEIGhsOFZIm0XSLAocPKrSArWvrX2p0Frmmv2FIK06z7
         tJOIq5YAToCcG8cVpaBU/kbgR7VZ2Tcppbau1eNSDZLn1Uqddf3v2AMfKgq2/eGXtHZk
         KmLOfB5Vlieh2j3MnWxTIodrlUpUUmEHqP6HOcGqShMmfJWfpxxJQEegu3SlnGtyjg9a
         E88Tc0QS4owPCxpCm6mjcvsG9BQHfQ7vKZl2rhmUCNnLh1s3YP12QYr1Abaw8ZsG/ThB
         +Ums/KtOeR0zI0DYBSRhHT1kF/wb1ofkqNYqqwnPpUdcos6T3bzWG0z4aXLGvEHRApJ5
         jI+w==
X-Gm-Message-State: AOJu0Yxe7cpw9GW1x3/7+zPL/BO00iWhE362aWKk3UdBAjxrTwHFaJC7
        igQvN3tXavAT2nnc9b8+YX8b4iEHR1euB7AT30wUDQ==
X-Google-Smtp-Source: AGHT+IGmaL1lCubVBE3q3NWkBv6nBQrZ0wRsy6ngThBW4I3ExrtLI9tz2AGRjsobSL7vHMdWw5sje4QO7Pqt6rn0QgM=
X-Received: by 2002:a05:6830:1e30:b0:6af:95f9:7adc with SMTP id
 t16-20020a0568301e3000b006af95f97adcmr12051128otr.14.1698158225267; Tue, 24
 Oct 2023 07:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com> <CAJuCfpErrAqZuiiU5uthVU87Sa=yztRRqnTszezFCMQgBEawCg@mail.gmail.com>
 <356a8b2e-1f70-45dd-b2f7-6c0b6b87b53b@redhat.com>
In-Reply-To: <356a8b2e-1f70-45dd-b2f7-6c0b6b87b53b@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 24 Oct 2023 07:36:51 -0700
Message-ID: <CAJuCfpF_qYsbW=gokP9jfc314UCb4erqhCjAo1vFi6orewSC=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 7:27=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.10.23 20:56, Suren Baghdasaryan wrote:
> > On Mon, Oct 23, 2023 at 5:29=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> Focusing on validate_remap_areas():
> >>
> >>> +
> >>> +static int validate_remap_areas(struct vm_area_struct *src_vma,
> >>> +                             struct vm_area_struct *dst_vma)
> >>> +{
> >>> +     /* Only allow remapping if both have the same access and protec=
tion */
> >>> +     if ((src_vma->vm_flags & VM_ACCESS_FLAGS) !=3D (dst_vma->vm_fla=
gs & VM_ACCESS_FLAGS) ||
> >>> +         pgprot_val(src_vma->vm_page_prot) !=3D pgprot_val(dst_vma->=
vm_page_prot))
> >>> +             return -EINVAL;
> >>
> >> Makes sense. I do wonder about pkey and friends and if we even have to
> >> so anything special.
> >
> > I don't see anything special done for mremap. Do you have something in =
mind?
>
> Nothing concrete, not a pkey expert. But as there is indeed nothing
> pkey-special in the VMA, there is nothing we can really check for and/or
> adjust.
>
> So let's assume this is fine.

Sounds good until someone tells us otherwise.

>
> >>
> >>> +
> >>> +     /* Only allow remapping if both are mlocked or both aren't */
> >>> +     if ((src_vma->vm_flags & VM_LOCKED) !=3D (dst_vma->vm_flags & V=
M_LOCKED))
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (!(src_vma->vm_flags & VM_WRITE) || !(dst_vma->vm_flags & VM=
_WRITE))
> >>> +             return -EINVAL;
> >>
> >> Why does one of both need VM_WRITE? If one really needs it, then the
> >> destination (where we're moving stuff to).
> >
> > As you noticed later, both should have VM_WRITE.
>
> Can you comment why? Just a simplification for now? Would be good to add
> that comment in the code as well.

Yeah, I thought to move a page both areas should be writable since we
are technically modifying both by this operation.

>
> /* For now, we keep it simple and only move between writable VMAs. */

Ack. Will add.

>
> >>> +      */
> >>> +     if (!dst_vma->vm_userfaultfd_ctx.ctx &&
> >>> +         !src_vma->vm_userfaultfd_ctx.ctx)
> >>> +             return -EINVAL;
> >>
> >>
> >>
> >>> +
> >>> +     /*
> >>> +      * FIXME: only allow remapping across anonymous vmas,
> >>> +      * tmpfs should be added.
> >>> +      */
> >>> +     if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> >>> +             return -EINVAL;
> >>
> >> Why a FIXME here? Just drop the comment completely or replace it with
> >> "We only allow to remap anonymous folios accross anonymous VMAs".
> >
> > Will do. I guess Andrea had plans to cover tmpfs as well.
>
>
> That is rather future work (or what's to fix here?) and better
> documented in the cover letter.

Ack.

>
> Having thought about VMA checks, I do wonder if we want to just block
> some VM_ flags right at the beginning (VM_IO,VM_PFNMAP,VM_HUGETLB,...).
> That might be covered by some other checks here implicitly, but I'm not
> 100% sure if that's always the case. An explicit list as in
> vma_ksm_compatible() might be clearer.
>
> Further, I wonder if we have to block VM_SHADOW_STACK; we certainly
> don't want to let users modify the shadow stack by moving modified
> target pages into place. But this might already be covered by earlier
> checks (vm_page_prot? but I didn't look up with which setting we ended
> up in the upstream version).

Good point. I'll check if existing checks already cover these and if
not will add them.
Thanks,
Suren.

>
> Cc'ing Rick: see "validate_remap_areas()" in [1]
>
> [1] https://lkml.kernel.org/r/20231009064230.2952396-3-surenb@google.com
>
>
> --
> Cheers,
>
> David / dhildenb
>
