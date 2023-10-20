Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568577D0A21
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376483AbjJTH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376613AbjJTH6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:58:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5EF1704
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:57:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso683229a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697788678; x=1698393478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0CED4KL9zezq3HoQP/JfPVszwxf8r4ApnYMP0RUL/M=;
        b=C0sKfLhmKz3ZqTRasHMRE6II4Pa0r/cb1/FarnECQZORX+7hUyzcrP0gH+ObqisR64
         +7ayUB/sJ4TdkroJKZXOsaW9+nk8ascirrQkusZh5IaCbDF4XNo0PadqmUtZwZBS/+w5
         Fn93P4/tjpStWjH1EgRzslrs8XDW2i3FHwUCB4o9MOclzvauSjK9776AzCKB49Wx2RjE
         xpkx1GmHNzvmEYxx8Lsy9wynU/zDBNYU6ghaGmzSC+eZrDpaMndJUgt61Litdtd2E1vC
         uqPS/Ef+emPedpyXpHEQu7pvj0Eqpi0taXtKCFvEjK4cEAuI2lw09BX5mptJIHemFeCu
         KIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697788678; x=1698393478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0CED4KL9zezq3HoQP/JfPVszwxf8r4ApnYMP0RUL/M=;
        b=JrY+AAdJyeJc6YFBqxYF+nCqGGv+9DLMKL4aRTyBlAH/j9LxJ/zrNHMY/SEEUkSb/N
         olPiXx+2CisQPaqPQh+eJcOEIIBqAw/8trA1CyOMHjzq7qIUbjymKZuUfd4aWnJzvWOW
         qcBLlnyUblgE/CWvLB/D+AYAHJX5OEcJN1HOYRHzHoO+S21yXHktL/3kH3a9jo3fdtb2
         BYRHzbJGaEjpV8t/cxZx2DQwwykAcRmxAy9dTWRD9y73g81G8cYB17q1K3zpHaw5S0ls
         e5AbWUjA+h7OoSyKmIBoJh6YzXDA7nPhk1u1Tbk6Hw9N/XG0Wi8ONiOvrXpAfzNuds7G
         d7MQ==
X-Gm-Message-State: AOJu0Yzb1AGnbJxL7d5w45EU+C9d3K7A3La0K6juEWY/24Sx1QAue+ed
        5VEkUTyv6y++wOw/+9zoTKUpRn7NQ7nYPBSvSus=
X-Google-Smtp-Source: AGHT+IENLJCj6azOkWZ8QWY9aSkT8dAwDkC16bJmsyS+3RwYYFnOtrR7DkuhygLfbS0Ku5nnFxaQqr8qJPJ48XlsPzA=
X-Received: by 2002:a50:ab4f:0:b0:53e:34c5:fc14 with SMTP id
 t15-20020a50ab4f000000b0053e34c5fc14mr844119edc.23.1697788678120; Fri, 20 Oct
 2023 00:57:58 -0700 (PDT)
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
 <CAFULd4YxvMtTEfQL-RiLisTxDwoJZZxXXB+3CWqCpzZkUf85JA@mail.gmail.com>
 <CAHk-=wj0UTj3dfuKK=DEQ+AQ2GPUddjVUVZ_nRHdY=L_rRb2KQ@mail.gmail.com> <CAHk-=wgw6C9kgTAmD4r2XWMbaiMRG3ZqCzYs8VptVekuo2g=Qg@mail.gmail.com>
In-Reply-To: <CAHk-=wgw6C9kgTAmD4r2XWMbaiMRG3ZqCzYs8VptVekuo2g=Qg@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 20 Oct 2023 09:57:46 +0200
Message-ID: <CAFULd4bAZ3iJqfDkV5bJ+1PrjaNMZyqpKCB7D9Fq1q5kQBc7rw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 9:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 19 Oct 2023 at 11:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Honestly, I've actually never seen gcc rematerialize anything at all.
> >
> > I really only started worrying about remat issues in a theoretical
> > sense, and because I feel it would be relatively *easy* to do for
> > something where the source is a load.
>
> .. I started looking around, since I actually have gcc sources around.
>
> At least lra-remat.cc explicitly says
>
>    o no any memory (as access to memory is non-profitable)
>
> so if we could just *rely* on that, it would actually allow us to use
> memory ops without the volatile.
>
> That would be the best of all worlds, of course.

I have made an experiment and changed:

#define __raw_cpu_read(qual, pcp)                                      \
({                                                                     \
-       *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));               \
+       *(__my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));            \
})

#define __raw_cpu_write(qual, pcp, val)                                    =
    \
do {                                                                   \
-       *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) =3D (val);       \
+       *(__my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) =3D (val);    \
} while (0)

Basically, I removed "volatile" from read/write accessors. With all
new percpu patches in place the difference in all percpu accesses is:

Reference: 15990 accesses
Patched: 15976 accesses.

So, the difference is 14 fewer accesses. Waaay too low of a gain for a
potential pain.

The code size savings are:

  text    data     bss     dec     hex filename
25476129        4389468  808452 30674049        1d40c81 vmlinux-new.o
25476021        4389444  808452 30673917        1d40bfd vmlinux-ref.o

So, 108 bytes for the default build.

Uros.
