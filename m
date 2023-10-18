Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924FC7CDCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjJRNPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjJRNP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:15:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC7394
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:15:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso5322010a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697634924; x=1698239724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i6qXUWupsnmAOKBRrGWDX4ua1G1ZUx1AreCL3neAh1g=;
        b=cJB4r0TsVa4RJfbuhDcQnhRBeXjyq54nYTheaqTzm500tiC6EC5TmhGd0mPo/290iL
         TQpR/KabrBiSGYebD3+o2TQR7fexdRpzSZcnsfgucZztu0KvNkOuMXugLjl79of6/JWh
         UWZWEp/rMLZDuJ6FackC10K2qH9eEfIN56eipWFmlJfvG23vucC9qb/N+sPmlgxHWq9g
         +wFo31ujc6hZ+Cku0o9VYENGWgxMDaA+r1yH0RZJCwxyGB3py6nYk37tsKiMIxI2Jctj
         t4MfENdMNGr5QReJS6Na9cHJSnarBlnvBperbTx7QdiVRI2Xfq/9uHOf1Coe/bA6nGFt
         0VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634924; x=1698239724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6qXUWupsnmAOKBRrGWDX4ua1G1ZUx1AreCL3neAh1g=;
        b=cVQE5hVNKVeMkXY0lz6Ldo7zL7wFOSzByNYellTGFMYV9I998TQL6Y8rdF3ppH3hxD
         xmGpWcXrkkPxNKwghhIodyTKiwuYHMBW5DpUevIXACz2ELZ8Jc8t0jE6ZVSa+DKtsEAy
         Di5zmt1YZMNizrtEPpUTw4xP9DeB4mUapDeNUBEh89aqN8OdDod00rybwHnQqGT5kANd
         jVkiD+/tlL9+auldvfRfHvrsPZnQYBYn3SbK+xhUxC35kZamv7Xy5duWeyevfhwU4hSY
         kzrqVj5BxPO3ywDRCS77GiPWOFJumqE2SwobLi01lBnRIxpK7+Bxt2YgSIrsj/TRu3vk
         oVdQ==
X-Gm-Message-State: AOJu0YxxavqGeyO6PHI4KpiOtN2lCegrxnPAnxvf/PtmU41PgxkXxDsw
        8uF4n3qbQgRqbwRzPKsgWfo8+Bicr+qlB8xk7gg=
