Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6526E76599B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjG0RL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjG0RLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:11:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CDD2D7D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:11:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5221f193817so1551997a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690477908; x=1691082708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GvxANQuFKNvKufAyX6mUm0ShC2KKTHC+l1CTdx+XIO8=;
        b=bIXWjHAQipbL2wfAXLamLx5ZXtUMJ9LF7m3R/sNdvy0IQJNfE8afEchWmW6ZEZZ3ub
         DlmG8QFZ4lSv9sRcwGmn5ObSPvzRBUvMWqs/dKhKdePfW47/mL19svD90UcuB3oUF4SA
         buCEXKAUhrdmnzS62lEN7CNr/ns8iS4gKv9D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477908; x=1691082708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvxANQuFKNvKufAyX6mUm0ShC2KKTHC+l1CTdx+XIO8=;
        b=LL0Ns4BOvKhZwnzqYepVvboI/5imELNRG1Nn8ZNmql/oRMv/jfYQhIYfUzazK+xmS0
         mK1CUfhTpWc9SG66rRBj3PKjPZl+klf89dxvW4LeB9uuWbCS8XiytiSGBFZMg7xk8bwx
         iVXzoQVOP2YW/Xmu8Ijy96AWTnRV1xMsZmFZvZetFEnb/85f33Cc7YKih6U2Ft1oJQzh
         FtrUmtU/EJYvkZ17vuDanqnqp7H09/hskuWcxapEa6K15MXJOkQhxc6XrYDHOtKNd1AA
         PRhNKgN1xJmT+UyFL8wxxKQw5W+v5WcY0lKyCaWOff2jt4JYP13MgpxVbnrr+2cLJm9Q
         CPsg==
X-Gm-Message-State: ABy/qLZlhv/Ly8IoG8r1H76dbw1gSnvgKG3VWY6rA0b81soLTcWxyn9c
        Tk8FpeWpCM28YPBYKvt97K3VTGYiP1XyMNf/N9dDcQmN
X-Google-Smtp-Source: APBJJlG7oWcmkQAsuB1Bgn57431Og6/aC3bXfwLqcrC/IyZrf5wVvWHpD4hSStxjUDV4yEL+M8qElg==
X-Received: by 2002:aa7:d6d0:0:b0:522:28fa:3009 with SMTP id x16-20020aa7d6d0000000b0052228fa3009mr2261103edr.13.1690477908749;
        Thu, 27 Jul 2023 10:11:48 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7d055000000b0051e26c7a154sm844527edo.18.2023.07.27.10.11.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:11:47 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bcf2de59cso166417866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:11:47 -0700 (PDT)
X-Received: by 2002:a17:907:2c6a:b0:982:870f:9e8f with SMTP id
 ib10-20020a1709072c6a00b00982870f9e8fmr2474183ejc.62.1690477906607; Thu, 27
 Jul 2023 10:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck> <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
In-Reply-To: <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 27 Jul 2023 10:11:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGjpt77tUYRQA6TxiGERp_rSbcNhuKaWbvoJ6yXPwhhQ@mail.gmail.com>
Message-ID: <CAHk-=whGjpt77tUYRQA6TxiGERp_rSbcNhuKaWbvoJ6yXPwhhQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
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

On Thu, 27 Jul 2023 at 08:44, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> This reads a little oddly, perhaps because it's a fragment from a larger
> piece of code.

Yes. As Jann already said, this is basically a preparatory step in a
much longer sequence, and the code simply wants to make sure that any
later code (possibly quite a bit later) will not see a NULL value.

I do believe it happens to be safe to use READ_ONCE() for a number of
reasons, but I will argue that we should *never* use a bare READ_ONCE
if there is any actual real question about what any memory ordering
might be.

And yes, the RCU code obviously does use READ_ONCE(), so that's why I
say "bare" - the RCU code wraps it in helper accessors with strict
semantics.

The reason I think it would be techncially *safe* to do here is that

 (a) code like this:

        if (READ_ONCE(..))

     may end up having the conditional speculated by the CPU, and have
the actual read done without any ordering by the CPU, but we do have
*one* guarantee: the memory load instruction will be before the
conditional branch (or whatever) in the instruction stream.

     So the code may be *executed* out of order, but we know the
memory load can not be moved after the conditional (whatever form that
conditional then takes) by a compiler.

     (We do have various barriers like "rcu_read_unlock()" that
guarantees that the READ_ONCE() couldn't be moved lmuch later even in
the absence of the conditional, but we can ignore that).

 (b) the later use of the anon_vma (that depends on the value being
stable) is *so* much later, and behind things that the compiler sees
as barriers (again, that rcu_read_unlock() acts at a minimum as a
compiler barrier) that any subsequent use would not have its load
moved down to before the READ_ONCE() in the instruction stream.

     Again, this is purely a "location in the instruction stream"
ordering argument, not a "execution order" ordering argument.

And finally

 (c) I do think that all our architectures have the rules that when
you read from the *same* memory location from the same CPU, the
accesses are ordered.

Now, I didn't actually find (c) spelled out anywhere, but even alpha -
the worst memory ordering ever devised - had that particular rule (the
alpha architecture manual calls it "Location Access Order").

Now, with that said, I did argue to Jann that we should use
smp_store_release and smp_load_acquire pairs here, because honestly,
the above (a)-(c) argument is too damn subtle for me, and I don't
think this particular use requires it.

With smp_load_acquire(), you don't need any of the (a)-(c) rules. The
rule is "the load is done before any subsequent memory operations".
End of story.

So while I do think READ_ONCE() is sufficient here, I actually think
that once you start going down that path you can argue that
READ_ONCE() is actually entirely unnecessary, because we also have
other ordering rules that mean that the compiler can't really do
anythinig else even *without* the READ_ONCE().

End result: I can trivially extend the (a)-(c) to say "even
READ_ONCE() isn't strictly necessary here, because even any access
tearing - which won't happen anyway - wouldn't actually change the
result.

So if we want to make it *obvious* that it's safe, we should use
smp_load_acquire().

And if we do find that there are situations where we care so much
about the (generally fairly cheap) possible additional
synchronization, and we really want to use READ_ONCE() rather than
smp_load_acquire(), I'd rather try to wrap a READ_ONCE in some kind of
better abstraction (maybe make the conditional part of the operation,
and make it clear that you are doing a "one-time test which depends on
the same-location rule".

Do we even have the same-location rule in the LKMM?

                       Linus
