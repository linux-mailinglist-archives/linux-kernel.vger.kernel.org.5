Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4679D61C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjILQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbjILQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:20:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193CB10E5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:20:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-501eec0a373so9484603e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694535621; x=1695140421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=smeLEFbah2HoW6uf8iZFGOeEFVNCc9b6q/n/ZC4m50w=;
        b=dXCCaoXxYzFQ2achQ7cPp2eIBV+ttbzo1K/uXG4Nt/cxxqp3IdGgl7PbkWFFuF8FSM
         KMDK6qOmBQ6UCL+KNwEAA9luR8Jj3F45GJtACjfGvyKdzR5jhdCQE3J7aFGx4E+GC6ke
         gkRFbALN1kKZwVW19clOMuMO2+Xq5T5hAHpzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694535621; x=1695140421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smeLEFbah2HoW6uf8iZFGOeEFVNCc9b6q/n/ZC4m50w=;
        b=Ij17pHMLKoXdiR14TVIf3KlbdImlJQSn/yNTUQvzpmU9dNTDmT/IU5qlH4OX7pRpd0
         uXWQMx7uMRF6nTDpV0RJtDlLh9olWx85naQS4PnTb9pkITBO2ESElKqwpb8Ud3YmYSjR
         JSkX2VHSUgbqiZ8K6Hse2Sr5OfURko8i4WOuRqsToD/g9oOliwf0Bo1QRybJgIw4+LCQ
         2ZnzR3wdIeK36RJlbdT2jToarlVzOv43VTsKKsbRXOTC5po2ODepTppwFdnXXEsK9C+w
         NbAp9n9u3T+lk7Wxa3DM4+6L2LjGiWwWhdONI38W9x/ImKgWbjBL+ca/NpPZYXtqdGjJ
         Kl5Q==
X-Gm-Message-State: AOJu0YwREUQzgbd732JzA4m8KYIqWoxtQ6MiENf9QnQBrIK1LVIjtDJt
        mUpcZxqhlCmthI3qymfdm4O8CKzNtmEklRyZ0HA9E8U7
X-Google-Smtp-Source: AGHT+IGwI20apAkQ1y7fdMPDvM7dP4269H3f1VdpEZ2U11HklnMAWrilmvg1T3b4vgxPPBFpSvYH2Q==
X-Received: by 2002:a05:6512:3e26:b0:4fd:ddbc:1577 with SMTP id i38-20020a0565123e2600b004fdddbc1577mr66503lfv.2.1694535620967;
        Tue, 12 Sep 2023 09:20:20 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id l25-20020ac25559000000b0050296068a12sm1773511lfk.30.2023.09.12.09.20.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 09:20:18 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so99782971fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:20:17 -0700 (PDT)
X-Received: by 2002:a2e:6e0b:0:b0:2b6:d6e1:a191 with SMTP id
 j11-20020a2e6e0b000000b002b6d6e1a191mr204380ljc.23.1694535617572; Tue, 12 Sep
 2023 09:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com> <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <20230911124856.453fba22@gandalf.local.home> <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
 <ZP/akhSImBVxff0k@casper.infradead.org>
In-Reply-To: <ZP/akhSImBVxff0k@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Sep 2023 09:20:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzTgRgeAXF+6Hu2BvRzrSwPsUbUJy-vrGXGEytQGAY6Q@mail.gmail.com>
Message-ID: <CAHk-=wgzTgRgeAXF+6Hu2BvRzrSwPsUbUJy-vrGXGEytQGAY6Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 20:27, Matthew Wilcox <willy@infradead.org> wrote:
>
> So we do still cond_resched(), but we might go up to PMD_SIZE
> between calls.  This is new code in 6.6 so it hasn't seen use by too
> many users yet, but it's certainly bigger than the 16 pages used by
> copy_chunked_from_user().  I honestly hadn't thought about preemption
> latency.

The thing about cond_resched() is that you literally won't get anybody
who complains until the big page case is common enough that it hits
special people.

This is also a large part of why I dislike cond_resched() a lot. It's
not just that it's sprinkled randomly in our code-base, it's that it's
*found* and added so randomly.

Some developers will look at code and say "this may be a long loop"
and add it without any numbers. It's rare, but it happens.

And other than that it usually is something like the RT people who
have the latency trackers, and one particular load that they use for
testing.

Oh well. Enough kvetching. I'm not happy about it, but in the end it's
a small annoyance, not a big issue.

                Linus
