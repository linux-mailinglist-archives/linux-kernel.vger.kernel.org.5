Return-Path: <linux-kernel+bounces-163072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F28B6496
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6212E1F21BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1A1836FE;
	Mon, 29 Apr 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8sSBLeL"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5431836DE;
	Mon, 29 Apr 2024 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426226; cv=none; b=lt3gKh1WEnkDL1m4IgopVdiY6oJwGWt7UwpS1Hsx8NFs3AcRdk7QAEvAJ+H+GL4dEZ04B23M5VLpZdzQUhbzBgIr4hEwRtPaTFngJIpBMiFRalL8Wc7Lnj7nH4klqDast+d/p8gi8CGeJv1OZDiI8F+gv5SQ3mLiEOHEPYWdEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426226; c=relaxed/simple;
	bh=kpvICPZMlsZfPJroQtt4wrumVDC1dFOAcBXHJhfrORg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcmsWIJ8NqzaZqxC2TTuI+8NlDYItDrnUpl5AD45RnkRhf9kq3O/+mRUB5JDhjwZMqrqyjLBQ7gqeiwg63l1Hjt+tjkFcHZcZ4Y/4qGzSS8T6nQgqCETK9xzAR8yNooLupJYEDjSOLsPIGHlwcm6tFuic4AwILnQdP67A1r/M3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8sSBLeL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e060d49f87so11553201fa.0;
        Mon, 29 Apr 2024 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426222; x=1715031022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OIprfau9HNmVx8+h0zObXjXi6FS5vux/SKaDT2brkWE=;
        b=D8sSBLeLB6QgC9VLfrx2FJktuj2Tfp0v7AZzgR2NmTlXR+p50bQKZduODlIjgEpdDe
         s1MG/urzwT9qpjw+zZmZgLYE0SkSRiC6Tuc+4Ak6sGNcuH8E4G6mLheVNo79FTLZrYpd
         /V2eaqaZDc8SK50hJP98SrUuSdd7Oukws+6+MLogRJ0/vYUB9X+3mT1scz5j9PoM2xf5
         RpW/Bw3hcOsM+PrLUSoWZlLk7+bvddA99LfHWw5xJAZ+0P2mVh3+uqaY+/alV3rcqMH8
         fhZd9yG4mm5epE+Mjm+qSIonp4FGiBcJEJGD3vdnvNe5wsg+L1W2Rb7aXYKcuOP+1KIc
         iBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426222; x=1715031022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIprfau9HNmVx8+h0zObXjXi6FS5vux/SKaDT2brkWE=;
        b=A+cpRxBSCwA9+YBKrZePQHPQf7GWZ0avHYhEGHO/CEUAayCIguWfhoSwMPzejyXW1M
         O/GDsKRO4QMYnrKuR7JppmhaXPhLY00Rn4SitqFld9IgItzIol6V6FLwrTgYSDFVIal9
         d1TfR7nunIj/xNjcC6NbUDIPdP9t0VvuYy5b6JwQ0r1cyfq4QOJHSLKrhs+e+V8G8pwY
         Pw0AERLk+hjmdNkU0N0WlMZQLsfaUt7lIZUZ+8Et8VrvIkRfCtVCLwgXcYvg9gago5GF
         hrzMb+YK5uNhGw/uN4d+PzRsUyQhuvFYj9uRtwzENsCBsf8P322WUgWUceFV9q8fxQ+E
         5KiA==
X-Forwarded-Encrypted: i=1; AJvYcCVXVepzQL45nUyMPg3ZvW1Nh5SSucSwuXEV6C7LdC+dL0J0BSIQhndHPEvj+SH/SgGthrKbaG3g4h4GVlwwzybA5GIOCpRTHtoOjGGwVYUf8bTThouW0CGwaJR5L+E0rvfyqMwyz2L/4UCX
X-Gm-Message-State: AOJu0YzMx3jHMNwsGG5y5xDRmP/uDHopPr6nqxp8OKunBfSaSMdJN1g0
	HOioXa3WGJcP3LyGb7SPgmmkcyVPzOef2333GfsZokXtZYHuYT3zVw/iOnXnmmMkYQzx3GN9tY2
	00UhrOwC9dVc2EYLc/D0RTlVg+z0=
X-Google-Smtp-Source: AGHT+IGUjTrac3O9enRphCIrmfCciEBg6iGpG+lO8D6luCCSLtsdNIPzi1Qdj7I+7ZQiQPc/8jJM6aICVlp3GzakuzI=
X-Received: by 2002:a05:651c:198c:b0:2df:1c6a:214b with SMTP id
 bx12-20020a05651c198c00b002df1c6a214bmr322490ljb.13.1714426221796; Mon, 29
 Apr 2024 14:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx> <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx> <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx> <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
 <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com> <87bk7ux4e9.ffs@tglx>
