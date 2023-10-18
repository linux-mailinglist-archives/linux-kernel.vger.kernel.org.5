Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF857CE7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJRTdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:33:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC9109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:33:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so91597a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697657610; x=1698262410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1tU0gAsvo99sH0ntf3CjZbasv525nBRbJ+XTXDklbo=;
        b=jNmOSKUxio7Q6kK8qjZW0HdTJn0b78TQIDgshy2n482jkfNruU1HplrWR8kymuzY6m
         dACY/qgLSLIBlGAjNJs3azlKipYJlYZq76e4lbfRysvfVK23e3T1kexWo4PzqXsZ2iLO
         rLIWhb3G5DxcFcpTFzsYMRtK3O2SxvaIojC/J+1zAObNvpes7g+l0PF/87wQSyFkJD6l
         3tMj7LpiXUyAJAPrtjzv7I6X6QJB2r5pMOFwkAI39s+JyOrC62VxSqarIUd/lYEp9i75
         eRyEm2zJ3s2sIKCLZJm/yyFSXPYR3tchSCAV29iY4zInI+0KxGD4Z11F4MZQOghwCxgU
         UbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657610; x=1698262410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1tU0gAsvo99sH0ntf3CjZbasv525nBRbJ+XTXDklbo=;
        b=mOfPdjQgfhchtDtJSiPCqFFtalmB7ID14US7NP2hKDuzIrRsKwRpE1hbL0UTMmtcnr
         sK5dq6BVCNAqanJrNof/bRtYjOWUe/b8hCuecjhXTKGBC28PgtYLSXzxv3srmgN8IRZa
         cidQIBM/rcMkt/o6SlZtX2SL8ilkhuSDn6qwjlcX+2AgfgsdJqAV+3zEqrDPgv8qSTb1
         9FlZ60zJw4vcloLAH+pAwql7n8/4qNzfAWhi1lwkCfCV5OfNaD4xvS9uDp+tGcGetJfv
         GBr++NWgrPbSOSCIi7D0i7Vl8wcQOru1VEhaPcegSig9f4Lyc2C13tqoYhNbY8iIl/9D
         tLrQ==
X-Gm-Message-State: AOJu0Ywf66JKBpKTQNnM/rE+lIdwXmEf23lrHXfxoVReSvVkWXg9usYn
        LjriX73SVBqnZyxR1s+X6WeUi+VSJER3cj+i4s4=
X-Google-Smtp-Source: AGHT+IEzDqTzIZ0kupOd7q8LeO5l5AyVoXEMBAMSErgMITON+MJpAZvES8ludPwFskqbnBDzTA/4ToZkFhA3zNruQC4=
X-Received: by 2002:a05:6402:524a:b0:53e:264d:be1f with SMTP id
 t10-20020a056402524a00b0053e264dbe1fmr436781edd.2.1697657609825; Wed, 18 Oct
 2023 12:33:29 -0700 (PDT)
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
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com> <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
In-Reply-To: <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 21:33:18 +0200
Message-ID: <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
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

On Wed, Oct 18, 2023 at 8:26=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Oct 18, 2023 at 8:16=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 18 Oct 2023 at 11:08, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > But loads from non-const memory work like the above.
> >
> > Yes, I'm certainly ok with the move to use plain loads from __seg_gs
> > for the percpu accesses. If they didn't honor the memory clobber, we
> > could never use it at all.
> >
> > I was just saying that the 'const' alias trick isn't useful for
> > anything else than 'current', because everything else needs to at
> > least honor our existing barriers.
>
> FYI, smp_processor_id() is implemented as:
>
> #define __smp_processor_id() __this_cpu_read(pcpu_hot.cpu_number)
>
> where __this_* forces volatile access which disables CSE.
>
> *If* the variable is really stable, then it should use __raw_cpu_read.
> Both, __raw_* and __this_* were recently (tip/percpu branch)
> implemented for SEG_SUPPORT as:

This pach works for me:

--cut here--
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..6eda4748bf64 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -141,8 +141,7 @@ __visible void
smp_call_function_single_interrupt(struct pt_regs *r);
 * This function is needed by all SMP systems. It must _always_ be valid
 * from the initial startup.
 */
-#define raw_smp_processor_id()  this_cpu_read(pcpu_hot.cpu_number)
-#define __smp_processor_id() __this_cpu_read(pcpu_hot.cpu_number)
+#define raw_smp_processor_id()  raw_cpu_read(pcpu_hot.cpu_number)

#ifdef CONFIG_X86_32
extern int safe_smp_processor_id(void);
--cut here--

But removes merely 10 reads from 3219.

BTW: I also don't understand the comment from include/linux/smp.h:

/*
 * Allow the architecture to differentiate between a stable and unstable re=
ad.
 * For example, x86 uses an IRQ-safe asm-volatile read for the unstable but=
 a
 * regular asm read for the stable.
 */
#ifndef __smp_processor_id
#define __smp_processor_id(x) raw_smp_processor_id(x)
#endif

All reads up to word size on x86 are atomic, so IRQ safe. asm-volatile
is not some IRQ property, but prevents the compiler from CSE the asm
and scheduling (moving) asm around too much.

Uros.
