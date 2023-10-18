Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE47CE277
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjJRQNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjJRQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:13:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17DD9F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:13:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so1081495166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697645584; x=1698250384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jbMhSSWsQ+uhHrbV00NqRePiqwZmI16mBjqyZxPVZCI=;
        b=duRQoe58yIL4nUhvhfsHaJZOWnboCu7qWHTHjBa/1wssq5+lhnAt1ob6EmkjENxvlE
         nPfBNSEWt705Ns3PUE2yRYb+09ZMeaMD3AbFet2Di0H8jPPqLWs6UdwdIdd3SOzu4Kic
         epHLiqBGZlB9swu+axZNMMNlD5m7/OXD9BIK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697645584; x=1698250384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbMhSSWsQ+uhHrbV00NqRePiqwZmI16mBjqyZxPVZCI=;
        b=s7agNXSKlB/U06e51AFA0QUOsKNvRt3GXVnC6SEP+r/4KSwuqie5AtjtgDc2txpaZP
         vZTpkpJo1ndeAv0Pt2GkWGrh19Y99JuL0r5/THa0v2smJ3us0eDRy44Q22RgZmSYoWxm
         P0yNJK1wiCwIbrUpggJPw/AngMYllptj3wcG0SUHLd822TfBBFlx/2olaxUqj4wTmBXH
         jCP8AV7dgzIR/aFhnIj86+as4DUjI2MVuaIFiJVmNtI1LsC3QU63D/jpyFSGFSsuQEG7
         j9D6rpCsAXkLZc2KaDvEIh3bEnrtCEQLv3ylf4o/oFp4cCgYGVtGCmWTYyhvTOp04+I8
         BteQ==
X-Gm-Message-State: AOJu0YwGjpTE8jZAtSqF1eeVKdMSrNXL9ftwZ/YD1CXQvAkEXB+bf71Q
        Ja86bG+wwkX6+YCZS00rjvzLGdK+DkWiQ04Dg0ZJnB7x
X-Google-Smtp-Source: AGHT+IH1s9jZqSi+eRLer+ozgGqbwldoSDM/K75n8Q15aDngxHEGvF0M4QhvRiMglz4dR0X09voryA==
X-Received: by 2002:a17:907:61aa:b0:9c6:64be:a3ac with SMTP id mt42-20020a17090761aa00b009c664bea3acmr3145826ejc.49.1697645584304;
        Wed, 18 Oct 2023 09:13:04 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b009829d2e892csm2037015ejg.15.2023.10.18.09.13.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 09:13:03 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so1081488466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:13:03 -0700 (PDT)
X-Received: by 2002:a17:906:eecd:b0:9c3:cefa:93c0 with SMTP id
 wu13-20020a170906eecd00b009c3cefa93c0mr4181923ejb.38.1697645582806; Wed, 18
 Oct 2023 09:13:02 -0700 (PDT)
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
In-Reply-To: <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 09:12:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB6LHPmnG7=RWNuQYY9=jCY0EmaJ7thRBEFOfDO09dfw@mail.gmail.com>
Message-ID: <CAHk-=wiB6LHPmnG7=RWNuQYY9=jCY0EmaJ7thRBEFOfDO09dfw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 06:15, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Attached is the prototype patch that works for me (together with
> Linus' FPU switching patch).

That looks reasonable, but I think the separate compilation unit is
unnecessary, and I still absolutely hate how that const_pcpu_hot thing
is declared twice (your patch does it in both current.h and in
percpu-hot.c).

How about we just do the whole alias as a linker thing instead? So the
same way that we just do

    jiffies = jiffies_64;

in our arch/x86/kernel/vmlinux.lds.S file, we could just do

    const_pcpu_hot = pcpu_hot;

in there.

Then, as far as the compiler is concerned, we just have

    DECLARE_PER_CPU_ALIGNED(
        const struct pcpu_hot __percpu_seg_override,
        const_pcpu_hot)

and the compiler doesn't know that it's aliased to anything else.

And please do that declaration in just *one* place.

                 Linus