In-Reply-To: <87bk7ux4e9.ffs@tglx>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 29 Apr 2024 23:30:09 +0200
Message-ID: <CAFULd4Z-stHtu2UWv02S+Nbx51QqytGUO8ZeW50Fc_PbsfF8BA@mail.gmail.com>
Subject: [RFC PATCH] Use x86 named address spaces to catch "sparse: incorrect
 type in initializer (different address spaces)" __percpu errors
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Arjan van de Ven <arjan@linux.intel.com>, X86 ML <x86@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Content-Type: multipart/mixed; boundary="000000000000f1b815061742f5a7"

--000000000000f1b815061742f5a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:49=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:

> >> > That's so sad because it would provide us compiler based __percpu
> >> > validation.
> >>
> >> Unfortunately, the c compiler can't strip qualifiers, so typeof() is
> >> of limited use also when const and volatile qualifiers are used.
> >> Perhaps some extension could be introduced to c standard to provide an
> >> unqualified type, e.g. typeof_unqual().
> >
> > Oh, there is one in C23 [1].
>
> Yes. I found it right after ranting.
>
> gcc >=3D 14 and clang >=3D 16 have support for it of course only when add=
ing
> -std=3Dc2x to the command line.
>
> Sigh. The name space qualifiers are non standard and then the thing
> which makes them more useful is hidden behind a standard.
>
> Why can't we have useful tools?
>
> Though the whole thing looks worthwhile:
>
> #define verify_per_cpu_ptr(ptr)                                         \
> do {                                                                    \
>         const void __seg_gs *__vpp_verify =3D (typeof((ptr) + 0))NULL;   =
 \
>         (void)__vpp_verify;                                             \
> } while (0)
>
> #define per_cpu_ptr(ptr, cpu)                                           \
> ({                                                                      \
>         verify_per_cpu_ptr(ptr);                                        \
>         (typeof_unqual(*(ptr)) *)(uintptr_t)ptr + per_cpu_offset(cpu);  \
> })
>
> unsigned int __seg_gs test;
>
> unsigned int foo1(unsigned int cpu)
> {
>         return *per_cpu_ptr(&test, cpu);
> }
>
> unsigned int foo2(unsigned int cpu)
> {
>         unsigned int x, *p =3D per_cpu_ptr(&x, cpu);
>
>         return *p;
> }
>
> x.c:29:23: error: initializing 'const __attribute__((address_space(256)))=
 void *' with an expression of type 'typeof ((&x) + 0)' (aka 'unsigned int =
*') changes address space of pointer
>         unsigned int x, *p =3D per_cpu_ptr(&x, cpu);
>
> That's exactly what we want. It would have caught all the long standing
> and ignored __percpu sparse warnings right away.
>
> This also simplifies all the other per cpu accessors. The most trivial
> is read()
>
> #define verify_per_cpu(variable)                                        \
> {                                                                       \
>         const unsigned int __s =3D sizeof(variable);                     =
 \
>                                                                         \
>         verify_per_cpu_ptr(&(variable));                                \
>         BUILD_BUG_ON(__s =3D=3D 1 || __s =3D=3D 2 || __s =3D=3D 4 || __s =
=3D=3D 8,      \
>                      "Wrong size for per CPU variable");                \
> }
>
> #define __pcpu_read(variable)                                           \
> ({                                                                      \
>         verify_per_cpu(variable);                                       \
>         READ_ONCE(variable);                                            \
> })
>
> which in turn catches all the mistakes, i.e. wrong namespace and wrong
> size.
>
> I'm really tempted to implement this as an alternative to the current
> pile of macro horrors. Of course this requires to figure out first what
> kind of damage -std=3Dc2x will do.
>
> I get to that in my copious spare time some day.

Please find attached the prototype patch that does the above.

The idea of the patch is to add named address qualifier to the __percpu tag=
:

-# define __percpu    BTF_TYPE_TAG(percpu)
+# define __percpu    __percpu_seg_override BTF_TYPE_TAG(percpu)

So instead of being merely a benign hint to the checker, __percpu
becomes the real x86 named address space qualifier to enable the
compiler checks for access to different address spaces. Following the
above change, we can remove various casts that cast "fake" percpu
addresses at the usage site and use the kernel type system to handle
named AS qualified addresses instead:

