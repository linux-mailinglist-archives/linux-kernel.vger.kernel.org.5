Return-Path: <linux-kernel+bounces-130998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03DA8981B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2251C25A2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A1454902;
	Thu,  4 Apr 2024 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh/3DugJ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398E54747;
	Thu,  4 Apr 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213796; cv=none; b=nitd3Ucq+PuE42JjRIByOEHWLXawtufbivz1pHjd5nV8xqNWWfYfBJICSRp6N0zwdEdyOESF0bnN1OSFwSIpAUvd8RId6piCN7E0zdwPoeHQVRoV5zsz6RTJ3scDuQrYUgWVy20HL065HzFtqsynKLoBOgsHER8g2BBODE99IVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213796; c=relaxed/simple;
	bh=dmJxPO62alglVgi5pUTiC0dFb2IdTQW74ytyacCmbUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia24fGkuS6yuxbVSmneDbgmfs8mIHpbHgmTQKE5tGi8fw8+CH2w0NfQP9hSpKp9uH1jbzdyDbdvFFMWRMFt/pk1Ml7E+EEPuL3+pAalLz0bmot6Kdowrliybl7DbU+bGOEBR6T8OkEiQXNyxJpZExo7RFTApmqlYH9MjOVlsllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh/3DugJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so7236301fa.1;
        Wed, 03 Apr 2024 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712213792; x=1712818592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LSLitdMdT1UlNRaUakWNHJUJo0RradF6J1sW3PFzcEQ=;
        b=jh/3DugJNv4gm1ApCsZ7jTWiR1PyAkXzAo2/+TTgPGxYPMsaJbdS870yh1hkgco7En
         q0O3qiHYFvLI0AUvV4QI0sXWP5jUPdm/qgTSkshuCPKDZdAyaqonIB1fmjQoozDexCZw
         qnuM+gn4YOFx/nOzf1/UjFFEPNh9LfYkeanXV75frtjhImoIoC4oDR9WOAl54NDt2zOj
         f8s9kLMtJaApz4cbGBHu1jk88RvlzIsmQRWS1/nOj8NB6tIgKQwpICm8BtaUuudiUbVj
         3XeuQCDL4L/0vNoYX6XV4dir4oe/5na2Tg7/Hl9Jf3m/qMXrd6R2oZLgFA7J/URzyfjB
         GLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712213792; x=1712818592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSLitdMdT1UlNRaUakWNHJUJo0RradF6J1sW3PFzcEQ=;
        b=dpYcW62WTJ+zuYPmxEsxtckDDv0WJLtJkoRXTdnp+RA7IJW9gk3N7Io9/N11wkvq4d
         Y/StjDPEW8FwzlG+ey6KQazcU6bjk6B0iqLv/PnrTrbeg4EvllYMKThG0lZXcfOvRRBz
         BQTHN8Z1mpmFYCEPEPihXtZeCXFov7nNOu1PzgcLHiujuNX2UdIplAwypCZfcaFnKJfK
         ROBpv8ysGxUZRc92LY4GUTA7rxGK6w2GdFnw5UrxWBgR50KzEDl9XBiaLHvm2QQX/AwY
         foLW3BXNNwQQ5vBgYfbzJgBehT2bjhUqbS6X8xqV5YHT4thk2XeBF8oVWV8S2rWqBupV
         kVUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2yRizSgMjIfUhfjikYHPMh7bM7r1BRdSyfXNt0m+VsmApx0GvSU/1i7jbhm5sgKr2wrv8WdCLeKbT8QUtgYtHXK32Anpx3OxEBPThtZav4Wo6qmFAB5PP2fqQ1qnc5nDe9VHhU2SiF/xZ
X-Gm-Message-State: AOJu0YwHC/Eiex4Bz8Iamo9NfnWNOrSnUvfTeztdyFXhc6hV1yzW8dUf
	kDtwy6ulHd8aN3dG0/MCYnYFQGJ7wluASH1Ia5lkxWyDnl2g909BP9EQ+avwlDGxGLyyvFy4kwy
	bakqkyQGTFCRunAaBauAvKlh3FcU=
X-Google-Smtp-Source: AGHT+IEEcxcmbMU09J0hrilIBRlyZ2FZNmR22nx764QfdoK2BFHoDfyWDmh6Y7Mc7L2Wmmb1oG8fv98gWw6Xrhz8aoY=
X-Received: by 2002:a2e:990f:0:b0:2d7:f07:89f8 with SMTP id
 v15-20020a2e990f000000b002d70f0789f8mr1271505lji.45.1712213792127; Wed, 03
 Apr 2024 23:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx> <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx> <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
 <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
 <87bk7ux4e9.ffs@tglx> <CAFULd4aEe2KU=UXEt2=GeLQq2uTSFvydBiwAdSa7B6T61Am=5w@mail.gmail.com>
 <878r2ywk3k.ffs@tglx> <CAFULd4YG21NdF_qNVBGDtXO6xnaYFeRPvKicB=gpgUUqYE=4jw@mail.gmail.com>
 <20240403175723.GA2667607@dev-arch.thelio-3990X>
In-Reply-To: <20240403175723.GA2667607@dev-arch.thelio-3990X>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 4 Apr 2024 08:56:19 +0200
Message-ID: <CAFULd4bzZuv=gW63jay_mMuPSAdh01Y=LhdVHXq51-cYPCJR0A@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, llvm@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000dc1a7f06153fd66f"

