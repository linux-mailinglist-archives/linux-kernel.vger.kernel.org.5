Return-Path: <linux-kernel+bounces-155793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8F8AF737
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCF51F24A44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D1140394;
	Tue, 23 Apr 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj/HFcOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345F13E8AC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900127; cv=none; b=T7Ph7b1CuMER2CyPIqoYZLDgIY/vaEkOyFOnrO5NFaLPugBo9QD13I1su+iInfCX72RkKX8soZprsKVpf50/sv7nhKW5a9VD+BLmUfmldcjqVn/L6dOu3dN+2saG++zl3r4vcoPQ+cMmFEYx16En8+U6/6TXb7EKZ1sWB0+iYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900127; c=relaxed/simple;
	bh=nRojG5zGUaFh0RsaOe1nUMGvKH9ztMo4Dj65h9VEDBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMm8xhwibC9hTjtTBQPMkfpFgAt51ArQsTxgoR5OIm8+Wvhuh4mEccfufTD2wzFSSha+hj9XiDqGvqiPO/5LUtTTOkkzKtVpUsYUEr0UfwFbYB/TH5m4P0bsGsUwz78nqUGuTgqoWQKCfHLAcq+bwaBYQ8d5Wo1Iq1todKcJ87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj/HFcOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E99C116B1;
	Tue, 23 Apr 2024 19:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713900126;
	bh=nRojG5zGUaFh0RsaOe1nUMGvKH9ztMo4Dj65h9VEDBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tj/HFcOVWFLcOQT8nnPBYuHEFiM4rnXH+N1nZt8/bubBqTGvJUeH0R3E6y8TcADdI
	 J1UmkntkdoT5oLZ6bRkrbLaRyiuSl5NKiBac6zKcmhSqDOeKiRAA2rCtj03EreWwNL
	 zriCh5eIkrnimLEGNKw1U93v77KubKvsm+2vmRPK0+R7OORC8XyC/2u6Pc+nxf40RC
	 njvoTrL/KYw+fKADEQuPY5YrN5bFO0XYedwTOmty/Ftcc1CaWMGvz/s9geNl5h0Uo5
	 cGZnyYZ7lOuEn+pkPydcGQDGDdezvQbnvlYvTc/QY/f4hdB5MS4yj6B2ExyRc5EhzN
	 M4W53wowIKENw==
Date: Tue, 23 Apr 2024 16:22:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <ZigKWZKY6kq-w0Tp@x1>
References: <ZigEvxn0-70og0H1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZigEvxn0-70og0H1@smile.fi.intel.com>

On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> It seems tons of the code in tools include linux/limits.h. But I haven't found
> where do we copy it. Any pointers?
> 
> Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.

⬢[acme@toolbox perf-tools-next]$ diff -u /usr/include/linux/limits.h include/uapi/linux/limits.h 
--- /usr/include/linux/limits.h	2024-01-31 21:00:00.000000000 -0300
+++ include/uapi/linux/limits.h	2024-02-03 16:18:02.652000641 -0300
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_LIMITS_H
-#define _LINUX_LIMITS_H
+#ifndef _UAPI_LINUX_LIMITS_H
+#define _UAPI_LINUX_LIMITS_H
 
 #define NR_OPEN	        1024
 
⬢[acme@toolbox perf-tools-next]$

And in the places where I test build perf I saw no problem so far, the
build failures below are unrelated, but still outstanding, see below.

But then is for building tools/, not the kernel, right? The discussion
you said this question was based on is about changing
include/linux/xarray.h, a kernel file, so should really be including
just kernel headers, files in the kernel source tree, outside tools/, I
don't see where what tools/ uses to build is relevant here? Can you
please elaborate?

