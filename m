Return-Path: <linux-kernel+bounces-67244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D402856892
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049B7292433
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCF813343A;
	Thu, 15 Feb 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ho/D51sI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2C58AAC;
	Thu, 15 Feb 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012448; cv=none; b=NBO+CIy1hzqdcH9wQliPWbrL2xIuOPRGABCMRuf0eUD3MTNnbUj1ar4p4kX9mO/CMIKmjPK7W4ysguDLIBOW/EYHBhd0cIjYnq7bjqIzyWG7s8RV0loLE+nRjFrsijg5UhS5dhnFYfUVLKcM8NxcOb8JUxnf4hKApRw2NLsc7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012448; c=relaxed/simple;
	bh=FucTpaG2QWsByOPEN+kiv5pPEkMvSvmqtzTj9F1+2Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grMLSHJZX/TcxRNEizOaYm0eKzx70skBH1a3dqhd7fU7i/IY09h91UMSEEuXkSUJlDLWQiZATgfPF9J9OMo8dALjYd38wxFPo76i0fZ7HfM1gKXUlAFPSdzA/30yqKFbUJGqFVbjO7nyHyYJEKO56F3+amLnGjekUaoFxFgSoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ho/D51sI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7926940E00B2;
	Thu, 15 Feb 2024 15:54:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VMXhnFquZ--w; Thu, 15 Feb 2024 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708012440; bh=1/7JX3IDa3rrHd76+naFromZzu40vS7fK2E4kfNgUSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ho/D51sIdHoCJ+SpERIDzy1dGp9h5Q0nkrqvxWThxdP43nNsTUC8PxafOGfyLZDbL
	 mAeP3cz0VSAY19sxbgxTcFqtCZEOyPPlEzPWYOV+MbXksYtBvYmT7+f7WvVF+pYCjw
	 0HPFboPtn2UlK3R8ucS/dXqxkCtpwxyWe01UeL+qed6+ueuvFp8PU4OJHG+K9gIgkE
	 3N4B92trzmCNezzcj0MGDNI0+AXeJAo1TbEjrXQMI2hLjRrhIDZJuObDznODeOAZJv
	 ZDDi47oQ562UiVpbeYK4gtxuQR8T/+vZoTSKzIpjjrf5lobqpjh/UKv1VIL9U2rUtJ
	 wbWiXdsraZHk4VX4AeIqLmcAl7XkiwonzNpXm8sxxJscEsJFdsoE4qhOEj+J4kMpw9
	 RMQGzpP8afymvEzshdvrYkaOr3et6DGXTk6Okhbre8J7LJ9u2RRBQAzLnG0Je6Bj9l
	 j8AmBiesBkcPaw/PNKzAxE8g7uv9vT+GLEqN8lukXQqFmeKJ/O1fLlSyDDoU20qaX0
	 dl/ICMalTb261CwSlunsWhfo6Ph7uskF6VHRnlAhQ2SIFAUqURuAopMh72A8quK8dT
	 4tjuCh+ApI6X+xnqHGuTK9SLwWz20gCFtXuyM2npD6ZJG6dc9E7Eb0ynM4dCPK2vAU
	 goPLQQvB+sgYhnuXoObGuE/E=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 323AB40E0192;
	Thu, 15 Feb 2024 15:53:55 +0000 (UTC)
Date: Thu, 15 Feb 2024 16:53:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240215155349.GBZc4zjaHn8hj6xOq3@fat_crate.local>
References: <20231010171020.462211-4-david.kaplan@amd.com>
 <170774721951.398.8999401565129728535.tip-bot2@tip-bot2>
 <20240215032049.GA3944823@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240215032049.GA3944823@dev-arch.thelio-3990X>

