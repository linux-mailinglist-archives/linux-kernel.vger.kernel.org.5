Return-Path: <linux-kernel+bounces-37924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340783B803
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FD11F25C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB34C175AA;
	Thu, 25 Jan 2024 03:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xa4V+T8N"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8D17593;
	Thu, 25 Jan 2024 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153354; cv=none; b=J1hqYSR9XUgohJHR6+xhXd7tHZuRRl4dDIIek0sFi/Ioe6+ba7B0O59UPwA+es3srHoDAq2FMtCOvJz7XH1GwANDk9jFrFiEGAe2fhN6YhTaYUjjCArrZBl/UX+2XSCVly6Kt8F266v3xB/ARlhNSWIR2p/gzKamj0lvdFBFT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153354; c=relaxed/simple;
	bh=0X6rWEK09NHa6BBHCR9XLlM19S/MwmJPDvK/vZWqAwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SKH4xslsfqajPrcTO092bS6Cw0wrXh3eYCEgZYCmXpDPOybDrmlFzamshCClTEmZh5x9ZYmdQ4AmbLUfVpd+ZrEetbfMQjHlaU8WD1TINl4RTgLyuVc/1h7LnB1uStXihFcSNFGZavb7+ZPK+M9IYot6V16wzRg5T87GJqsZPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Xa4V+T8N; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706153349;
	bh=GHY4swhnXLMFacA3pX4da7TLNe5sUk48QIMV0TOgBiw=;
	h=Date:From:To:Cc:Subject:From;
	b=Xa4V+T8NbVpRKFKzBpDs21TVuE9j0m4nySPKuhLFdgGPtOZTLpWz0JuqdEterO0si
	 aXr0tQjKg2URi/awXMg094hoWGzpxCeEUmZLdlrnl/pXnWZ2RhJQFlmFzHnGK7o/8C
	 HEHbmS0FspNnVeRCOmaqyaD5m64NpuUmjHFTgOM7fNeu/IxNg6SeU73ISpuzlC/s5p
	 R1iaPiLxGsy5s/0Uox11+vmQdfgtiryx7zCkICXYT4WDuSa/jmnkl+fDXWAsYwk/dC
	 C8B9G8/ylGyVUyURd/o+OsMHWLxkmSrzLOaiFuWQers1UjJQHNEhMp+YtvbRY7zRuS
	 kYZr0zmPqQS6g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TL5sK2Bw4z4wcJ;
	Thu, 25 Jan 2024 14:29:08 +1100 (AEDT)
Date: Thu, 25 Jan 2024 14:29:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240125142907.33015c9f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8NWZy_aWMrBmtL5e3YMQfKX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8NWZy_aWMrBmtL5e3YMQfKX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc allnoconfig)
failed like this:

WARNING: unmet direct dependencies detected for CRASH_DUMP
  Depends on [n]: ARCH_SUPPORTS_CRASH_DUMP [=3Dy] && KEXEC_CORE [=3Dn]
  Selected by [y]:
  - ARCH_SELECTS_KEXEC [=3Dy]
arch/powerpc/kernel/crash_dump.c:101:6: error: redefinition of 'is_kdump_ke=
rnel'
  101 | bool is_kdump_kernel(void)
      |      ^~~~~~~~~~~~~~~
In file included from arch/powerpc/kernel/crash_dump.c:12:
include/linux/crash_dump.h:64:20: note: previous definition of 'is_kdump_ke=
rnel' with type 'bool(void)' {aka '_Bool(void)'}
   64 | static inline bool is_kdump_kernel(void)
      |                    ^~~~~~~~~~~~~~~
kernel/crash_core.c: In function 'kimage_crash_copy_vmcoreinfo':
kernel/crash_core.c:43:18: error: invalid use of undefined type 'struct kim=
age'
   43 |         if (image->type !=3D KEXEC_TYPE_CRASH)
      |                  ^~
kernel/crash_core.c:43:28: error: 'KEXEC_TYPE_CRASH' undeclared (first use =
in this function); did you mean 'KEXEC_ON_CRASH'?
   43 |         if (image->type !=3D KEXEC_TYPE_CRASH)
      |                            ^~~~~~~~~~~~~~~~
      |                            KEXEC_ON_CRASH
