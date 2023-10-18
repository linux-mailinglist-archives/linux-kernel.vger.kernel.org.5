Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743F07CD4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjJRHCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbjJRHBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:01:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D234EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:01:51 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41b813f0a29so142811cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697612510; x=1698217310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQMWdsjrcNxGemB+Ki+j+OmjDR6Ap/DLLOnXpTvSXXU=;
        b=BDOaHkwV4BokQ0SNJAvrLqGryf0MP/JZL+9jwKjPK0N4tG05P5vV5mY5deCuGRYUWJ
         n5FhyYP8P30ngXwe0QEOgllGlNekSLWz+y6+GZD56Mv19PtQf35nvZNx5Pzqndki7q4h
         JtjQnsIsJmEDmBamInZmUkgxtykcWNqfyqgnMgdxqoA5RL4PAmGEuZGp/TmO4QkyeRn4
         yiF+h258/JE9kE2jZnyWcuI4QpofrkYxsDLfCIswY/hw5LxvQi1FZ7lnNJGR8VJuzAuI
         7s/wFWb3+YI1EayMq7Z/q0CQy2CB1SpdefJ2cFwcLwbkg+qk2udXoQApeEQ4BaZjJG7H
         azfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697612510; x=1698217310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQMWdsjrcNxGemB+Ki+j+OmjDR6Ap/DLLOnXpTvSXXU=;
        b=HDiU1H/hIR/7BP+DyTb5gHqEEaPlrQzFV5RQ5DeVMDJ0FyPN+L8pvtVTAUQsXk/APG
         TP+EapSVAerpOQuXOn5iLLCTcJkxZhGW8hkZujrOWRphD5WD4FSypvvEclqe6Xz5bQK5
         QT/Td8odEvkkpvUBNJMLBYS1TzVfWojp3hRONvY8JGldjjvB1sojzxzjiNGxHbIvxHhC
         s3Bg6ZLQn1/g5kKBT7MDvwYUWpOYkBzmWDld9uwk/gf4n+Ix91EbVu/hWnDin/Ox9r/G
         J4xpeDZmo2jXTOOvR/fxqTQiBYxB+/yVf3/3LAqSNm3/0qNAEWNIXO5Qs6N3hwjAoW1K
         00OQ==
X-Gm-Message-State: AOJu0YxU/SuCCXk6ntUPrqPTDe/1XEzy6GNqamVVRZA3nYB4UCQNoEE6
        Ps74xOSQMOT0N1i4pPVdPOeBUdtuaZ5JY2Llzz15Sw==
X-Google-Smtp-Source: AGHT+IHQyYOLE+Z9gTa+AYX+0rUotOh258UwOYKTEH95jYD/ocMbUJZKoG7x1mSLfzj+pDUtHplvY6ztBQyrR0NiBRo=
X-Received: by 2002:a05:622a:a047:b0:41b:ef8f:dcbc with SMTP id
 ju7-20020a05622aa04700b0041bef8fdcbcmr234597qtb.0.1697612509813; Wed, 18 Oct
 2023 00:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-8-jeffxu@chromium.org>
 <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com> <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
In-Reply-To: <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 18 Oct 2023 00:01:13 -0700
Message-ID: <CALmYWFtugBD9CJRjfKZ+tp0r4fPCGkotpH17t0rF5_atw8_PbA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/8] mseal:Check seal flag for mmap(2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
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

Hi Linus,

On Tue, Oct 17, 2023 at 10:43=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 17 Oct 2023 at 10:04, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Honestly, there is only two kinds of sealing that makes sense:
> >
> >  - you cannot change the permissions of some area
> >
> >  - you cannot unmap an area
>
> Actually, I guess at least theoretically, there could be three different =
things:
>
>  - you cannot move an area
>
Yes.

Actually, the newly added selftest covers some of the above:
1. can't change the permission of some areas.
test_seal_mprotect
test_seal_mmap_overwrite_prot

2. can't unmap an area (thus mmap() to the same address later)
test_seal_munmap

3. can't move to an area:
test_seal_mremap_move         //can't move from a sealed area:
test_seal_mremap_move_fixed_zero //can't move from a sealed area to a
fixed address
test_seal_mremap_move_fixed   //can't move to a sealed area.

4 can't expand or shrink the area:
test_seal_mremap_shrink
test_seal_mremap_expand

> although I do think that maybe just saying "you cannot unmap" might
> also include "you cannot move".
>
> But I guess it depends on whether you feel it's the virtual _address_
> you are protecting, or whether it's the concept of mapping something.
>
> I personally think that from a security perspective, what you want to
> protect is a particular address. That implies that "seal from
> unmapping" would thus also include "you can't move this area
> elsewhere".
>
> But at least conceptually, splitting "unmap" and "move" apart might
> make some sense. I would like to hear a practical reason for it,
> though.
>
> Without that practical reason, I think the only two sane sealing operatio=
ns are:
>
>  - SEAL_MUNMAP: "don't allow this mapping address to go away"
>
>    IOW no unmap, no shrinking, no moving mremap
>
>  - SEAL_MPROTECT: "don't allow any mapping permission changes"
>
I agree with the concept in general. The separation of two seal types
is easy to understand.

For mmap(MAP_FIXED), I know for a fact that it can modify permission of
an existing mapping, (as in selftest:test_seal_mmap_overwrite_prot).
I think it can also expand an existing VMA. This is not a problem, code-wis=
e,
I mention it here, because it needs extra care when coding mmap() change.

> Again, that permission case might end up being "don't allow
> _additional_ permissions" and "don't allow taking permissions away".
> Or it could be split by operation (ie "don't allow permission changes
> to writability / readability / executability respectively").
>
Yes. If the application desires this, it can also be done.
i.e. seal of X bit, or seal of W bit, this will be similar to file sealing.
I discussed this with Stephan before, at this point of time,  Chrome
doesn't have a use case.

> I suspect there isn't a real-life example of splitting the
> SEAL_MPROTECT (the same way I doubt there's a real-life example for
> splitting the UNMAP into "unmap vs move"), so unless there is some
> real reason, I'd keep the sealing minimal and to just those two flags.
>
I think two seal-type (permission and unmap/move/expand/shrink)
will work for the Chrome case. Stephen R=C3=B6ttger is an expert in Chrome,
on vacation/ be back soon. I will wait for Stephen to confirm.

> We could always add more flags later, if there is a real use case
> (IOW, if we start with "don't allow any permission changes", we could
> add a flag later that just says "don't allow writability changes").
>
Agreed 100%, thanks for understanding.

-Jeff


>                Linus
