Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0F7D005E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345940AbjJSRVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjJSRVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:21:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28335126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:21:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507d7b73b74so401231e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697736094; x=1698340894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba/oGqTPfrZodec+lJ/3NDrbOWqxCdK6uYtuTP2TGGA=;
        b=afmTc8K/SLzZTpp1+IeUfchAiseqdx1Y2MP9y/prtsVLSHI/WAJ03iwvaQOP4kNzOX
         iAZZ6qvBi/fSVO54veAsr+dFCiBh2geFJyrMl3Tvx9OyWFPmeTdUIGAmp3w13WnEYV24
         NFD1iAblKCGc2jJT3PPcurTdjd4Xhih8khA6SFQqMhijKQ2AeLoiKKabmzc9pAMdV0Sd
         tUS6JGHC97F6gA6s47mvCZovRgIQVeKZ/IONeRWS4HqxVr1AZpbjWc2R/qlTY/51uJuF
         wyH19REAmlMK5SqJDq6t6eI8qumh6ZzftsGlHdYS4qGfULmKH/lxPV4CzmUJSqEdLS0m
         dXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736094; x=1698340894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ba/oGqTPfrZodec+lJ/3NDrbOWqxCdK6uYtuTP2TGGA=;
        b=etMnIXr/QzFFPI97/+MybNOXuUYNmjZ73xH3CbHzwBLxC9IiSZJidnKnuOK93v6sLp
         H8ElMymwFftDlRT5kq5pPBun5mqG+lZ0XGBJSVy4XzOIbiW7FZ+jv/Jxma/GmiApBvQ0
         jvUJW186NIoyJ+EI6Ab6mPve32wlvIHiebOdRs8HvgVsHjqbvNCiEPBq3lEwkpypT2Ea
         DLnju7cHoBlsNQjYUT1wtwOlzinBAgWrfvHUZXDQOWgiIBO/Zg6Wf9LsNsNMngR+8f/Z
         xoO577fd4z6uDmy/B3jedFiwvNEOtF7bvTjttNvar2XgaaDp7ViIwNjK3fuhMT7voAp3
         W3xQ==
X-Gm-Message-State: AOJu0YxQDRvmHeAODVY8dRWgQgiXRa9hTnpfLWiYslESahZ8t5hYKsfO
        qv2I/NTsKNik+Ug9nQDb+LEFoxrZ+BHl+hZOqEI=
X-Google-Smtp-Source: AGHT+IEw1S6NU05auS21hPUpgUEtWHBaIpgBlqmM2ymYmNY63YBhI9iyVylaDIBYigt5b27qry9WKnNxtp4wXBURO9A=
X-Received: by 2002:ac2:5a50:0:b0:500:b5db:990b with SMTP id
 r16-20020ac25a50000000b00500b5db990bmr1944154lfn.47.1697736094137; Thu, 19
 Oct 2023 10:21:34 -0700 (PDT)
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
 <CAFULd4avm_TaEoRauohRc90SUrx-D+wBJvg+htQDQ1_N=zNemw@mail.gmail.com> <CAHk-=wijmmRB7-ZeT-sdxCSUoB83Lb5dnN7a7mCcH3cRw_aghQ@mail.gmail.com>
In-Reply-To: <CAHk-=wijmmRB7-ZeT-sdxCSUoB83Lb5dnN7a7mCcH3cRw_aghQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 19 Oct 2023 19:21:22 +0200
Message-ID: <CAFULd4b91Tr9Q2p4a20eusC+QO6O81gxY+nP-zpFiFKGTmLpYg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 7:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 19 Oct 2023 at 00:04, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Let me explain how the compiler handles volatile.
>
> We're talking past each other.
>
> You are talking about the volatile *memory* ops, and the the
> difference that "raw" vs "this" would cause with and without the
> "volatile".
>
> While *I* am now convinced that the memory ops aren't even an option,
> because they will generate worse code, because pretty much all users
> use the "this" version (which would have to use volatile),

Please see [1]. Even with volatile access, with memory ops the
compiler can propagate operands, resulting in ~8k code size reduction,
and many hundreds (if not thousands) MOVs propagated into subsequent
instructions. Please note many code examples in [1]. This is not
possible with the asm variant.

[1] https://lore.kernel.org/lkml/20231004192404.31733-1-ubizjak@gmail.com/

> Because if we just stick with inline asms, the need for "volatile"
> simply goes away.

No, the compiler is then free to remove or duplicate the asm (plus
other unwanted optimizations), please see the end of chapter 6.47.2.1
in [2].

[2] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Extended-Asm.html#Volatil=
e-1

> The existing volatile on those percpu inline asms is *wrong*. It's a
> historical mistake.

Please see above.

> And with just a plain non-volatile inline asm, the inline asm wins.

Please see [1] for the code propagation argument.

> It doesn't have the (bad) read-once behavior of a volatile memory op.
>
> And it also doesn't have the (horrible correctness issue)
> rematerialization behavior of a non-volatile memory op.

Unfortunately, it does. Without volatile, asm can be rematerialized in
the same way as it can be CSEd. OTOH, the memory op with memory-ops
approach is casted to volatile in this_* case, so it for sure won't
get rematerialized.

> A compiler that were to rematerializes an inline asm (instead of
> spilling) would be a bad joke. That's not an optimization, that's just
> a crazy bad compiler with a code generation bug.

But that is what the compiler does without volatile.

Thanks,
Uros.
