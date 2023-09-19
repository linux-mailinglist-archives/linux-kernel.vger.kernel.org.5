Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC37A6994
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjISRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:25:42 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A579F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:25:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c008d8fd07so41497211fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695144335; x=1695749135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PUjFUwCVE5/xUduoxjL7lC1W3crAzRPXEbwf2O/yhew=;
        b=IJQRWuVT4GWUyGUYFvpMnG+Mgr+MKOYHZcY4hDVFvtc1yPFOVK7pX08ApSParXpHLy
         8aV8hqWNV2c/NIpLAweOm2ZyCQXZOuCGna1apzIJXQA4U+rZD5Dq/LoO3iR6KzZwIiM0
         tn0UyfYpSj5rmmcwj2E2KD7BwbTlvdeeW89ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144335; x=1695749135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUjFUwCVE5/xUduoxjL7lC1W3crAzRPXEbwf2O/yhew=;
        b=DbFOGrP7v5CK1kLuARxt7PZ0H+gt2UGsnAXCSP0Tjen02/Y5GZGCht6EArKDWP4mIZ
         xFDlni2dssfxV8cti2PR4c8ojQV5B0cvIHtf1BqdktUZkfq7irjB63MGsuqiBWU1JT8c
         YxLghluWsnj7Z2jnwqUaF5EBkvY1tcqEue0lO/SIGwc5aLlUs9luQAXYHJuJaYVSqU+F
         7WGoBv8QvN7sswYkMKTeBzktdUpfiPk/ka6Nrmd3nv4Yjq9/ZIzs0nsGHtk2Nk+nZ2Ph
         IkARUI66X+XJESzhA9nRyI1HrG7hMjqLZDJmEzxrH3J+aiAvoo8TojyGEkqfsGnAO4lc
         ET3w==
X-Gm-Message-State: AOJu0YztmOEnZ0SMcLpi6p7GFjMG6j6qUhkpZY1qPPQ1ue3ABAcg6u/v
        xGi/huSYsxUZ4a1V0KoCdp7LOA/FApBn4NXcpDljFry0
X-Google-Smtp-Source: AGHT+IF8Ae+cmBH4eQWVHaaZgDKGTRtmo4iAWhhrV9F//GWD0WSg2+wCvYHyVMTH/+tzlhjhCuXxEg==
X-Received: by 2002:a2e:8084:0:b0:2c0:302d:f995 with SMTP id i4-20020a2e8084000000b002c0302df995mr116672ljg.1.1695144334706;
        Tue, 19 Sep 2023 10:25:34 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id q16-20020a2e9150000000b002c02bccfb5esm381535ljg.77.2023.09.19.10.25.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 10:25:34 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso9430168e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:25:34 -0700 (PDT)
X-Received: by 2002:a19:e04b:0:b0:4fe:3724:fdae with SMTP id
 g11-20020a19e04b000000b004fe3724fdaemr269206lfj.66.1695144333866; Tue, 19 Sep
 2023 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
In-Reply-To: <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Sep 2023 10:25:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Message-ID: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Subject: Re: Arches that don't support PREEMPT
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> As Geert poined out, I'm not seeing anything particular problematic with the
> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> something about organizing KConfig files.

It can definitely be problematic.

Not the Kconfig file part, and not the preempt count part itself.

But the fact that it has never been used and tested means that there
might be tons of "this architecture code knows it's not preemptible,
because this architecture doesn't support preemption".

So you may have basic architecture code that simply doesn't have the
"preempt_disable()/enable()" pairs that it needs.

PeterZ mentioned the generic entry code, which does this for the entry
path. But it actually goes much deeper: just do a

    git grep preempt_disable arch/x86/kernel

and then do the same for some other architectures.

Looking at alpha, for example, there *are* hits for it, so at least
some of the code there clearly *tries* to do it. But does it cover all
the required parts? If it's never been tested, I'd be surprised if
it's all just ready to go.

I do think we'd need to basically continue to support ARCH_NO_PREEMPT
- and such architectures migth end up with the worst-cast latencies of
only scheduling at return to user space.

               Linus