--000000000000dc1a7f06153fd66f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:57=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:

> > > > With GCC, you can use __typeof_unqual__ (please note underscores)
> > > > without -std=3Dc2x [1]:
> > > >
> > > > "... Alternate spelling __typeof_unqual__ is available in all C mod=
es
> > > > and provides non-atomic unqualified version of what __typeof__
> > > > operator returns..."
> > > >
> > > > Please also see the example in my last post. It can be compiled wit=
hout -std=3D...
> > >
> > > With gcc >=3D 14. Not so with clang...
> >
> > Please note that clang-17.0.6 currently fails to compile kernel with
> > named address spaces [1]. So perhaps kernel can use __typeof_unqual__
> > (available without -std=3Dc2x) in the hope that clang implements
> > __typeof_unqual__ in one of its next releases, following the examples
> > of GCC [2] and MSVC[3].
>
> This is now supported in clang 19.0.0 (main):
>
> https://github.com/llvm/llvm-project/commit/cc308f60d41744b5920ec2e2e5b25=
e1273c8704b
>
> I have inquired about applying this to the 18.x series, such that it
> would either make 18.1.3 or 18.1.4, but that is still open for
> discussion.
>
> I think the error that I mentioned at [1] is resolved with using
> __typeof_unqual__, I tested this diff, which is likely incorrect but
> allows me to continue testing without that warning/error due to -Werror:
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.=
h
> index 20696df5d567..fc77c99d2e80 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -95,7 +95,7 @@
>
>  #endif /* CONFIG_SMP */
>
> -#define __my_cpu_type(var)     typeof(var) __percpu_seg_override
> +#define __my_cpu_type(var)     __typeof_unqual__(var) __percpu_seg_overr=
ide
>  #define __my_cpu_ptr(ptr)      (__my_cpu_type(*ptr)*)(__force uintptr_t)=
(ptr)
>  #define __my_cpu_var(var)      (*__my_cpu_ptr(&(var)))
>  #define __percpu_arg(x)                __percpu_prefix "%" #x

IMO, the above change is not correct. Currently, the percpu variables
still live in generic address space, and the above casts are used at
the usage site of the percpu variable to convert pointer from generic
to disjoint __seg_gs address space (please see [2], section 6.17.5).
The -Wduplicate-decl-specifier warning at [1] (if correct) perhaps
points to the percpu accessor chain. GCC does not care about duplicate
__seg_gs conversions (the operation is idempotent), but the issue
should be corrected nevertheless.

BTW: With the above approach we get all the benefits of named address
spaces, but *not* checks for invalid access between disjoint address
spaces. This check is currently done by sparse (this is the reason for
__force in the above cast chain), but the check is not enabled by
default. The proposed improvement would *define* the percpu variable
in __seg_gs named address space, so the compiler will error out with
"assignment/return from pointer to non-enclosed address space" when
invalid access is detected (please see attached testcase, should be
compiled with gcc-14 due to usage of __typeof_unqual__) or warn with
"cast to generic address space pointer from disjoint =E2=80=98__seg_gs=E2=
=80=99
address space pointer" with explicit cast.

[1] https://lore.kernel.org/lkml/20240320173758.GA3017166@dev-arch.thelio-3=
990X/
[2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html

Uros.

--000000000000dc1a7f06153fd66f
Content-Type: text/x-csrc; charset="US-ASCII"; name="seg.c"
Content-Disposition: attachment; filename="seg.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lukvrsfr0>
X-Attachment-Id: f_lukvrsfr0

aW50IF9fc2VnX2dzIHZhcjsKCnZvaWQgZm9vMSAodm9pZCkKewogIGFzbSB2b2xhdGlsZSAoIiMg
JTAiIDo6ICJtIiAodmFyKSk7Cn0KCmludCBmb28yICh2b2lkKQp7CiAgcmV0dXJuIHZhcjsKfQoK
aW50IF9fc2VnX2dzICpiYXIxICh2b2lkKQp7CiAgcmV0dXJuICZ2YXI7Cn0KCmludCAqYmFyMiAo
dm9pZCkKewogIC8vIHJldHVybiAmdmFyOyAvKiBlcnJvciAqLwogIHJldHVybiAoaW50ICopJnZh
cjsKfQoKaW50ICpiYXIzICh2b2lkKQp7CiAgaW50ICpwOwoKICAvLyAgcCA9ICZ2YXI7IC8qIGVy
cm9yICovCiAgcCA9IChpbnQgKikmdmFyOwoKICByZXR1cm4gcDsKfQoKaW50IF9fc2VnX2dzICpi
YXoxICh2b2lkKQp7CiAgdHlwZW9mKHZhcikgKnA7IC8qIChfX3NlZ19ncyBpbnQgKikgKi8KCiAg
cCA9ICZ2YXI7CgogIHJldHVybiBwOwp9CgppbnQgKmJhejIgKHZvaWQpCnsKICBfX3R5cGVvZl91
bnF1YWxfXyh2YXIpICpwOyAvKiAoaW50ICopICovCgogIC8vIHAgPSAmdmFyOyAvKiBlcnJvciAq
LwogIHAgPSAoaW50ICopJnZhcjsKCiAgcmV0dXJuIHA7Cn0K
--000000000000dc1a7f06153fd66f--

