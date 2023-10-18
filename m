Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5717CE47B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjJRR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjJRR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:28:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4823C10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:23:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso7766168a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697649808; x=1698254608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlsBb8jenRCxdIl7j9zet5It8gScLwOuosdLEhMzLL8=;
        b=hADilJN66zRTLr7AXEtinqXjYvyWS5u5TqynljlxOCXyHx4GLpnY6fiP2Nt2gPr1tf
         t8KJs+OoxriN5u3fIbr8ZeDIwOS356uIG1cmQ10eberoU6tndHn8fZuvqU9LlFgQqvzd
         UyRTbNaXCJoPeYNQS2Gixk1z6ECozA+2bLJBn+1X/oexigN0I9Focc9HSZTxPsQ9WTlT
         4g/pmU0PpD+qvkaAIfN4z1edRIkb5vhZlcfQfit0OYGmJZ31fwZlPeJmoXSh6bOfZuCb
         t7NNnu2C1/hcPMmHlQxinpl3rJ2eqjA2kL160ZQwanQnr4x5TFojdO0n1s3asKxkbd06
         rybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697649808; x=1698254608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlsBb8jenRCxdIl7j9zet5It8gScLwOuosdLEhMzLL8=;
        b=FID3FH6UCG+ffQsQWyTdgtGeC/BnDo2E9tK3JLMs5qScRWSpd4Nc6/vZzDKbpMFm/1
         n7c3WStD0nk8JXmJljG6Xs7ndJB6drLWvg1eUT8OrMm/YYvbgjecR/+3QwrNBWJ5SZcA
         Y/gP6Z3OB3ggN76MzY26loD7Uiwf8BXAhy1rU6dKz0pWYLrPJBEmbm5r8DOLJ8FeMasY
         DmKzosAm0Yj2IUhuV/ViTqA+ONr1zZEWX2OAZ8i1z1zgnGA5xtZBoyJFze/Z6fgMtvoo
         NE9uRTfGXzPMHxmP9TRbEAnIqFJXf9kw/h759AkEvCozK/AfycXFCfUcjj+ZR+VGbBkk
         uuEQ==
X-Gm-Message-State: AOJu0YxZqK8aez8NBDFGnlPv47t635FW3tJHluXFVZ9MwetEng0rQjrw
        SxxvMThyPDFx2QSshn+8oOGK9NqykWKsh+P8gRo=
X-Google-Smtp-Source: AGHT+IFa3wKP8yP2QhrxZ9j+N/C/Vk2rSM6WgZHy8OJY8IMPSyQKNLWhNAOUCG2DgDyxbwlZ/ELtvDLfeu2UOQajuuI=
X-Received: by 2002:a05:6402:3493:b0:53d:a7ea:225c with SMTP id
 v19-20020a056402349300b0053da7ea225cmr4865720edc.30.1697649808345; Wed, 18
 Oct 2023 10:23:28 -0700 (PDT)
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
In-Reply-To: <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 19:23:16 +0200
Message-ID: <CAFULd4akMtMxk1C-NsfzYFP6rkt5QUuHACq+BFEJV6u_8n+yiA@mail.gmail.com>
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

On Wed, Oct 18, 2023 at 6:26=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 09:03, Nadav Amit <namit@vmware.com> wrote:
> >
> > Having said that, I am not sure what other usages you have in mind.
> > =E2=80=9Ccurrent=E2=80=9D is a pretty obvious straight forward case wit=
h considerable
> > impact on code generation. There may be additional variables, but it is
> > likely that there would be more functions/TU in which they would not be
> > constant and would require more refined techniques to avoid mistakes
> > such as the use of stale cached values.
>
> Yeah, I don't think there really are other cases.

In processor.h, we have:

static __always_inline unsigned long current_top_of_stack(void)
{
/*
*  We can't read directly from tss.sp0: sp0 on x86_32 is special in
*  and around vm86 mode and sp0 on x86_64 is special because of the
*  entry trampoline.
*/
return this_cpu_read_stable(pcpu_hot.top_of_stack);
}

But I don't know how much it is used.

Uros.

> We do have things that could be considered stable (like
> "smp_processor_id()" which is stable as long as preemption or
> migration is disabled (or it's in an irq-off section).
>
> And it might be lovely to optimize those too, *BUT* that would require
> that there be a barrier against that optimization that works.
>
> And if there is anything that this thread has made clear, it's that
> the whole 'load from a constant section' doesn't seem to have any sane
> barriers.
>
> So while the CSE for inline asm statements is a bit too weak with that
> whole "only CSE within a basic block" thing, the CSE of "load a
> constant value from memory" is too *strong*, in that we don't seem to
> have _any_ sane way to say "now you need to reload".
>
> The traditional way we've done that is with our "barrier()" macro,
> which does the whole inline asm with a memory clobber, but even that
> doesn't act as a barrier for gcc optimizing the constant load.
>
> Which means that while we'd probably love for the compiere to optimize
> smp_processor_id() a bit more, we can't use the 'stable memory
> location' trick for it.
>
> Because I can't think of anything but 'current' that would be _that_
> stable as far as C code is concerned.
>
>                 Linus