X-Google-Smtp-Source: AGHT+IHszRkhrEgrvruAfqI5aBdEPLfp2YCjX6JO0wegVjzj8b/BTDoCIis9zHv3apNeeGxlsilkGaFIQpA31UhoH/Y=
X-Received: by 2002:aa7:cd4d:0:b0:53e:1e7f:4835 with SMTP id
 v13-20020aa7cd4d000000b0053e1e7f4835mr3803494edw.32.1697634923796; Wed, 18
 Oct 2023 06:15:23 -0700 (PDT)
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
In-Reply-To: <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 15:15:11 +0200
Message-ID: <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="00000000000097e5270607fd6e2d"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000097e5270607fd6e2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 2:14=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Oct 18, 2023 at 12:54=E2=80=AFPM Nadav Amit <namit@vmware.com> wr=
ote:
> >
> >
> >
> > > On Oct 18, 2023, at 12:04 PM, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > Solved.
> > >
> > > All that is needed is to patch cpu_init() from
> > > arch/x86/kernel/cpu/common.c with:
> > >
> > > --cut here--
> > > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/commo=
n.c
> > > index b14fc8c1c953..61b6fcdf6937 100644
> > > --- a/arch/x86/kernel/cpu/common.c
> > > +++ b/arch/x86/kernel/cpu/common.c
> > > @@ -2228,7 +2232,7 @@ void cpu_init_exception_handling(void)
> > > */
> > > void cpu_init(void)
> > > {
> > > -       struct task_struct *cur =3D current;
> > > +       struct task_struct *cur =3D this_cpu_read_stable(pcpu_hot.cur=
rent_task);
> > >       int cpu =3D raw_smp_processor_id();
> >
> > Thanks for solving that, and sorry that I missed it.
> >
> > The reason I didn=E2=80=99t encounter it before is that in my original =
patch I created
> > a new compilation unit which only defined the alias.
> >
> > Since there might be additional problems (any =E2=80=9Ccurrent=E2=80=9D=
 use in common.c is
> > dangerous, even in included files), I think that while there may be add=
itional
> > solutions, defining the alias in a separate compilation unit - as I did=
 before -
> > is the safest.
>
> What happens here can be illustrated with the following testcase:
>
> --cut here--
> int init_mm;
>
> struct task_struct
> {
>   int *active_mm;
> };
>
> struct task_struct init_task;
>
> struct pcpu_hot
> {
>   struct task_struct *current_task;
> };
>
> struct pcpu_hot pcpu_hot =3D { .current_task =3D &init_task };
>
> extern const struct pcpu_hot __seg_gs const_pcpu_hot
> __attribute__((alias("pcpu_hot")));
>
> void foo (void)
> {
>   struct task_struct *cur =3D const_pcpu_hot.current_task;
>
>   cur->active_mm =3D &init_mm;
> }
> --cut here--
>
> gcc -O2 -S:
>
> foo:
>        movq    $init_mm, init_task(%rip)
>        ret
>
> Here, gcc optimizes the access to generic address space, which is
> allowed to, since *we set the alias to pcpu_hot*, which is in the
> generic address space. The compiler doesn't care that we actually
> want:
>
> foo:
>        movq    %gs:const_pcpu_hot(%rip), %rax
>        movq    $init_mm, (%rax)
>
> So yes, to prevent the optimization, we have to hide the alias in another=
 TU.
>
> BTW: Clang creates:
>
> foo:
>        movq    %gs:pcpu_hot(%rip), %rax
>        movq    $init_mm, (%rax)
>        retq
>
> It is a bit more conservative and retains the address space of the
> aliasing symbol.
>
> Looks like another case of underspecified functionality where both
> compilers differ. Luckily, both DTRT when aliases are hidden in
> another TU.

Attached is the prototype patch that works for me (together with
Linus' FPU switching patch).

Uros.

--00000000000097e5270607fd6e2d
Content-Type: text/plain; charset="US-ASCII"; name="current.diff.txt"
Content-Disposition: attachment; filename="current.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnvrz6c80>
X-Attachment-Id: f_lnvrz6c80

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2N1cnJlbnQuaAppbmRleCBhMTE2OGU3YjY5ZTUuLjIxZThiZDRlYTQ0ZSAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3VycmVudC5oCisrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2N1cnJlbnQuaApAQCAtMzYsMTAgKzM2LDIzIEBAIHN0YXRpY19hc3NlcnQoc2l6
ZW9mKHN0cnVjdCBwY3B1X2hvdCkgPT0gNjQpOwogCiBERUNMQVJFX1BFUl9DUFVfQUxJR05FRChz
dHJ1Y3QgcGNwdV9ob3QsIHBjcHVfaG90KTsKIAorLyoKKyAqCisgKi8KK0RFQ0xBUkVfUEVSX0NQ
VV9BTElHTkVEKGNvbnN0IHN0cnVjdCBwY3B1X2hvdCBfX3BlcmNwdV9zZWdfb3ZlcnJpZGUsCisJ
CQljb25zdF9wY3B1X2hvdCk7CisKKyNpZmRlZiBDT05GSUdfVVNFX1g4Nl9TRUdfU1VQUE9SVAor
c3RhdGljIF9fYWx3YXlzX2lubGluZSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmdldF9jdXJyZW50KHZv
aWQpCit7CisJcmV0dXJuIGNvbnN0X3BjcHVfaG90LmN1cnJlbnRfdGFzazsKK30KKyNlbHNlCiBz
dGF0aWMgX19hbHdheXNfaW5saW5lIHN0cnVjdCB0YXNrX3N0cnVjdCAqZ2V0X2N1cnJlbnQodm9p
ZCkKIHsKIAlyZXR1cm4gdGhpc19jcHVfcmVhZF9zdGFibGUocGNwdV9ob3QuY3VycmVudF90YXNr
KTsKIH0KKyNlbmRpZgogCiAjZGVmaW5lIGN1cnJlbnQgZ2V0X2N1cnJlbnQoKQogCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L01ha2VmaWxlIGIvYXJjaC94ODYva2VybmVsL2NwdS9N
YWtlZmlsZQppbmRleCA5M2VhYmY1NDQwMzEuLmExZDE3NTc4ZjVjMSAxMDA2NDQKLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9NYWtlZmlsZQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L01ha2Vm
aWxlCkBAIC0xOSw2ICsxOSw3IEBAIEtDU0FOX1NBTklUSVpFX2NvbW1vbi5vIDo9IG4KIAogb2Jq
LXkJCQk6PSBjYWNoZWluZm8ubyBzY2F0dGVyZWQubyB0b3BvbG9neS5vCiBvYmoteQkJCSs9IGNv
bW1vbi5vCitvYmoteQkJCSs9IHBlcmNwdS1ob3Qubwogb2JqLXkJCQkrPSByZHJhbmQubwogb2Jq
LXkJCQkrPSBtYXRjaC5vCiBvYmoteQkJCSs9IGJ1Z3MubwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL2NwdS9jb21tb24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMKaW5kZXgg
YjE0ZmM4YzFjOTUzLi5mYjllMTA2NDY3YmEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9j
cHUvY29tbW9uLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYwpAQCAtMjA0Mywx
MyArMjA0Myw2IEBAIHN0YXRpYyBfX2luaXQgaW50IHNldHVwX2NsZWFyY3B1aWQoY2hhciAqYXJn
KQogfQogX19zZXR1cCgiY2xlYXJjcHVpZD0iLCBzZXR1cF9jbGVhcmNwdWlkKTsKIAotREVGSU5F
X1BFUl9DUFVfQUxJR05FRChzdHJ1Y3QgcGNwdV9ob3QsIHBjcHVfaG90KSA9IHsKLQkuY3VycmVu
dF90YXNrCT0gJmluaXRfdGFzaywKLQkucHJlZW1wdF9jb3VudAk9IElOSVRfUFJFRU1QVF9DT1VO
VCwKLQkudG9wX29mX3N0YWNrCT0gVE9QX09GX0lOSVRfU1RBQ0ssCi19OwotRVhQT1JUX1BFUl9D
UFVfU1lNQk9MKHBjcHVfaG90KTsKLQogI2lmZGVmIENPTkZJR19YODZfNjQKIERFRklORV9QRVJf
Q1BVX0ZJUlNUKHN0cnVjdCBmaXhlZF9wZXJjcHVfZGF0YSwKIAkJICAgICBmaXhlZF9wZXJjcHVf
ZGF0YSkgX19hbGlnbmVkKFBBR0VfU0laRSkgX192aXNpYmxlOwpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL2NwdS9wZXJjcHUtaG90LmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3BlcmNwdS1o
b3QuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmVjYTU1OGEzODQ1
YQotLS0gL2Rldi9udWxsCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcGVyY3B1LWhvdC5jCkBA
IC0wLDAgKzEsMTUgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKworCisj
aW5jbHVkZSA8bGludXgvc2NoZWQvdGFzay5oPgorI2luY2x1ZGUgPGFzbS9jdXJyZW50Lmg+CisK
K0RFRklORV9QRVJfQ1BVX0FMSUdORUQoc3RydWN0IHBjcHVfaG90LCBwY3B1X2hvdCkgPSB7CisJ
LmN1cnJlbnRfdGFzawk9ICZpbml0X3Rhc2ssCisJLnByZWVtcHRfY291bnQJPSBJTklUX1BSRUVN
UFRfQ09VTlQsCisJLnRvcF9vZl9zdGFjawk9IFRPUF9PRl9JTklUX1NUQUNLLAorfTsKK0VYUE9S
VF9QRVJfQ1BVX1NZTUJPTChwY3B1X2hvdCk7CisKK0RFQ0xBUkVfUEVSX0NQVV9BTElHTkVEKGNv
bnN0IHN0cnVjdCBwY3B1X2hvdCBfX3BlcmNwdV9zZWdfb3ZlcnJpZGUsCisJCQljb25zdF9wY3B1
X2hvdCkgX19hdHRyaWJ1dGVfXygoYWxpYXMoInBjcHVfaG90IikpKTsKK0VYUE9SVF9QRVJfQ1BV
X1NZTUJPTChjb25zdF9wY3B1X2hvdCk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBp
bGVyLmggYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgKaW5kZXggZDc3NzlhMThiMjRmLi5iZjk4
MTVlYWY0YWEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaAorKysgYi9pbmNs
dWRlL2xpbnV4L2NvbXBpbGVyLmgKQEAgLTIxMiw3ICsyMTIsNyBAQCB2b2lkIGZ0cmFjZV9saWtl
bHlfdXBkYXRlKHN0cnVjdCBmdHJhY2VfbGlrZWx5X2RhdGEgKmYsIGludCB2YWwsCiAgKi8KICNk
ZWZpbmUgX19fQUREUkVTU0FCTEUoc3ltLCBfX2F0dHJzKSBcCiAJc3RhdGljIHZvaWQgKiBfX3Vz
ZWQgX19hdHRycyBcCi0JCV9fVU5JUVVFX0lEKF9fUEFTVEUoX19hZGRyZXNzYWJsZV8sc3ltKSkg
PSAodm9pZCAqKSZzeW07CisJX19VTklRVUVfSUQoX19QQVNURShfX2FkZHJlc3NhYmxlXyxzeW0p
KSA9ICh2b2lkICopKHVpbnRwdHJfdCkmc3ltOwogI2RlZmluZSBfX0FERFJFU1NBQkxFKHN5bSkg
XAogCV9fX0FERFJFU1NBQkxFKHN5bSwgX19zZWN0aW9uKCIuZGlzY2FyZC5hZGRyZXNzYWJsZSIp
KQogCg==
--00000000000097e5270607fd6e2d--
