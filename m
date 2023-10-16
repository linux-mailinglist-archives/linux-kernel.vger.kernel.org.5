Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B927CB6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjJPXCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjJPXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:02:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D783
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:02:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso430855266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697497359; x=1698102159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIXn6t7PHANRTcgs4g0e2rVgnFrT4twoJ2oYr1hfY00=;
        b=WDS95oKeG0PeTwEc3E34/qZ56J0nRIYFTTiV1jJYJf/rqhpodWaGfbk5zU9lPn2fhS
         H57ZwMzYtOtgXf5USpQQySk0BOYm6YWv/Awd0MjNVuo2Pa1tjR/fWaROxjQC3IoNAu8M
         +sD4O0Gl2Pz4am0mHmWfQmEBHO7Vk/I7kcpGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697497359; x=1698102159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIXn6t7PHANRTcgs4g0e2rVgnFrT4twoJ2oYr1hfY00=;
        b=c2ukbNA7u3Paekz2tgNtlHtwn6tXWibZjqoKHiDkz43gMdnMMq8vp9yftoxpm34GBV
         dQqNbuZ8DUfQT53LZopasnyRvp8/kkUkQneMABnFVNIGEGpt0Ip1Nul51rhnJDg4T2eE
         6zcw5l+QKugxHWehnrokUzY/d8OLJ16dWJP1qbuh+E41GXQ0/bx99xriPYu71HjeRR/9
         43pIHsdP7gTEVjpL4xsE09X69sz58XmJl8HsWkrwTNPFdhXy1zWbu0AdcnGXRvtbECUz
         pMKaQTZTPbEoZrN+XaQF/acXuoH9w/3PWOM8QSFEHMAa7qjivaU66QtduY93eQOM1RpV
         UN5g==
X-Gm-Message-State: AOJu0Yyg/hbOwQQsIITNQzNP2fLV01eIHrnzRaaSxdoPYMChoAFmUNjW
        BDYyCUGIlTeu3o37dr14WMjiB1+7x+vZ7rX9mpgdcFmo
X-Google-Smtp-Source: AGHT+IEwIU74A1DYtKjUHWa5XHjESkLpoyisFAb4V5ZQTt8OOSg9E+Xk+zB+bVONSXlrLyTZBzCAgg==
X-Received: by 2002:a17:907:9306:b0:9c4:e660:a38c with SMTP id bu6-20020a170907930600b009c4e660a38cmr557686ejc.17.1697497358825;
        Mon, 16 Oct 2023 16:02:38 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id mm23-20020a170906cc5700b0099bcdfff7cbsm104848ejb.160.2023.10.16.16.02.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 16:02:38 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso430852666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:02:37 -0700 (PDT)
X-Received: by 2002:a17:907:7f1b:b0:9b2:fa55:5794 with SMTP id
 qf27-20020a1709077f1b00b009b2fa555794mr404476ejc.58.1697497357536; Mon, 16
 Oct 2023 16:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com> <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com>
In-Reply-To: <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Oct 2023 16:02:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
Message-ID: <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
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
Content-Type: multipart/mixed; boundary="000000000000012ddb0607dd67f5"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000012ddb0607dd67f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Oct 2023 at 13:35, Nadav Amit <namit@vmware.com> wrote:
>
> I have encountered several such issues before [1], and while some have be=
en fixed,
> some have not (I looked at switch_fpu_finish()), and might under the righ=
t/wrong
> circumstances use the wrongly-=E2=80=9Ccached=E2=80=9D current. Moreover,=
 perhaps new problems
> have been added since my old patch.

Yeah, that fpu switching is disgusting and borderline buggy. And yes,
it would trigger problems when caching the value of 'current'.

I don't particularly love the patch you pointed at, because it seems
to have only fixed the switch_fpu_finish() case, which is the one that
presumably triggered issues, but that's not a very pretty fix.

switch_fpu_prepare() has the exact same problem, and in fact is likely
the *source* of the issue, because that's the original "load current"
that then ends up being cached incorrectly later in __switch_to().

