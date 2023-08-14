Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1685A77C258
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjHNVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjHNVWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:22:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B3DE73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:22:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso13615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692048161; x=1692652961;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL0AM1Je6e5fBP6gbPX83S7jRl54DBoHaRHEKtf7HH8=;
        b=of0DjEEwmYxilK4o4yzt2UbCzOJrcQEaB5PQ0IncGy/5eVK4gRp37L3F/SWoqzSlt6
         vCtVzBQKEmw/NCZ9PnHfJ0bnTlMdyo09OKI9HA5UU8pN4+efwnXvO6GuoKWiqG3m8VcF
         xj1Cqc4BLOa1nuzf8B0r8v409e7pBkV+Tw6zxXDm/CMeVNBvCgRvFZqa4T9v0M8ARiGw
         +sXkLjZ2/qeQTLR62P1z/zBGy9tRnuRQ2yv1x8mad+U7bhP9o5Nb/RV0tCWR25Xndbf+
         SnvcUkAR6dy/v7h62LyqcyDMagE/PULla0IT3tEpgDIZ052T+SxUlfvDUJGGTcw4juRr
         Hrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692048161; x=1692652961;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL0AM1Je6e5fBP6gbPX83S7jRl54DBoHaRHEKtf7HH8=;
        b=cLImZ2l5a6rYOsgUKRxcrf97vTnCbqaJIZ4x//UN3eK6SkRtToF4WBnM16m3SF7xv9
         UeKUG14la+chTTvb8d04KVBmF4eqbQmFSfbxlCDdmeSiHMdVNy6OBJnnnfwllici4Z8/
         dTNLku5tEbaOKWPSNvnWFEMPV/CbW28iISMsqFiXxQnCpGa6pTknMIH2eVGvBXsNl9Nn
         zDvh2ornJR1zwpKGcq8u+uQ4vbd70YHLguK8/3u7PKrPBI5yqF+aShz3y8kY2ZYr6slY
         jwvkwvwWl4T1CCZlcfbYVsCe9pJOfMYiUaXsZkHHZ5EWaXozKeYT7AzgPAI8HfYZ9jeR
         lS+g==
X-Gm-Message-State: AOJu0YxaH5gvbQ2+hpktCGICchmaZDlYcdvlPLMsgcNi81Q9lSyEqbUZ
        cv63Tl+yghHebRvuyOP/SIi2rPkATLRxJxNMYcFPMA==
X-Google-Smtp-Source: AGHT+IHul3sJIyCib/1PCvISVtSSIkVP4Pk9tk4L5J1YA2h/KC+U0UX04u2MNGToWdfc1d1QtDDHtjZ8I3flmd4y/ps=
X-Received: by 2002:a05:600c:2146:b0:3fd:e15:6d5 with SMTP id
 v6-20020a05600c214600b003fd0e1506d5mr341439wml.2.1692048160762; Mon, 14 Aug
 2023 14:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
 <20230724183157.3939892-16-Liam.Howlett@oracle.com> <CAG48ez09ELhVYZftGtcxrvUaW6pF+k9RzwFtjRs-pcRx1aUweQ@mail.gmail.com>
 <20230814191835.jzj7ryvhi6dqwruy@revolver>
In-Reply-To: <20230814191835.jzj7ryvhi6dqwruy@revolver>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Aug 2023 23:22:04 +0200
Message-ID: <CAG48ez2UbpFb41gfcwyoA73ado=+YEiRtU2KmKt560_M_B7JUw@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] mm/mmap: Change vma iteration order in do_vmi_align_munmap()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:32=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
> * Jann Horn <jannh@google.com> [230814 11:44]:
> > @akpm
> >
> > On Mon, Jul 24, 2023 at 8:31=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > > Since prev will be set later in the function, it is better to reverse
> > > the splitting direction of the start VMA (modify the new_below argume=
nt
> > > to __split_vma).
> >
> > It might be a good idea to reorder "mm: always lock new vma before
> > inserting into vma tree" before this patch.
> >
> > If you apply this patch without "mm: always lock new vma before
> > inserting into vma tree", I think move_vma(), when called with a start
> > address in the middle of a VMA, will behave like this:
> >
> >  - vma_start_write() [lock the VMA to be moved]
> >  - move_page_tables() [moves page table entries]
> >  - do_vmi_munmap()
> >    - do_vmi_align_munmap()
> >      - __split_vma()
> >        - creates a new VMA **covering the moved range** that is **not l=
ocked**
> >        - stores the new VMA in the VMA tree **without locking it** [1]
> >      - new VMA is locked and removed again [2]
> > [...]
> >
> > So after the page tables in the region have already been moved, I
> > believe there will be a brief window (between [1] and [2]) where page
> > faults in the region can happen again, which could probably cause new
> > page tables and PTEs to be created in the region again in that window.
> > (This can't happen in Linus' current tree because the new VMA created
> > by __split_vma() only covers the range that is not being moved.)
>
> Ah, so my reversing of which VMA to keep to the first split call opens a
> window where the VMA being removed is not locked.  Good catch.
>
> >
> > Though I guess that's not going to lead to anything bad, since
> > do_vmi_munmap() anyway cleans up PTEs and page tables in the region?
> > So maybe it's not that important.
>
> do_vmi_munmap() will clean up PTEs from the end of the previous VMA to
> the start of the next

Alright, I guess no action is needed here then.

> I don't have any objections in the ordering or see an issue resulting
> from having it this way... Except for maybe lockdep, so maybe we should
> change the ordering of the patch sets just to be safe?
>
> In fact, should we add another check somewhere to ensure we do generate
> the warning?  Perhaps to remove_mt() to avoid the exit path hitting it?

I'm not sure which lockdep check you mean. do_vmi_align_munmap() is
going to lock the VMAs again before it operates on them; I guess the
only checks that would catch this would be the page table validation
logic or the RSS counter checks on exit?
