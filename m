Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E27E2B62
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjKFRlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKFRlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:41:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62ABD45
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:41:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-280200949c3so3493412a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699292499; x=1699897299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQokn8UoRY8iyQHlIyiff09+YQ846OAlOmMikNVi4QE=;
        b=Y7bLdpSLCiknwdgFuUphflbtEdlKzes3D/gdhBDCajS1EmTA973AmAgYkAMT3IBlBf
         XW5ovyke3q/513Jh8DAHfR2WqLBlMn1V3tbPSasEZ2dTQ4d+O0weDekxGGrDk108GSdD
         2hquGE/kXf1NTi2JiZ+RVwNgRnSqHgzFHA/Ns/wzTj2zTu0ZL9X4LyCkascxV7XvaFXp
         tIE6YBikgKpaD14V1kyLSYuDnPiU4iDzER9bC05wtKFoKhIp3fEC4ZqazXI/CLMhOZBd
         iFjNugJKcSmwBCZsDGhrn0dMyyHXmqohA8ZQN3fYD2RYQaaR08QR505QfddXazyDpaMb
         CgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292499; x=1699897299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQokn8UoRY8iyQHlIyiff09+YQ846OAlOmMikNVi4QE=;
        b=h2/WlqMc2m/jeL1zBMfwyRZ5cvTWyYqsqhCyoEbPYMvTI0SJD8uSlp+8KlZHsJSq+7
         5zbTwQ1cnsYisat0fIjJHa3nhVXc/0SiPpQS1BuAZk+ZVCHXgKMDQR4q+gOmqSsLbjU5
         HAD7uJHz/OvTDdPM2NfaXW6lUemGwSPgTwpBvE6fQkXPCcREQAVhM5Ox4fI/O7UcpA6m
         OoYGQ6bheUy/dZSeK2YTM90gMd3ih4HTxwhVVqah3H3GVOuK7LpyNj0Pf3mioFWAWwjW
         M1dajWUuL6hU078Fb6znkfiz17/xY9jmhhgyjEF0W0IPXXtn+jVg2Qb7yTf9JYTpdWkA
         nmCA==
X-Gm-Message-State: AOJu0YybTIU/A9JWMWyrAQbQNm+hry0pKUDNZned07MNaoWXDvBSWV9i
        P3cYGe72uR0UWA0twY1/5bSfnKC6HGcB83WWmsA=
X-Google-Smtp-Source: AGHT+IHiAqA6yTXob/0lQXEwVw+XGA3f3QODgmaimdSwl1J9rXBTTAEdCQf7hLfeBep3tDL+zvrXQld8T9b6eCfMYp4=
X-Received: by 2002:a17:90b:4a50:b0:26d:17da:5e9f with SMTP id
 lb16-20020a17090b4a5000b0026d17da5e9fmr10375032pjb.1.1699292499209; Mon, 06
 Nov 2023 09:41:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698077459.git.andreyknvl@google.com> <CANpmjNNoJQoWzODAbc4naq--b+LOfK76TCbx9MpL8+4x9=LTiw@mail.gmail.com>
 <CA+fCnZeQ6nkCbkOR4GqGQ9OzprGNNrXvrOqqsJP0Vr3uJKLdrQ@mail.gmail.com>
In-Reply-To: <CA+fCnZeQ6nkCbkOR4GqGQ9OzprGNNrXvrOqqsJP0Vr3uJKLdrQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Nov 2023 18:41:28 +0100
Message-ID: <CA+fCnZeEkj2TdZ37jFOcYcA-+2BwHta7thMZxPf7n2N4Rt--tw@mail.gmail.com>
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

On Fri, Nov 3, 2023 at 10:37=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Oct 24, 2023 at 3:14=E2=80=AFPM Marco Elver <elver@google.com> wr=
ote:
> >
> > 1. I know fixed-sized slots are need for eviction to work, but have
> > you evaluated if this causes some excessive memory waste now? Or is it
> > negligible?
>
> With the current default stack depot slot size of 64 frames, a single
> stack trace takes up ~3-4x on average compared to precisely sized
> slots (KMSAN is closer to ~4x due to its 3-frame-sized linking
> records).
>
> However, as the tag-based KASAN modes evict old stack traces, the
> average total amount of memory used for stack traces is ~0.5 MB (with
> the default stack ring size of 32k entries).
>
> I also have just mailed an eviction implementation for Generic KASAN.
> With it, the stack traces take up ~1 MB per 1 GB of RAM while running
> syzkaller (stack traces are evicted when they are flushed from
> quarantine, and quarantine's size depends on the amount of RAM.)
>
> The only problem is KMSAN. Based on a discussion with Alexander, it
> might not be possible to implement the eviction for it. So I suspect,
> with this change, syzbot might run into the capacity WARNING from time
> to time.
>
> The simplest solution would be to bump the maximum size of stack depot
> storage to x4 if KMSAN is enabled (to 512 MB from the current 128 MB).
> KMSAN requires a significant amount of RAM for shadow anyway.
>
> Would that be acceptable?
>
> > If it turns out to be a problem, one way out would be to partition the
> > freelist into stack size classes; e.g. one for each of stack traces of
> > size 8, 16, 32, 64.
>
> This shouldn't be hard to implement.
>
> However, as one of the perf improvements, I'm thinking of saving a
> stack trace directly into a stack depot slot (to avoid copying it).
> With this, we won't know the stack trace size before it is saved. So
> this won't work together with the size classes.

On a second thought, saving stack traces directly into a stack depot
slot will require taking the write lock, which will badly affect
performance, or using some other elaborate locking scheme, which might
be an overkill.

> > 2. I still think switching to the percpu_rwsem right away is the right
> > thing, and not actually a downside. I mentioned this before, but you
> > promised a follow-up patch, so I trust that this will happen. ;-)
>
> First thing on my TODO list wrt perf improvements :)
>
> > Acked-by: Marco Elver <elver@google.com>
> >
> > The series looks good in its current state. However, see my 2
> > higher-level comments above.
>
> Thank you!
