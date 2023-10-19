Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D047B7D04EF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbjJSWjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjJSWjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:39:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ADB115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:39:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so196633e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697755172; x=1698359972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf4UVfm9ejOuj/+1if2blVbFZkZx0qYyb9UZRpdYTtM=;
        b=eGyoMnQJ+ZzjkezGDNdPHNuXnOo6/ZO6a/BEKlN1j8fEaE5sx8Fi9oRP7ViDovgY+W
         iVIZumuj/ZSoa2gdaYBEjKpmTEBnZsUZsVONXYlWvvudyly9BrQKC9gWIIF3oHndUJVM
         o9Z8N6l0GtkFEScaTwmbVc2MNNEUQBf74fHMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697755172; x=1698359972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf4UVfm9ejOuj/+1if2blVbFZkZx0qYyb9UZRpdYTtM=;
        b=bJ29A1Z1BuJ12fJZJ4q1e8Ri+f5WaMxoMJgZet9ZwIIfyv/ZiCztrECmdwBegjsz6Z
         F/tLFBAW43hHgzMFy/xs6rNP7DONcFrkvPz+b6So3lNXG6XFrPPUpwOYZJ1sTWLFfQTQ
         xiJxKKaciNQOIPON9h40/ILxCjDqVWCOLxRu66QOOzdYZsgoHjudUnDN6JrPTyMnpxYi
         pdJOay459tSpa7VOycmurs1UEEpbdnCn+GJdftFcaGsLaXn0KY2LA5oKc1OB7RZphSIO
         a/hJaG8YyFbHfrXRpX/qs1sAFqyQCgFIvzpf5SteSIMrJgmxUzOMizyPRVLgbmmDDFsA
         m+Cw==
X-Gm-Message-State: AOJu0YztH4nV6SoPBeA75DnfSunVqjNA0P8fl1KzThWs5lbp9mkwnGKj
        Y6AXnc2adFwByUKyZzsuO3eLe89dqJgGy5hmHqHx9kOG
X-Google-Smtp-Source: AGHT+IH2tb9dwXv1nIP5phJVsdXHEiisOeTipote9Qcxo7AN7vY4c8J0GIyhk593rJfNyzUcA9l7Iw==
X-Received: by 2002:a19:e05e:0:b0:507:b15b:8b99 with SMTP id g30-20020a19e05e000000b00507b15b8b99mr45225lfj.60.1697755171740;
        Thu, 19 Oct 2023 15:39:31 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id t14-20020aa7d70e000000b0053e4783afbasm312747edq.63.2023.10.19.15.39.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 15:39:30 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so212413a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:39:30 -0700 (PDT)
X-Received: by 2002:a17:907:3d9f:b0:9b2:b152:b0f2 with SMTP id
 he31-20020a1709073d9f00b009b2b152b0f2mr38956ejc.10.1697755170439; Thu, 19 Oct
 2023 15:39:30 -0700 (PDT)
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
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
 <CAFULd4avm_TaEoRauohRc90SUrx-D+wBJvg+htQDQ1_N=zNemw@mail.gmail.com>
 <CAHk-=wijmmRB7-ZeT-sdxCSUoB83Lb5dnN7a7mCcH3cRw_aghQ@mail.gmail.com>
 <CAFULd4b91Tr9Q2p4a20eusC+QO6O81gxY+nP-zpFiFKGTmLpYg@mail.gmail.com>
 <CAHk-=wi3LZ_4OGAMhvgO0JSTp-eEPOGp+siq1nJNLY1JAxdP5Q@mail.gmail.com>
 <CAFULd4YxvMtTEfQL-RiLisTxDwoJZZxXXB+3CWqCpzZkUf85JA@mail.gmail.com> <CAHk-=wj8qEwR1eGeJdup2q90WK7ZWBjpcXJEBi-TBp29p0n8oQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj8qEwR1eGeJdup2q90WK7ZWBjpcXJEBi-TBp29p0n8oQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 15:39:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvHDp+oiC4UZxivF6fCjKWFAAzgBYZdng6qe+ED6rLTg@mail.gmail.com>
Message-ID: <CAHk-=wjvHDp+oiC4UZxivF6fCjKWFAAzgBYZdng6qe+ED6rLTg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     peterz@infradead.org, Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unrelated question to the gcc people (well, related in the way that
this discussion made me *test* this).

Lookie here:

    int test(void)
    {
        unsigned int sum = 0;
        for (int i = 0; i < 4; i++) {
                unsigned int val;
    #if ONE
                asm("magic1 %0":"=r" (val): :"memory");
    #else
                asm volatile("magic2 %0":"=r" (val));
    #endif
                sum += val;
        }
        return sum;
    }

and now build this with

    gcc -O2 -S -DONE -funroll-all-loops t.c

and I get a *completely* nonsensical end result. What gcc generates is
literally insane.

What I *expected* to happen was that the two cases (with "-DONE" and
without) would generate the same code, since one has a "asm volatile",
and the other has a memory clobber.

IOW, neither really should be something that can be combined.

But no. The '-DONE" version is completely crazy with my gcc-13.2.1 setup.

First off, it does actually CSE all the asm's despite the memory
clobber. Which I find quite debatable, but whatever.

But not only does it CSE them, it then does *not* just multiply the
result by four. No. It generates this insanity:

        magic1 %eax
        movl    %eax, %edx
        addl    %eax, %eax
        addl    %edx, %eax
        addl    %edx, %eax
        ret

so it has apparently done the CSE _after_ the other optimizations.

Very strange.

Honestly, the CSE part looks like an obvious bug to me. The gcc
documentation states:

     The "memory" clobber tells the compiler that the assembly code
     performs memory reads or writes to items other than those listed in
     the input and output operands (for example, accessing the memory
     pointed to by one of the input parameters).

so CSE'ing any inline asm with a memory clobber sounds *very* dubious.
The asm literally told the compiler that it has side effects in
unrelated memory locations!

I don't think we actually care in the kernel (and yes, I think it
would always be safer to use "asm volatile" if there's some unrelated
memory locations that change), but since I was testing this and was
surprised, and since the obvious reading of the documented behavior of
a memory clobber really does scream "you can't combine those asms", I
thought I'd mention this.

Also, *without* the memory clobber, gcc obviously still does CSE the
asm, but also, gcc ends up doing just

        magic1 %eax
        sall    $2, %eax
        ret

so the memory clobber clearly does actually make a difference. Just
not a _sane_ one.

In testing, clang does *not* have this apparently buggy behavior (but
clang annoyingly actually checks the instruction mnemonics, so I had
to change "magic" into "strl" instead to make clang happy).

Hmm?

                  Linus
