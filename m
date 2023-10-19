Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6487D013B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbjJSSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjJSSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:16:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BA124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:16:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507c91582fdso2866903e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697739396; x=1698344196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMvBZw/5ibdJUtRpjBP1gLboueYiqJ7FmUJP3xGwISY=;
        b=Lz7EWYYCxgfXfnRR1b5i8rQo4EZ1BWBr+Eb6NXmk3DSNaTe7/+v2Bf0BvkXS2Wixlm
         YeBX2D1hBa2tmQUft9ozJFhuggnsH2UZoGPPaurug73VCR8oBVEfsrywSogmVmKzEY0O
         IEL7rQqGKZVfVQp0+lAKLbGOMVMnp2IIFygHifHVm16LH6s1HK57XXjMMStpzkmBNjg9
         vPPxWccLZEkLsypobfcsuC9Bw/+W2YOZbMZhYA+nW69X+vYlaKepMIRnNbmqJ9o99MVJ
         LPgB78giTjHBkoQOHF4x4fJkuScUTMYtO6l6ewEpfM7093NeXWsAwHl6yDpZ4UBD+YYM
         gNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739396; x=1698344196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMvBZw/5ibdJUtRpjBP1gLboueYiqJ7FmUJP3xGwISY=;
        b=sFJCaTHd734SH2GNm+0qKMsYwzntJA2lgWaGTC1/SMJxNq34yB3OVCzXIocVhKjNf5
         PsCNAMKCFmuCVoMi5yxu1t5oO01IHKSOyEVXjRogr7BdECBxZFI4uc7G8AcFxUK3wwJl
         1LOe+pp9tReka/tzpV8i4YOw4AF6GxJn/Ivx6NMvZ6dqtvw4vlAxT1UEPIT1YOGExZbk
         SsU1v40WIX7z2H/pBdf0yo0mFAwx6bGrmTTv0x4/1zigFAEhwQ7UeHbcHM7DhOwMl3PT
         EImmI5alJ2xAle3EvMB7UdH8bhwxg/4LRgKGUDWAC+sClRELhzw0pfmQL36kkhPt4LUE
         086w==
X-Gm-Message-State: AOJu0YzsOQG5chw+pxkrtZR/Ot7KR3pNwXvGvUQabmwwegmBk4KuHGhL
        jjtDSAKwPx+5WWD9HfokYsHYQA+Ws/pm9M+IaPE=
X-Google-Smtp-Source: AGHT+IFrOMPHG7xgs3UutIiOWA5ySAAvt5OvQ/g2C6jbzBQ3o7zNsCbFHK7l/S8B8fPaZRuoHnzTLDEQcdcErEp0qEI=
X-Received: by 2002:ac2:58ca:0:b0:507:a96c:e76 with SMTP id
 u10-20020ac258ca000000b00507a96c0e76mr1901093lfo.21.1697739396328; Thu, 19
 Oct 2023 11:16:36 -0700 (PDT)
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
 <CAFULd4b91Tr9Q2p4a20eusC+QO6O81gxY+nP-zpFiFKGTmLpYg@mail.gmail.com> <CAHk-=wi3LZ_4OGAMhvgO0JSTp-eEPOGp+siq1nJNLY1JAxdP5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi3LZ_4OGAMhvgO0JSTp-eEPOGp+siq1nJNLY1JAxdP5Q@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 19 Oct 2023 20:16:24 +0200
Message-ID: <CAFULd4YxvMtTEfQL-RiLisTxDwoJZZxXXB+3CWqCpzZkUf85JA@mail.gmail.com>
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

On Thu, Oct 19, 2023 at 8:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 19 Oct 2023 at 10:21, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > A compiler that were to rematerializes an inline asm (instead of
> > > spilling) would be a bad joke. That's not an optimization, that's jus=
t
> > > a crazy bad compiler with a code generation bug.
> >
> > But that is what the compiler does without volatile.
>
> Do you actually have a real case of that, or are basing it purely off
> insane documentation?
>
> Because remat of inline asm really _is_ insane.

The following testcase pushes the compiler to the limit:

--cut here--
extern void ex (int);

static int read (void)
{
  int ret;

  asm ("# -> %0" : "=3Dr"(ret));
  return ret;
}

int foo (void)
{
  int ret =3D read ();

  ex (ret);
  asm volatile ("clobber" : : : "ax", "cx", "dx", "bx", "bp", "si", "di");

  return ret;
}

extern int m;

int bar (void)
{
  int ret =3D m;

  ex (ret);
  asm volatile ("clobber" : : : "ax", "cx", "dx", "bx", "bp", "si", "di");

  return ret;
}
--cut here--

Please compile the above with -S -O2 -m32 (so we don't have to list
all 16 x86_64 registers).

And NO (whee...), there is no rematerialization of asm (foo() ). OTOH,
there is also no rematerialization from non-volatile memory (bar() ),
although it would be more optimal than spill to/fill from a frame pair
of moves. I wonder what are "certain circumstances" that the
documentation is referring to.

Uros.


Uros.
