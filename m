Return-Path: <linux-kernel+bounces-18553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7A825F29
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 11:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD4C1F233B3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A463DA;
	Sat,  6 Jan 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnzCFH9A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354363AA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55679552710so3399a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 02:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704536778; x=1705141578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPXLeIsh1MpII0KRfknEvak1pJLfOWK+MLM2dDld17U=;
        b=wnzCFH9AgyWXEUzn7ZE9n5WyiKly623zERvJ6U6ZNPG9/mMVCnOM7Hpf6BHJx14Fd7
         CzXVqacCNlmF6MOcohZP38Q+hmbM68T95FzPw/AMgR71TRiM1kmHnP4wx4eu/1uWoVaU
         ledgo/u3hWL7iqys8UBSlcyADIoR/cdbL63yNhTpyA5mkLFfq8e17sqQmgcll2Hbdu1H
         qOpJBa18Uag7NYdIRn706sY5UprVKA9mJqrb8cbc42pKFI9IWODWmQg8CM5Pggo0ZNok
         7T4bkars9oMhcULnHPOQbLmeT3d+39aMiDuZKph9rLzvuVBno3hdeEOWt5XdTV3w5Xx3
         qO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704536778; x=1705141578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPXLeIsh1MpII0KRfknEvak1pJLfOWK+MLM2dDld17U=;
        b=DpmWMnmc+TM57oEVX2rdbd3ncwa1izTJSgmJOK2faWQ68wjQNpMtsH5gbytbUAUq/Y
         45/gH+8Dbz79tFsjqIUurEtwEaugGzgCRT4pvBvwjc+Lo3oL7Gh0Lwb5/QU7P6J/URcE
         MGS8YM5uQH2fvHOuL4Os9pO88nG4wP26WdI77CYzUv582rt1T71UdT69oyyBt8TMCZQ4
         5LI5H32v5whnNW9iHYyVhOItQo8dvf2Hx/gG3/QUaq1KZ1lfOUdFAzi8fISF3xnntkB3
         9Ou90+h0W1r+TerWRza4qxHkZdOCKAoLlCh0dN6uHJJFSQsaljpiR6Z3sMLXmjosQyr7
         u0xQ==
X-Gm-Message-State: AOJu0YzWB/ZnNKSnCTz/IBEdjR3X6C/xRouwFDC9Htxks8vgKLlhJo/z
	lwkoTCLHyDL3Aeqg9pite0JfyrM+TGs6KiGpXXmd+T8nvamn
X-Google-Smtp-Source: AGHT+IGhaUwX7i/3K4/Bu2g2V3TYNVx+nug6eDPVsTk3eFahDjPMd7/l9gJHMxoOT2Zgbu3/OstLd9GNokeRAvfDV1A=
X-Received: by 2002:a50:8a93:0:b0:557:15d:b784 with SMTP id
 j19-20020a508a93000000b00557015db784mr94560edj.2.1704536777508; Sat, 06 Jan
 2024 02:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com> <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
 <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
 <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
 <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com>
 <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com> <CAHk-=wg8vssPVO68_qH_BHBCj6_DDawKQHBOgZh4gw5YFmpCKA@mail.gmail.com>
 <204bf145e6ad47219c005e9a4407ebdc@AcuMS.aculab.com> <CAHk-=wjGaH6oA47WkphTweMiy15Zjfuk-aVcXSasMX=aX9rFLQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjGaH6oA47WkphTweMiy15Zjfuk-aVcXSasMX=aX9rFLQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Jan 2024 11:26:06 +0100
Message-ID: <CANn89iKjUZjw-9ACNWrEd_H+o79Uwkw9NVuujQ3w=c2pGRFotg@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>, Noah Goldstein <goldstein.w.n@gmail.com>, 
	kernel test robot <lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 1:19=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 5 Jan 2024 at 15:53, David Laight <David.Laight@aculab.com> wrote=
:
> >
> > I'd have to fix his benchmark code first :-)
> > You can't use the TSC unless you lock the cpu frequency.
> > The longer the test runs for the faster the cpu will run.
>
> They'll stabilize, it has soem cycle result aging code.
>
> But yes, set the CPU policy to 'performance' or do performance
> counters if you care deeply.
>
> > On a related point, do you remember what the 'killer app'
> > was for doing the checksum in copy_to/from_user?
>
> No. It's a long time ago, and many things have changed since.
>
> It's possible the copy-and-csum it's not worth it any more, simply
> because all modern network cards will do the csum for us, and I think
> loopback sets a flag saying "no need to checksum" too.
>
> But I do have a strong memory of it being a big deal back when. A
> _loong_ time ago.
>

On a related note, at least with clang, I found that csum_ipv6_magic()
is needlessly using temporary on-stack storage,
showing a stall on Cascade Lake unless I am patching add32_with_carry() :

