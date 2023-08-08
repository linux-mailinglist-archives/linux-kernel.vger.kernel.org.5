Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0B774A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjHHU20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjHHU2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:28:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84ABAD3B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:47:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so1215e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 12:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691524020; x=1692128820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opx92wdxHaEdCsoUx6blD14y3bUm677W/w8y424CFjM=;
        b=rOdHMRfqmfxmekOtBHPFVbgPOuNJNj5P2YoTVPabafvcaxty7pOH0fYkqEOnrtdUqf
         uXDmE9Mm1PW/hJRyHan+cG1C+KM5HGSk8KmZ9VFqMjW54smM9iXYgQAQ9z0szl7xS/YA
         WPQKoyk0PCaN1JSt1tm276qno6VoBU+VDXUb9XapvrcECevONoesnk7Adc4Xnay3Qc4A
         BcJ8314cxeyRxoC7ddlsN0jvPltfQCPy3NImI1HkPi/hZArVg+rKP2kA2LiA8/R299Dj
         uLs1BcNO8F1e2Zjmu8Q5gTkCwd+F5NGpBCk6hFJj4zfpZEh3C1mPWxM1zVk+zPFQQPkB
         WQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691524020; x=1692128820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opx92wdxHaEdCsoUx6blD14y3bUm677W/w8y424CFjM=;
        b=UtDwKEhLpANGWEb28eh8z6hcYBvc1LbAu/rz8Y9wDclHCIDQvrF1meIpKrlmPjC6Z0
         u1ZlaltgdJlBGzM8/LN3nbTwVXGIqdO89JjwRRv7JLNKEVNF1Q15kR3oiiXDnH7cPD8u
         ECs+LMfJw404vo++i5Lf6Z7YHo+gHKDMyC0UaBtHY3ud447R4a8RwyBkuRDSKDgxGWQI
         NAUEsTlK9h4VO14bIESh8e05Sdk5aKbcFetcoOmLVhZUVEPjUREi6pWl09uLD5RYfwi2
         rgwmg/sAmEPbjrsAy0lgzSUH0RWMIGVqJpnlq5XwecwFWHI/1MjlCeScWppNif23HPST
         v3YQ==
X-Gm-Message-State: AOJu0Yxox4d2+lsPCciYvX3qXRpDK/wsILJBCuAeMQxl4d5tRAtpeaq6
        UunQKf98pnFyZs/U6d5SgXHhojlh/DJGluzFzleu
X-Google-Smtp-Source: AGHT+IG8xLolBhXWUX3nVCcnA9akVpaFxYzlaEiiOSqMAM/nMgPpHPDyJhLIo165i3vd9p0baWneMPB8lp6e6Jtn0S0=
X-Received: by 2002:a05:600c:3c8a:b0:3fc:75d:8f85 with SMTP id
 bg10-20020a05600c3c8a00b003fc075d8f85mr28835wmb.6.1691524020350; Tue, 08 Aug
 2023 12:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230808062658.391595-1-jstultz@google.com> <20230808062658.391595-2-jstultz@google.com>
 <20230808103637.GA212435@hirez.programming.kicks-ass.net> <CAHmME9oB1PisGNqFTkE3M3YT1Q_bezS39s_xc9x4GkY87PtFtQ@mail.gmail.com>
 <CANDhNCokP08r=NvDhepPsazQtck+LtW+KPbYVE1wc0r=tnm+Vg@mail.gmail.com>
In-Reply-To: <CANDhNCokP08r=NvDhepPsazQtck+LtW+KPbYVE1wc0r=tnm+Vg@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 8 Aug 2023 12:46:48 -0700
Message-ID: <CANDhNCq8TdsL3k9Tn6SPpG9aKydHa=D_jG+29AoZLAmbJd=A9g@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] test-ww_mutex: Use prng instead of rng to avoid
 hangs at bootup
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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

On Tue, Aug 8, 2023 at 11:20=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
> On Tue, Aug 8, 2023 at 7:05=E2=80=AFAM Jason A. Donenfeld <Jason@zx2c4.co=
m> wrote:
> > So, from my perspective, you shouldn't see any hang. That function
> > never blocks. I'm happy to look more into what's happening on your end
> > though. Maybe share your .config and qemu command line and I'll see if
> > I can repro?
>
> Yeah, it may just be that the real RNG is slow enough that I'm hitting
> the hung task watchdog?
> (I'm running with 64 cpus, so the test is trying to use 128 threads
> all hitting get_random_u32_below over and over to create their own
> random order of 16 locks)

Just following up on this point, I went through and disabled all the
hung task and delay detection (and pushed the rcu stall boundary up to
two minutes), and indeed the test did complete without actually
hanging. However, the test took something like 90 seconds to finish
using the get_random_u32_below() calls, whereas with this patch it
finishes in ~18s.

So indeed it's not blocking, just not fast enough to avoid the hung
task watchdogs in this admittedly contrived case (though one that has
been helpful in uncovering issues with proposed scheduler changes) .

I'll try to rework the commit message so the above is clear and resubmit.

thanks
-john
