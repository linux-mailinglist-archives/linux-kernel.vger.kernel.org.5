Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367F87CE456
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjJRRKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjJRRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:10:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96945326C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:08:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c603e2354fso444919866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648877; x=1698253677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TC+0I+zWgSfzwJAuAf0X+3Iv9+B3fQ87MnP7gIaazJY=;
        b=fmE0ESG5y5+k6eKwnzkewUrzBNQydIp4U6uTwzheXcvLlsPWmBMJYnNdhVgcQ10+ZT
         xlA4uPulIcbhael+36CEkinkE58RLXYTy8GmWro36FmhaDFkIrnGvOVbwaKyE7RWagxh
         SgYDV5T7z4HGaWABtaFA01/B8+e7mi//2VdmwhwN9y1jhFei4X0nLA5oSjYcweHxfLka
         1dFQZ2GumSg95dNtwWxSN9cANTk5knmGkbpdhFJLfT/ddJlbs5QLgiY3bo0QuHPUiQPd
         7teyrtjQUiEu0/nrfv9ung9PbDxlq/EI3Tv+UVdGdd3VbY2alxR/9MSOYOqJ5twOzGzI
         L3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648877; x=1698253677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TC+0I+zWgSfzwJAuAf0X+3Iv9+B3fQ87MnP7gIaazJY=;
        b=mR4C481cPVGSJtlaGlo/vQaWQRq+xL2L9AcM/4AgznCpEA+Lo9ZvGGODiSuCWWuEAJ
         XMA2UV8yCB/oi5RQLi2n+t/TJU57H0YVffPW2S3pSJBAIeLgdAUr4R5A55GyUho7PdNQ
         gFiIRupOcq8opsWWjqxMn6tzjmKNYm6c8C1vnYNxYMEI0M71hxmT87wmm+OeP4f6Egvk
         Gdp2YnQSB+t7wnFqZGvTXda0FujGVU80TlGFc6uLJODNnAA/pp2JasE4iTKeSVU+oByq
         EvExFsEarmAP0gaP4oKCI8HipeAKnkr3pEqK5+6TgLt0K3oekUQ6N+ccr6/RupQDIIn6
         Laug==
X-Gm-Message-State: AOJu0YwIwMFIlEcfc+xTeg7r8uxonAtL2qsGULux90Hhll+lBal7gmhy
        3woyW6HU7TTv5SMO4IJeuvwgmVbnqpz0b7p7R3g=
X-Google-Smtp-Source: AGHT+IE4gNtILPWjj0L7jJvxjQGXfORy1CyAViBhZQsBIluQkbUYUMp6++l3hv7V4ae6FXW0KpoHBqiXi/aiQJAD9cI=
X-Received: by 2002:a17:907:1ca4:b0:9a4:11a3:c32b with SMTP id
 nb36-20020a1709071ca400b009a411a3c32bmr4522888ejc.29.1697648877405; Wed, 18
 Oct 2023 10:07:57 -0700 (PDT)
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
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com> <CAHk-=wiB6LHPmnG7=RWNuQYY9=jCY0EmaJ7thRBEFOfDO09dfw@mail.gmail.com>
In-Reply-To: <CAHk-=wiB6LHPmnG7=RWNuQYY9=jCY0EmaJ7thRBEFOfDO09dfw@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 19:07:45 +0200
Message-ID: <CAFULd4YHq7tKQBNk9bNYZkBo9C5XM+6=O7QZG3E-qKBVjSHb6g@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0000000000004aa548060800ae12"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004aa548060800ae12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 6:13=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 06:15, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Attached is the prototype patch that works for me (together with
> > Linus' FPU switching patch).
>
> That looks reasonable, but I think the separate compilation unit is
> unnecessary, and I still absolutely hate how that const_pcpu_hot thing
> is declared twice (your patch does it in both current.h and in
> percpu-hot.c).
>
> How about we just do the whole alias as a linker thing instead? So the
> same way that we just do
>
>     jiffies =3D jiffies_64;
>
> in our arch/x86/kernel/vmlinux.lds.S file, we could just do
>
>     const_pcpu_hot =3D pcpu_hot;
>
> in there.
>
> Then, as far as the compiler is concerned, we just have
>
>     DECLARE_PER_CPU_ALIGNED(
>         const struct pcpu_hot __percpu_seg_override,
>         const_pcpu_hot)
>
> and the compiler doesn't know that it's aliased to anything else.

Oh...

