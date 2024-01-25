Return-Path: <linux-kernel+bounces-39379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102183CFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ED71F23D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE01F125CF;
	Thu, 25 Jan 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/k5uY+I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59B111B5;
	Thu, 25 Jan 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223361; cv=none; b=UqO2GpD01VDcP5SP6ZPSLfIBxJJG5BaMqrtYarPYF5xRcu0+kaYTclovkd1vJBcdLhGhZpDWp/Pwdrv2Z81ljxPggKOgYhRyNPiXf+yzeM0vbjy7DwqCPvK+gHkcXHGCmOmuCKPtsVgx7rTbQrPtwA5HGl6zjKKkVa0e009dA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223361; c=relaxed/simple;
	bh=Bx1oIdTdd86nzue6xvhtwCp4wPQwGjG0ILCqZqgINO8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kSoRrWNmQfWh/h89qFtjQSj8aiImRxfwfyajmwe5wCWMDa1tOuW6DkSAzQrYBwivV9HOoBIsML57mxHToLNm2jZwFych6HuDBorQ1OBKwOeJ418DA9LTuHvcKZfVOAuzxrPUr8iqgKAtXZIjvMwV52Dbe+16MAkBcPtkgPkmvsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/k5uY+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DA3C433F1;
	Thu, 25 Jan 2024 22:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223360;
	bh=Bx1oIdTdd86nzue6xvhtwCp4wPQwGjG0ILCqZqgINO8=;
	h=From:Subject:Date:To:Cc:From;
	b=u/k5uY+I+ALGKvsZhJOKy+elEEMTuGK4js+9E2aa8C+jdW7zCUmcFB09uzv+3CoZu
	 FWBWHBaHi7qqt5eN22oRGai4acZwbSD7+wTeYGd4bp/1BTWPKdzypKh5/upZuxCBTI
	 DwwCb0OmIwH8ErHvyqJ9tF2AwVh/f9Tc6jYY5uvefvVeofbszLGkSgD9Psw/Y/fOqO
	 4JubQhTEYhKN/h+N4+luvLNiDNT38sywwwjB3NkWClFOXDzTsmqYGb6NEb82khEZvP
	 LyqTCcJ5Mv1GCoc5ko76xtnLjFlNccOpbLWrEyB9x/zp7+IcLe5lDiJ5iq6cetYBpb
	 6LFQ6NVeleKSA==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 00/11] Bump the minimum supported version of LLVM to 13.0.1
Date: Thu, 25 Jan 2024 15:55:06 -0700
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrmsmUC/x3MQQqDMBAF0KvIrPshkwSpvUrpojajHTBREhsK4
 t0bunybd1CRrFLo1h2UpWrRNTXwpaPX+5lmgYZmssZ6w9Zj/MQNUROWpUZUydhXsIMBww3T1Yf
 g+pEHasOWZdLvf78/zvMHzVeZdG0AAAA=
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, tglx@linutronix.de, mingo@redhat.com, 
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
 linux@armlinux.org.uk, ardb@kernel.org, 
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, 
 will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au, 
 npiggin@gmail.com, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, 
 linuxppc-dev@lists.ozlabs.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
 aou@eecs.berkeley.edu, conor@kernel.org, linux-riscv@lists.infradead.org, 
 keescook@chromium.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5041; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Bx1oIdTdd86nzue6xvhtwCp4wPQwGjG0ILCqZqgINO8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv0VWied95P5q0eXfkzlxrZNofbTU+K5bbiVjef9U
 LF9Lp/YUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACbyoJSRYdfLJeuavmdyeR6u
 +xn7PM6bZ9E7RT/WZzFKl4VUYs0DHjEyPAwMYX+6+56b/awFIlsKOvdcOn9vr4jAiuMznF5/qmc
 T5wMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

This series bumps the minimum supported version of LLVM for building the
kernel to 13.0.1. The first patch does the bump and all subsequent
patches clean up all the various workarounds and checks for earlier
versions.