kernel/crash_core.c:43:28: note: each undeclared identifier is reported onl=
y once for each function it appears in
kernel/crash_core.c:55:27: error: implicit declaration of function 'kimage_=
alloc_control_pages' [-Werror=3Dimplicit-function-declaration]
   55 |         vmcoreinfo_page =3D kimage_alloc_control_pages(image, 0);
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/crash_core.c:55:25: warning: assignment to 'struct page *' from 'int=
' makes pointer from integer without a cast [-Wint-conversion]
   55 |         vmcoreinfo_page =3D kimage_alloc_control_pages(image, 0);
      |                         ^
kernel/crash_core.c:66:14: error: invalid use of undefined type 'struct kim=
age'
   66 |         image->vmcoreinfo_data_copy =3D safecopy;
      |              ^~
kernel/crash_core.c: At top level:
kernel/crash_core.c:74:5: error: redefinition of 'kexec_should_crash'
   74 | int kexec_should_crash(struct task_struct *p)
      |     ^~~~~~~~~~~~~~~~~~
In file included from kernel/crash_core.c:12:
include/linux/kexec.h:474:19: note: previous definition of 'kexec_should_cr=
ash' with type 'int(struct task_struct *)'
  474 | static inline int kexec_should_crash(struct task_struct *p) { retur=
n 0; }
      |                   ^~~~~~~~~~~~~~~~~~
kernel/crash_core.c:92:5: error: redefinition of 'kexec_crash_loaded'
   92 | int kexec_crash_loaded(void)
      |     ^~~~~~~~~~~~~~~~~~
include/linux/kexec.h:475:19: note: previous definition of 'kexec_crash_loa=
ded' with type 'int(void)'
  475 | static inline int kexec_crash_loaded(void) { return 0; }
      |                   ^~~~~~~~~~~~~~~~~~
kernel/crash_core.c: In function 'kexec_crash_loaded':
kernel/crash_core.c:94:18: error: 'kexec_crash_image' undeclared (first use=
 in this function); did you mean 'kexec_crash_loaded'?
   94 |         return !!kexec_crash_image;
      |                  ^~~~~~~~~~~~~~~~~
      |                  kexec_crash_loaded
kernel/crash_core.c: At top level:
kernel/crash_core.c:103:16: error: redefinition of '__crash_kexec'
  103 | void __noclone __crash_kexec(struct pt_regs *regs)
      |                ^~~~~~~~~~~~~
include/linux/kexec.h:472:20: note: previous definition of '__crash_kexec' =
with type 'void(struct pt_regs *)'
  472 | static inline void __crash_kexec(struct pt_regs *regs) { }
      |                    ^~~~~~~~~~~~~