-#define __my_cpu_type(var)    typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)    (__my_cpu_type(*(ptr))*)(__force uintptr_t)(p=
tr)
-#define __my_cpu_var(var)    (*__my_cpu_ptr(&(var)))
-#define __percpu_arg(x)        __percpu_prefix "%" #x
+#define __my_cpu_type(var)    typeof(var)
+#define __my_cpu_ptr(ptr)    (ptr)
+#define __my_cpu_var(var)    (var)
+#define __percpu_arg(x)        "%" #x

As can be seen from the patch, various temporary non-percpu variables
need to be declared with __typeof_unqual__ to use unqualified base
type without named AS qualifier. In addition to the named AS
qualifier, __typeof_unqual__ also strips const and volatile
qualifiers, so it can enable some further optimizations involving
this_cpu_read_stable, not a topic of this patch.

The patch is against the recent -tip tree and needs to be compiled
with gcc-14. It is tested by compiling and booting the defconfig
kernel, but other than that, as a prototype patch, it does not even
try to be a generic patch that would handle compilers without
__typeof_unqual__ support. The patch unearths and fixes some address
space inconsistencies to avoid __verify_pcpu_ptr and x86 named address
space compile failures with a defconfig compilation, demonstrating the
effectiveness of the proposed approach.

Uros.

