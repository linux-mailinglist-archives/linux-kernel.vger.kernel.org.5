Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24D7CE2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjJRQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjJRQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:27:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7A137
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:26:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso6269878a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697646418; x=1698251218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa5WhSbXi1geOvYtlQrVXIlJD9l6hQOxw08qavSltA0=;
        b=N8s3FIQwP7ZDvI3RCx/7azZDc46BVrAYwOWyOrcjkNGY3PCG2PEMh6snP89jXFDj0r
         YEpE3SbtrjM/puKcv7xMBuPp8GDkTTqy6lzf0LwUmHNzNj3R5G4KBg8mCm6nrq7vgC84
         OyPdANA2ajDLuLtE05Iv213akT9T03ghUwEh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646418; x=1698251218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa5WhSbXi1geOvYtlQrVXIlJD9l6hQOxw08qavSltA0=;
        b=UfdlbdwIIQaTm0OHOq+7+2iSGA1iZiMywwsCqFN73eBv5WD452pijxKXTmnNxsRivH
         B5g64hlDxJ9rmx9Z0HaDne5gp/F1BlAE9M2Et5hd7sZPVgrAdjd6MboGirXMLeIYKhC6
         VCJuiMSsq0IHm6kCFDpsqt6AwlxCbXhLKZ9exG8e3l9XFjhKMvYVeUOP48IxSHzHYU6N
         8X3RlBMGBDx6CSLftB7rDj9ESTYaxEALtoPL9+o6ASYD/jBDUcmQ+WrgtCCbMlNCXwql
         fvC/EFkRZGRUCOhXnJoXWXgj3Jjm+ve75NWqle22m5MNM8hpOSALK1IAr0A9oMHf+3CH
         kJkA==
X-Gm-Message-State: AOJu0YxSXeKNNbFmImKOlfzKf5IjdA4mmvepncp1DOi8QgdhxNBrm6NZ
        3GOdRgejLZRiH75V8+sbUzcU8gNNxWdH9Qk9/NdGa8yD
X-Google-Smtp-Source: AGHT+IHALmF/G37TYlrLSyndp1zS1Rsv0VZe2k8p/AF7f+zB3vJixAZtdFt9U4jsQ+ix11EUvdEygg==
X-Received: by 2002:a17:907:744:b0:9bf:63b2:b6e2 with SMTP id xc4-20020a170907074400b009bf63b2b6e2mr4844033ejb.26.1697646418116;
        Wed, 18 Oct 2023 09:26:58 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709060c4c00b00997e00e78e6sm1990722ejf.112.2023.10.18.09.26.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 09:26:57 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1139474666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:26:57 -0700 (PDT)
X-Received: by 2002:a17:907:1c0c:b0:9be:b43c:38dc with SMTP id
 nc12-20020a1709071c0c00b009beb43c38dcmr5130678ejc.12.1697646417119; Wed, 18
 Oct 2023 09:26:57 -0700 (PDT)
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
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com>
In-Reply-To: <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 09:26:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
Message-ID: <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 09:03, Nadav Amit <namit@vmware.com> wrote:
>
> Having said that, I am not sure what other usages you have in mind.
> =E2=80=9Ccurrent=E2=80=9D is a pretty obvious straight forward case with =
considerable
> impact on code generation. There may be additional variables, but it is
> likely that there would be more functions/TU in which they would not be
> constant and would require more refined techniques to avoid mistakes
> such as the use of stale cached values.

Yeah, I don't think there really are other cases.

We do have things that could be considered stable (like
"smp_processor_id()" which is stable as long as preemption or
migration is disabled (or it's in an irq-off section).

And it might be lovely to optimize those too, *BUT* that would require
that there be a barrier against that optimization that works.

And if there is anything that this thread has made clear, it's that
the whole 'load from a constant section' doesn't seem to have any sane
barriers.

So while the CSE for inline asm statements is a bit too weak with that
whole "only CSE within a basic block" thing, the CSE of "load a
constant value from memory" is too *strong*, in that we don't seem to
have _any_ sane way to say "now you need to reload".

The traditional way we've done that is with our "barrier()" macro,
which does the whole inline asm with a memory clobber, but even that
doesn't act as a barrier for gcc optimizing the constant load.

Which means that while we'd probably love for the compiere to optimize
smp_processor_id() a bit more, we can't use the 'stable memory
location' trick for it.

Because I can't think of anything but 'current' that would be _that_
stable as far as C code is concerned.

                Linus
