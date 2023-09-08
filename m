Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93563798B53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbjIHRPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIHRPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:15:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5B8CE6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 10:15:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-500c37d479aso3645540e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694193326; x=1694798126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftE86UDOiJ2OxuBofmHmxxisKgEH1PFcf8OJbUZ9prw=;
        b=hKn+qYs/SFvQwH/NKkPyQIcvIHY/YFd34k2cUIBnLgga9M9cvq5wmTrNlBWmcNRg0e
         aCWHTU6Fm1mZlAMkhxudp1ZPrhE4mrD/et7yqqcmwkCn9onK1g3P2wlwrHQH3AcLXCHM
         oGTy8c3xJsG8OXEggrbOzk56nuHYpSu1UVFqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694193326; x=1694798126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftE86UDOiJ2OxuBofmHmxxisKgEH1PFcf8OJbUZ9prw=;
        b=sqYoV23YhXrAPlNqtByX5lb6oFN1ZgJRsJ+k6V7Fwln3nr7VTU3YnjnNcJHkF9Py2Y
         fI/qSIMx+hLS5LwmML9I9CaremA2aKDyNlNgGGJu7xAwv3qSXw+Z4hX2eFSmilaGgEUw
         kXISX1/Se917gjbMO+0Guwz4MTdmtT3biVZXIkJ3Nn/qsYfFzpK6zRIGCURzRfq+q91N
         4E5kB0HlGkNUh9m4lcm2jenzhBrk6FFkqnUmo9dONnEKnIBwFAxoR4QrwekmXgTcLFu+
         Pp1m3XR6Y6iZfCc17irHwwiSI/kA9BudV3kEqDEUogYqN/eieu5/BTpwZ9RU5QzxhMWl
         T0yg==
X-Gm-Message-State: AOJu0YxUcUpPjkRyuOn29YLKi2P7XGZcbkofw4oDGGPbpbnlNvANPKoD
        4CLTqJ7cZkXIcVMvttPjdng66cQpwjKxZUBK9MLbfG26
X-Google-Smtp-Source: AGHT+IGNZ/ljVRqpDGIEjXFE2cCJ1AxuF6HpmgQTb8PcTEgILbjCtLRQafx99oV05eL0c9H5Dl9clQ==
X-Received: by 2002:a05:6512:2346:b0:500:7dc0:b0b2 with SMTP id p6-20020a056512234600b005007dc0b0b2mr3156889lfu.28.1694193326344;
        Fri, 08 Sep 2023 10:15:26 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p14-20020ac246ce000000b004fa52552c7csm332991lfo.151.2023.09.08.10.15.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 10:15:25 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-500c37d479aso3645477e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 10:15:25 -0700 (PDT)
X-Received: by 2002:a05:6512:e9a:b0:4fb:77d6:89c3 with SMTP id
 bi26-20020a0565120e9a00b004fb77d689c3mr3236491lfb.12.1694193324794; Fri, 08
 Sep 2023 10:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
In-Reply-To: <20230908070258.GA19320@noisy.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Sep 2023 10:15:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
Message-ID: <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
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

On Fri, 8 Sept 2023 at 00:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Which on a PREEMPT_COUNT=n build will cause preemption while holding the
> spinlock. I think something like the below will cause sufficient
> warnings to avoid growing patterns like that.

Hmm. I don't think that warning is valid.

Disabling preemption is actually fine if it's done in an interrupt,
iow if we have

        allow_resched();
           -> irq happens
                spin_lock();  // Ok and should *not* complain
                ...
                spin_unlock();
            <- irq return (and preemption)

which actually makes me worry about the nested irq case, because this
would *not* be ok:

        allow_resched();
           -> irq happens
                -> *nested* irq happens
                <- nested irq return (and preemption)

ie the allow_resched() needs to still honor the irq count, and a
nested irq return obviously must not cause any preemption.

I've lost sight of the original patch series, and I assume / hope that
the above isn't actually an issue, but exactly because I've lost sight
of the original patches and only have this one in my mailbox I wanted
to check.

            Linus