Quoting the first patch's commit message for those that were only on CC
for the clean ups:

  When __builtin_mul_overflow() has arguments that differ in terms of
  signedness and width, LLVM may generate a libcall to __muloti4 because
  it performs the checks in terms of 65-bit multiplication. This issue
  becomes harder to hit (but still possible) after LLVM 12.0.0, which
  includes a special case for matching widths but different signs.

  To gain access to this special case, which the kernel can take advantage
  of when calls to __muloti4 appear, bump the minimum supported version of
  LLVM for building the kernel to 13.0.1. 13.0.1 was chosen because there
  is minimal impact to distribution support while allowing a few more
  workarounds to be dropped in the kernel source than if 12.0.0 were
  chosen. Looking at container images of up to date distribution versions:

    archlinux:latest              clang version 16.0.6
    debian:oldoldstable-slim      clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
    debian:oldstable-slim         Debian clang version 11.0.1-2
    debian:stable-slim            Debian clang version 14.0.6
    debian:testing-slim           Debian clang version 16.0.6 (19)
    debian:unstable-slim          Debian clang version 16.0.6 (19)
    fedora:38                     clang version 16.0.6 (Fedora 16.0.6-3.fc38)
    fedora:latest                 clang version 17.0.6 (Fedora 17.0.6-1.fc39)
    fedora:rawhide                clang version 17.0.6 (Fedora 17.0.6-1.fc40)
    opensuse/leap:latest          clang version 15.0.7
    opensuse/tumbleweed:latest    clang version 17.0.6
    ubuntu:focal                  clang version 10.0.0-4ubuntu1
    ubuntu:latest                 Ubuntu clang version 14.0.0-1ubuntu1.1
    ubuntu:rolling                Ubuntu clang version 16.0.6 (15)
    ubuntu:devel                  Ubuntu clang version 17.0.6 (3)

  The only distribution that gets left behind is Debian Bullseye, as the
  default version is 11.0.1; other distributions either have a newer
  version than 13.0.1 or one older than the current minimum of 11.0.0.
  Debian has easy access to more recent LLVM versions through
  apt.llvm.org, so this is not as much of a concern. There are also the
  kernel.org LLVM toolchains, which should work with distributions with
  glibc 2.28 and newer.

  Another benefit of slimming up the number of supported versions of LLVM
  for building the kernel is reducing the build capacity needed to support
  a matrix that builds with each supported version, which allows a matrix
  to reallocate the freed up build capacity towards something else, such
  as more configuration combinations.

This passes my build matrix with all supported versions.

This is based on Andrew's mm-nonmm-unstable to avoid trivial conflicts
with my series to update the LLVM links across the repository [1] but I
can easily rebase it to linux-kbuild if Masahiro would rather these
patches go through there (and defer the conflict resolution to the merge
window).

[1]: https://lore.kernel.org/20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org/

---
Nathan Chancellor (11):
      kbuild: Raise the minimum supported version of LLVM to 13.0.1
      Makefile: Drop warn-stack-size plugin opt
      x86: Drop stack-alignment plugin opt
      ARM: Remove Thumb2 __builtin_thread_pointer workaround for Clang
      arm64: Kconfig: Clean up tautological LLVM version checks
      powerpc: Kconfig: Remove tautology in CONFIG_COMPAT
      riscv: Remove MCOUNT_NAME workaround
      riscv: Kconfig: Remove version dependency from CONFIG_CLANG_SUPPORTS_DYNAMIC_FTRACE
      fortify: Drop Clang version check for 12.0.1 or newer
      lib/Kconfig.debug: Update Clang version check in CONFIG_KCOV
      compiler-clang.h: Update __diag_clang() macros for minimum version bump

 Documentation/process/changes.rst |  2 +-
 Makefile                          |  8 --------
 arch/arm/include/asm/current.h    |  8 +-------
 arch/arm64/Kconfig                |  5 +----
 arch/powerpc/Kconfig              |  1 -
 arch/riscv/Kconfig                |  2 --
 arch/riscv/include/asm/ftrace.h   | 14 ++------------
 arch/riscv/kernel/mcount.S        | 10 +++++-----
 arch/x86/Makefile                 |  6 ------
 include/linux/compiler-clang.h    |  8 ++------
 lib/Kconfig.debug                 |  2 +-
 scripts/min-tool-version.sh       |  2 +-
 scripts/recordmcount.pl           |  2 +-
 security/Kconfig                  |  2 --
 14 files changed, 15 insertions(+), 57 deletions(-)
---
base-commit: 979741ebd48f75ed6d101c7290e3325340d361ff
change-id: 20240124-bump-min-llvm-ver-to-13-0-1-39f84dd36b19

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


