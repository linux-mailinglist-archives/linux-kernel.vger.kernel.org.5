Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2E76572A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjG0PQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjG0PQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:16:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F42D19BA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:16:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so97975e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690470982; x=1691075782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utE8vRwrX++6X0lCOyhtmTOdfLDy8jS4+Yo+Xxkza3c=;
        b=Ud0pxpZcd7aJNotRCE+WUkhwBFed5VvPwbUpDmgYSr8EJcG6JebWxDXIuyEiieBAPV
         PO1qiiq2eJavMeZRdjixHjuwqA+2/WoV5o7o7Ynd+QnnajfQaNBBUrkDqiyyLiKwnJtA
         rq3SDnDRGFVUkeNDtrnLUyX9Dznzsymxnsxc1hXaclSb46syUvEsivXGKLSsXkVIU4sV
         cLYy2tYslYLm8gOFsr+kFoUtVt+rv+IUfbG0VX+vlTzCtdEXzjmdaHssefNZPMReg5I1
         axHAnqY1q1s60vmb7J4GCAt+bQixi3uhbstXwwiF6qlwNoi5ewKAKxdhFBuGEIm7giJn
         17gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690470982; x=1691075782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utE8vRwrX++6X0lCOyhtmTOdfLDy8jS4+Yo+Xxkza3c=;
        b=hL+MPWlYXizjCRTUOM3lf0TYvFxYiJY0Pa6KZTscAG4XI7KX01gJJZgpReBeQ9r0wZ
         /XgQtbF/GmipBpJ0nlnoUiTkxtmm0QdT2a4kr/7HyDDu/XefnGncLN4qv3RQkLL3IpRI
         pk/Fv0GY4qoWJECQIanVmFAI8NPgNhnqkYl5kZS1eOnpTsnoSFLYBfXyQ5vzGzdKPrkk
         s3OSX7r91uDJokz4V88zUUjm0me/ERRumMREqr+YnDxgACwr/5QeEwFNFb7AuH0TyIhP
         r51LvLl+8f6ATgjfZglFLHsjRSAs+mmeiP3PsQ0xU6UUUaJFt9f2AknJdJZ6thJ6yQot
         +Wew==
X-Gm-Message-State: ABy/qLa/Aq8R+K7lABwyBQZyyRN0XyGgvCKbz4GmBFfY3QpCMy9/2QoU
        aEsowg7kWfErEySMhHtN+VA3mykg/LiO5TnYxduKtw==
X-Google-Smtp-Source: APBJJlE4frvwQ6KmYnfKrtCTfLx4fYG+xPFA2HGLtVpwad1rvO4gMoSBfZQUbfyqUM/AJW+OuV1rWQWd9qfbBYornqI=
X-Received: by 2002:a05:600c:829:b0:3f1:6fe9:4a95 with SMTP id
 k41-20020a05600c082900b003f16fe94a95mr113708wmp.4.1690470982450; Thu, 27 Jul
 2023 08:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com> <ZMKINJ9+WX1WWG8g@casper.infradead.org>
In-Reply-To: <ZMKINJ9+WX1WWG8g@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Jul 2023 17:15:45 +0200
Message-ID: <CAG48ez1YPhc2sp=+pXCsZsmiPfXF_oQakouSfNFqi4xK2gEuGA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
To:     Matthew Wilcox <willy@infradead.org>
Cc:     paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
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

On Thu, Jul 27, 2023 at 5:07=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> > The other option is to replace the READ_ONCE() with a
> > smp_load_acquire(), at which point it becomes a lot simpler to show
> > that the code is correct.
>
> Aren't we straining at gnats here?  The context of this is handling a
> page fault, and we used to take an entire rwsem for read.  I'm having
> a hard time caring about "the extra expense" of an unnecessarily broad
> barrier.
>
> Cost of an L3 cacheline miss is in the thousands of cycles.  Cost of a
> barrier is ... tens?

Yeah, fair point. If it's hard to show correctness with READ_ONCE() we
can just use smp_load_acquire() and call it a day.
