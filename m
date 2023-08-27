Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C478A164
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 22:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjH0UeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjH0UeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 16:34:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25C127;
        Sun, 27 Aug 2023 13:34:08 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37RJS4HH024132;
        Sun, 27 Aug 2023 20:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=Oc+rQCz7XmNn3MU7fO2g3kLV1DFoU1jLo3IGX4xZMNY=;
 b=I5aPaqg0vrTvTOy9z+7FTZwDCp65ZIksC2KVsuegVE33IJ8MAj7bKofJvlt8z9wGQMMG
 HPtctljYIMGrJIGWyf32ZMpZxw55t3YzHT8Yv0vd7oZ/OD7pAYSiyno48C2jR8hEPAI8
 gUN87V5UlB1uBYOQcTDsWBtW6XrqKpZXFDNmtwKf1e7MFaOtFQUiwzkLFAoWamQVNlkp
 XqYS2NDpHiWWRQfOlHcMA8JK2mQlAJDX9Z4DcYENQ1/CUTWOuQ7k48/FwfeIp609gSoB
 PMXA+pD3hXtUdjlTLx6PHfa1FkkwdbgFuktq/Tamna/c4ZgG9akBxOngVgoIw7+uFUNX XQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr9j1twcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 20:34:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37RJmHt3009967;
        Sun, 27 Aug 2023 20:34:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7jwety-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 20:34:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37RKY3eZ65077544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Aug 2023 20:34:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C132004F;
        Sun, 27 Aug 2023 20:34:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1948E20067;
        Sun, 27 Aug 2023 20:34:03 +0000 (GMT)
Received: from osiris (unknown [9.171.83.35])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Aug 2023 20:34:03 +0000 (GMT)
Date:   Sun, 27 Aug 2023 22:34:01 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 updates for 6.6 merge window
Message-ID: <20230827203401.5559-B-hca@linux.ibm.com>
References: <20230827203058.5559-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827203058.5559-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v0IslSWZUuDuaxhxD0TsgHfBwmVlyr5A
X-Proofpoint-ORIG-GUID: v0IslSWZUuDuaxhxD0TsgHfBwmVlyr5A
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308270195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 10:31:00PM +0200, Heiko Carstens wrote:
> Hi Linus,
> 
> please pull s390 updates for the 6.6 merge window.
> 
> There will be a merge conflict with Andrew's mm-nonmm-stable tree.
> Since the diff of the merge resolution is quite large I'm going to
> reply to this mail.

Maybe I'm doing something wrong, but below is the rather large diff
of the merge commit, using "git diff HEAD HEAD^@", where HEAD is the
merge commit.

diff --cc arch/s390/Kconfig
index 18bf754e1fad,4d011f7c26e5..42446cbb53e2
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@@ -245,6 -245,25 +246,25 @@@ config PGTABLE_LEVEL
  
  source "kernel/livepatch/Kconfig"
  
+ config ARCH_SUPPORTS_KEXEC
+ 	def_bool y
+ 
+ config ARCH_SUPPORTS_KEXEC_FILE
+ 	def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
+ 
+ config ARCH_SUPPORTS_KEXEC_SIG
+ 	def_bool MODULE_SIG_FORMAT
+ 
+ config ARCH_SUPPORTS_KEXEC_PURGATORY
+ 	def_bool KEXEC_FILE
+ 
+ config ARCH_SUPPORTS_CRASH_DUMP
+ 	def_bool y
+ 	help
 -	  Refer to <file:Documentation/s390/zfcpdump.rst> for more details on this.
++	  Refer to <file:Documentation/arch/s390/zfcpdump.rst> for more details on this.
+ 	  This option also enables s390 zfcpdump.
 -	  See also <file:Documentation/s390/zfcpdump.rst>
++	  See also <file:Documentation/arch/s390/zfcpdump.rst>
+ 
  menu "Processor type and features"
  
  config HAVE_MARCH_Z10_FEATURES
@@@ -483,47 -502,6 +503,17 @@@ config SCHED_TOPOLOG
  
  source "kernel/Kconfig.hz"
  
