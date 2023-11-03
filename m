Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A837E07F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjKCSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:17:28 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03781B9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:17:21 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3580b94ac2eso9765655ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699035441; x=1699640241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3y5T7cq892SnU83dYVfN20NJ59cVSzusXtbdmjUBa/c=;
        b=OK0C+0hbKN7I2u+2M84KOE65racriMSTBdXOhjoQROkl4lkXu3squI5fzUDW34+o1S
         D8Ppz+DMWaaXuJPnn3rJdeWXErsJ3mCSZas80N0/ng8WEGp00PH+tzeKiU4Qbq7nD0J+
         rk7wxBBCOoBX1eSSnH22FT6CoE6bXkmeITUVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699035441; x=1699640241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y5T7cq892SnU83dYVfN20NJ59cVSzusXtbdmjUBa/c=;
        b=m0Ty5gVAffCAbwR+L4GM1Ys40wAOw7hYmSyfa4inxGs4UkohVXIZpdiWIC32mixKVR
         8OrV2xNz0/HPS4H5dJs2o9y3wtCI0oGxr9YBhHiUVWquMcp+xlsQXf/NZpXzkrxzg6zF
         qDq6eX9BIXzcOL+j2WUPu/sJII6F9RmRdN4sNm20bn4ERe0khIzhG+A3CCQB6ARCxhyP
         8l6JmCCKJKnI4l/+PNwQaQHxWqjrAKiNXHYxXY9rWF8R54EZqIM/cGmRIDRo6BNQLL0h
         r3FqT7ufWYnPKxjz6HeoHu5Yk5MxFaTJQt1nL3gEbOOBwoO0EaCBkagBqgDoL4xUjacv
         Xdhg==
X-Gm-Message-State: AOJu0YzURQwy3eOCNMy9nCAm9NXCyGcmG03Fr4ivEBjWJB83UT+REAVT
        l4ybxETaLTcGFS355JRAdThnJqHGosHENNSZE3O7pase
X-Google-Smtp-Source: AGHT+IGQms2HCAM4ESbCZlMCjMzWYiLvFD/CsiKTxnqpWBtXnCvlcRTX1AutJ4tM1p/NQJJWjh+dmw==
X-Received: by 2002:a05:6e02:320e:b0:359:3ba1:7745 with SMTP id cd14-20020a056e02320e00b003593ba17745mr13630925ilb.0.1699035440965;
        Fri, 03 Nov 2023 11:17:20 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id t12-20020a056e02060c00b00357a2b367ccsm704880ils.42.2023.11.03.11.17.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 11:17:20 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso3970435a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 11:17:20 -0700 (PDT)
X-Received: by 2002:a17:907:86a7:b0:9dd:bd42:4ec2 with SMTP id
 qa39-20020a17090786a700b009ddbd424ec2mr673300ejc.10.1699035438864; Fri, 03
 Nov 2023 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231102104429.025835330@infradead.org> <20231102110706.460851167@infradead.org>
 <20231102144009.GA9680@redhat.com> <20231103093023.GA8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231103093023.GA8262@noisy.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 3 Nov 2023 08:17:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiGpX9+ajuRZeeX48C9ChwS0qNGj+Gkg_kDiuo6KJV00Q@mail.gmail.com>
Message-ID: <CAHk-=wiGpX9+ajuRZeeX48C9ChwS0qNGj+Gkg_kDiuo6KJV00Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] cleanup: Add conditional guard support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 23:30, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 02, 2023 at 03:40:11PM +0100, Oleg Nesterov wrote:
> >
> > To me
> >
> >       guard(rcu);
> >       guard(spinlock, &lock);
> >
> > looks better than
> >
> >       guard(rcu)();
> >       // doesn't match scoped_guard(spinlock, &lock)
> >       guard(spinlock)(&lock);
> >
> > And this will make guard() consistent with scoped_guard().
[...]
> That said; if we were to do this, then something like:
>
> #define __cond_guard(_name, _inst, _fail, args...) \
>         CLASS(_name, _inst)(args); \
>         if (!__guard_ptr(_name)(&_inst)) _fail
>
> #define cond_guard(_name, _fail, args...) \
>         __cond_guard(_name, __UNIQUE_ID(guard), _fail, args)
>
>   cond_guard(spinlock_try, return -EBUSY, &my_lock);
>
> Becomes possible.
>
> Linus, do you like that enough to suffer a flag day patch as proposed by
> Oleg?

I don't find myself caring too much whether we have that "double
grouping" of the guard type-vs-arguments or the "(type, arg...)"
syntax.

I honestly think that "guard(spinlock)(&lock)" makes it more visually
obvious that the first argument is the "type of guard", while
"guard(spinlock, &lock)" makes it look like the two arguments are
somehow at the same level, which they most definitely aren't.

But I also can't find it in myself to care too much about something
that is so purely syntactic, and that I suspect should be abstracted
away anyway to just become "guard_spinlock(&lock)" with a trivial
helper macro.

                Linus