diff --git a/arch/x86/include/asm/checksum_64.h
b/arch/x86/include/asm/checksum_64.h
index 407beebadaf45a748f91a36b78bd1d023449b132..c3d6f47626c70d81f0c2ba401d8=
5050b09a39922
100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -171,7 +171,7 @@ static inline unsigned add32_with_carry(unsigned
a, unsigned b)
        asm("addl %2,%0\n\t"
            "adcl $0,%0"
            : "=3Dr" (a)
-           : "0" (a), "rm" (b));
+           : "0" (a), "r" (b));
        return a;
 }

Before patch :

ffffffff81b9b600 <csum_ipv6_magic>:
ffffffff81b9b600: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
ffffffff81b9b601: R_X86_64_NONE __fentry__-0x4
ffffffff81b9b605: 55                    push   %rbp
ffffffff81b9b606: 48 89 e5              mov    %rsp,%rbp
ffffffff81b9b609: 48 83 ec 04          sub    $0x4,%rsp     // This
will be removed after patch
ffffffff81b9b60d: 0f ca                bswap  %edx
ffffffff81b9b60f: 89 c9                mov    %ecx,%ecx
ffffffff81b9b611: 48 c1 e1 08          shl    $0x8,%rcx
ffffffff81b9b615: 44 89 c0              mov    %r8d,%eax
ffffffff81b9b618: 48 01 d0              add    %rdx,%rax
ffffffff81b9b61b: 48 01 c8              add    %rcx,%rax
ffffffff81b9b61e: 48 03 07              add    (%rdi),%rax
ffffffff81b9b621: 48 13 47 08          adc    0x8(%rdi),%rax
ffffffff81b9b625: 48 13 06              adc    (%rsi),%rax
ffffffff81b9b628: 48 13 46 08          adc    0x8(%rsi),%rax
ffffffff81b9b62c: 48 83 d0 00          adc    $0x0,%rax
ffffffff81b9b630: 48 89 c1              mov    %rax,%rcx
ffffffff81b9b633: 48 c1 e9 20          shr    $0x20,%rcx
ffffffff81b9b637: 89 4d fc              mov    %ecx,-0x4(%rbp)  //
Store exc on the stack
ffffffff81b9b63a: 03 45 fc              add    -0x4(%rbp),%eax  //
reads the value right away, stalling some Intel cpus.
ffffffff81b9b63d: 83 d0 00              adc    $0x0,%eax
ffffffff81b9b640: 89 c1                mov    %eax,%ecx   // Note that
ecs content was scratch anyway
ffffffff81b9b642: c1 e1 10              shl    $0x10,%ecx
ffffffff81b9b645: 25 00 00 ff ff        and    $0xffff0000,%eax
ffffffff81b9b64a: 01 c8                add    %ecx,%eax
ffffffff81b9b64c: 15 ff ff 00 00        adc    $0xffff,%eax
ffffffff81b9b651: f7 d0                not    %eax
ffffffff81b9b653: c1 e8 10              shr    $0x10,%eax
ffffffff81b9b656: 48 83 c4 04          add    $0x4,%rsp
ffffffff81b9b65a: 5d                    pop    %rbp
ffffffff81b9b65b: c3                    ret
ffffffff81b9b65c: cc                    int3
ffffffff81b9b65d: 00 00                add    %al,(%rax)
ffffffff81b9b65f: cc                    int3

After patch:

00000000000000a0 <csum_ipv6_magic>:
  a0: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
a1: R_X86_64_NONE __fentry__-0x4
  a5: 55                    push   %rbp
  a6: 48 89 e5              mov    %rsp,%rbp
  a9: 0f ca                bswap  %edx
  ab: 89 c9                mov    %ecx,%ecx
  ad: 48 c1 e1 08          shl    $0x8,%rcx
  b1: 44 89 c0              mov    %r8d,%eax
  b4: 48 01 d0              add    %rdx,%rax
  b7: 48 01 c8              add    %rcx,%rax
  ba: 48 03 07              add    (%rdi),%rax
  bd: 48 13 47 08          adc    0x8(%rdi),%rax
  c1: 48 13 06              adc    (%rsi),%rax
  c4: 48 13 46 08          adc    0x8(%rsi),%rax
  c8: 48 83 d0 00          adc    $0x0,%rax
  cc: 48 89 c1              mov    %rax,%rcx
  cf: 48 c1 e9 20          shr    $0x20,%rcx
  d3: 01 c8                add    %ecx,%eax   // just better !
  d5: 83 d0 00              adc    $0x0,%eax
  d8: 89 c1                mov    %eax,%ecx
  da: c1 e1 10              shl    $0x10,%ecx
  dd: 25 00 00 ff ff        and    $0xffff0000,%eax
  e2: 01 c8                add    %ecx,%eax
  e4: 15 ff ff 00 00        adc    $0xffff,%eax
  e9: f7 d0                not    %eax
  eb: c1 e8 10              shr    $0x10,%eax
  ee: 5d                    pop    %rbp
  ef: c3                    ret
  f0: cc                    int3

