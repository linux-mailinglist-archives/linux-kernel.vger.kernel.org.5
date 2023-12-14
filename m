Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07968123FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjLNAl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLNAly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:41:54 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD0B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:42:01 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6da330ff8fdso1236049a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702514521; x=1703119321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzK45zb0LxFLrNRkOxquQyQenMKLSRC3JhAeRqUtSRE=;
        b=LpRw6NoPBGcbQtYMkBZkjMZSX8Zz/Efr4xDYWpWyCw5K1otpiEuPoGwekrgRA89pG3
         2yblUfNgxSTENp4Iua+0FN33g8aqjN4ykKmKG0NerfUf5xp4XkrKL5dqPuzYMoBSarrP
         EoLsS1Y9OXTOjYfiYb8APXbkqiM9qV7DI2gCZLCSaOD0OimZh/1MFd5pJIU56rIJNWoh
         cEm8xXR8YGCrkIDlECIqICIfkQgy+Tve3FLbK33QJrILI0juLl25+el3jaq8LLt/XFhp
         U1L/rzPX+hiB6RETyIiVSa9iKVFCVHcNbTqsISaiOtBzALvbSnXvsTlMMFE2TTF5adxJ
         0tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514521; x=1703119321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzK45zb0LxFLrNRkOxquQyQenMKLSRC3JhAeRqUtSRE=;
        b=Mnpj6bX/MO9lPvPIOhRN6cTa9soSaHSLv3RcNEW+g3OPUGdvsKcE3CVh5U+kNBnEoG
         syhlmAfi7cuRk6RUJbcCEvCb0Z6DA8FmrfOweeO5ob4rGUPY9gD+ofJzreAb/iu4yqBb
         1hoBaaeib1ccR66KalefmMjiw4LV47nILrz02sJXeGO0N6bbfMfDUFz+wC6qEa9Yhu1y
         H5NFgOYV7RIAOXzo0WT6F9CSmhM98mX1QabXM0qZz3yjDsG+e0KMmqsswu/u0ats5rIf
         hnbfYJH6Vq3gZZka2hjzRW882glEL4i3Y+2bA4RhcgREwjoCaGofnQ/aD17s+AQjjfuV
         B0QA==
X-Gm-Message-State: AOJu0YzI7CK14DpXHVy6EWIusso956nV5x4lOAgtbxx5XytSvDBHBDQY
        Cm050llZivwFJsixluZzk7g9xptQxhMVbu3QdA4=
X-Google-Smtp-Source: AGHT+IGMTFCE9oaDso7qlnVj3yEBftp5GlnkEY1TwrVseMJ8q7KOPWfmxpkgO4AojopgKh50WCetfRXcgrPixf49kQw=
X-Received: by 2002:a05:6830:4423:b0:6d8:7ba7:c8b4 with SMTP id
 q35-20020a056830442300b006d87ba7c8b4mr11075778otv.6.1702514520732; Wed, 13
 Dec 2023 16:42:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702339432.git.andreyknvl@google.com> <432a89fafce11244287c8af757e73a2eb22a5354.1702339432.git.andreyknvl@google.com>
 <CANpmjNM9Kq9C4f9AMYE9U3JrqofbsrC7cmrP28ZP4ep1CZTWaA@mail.gmail.com>
 <CA+fCnZcGWXbpwCxk5eoBEMr2_4+8hhEpTefE2h4QQ-9fRv-2Uw@mail.gmail.com> <CANpmjNPEofU4wkmuqYegjDZgmP84yrf7Bmfc-t4Wp7UyYvDc7A@mail.gmail.com>
In-Reply-To: <CANpmjNPEofU4wkmuqYegjDZgmP84yrf7Bmfc-t4Wp7UyYvDc7A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 14 Dec 2023 01:41:49 +0100
Message-ID: <CA+fCnZd8_iOgf6HzDSemHJgs8S6doMJJK4YhcwT1M-oBePe7HA@mail.gmail.com>
Subject: Re: [PATCH mm 2/4] kasan: handle concurrent kasan_record_aux_stack calls
To:     Marco Elver <elver@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 5:51=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> > > [1]: Since a depot stack handle is just an u32, we can have a
> > >
> > >  union {
> > >    depot_stack_handle_t handles[2];
> > >    atomic64_t atomic_handle;
> > >   } aux_stack;
> > > (BUILD_BUG_ON somewhere if sizeof handles and atomic_handle mismatch.=
)
> > >
> > > Then in the code here create the same union and load atomic_handle.
> > > Swap handle[1] into handle[0] and write the new one in handles[1].
> > > Then do a cmpxchg loop to store the new atomic_handle.
> >
> > This approach should work. If you prefer, I can do this instead of a sp=
inlock.
> >
> > But we do need some kind of atomicity while rotating the aux handles
> > to make sure nothing gets lost.
>
> Yes, I think that'd be preferable. Although note that not all 32-bit
> architectures have 64-bit atomics, so that may be an issue. Another
> alternative is to have a spinlock next to the aux_stack (it needs to
> be initialized properly). It'll use up a little more space, but that's
> for KASAN configs only, so I think it's ok. Certainly better than a
> global lock.

Ah, hm, actually this is what I indented to do with this change. But
somehow my brain glitched out and decided to use a global lock :)

I'll change this into a local spinlock in v2.

Thank you!
