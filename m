Return-Path: <linux-kernel+bounces-98723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88794877E64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0491C20B23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324CE37169;
	Mon, 11 Mar 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tgEO08wz"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3C34CD7;
	Mon, 11 Mar 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154318; cv=none; b=EjO3Q87NPoBcBeeWAGtBhNk2f2sEzwXL999vJpMX6M68vYIMgXwJdDfl3IM9ipLfoKm7dUZ6s89JgFA5/OcIm96L7IU6Uj0XIAZB1cyfVhVujn6fhNzhrZK4e6ahlp2fEdFRbgHNZjiapTTrDsXzoPxTudAvgghL/DKAq6pMP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154318; c=relaxed/simple;
	bh=eBsclcRK+ONg+KlYT4kcvwih3VR44UjQirQ7oNwf19Q=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bV2cmxQ9ZCN6Dz8bku7jRpmIF9ceAJemspEAzWkYz6UbIFrDMwmlTm9ZDPjPFyx5hkvkcx2Y1+6DECidGYcI0J8b9tBX2+VQOFUw63OcxsRf9PQAVsFavmU0cjzubSIbzobbiMCMgI4wD3OXBwnpdyrHKdllMwRlMPg39+xFqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tgEO08wz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B7S7QM007074;
	Mon, 11 Mar 2024 10:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=1a3YkhQ095kKIgSVl61Fm1izFMkUZTqf/5ycVV9Hs84=;
 b=tgEO08wzrKFQ4v0lghk3s6lFgwuXXSHMpYvjQxHjdTAM1MEJSvVrskO1UMZ06nucHFd3
 KIHZeQB2fH/KTp75R2xOPQZiqZHZ1TwOY57y9MEMLuFpiBxBZiPUtYiRqRljovqebvnk
 0ZoJh/rX96QXst/ecWzDP0MMM3EDtNjh0woviT7E8qsUo+BwRrwLR6VUqDMMrdYWY97x
 yaJG7HhmXE5KKCvObw3gGUU5SKBtqQdJe5x7G8KDLee5u3xlrKi/vq3+xqmSaTzpQbCb
 8zQKnAFeMXFz6gGY86pt2TQAQ53eg8OvYHYy/x/SRcNKkwLqyQ58wvIVZvXH4kOQwwyW Rg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wswkau77b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 10:51:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42B8bY2R013543;
	Mon, 11 Mar 2024 10:51:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4ajyn2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 10:51:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BApmmX13828356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 10:51:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 653E620043;
	Mon, 11 Mar 2024 10:51:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAB8A20040;
	Mon, 11 Mar 2024 10:51:47 +0000 (GMT)
Received: from osiris (unknown [9.171.68.15])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 Mar 2024 10:51:47 +0000 (GMT)
Date: Mon, 11 Mar 2024 11:51:46 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.9 merge window
Message-ID: <20240311105146.20399-B-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sNQKfoZdwWIrpUNKlb4iS-P-oFEcR-1Q
X-Proofpoint-GUID: sNQKfoZdwWIrpUNKlb4iS-P-oFEcR-1Q
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110079

Hi Linus,

please pull s390 updates for the 6.9 merge window.

Thanks,
Heiko