kernel/crash_core.c: In function '__crash_kexec':
kernel/crash_core.c:114:21: error: 'kexec_crash_image' undeclared (first us=
e in this function); did you mean 'kexec_crash_loaded'?
  114 |                 if (kexec_crash_image) {
      |                     ^~~~~~~~~~~~~~~~~
      |                     kexec_crash_loaded
kernel/crash_core.c:117:25: error: implicit declaration of function 'crash_=
setup_regs' [-Werror=3Dimplicit-function-declaration]
  117 |                         crash_setup_regs(&fixed_regs, regs);
      |                         ^~~~~~~~~~~~~~~~
kernel/crash_core.c:120:25: error: implicit declaration of function 'machin=
e_kexec' [-Werror=3Dimplicit-function-declaration]
  120 |                         machine_kexec(kexec_crash_image);
      |                         ^~~~~~~~~~~~~
kernel/crash_core.c: At top level:
kernel/crash_core.c:128:1: warning: ignoring attribute 'noinline' because i=
t conflicts with attribute 'gnu_inline' [-Wattributes]
  128 | {
      | ^
include/linux/kexec.h:473:20: note: previous declaration here
  473 | static inline void crash_kexec(struct pt_regs *regs) { }
      |                    ^~~~~~~~~~~
kernel/crash_core.c:127:18: error: redefinition of 'crash_kexec'
  127 | __bpf_kfunc void crash_kexec(struct pt_regs *regs)
      |                  ^~~~~~~~~~~
include/linux/kexec.h:473:20: note: previous definition of 'crash_kexec' wi=
th type 'void(struct pt_regs *)'
  473 | static inline void crash_kexec(struct pt_regs *regs) { }
      |                    ^~~~~~~~~~~
kernel/crash_core.c: In function '__crash_shrink_memory':
kernel/crash_core.c:356:9: error: implicit declaration of function 'crash_f=
ree_reserved_phys_range' [-Werror=3Dimplicit-function-declaration]
  356 |         crash_free_reserved_phys_range(ram_res->start, ram_res->end=
);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/crash_core.c: In function 'crash_shrink_memory':
kernel/crash_core.c:370:13: error: 'kexec_crash_image' undeclared (first us=
e in this function); did you mean 'kexec_crash_loaded'?
  370 |         if (kexec_crash_image) {
      |             ^~~~~~~~~~~~~~~~~
      |             kexec_crash_loaded
In file included from include/linux/kernel.h:27,
                 from arch/powerpc/include/asm/page.h:11,
                 from arch/powerpc/include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:60,
                 from arch/powerpc/include/asm/processor.h:41,
                 from include/linux/sched.h:13,
                 from include/linux/utsname.h:6,
                 from kernel/crash_core.c:9:
kernel/crash_core.c:377:38: error: 'KEXEC_CRASH_MEM_ALIGN' undeclared (firs=
t use in this function)
  377 |         new_size =3D roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
      |                                      ^~~~~~~~~~~~~~~~~~~~~
include/linux/math.h:61:16: note: in definition of macro 'roundup'
   61 |         typeof(y) __y =3D y;                              \
      |                ^
kernel/crash_core.c: In function 'crash_save_cpu':
kernel/crash_core.c:437:36: error: 'KEXEC_CORE_NOTE_NAME' undeclared (first=
 use in this function); did you mean 'CRASH_CORE_NOTE_NAME'?
  437 |         buf =3D append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTA=
TUS,
      |                                    ^~~~~~~~~~~~~~~~~~~~
      |                                    CRASH_CORE_NOTE_NAME
kernel/crash_core.c: In function 'kexec_crash_loaded':
kernel/crash_core.c:95:1: error: control reaches end of non-void function [=
-Werror=3Dreturn-type]
   95 | }
      | ^
cc1: some warnings being treated as errors

Caused by commit

  9dc830523e4e ("ppc, crash: enforce KEXEC and KEXEC_FILE to select CRASH_D=
UMP")

I have applied the following patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 25 Jan 2024 14:20:51 +1100
Subject: [PATCH] fix up for "ppc, crash: enforce KEXEC and KEXEC_FILE to
 select CRASH_DUMP"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 31f013e636e3..e7707bebc061 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -610,6 +610,8 @@ config ARCH_SUPPORTS_KEXEC
=20
 config ARCH_SELECTS_KEXEC
 	def_bool y
+	depends on ARCH_SUPPORTS_CRASH_DUMP
+	depends on KEXEC_CORE
 	select CRASH_DUMP
=20
 config ARCH_SUPPORTS_KEXEC_FILE
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/8NWZy_aWMrBmtL5e3YMQfKX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWx1YMACgkQAVBC80lX
0GzgUAf8CMP5QcvOcJG+0ATeF1jayDWKvYN0MKzaK8Xd5B/GW8zOcSnrymdALNW/
xI3ypp3kvMa3GnczsoIAzuI0gomhEZ/I9vPFap0bR+3ktavvc9ZopkOsZKZmKIob
c7usLr11t0h7+5s6j+dMzgU6cGxiFQlpjI2DX5t4nCW59/cYhoZb98l53XEmWxcw
NS4a16HUvdrt7A6H7FxCdJrvZxyxytYzVs8GQFPbIpqOODPju3/x1mBFwhVClEU0
KK7vqprcW4Q8kHQ3nZC+y7ghF5F4W6FskeIm1AW5is2lj/uktThPVdo4Kpn1/kXS
SAVxiOGuupgbvzaATYQA8ZQ4LTgB1A==
=MFVn
-----END PGP SIGNATURE-----

--Sig_/8NWZy_aWMrBmtL5e3YMQfKX--

