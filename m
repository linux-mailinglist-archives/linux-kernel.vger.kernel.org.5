Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1AC7E9379
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjKMAIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjKMAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:08:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3590D7A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:08:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBF3C433C7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699834125;
        bh=J4HknDoArB4ViSGbXTge5MV2QIRiveJDtQEAca3JRFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hi0HjTMI+nRsZwwwx9LHEpR0yFWgWQP53nCLAd/51TrnmA6/mad2w65izFJfcsXY0
         e6JKQ2/xhMNBfSnaOHQUpFT+ooBIhBO1vWu+aVJpKyl1eANCDLQo/X1iYeoHw6Fczn
         8D70/txhskZtPXKmjaZkojsnkPCjhgWn4o6H/ABstX10k/5O/8zaynnJ2H4KwQqZJf
         r6IKjf/1dp5gVo5+aztfyvY6rxkVuER09PaHgcY69tIoUqclIhpAJPSWFrIKj9v1A7
         yvKL+c+kpGTEt+UEXbj1O6Xn7T2v06UbLe1Zp9N2BniTz4zhCG8lMT+rcsa47vJuxG
         GcBUDiS6nXhDg==
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4ac10aacd27so1710922e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:08:45 -0800 (PST)
X-Gm-Message-State: AOJu0YwnXoEOBXRtEKEkml6LHNMEalwtNa5xZccjkiYY29ZYOPLXSfVB
        +XdT5PcjIt3DS5vtWgd4mQ+miJSCsMEEpCUXbPxgfw==
X-Google-Smtp-Source: AGHT+IExtM3e5B9oYl5Q78gHtL5BrHeWXvK+rbc/rl7vuukhHSKNddDfLnVLfVZelEBUmqmA3mEYIczPv1uoHdtexL4=
X-Received: by 2002:a05:6122:458a:b0:495:cace:d59c with SMTP id
 de10-20020a056122458a00b00495caced59cmr5601637vkb.0.1699834124363; Sun, 12
 Nov 2023 16:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu> <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
In-Reply-To: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 12 Nov 2023 16:08:33 -0800
X-Gmail-Original-Message-ID: <CALCETrV+2wPJwZ90-nZFgM9o_f0hCQ4Gf3Y+H+6cdkjoafgiZQ@mail.gmail.com>
Message-ID: <CALCETrV+2wPJwZ90-nZFgM9o_f0hCQ4Gf3Y+H+6cdkjoafgiZQ@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        York Jasper Niebuhr <yjnworkstation@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 11, 2023, at 5:24=E2=80=AFPM, Linus Torvalds <torvalds@linux-found=
ation.org> wrote:
>
> =EF=BB=BFOn Sat, 11 Nov 2023 at 05:24, Willy Tarreau <w@1wt.eu> wrote:
>> IMHO it does not make sense to add a syscall for this, please have a
>> look at prctl(2) instead, which is already used for similar settings.
>
> Honestly, I don't think it makes any sense at all.
>
> If the key manager people can't be bothered to keep track of their
> keys, the kernel certainly shouldn't be bothered with this kind of
> huge hammer.
>
> It looks like an active DoS attack to me, by anybody who just creates
> a huge process and then sits there giggling as the machine comes to a
> complete halt, with the kernel busy zeroing pointless crap.

The implementation in this patch is =E2=80=A6 bad.  But that aside, the who=
le
concept seems wrong to me: zeroing memory specifically when an mm
exits seems rather bizarre -- it's the wrong condition. From a
hardening perspective, there are really three concerning cases, IMO:

1. Something sensitive is in memory, and some bug (side channel or
straight up kernel bug) allows an attacker to read it.  Zeroing early
shortens the window but doesn't actually prevent the attack.

2. Something sensitive is in memory, and some bug allocates the memory
before it's freed.  (I.e. allocator state gets corrupted.)  Like #1,
all we can do is shorten the window.  But these kinds of bugs are
quite rare.

3. Something sensitive is in memory, it gets freed, it gets reused
without __GFP_ZERO, and it gets leaked.  This actually seems fairly
plausible.  While __GFP_ZERO is fairly common, there are tons of paths
that don't use it, and bugs happen.

We do have:

commit 6471384af2a6530696fc0203bafe4de41a23c9ef
Author: Alexander Potapenko <glider@google.com>
Date:   Thu Jul 11 20:59:19 2019 -0700

    mm: security: introduce init_on_alloc=3D1 and init_on_free=3D1 boot opt=
ions


And I can easily imagine a useful API to flag some memory as being
sensitive such that either the kernel will always zero it when freed
or will make sure it's zeroed before being reallocated even if
__GFP_ZERO is not set and init_on_alloc and init_on_free are both
zero.

This would be a rather different patch that exitz().

--Andy


>
> Do it in user space. And if your user space randomly crashes, you have
> other problems - but you can try to use ptrace to catch even that case
> if you care.
>
>        Linus