The following changes since commit 124468af7e769a52d27c3290007ac6e2ba346ccd:

  s390/configs: update default configurations (2024-02-09 13:57:29 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-1

for you to fetch changes up to fa9e3139e6c5ac756e1ab2a6c7eca99eb684a2fe:

  s390/tools: handle rela R_390_GOTPCDBL/R_390_GOTOFF64 (2024-03-07 17:02:05 +0100)

----------------------------------------------------------------
s390 updates for 6.9 merge window

- Various virtual vs physical address usage fixes

- Fix error handling in Processor Activity Instrumentation device driver, and
  export number of counters with a sysfs file

- Allow for multiple events when Processor Activity Instrumentation counters
  are monitored in system wide sampling

- Change multiplier and shift values of the Time-of-Day clock source to improve
  steering precision

- Remove a couple of unneeded GFP_DMA flags from allocations

- Disable mmap alignment if randomize_va_space is also disabled, to avoid a too
  small heap

- Various changes to allow s390 to be compiled with LLVM=1, since ld.lld and
  llvm-objcopy will have proper s390 support witch clang 19

- Add __uninitialized macro to Compiler Attributes. This is helpful with s390's
  FPU code where some users have up to 520 byte stack frames. Clearing such
  stack frames (if INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO is enabled)
  before they are used contradicts the intention (performance improvement) of
  such code sections.

- Convert switch_to() to an out-of-line function, and use the generic switch_to
  header file

- Replace the usage of s390's debug feature with pr_debug() calls within the
  zcrypt device driver

- Improve hotplug support of the Adjunct Processor device driver

- Improve retry handling in the zcrypt device driver

- Various changes to the in-kernel FPU code:

  - Make in-kernel FPU sections preemptible

  - Convert various larger inline assemblies and assembler files to C, mainly
    by using singe instruction inline assemblies. This increases readability,
    but also allows makes it easier to add proper instrumentation hooks

  - Cleanup of the header files

- Provide fast variants of csum_partial() and csum_partial_copy_nocheck() based
  on vector instructions

- Introduce and use a lock to synchronize accesses to zpci device data
  structures to avoid inconsistent states caused by concurrent accesses

- Compile the kernel without -fPIE. This addresses the following problems if
  the kernel is compiled with -fPIE:

  - It uses dynamic symbols (.dynsym), for which the linker refuses to allow
    more than 64k sections. This can break features which use
    '-ffunction-sections' and '-fdata-sections', including kpatch-build and
    function granular KASLR

  - It unnecessarily uses GOT relocations, adding an extra layer of indirection
    for many memory accesses

- Fix shared_cpu_list for CPU private L2 caches, which incorrectly were
  reported as globally shared

----------------------------------------------------------------
Alexander Gordeev (7):
      s390/diag: fix diag26c() physical vs virtual address confusion
      s390/extmem: fix virtual vs physical address confusion
      s390/boot: simplify GOT handling
      s390/boot: sanitize kaslr_adjust_relocs() function prototype
      s390/boot: make type of __vmlinux_relocs_64_start|end consistent
      s390/boot: do not check for zero-termination relocation entry
      s390/boot: fix minor comment style damages

Eric Farman (2):
      KVM: s390: fix access register usage in ioctls
      KVM: s390: selftests: memop: add a simple AR test

Gerald Schaefer (2):
      s390/appldata: fix virtual vs physical address confusion
      s390/setup: fix virtual vs physical address confusion

Gerd Bayer (4):
      s390/pci: rename lock member in struct zpci_dev
      s390/pci: introduce lock to synchronize state of zpci_dev's
      s390/pci: remove hotplug slot when releasing the device
      s390/pci: fix three typos in comments

Harald Freudenberger (14):
      s390/zcrypt: harmonize debug feature calls and defines
      s390/zcrypt: introduce dynamic debugging for AP and zcrypt code
      s390/pkey: harmonize pkey s390 debug feature calls
      s390/pkey: introduce dynamic debugging for pkey
      s390/ap: add debug possibility for AP messages
      s390/zcrypt: add debug possibility for CCA and EP11 messages
      s390/ap: rearm APQNs bindings complete completion
      s390/ap: clarify AP scan bus related functions and variables
      s390/ap: rework ap_scan_bus() to return true on config change
      s390/ap: introduce mutex to lock the AP bus scan
      s390/zcrypt: introduce retries on in-kernel send CPRB functions
      s390/zcrypt: improve zcrypt retry behavior
      s390/pkey: improve pkey retry behavior
      s390/crypto: remove retry loop with sleep from PAES pkey invocation

Heiko Carstens (46):
      s390/hypfs_sprp: fix virtual vs physical address confusion
      s390/hypfs_diag0c: fix virtual vs physical address confusion
      s390/hypfs_sprp: remove unneeded DMA zone allocation
      s390/cmf: remove unneeded DMA zone allocation
      s390/cmf: fix virtual vs physical address confusion
      Compiler Attributes: Add __uninitialized macro
      s390/fpu: make use of __uninitialized macro
      s390/acrs: cleanup access register handling
      s390/switch_to: use generic header file
      s390/bug: remove entry size from __bug_table section
      s390/vdso: remove unused ENTRY in linker scripts
      s390/fpu: fix VLGV macro
      s390/fpu: improve description of RXB macro
      s390/nmi: remove register validation code
      s390/fpu: use KERNEL_VXR_LOW instead of KERNEL_VXR_V0V7
      s390/fpu: various coding style changes
      s390/fpu: move, rename, and merge header files
      s390/fpu: add documentation about fpu helper functions
      s390/fpu: use lfpc instead of sfpc instruction
      s390/fpu: provide and use ld and std inline assemblies
      s390/fpu: provide and use lfpc, sfpc, and stfpc inline assemblies
      s390/fpu: provide and use vlm and vstm inline assemblies
      s390/fpu: convert __kernel_fpu_begin()/__kernel_fpu_end() to C
      s390/fpu: convert FPU CIF flag to regular TIF flag
      s390/fpu: rename save_fpu_regs() to save_user_fpu_regs(), etc
      s390/fpu: change type of fpu mask from u32 to int
      s390/fpu: make kernel fpu context preemptible
      s390/kvm: convert to regular kernel fpu user
      s390/fpu: remove regs member from struct fpu
      s390/fpu: remove anonymous union from struct fpu
      s390/fpu: let fpu_vlm() and fpu_vstm() return number of registers
      s390/fpu: decrease stack usage for some cases
      s390/fpu: limit save and restore to used registers
      s390/fpu: remove TIF_FPU
      s390/checksum: call instrument_read() instead of kasan_check_read()
      s390/checksum: provide and use cksm() inline assembly
      s390/checksum: provide vector register variant of csum_partial()
      s390/checksum: provide csum_partial_copy_nocheck()
      s390/raid6: convert to use standard fpu_*() inline assemblies
      s390/sysinfo: convert bogomips calculation to C
      s390/fpu: add vector instruction inline assemblies for crc32
      s390/crc32be: convert to C
      s390/crc32le: convert to C
      s390: vmlinux.lds.S: fix .got.plt assertion
      s390/configs: increase number of LOCKDEP_BITS
      s390/cache: prevent rebuild of shared_cpu_list

Holger Dengler (1):
      s390/ap: explicitly include ultravisor header

Janosch Frank (1):
      KVM: s390: introduce kvm_s390_fpu_(store|load)

Jason J. Herne (1):
      s390/vfio-ap: handle hardware checkstop state on queue reset operation

Josh Poimboeuf (2):
      s390: add relocs tool
      s390: compile relocatable kernel without -fPIE

Nathan Chancellor (15):
      s390/vdso: drop '-fPIC' from LDFLAGS
      s390/boot: add support for CONFIG_LD_ORPHAN_WARN
      s390: vmlinux.lds.S: handle '.data.rel' sections explicitly
      s390: vmlinux.lds.S: explicitly handle '.got' and '.plt' sections
      s390: vmlinux.lds.S: explicitly keep various sections
      s390/boot: vmlinux.lds.S: handle '.init.text'
      s390/boot: vmlinux.lds.S: handle '.rela' sections
      s390/boot: vmlinux.lds.S: handle DWARF debug sections
      s390/boot: vmlinux.lds.S: handle ELF required sections
      s390/boot: vmlinux.lds.S: handle commonly discarded sections
      s390: select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
      s390: link vmlinux with '-z notext'
      s390: don't allow CONFIG_COMPAT with LD=ld.lld
      s390/boot: add 'alloc' to info.bin .vmlinux.info section flags
      s390/boot: workaround current 'llvm-objdump -t -j ...' behavior

Peter Oberparleiter (1):
      s390/cio: remove unneeded DMA zone allocation

Ricardo B. Marliere (7):
      s390/time: make stp_subsys const
      s390/ccwgroup: make ccwgroup_bus_type const
      s390/cio: make css_bus_type const
      s390/cio: make ccw_bus_type const
      s390/cio: make scm_bus_type const
      s390/ap: make ap_bus_type const
      s390/vfio-ap: make matrix_bus const

Sumanth Korikkar (2):
      s390/vdso64: filter out munaligned-symbols flag for vdso
      s390/tools: handle rela R_390_GOTPCDBL/R_390_GOTOFF64

Sven Schnelle (2):
      s390/time: improve steering precision
      s390/mmap: disable mmap alignment when randomize_va_space = 0

Thomas Richter (10):
      s390/pai: fix attr_event_free upper limit for pai device drivers
      s390/pai_crypto: emit error on too many counters
      s390/pai: export number of sysfs attribute files
      s390/pai_crypto: return proper error code in paicrypt_init
      s390/vmur: fix virtual vs physical address confusion
      s390/diag: add missing virt_to_phys() translation to diag14()
      s390/pai: save PAI counter value page in event structure
      s390/pai: simplify event start function for perf stat
      s390/pai: adjust whitespace indentation
      s390/pai: change sampling event assignment for PMU device driver

 arch/s390/Kconfig                                  |  18 +-
 arch/s390/Makefile                                 |  10 +-
 arch/s390/boot/.gitignore                          |   1 +
 arch/s390/boot/Makefile                            |  25 +-
 arch/s390/boot/boot.h                              |   6 +
 arch/s390/boot/startup.c                           |  75 +++-
 arch/s390/boot/vmlinux.lds.S                       |  48 ++
 arch/s390/configs/debug_defconfig                  |   2 +
 arch/s390/crypto/chacha-glue.c                     |   4 +-
 arch/s390/crypto/chacha-s390.S                     |   2 +-
 arch/s390/crypto/crc32-vx.c                        |  11 +-
 arch/s390/crypto/crc32-vx.h                        |  12 +
 arch/s390/crypto/{crc32be-vx.S => crc32be-vx.c}    | 171 +++-----
 arch/s390/crypto/{crc32le-vx.S => crc32le-vx.c}    | 239 +++++-----
 arch/s390/crypto/paes_s390.c                       |  16 +-
 arch/s390/hypfs/hypfs_diag0c.c                     |   3 +-
 arch/s390/hypfs/hypfs_sprp.c                       |   4 +-
 arch/s390/include/asm/access-regs.h                |  38 ++
 arch/s390/include/asm/appldata.h                   |   4 +-
 arch/s390/include/asm/asm-prototypes.h             |   2 +-
 arch/s390/include/asm/bug.h                        |   4 +-
 arch/s390/include/asm/checksum.h                   |  29 +-
 arch/s390/include/asm/diag.h                       |  15 +-
 arch/s390/include/asm/entry-common.h               |   5 +-
 .../include/asm/{vx-insn-asm.h => fpu-insn-asm.h}  |  71 ++-
 arch/s390/include/asm/fpu-insn.h                   | 486 +++++++++++++++++++++
 arch/s390/include/asm/fpu-types.h                  |  51 +++
 arch/s390/include/asm/fpu.h                        | 295 +++++++++++++
 arch/s390/include/asm/fpu/api.h                    | 126 ------
 arch/s390/include/asm/fpu/internal.h               |  67 ---
 arch/s390/include/asm/fpu/types.h                  |  38 --
 arch/s390/include/asm/kvm_host.h                   |   5 +-
 arch/s390/include/asm/lowcore.h                    |   2 +-
 arch/s390/include/asm/pai.h                        |   3 +-
 arch/s390/include/asm/pci.h                        |   3 +-
 arch/s390/include/asm/physmem_info.h               |   1 +
 arch/s390/include/asm/processor.h                  |  11 +-
 arch/s390/include/asm/ptrace.h                     |   4 +
 arch/s390/include/asm/stacktrace.h                 |   1 -
 arch/s390/include/asm/switch_to.h                  |  49 ---
 arch/s390/include/asm/vx-insn.h                    |  19 -
 arch/s390/kernel/cache.c                           |   1 +
 arch/s390/kernel/compat_signal.c                   |  22 +-
 arch/s390/kernel/crash_dump.c                      |   2 +-
 arch/s390/kernel/diag.c                            |  31 +-
 arch/s390/kernel/early.c                           |   3 +-
 arch/s390/kernel/entry.S                           |  19 +-
 arch/s390/kernel/entry.h                           |   1 +
 arch/s390/kernel/fpu.c                             | 380 +++++++---------
 arch/s390/kernel/ipl.c                             |   3 +-
 arch/s390/kernel/machine_kexec.c                   |   3 +-
 arch/s390/kernel/nmi.c                             | 168 ++-----
 arch/s390/kernel/os_info.c                         |   6 +-
 arch/s390/kernel/perf_pai_crypto.c                 |  83 ++--
 arch/s390/kernel/perf_pai_ext.c                    |  52 ++-
 arch/s390/kernel/perf_regs.c                       |  10 +-
 arch/s390/kernel/process.c                         |  31 +-
 arch/s390/kernel/ptrace.c                          | 101 ++---
 arch/s390/kernel/setup.c                           |  12 +-
 arch/s390/kernel/signal.c                          |  20 +-
 arch/s390/kernel/smp.c                             |   3 +-
 arch/s390/kernel/sysinfo.c                         |  27 +-
 arch/s390/kernel/text_amode31.S                    |   2 +-
 arch/s390/kernel/time.c                            |   6 +-
 arch/s390/kernel/traps.c                           |  12 +-
 arch/s390/kernel/uprobes.c                         |   1 -
 arch/s390/kernel/vdso32/Makefile                   |   2 +-
 arch/s390/kernel/vdso32/vdso32.lds.S               |   1 -
 arch/s390/kernel/vdso64/Makefile                   |   3 +-
 arch/s390/kernel/vdso64/vdso64.lds.S               |   1 -
 arch/s390/kernel/vmlinux.lds.S                     |  54 +++
 arch/s390/kvm/gaccess.c                            |   5 +-
 arch/s390/kvm/interrupt.c                          |   6 +-
 arch/s390/kvm/kvm-s390.c                           |  33 +-
 arch/s390/kvm/kvm-s390.h                           |  18 +
 arch/s390/kvm/vsie.c                               |   3 -
 arch/s390/lib/Makefile                             |   1 +
 arch/s390/lib/csum-partial.c                       |  91 ++++
 arch/s390/mm/extmem.c                              |   4 +-
 arch/s390/mm/mmap.c                                |  19 +-
 arch/s390/pci/pci.c                                |  20 +-
 arch/s390/pci/pci_debug.c                          |  10 +-
 arch/s390/pci/pci_event.c                          |  15 +-
 arch/s390/pci/pci_sysfs.c                          |  70 +--
 arch/s390/tools/.gitignore                         |   1 +
 arch/s390/tools/Makefile                           |   5 +
 arch/s390/tools/relocs.c                           | 387 ++++++++++++++++
 drivers/pci/hotplug/s390_pci_hpc.c                 |  65 ++-
 drivers/s390/char/vmur.c                           |   4 +-
 drivers/s390/char/zcore.c                          |   1 -
 drivers/s390/cio/ccwgroup.c                        |   4 +-
 drivers/s390/cio/chsc.c                            |   4 +-
 drivers/s390/cio/chsc_sch.c                        |  20 +-
 drivers/s390/cio/cmf.c                             |   6 +-
 drivers/s390/cio/css.c                             |   4 +-
 drivers/s390/cio/device.c                          |   4 +-
 drivers/s390/cio/scm.c                             |   4 +-
 drivers/s390/crypto/ap_bus.c                       | 259 ++++++++---
 drivers/s390/crypto/ap_bus.h                       |   8 +-
 drivers/s390/crypto/ap_debug.h                     |   4 +-
 drivers/s390/crypto/ap_queue.c                     |  31 +-
 drivers/s390/crypto/pkey_api.c                     | 226 +++++-----
 drivers/s390/crypto/vfio_ap_drv.c                  |   2 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |  35 +-
 drivers/s390/crypto/zcrypt_api.c                   | 226 +++++-----
 drivers/s390/crypto/zcrypt_api.h                   |   9 +
 drivers/s390/crypto/zcrypt_ccamisc.c               | 214 ++++-----
 drivers/s390/crypto/zcrypt_debug.h                 |   4 +-
 drivers/s390/crypto/zcrypt_ep11misc.c              | 127 +++---
 drivers/s390/crypto/zcrypt_error.h                 |   5 +-
 drivers/s390/crypto/zcrypt_msgtype50.c             |  14 +-
 drivers/s390/crypto/zcrypt_msgtype6.c              |  45 +-
 include/linux/compiler_attributes.h                |  12 +
 lib/raid6/s390vx.uc                                |  62 +--
 tools/testing/selftests/kvm/s390x/memop.c          |  31 ++
 115 files changed, 3242 insertions(+), 1912 deletions(-)
 create mode 100644 arch/s390/crypto/crc32-vx.h
 rename arch/s390/crypto/{crc32be-vx.S => crc32be-vx.c} (56%)
 rename arch/s390/crypto/{crc32le-vx.S => crc32le-vx.c} (52%)
 create mode 100644 arch/s390/include/asm/access-regs.h
 rename arch/s390/include/asm/{vx-insn-asm.h => fpu-insn-asm.h} (86%)
 create mode 100644 arch/s390/include/asm/fpu-insn.h
 create mode 100644 arch/s390/include/asm/fpu-types.h
 create mode 100644 arch/s390/include/asm/fpu.h
 delete mode 100644 arch/s390/include/asm/fpu/api.h
 delete mode 100644 arch/s390/include/asm/fpu/internal.h
 delete mode 100644 arch/s390/include/asm/fpu/types.h
 delete mode 100644 arch/s390/include/asm/switch_to.h
 delete mode 100644 arch/s390/include/asm/vx-insn.h
 create mode 100644 arch/s390/lib/csum-partial.c
 create mode 100644 arch/s390/tools/relocs.c