... this works, too! Please see the attached patch.

(Note to self: Leave linking stuff to linker) ;)

> And please do that declaration in just *one* place.

Sure. Now the patch looks quite slim, but works as expected, reducing
the number of current_task accesses from 3841 to 3220.

Thanks,
Uros.

--0000000000004aa548060800ae12
Content-Type: text/plain; charset="US-ASCII"; name="current-2.diff.txt"
Content-Disposition: attachment; filename="current-2.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnw0aage0>
X-Attachment-Id: f_lnw0aage0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2N1cnJlbnQuaAppbmRleCBhMTE2OGU3YjY5ZTUuLjM2OTAyZDYxZmQ1NSAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3VycmVudC5oCisrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2N1cnJlbnQuaApAQCAtMzYsOCArMzYsMTcgQEAgc3RhdGljX2Fzc2VydChzaXpl
b2Yoc3RydWN0IHBjcHVfaG90KSA9PSA2NCk7CiAKIERFQ0xBUkVfUEVSX0NQVV9BTElHTkVEKHN0
cnVjdCBwY3B1X2hvdCwgcGNwdV9ob3QpOwogCisvKgorICoKKyAqLworREVDTEFSRV9QRVJfQ1BV
X0FMSUdORUQoY29uc3Qgc3RydWN0IHBjcHVfaG90IF9fcGVyY3B1X3NlZ19vdmVycmlkZSwKKwkJ
CWNvbnN0X3BjcHVfaG90KTsKKwogc3RhdGljIF9fYWx3YXlzX2lubGluZSBzdHJ1Y3QgdGFza19z
dHJ1Y3QgKmdldF9jdXJyZW50KHZvaWQpCiB7CisJaWYgKElTX0VOQUJMRUQoQ09ORklHX1VTRV9Y
ODZfU0VHX1NVUFBPUlQpKQorCQlyZXR1cm4gY29uc3RfcGNwdV9ob3QuY3VycmVudF90YXNrOwor
CiAJcmV0dXJuIHRoaXNfY3B1X3JlYWRfc3RhYmxlKHBjcHVfaG90LmN1cnJlbnRfdGFzayk7CiB9
CiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TIGIvYXJjaC94ODYv
a2VybmVsL3ZtbGludXgubGRzLlMKaW5kZXggOWNkYjFhNzMzMmM0Li43Y2JjNDI2MTllMTYgMTAw
NjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TCisrKyBiL2FyY2gveDg2L2tl
cm5lbC92bWxpbnV4Lmxkcy5TCkBAIC00Niw2ICs0Niw3IEBAIEVOVFJZKHBoeXNfc3RhcnR1cF82
NCkKICNlbmRpZgogCiBqaWZmaWVzID0gamlmZmllc182NDsKK2NvbnN0X3BjcHVfaG90ID0gcGNw
dV9ob3Q7CiAKICNpZiBkZWZpbmVkKENPTkZJR19YODZfNjQpCiAvKgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9jb21waWxlci5oIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5oCmluZGV4IGQ3
Nzc5YTE4YjI0Zi4uYmY5ODE1ZWFmNGFhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2NvbXBp
bGVyLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5oCkBAIC0yMTIsNyArMjEyLDcgQEAg
dm9pZCBmdHJhY2VfbGlrZWx5X3VwZGF0ZShzdHJ1Y3QgZnRyYWNlX2xpa2VseV9kYXRhICpmLCBp
bnQgdmFsLAogICovCiAjZGVmaW5lIF9fX0FERFJFU1NBQkxFKHN5bSwgX19hdHRycykgXAogCXN0
YXRpYyB2b2lkICogX191c2VkIF9fYXR0cnMgXAotCQlfX1VOSVFVRV9JRChfX1BBU1RFKF9fYWRk
cmVzc2FibGVfLHN5bSkpID0gKHZvaWQgKikmc3ltOworCV9fVU5JUVVFX0lEKF9fUEFTVEUoX19h
ZGRyZXNzYWJsZV8sc3ltKSkgPSAodm9pZCAqKSh1aW50cHRyX3QpJnN5bTsKICNkZWZpbmUgX19B
RERSRVNTQUJMRShzeW0pIFwKIAlfX19BRERSRVNTQUJMRShzeW0sIF9fc2VjdGlvbigiLmRpc2Nh
cmQuYWRkcmVzc2FibGUiKSkKIAo=
--0000000000004aa548060800ae12--
