Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09367CE0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbjJRPSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjJRPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:18:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE85898
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:18:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso11027930a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697642284; x=1698247084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwmlKg+iurujaoHM78khlFeWHnt3Ry3Unvc1lAlS3ck=;
        b=FjtIrokIBwiaJ8LXmwKSw+KVgJj2YP2FU/pcMYQ3vWDmS8lslzPDNqCxsE2hPbKmil
         /aKAJsgFFLv7Tm73p15ZBZ+eVIh1UwiiRPyAiJpZ182X/gR4oQO6e2XrhNaMEmirL40d
         n6OpmqVHazRvgiRTZyliYez0qMzIzwKUvED4iu1Wq2ZH+PicGazeRj9SEr9TF43xX66K
         rcQvmPo6+kYBDXzQaTpKrydnNlCV4S6knrWvjFFJ8Gwyejgfu4+Qf/EchGib9AYSrZ8l
         4zgHUbfzVADl21NlJ4Mrp2mM9vMTnkEj75WvW4vQd/N45GTPpaSgcPnK5Kycnr0wh0Y/
         TUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697642284; x=1698247084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwmlKg+iurujaoHM78khlFeWHnt3Ry3Unvc1lAlS3ck=;
        b=H4nmYMrepmI9xCV9E0dMUFg6x2nH6+X/Si+Q2wGLsmbW4qEJCs2ZZ8xJ1acE29FBs7
         EpNKHy+RiecEIgK05G8QRj9s1AFgc0cM9O1gwQHm6mckasYRv5MGAYAZ3N93Qo8gCX+C
         ZvpJcl0z51EOQo7O3RVByiQbRHG+YZL2yeQ1tjLlL/+dz1YnuwqU5mrLpzd9yIAxGawW
         b9LxSTwWTbwhS/EfRSC+ySSaQgSgyVXF1+LCrCuQj+0w1sbWSZg2WJC0NOxBypXoZfgD
         HbIS1w+SHVHs6heKljaYTaV+CLQ5d3rcHKPZtBnG8nuishJ+EMfSeApHIJ+Srh680sjb
         UDRw==
X-Gm-Message-State: AOJu0Yy740fjnO++PJDNXrq5kDDjvqCH0WByNNMnaNNJpfF2XSkaNXIJ
        jXW2/wZ0bthlrpX9jyaNxyftF4A7XUDzYH0FGYM=
X-Google-Smtp-Source: AGHT+IEyBgneSxvWCbQbHt+OVSRJvQ8b9wVxZ4e27gd/WOZ2beL6KY5XsL+5FDYTkeK/Tz5jCtIk6bkDK4BUhC5bNzk=
X-Received: by 2002:a50:8719:0:b0:53e:3732:9aae with SMTP id
 i25-20020a508719000000b0053e37329aaemr4118128edb.4.1697642283873; Wed, 18 Oct
 2023 08:18:03 -0700 (PDT)
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
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com> <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com>
In-Reply-To: <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 17:17:51 +0200
Message-ID: <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Content-Type: multipart/mixed; boundary="00000000000049b5ec0607ff25d6"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000049b5ec0607ff25d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 4:46=E2=80=AFPM Nadav Amit <namit@vmware.com> wrote=
:

> >> Looks like another case of underspecified functionality where both
> >> compilers differ. Luckily, both DTRT when aliases are hidden in
> >> another TU.
> >
> > Attached is the prototype patch that works for me (together with
> > Linus' FPU switching patch).
>
> In general looks good. See some minor issues below.
>
> > --- a/arch/x86/include/asm/current.h
> > +++ b/arch/x86/include/asm/current.h
> > @@ -36,10 +36,23 @@ static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> >
> >  DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
> >
> > +/*
> > + *
> > + */
>
> Obviously some further comments to clarify why struct pcpu_hot is
> defined in percpu-hot.c (the GCC manual says:  "It is an error if
> the alias target is not defined in the same translation unit as the
> alias=E2=80=9D which can be used as part of the explanation.)

Sure.

>
> > +DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
> > +                     const_pcpu_hot);
> > +
> > +#ifdef CONFIG_USE_X86_SEG_SUPPORT
> > +static __always_inline struct task_struct *get_current(void)
> > +{
> > +     return const_pcpu_hot.current_task;
> > +}
> > +#else
> >  static __always_inline struct task_struct *get_current(void)
> >  {
> >       return this_cpu_read_stable(pcpu_hot.current_task);
> >  }
> > +#endif
>
>
> Please consider using IS_ENABLED() to avoid the ifdef=E2=80=99ry.
>
> So this would turn to be:
>
> static __always_inline struct task_struct *get_current(void)
> {
>         if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
>                 return const_pcpu_hot.current_task;
>
>         return this_cpu_read_stable(pcpu_hot.current_task);
> }

