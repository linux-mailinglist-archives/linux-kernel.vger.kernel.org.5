Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C07B0972
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjI0P6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjI0P6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:58:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E9193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:58:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053f24c900so100045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695830309; x=1696435109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H6EKhbh+uwSaVjjFLye5TVhjia4Fh1KKJgT0N4UEBx0=;
        b=NJm8ZQZGMr4oZGANbMqfNNiQl3YhHM5P/B9sKyOClTPb9V14zsDQIDHnnuTn5Ed/IR
         msjf5TWskJLUpz5xXTwbEXVVT88zQ72VwO5VKmpMe6CP8wspxe8W9TpcFiLCCntEBJGP
         5mKLIWP7nWb8fCqYBi8vG2Ic74SsAEgRYQgxEr9W+Cf53LAx5xvRltFS95QVNMhyXbHl
         j+sG9dg+A6O99w0PxdY7dgSDi1zvk2tc8P/cDBbvep6G0+m07cLND7KNE+srzhi49C36
         xSsQj2ILOfhvsy3Dhe9WFO5QrDKA4itNIEGZ0OdhDWgYvCJee9ZgTMrGhsMxzixW6xcd
         kwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830309; x=1696435109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6EKhbh+uwSaVjjFLye5TVhjia4Fh1KKJgT0N4UEBx0=;
        b=JisYkuMLMv7ZDz8E/rifCXl8X09k0Iyx1dlcxuOYUlOJgr7RQLGlyr6XRlKb7uwBZN
         iQXO1zdq19yTiCl+ifChz9McqwlIWwvLt48uTuZBgqskRTamqILo5kO/yEtHfSzaDxv8
         kabmWV6Nax1l3cC74tvL20dQro+rlmDsYxO2E/kDZ1Ov8I2Ab3baY9zET/MSFxnWAS1M
         RGUFPceV0jn5HJVWmuMOdjxynEJ+e80jStnn3cxGODIpQOPHiN9QAGk3oZ8bXMCEX5NT
         DRoKBNo/LGwaw7nnHx7sKC/r0yGp7CjRIQ9app3u2ycAjX7tqf7mcOAUkZK9qLtTLPPc
         5qCA==
X-Gm-Message-State: AOJu0YzLjLROF6jnQnpCgofT6fBXGyxgD3OC6L4Y8eFccsHRPmwO8uS1
        b7/paIVIxQGals6I4mC7IfdwijTPcKllC5jwFymg4w==
X-Google-Smtp-Source: AGHT+IHouwphCDErmnOKBhP+lk3XKIj4HPNAIxtupjaE9J/Cluv/KAGLM81/gWknqRfgR0LQ3k569YyhTiEpXvolNAA=
X-Received: by 2002:a05:600c:4e42:b0:3fe:eb42:7ec with SMTP id
 e2-20020a05600c4e4200b003feeb4207ecmr218651wmq.1.1695830309055; Wed, 27 Sep
 2023 08:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
 <20230926205215.472650-1-dvyukov@google.com> <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
 <875y3wp6au.fsf@oldenburg.str.redhat.com>
In-Reply-To: <875y3wp6au.fsf@oldenburg.str.redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Sep 2023 08:58:16 -0700
Message-ID: <CACT4Y+aVY+KPmBXYDBpA+JmLHvk=o5bt9d4tV5L41e813e0SVw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
To:     Florian Weimer <fweimer@redhat.com>
Cc:     mathieu.desnoyers@efficios.com, David.Laight@aculab.com,
        alexander@mihalicyn.com, andrealmeid@igalia.com,
        boqun.feng@gmail.com, brauner@kernel.org, carlos@redhat.com,
        ckennelly@google.com, corbet@lwn.net, dave@stgolabs.net,
        dvhart@infradead.org, goldstein.w.n@gmail.com, hpa@zytor.com,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        paulmck@kernel.org, peterz@infradead.org, pjt@google.com,
        posk@posk.io, rostedt@goodmis.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sept 2023 at 21:51, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Dmitry Vyukov:
>
> > In reality it's a bit more involved since the field is actually 8
> > bytes and only partially overlaps with rseq.cpu_id_start (it's an
> > 8-byte pointer with high 4 bytes overlap rseq.cpu_id_start):
> >
> > https://github.com/google/tcmalloc/blob/229908285e216cca8b844c1781bf16b838128d1b/tcmalloc/internal/percpu.h#L101-L165
>
> This does not compose with other rseq users, as noted in the sources:
>
>   // Note: this makes __rseq_abi.cpu_id_start unusable for its original purpose.
>
> For a core library such a malloc replacement, that is a very bad trap.

I agree. I wouldn't do this if there were other options. That's why I
am looking for official kernel support for this.
If we would have a separate 8 bytes that are overwritten with 0 when a
thread is descheduled, that would be perfect.