- Arnaldo

   1   113.99 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-20) , clang version 16.0.6 (Red Hat 16.0.6-2.module_el8.9.0+3621+df7f7146) flex 2.6.1
   2    90.56 almalinux:9                   : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 16.0.6 (Red Hat 16.0.6-1.el9) flex 2.6.4
   3    96.32 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1 flex 2.6.4
   4    95.11 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
   5    80.81 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
   6    75.39 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
   7    85.18 alpine:3.19                   : Ok   gcc (Alpine 13.2.1_git20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
   8    86.89 alpine:edge                   : Ok   gcc (Alpine 13.2.1_git20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
   9    60.25 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-17) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2) flex 2.5.37
  10    78.11 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4
  11    77.00 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
  12    96.53 archlinux:base                : Ok   gcc (GCC) 13.2.1 20230801 , clang version 17.0.6 flex 2.6.4
  13    80.73 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-21) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8+767+9fa966b8) flex 2.6.1
  14    76.60 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 13.2.1 20240402 releases/gcc-13.2.0-946-g11f37868bb , clang version 17.0.6 flex 2.6.4
  15    52.34 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1 flex 2.6.4
  16    69.91 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 13.0.1-6~deb11u1 flex 2.6.4
  17    69.93 debian:12                     : Ok   gcc (Debian 12.2.0-14) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
  18    73.52 debian:experimental           : Ok   gcc (Debian 13.2.0-23) 13.2.0 , Debian clang version 16.0.6 (24) flex 2.6.4
  19     4.22 debian:experimental-x-arm64   : FAIL gcc version 13.2.0 (Debian 13.2.0-12) 
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:2:10: fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such file or directory
        2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      CC      /tmp/build/perf/libbpf/staticobjs/zip.o
      CC      /tmp/build/perf/libbpf/staticobjs/elf.o
      CC      /tmp/build/perf/libbpf/staticobjs/features.o
      LD      /tmp/build/perf/libapi/fs/libapi-in.o
    In file included from /git/perf-6.9.0-rc5/tools/include/uapi/linux/bpf_perf_event.h:11,
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:2:10: fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such file or directory
        2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    make[4]: *** [/git/perf-6.9.0-rc5/tools/build/Makefile.build:105: /tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libapi/libapi-in.o
      AR      /tmp/build/perf/libapi/libapi.a
      LD      /tmp/build/perf/libperf/libperf-in.o
  20    13.87 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 12.3.0-6) 12.3.0  flex 2.6.4
  21    14.02 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 12.3.0-6) 12.3.0  flex 2.6.4
  22    14.20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 12.3.0-6) 12.3.0  flex 2.6.4
  23    81.08 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-3) , clang version 13.0.1 (Fedora 13.0.1-1.fc35) flex 2.6.4
  24    80.55 fedora:36                     : Ok   gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4) , clang version 14.0.5 (Fedora 14.0.5-2.fc36) flex 2.6.4
  25    78.80 fedora:37                     : Ok   gcc (GCC) 12.3.1 20230508 (Red Hat 12.3.1-1) , clang version 15.0.7 (Fedora 15.0.7-2.fc37) flex 2.6.4
  26    72.57 fedora:38                     : Ok   gcc (GCC) 13.2.1 20231011 (Red Hat 13.2.1-4) , clang version 16.0.6 (Fedora 16.0.6-4.fc38) flex 2.6.4
  27    67.84 fedora:39                     : Ok   gcc (GCC) 13.2.1 20240316 (Red Hat 13.2.1-7) , clang version 17.0.6 (Fedora 17.0.6-2.fc39) flex 2.6.4
  28    76.14 fedora:40                     : Ok   gcc (GCC) 14.0.1 20240411 (Red Hat 14.0.1-0) , clang version 18.1.1 (Fedora 18.1.1-1.fc40) flex 2.6.4
  29    72.49 fedora:rawhide                : Ok   gcc (GCC) 14.0.1 20240411 (Red Hat 14.0.1-0) , clang version 18.1.3 (Fedora 18.1.3-2.fc41) flex 2.6.4
  30    27.98 gentoo:stage3                 : Ok   gcc (Gentoo 13.2.1_p20240210 p14) 13.2.1 20240210  flex 2.6.4
  31    83.73 manjaro:base                  : Ok   gcc (GCC) 13.2.1 20230801 , clang version 16.0.6 flex 2.6.4
  32    94.35 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
  33    97.90 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
  34    93.92 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 13.2.1 20240206 [revision 67ac78caf31f7cb3202177e6428a46d829b70f23] , clang version 17.0.6 flex 2.6.4
  35    81.04 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-20.0.3) , clang version 16.0.6 (Red Hat 16.0.6-2.0.1.module+el8.9.0+90129+d3ee8717) flex 2.6.1
  36    78.68 oraclelinux:9                 : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2.1.0.1) , clang version 16.0.6 (Red Hat 16.0.6-1.0.1.el9) flex 2.6.4
  37    83.49 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-20) , clang version 16.0.6 (Red Hat 16.0.6-2.module+el8.9.0+1651+e10a8f6d) flex 2.6.1
  38    80.23 rockylinux:9                  : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 16.0.6 (Red Hat 16.0.6-1.el9) flex 2.6.4
  39    23.87 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  40    15.99 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  41     3.33 ubuntu:18.04-x-arm64          : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:2:10: fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      LD      /tmp/build/perf/libapi/libapi-in.o
      AR      /tmp/build/perf/libapi/libapi.a
      LD      /tmp/build/perf/libperf/libperf-in.o
      AR      /tmp/build/perf/libperf/libperf.a
    In file included from /git/perf-6.9.0-rc5/tools/include/uapi/linux/bpf_perf_event.h:11:0,
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:2:10: fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    /git/perf-6.9.0-rc5/tools/build/Makefile.build:105: recipe for target '/tmp/build/perf/libbpf/staticobjs/libbpf.o' failed
    make[4]: *** [/tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
      AR      /tmp/build/perf/libsubcmd/libsubcmd.a
  42    15.36 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  43    15.91 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  44    15.80 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  45     3.36 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal error: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      CC      /tmp/build/perf/libbpf/staticobjs/zip.o
      CC      /tmp/build/perf/libbpf/staticobjs/elf.o
      AR      /tmp/build/perf/libperf/libperf.a
      CC      /tmp/build/perf/libbpf/staticobjs/features.o
    In file included from /git/perf-6.9.0-rc5/tools/include/uapi/linux/bpf_perf_event.h:11:0,
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal error: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    /git/perf-6.9.0-rc5/tools/build/Makefile.build:105: recipe for target '/tmp/build/perf/libbpf/staticobjs/libbpf.o' failed
    make[4]: *** [/tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
      AR      /tmp/build/perf/libsubcmd/libsubcmd.a
  46     3.53 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:6:10: fatal error: ../../arch/s390/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      LD      /tmp/build/perf/libapi/libapi-in.o
      AR      /tmp/build/perf/libapi/libapi.a
      LD      /tmp/build/perf/libperf/libperf-in.o
      AR      /tmp/build/perf/libperf/libperf.a
    In file included from /git/perf-6.9.0-rc5/tools/include/uapi/linux/bpf_perf_event.h:11:0,
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:6:10: fatal error: ../../arch/s390/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    /git/perf-6.9.0-rc5/tools/build/Makefile.build:105: recipe for target '/tmp/build/perf/libbpf/staticobjs/libbpf.o' failed
    make[4]: *** [/tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
      AR      /tmp/build/perf/libsubcmd/libsubcmd.a
  47    15.73 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  48    14.17 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  49    23.06 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0  flex 2.6.4
  50    16.36 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.5.0-1ubuntu1~20.04) 10.5.0  flex 2.6.4
  51   127.69 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0 , Ubuntu clang version 14.0.0-1ubuntu1.1 flex 2.6.4
  52     2.87 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04) 
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal error: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or directory
        8 | #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      CC      /tmp/build/perf/libbpf/staticobjs/features.o
      LD      /tmp/build/perf/libapi/fs/libapi-in.o
      LD      /tmp/build/perf/libapi/libapi-in.o
      AR      /tmp/build/perf/libapi/libapi.a
    In file included from /git/perf-6.9.0-rc5/tools/include/uapi/linux/bpf_perf_event.h:11,
                     from libbpf.c:36:
    /git/perf-6.9.0-rc5/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal error: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or directory
        8 | #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    make[4]: *** [/git/perf-6.9.0-rc5/tools/build/Makefile.build:105: /tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
      AR      /tmp/build/perf/libsubcmd/libsubcmd.a
    make[3]: *** [Makefile:157: /tmp/build/perf/libbpf/staticobjs/libbpf-in.o] Error 2
  53    88.66 ubuntu:23.04                  : Ok   gcc (Ubuntu 12.3.0-1ubuntu1~23.04) 12.3.0 , Ubuntu clang version 15.0.7 flex 2.6.4
  54    75.72 ubuntu:23.10                  : Ok   gcc (Ubuntu 13.2.0-4ubuntu3) 13.2.0 , Ubuntu clang version 16.0.6 (15) flex 2.6.4
  55    78.64 ubuntu:24.04                  : Ok   gcc (Ubuntu 13.2.0-23ubuntu4) 13.2.0 , Ubuntu clang version 18.1.2 (1ubuntu3) flex 2.6.4
BUILD_TARBALL_HEAD=3b8a6dcedaec6def48b3d597f3a8437938c3eaa4
56 3296.82

