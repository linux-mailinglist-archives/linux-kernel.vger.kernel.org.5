Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCC678A162
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 22:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjH0Ube (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjH0UbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 16:31:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB4127;
        Sun, 27 Aug 2023 13:31:06 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37RKPe0V006667;
        Sun, 27 Aug 2023 20:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=0WomOenKpB4/f0cAoMXF2cdk3llLo5bkHcu0+/Ay5og=;
 b=aBZ0+VyyW+RBPHT9OSeHZSv1QliDwFeqgRX/DYGKyXZjNn1MaUd1YFq1Q0gYkt3XmfaU
 BwzWYM8huLdUOPnF2X3gVYKctQ/OZOCQTWQwFY7S9yBhOHu3JjEi96Ef9VFJml0GsBzw
 Wx8g8SJVjWieaYQ1kO3b+w61GpWQyWiTQ5/Hwmk7sqqM25mxQeAd94upM3jOpRQ+gZUa
 Q4E+cJXsXxw/iuzL4+rHd//wEooHKWKfF6WJ8K/8xrXx/ZRTkC25TEcM0e6tiw1kMot0
 0s6DME7Yz9cTwnPrSdJGk2jd0sNHGJ3Cd8NmW17J2DO6VdBsnB1Pbs6JpQQHgquzeVLD Qg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr87gbssk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 20:31:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37RI9nlC019181;
        Sun, 27 Aug 2023 20:31:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe15139-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 20:31:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37RKV0Sn41484884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Aug 2023 20:31:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B18320043;
        Sun, 27 Aug 2023 20:31:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3452920040;
        Sun, 27 Aug 2023 20:31:00 +0000 (GMT)
Received: from osiris (unknown [9.171.83.35])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Aug 2023 20:31:00 +0000 (GMT)
Date:   Sun, 27 Aug 2023 22:30:58 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.6 merge window
Message-ID: <20230827203058.5559-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qbWoURHyKW3lTIo7sdNvLLBSfqP_2roG
X-Proofpoint-GUID: qbWoURHyKW3lTIo7sdNvLLBSfqP_2roG
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_18,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308270190
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull s390 updates for the 6.6 merge window.

There will be a merge conflict with Andrew's mm-nonmm-stable tree.
Since the diff of the merge resolution is quite large I'm going to
reply to this mail.

Thanks,
Heiko

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-1

for you to fetch changes up to dedf98dd1cfb61cfc74be9248b90a49b42c6dead:

  s390/pci: use builtin_misc_device macro to simplify the code (2023-08-23 14:37:42 +0200)

----------------------------------------------------------------
s390 updates for 6.6 merge window

- Add vfio-ap support to pass-through crypto devices to secure execution
  guests

- Add API ordinal 6 support to zcrypt_ep11misc device drive, which is
  required to handle key generate and key derive (e.g. secure key to
  protected key) correctly

- Add missing secure/has_secure sysfs files for the case where it is not
  possible to figure where a system has been booted from. Existing user
  space relies on that these files are always present

- Fix DCSS block device driver list corruption, caused by incorrect
  error handling

- Convert virt_to_pfn() and pfn_to_virt() from defines to static inline
  functions to enforce type checking

- Cleanups, improvements, and minor fixes to the kernel mapping setup

- Fix various virtual vs physical address confusions

- Move pfault code to separate file, since it has nothing to do with
  regular fault handling

- Move s390 documentation to Documentation/arch/ like it has been done
  for other architectures already

- Add HAVE_FUNCTION_GRAPH_RETVAL support

- Factor out the s390_hypfs filesystem and add a new config option for
  it. The filesystem is deprecated and as soon as all users are gone it
  can be removed some time in the not so near future

- Remove support for old CEX2 and CEX3 crypto cards from zcrypt device
  driver

- Add support for user-defined certificates: receive user-defined
  certificates with a diagnose call and provide them via 'cert_store'
  keyring to user space

- Couple of other small fixes and improvements all over the place

----------------------------------------------------------------
Alexander Gordeev (12):
      s390/kexec: make machine_kexec() depend on CONFIG_KEXEC_CORE
      s390/dcssblk: use IS_ALIGNED() for alignment checks
      s390/dcssblk: fix virtual vs physical address confusion
      s390/mm: remove redundant check against VMEM_MAX_PHYS
      s390/mm: rework arch_get_mappable_range() callback
      s390/extmem: improve reporting of -ERANGE error
      s390/mm: get rid of VMEM_MAX_PHYS macro
      s390/boot: cleanup number of page table levels setup
      s390/mm: define Real Memory Copy size and mask macros
      s390/boot: account Real Memory Copy and Lowcore areas
      s390/boot: fix multi-line comments style
      s390/ipl: fix virtual vs physical address confusion

Anastasia Eskova (1):
      s390: add support for user-defined certificates

Christophe JAILLET (1):
      s390/ebcdic: fix typo in comment

Costa Shulyupin (1):
      docs: move s390 under arch

Gerald Schaefer (1):
      s390/dcssblk: fix kernel crash with list_add corruption

Harald Freudenberger (1):
      s390/zcrypt: remove CEX2 and CEX3 device drivers

Heiko Carstens (16):
      s390/diag: handle diag 204 subcode 4 address correctly
      s390/sthyi: enforce 4k alignment of vmalloc'ed area
      s390/hypfs: simplify memory allocation
      s390/hypfs: remove open-coded PTR_ALIGN()
      s390/hypfs: factor out filesystem code
      s390/diag: fix diagnose 8c description
      s390/ftrace: use la instead of aghik in return_to_handler()
      s390/defconfigs: set CONFIG_FUNCTION_GRAPH_RETVAL=y
      s390/mm: move pfault code to own C file
      s390/pfault: use UL instead of ULL
      s390/pfault: remove not needed packed and aligned attributes
      s390/pfault: use early_param() instead if __setup()
      s390/pfault: cleanup inline assemblies
      s390/pfault: use consistent comment style
      s390/smp: ensure global control register contents are in sync
      Merge branch 'vfio-ap' into features

Holger Dengler (8):
      s390/pkey: fix/harmonize internal keyblob headers
      s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_GENSECK2 IOCTL
      s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_CLR2SECK2 IOCTL
      s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_KBLOB2PROTK[23]
      s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_VERIFYKEY2 IOCTL
      s390/pkey: fix PKEY_TYPE_EP11_AES handling for sysfs attributes
      s390/paes: fix PKEY_TYPE_EP11_AES handling for secure keyblobs
      s390/zcrypt_ep11misc: support API ordinal 6 with empty pin-blob

Janosch Frank (1):
      s390/uv: export uv_pin_shared for direct usage

Justin Stitt (1):
      s390/ipl: refactor deprecated strncpy

Li Zetao (1):
      s390/pci: use builtin_misc_device macro to simplify the code

Linus Walleij (1):
      s390/mm: make virt_to_pfn() a static inline

Masahiro Yamada (4):
      s390: use obj-y to descend into drivers/s390/
      s390: remove unneeded #include <asm/export.h>
      s390: replace #include <asm/export.h> with #include <linux/export.h>
      s390: remove <asm/export.h>

Sven Schnelle (6):
      s390/ftrace: enable HAVE_FUNCTION_GRAPH_RETVAL
      s390/hypfs: stop using ENOSYS error code
      s390/tracing: pass struct ftrace_regs to ftrace_trace_function
      s390/cert_store: select CRYPTO_LIB_SHA256
      s390/ipl: add missing secure/has_secure file to ipl type 'unknown'
      s390/ipl: add common ipl parameter attribute group

Tony Krowiak (11):
      s390/vfio-ap: no need to check the 'E' and 'I' bits in APQSW after TAPQ
      s390/vfio-ap: clean up irq resources if possible
      s390/vfio-ap: wait for response code 05 to clear on queue reset
      s390/vfio-ap: allow deconfigured queue to be passed through to a guest
      s390/vfio-ap: remove upper limit on wait for queue reset to complete
      s390/vfio-ap: store entire AP queue status word with the queue object
      s390/vfio-ap: use work struct to verify queue reset
      s390/vfio-ap: handle queue state change in progress on reset
      s390/vfio-ap: check for TAPQ response codes 0x35 and 0x36
      KVM: s390: export kvm_s390_pv*_is_protected functions
      s390/vfio-ap: make sure nib is shared

Yang Yingliang (1):
      s390/cert_store: fix error return code in fill_cs_keyring()

 Documentation/admin-guide/kernel-parameters.txt   |   4 +-
 Documentation/arch/index.rst                      |   2 +-
 Documentation/{ => arch}/s390/3270.ChangeLog      |   0
 Documentation/{ => arch}/s390/3270.rst            |   4 +-
 Documentation/{ => arch}/s390/cds.rst             |   2 +-
 Documentation/{ => arch}/s390/common_io.rst       |   2 +-
 Documentation/{ => arch}/s390/config3270.sh       |   0
 Documentation/{ => arch}/s390/driver-model.rst    |   0
 Documentation/{ => arch}/s390/features.rst        |   0
 Documentation/{ => arch}/s390/index.rst           |   0
 Documentation/{ => arch}/s390/monreader.rst       |   0
 Documentation/{ => arch}/s390/pci.rst             |   2 +-
 Documentation/{ => arch}/s390/qeth.rst            |   0
 Documentation/{ => arch}/s390/s390dbf.rst         |   0
 Documentation/{ => arch}/s390/text_files.rst      |   0
 Documentation/{ => arch}/s390/vfio-ap-locking.rst |   0
 Documentation/{ => arch}/s390/vfio-ap.rst         |   0
 Documentation/{ => arch}/s390/vfio-ccw.rst        |   2 +-
 Documentation/{ => arch}/s390/zfcpdump.rst        |   0
 Documentation/driver-api/s390-drivers.rst         |   4 +-
 MAINTAINERS                                       |   8 +-
 arch/s390/Kbuild                                  |   2 +-
 arch/s390/Kconfig                                 |  31 +-
 arch/s390/Makefile                                |   1 -
 arch/s390/boot/startup.c                          |  22 +-
 arch/s390/configs/debug_defconfig                 |   1 +
 arch/s390/configs/defconfig                       |   1 +
 arch/s390/crypto/paes_s390.c                      |   2 +-
 arch/s390/hypfs/Makefile                          |  11 +-
 arch/s390/hypfs/hypfs.h                           |  10 +-
 arch/s390/hypfs/hypfs_dbfs.c                      |  31 +-
 arch/s390/hypfs/hypfs_diag.c                      | 453 +-----------
 arch/s390/hypfs/hypfs_diag.h                      |  35 +
 arch/s390/hypfs/hypfs_diag_fs.c                   | 393 +++++++++++
 arch/s390/hypfs/hypfs_vm.c                        | 175 +----
 arch/s390/hypfs/hypfs_vm.h                        |  50 ++
 arch/s390/hypfs/hypfs_vm_fs.c                     | 139 ++++
 arch/s390/hypfs/inode.c                           |  35 +-
 arch/s390/include/asm/Kbuild                      |   1 -
 arch/s390/include/asm/debug.h                     |   4 +-
 arch/s390/include/asm/diag.h                      |   3 +
 arch/s390/include/asm/ftrace.h                    |  17 +
 arch/s390/include/asm/kfence.h                    |   2 +-
 arch/s390/include/asm/kvm_host.h                  |   3 +
 arch/s390/include/asm/maccess.h                   |   3 +
 arch/s390/include/asm/page.h                      |  12 +-
 arch/s390/include/asm/pfault.h                    |  26 +
 arch/s390/include/asm/pgtable.h                   |   2 -
 arch/s390/include/asm/sclp.h                      |   1 +
 arch/s390/include/asm/setup.h                     |   9 +-
 arch/s390/include/asm/uv.h                        |   6 +
 arch/s390/include/uapi/asm/pkey.h                 |   2 +-
 arch/s390/kernel/Makefile                         |   7 +-
 arch/s390/kernel/asm-offsets.c                    |   9 +
 arch/s390/kernel/cert_store.c                     | 811 ++++++++++++++++++++++
 arch/s390/kernel/diag.c                           |  25 +-
 arch/s390/kernel/ebcdic.c                         |   2 +-
 arch/s390/kernel/entry.S                          |   2 +-
 arch/s390/kernel/ipl.c                            |  32 +-
 arch/s390/kernel/machine_kexec.c                  |   1 +
 arch/s390/kernel/machine_kexec_file.c             |   4 +-
 arch/s390/kernel/mcount.S                         |  65 +-
 arch/s390/kernel/setup.c                          |   3 +-
 arch/s390/kernel/smp.c                            |  16 +-
 arch/s390/kernel/sthyi.c                          |   4 +-
 arch/s390/kernel/uv.c                             |   3 +-
 arch/s390/kvm/kvm-s390.h                          |  12 -
 arch/s390/kvm/pv.c                                |  14 +
 arch/s390/lib/mem.S                               |   2 +-
 arch/s390/lib/tishift.S                           |   2 +-
 arch/s390/mm/Makefile                             |   1 +
 arch/s390/mm/cmm.c                                |   2 +-
 arch/s390/mm/dump_pagetables.c                    |   2 +-
 arch/s390/mm/extmem.c                             |   9 +-
 arch/s390/mm/fault.c                              | 228 ------
 arch/s390/mm/maccess.c                            |   7 +-
 arch/s390/mm/pfault.c                             | 248 +++++++
 arch/s390/mm/vmem.c                               |   4 +-
 arch/s390/pci/pci_clp.c                           |   7 +-
 drivers/Makefile                                  |   2 +
 drivers/crypto/Kconfig                            |   7 +-
 drivers/s390/block/dcssblk.c                      |  26 +-
 drivers/s390/block/scm_blk.c                      |   2 +-
 drivers/s390/char/sclp_cmd.c                      |   4 -
 drivers/s390/char/sclp_early.c                    |   1 +
 drivers/s390/char/vmcp.c                          |   2 +-
 drivers/s390/char/zcore.c                         |   2 +-
 drivers/s390/crypto/Makefile                      |   2 +-
 drivers/s390/crypto/ap_bus.c                      |  34 +-
 drivers/s390/crypto/ap_bus.h                      |  20 +-
 drivers/s390/crypto/ap_queue.c                    |  47 +-
 drivers/s390/crypto/pkey_api.c                    | 119 +++-
 drivers/s390/crypto/vfio_ap_ops.c                 | 172 +++--
 drivers/s390/crypto/vfio_ap_private.h             |   6 +-
 drivers/s390/crypto/zcrypt_cex2a.c                | 227 ------
 drivers/s390/crypto/zcrypt_cex2a.h                | 134 ----
 drivers/s390/crypto/zcrypt_cex2c.c                | 421 -----------
 drivers/s390/crypto/zcrypt_cex2c.h                |  18 -
 drivers/s390/crypto/zcrypt_ep11misc.c             | 347 ++++++---
 drivers/s390/crypto/zcrypt_ep11misc.h             |  24 +-
 drivers/s390/crypto/zcrypt_msgtype50.c            |  64 +-
 drivers/s390/crypto/zcrypt_msgtype50.h            |   3 +-
 drivers/s390/crypto/zcrypt_msgtype6.c             |  14 +-
 security/integrity/platform_certs/load_ipl_s390.c |   4 +-
 104 files changed, 2580 insertions(+), 2157 deletions(-)
 rename Documentation/{ => arch}/s390/3270.ChangeLog (100%)
 rename Documentation/{ => arch}/s390/3270.rst (99%)
 rename Documentation/{ => arch}/s390/cds.rst (99%)
 rename Documentation/{ => arch}/s390/common_io.rst (98%)
 rename Documentation/{ => arch}/s390/config3270.sh (100%)
 rename Documentation/{ => arch}/s390/driver-model.rst (100%)
 rename Documentation/{ => arch}/s390/features.rst (100%)
 rename Documentation/{ => arch}/s390/index.rst (100%)
 rename Documentation/{ => arch}/s390/monreader.rst (100%)
 rename Documentation/{ => arch}/s390/pci.rst (99%)
 rename Documentation/{ => arch}/s390/qeth.rst (100%)
 rename Documentation/{ => arch}/s390/s390dbf.rst (100%)
 rename Documentation/{ => arch}/s390/text_files.rst (100%)
 rename Documentation/{ => arch}/s390/vfio-ap-locking.rst (100%)
 rename Documentation/{ => arch}/s390/vfio-ap.rst (100%)
 rename Documentation/{ => arch}/s390/vfio-ccw.rst (99%)
 rename Documentation/{ => arch}/s390/zfcpdump.rst (100%)
 create mode 100644 arch/s390/hypfs/hypfs_diag.h
 create mode 100644 arch/s390/hypfs/hypfs_diag_fs.c
 create mode 100644 arch/s390/hypfs/hypfs_vm.h
 create mode 100644 arch/s390/hypfs/hypfs_vm_fs.c
 create mode 100644 arch/s390/include/asm/pfault.h
 create mode 100644 arch/s390/kernel/cert_store.c
 create mode 100644 arch/s390/mm/pfault.c
