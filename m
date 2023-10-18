Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696D7CEA25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJRVlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:40:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB30EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:40:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso11482274a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697665255; x=1698270055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=282qgW426ecEuopzF8jbvOzMje/HUlZNH6e92nVI8WY=;
        b=ebRf3TFglxricBN6ZBjV8FRTGmgKBy1gDYqT1R+4XPopDYV7NPgknezC1ZjO1NZeIa
         Jx6pgstOWXlso8nkjAQHYBTzTDE4IifM1HFa29DjaQ03n/OeLVpNrMOzkal+at7o0N6S
         ansPExPFr6a8Teo9usdsQ87spZ6PqBtXORkXyEG8AdWRnzkuSewJ0NXOAibkLHhFbmIV
         ubAejL8LKCKD5q8UbGnUYC7je9ZgLUrbnrNKY8XmyuI3/LXJhB/5waURTJtIhMq7Q2it
         +zCkh7RhHqtb3uXMb54OmQKcFgJa4e4Gxm0STTOmO1J/UKAh8TduvDsmnYzQ5TF4PR+W
         A34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697665255; x=1698270055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=282qgW426ecEuopzF8jbvOzMje/HUlZNH6e92nVI8WY=;
        b=KnNQmERkdIku08sa97x9U929hD/vSk1FmYfrLmMyjXdg1AoLfGAigBpvnNr10pOZZB
         xSiBRIadLMovD6fKefX68ke0RWDBwc393oHE38rR6ZqsmDo2OysXseBIRtMWES3iqGUU
         jMKDmg+mv3DavBTMGdX1N86pZ7iKtQ9SM+tBDuF1opmljNj3t3Sl8S8YZN/PwubsQoZ3
         uQf0RGZKsBKU3ayO5WpJyqONf3V7Peu4nwmHxDxTq0fCZUYN7YCFhRI+jz3AzfjKyhhj
         /eyqI5WczKE3AfHCws0Xaez0hHCWkRj8RAYpP5yr/azaphwSngDqtkC+rhmqUdu1aRcv
         CaRg==
X-Gm-Message-State: AOJu0Yx647Nei+idaXgcHK2aMFsoVIO18SgEOrzhtt03W7Y77Z4cMFdi
        Da8bTPmWAjsb4OyknQgeFp/819VW+OgdZ6rVhxM=
X-Google-Smtp-Source: AGHT+IGGRL7L4GtDBt1y9EoDQOlzmdSzOspX1xwYnk5IFCr7di1DH+ySUWsnlX46grO7M+VMe2VHqNVoRLAqZxDGntw=
X-Received: by 2002:a50:d79b:0:b0:53e:5cde:b3c6 with SMTP id
 w27-20020a50d79b000000b0053e5cdeb3c6mr163892edi.31.1697665254606; Wed, 18 Oct
 2023 14:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com> <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 23:40:42 +0200
Message-ID: <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, Oct 18, 2023 at 11:11=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 13:52, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > FYI: This is the reason RMW instructions in percpu.h are not (blindly)
> > converted to C ops.  They will remain in their (volatile or not) asm
> > form because of the above reason, and due to the fact that they don't
> > combine with anything.
>
> Well, also because converting them to C would be HORRIBYL BUGGY.
>
> They absolutely have to be a single instruction. We have architectures
> that can't do rmw instructions, and then they have to do lots of extra
> horrid crud (disable interrupts or whatever) to make a percpu 'add' be
> a valid thing.
>
>
> > Actually, RMW insns are better written in asm, while simple "mov"
> > should be converted to (volatile or not) memory access.
>
> No.
>
> This remat issue has convinced me that the *only* thing that should be
> converted to a memory access is the "stable" case (which in practice
> is mainly just 'current').
>
> Because if you make them 'volatile' memory instructions, then the
> simple "mov" inline asm is simply better. It still allows CSE on the
> asm (in the "raw" form).

The ones in "raw" form are not IRQ safe and these are implemented
without volatile qualifier.

The safe variant are ones with "this" form. These were implemented as
volatile-asm and are now implemented as volatile reads. They do not
rematerialize, the number of memory accesses stays the same. They do
not CSE (volatile-asm also doesn't), but they can propagate into
follow-up instructions.

> And if you make them memory instructions _without_ the 'volatile', the
> memory access is simply buggy until we have some 'nomaterialize'
> model.

This is the reason that almost all percpu access is implemented using
this_* accessors. raw_* is a relaxed version without IRQ guarantees
that should be (and is) used in a controlled manner in a special
places:

https://elixir.bootlin.com/linux/latest/A/ident/this_cpu_read
https://elixir.bootlin.com/linux/latest/A/ident/raw_cpu_read

>
> So the *only* situation where a memory access is better is that
> 'stable' case. In all other cases they are the same or strictly worse
> than 'asm'.

No, argument propagation is non-existent with "asm" version.

Uros.