The whole

        struct fpu *prev_fpu =3D &prev->fpu;

thing in __switch_to() is pretty ugly. There's no reason why we should
look at that 'prev_fpu' pointer there, or pass it down.

And it only generates worse code, in how it loads 'current' when
t__switch_to() has the right task pointers.

So the attached patch is, I think, the right thing to do. It may not
be the *complete* fix, but at least for the config I tested, this
makes all loads of 'current' go away in the resulting generated
assembly, and the only access to '%gs:pcpu_hot(%rip)' is the write to
update it:

        movq %rbx, %gs:pcpu_hot(%rip)

from that

        raw_cpu_write(pcpu_hot.current_task, next_p);

code.

Thomas, I think you've touched this code last, but even that isn't
very recent. The attached patch not only cleans this up, it actually
generates better code too:

 (a) it removes one push/pop pair at entry/exit because there's one
less register used (no 'current')

 (b) it removes that pointless load of 'current' because it just uses
the right argument:

-       #APP
-       movq    %gs:pcpu_hot(%rip), %r12
-       #NO_APP
-       testq   $16384, (%r12)
+       testq   $16384, (%rdi)

so I think this is the right thing to do. I checked that the 32-bit
code builds and looks sane too.

I do think the 'old/new' naming in the FPU code should probably be
'prev/next' to match the switch_to() naming, but I didn't do that.

Comments?

                Linus

                  Linus

