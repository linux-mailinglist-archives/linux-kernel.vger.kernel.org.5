Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D857CE9D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjJRVNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjJRVMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:12:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CEB125
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:11:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so12066358a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697663473; x=1698268273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gHJkxGGa0xp/KQtfuJ9uEhGm09K/j/y/DFHKEFc7xTE=;
        b=FvIZsWRs+PZBurX8d9VsqZI424flyoZvm8Gg5xdLAplkcJtDp0Nyq3K86SfYHkkxpu
         eb5yu0sCegYMPV9005Yv6cTZlXOfdOt8ybE4HlUWWSbi36dJlEV7G9lEBjbCc3o1OYxE
         ZWlt4oQFpp04OB9hAAyqMuLsdajDgkI4CyHzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663473; x=1698268273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHJkxGGa0xp/KQtfuJ9uEhGm09K/j/y/DFHKEFc7xTE=;
        b=qoig0hoq+4zQGxNweL93VWcM0tbzrrQ2D266Omuw/c6EXntujRV3mBhe7iOI51g8tr
         MiglQzLEvFHiI5SWATddEUDNAfhL2RP0h67UioKEEJ/mPXlb0EPGd+mMJysp2mSF/Ruh
         vCtJhb7qQ2zMJa2NVb9QTbNjG7dpJTDPdPeH8+ZmbjUMXwKw8MPsQxKtjzvh3CATv9sP
         FPNHvhltDTnVUGyyhd/k8Bmes1nssm7j+9FLDe49pkAtv9uEfXzL7k8TA2jqX+Rb2Mpr
         04jYANEGvrakG4Ys1cYI8EyOV36SUz9OkMOBjVu1YAzCQX5nULkfFiV3OLrvJ1oVuj69
         PxcA==
X-Gm-Message-State: AOJu0YyVlUFBVTK+zqdXSMKPP4Pc8ZoQrMiUw3LVchdKQKiQOjfytQBV
        ch3GtxUa5UU0RFh4g1gqxhMehHzX3lZfFbG6BC/aRrfO
X-Google-Smtp-Source: AGHT+IEdJSIV3zwpbjE7G4DVp8eE+JtWJE4WUq4RNR9qoYq51/wruuBZmXRcgQ8PjkILTOgV99JGRA==
X-Received: by 2002:a05:6402:35ca:b0:53e:900f:ca59 with SMTP id z10-20020a05640235ca00b0053e900fca59mr129080edc.38.1697663473169;
        Wed, 18 Oct 2023 14:11:13 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id s23-20020a50d497000000b0053dfd3519f4sm3420566edi.22.2023.10.18.14.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 14:11:12 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so12066329a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:11:12 -0700 (PDT)
X-Received: by 2002:a17:907:e94:b0:9c2:4d0a:c568 with SMTP id
 ho20-20020a1709070e9400b009c24d0ac568mr315639ejc.64.1697663471724; Wed, 18
 Oct 2023 14:11:11 -0700 (PDT)
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
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com> <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
In-Reply-To: <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 14:10:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
Message-ID: <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 13:52, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> FYI: This is the reason RMW instructions in percpu.h are not (blindly)
> converted to C ops.  They will remain in their (volatile or not) asm
> form because of the above reason, and due to the fact that they don't
> combine with anything.

Well, also because converting them to C would be HORRIBYL BUGGY.

They absolutely have to be a single instruction. We have architectures
that can't do rmw instructions, and then they have to do lots of extra
horrid crud (disable interrupts or whatever) to make a percpu 'add' be
a valid thing.


> Actually, RMW insns are better written in asm, while simple "mov"
> should be converted to (volatile or not) memory access.

No.

This remat issue has convinced me that the *only* thing that should be
converted to a memory access is the "stable" case (which in practice
is mainly just 'current').

Because if you make them 'volatile' memory instructions, then the
simple "mov" inline asm is simply better. It still allows CSE on the
asm (in the "raw" form).

And if you make them memory instructions _without_ the 'volatile', the
memory access is simply buggy until we have some 'nomaterialize'
model.

So the *only* situation where a memory access is better is that
'stable' case. In all other cases they are the same or strictly worse
than 'asm'.

               Linus
