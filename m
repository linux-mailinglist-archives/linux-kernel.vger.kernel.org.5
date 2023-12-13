Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D195811A10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378798AbjLMQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:51:09 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E796F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:15 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-46484f37549so2447759137.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702486274; x=1703091074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aZ9Gls1BogU2MReoFJauXP2UgnNIXaBIdamecIfCjI=;
        b=LlP3f+lLIPBascCA2+adLBXWKEu/Ue7Y8JXRF0nEayxwk7LWD959xZEtSi8ktJIijE
         GBxivhUlpImZXMyAyCxvhhcOYGIk2R6YDNEMZMSQOdckB8g+n556UIXbTATnAZkJDthM
         7Xg6bBhJ96eEWCyuqVGbL0lH68x3FlDctOOfb4kLHwt8kzhe1ha44+AcdDV3CTqU6PKM
         Fw87yHuOr3TXqCVW8hMR6oEBa/pq1TrhV5Y6phT3yN4WhHjjS8v/5648cxHQzAw/hcCd
         HIexjtFwEtTDEqtlJbgP98kiwtigjIjQgMiC6EAJYWO2rC2Kqcg72GM7kHggTB10BKzd
         RSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486274; x=1703091074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aZ9Gls1BogU2MReoFJauXP2UgnNIXaBIdamecIfCjI=;
        b=ftnkEDoA10OfkmFJ33zzj0G39ElAwaMHIJFQzLMkuMjL/41OQruvIFnHTc9rHCaM2P
         wlZawF1MsHtJruCKyzIXOxhPsQ3TYCD5knIqVfjJlhgCCAKvzhJweG9Y+GeLR0bwLuJM
         0aaOUHqt3gutWQPmJoDhG0O2cHzsq0kT25sPDaz3ylr8oKX65Rb+pKjtvlQqn1hMrwhC
         PFpdK64csXMVrNuVgCiqMWaDr0Df9BBtH0+8kCoFhm5+yPND9hK9BMz5ZRQVobGhMVBi
         Eqk6ARSHSDnEGkKDev84l7PhfpLIW5xzN6kIRldiaqM2XnVLQkzjQPyb5Gb9JgeSlV1o
         kPwQ==
X-Gm-Message-State: AOJu0Yy7ivBxjTrpAKqzxdf3OLRnoh/5EgYkVsDH9zewTo/kTjeS0dx+
        635xYLMIicHh5ow8P0ZUfw2c98XiiaB9UNtjzkuLuw==
X-Google-Smtp-Source: AGHT+IHQpIkVGJCpLoc6EVwkHmU30myi6H5tPqvw7/ES4Tv2xk+lOzhBDTrqSvlq0+rORSxW/TrAAv6EHgdiBENNGNI=
X-Received: by 2002:a05:6102:188c:b0:464:498f:3b6 with SMTP id
 ji12-20020a056102188c00b00464498f03b6mr4870448vsb.22.1702486274436; Wed, 13
 Dec 2023 08:51:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702339432.git.andreyknvl@google.com> <432a89fafce11244287c8af757e73a2eb22a5354.1702339432.git.andreyknvl@google.com>
 <CANpmjNM9Kq9C4f9AMYE9U3JrqofbsrC7cmrP28ZP4ep1CZTWaA@mail.gmail.com> <CA+fCnZcGWXbpwCxk5eoBEMr2_4+8hhEpTefE2h4QQ-9fRv-2Uw@mail.gmail.com>
In-Reply-To: <CA+fCnZcGWXbpwCxk5eoBEMr2_4+8hhEpTefE2h4QQ-9fRv-2Uw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Dec 2023 17:50:36 +0100
Message-ID: <CANpmjNPEofU4wkmuqYegjDZgmP84yrf7Bmfc-t4Wp7UyYvDc7A@mail.gmail.com>
Subject: Re: [PATCH mm 2/4] kasan: handle concurrent kasan_record_aux_stack calls
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 15:40, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Tue, Dec 12, 2023 at 8:29=E2=80=AFPM Marco Elver <elver@google.com> wr=
ote:
> >
> > > -       stack_depot_put(alloc_meta->aux_stack[1]);
> > > +       new_handle =3D kasan_save_stack(0, depot_flags);
> > > +
> > > +       spin_lock_irqsave(&aux_lock, flags);
> >
> > This is a unnecessary global lock. What's the problem here? As far as
> > I can understand a race is possible where we may end up with
> > duplicated or lost stack handles.
>
> Yes, this is the problem. And this leads to refcount underflows in the
> stack depot code, as we fail to keep precise track of the stack
> traces.
>
> > Since storing this information is best effort anyway, and bugs are
> > rare, a global lock protecting this is overkill.
> >
> > I'd just accept the racyness and use READ_ONCE() / WRITE_ONCE() just
> > to make sure we don't tear any reads/writes and the depot handles are
> > valid.
>
> This will help with the potential tears but will not help with the
> refcount issues.
>
> > There are other more complex schemes [1], but I think they are
> > overkill as well.
> >
> > [1]: Since a depot stack handle is just an u32, we can have a
> >
> >  union {
> >    depot_stack_handle_t handles[2];
> >    atomic64_t atomic_handle;
> >   } aux_stack;
> > (BUILD_BUG_ON somewhere if sizeof handles and atomic_handle mismatch.)
> >
> > Then in the code here create the same union and load atomic_handle.
> > Swap handle[1] into handle[0] and write the new one in handles[1].
> > Then do a cmpxchg loop to store the new atomic_handle.
>
> This approach should work. If you prefer, I can do this instead of a spin=
lock.
>
> But we do need some kind of atomicity while rotating the aux handles
> to make sure nothing gets lost.

Yes, I think that'd be preferable. Although note that not all 32-bit
architectures have 64-bit atomics, so that may be an issue. Another
alternative is to have a spinlock next to the aux_stack (it needs to
be initialized properly). It'll use up a little more space, but that's
for KASAN configs only, so I think it's ok. Certainly better than a
global lock.
