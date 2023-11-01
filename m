Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389D07DE519
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbjKARM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbjKARMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:12:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B3211C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:12:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd644a96so10123132e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698858735; x=1699463535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3dI2vPmAxG2rnU2Trg0UzI1o//xP9o8QWeSVZuORzPA=;
        b=efZJiaHrtrD1ymHaOClSB8ut4NXymIHH7BimtyzqAPny3FI3rPl+HtJUfd0jtFTDRL
         mSLrkBMy4DeZkvch/kU/Yx49g17iFSsCJOB9UDs3HsF9T0MnXRwJH5RD3sft6dYeiurE
         1XnxJyHBsdJVT4qyLK+pQEGfiZpXHXAUC/2nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858735; x=1699463535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dI2vPmAxG2rnU2Trg0UzI1o//xP9o8QWeSVZuORzPA=;
        b=LtUvhIdgHiGiusjuYKOTIDb++BbzYw8+lkPAoTygtG8AJhO1jvZUS29ALIMsG4/5N3
         GZB+DUSI52/I3MODHTCQsHsQNVXaxFjzXCxcL8Y/zDyGmO2dflJ65yOHAJFgbqrftD57
         O6gevrbqqI/Ki4gLWPdYZyMjnISKsM0lavvTksn9EBXw6mvoMjvmIwLbds5JgxZHzcr9
         yqISSaJpa3cV1ta4BNL1otG4WcWWqkEAh9KRTkOQaZzSLG8T8GlvwlQkT4mbsCLJIwV0
         /GU+uJbvbWeqrYhSkRFOjzwYm32YfDBlYY1bDGYED4/uLB4CrANoKzTfKI4N4MMw7B/P
         GrIg==
X-Gm-Message-State: AOJu0YwnfO0ffXbDweQFgYNRSpbWj9Qelns3qwMfc2jT+cQ39K3mrOAY
        pEpBF0XfLjltp4mdxwjWjNy60/+CI4uAkUy6Hd2S7g==
X-Google-Smtp-Source: AGHT+IFjv3RnWTSsG7EtQM11Rm307DpCjSBVNsgoZC3zVf7GJ5BlttnDT/3/hqNocwwAwUxfj3l8Ew==
X-Received: by 2002:a05:6512:1282:b0:505:6ede:20a9 with SMTP id u2-20020a056512128200b005056ede20a9mr15216159lfs.65.1698858735182;
        Wed, 01 Nov 2023 10:12:15 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id u19-20020a17090657d300b009932337747esm154824ejr.86.2023.11.01.10.12.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:12:14 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso6208666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:12:13 -0700 (PDT)
X-Received: by 2002:a17:907:9612:b0:9d4:2042:775b with SMTP id
 gb18-20020a170907961200b009d42042775bmr2500473ejc.30.1698858733416; Wed, 01
 Nov 2023 10:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZTuf+xNrfqGjHFDK@lothringen> <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen> <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
 <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com> <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
In-Reply-To: <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Nov 2023 07:11:54 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiZZB_P57xUPqUg5j7Toany0FNaWO3Ht+Sks7J=XkYnfA@mail.gmail.com>
Message-ID: <CAHk-=wiZZB_P57xUPqUg5j7Toany0FNaWO3Ht+Sks7J=XkYnfA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 at 15:08, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Here are the ways forward I can see:
>
> 1.      Status quo.  This has all the issues that you call out.
>         People will hurt themselves with it and consume time and effort.
>         So let's not do this.

Well, at a *minimum*, I really want that notifier chain call to be
done *after* the core printk's.

That way, if it deadlocks or does something else stupid, at least the
core printouts make it out.

IOW, I think the notifier should be done perhaps just before the
"panic_on_rcu_stall()" call, not at the top before you've even
reported any stall conditions at all.

And yes, I think the trace_rcu_stall_warning() might be better off
later too, but at least trace events are things that get regular
testing in nasty conditions (including NMI etc), so I'm *much* less
worried about those than about "random developers who think they know
what they do and add a notifier".

And yes, I do think the notifier should be narrowed down a lot, if you
actually want to keep it.

I did not actually hear you say that there is a good use-case for it.
I only saw you say "Those of us who need this", without showing *any*
kind of indication of why anybody would use it in reality.

Why the secrecy? There is certainly no current user, nor any
description of what a user would be and what makes that notifier
useful.

The commit message also just says "It is sometimes helpful" and some
strange reference to "the subsystem causing the stall to dump its
state". It all sounds very fishy. Why would anybody ever have a known
subsystem causing RCU stalls? Except, of course, for the rcutorture
testing.

Anyway, that all absolutely SCREAMS to me "this is not something
useful in any normal kernel", and so yes:

> 3.      Add a default-n Kconfig option that depends on RCU_EXPERT
>         and KEBUG_KERNEL, so that these problems can only arise in
>         specially built kernels.
>
> 4.      Same as #3, but use a kernel boot parameter instead of a
>         Kconfig option.

let's make it clear that this is *not* something that any upstream
kernel would ever do, and the *only* possible use for it is some kind
of external temporary debug patch.

See why I so hate things like this? Let's head off any crazy use long
*long* before somebody decides that "Oh, I want to use this".

               Linus
