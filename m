Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B77765B51
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjG0S0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjG0S0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:26:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108AC2D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:26:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so1749293a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690482358; x=1691087158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bzem6p2nNFcrPREy8LTws99E2B4HTj3oQRbG1EigUS4=;
        b=bjAdL850CueyOByCRuInC49bKHSUSe8x+zsDEu/NYsVmPUGVLaK7NVBLBshh2XsXuK
         wkYSXG4nLvZcHgcXF2uxUMJMEsG7FPmuOB61TO5bcgB8E8+UUXg2S33FZ7EQMlWFvl92
         JSn47budHcPk7imfbiF7H8/mCigiYG7s1b4g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482358; x=1691087158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzem6p2nNFcrPREy8LTws99E2B4HTj3oQRbG1EigUS4=;
        b=BfIK1GLK1RAJJo92qKSQsQFr5Ma9idlIYyWJSYEn0Rnd47KTqabywlrxwJbmac8fgt
         DHlOJeBst4EOhprboqKVtjznz/OWKmUOmJqbSlmdx94Ftlws4fyTUoNJfLjGYLpDmFUV
         X1X5C5pqgEuA++mNGfdTDdh2epAzZNx5XFrD9Gu3EPi83UmZqAIZm7zxrbukN/uzm7EX
         q3F3WkVHq4JAc/CIatd8+euU8593dB7x2d/EKNzcVb7IBmSEZOF9KhzaQewwh3Ysf/WV
         prYDC7ZQFRKsG15tPqtkrA0I4Od578rOJ6ZpdueHv0s2G3mjHExAVZJrbRY63vdU/NCF
         3I6A==
X-Gm-Message-State: ABy/qLanrDXFT0YJ4qWgDlrJIHXSeUuXWkuacJd3O3AokJ2smQ+C+Clw
        o3L/rgu5yIsRyshLhJ7nqcVFw1/NNwLuE/9QZJ8DDxzR
X-Google-Smtp-Source: APBJJlF/ToR/OPqnwnPqTGfFBvuYq9YVErzyqq/VfULKfZZzhUUYjjgbeaxwHU2Wi9RBTauGq0C/sw==
X-Received: by 2002:aa7:d9c5:0:b0:522:2b24:cf6 with SMTP id v5-20020aa7d9c5000000b005222b240cf6mr2091893eds.42.1690482358221;
        Thu, 27 Jul 2023 11:25:58 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id k16-20020aa7d8d0000000b0051e2670d599sm924108eds.4.2023.07.27.11.25.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 11:25:57 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5221e487e08so1774271a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:25:57 -0700 (PDT)
X-Received: by 2002:aa7:cfc5:0:b0:521:7a5e:ab1e with SMTP id
 r5-20020aa7cfc5000000b005217a5eab1emr2415059edy.21.1690482357203; Thu, 27 Jul
 2023 11:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <20230726214103.3261108-4-jannh@google.com>
 <CAG48ez00FhfjTReO8+B43tEXuzFcat1mQs3jxu_eGFzEp2Vsag@mail.gmail.com>
In-Reply-To: <CAG48ez00FhfjTReO8+B43tEXuzFcat1mQs3jxu_eGFzEp2Vsag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 27 Jul 2023 11:25:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU7J8-tz_UaaAZfLeak7N2D_LPLq3OS7stSxY87nwPYg@mail.gmail.com>
Message-ID: <CAHk-=wiU7J8-tz_UaaAZfLeak7N2D_LPLq3OS7stSxY87nwPYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Fix anon_vma memory ordering
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 14:51, Jann Horn <jannh@google.com> wrote:
>
> Of course I only realize directly after sending this patch that this
> comment only holds... [..]
> ... if we move the smp_store_release() down by one line here.

So I've applied PATCH 1/2 as obvious, but am holding off on this one.

Partly because of the other discussion about memory ordering, but also
due to how the now sometimes much more complex-looking conditionals
could be made a bit visually simpler.

For example the patch does

-       if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+       /* see anon_vma_prepare() */
+       if (!vma || !(vma->vm_flags & VM_MERGEABLE) ||
+                       !smp_load_acquire(&vma->anon_vma))
                return NULL;

which is a understandably mindless "just add the smp_load_acquire()",
but it is also just unnecessarily hard to read.

And the comment placement is a bit misleading too, since it really
only refers to one part of the expression. And that's very obvious if
you know what it's about, but the whole point of that comment would be
that you don't necessarily know why the code is doing what it is
doing.

IOW, that would be much more legible just split up as

        if (!vma || !(vma->vm_flags & VM_MERGEABLE))
                return NULL;

        /* see anon_vma_prepare() */
        if (!smp_load_acquire(&vma->anon_vma))
                return NULL;

I feel.

Also, I'm now wondering about the ordering of that

>                 smp_store_release(&vma->anon_vma, anon_vma);
>                 anon_vma_chain_link(vma, avc, anon_vma);

sequence. Maybe we *do* want the anon_vma pointer to be set first, so
that once it's on that anon_vma chain (and is visible in the anon_vma
interval tree) it always has a proper anon_vma pointer.

*OR* maybe the rule needs to be that any other concurrent user that
sees 'anon_vma' as being valid also can rely on the links being set
up?

I *suspect* the ordering doesn't actually matter, but it just makes me
wonder more about this area.

                Linus