On Wed, Feb 14, 2024 at 08:20:49PM -0700, Nathan Chancellor wrote:
> On Mon, Feb 12, 2024 at 02:13:39PM -0000, tip-bot2 for Josh Poimboeuf wro=
te:
> > The following commit has been merged into the x86/bugs branch of tip:
> >=20
> > Commit-ID:     4461438a8405e800f90e0e40409e5f3d07eed381
> > Gitweb:        https://git.kernel.org/tip/4461438a8405e800f90e0e40409e5=
f3d07eed381
> > Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> > AuthorDate:    Wed, 03 Jan 2024 19:36:26 +01:00
> > Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > CommitterDate: Mon, 12 Feb 2024 11:42:15 +01:00
> >=20
> > x86/retpoline: Ensure default return thunk isn't used at runtime
> >=20
> > Make sure the default return thunk is not used after all return
> > instructions have been patched by the alternatives because the default
> > return thunk is insufficient when it comes to mitigating Retbleed or
> > SRSO.
> >=20
> > Fix based on an earlier version by David Kaplan <david.kaplan@amd.com>.
> >=20
> >   [ bp: Fix the compilation error of warn_thunk_thunk being an invisible
> >         symbol, hoist thunk macro into calling.h ]
> >=20
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Link: https://lore.kernel.org/r/20231010171020.462211-4-david.kaplan@am=
d.com
> > Link: https://lore.kernel.org/r/20240104132446.GEZZaxnrIgIyat0pqf@fat_c=
rate.local
>=20
> This warning is now getting triggered for me in some of my builds,
> specifically from Alpine Linux's configuration. A minimal reproducer on
> top of defconfig:
>=20
> $ echo 'CONFIG_X86_KERNEL_IBT=3Dn
> CONFIG_UNWINDER_ORC=3Dn
> CONFIG_UNWINDER_FRAME_POINTER=3Dy' >arch/x86/configs/repro.config

Yeah, the special vdso glue:

[  325.985728] PCI: Using configuration type 1 for base access
[  325.986637] PCI: Using configuration type 1 for extended access
[  325.987797] initcall pci_arch_init+0x0/0x90 returned 0 after 3000 usecs
[  325.988815] calling  init_vdso_image_64+0x0/0x30 @ 1
[  325.989804] ------------[ cut here ]------------
[  325.990724] Unpatched return thunk in use. This should not happen!
[  325.991735] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:2856 __=
warn_thunk+0x27/0x40
[  325.992793] Modules linked in:
[  325.993440] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-00040-g4=
589f199eb68 #1
[  325.993794] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  325.994794] RIP: 0010:__warn_thunk+0x27/0x40
[  325.995648] Code: 90 90 90 80 3d 62 38 c3 01 00 74 05 e9 52 07 ee 00 55 =
c6 05 53 38 c3 01 01 48 89 e5 90 48 c7 c7 08 54 71 82 e8 9a c9 03 00 90 <0f=
> 0b 90 90 5d e9 2f 07 ee 00 cc cc cc cc cc cc cc cc cc cc cc cc
[  325.996793] RSP: 0018:ffffc90000013e10 EFLAGS: 00010286
[  325.997793] RAX: 0000000000000000 RBX: ffffffff82cfdac0 RCX: 00000000000=
00000
[  325.998795] RDX: 0000000000000000 RSI: 00000000fff7ffff RDI: 00000000000=
00001
[  325.999793] RBP: ffffc90000013e10 R08: 00000000fff7ffff R09: ffffc900000=
13c90
[  326.000794] R10: 0000000000000001 R11: ffff88807b7df000 R12: 00000000000=
00000
[  326.001793] R13: ffff8880035f9900 R14: ffffc90000013e78 R15: 00000000000=
00000
[  326.002795] FS:  0000000000000000(0000) GS:ffff888079200000(0000) knlGS:=
0000000000000000
[  326.003795] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  326.004793] CR2: ffff888003201000 CR3: 0000000002a2c000 CR4: 00000000003=
506f0
[  326.005794] Call Trace:
[  326.006339]  <TASK>
[  326.006794]  ? show_regs+0x5f/0x70
[  326.007501]  ? __warn+0x83/0x130
[  326.007794]  ? __warn_thunk+0x27/0x40
[  326.008542]  ? report_bug+0x171/0x1a0
[  326.008793]  ? srso_return_thunk+0x5/0x5f
[  326.009603]  ? console_unlock+0x4f/0xe0
[  326.010381]  ? handle_bug+0x43/0x80
[  326.010795]  ? exc_invalid_op+0x18/0x70
[  326.011592]  ? asm_exc_invalid_op+0x1b/0x20
[  326.012440]  ? ia32_binfmt_init+0x40/0x40
[  326.012795]  ? __warn_thunk+0x27/0x40
[  326.013546]  warn_thunk_thunk+0x16/0x30
[  326.013795]  do_one_initcall+0x59/0x230
[  326.014574]  kernel_init_freeable+0x19a/0x2d0
[  326.014794]  ? __pfx_kernel_init+0x10/0x10
[  326.015629]  kernel_init+0x15/0x1b0
[  326.016326]  ret_from_fork+0x38/0x60
[  326.016794]  ? __pfx_kernel_init+0x10/0x10
[  326.017627]  ret_from_fork_asm+0x1a/0x30
[  326.018394]  </TASK>
[  326.018794] ---[ end trace 0000000000000000 ]---
[  326.019705] initcall init_vdso_image_64+0x0/0x30 returned 0 after 29000 =
usecs
[  326.020794] calling  init_vdso_image_32+0x0/0x20 @ 1

