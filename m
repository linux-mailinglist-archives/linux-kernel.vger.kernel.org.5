Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1B7D889F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjJZS6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJZS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:58:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F82A1A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:58:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507c1936fd5so2734192e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698346681; x=1698951481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCdrR76awIJQhAH7GAdkL7E4ZFaTBKsQRWujNlskIyM=;
        b=R/pipA2GCWrOH4V6HgSk1BBOUVR4Yo9q8QBbSw1dS/jt/LLNcv0SWwje44eXsVZxPt
         hSdRWk8U7g3eq3M2HTvoi6m1RrVRXLx8MbheHHZNsbMgqtN1p8mIjrqe6QrV07g/Eed5
         +oOWiALTyECmV9dqmViv0hK4ksmBJbw69VVXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698346681; x=1698951481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCdrR76awIJQhAH7GAdkL7E4ZFaTBKsQRWujNlskIyM=;
        b=aDq0dA52z5QXCkxyb6eT1DjsFKQSuKVQnNptplGnEK3rySEaFBS9sA1b0eSQ/Xb61p
         PAH7ElHslBxsgvQ3zJVOSkyMTEjoHePui8/QqLdhjVe8Ze1cFiZSVaUoS/55vZujvMyz
         CNkxErDXRF9YsMRUgzQvSelX8/jEao0u8B1b5VibzWzh2ei8WP71UygteWhlhAXSgEXe
         TdOIve+X16EdKzQPht6cNZIPRkNWFrKkT32QRp7yRG4gyoPIvVv3Fe2JrUsv1U23bFv/
         7AyZXr76py+TJroz8+pxVfKyVDe4uhBzUuBSlX3xHrtgRJDzXqgtcqCULoQpZX2C04ed
         L2Kg==
X-Gm-Message-State: AOJu0Yx90n92V5b9m23z+pp6d5ftewov1CRjIEUHTRjchG2FKYbL/Ux6
        1w8YRhxLngaTDKmzJ36dst1p45edO67lA24BuGn1zeTG
X-Google-Smtp-Source: AGHT+IGONZ5AYAKSnonvXL7BAxneclsemu7xxzsP6Gw5xsRHUMSnx3WHBVTt6wYhF/n2YvEvoqpC4w==
X-Received: by 2002:a05:6512:108c:b0:508:1a4c:84b9 with SMTP id j12-20020a056512108c00b005081a4c84b9mr228013lfg.14.1698346680986;
        Thu, 26 Oct 2023 11:58:00 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w2-20020ac254a2000000b00507d1ed897esm3098505lfk.129.2023.10.26.11.58.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 11:58:00 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so1423981e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:58:00 -0700 (PDT)
X-Received: by 2002:aa7:d352:0:b0:541:1e0d:b56f with SMTP id
 m18-20020aa7d352000000b005411e0db56fmr2544458edr.12.1698346251196; Thu, 26
 Oct 2023 11:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231025235413.597287e1@gandalf.local.home> <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
 <20231026071413.4ed47b0e@gandalf.local.home> <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
In-Reply-To: <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Oct 2023 08:50:32 -1000
X-Gmail-Original-Message-ID: <CAHk-=whnyt2TccpDaWGTbDsVkKApL3c2FtDPMEwuTmeu_cEL8Q@mail.gmail.com>
Message-ID: <CAHk-=whnyt2TccpDaWGTbDsVkKApL3c2FtDPMEwuTmeu_cEL8Q@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 08:36, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> >       asm volatile("xchg %b0,%1"
>
> which has an implicit lock prefix (xchg with a memory operand is a
> special-case):

Yeah, this is why we do "percpu_xchg()" - which does not want locked
semantics - as a "cmpxchg" loop.

Steven, check out

    arch/x86/include/asm/percpu.h

for a rough implementation of a 'xchg()' without SMP coherency, just
cpu-local one (ie atomic wrt being preempted by the kernel, but not
atomic wrt other CPU's accessing the same variable concurrently)

             Linus
