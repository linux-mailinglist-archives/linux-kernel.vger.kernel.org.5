Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167027E0ABE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjKCViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjKCViK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:38:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46E112
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 14:38:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5bd33abbb90so1571557a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699047487; x=1699652287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwErFEOvRqH77tvd+byjAioyY68nFad6bltFM5K+5yM=;
        b=FHBr7kO6z3r//88fdW8hxUgzcL/NOp6SZUm+Df1ysGV+z69dA4wxMeruYu/jPt8UTK
         MQRw1mTBas8riiowjd4klRuorwamtzt2pbHipaSoGGQG7kaoH1IzJWiVbda2hsSFiZgA
         ZjAOYHpT8QymeGIFwjulbpmGn9jasLWYBhVfdqA3FCvlAzn/Lm16Yrf/W5aC2X5LG5EK
         nKtD24rTGvig9SgHnz7+wrKIwWr8YsW4kUUY5jEvqGdZXNtKwT14QuNS4+KwhppmHj+8
         Ywr2UlxvFegPI5rxMHP1VL4P37GZsiN85EFtHwDzfemKZaRIfIe0VNVnUT17f1zAhUEy
         2qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699047487; x=1699652287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwErFEOvRqH77tvd+byjAioyY68nFad6bltFM5K+5yM=;
        b=XFuwdiLF9ajAD/Zfkivo8BxVPEApDLEuvMEP/l0rCmjVmHxhjOBmTTxsTpXhcRhf5c
         /WPxHWsZg4AHHbVxoEM+dFGgvh7lZZVfNKWFJu73xCTGUcSQQzvyjkjptixxl64ZAaaG
         0WRPot2qplK4JEJsPwkkojOdAc8tHijC59sdiCBmpIkDWgIZn4iZZfFifY3bkXSn/2JY
         uYZ9dIrrb9Kc8vb5iPkiQsEZcEX+BTSr+iTYlpApOlO0JMqOyVWRgQCVIL0x6WGl9vWn
         2Brr+YMkNqkQW9/yBZcCsZxJ7TU/xcrGgW/UETgYPMKSqcqf3Bh/ylQWIxcaCrSnERON
         Q3Xg==
X-Gm-Message-State: AOJu0YwIZo+Ve39Fk0Qe2XOcALSV0VVnWA8Mle6bQPcwFeMb2pwVRZTY
        EbESFS32bnpiOaqCC5rPOKsCpMY7pjIk+Xrb3RI=
X-Google-Smtp-Source: AGHT+IHOHpCahBHRq/RlAePjwSKPXDC0zfTu4rDCG67yPtPFnTK2BOrf0rCbvsvxxn/F4CJCOpY5+SSFT1/nnzpQUT8=
X-Received: by 2002:a05:6a21:a5a8:b0:15d:d73e:e398 with SMTP id
 gd40-20020a056a21a5a800b0015dd73ee398mr25322907pzc.16.1699047487145; Fri, 03
 Nov 2023 14:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698077459.git.andreyknvl@google.com> <CANpmjNNoJQoWzODAbc4naq--b+LOfK76TCbx9MpL8+4x9=LTiw@mail.gmail.com>
In-Reply-To: <CANpmjNNoJQoWzODAbc4naq--b+LOfK76TCbx9MpL8+4x9=LTiw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 3 Nov 2023 22:37:56 +0100
Message-ID: <CA+fCnZeQ6nkCbkOR4GqGQ9OzprGNNrXvrOqqsJP0Vr3uJKLdrQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] stackdepot: allow evicting stack traces
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 3:14=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> 1. I know fixed-sized slots are need for eviction to work, but have
> you evaluated if this causes some excessive memory waste now? Or is it
> negligible?

With the current default stack depot slot size of 64 frames, a single
stack trace takes up ~3-4x on average compared to precisely sized
slots (KMSAN is closer to ~4x due to its 3-frame-sized linking
records).

However, as the tag-based KASAN modes evict old stack traces, the
average total amount of memory used for stack traces is ~0.5 MB (with
the default stack ring size of 32k entries).

I also have just mailed an eviction implementation for Generic KASAN.
With it, the stack traces take up ~1 MB per 1 GB of RAM while running
syzkaller (stack traces are evicted when they are flushed from
quarantine, and quarantine's size depends on the amount of RAM.)

The only problem is KMSAN. Based on a discussion with Alexander, it
might not be possible to implement the eviction for it. So I suspect,
with this change, syzbot might run into the capacity WARNING from time
to time.

The simplest solution would be to bump the maximum size of stack depot
storage to x4 if KMSAN is enabled (to 512 MB from the current 128 MB).
KMSAN requires a significant amount of RAM for shadow anyway.

Would that be acceptable?

> If it turns out to be a problem, one way out would be to partition the
> freelist into stack size classes; e.g. one for each of stack traces of
> size 8, 16, 32, 64.

This shouldn't be hard to implement.

However, as one of the perf improvements, I'm thinking of saving a
stack trace directly into a stack depot slot (to avoid copying it).
With this, we won't know the stack trace size before it is saved. So
this won't work together with the size classes.

> 2. I still think switching to the percpu_rwsem right away is the right
> thing, and not actually a downside. I mentioned this before, but you
> promised a follow-up patch, so I trust that this will happen. ;-)

First thing on my TODO list wrt perf improvements :)

> Acked-by: Marco Elver <elver@google.com>
>
> The series looks good in its current state. However, see my 2
> higher-level comments above.

Thank you!