- config KEXEC
- 	def_bool y
- 	select KEXEC_CORE
- 
- config KEXEC_FILE
- 	bool "kexec file based system call"
- 	select KEXEC_CORE
- 	depends on CRYPTO
- 	depends on CRYPTO_SHA256
- 	depends on CRYPTO_SHA256_S390
- 	help
- 	  Enable the kexec file based system call. In contrast to the normal
- 	  kexec system call this system call takes file descriptors for the
- 	  kernel and initramfs as arguments.
- 
- config ARCH_HAS_KEXEC_PURGATORY
- 	def_bool y
- 	depends on KEXEC_FILE
- 
- config KEXEC_SIG
- 	bool "Verify kernel signature during kexec_file_load() syscall"
- 	depends on KEXEC_FILE && MODULE_SIG_FORMAT
- 	help
- 	  This option makes kernel signature verification mandatory for
- 	  the kexec_file_load() syscall.
- 
- 	  In addition to that option, you need to enable signature
- 	  verification for the corresponding kernel image type being
- 	  loaded in order for this to work.
- 
 +config CERT_STORE
 +	bool "Get user certificates via DIAG320"
 +	depends on KEYS
 +	select CRYPTO_LIB_SHA256
 +	help
 +	  Enable this option if you want to access user-provided secure boot
 +	  certificates via DIAG 0x320.
 +
 +	  These certificates will be made available via the keyring named
 +	  'cert_store'.
 +
  config KERNEL_NOBP
  	def_bool n
  	prompt "Enable modified branch prediction for the kernel by default"
diff --cc kernel/Kconfig.kexec
index 000000000000,9bfe68fe9676..7aff28ded2f4
mode 000000,100644..100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@@ -1,0 -1,150 +1,150 @@@
+ # SPDX-License-Identifier: GPL-2.0-only
+ 
+ menu "Kexec and crash features"
+ 
+ config CRASH_CORE
+ 	bool
+ 
+ config KEXEC_CORE
+ 	select CRASH_CORE
+ 	bool
+ 
+ config KEXEC_ELF
+ 	bool
+ 
+ config HAVE_IMA_KEXEC
+ 	bool
+ 
+ config KEXEC
+ 	bool "Enable kexec system call"
+ 	depends on ARCH_SUPPORTS_KEXEC
+ 	select KEXEC_CORE
+ 	help
+ 	  kexec is a system call that implements the ability to shutdown your
+ 	  current kernel, and to start another kernel. It is like a reboot
+ 	  but it is independent of the system firmware. And like a reboot
+ 	  you can start any kernel with it, not just Linux.
+ 
+ 	  The name comes from the similarity to the exec system call.
+ 
+ 	  It is an ongoing process to be certain the hardware in a machine
+ 	  is properly shutdown, so do not be surprised if this code does not
+ 	  initially work for you. As of this writing the exact hardware
+ 	  interface is strongly in flux, so no good recommendation can be
+ 	  made.
+ 
+ config KEXEC_FILE
+ 	bool "Enable kexec file based system call"
+ 	depends on ARCH_SUPPORTS_KEXEC_FILE
+ 	select KEXEC_CORE
+ 	help
+ 	  This is new version of kexec system call. This system call is
+ 	  file based and takes file descriptors as system call argument
+ 	  for kernel and initramfs as opposed to list of segments as
+ 	  accepted by kexec system call.
+ 
+ config KEXEC_SIG
+ 	bool "Verify kernel signature during kexec_file_load() syscall"
+ 	depends on ARCH_SUPPORTS_KEXEC_SIG
+ 	depends on KEXEC_FILE
+ 	help
+ 	  This option makes the kexec_file_load() syscall check for a valid
+ 	  signature of the kernel image. The image can still be loaded without
+ 	  a valid signature unless you also enable KEXEC_SIG_FORCE, though if
+ 	  there's a signature that we can check, then it must be valid.
+ 
+ 	  In addition to this option, you need to enable signature
+ 	  verification for the corresponding kernel image type being
+ 	  loaded in order for this to work.
+ 
+ config KEXEC_SIG_FORCE
+ 	bool "Require a valid signature in kexec_file_load() syscall"
+ 	depends on ARCH_SUPPORTS_KEXEC_SIG_FORCE
+ 	depends on KEXEC_SIG
+ 	help
+ 	  This option makes kernel signature verification mandatory for
+ 	  the kexec_file_load() syscall.
+ 
+ config KEXEC_IMAGE_VERIFY_SIG
+ 	bool "Enable Image signature verification support (ARM)"
+ 	default ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
+ 	depends on ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
+ 	depends on KEXEC_SIG
+ 	depends on EFI && SIGNED_PE_FILE_VERIFICATION
+ 	help
+ 	  Enable Image signature verification support.
+ 
+ config KEXEC_BZIMAGE_VERIFY_SIG
+ 	bool "Enable bzImage signature verification support"
+ 	depends on ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG
+ 	depends on KEXEC_SIG
+ 	depends on SIGNED_PE_FILE_VERIFICATION
+ 	select SYSTEM_TRUSTED_KEYRING
+ 	help
+ 	  Enable bzImage signature verification support.
+ 
+ config KEXEC_JUMP
+ 	bool "kexec jump"
+ 	depends on ARCH_SUPPORTS_KEXEC_JUMP
+ 	depends on KEXEC && HIBERNATION
+ 	help
+ 	  Jump between original kernel and kexeced kernel and invoke
+ 	  code in physical address mode via KEXEC
+ 
+ config CRASH_DUMP
+ 	bool "kernel crash dumps"
+ 	depends on ARCH_SUPPORTS_CRASH_DUMP
+ 	depends on ARCH_SUPPORTS_KEXEC
+ 	select CRASH_CORE
+ 	select KEXEC_CORE
+ 	select KEXEC
+ 	help
+ 	  Generate crash dump after being started by kexec.
+ 	  This should be normally only set in special crash dump kernels
+ 	  which are loaded in the main kernel with kexec-tools into
+ 	  a specially reserved region and then later executed after
+ 	  a crash by kdump/kexec. The crash dump kernel must be compiled
+ 	  to a memory address not used by the main kernel or BIOS using
+ 	  PHYSICAL_START, or it must be built as a relocatable image
+ 	  (CONFIG_RELOCATABLE=y).
+ 	  For more details see Documentation/admin-guide/kdump/kdump.rst
+ 
+ 	  For s390, this option also enables zfcpdump.
 -	  See also <file:Documentation/s390/zfcpdump.rst>