--000000000000012ddb0607dd67f5
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lnti30uj0>
X-Attachment-Id: f_lnti30uj0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS9zY2hlZC5oIHwgMTAgKysrKysrLS0tLQogYXJjaC94
ODYva2VybmVsL3Byb2Nlc3NfMzIuYyAgICAgfCAgNyArKystLS0tCiBhcmNoL3g4Ni9rZXJuZWwv
cHJvY2Vzc182NC5jICAgICB8ICA3ICsrKy0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vZnB1L3NjaGVkLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUvc2NoZWQuaAppbmRleCBj
YTZlNWU1ZjE2YjIuLmM0ODVmMTk0NGM1ZiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vZnB1L3NjaGVkLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZnB1L3NjaGVkLmgKQEAg
LTM3LDEwICszNywxMiBAQCBleHRlcm4gdm9pZCBmcHVfZmx1c2hfdGhyZWFkKHZvaWQpOwogICog
VGhlIEZQVSBjb250ZXh0IGlzIG9ubHkgc3RvcmVkL3Jlc3RvcmVkIGZvciBhIHVzZXIgdGFzayBh
bmQKICAqIFBGX0tUSFJFQUQgaXMgdXNlZCB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIGtlcm5lbCBh
bmQgdXNlciB0aHJlYWRzLgogICovCi1zdGF0aWMgaW5saW5lIHZvaWQgc3dpdGNoX2ZwdV9wcmVw
YXJlKHN0cnVjdCBmcHUgKm9sZF9mcHUsIGludCBjcHUpCitzdGF0aWMgaW5saW5lIHZvaWQgc3dp
dGNoX2ZwdV9wcmVwYXJlKHN0cnVjdCB0YXNrX3N0cnVjdCAqb2xkLCBpbnQgY3B1KQogewogCWlm
IChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0ZQVSkgJiYKLQkgICAgIShjdXJyZW50
LT5mbGFncyAmIChQRl9LVEhSRUFEIHwgUEZfVVNFUl9XT1JLRVIpKSkgeworCSAgICAhKG9sZC0+
ZmxhZ3MgJiAoUEZfS1RIUkVBRCB8IFBGX1VTRVJfV09SS0VSKSkpIHsKKwkJc3RydWN0IGZwdSAq
b2xkX2ZwdSA9ICZvbGQtPnRocmVhZC5mcHU7CisKIAkJc2F2ZV9mcHJlZ3NfdG9fZnBzdGF0ZShv
bGRfZnB1KTsKIAkJLyoKIAkJICogVGhlIHNhdmUgb3BlcmF0aW9uIHByZXNlcnZlZCByZWdpc3Rl
ciBzdGF0ZSwgc28gdGhlCkBAIC02MCwxMCArNjIsMTAgQEAgc3RhdGljIGlubGluZSB2b2lkIHN3
aXRjaF9mcHVfcHJlcGFyZShzdHJ1Y3QgZnB1ICpvbGRfZnB1LCBpbnQgY3B1KQogICogRGVsYXkg
bG9hZGluZyBvZiB0aGUgY29tcGxldGUgRlBVIHN0YXRlIHVudGlsIHRoZSByZXR1cm4gdG8gdXNl
cmxhbmQuCiAgKiBQS1JVIGlzIGhhbmRsZWQgc2VwYXJhdGVseS4KICAqLwotc3RhdGljIGlubGlu
ZSB2b2lkIHN3aXRjaF9mcHVfZmluaXNoKHZvaWQpCitzdGF0aWMgaW5saW5lIHZvaWQgc3dpdGNo
X2ZwdV9maW5pc2goc3RydWN0IHRhc2tfc3RydWN0ICpuZXcpCiB7CiAJaWYgKGNwdV9mZWF0dXJl
X2VuYWJsZWQoWDg2X0ZFQVRVUkVfRlBVKSkKLQkJc2V0X3RocmVhZF9mbGFnKFRJRl9ORUVEX0ZQ
VV9MT0FEKTsKKwkJc2V0X3Rza190aHJlYWRfZmxhZyhuZXcsIFRJRl9ORUVEX0ZQVV9MT0FEKTsK
IH0KIAogI2VuZGlmIC8qIF9BU01fWDg2X0ZQVV9TQ0hFRF9IICovCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvcHJvY2Vzc18zMi5jIGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfMzIuYwpp
bmRleCA3MDhjODdiODhjYzEuLjA5MTdjN2YyNTcyMCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2Vy
bmVsL3Byb2Nlc3NfMzIuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc18zMi5jCkBAIC0x
NTYsMTMgKzE1NiwxMiBAQCBfX3N3aXRjaF90byhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnByZXZfcCwg
c3RydWN0IHRhc2tfc3RydWN0ICpuZXh0X3ApCiB7CiAJc3RydWN0IHRocmVhZF9zdHJ1Y3QgKnBy
ZXYgPSAmcHJldl9wLT50aHJlYWQsCiAJCQkgICAgICpuZXh0ID0gJm5leHRfcC0+dGhyZWFkOwot
CXN0cnVjdCBmcHUgKnByZXZfZnB1ID0gJnByZXYtPmZwdTsKIAlpbnQgY3B1ID0gc21wX3Byb2Nl
c3Nvcl9pZCgpOwogCiAJLyogbmV2ZXIgcHV0IGEgcHJpbnRrIGluIF9fc3dpdGNoX3RvLi4uIHBy
aW50aygpIGNhbGxzIHdha2VfdXAqKCkgaW5kaXJlY3RseSAqLwogCi0JaWYgKCF0ZXN0X3RocmVh
ZF9mbGFnKFRJRl9ORUVEX0ZQVV9MT0FEKSkKLQkJc3dpdGNoX2ZwdV9wcmVwYXJlKHByZXZfZnB1
LCBjcHUpOworCWlmICghdGVzdF90c2tfdGhyZWFkX2ZsYWcocHJldl9wLCBUSUZfTkVFRF9GUFVf
TE9BRCkpCisJCXN3aXRjaF9mcHVfcHJlcGFyZShwcmV2X3AsIGNwdSk7CiAKIAkvKgogCSAqIFNh
dmUgYXdheSAlZ3MuIE5vIG5lZWQgdG8gc2F2ZSAlZnMsIGFzIGl0IHdhcyBzYXZlZCBvbiB0aGUK
QEAgLTIwOSw3ICsyMDgsNyBAQCBfX3N3aXRjaF90byhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnByZXZf
cCwgc3RydWN0IHRhc2tfc3RydWN0ICpuZXh0X3ApCiAKIAlyYXdfY3B1X3dyaXRlKHBjcHVfaG90
LmN1cnJlbnRfdGFzaywgbmV4dF9wKTsKIAotCXN3aXRjaF9mcHVfZmluaXNoKCk7CisJc3dpdGNo
X2ZwdV9maW5pc2gobmV4dF9wKTsKIAogCS8qIExvYWQgdGhlIEludGVsIGNhY2hlIGFsbG9jYXRp
b24gUFFSIE1TUi4gKi8KIAlyZXNjdHJsX3NjaGVkX2luKG5leHRfcCk7CmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jIGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQu
YwppbmRleCAzM2IyNjg3NDdiYjcuLjE1NTNlMTk5MDRlMCAxMDA2NDQKLS0tIGEvYXJjaC94ODYv
a2VybmVsL3Byb2Nlc3NfNjQuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jCkBA
IC01NjIsMTQgKzU2MiwxMyBAQCBfX3N3aXRjaF90byhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnByZXZf
cCwgc3RydWN0IHRhc2tfc3RydWN0ICpuZXh0X3ApCiB7CiAJc3RydWN0IHRocmVhZF9zdHJ1Y3Qg
KnByZXYgPSAmcHJldl9wLT50aHJlYWQ7CiAJc3RydWN0IHRocmVhZF9zdHJ1Y3QgKm5leHQgPSAm
bmV4dF9wLT50aHJlYWQ7Ci0Jc3RydWN0IGZwdSAqcHJldl9mcHUgPSAmcHJldi0+ZnB1OwogCWlu
dCBjcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7CiAKIAlXQVJOX09OX09OQ0UoSVNfRU5BQkxFRChD
T05GSUdfREVCVUdfRU5UUlkpICYmCiAJCSAgICAgdGhpc19jcHVfcmVhZChwY3B1X2hvdC5oYXJk
aXJxX3N0YWNrX2ludXNlKSk7CiAKLQlpZiAoIXRlc3RfdGhyZWFkX2ZsYWcoVElGX05FRURfRlBV
X0xPQUQpKQotCQlzd2l0Y2hfZnB1X3ByZXBhcmUocHJldl9mcHUsIGNwdSk7CisJaWYgKCF0ZXN0
X3Rza190aHJlYWRfZmxhZyhwcmV2X3AsIFRJRl9ORUVEX0ZQVV9MT0FEKSkKKwkJc3dpdGNoX2Zw
dV9wcmVwYXJlKHByZXZfcCwgY3B1KTsKIAogCS8qIFdlIG11c3Qgc2F2ZSAlZnMgYW5kICVncyBi
ZWZvcmUgbG9hZF9UTFMoKSBiZWNhdXNlCiAJICogJWZzIGFuZCAlZ3MgbWF5IGJlIGNsZWFyZWQg
YnkgbG9hZF9UTFMoKS4KQEAgLTYyMyw3ICs2MjIsNyBAQCBfX3N3aXRjaF90byhzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnByZXZfcCwgc3RydWN0IHRhc2tfc3RydWN0ICpuZXh0X3ApCiAJcmF3X2NwdV93
cml0ZShwY3B1X2hvdC5jdXJyZW50X3Rhc2ssIG5leHRfcCk7CiAJcmF3X2NwdV93cml0ZShwY3B1
X2hvdC50b3Bfb2Zfc3RhY2ssIHRhc2tfdG9wX29mX3N0YWNrKG5leHRfcCkpOwogCi0Jc3dpdGNo
X2ZwdV9maW5pc2goKTsKKwlzd2l0Y2hfZnB1X2ZpbmlzaChuZXh0X3ApOwogCiAJLyogUmVsb2Fk
IHNwMC4gKi8KIAl1cGRhdGVfdGFza19zdGFjayhuZXh0X3ApOwo=
--000000000000012ddb0607dd67f5--
