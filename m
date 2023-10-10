Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636C57C0352
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjJJSW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjJJSW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:22:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C299E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:22:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso10690937a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696962174; x=1697566974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs+iXb7PDw/X1rjcS4aBKNQ3kcels/TfVBa5gZG+NI4=;
        b=DsujLZyCXs/SQEXdOCEMzdj66yidKMaCoTQzhK3YvUCHFDE66PArl87OSmffiylGx6
         HSGe0N14gKrieAXK9NM3Xeh8SxZDEkrLkt9tfkj3pOKEOTtmpBDnwMbDc1REzxfbxod7
         uDPfzvaqDuZIii0z5SHYSPQz+riL1UL/PjhnfDFdzx35XDPuRBG6qrOfGsEOU2ztRie7
         4mHzabs0AogP9i4HC/03XJFPk2+U6yf5h0tsMWHoGgKLSDuDwmf4B3Com0Q1YzwXAFrP
         /aQ5YdcR5xWiKE2ysxJwqKrkQmD3EgzCnJJtrpCQ9Nen7V6oehDdSQRLizXIWgr1vmaI
         roug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962174; x=1697566974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs+iXb7PDw/X1rjcS4aBKNQ3kcels/TfVBa5gZG+NI4=;
        b=WzNdT5E79fmxJ/RIHhIP/TWEtx6fvI3PGxhlRtZvL+MpbrYJo80NGlB3aMVTzezFGQ
         ws/H1BFQkbh5hy58WcYU9jIxqfGm3i1NYEdLuXUkZ0gdljZpBLDri4gccJlIiOZnBqQ7
         qtlYnwerQlGrEcpIXyU04b9M21oWi51LyGVvt7NoRkLmNcREVgA2zwRL4y8orELFS5me
         h81Rd+DdJ3dPJCA2duoH4vEm2qOwlPPq/V4yQjoKGy6tq/O+i2ILyaad3ljB/TWR9snN
         f4O/yyI9wEYDhP59Abrom0VS0x/tCDwxHk6g5B/q5C/dxBWZQeFQq5eW3CUOUJ/s2c3e
         TvYw==
X-Gm-Message-State: AOJu0YwZjdnKlSfg7+LJz/Jvd41RqKj64ULgNOnJzH8iat3rCunr1iS3
        d5suQo0NOFwJ1ZTwP0dMeMFwvzXZ4/2HKKs0TN8=
X-Google-Smtp-Source: AGHT+IGHuYEjmkXE3lV009ISGXKWjBFuOf/pN2h/adBzl2GK2XJ3HtXfMESDEc2V8Qhm6nercVuMFgtxBx37naHb9qo=
X-Received: by 2002:aa7:c493:0:b0:532:c690:92c8 with SMTP id
 m19-20020aa7c493000000b00532c69092c8mr16291264edq.31.1696962173905; Tue, 10
 Oct 2023 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
In-Reply-To: <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 10 Oct 2023 20:22:43 +0200
Message-ID: <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 7:32=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 10 Oct 2023 at 09:43, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Implementing arch_raw_cpu_ptr() in C, allows the compiler to perform
> > better optimizations, such as setting an appropriate base to compute
> > the address instead of an add instruction.
>
> Hmm. I wonder..
>
> > +       tcp_ptr__ =3D __raw_cpu_read(, this_cpu_off) + (unsigned long)(=
ptr); \
>
> Do we really even want to use __raw_cpu_read(this_cpu_off) at all?

Please note that besides propagation of the addition into address, the
patch also exposes memory load to the compiler, with the anticipation
that the compiler CSEs the load from this_cpu_off from eventual
multiple addresses. For this to work, we have to get rid of the asms.
It is important that the compiler knows that this is a memory load, so
it can also apply other compiler magic to it.

BTW: A follow-up patch will also use__raw_cpu_read to implement
this_cpu_read_stable. We can then read "const aliased" current_task to
CSE the load even more, something similar to [1].

[1] https://lore.kernel.org/lkml/20190823224424.15296-8-namit@vmware.com/

Uros.

> On my machines (I tested an Intel 8th gen laptop, and my AMD Zen 2
> Threadripper machine), 'rdgsbase' seems to be basically two cycles.
>
> I wonder if we'd be better off using that, rather than doing the load.
>
> Yes, a load that hits in L1D$ will schedule better, so it's "cheaper"
> in that sense. The rdgsbase instruction *probably* will end up only
> decoding in the first decoder etc. But we're talking single-cycle kind
> of effects, and the rdgsbase case should be much better from a cache
> perspective and might use fewer memory pipeline resources to offset
> the fact that it uses an unusual front end decoder resource...
>
> Yes, yes, we'd have to make it an alternative, and do something like
>
>     static __always_inline unsigned long new_cpu_offset(void)
>     {
>         unsigned long res;
>         asm(ALTERNATIVE(
>                         "movq %%gs:this_cpu_off,%0",
>                         "rdgsbase %0",
>                         X86_FEATURE_FSGSBASE)
>                 : "=3Dr" (res));
>         return res;
>     }
>
> but it still seems fairly straightforward. Hmm?
>
>              Linus