--000000000000f1b815061742f5a7
Content-Type: text/plain; charset="US-ASCII"; name="pcpu-unqual.diff.txt"
Content-Disposition: attachment; filename="pcpu-unqual.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lvlh32xn0>
X-Attachment-Id: f_lvlh32xn0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyY3B1LmgKaW5kZXggM2JlZGVlMTgwMWUyLi5kMjUwNWE0N2RjMjcgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmNwdS5oCkBAIC04OSwxMCArODksMTAgQEAKIAogI2VuZGlmIC8qIENPTkZJR19T
TVAgKi8KIAotI2RlZmluZSBfX215X2NwdV90eXBlKHZhcikJdHlwZW9mKHZhcikgX19wZXJjcHVf
c2VnX292ZXJyaWRlCi0jZGVmaW5lIF9fbXlfY3B1X3B0cihwdHIpCShfX215X2NwdV90eXBlKCoo
cHRyKSkqKShfX2ZvcmNlIHVpbnRwdHJfdCkocHRyKQotI2RlZmluZSBfX215X2NwdV92YXIodmFy
KQkoKl9fbXlfY3B1X3B0cigmKHZhcikpKQotI2RlZmluZSBfX3BlcmNwdV9hcmcoeCkJCV9fcGVy
Y3B1X3ByZWZpeCAiJSIgI3gKKyNkZWZpbmUgX19teV9jcHVfdHlwZSh2YXIpCXR5cGVvZih2YXIp
CisjZGVmaW5lIF9fbXlfY3B1X3B0cihwdHIpCShwdHIpCisjZGVmaW5lIF9fbXlfY3B1X3Zhcih2
YXIpCSh2YXIpCisjZGVmaW5lIF9fcGVyY3B1X2FyZyh4KQkJIiUiICN4CiAjZGVmaW5lIF9fZm9y
Y2VfcGVyY3B1X2FyZyh4KQlfX2ZvcmNlX3BlcmNwdV9wcmVmaXggIiUiICN4CiAKIC8qCkBAIC0x
NDgsNyArMTQ4LDcgQEAKIGRvIHsJCQkJCQkJCQlcCiAJX19wY3B1X3R5cGVfIyNzaXplIHB0b192
YWxfXyA9IF9fcGNwdV9jYXN0XyMjc2l6ZShfdmFsKTsJXAogCWlmICgwKSB7CQkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAotCQl0eXBlb2YoX3ZhcikgcHRvX3RtcF9f
OwkJCQkJXAorCQlfX3R5cGVvZl91bnF1YWxfXyhfdmFyKSBwdG9fdG1wX187CQkJXAogCQlwdG9f
dG1wX18gPSAoX3ZhbCk7CQkJCQlcCiAJCSh2b2lkKXB0b190bXBfXzsJCQkJCVwKIAl9CQkJCQkJ
CQlcCkBAIC0xNzMsNyArMTczLDcgQEAgZG8gewkJCQkJCQkJCVwKIAkJCSAgICAgICgodmFsKSA9
PSAxIHx8ICh2YWwpID09IC0xKSkgPwkJXAogCQkJCShpbnQpKHZhbCkgOiAwOwkJCQlcCiAJaWYg
KDApIHsJCQkJCQkJXAotCQl0eXBlb2YodmFyKSBwYW9fdG1wX187CQkJCQlcCisJCV9fdHlwZW9m
X3VucXVhbF9fKHZhcikgcGFvX3RtcF9fOwkJCVwKIAkJcGFvX3RtcF9fID0gKHZhbCk7CQkJCQlc
CiAJCSh2b2lkKXBhb190bXBfXzsJCQkJCVwKIAl9CQkJCQkJCQlcCkBAIC0yMjMsNyArMjIzLDcg
QEAgZG8gewkJCQkJCQkJCVwKICAqLwogI2RlZmluZSByYXdfcGVyY3B1X3hjaGdfb3AoX3Zhciwg
X252YWwpCQkJCQlcCiAoewkJCQkJCQkJCVwKLQl0eXBlb2YoX3ZhcikgcHhvX29sZF9fID0gcmF3
X2NwdV9yZWFkKF92YXIpOwkJCVwKKwlfX3R5cGVvZl91bnF1YWxfXyhfdmFyKSBweG9fb2xkX18g
PSByYXdfY3B1X3JlYWQoX3Zhcik7CQlcCiAJcmF3X2NwdV93cml0ZShfdmFyLCBfbnZhbCk7CQkJ
CQlcCiAJcHhvX29sZF9fOwkJCQkJCQlcCiB9KQpAQCAtMjM1LDcgKzIzNSw3IEBAIGRvIHsJCQkJ
CQkJCQlcCiAgKi8KICNkZWZpbmUgdGhpc19wZXJjcHVfeGNoZ19vcChfdmFyLCBfbnZhbCkJCQkJ
XAogKHsJCQkJCQkJCQlcCi0JdHlwZW9mKF92YXIpIHB4b19vbGRfXyA9IHRoaXNfY3B1X3JlYWQo
X3Zhcik7CQkJXAorCV9fdHlwZW9mX3VucXVhbF9fKF92YXIpIHB4b19vbGRfXyA9IHRoaXNfY3B1
X3JlYWQoX3Zhcik7CVwKIAlkbyB7IH0gd2hpbGUgKCF0aGlzX2NwdV90cnlfY21weGNoZyhfdmFy
LCAmcHhvX29sZF9fLCBfbnZhbCkpOwlcCiAJcHhvX29sZF9fOwkJCQkJCQlcCiB9KQpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL2hlYWQ2NC5jIGIvYXJjaC94ODYva2VybmVsL2hlYWQ2NC5j
CmluZGV4IGE4MTdlZDA3MjRkMS4uZjVkNmFkMzUxY2M0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvaGVhZDY0LmMKKysrIGIvYXJjaC94ODYva2VybmVsL2hlYWQ2NC5jCkBAIC01NjAsOSAr
NTYwLDEwIEBAIHZvaWQgZWFybHlfc2V0dXBfaWR0KHZvaWQpCiB2b2lkIF9faGVhZCBzdGFydHVw
XzY0X3NldHVwX2dkdF9pZHQodm9pZCkKIHsKIAl2b2lkICpoYW5kbGVyID0gTlVMTDsKKwlzdHJ1
Y3QgZGVzY19zdHJ1Y3QgKmdkdCA9IChzdHJ1Y3QgZGVzY19zdHJ1Y3QgKikodWludHB0cl90KWlu
aXRfcGVyX2NwdV92YXIoZ2R0X3BhZ2UuZ2R0KTsKIAogCXN0cnVjdCBkZXNjX3B0ciBzdGFydHVw
X2dkdF9kZXNjciA9IHsKLQkJLmFkZHJlc3MgPSAodW5zaWduZWQgbG9uZykmUklQX1JFTF9SRUYo
aW5pdF9wZXJfY3B1X3ZhcihnZHRfcGFnZS5nZHQpKSwKKwkJLmFkZHJlc3MgPSAodW5zaWduZWQg
bG9uZykmUklQX1JFTF9SRUYoKmdkdCksCiAJCS5zaXplICAgID0gR0RUX1NJWkUgLSAxLAogCX07
CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9kZXZyZXMuYyBiL2RyaXZlcnMvYmFzZS9kZXZy
ZXMuYwppbmRleCAzZGYwMDI1ZDEyYWEuLmFlNTI3MjFiYzc5ZSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9iYXNlL2RldnJlcy5jCisrKyBiL2RyaXZlcnMvYmFzZS9kZXZyZXMuYwpAQCAtMTIyMyw2ICsx
MjIzLDYgQEAgRVhQT1JUX1NZTUJPTF9HUEwoX19kZXZtX2FsbG9jX3BlcmNwdSk7CiB2b2lkIGRl
dm1fZnJlZV9wZXJjcHUoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkIF9fcGVyY3B1ICpwZGF0YSkK
IHsKIAlXQVJOX09OKGRldnJlc19kZXN0cm95KGRldiwgZGV2bV9wZXJjcHVfcmVsZWFzZSwgZGV2
bV9wZXJjcHVfbWF0Y2gsCi0JCQkgICAgICAgKF9fZm9yY2Ugdm9pZCAqKXBkYXRhKSk7CisJCQkg
ICAgICAgKF9fZm9yY2Ugdm9pZCAqKSh1aW50cHRyX3QpcGRhdGEpKTsKIH0KIEVYUE9SVF9TWU1C
T0xfR1BMKGRldm1fZnJlZV9wZXJjcHUpOwpkaWZmIC0tZ2l0IGEvZnMvYWlvLmMgYi9mcy9haW8u
YwppbmRleCAwZjRmNTMxYzk3ODAuLmJhYmEyNzQ1MDY5NiAxMDA2NDQKLS0tIGEvZnMvYWlvLmMK
KysrIGIvZnMvYWlvLmMKQEAgLTEwMCw3ICsxMDAsNyBAQCBzdHJ1Y3Qga2lvY3R4IHsKIAogCXVu
c2lnbmVkIGxvbmcJCXVzZXJfaWQ7CiAKLQlzdHJ1Y3QgX19wZXJjcHUga2lvY3R4X2NwdSAqY3B1
OworCXN0cnVjdCBraW9jdHhfY3B1IF9fcGVyY3B1ICpjcHU7CiAKIAkvKgogCSAqIEZvciBwZXJj
cHUgcmVxc19hdmFpbGFibGUsIG51bWJlciBvZiBzbG90cyB3ZSBtb3ZlIHRvL2Zyb20gZ2xvYmFs
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmggYi9pbmNsdWRlL2xp
bnV4L2NvbXBpbGVyX3R5cGVzLmgKaW5kZXggMmFiYWEzYTgyNWE5Li43YzU3NGQ2ODY0ODYgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaAorKysgYi9pbmNsdWRlL2xp
bnV4L2NvbXBpbGVyX3R5cGVzLmgKQEAgLTU3LDcgKzU3LDcgQEAgc3RhdGljIGlubGluZSB2b2lk
IF9fY2hrX2lvX3B0cihjb25zdCB2b2xhdGlsZSB2b2lkIF9faW9tZW0gKnB0cikgeyB9CiAjICBk
ZWZpbmUgX191c2VyCUJURl9UWVBFX1RBRyh1c2VyKQogIyBlbmRpZgogIyBkZWZpbmUgX19pb21l
bQotIyBkZWZpbmUgX19wZXJjcHUJQlRGX1RZUEVfVEFHKHBlcmNwdSkKKyMgZGVmaW5lIF9fcGVy
Y3B1CV9fcGVyY3B1X3NlZ19vdmVycmlkZSBCVEZfVFlQRV9UQUcocGVyY3B1KQogIyBkZWZpbmUg
X19yY3UJCUJURl9UWVBFX1RBRyhyY3UpCiAKICMgZGVmaW5lIF9fY2hrX3VzZXJfcHRyKHgpCSh2
b2lkKTAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGFydF9zdGF0LmggYi9pbmNsdWRlL2xp
bnV4L3BhcnRfc3RhdC5oCmluZGV4IGFiZWJhMzU2YmMzZi4uMGUwMmU5ZDYwMTE0IDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L3BhcnRfc3RhdC5oCisrKyBiL2luY2x1ZGUvbGludXgvcGFydF9z
dGF0LmgKQEAgLTMzLDcgKzMzLDcgQEAgc3RydWN0IGRpc2tfc3RhdHMgewogCiAjZGVmaW5lIHBh
cnRfc3RhdF9yZWFkKHBhcnQsIGZpZWxkKQkJCQkJXAogKHsJCQkJCQkJCQlcCi0JdHlwZW9mKChw
YXJ0KS0+YmRfc3RhdHMtPmZpZWxkKSByZXMgPSAwOwkJCVwKKwlfX3R5cGVvZl91bnF1YWxfXygo
cGFydCktPmJkX3N0YXRzLT5maWVsZCkgcmVzID0gMDsJCVwKIAl1bnNpZ25lZCBpbnQgX2NwdTsJ
CQkJCQlcCiAJZm9yX2VhY2hfcG9zc2libGVfY3B1KF9jcHUpCQkJCQlcCiAJCXJlcyArPSBwZXJf
Y3B1X3B0cigocGFydCktPmJkX3N0YXRzLCBfY3B1KS0+ZmllbGQ7IFwKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvcGVyY3B1LWRlZnMuaCBiL2luY2x1ZGUvbGludXgvcGVyY3B1LWRlZnMuaApp
bmRleCBlYzM1NzMxMTk5MjMuLjRjYjY2Nzg4N2M4MSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9wZXJjcHUtZGVmcy5oCisrKyBiL2luY2x1ZGUvbGludXgvcGVyY3B1LWRlZnMuaApAQCAtMjMz
LDEzICsyMzMsMTMgQEAgZG8gewkJCQkJCQkJCVwKICNkZWZpbmUgcGVyX2NwdV9wdHIocHRyLCBj
cHUpCQkJCQkJXAogKHsJCQkJCQkJCQlcCiAJX192ZXJpZnlfcGNwdV9wdHIocHRyKTsJCQkJCQlc
Ci0JU0hJRlRfUEVSQ1BVX1BUUigocHRyKSwgcGVyX2NwdV9vZmZzZXQoKGNwdSkpKTsJCQlcCisJ
KF9fdHlwZW9mX3VucXVhbF9fKCoocHRyKSkgKikodWludHB0cl90KVNISUZUX1BFUkNQVV9QVFIo
KHB0ciksIHBlcl9jcHVfb2Zmc2V0KChjcHUpKSk7IFwKIH0pCiAKICNkZWZpbmUgcmF3X2NwdV9w
dHIocHRyKQkJCQkJCVwKICh7CQkJCQkJCQkJXAogCV9fdmVyaWZ5X3BjcHVfcHRyKHB0cik7CQkJ
CQkJXAotCWFyY2hfcmF3X2NwdV9wdHIocHRyKTsJCQkJCQlcCisJKF9fdHlwZW9mX3VucXVhbF9f
KCoocHRyKSkgKikodWludHB0cl90KWFyY2hfcmF3X2NwdV9wdHIocHRyKTsJXAogfSkKIAogI2lm
ZGVmIENPTkZJR19ERUJVR19QUkVFTVBUCkBAIC0zMTUsNyArMzE1LDcgQEAgc3RhdGljIF9fYWx3
YXlzX2lubGluZSB2b2lkIF9fdGhpc19jcHVfcHJlZW1wdF9jaGVjayhjb25zdCBjaGFyICpvcCkg
eyB9CiAKICNkZWZpbmUgX19wY3B1X3NpemVfY2FsbF9yZXR1cm4oc3RlbSwgdmFyaWFibGUpCQkJ
CVwKICh7CQkJCQkJCQkJXAotCXR5cGVvZih2YXJpYWJsZSkgcHNjcl9yZXRfXzsJCQkJCVwKKwlf
X3R5cGVvZl91bnF1YWxfXyh2YXJpYWJsZSkgcHNjcl9yZXRfXzsJCQkJXAogCV9fdmVyaWZ5X3Bj
cHVfcHRyKCYodmFyaWFibGUpKTsJCQkJCVwKIAlzd2l0Y2goc2l6ZW9mKHZhcmlhYmxlKSkgewkJ
CQkJXAogCWNhc2UgMTogcHNjcl9yZXRfXyA9IHN0ZW0jIzEodmFyaWFibGUpOyBicmVhazsJCQlc
CkBAIC0zMzAsNyArMzMwLDcgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIF9fdGhpc19j
cHVfcHJlZW1wdF9jaGVjayhjb25zdCBjaGFyICpvcCkgeyB9CiAKICNkZWZpbmUgX19wY3B1X3Np
emVfY2FsbF9yZXR1cm4yKHN0ZW0sIHZhcmlhYmxlLCAuLi4pCQkJXAogKHsJCQkJCQkJCQlcCi0J
dHlwZW9mKHZhcmlhYmxlKSBwc2NyMl9yZXRfXzsJCQkJCVwKKwlfX3R5cGVvZl91bnF1YWxfXyh2
YXJpYWJsZSkgcHNjcjJfcmV0X187CQkJXAogCV9fdmVyaWZ5X3BjcHVfcHRyKCYodmFyaWFibGUp
KTsJCQkJCVwKIAlzd2l0Y2goc2l6ZW9mKHZhcmlhYmxlKSkgewkJCQkJXAogCWNhc2UgMTogcHNj
cjJfcmV0X18gPSBzdGVtIyMxKHZhcmlhYmxlLCBfX1ZBX0FSR1NfXyk7IGJyZWFrOwlcCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3ByYW5kb20uaCBiL2luY2x1ZGUvbGludXgvcHJhbmRvbS5o
CmluZGV4IGY3ZjFlNTI1MWM2Ny4uZjJlZDViNzJiM2Q2IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L3ByYW5kb20uaAorKysgYi9pbmNsdWRlL2xpbnV4L3ByYW5kb20uaApAQCAtMTAsNiArMTAs
NyBAQAogCiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KICNpbmNsdWRlIDxsaW51eC9vbmNlLmg+
CisjaW5jbHVkZSA8bGludXgvcGVyY3B1Lmg+CiAjaW5jbHVkZSA8bGludXgvcmFuZG9tLmg+CiAK
IHN0cnVjdCBybmRfc3RhdGUgewpkaWZmIC0tZ2l0IGEva2VybmVsL2V2ZW50cy9od19icmVha3Bv
aW50LmMgYi9rZXJuZWwvZXZlbnRzL2h3X2JyZWFrcG9pbnQuYwppbmRleCA2YzJjYjRlNGY0OGQu
LmQ4MmZlNzhmMDY1OCAxMDA2NDQKLS0tIGEva2VybmVsL2V2ZW50cy9od19icmVha3BvaW50LmMK
KysrIGIva2VybmVsL2V2ZW50cy9od19icmVha3BvaW50LmMKQEAgLTg0OSw3ICs4NDksNyBAQCBy
ZWdpc3Rlcl93aWRlX2h3X2JyZWFrcG9pbnQoc3RydWN0IHBlcmZfZXZlbnRfYXR0ciAqYXR0ciwK
IAogCWNwdV9ldmVudHMgPSBhbGxvY19wZXJjcHUodHlwZW9mKCpjcHVfZXZlbnRzKSk7CiAJaWYg
KCFjcHVfZXZlbnRzKQotCQlyZXR1cm4gKHZvaWQgX19wZXJjcHUgX19mb3JjZSAqKUVSUl9QVFIo
LUVOT01FTSk7CisJCXJldHVybiAodm9pZCBfX3BlcmNwdSBfX2ZvcmNlICopKHVpbnRwdHJfdClF
UlJfUFRSKC1FTk9NRU0pOwogCiAJY3B1c19yZWFkX2xvY2soKTsKIAlmb3JfZWFjaF9vbmxpbmVf
Y3B1KGNwdSkgewpAQCAtODY4LDcgKzg2OCw3IEBAIHJlZ2lzdGVyX3dpZGVfaHdfYnJlYWtwb2lu
dChzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICphdHRyLAogCQlyZXR1cm4gY3B1X2V2ZW50czsKIAog
CXVucmVnaXN0ZXJfd2lkZV9od19icmVha3BvaW50KGNwdV9ldmVudHMpOwotCXJldHVybiAodm9p
ZCBfX3BlcmNwdSBfX2ZvcmNlICopRVJSX1BUUihlcnIpOworCXJldHVybiAodm9pZCBfX3BlcmNw
dSBfX2ZvcmNlICopKHVpbnRwdHJfdClFUlJfUFRSKGVycik7CiB9CiBFWFBPUlRfU1lNQk9MX0dQ
TChyZWdpc3Rlcl93aWRlX2h3X2JyZWFrcG9pbnQpOwogCmRpZmYgLS1naXQgYS9rZXJuZWwvbG9j
a2luZy9wZXJjcHUtcndzZW0uYyBiL2tlcm5lbC9sb2NraW5nL3BlcmNwdS1yd3NlbS5jCmluZGV4
IDYwODM4ODNjNGZlMC4uMWM4ZmNhN2U2ZmQ2IDEwMDY0NAotLS0gYS9rZXJuZWwvbG9ja2luZy9w
ZXJjcHUtcndzZW0uYworKysgYi9rZXJuZWwvbG9ja2luZy9wZXJjcHUtcndzZW0uYwpAQCAtMTg0
LDcgKzE4NCw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKF9fcGVyY3B1X2Rvd25fcmVhZCk7CiAKICNk
ZWZpbmUgcGVyX2NwdV9zdW0odmFyKQkJCQkJCVwKICh7CQkJCQkJCQkJXAotCXR5cGVvZih2YXIp
IF9fc3VtID0gMDsJCQkJCQlcCisJX190eXBlb2ZfdW5xdWFsX18odmFyKSBfX3N1bSA9IDA7CQkJ
CVwKIAlpbnQgY3B1OwkJCQkJCQlcCiAJY29tcGlsZXRpbWVfYXNzZXJ0X2F0b21pY190eXBlKF9f
c3VtKTsJCQkJXAogCWZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpCQkJCQlcCmRpZmYgLS1naXQg
YS9rZXJuZWwvd29ya3F1ZXVlLmMgYi9rZXJuZWwvd29ya3F1ZXVlLmMKaW5kZXggZjM5NzUxMGVk
YzliLi43ZGQ2MzkyYzljNTIgMTAwNjQ0Ci0tLSBhL2tlcm5lbC93b3JrcXVldWUuYworKysgYi9r
ZXJuZWwvd29ya3F1ZXVlLmMKQEAgLTM3Nyw3ICszNzcsNyBAQCBzdHJ1Y3Qgd29ya3F1ZXVlX3N0
cnVjdCB7CiAKIAkvKiBob3QgZmllbGRzIHVzZWQgZHVyaW5nIGNvbW1hbmQgaXNzdWUsIGFsaWdu
ZWQgdG8gY2FjaGVsaW5lICovCiAJdW5zaWduZWQgaW50CQlmbGFncyBfX19fY2FjaGVsaW5lX2Fs
aWduZWQ7IC8qIFdROiBXUV8qIGZsYWdzICovCi0Jc3RydWN0IHBvb2xfd29ya3F1ZXVlIF9fcGVy
Y3B1IF9fcmN1ICoqY3B1X3B3cTsgLyogSTogcGVyLWNwdSBwd3FzICovCisJc3RydWN0IHBvb2xf
d29ya3F1ZXVlICogX19wZXJjcHUgX19yY3UgKmNwdV9wd3E7IC8qIEk6IHBlci1jcHUgcHdxcyAq
LwogCXN0cnVjdCB3cV9ub2RlX25yX2FjdGl2ZSAqbm9kZV9ucl9hY3RpdmVbXTsgLyogSTogcGVy
LW5vZGUgbnJfYWN0aXZlICovCiB9OwogCmRpZmYgLS1naXQgYS9saWIvcGVyY3B1X2NvdW50ZXIu
YyBiL2xpYi9wZXJjcHVfY291bnRlci5jCmluZGV4IDQ0ZGQxMzM1OTRkNC4uNzRmNDM4ZjQ2OWQ4
IDEwMDY0NAotLS0gYS9saWIvcGVyY3B1X2NvdW50ZXIuYworKysgYi9saWIvcGVyY3B1X2NvdW50
ZXIuYwpAQCAtMTc1LDcgKzE3NSw3IEBAIGludCBfX3BlcmNwdV9jb3VudGVyX2luaXRfbWFueShz
dHJ1Y3QgcGVyY3B1X2NvdW50ZXIgKmZiYywgczY0IGFtb3VudCwKIAkJSU5JVF9MSVNUX0hFQUQo
JmZiY1tpXS5saXN0KTsKICNlbmRpZgogCQlmYmNbaV0uY291bnQgPSBhbW91bnQ7Ci0JCWZiY1tp
XS5jb3VudGVycyA9ICh2b2lkICopY291bnRlcnMgKyAoaSAqIGNvdW50ZXJfc2l6ZSk7CisJCWZi
Y1tpXS5jb3VudGVycyA9ICh2b2lkIF9fcGVyY3B1ICopY291bnRlcnMgKyAoaSAqIGNvdW50ZXJf
c2l6ZSk7CiAKIAkJZGVidWdfcGVyY3B1X2NvdW50ZXJfYWN0aXZhdGUoJmZiY1tpXSk7CiAJfQpk
aWZmIC0tZ2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9uZXQvY29yZS9kZXYuYwppbmRleCAzMzE4NDhl
Y2E3ZDMuLjRkZmMwZWE5MjUxMyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvZGV2LmMKKysrIGIvbmV0
L2NvcmUvZGV2LmMKQEAgLTEwNjUxLDcgKzEwNjUxLDcgQEAgbm9pbmxpbmUgdm9pZCBuZXRkZXZf
Y29yZV9zdGF0c19pbmMoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdTMyIG9mZnNldCkKIAkJCXJl
dHVybjsKIAl9CiAKLQlmaWVsZCA9IChfX2ZvcmNlIHVuc2lnbmVkIGxvbmcgX19wZXJjcHUgKiko
KF9fZm9yY2Ugdm9pZCAqKXAgKyBvZmZzZXQpOworCWZpZWxkID0gKHVuc2lnbmVkIGxvbmcgX19w
ZXJjcHUgKikodm9pZCBfX3BlcmNwdSAqKShwICsgb2Zmc2V0KTsKIAl0aGlzX2NwdV9pbmMoKmZp
ZWxkKTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKG5ldGRldl9jb3JlX3N0YXRzX2luYyk7Cg==
--000000000000f1b815061742f5a7--

