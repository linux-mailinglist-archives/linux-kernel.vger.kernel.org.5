Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E657C76AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442098AbjJLTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379697AbjJLTY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:24:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AADB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:24:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae75ece209so218550566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697138696; x=1697743496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQgjxjgdz0Jx9fhWH2hRFe0ialjJ6rtancxgASfDniE=;
        b=HmKsczK5ISJfEsL8NvZ1rtBB6tHM+DWYv7MSFqBkBREVGBeODKiPVV+ZR6WNT2+/WB
         O5wL0UETNCdtamVU8pdnIjUyMdP2s8jGxaB39YE6P6XwmOANpLsQYDRUw9ig+TzXbSC+
         Y9ocL1y4KI2v06a9Co2Ni+4BzYpZMCA9fpC0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697138696; x=1697743496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQgjxjgdz0Jx9fhWH2hRFe0ialjJ6rtancxgASfDniE=;
        b=g+FOA3K0i1FxQ3TYhruG7gW9mgYgeA1lW2zh1jmLIG75gAJspa7lrU7T+1XypJgBoe
         ptv7ASx8kM0dmJI4xgtORi+/zQ/d5DufL1QK5lBN6bgOe7/a7xM3BXlX540PNUSSxOhS
         lsMl2Pk1jKXSR8K6b8QQTDN/DDIp1Mctl5EVJx/JeDFEeExRH6twI3kTcFmHIpTqssYp
         z8Vq1j6qjE4m4vo1dl8kl28mTqAVknkfJ5VZaExzcIaOzAf/+kPA8trmwI9uRXOIIDgh
         FB0a1Xi6bzQNrnKGacIRiKKHzj9UNejpxPyxcN4HKTRklYiQ8hA40xtLETKXmJBgy0sb
         1AYQ==
X-Gm-Message-State: AOJu0YwYhn8kR7LXy+mLn94vM1ULiDRxkcbZ4MZxkcoxw9wkjbNDFQ9q
        riso/6/RRJ9CixVDf0J2Ok/9p9zl+a0hPFiHCKzj65E7
X-Google-Smtp-Source: AGHT+IGUrwZm1CsBPy8yz1jjCWS/5xjRtL+QvROaCDHFOBjTC2tnTFPvCd5Fxi7bFgQSZEmEJC3ayw==
X-Received: by 2002:a17:906:10ce:b0:9a1:e233:e627 with SMTP id v14-20020a17090610ce00b009a1e233e627mr24619363ejv.42.1697138695614;
        Thu, 12 Oct 2023 12:24:55 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id oy3-20020a170907104300b009ae482d70besm11339465ejb.134.2023.10.12.12.24.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 12:24:55 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99c1c66876aso218017066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:24:55 -0700 (PDT)
X-Received: by 2002:a17:906:14e:b0:9ae:74d1:4b42 with SMTP id
 14-20020a170906014e00b009ae74d14b42mr23002308ejh.76.1697138694810; Thu, 12
 Oct 2023 12:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231012143158.GA16133@redhat.com> <20231012143227.GA16143@redhat.com>
 <ZSg5KAFxVzKoFlhZ@gmail.com>
In-Reply-To: <ZSg5KAFxVzKoFlhZ@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Oct 2023 12:24:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsybshMs3KLsyheP8hHhndrRhjo70L1qi+GdBZND8M+A@mail.gmail.com>
Message-ID: <CAHk-=wgsybshMs3KLsyheP8hHhndrRhjo70L1qi+GdBZND8M+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] seqlock: change __seqprop() to return the function pointer
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 at 11:21, Ingo Molnar <mingo@kernel.org> wrote:
>
> Okay, so dropping 'const' makes sense in terms of staying bug-compatible
> with the  previous API and not build-breaking the world - but could we
> perhaps follow this up with fixups of the type misuse and then a removal
> of the forced type casts from these APIs?

No. The use of 'const' here is *not* a bug.

The thing is, 'const' doesn't mean what you seem to think it means. A
'const' pointer in C in no way means that the target is constant - it
means that *THIS* use of the pointer will not write to the target!

Those may sound similar, but they are very very very different.

In particular, for the sequence

        seq = raw_seqcount_begin(seq_ptr);
        ...
        if (read_seqcount_retry(seq_ptr, seq))
                goto retry;

then 'seq_ptr' really *is* a 'const' pointer. The reader very much
does not write to it, and this very much is part of the fundamental
design.

The above is *literally* what sequence locking is all about: readers
are pure readers.

So no, making it a 'const seqptr_t' is absolutely not a bug. It's very
much a FUNDAMENTAL FEATURE of sequence locks.

Now, I'm not sure how much we actually take advantage of this and
there may not be very many cases of this all, but I really think this
is fundamental to the whole data structure, and there are most
definitely cases where we probably *should* take more advantage of the
fact that a read_seqcount is a read-only op.

For example, I think a function like 'dget_parent()' should actually
take a 'const struct dentry *dentry' as its argument, and the seqcount
is embedded inside that dentry and as such would also be const.

Right now the dentry code doesn't actually do that, because this isn't
one of the areas we have constified, but it's conceptually the right
thing to do. We use the dentry argument in a read-only manner
(although the *parent* that we look up then is written to, and in the
case of a root dentry, the parent may end up being the same as the
original).

Note that the 'const' should only be an issue for the begin/retry
cases, and obviously not for the write ones, but those readers do use
the seqprop_ptr() helper. So those absolutely need to handle the const
case.

So no, the cast wasn't "masking" anything at all. The 'const' is real.

            Linus