During build we do:

# VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
  arch/x86/entry/vdso/vdso2c arch/x86/entry/vdso/vdso64.so.dbg arch/x86/ent=
ry/vdso/vdso64.so arch/x86/entry/vdso/vdso-image-64.c

  ...

  # CC      arch/x86/entry/vdso/vdso-image-64.o
  gcc -Wp,-MMD,arch/x86/entry/vdso/.vdso-image-64.o.d -nostdinc -I./arch/x8=
6/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/=
uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/gener=
ated/uapi -include ./include/linux/compiler-version.h -include ./include/li=
nux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -fmacr=
o-prefix-map=3D./=3D -Werror -std=3Dgnu11 -fshort-wchar -funsigned-char -fn=
o-common -fno-PIE -fno-strict-aliasing -mno-sse -mno-mmx -mno-sse2 -mno-3dn=
ow -mno-avx -fcf-protection=3Dnone -m64 -falign-jumps=3D1 -falign-loops=3D1=
 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3D3 -mskip-rax-se=
tup -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -Wno-sign-compare -fno=
-asynchronous-unwind-tables -mindirect-branch=3Dthunk-extern -mindirect-bra=
nch-register -mindirect-branch-cs-prefix -mfunction-return=3Dthunk-extern -=
fno-jump-tables -fpatchable-function-entry=3D16,16 -fno-delete-null-pointer=
-checks -O2 -fno-allow-store-data-races -fstack-protector-strong -fno-omit-=
frame-pointer -fno-optimize-sibling-calls -ftrivial-auto-var-init=3Dzero -f=
no-stack-clash-protection -falign-functions=3D16 -fstrict-flex-arrays=3D3 -=
fno-strict-overflow -fno-stack-check -fconserve-stack -Wall -Wundef -Werror=
=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-ty=
pe -Werror=3Dstrict-prototypes -Wno-format-security -Wno-trigraphs -Wno-fra=
me-address -Wno-address-of-packed-member -Wmissing-declarations -Wmissing-p=
rototypes -Wframe-larger-than=3D2048 -Wno-main -Wno-unused-but-set-variable=
 -Wno-unused-const-variable -Wno-dangling-pointer -Wvla -Wno-pointer-sign -=
Wcast-function-type -Wno-stringop-overflow -Wno-array-bounds -Wno-alloc-siz=
e-larger-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dinco=
mpatible-pointer-types -Werror=3Ddesignated-init -Wenum-conversion -Wno-unu=
sed-but-set-variable -Wno-unused-const-variable -Wno-restrict -Wno-packed-n=
ot-aligned -Wno-format-overflow -Wno-format-truncation -Wno-stringop-trunca=
tion -Wno-missing-field-initializers -Wno-type-limits -Wno-shift-negative-v=
alue -Wno-maybe-uninitialized -Wno-sign-compare    -DKBUILD_MODFILE=3D'"arc=
h/x86/entry/vdso/vdso-image-64"' -DKBUILD_BASENAME=3D'"vdso_image_64"' -DKB=
UILD_MODNAME=3D'"vdso_image_64"' -D__KBUILD_MODNAME=3Dkmod_vdso_image_64 -c=
 -o arch/x86/entry/vdso/vdso-image-64.o arch/x86/entry/vdso/vdso-image-64.c

  ...

and what is missing here is

# cmd_gen_objtooldep arch/x86/lib/vdso-image-64.o
   { echo ; echo 'arch/x86/lib/vdso-image-64.o: $(wildcard ./tools/objtool/=
objtool)' ; } >> arch/x86/lib/...

or so which needs to create the .return_sites but that thing gets
generated without it:

  rm -f arch/x86/entry/vdso/built-in.a;  printf "arch/x86/entry/vdso/%s " v=
ma.o extable.o vdso32-setup.o vdso-image-64.o vdso-image-32.o | xargs ar cD=
PrST arch/x86/entry/vdso/built-in.a

I'd tend to look in Josh's direction as to say what would be the right
thing to do here and more specifically, where?

We need to run objtool on the vdso objects which are *kernel* code.
I.e., that initcall thing. The vdso-image-64.c gets generated by vdso2c
and lands in arch/x86/entry/vdso/vdso-image-64.c, that's why objtool
hasn't seen it yet.

I mean, it is one initcall in the vdso, probably not that important and
if its return hasn't been patched, it won't be the end of the world but
still...

In any case, the patch works as advertized! :-)

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