++	  See also <file:Documentation/arch/s390/zfcpdump.rst>
+ 
+ config CRASH_HOTPLUG
+ 	bool "Update the crash elfcorehdr on system configuration changes"
+ 	default y
+ 	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+ 	depends on ARCH_SUPPORTS_CRASH_HOTPLUG
+ 	help
+ 	  Enable direct update to the crash elfcorehdr (which contains
+ 	  the list of CPUs and memory regions to be dumped upon a crash)
+ 	  in response to hot plug/unplug or online/offline of CPUs or
+ 	  memory. This is a much more advanced approach than userspace
+ 	  attempting that.
+ 
+ 	  If unsure, say Y.
+ 
+ config CRASH_MAX_MEMORY_RANGES
+ 	int "Specify the maximum number of memory regions for the elfcorehdr"
+ 	default 8192
+ 	depends on CRASH_HOTPLUG
+ 	help
+ 	  For the kexec_file_load() syscall path, specify the maximum number of
+ 	  memory regions that the elfcorehdr buffer/segment can accommodate.
+ 	  These regions are obtained via walk_system_ram_res(); eg. the
+ 	  'System RAM' entries in /proc/iomem.
+ 	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+ 	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ 	  segment size.
+ 	  The value 8192, for example, covers a (sparsely populated) 1TiB system
+ 	  consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ 	  memory buffer/segment size under 1MiB. This represents a sane choice
+ 	  to accommodate both baremetal and virtual machine configurations.
+ 
+ 	  For the kexec_load() syscall path, CRASH_MAX_MEMORY_RANGES is part of
+ 	  the computation behind the value provided through the
+ 	  /sys/kernel/crash_elfcorehdr_size attribute.
+ 
+ endmenu
