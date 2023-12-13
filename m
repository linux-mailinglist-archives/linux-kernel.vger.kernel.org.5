Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBA8114E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442109AbjLMOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442012AbjLMOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:40:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7EDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:40:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d32c5ce32eso22318665ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702478445; x=1703083245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3mJDSsBd+gLTGFYfrkyu9tBgFHp0rV5RVCzftSRiIQ=;
        b=JRDdaQ2B8FQu3KlKWYs8F6bw6Hci22Zt6KSu8+h5085vm02ORdC+xT7gMKPvMxmkiN
         ivnjb+CLoh5sLw1tCoaVyDM7cjXd103faHI1wwzfv2KgmUXJhBX1PtVK4xfa0gBQ5iav
         C00PPhVfcbO1rBftn8plUb24x2BrGVDnGOunB+43Wn8Lq4lSMDWLF07lWnzF8sL3E25f
         zP2QpImegtl5gLmoAWdPHjJpGI86k9ZA5imCxpmXBeD3n9kUITL7ywBSVnvc93Vzb/Gl
         GhsSG0W93y5EiAVv3LrGBOAY1x2u+SkwebyL/eobzovY7Z7gmSetS+YQ7w18Dcn6M22V
         m+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478445; x=1703083245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3mJDSsBd+gLTGFYfrkyu9tBgFHp0rV5RVCzftSRiIQ=;
        b=ZCxeMtbAdFrG4v8fwubEoKVHBpCBu6tPcmqiS1KcuAEUPNeQETPKAG7+OrlBOC4/JR
         djnwrsA2rK++gWM9C3gYQioSuq0c5sOvQcEGCsx57U6IF51JZl2sFmz4mV/OVp+dB7qw
         cfF+OSmgHDSWuxe7emHFDkFvIiTPjoDovzSRvBTiXChtu+jUPkZehjHukqcl2UHAVW0m
         AuyJNKIePGZ+JoKFdjfjtwbjXULvm//0TyzqQGIQnixVg8ZjNfM/J4EUSOCn/w2gejAo
         LVVEn1o5Bg7cMZGKT1BLi9AryrBjA4tp0Vk/nzB3Hyjxf9gJ9Jl8f1inn2WAEVl0F4NL
         U8VA==
X-Gm-Message-State: AOJu0YyZu8IFlXwbeAGRIKuCTO418gs+aprGwGGcOW2oYwnokNUuOUTo
        kJc9ITfvveDtjwQoR9SJ+Xk9bvAhpGrsYsIW4Nc=
X-Google-Smtp-Source: AGHT+IF6caqmkOkKchSE4mSM69yXAgz5JoYHbVboHyzfw8Axgg+y5yFAUSGQz+qEjv5WV2j5pYSexT6qvPQj785jqew=
X-Received: by 2002:a17:90b:e0e:b0:28a:dcda:a101 with SMTP id
 ge14-20020a17090b0e0e00b0028adcdaa101mr1926855pjb.47.1702478445662; Wed, 13
 Dec 2023 06:40:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702339432.git.andreyknvl@google.com> <432a89fafce11244287c8af757e73a2eb22a5354.1702339432.git.andreyknvl@google.com>
 <CANpmjNM9Kq9C4f9AMYE9U3JrqofbsrC7cmrP28ZP4ep1CZTWaA@mail.gmail.com>
In-Reply-To: <CANpmjNM9Kq9C4f9AMYE9U3JrqofbsrC7cmrP28ZP4ep1CZTWaA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Dec 2023 15:40:34 +0100
Message-ID: <CA+fCnZcGWXbpwCxk5eoBEMr2_4+8hhEpTefE2h4QQ-9fRv-2Uw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 8:29=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> > -       stack_depot_put(alloc_meta->aux_stack[1]);
> > +       new_handle =3D kasan_save_stack(0, depot_flags);
> > +
> > +       spin_lock_irqsave(&aux_lock, flags);
>
> This is a unnecessary global lock. What's the problem here? As far as
> I can understand a race is possible where we may end up with
> duplicated or lost stack handles.

Yes, this is the problem. And this leads to refcount underflows in the
stack depot code, as we fail to keep precise track of the stack
traces.

> Since storing this information is best effort anyway, and bugs are
> rare, a global lock protecting this is overkill.
>
> I'd just accept the racyness and use READ_ONCE() / WRITE_ONCE() just
> to make sure we don't tear any reads/writes and the depot handles are
> valid.

This will help with the potential tears but will not help with the
refcount issues.

> There are other more complex schemes [1], but I think they are
> overkill as well.
>
> [1]: Since a depot stack handle is just an u32, we can have a
>
>  union {
>    depot_stack_handle_t handles[2];
>    atomic64_t atomic_handle;
>   } aux_stack;
> (BUILD_BUG_ON somewhere if sizeof handles and atomic_handle mismatch.)
>
> Then in the code here create the same union and load atomic_handle.
> Swap handle[1] into handle[0] and write the new one in handles[1].
> Then do a cmpxchg loop to store the new atomic_handle.

This approach should work. If you prefer, I can do this instead of a spinlo=
ck.

But we do need some kind of atomicity while rotating the aux handles
to make sure nothing gets lost.

Thanks!