I am more thinking of moving the ifdeffery to percpu.h, something like
the attached part of the patch. This would handle all current and
future stable percpu variables.

Thanks,
Uros.

--00000000000049b5ec0607ff25d6
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnvwcubh0>
X-Attachment-Id: f_lnvwcubh0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyY3B1LmgKaW5kZXggNTQ3NDY5MDNiOGMzLi42MDdmNmI4ZTE2Y2EgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmNwdS5oCkBAIC00MTcsNyArNDE3LDYgQEAgZG8gewkJCQkJCQkJCVwKICNkZWZp
bmUgdGhpc19jcHVfcmVhZF9zdGFibGVfMihwY3ApCXBlcmNwdV9zdGFibGVfb3AoMiwgIm1vdiIs
IHBjcCkKICNkZWZpbmUgdGhpc19jcHVfcmVhZF9zdGFibGVfNChwY3ApCXBlcmNwdV9zdGFibGVf
b3AoNCwgIm1vdiIsIHBjcCkKICNkZWZpbmUgdGhpc19jcHVfcmVhZF9zdGFibGVfOChwY3ApCXBl
cmNwdV9zdGFibGVfb3AoOCwgIm1vdiIsIHBjcCkKLSNkZWZpbmUgdGhpc19jcHVfcmVhZF9zdGFi
bGUocGNwKQlfX3BjcHVfc2l6ZV9jYWxsX3JldHVybih0aGlzX2NwdV9yZWFkX3N0YWJsZV8sIHBj
cCkKIAogI2lmZGVmIENPTkZJR19VU0VfWDg2X1NFR19TVVBQT1JUCiAKQEAgLTQ1Myw2ICs0NTIs
OCBAQCBkbyB7CQkJCQkJCQkJXAogI2RlZmluZSB0aGlzX2NwdV93cml0ZV84KHBjcCwgdmFsKQlf
X3Jhd19jcHVfd3JpdGUodm9sYXRpbGUsIHBjcCwgdmFsKQogI2VuZGlmCiAKKyNkZWZpbmUgdGhp
c19jcHVfcmVhZF9zdGFibGUocGNwKQljb25zdF8jI3BjcAorCiAjZWxzZSAvKiBDT05GSUdfVVNF
X1g4Nl9TRUdfU1VQUE9SVCAqLwogCiAjZGVmaW5lIHJhd19jcHVfcmVhZF8xKHBjcCkJCXBlcmNw
dV9mcm9tX29wKDEsICwgIm1vdiIsIHBjcCkKQEAgLTQ3Nyw2ICs0NzgsOSBAQCBkbyB7CQkJCQkJ
CQkJXAogI2RlZmluZSB0aGlzX2NwdV93cml0ZV84KHBjcCwgdmFsKQlwZXJjcHVfdG9fb3AoOCwg
dm9sYXRpbGUsICJtb3YiLCAocGNwKSwgdmFsKQogI2VuZGlmCiAKKyNkZWZpbmUgdGhpc19jcHVf
cmVhZF9zdGFibGUocGNwKQkJCQkJXAorICBfX3BjcHVfc2l6ZV9jYWxsX3JldHVybih0aGlzX2Nw
dV9yZWFkX3N0YWJsZV8sIHBjcCkKKwogI2VuZGlmIC8qIENPTkZJR19VU0VfWDg2X1NFR19TVVBQ
T1JUICovCiAKICNkZWZpbmUgcmF3X2NwdV9hZGRfMShwY3AsIHZhbCkJCXBlcmNwdV9hZGRfb3Ao
MSwgLCAocGNwKSwgdmFsKQo=
--00000000000049b5ec0607ff25d6--
