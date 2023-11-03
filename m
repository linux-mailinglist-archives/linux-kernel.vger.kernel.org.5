Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1E7E07C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjKCRue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKCRub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:50:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D176136;
        Fri,  3 Nov 2023 10:50:26 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3HkRPM007128;
        Fri, 3 Nov 2023 17:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=yPMnGKcjxbyTf+8vU7fm2ibsNgRHRY37p8mU6jU2LnY=;
 b=cuTfy6Q2oBmWDF7hNwxMOgCRCerbS3HTSUlPSS7koPPoEMuLhcuUWNShkO6SHfDj2U3V
 6VmzXBQCeXkTSOEuVgtYXs9DL6odN62LsPX/3YtZkjutrRQ32HnLwh3ZIOJ/zimkv0rO
 zOWTNQhw914DPvO8uCwLHaRd0dggxPKe2phJvGk8WRSgd1+Bjhu8tDcxclHxrt/EfnrN
 Scq22L7mDTDvIhq2GGrSfJbOs0Uh/5ixvWB4T/GjX2AgKMafqgRPocjQo64WJ2NiopkH
 pYdR4R3pylizeHqmc47OM1EXXaCQucBq/6j1/jtdCrenXEkQJ1WMNwh86QwFHWbCli2k iA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u55bqrd6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 17:50:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3HfSHx007726;
        Fri, 3 Nov 2023 17:50:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmp7kx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 17:50:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A3HoKKa57082292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 17:50:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ADCF2004E;
        Fri,  3 Nov 2023 17:50:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6C842004F;
        Fri,  3 Nov 2023 17:50:19 +0000 (GMT)
Received: from localhost (unknown [9.171.31.188])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Nov 2023 17:50:19 +0000 (GMT)
Date:   Fri, 3 Nov 2023 18:50:18 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 6.7 merge window
Message-ID: <your-ad-here.call-01699033818-ext-2437@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 37c7nCfM_9Whvp9PMcn5JMaSTIoBVEaT
X-Proofpoint-GUID: 37c7nCfM_9Whvp9PMcn5JMaSTIoBVEaT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_17,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030149
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.7.

Thank you,
Vasily

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-1

for you to fetch changes up to 991a211aa99f468cd291a97b8dcb448ebc77f6c4:

  s390/cio: replace deprecated strncpy with strscpy (2023-10-25 15:08:30 +0200)

----------------------------------------------------------------
s390 updates for the 6.7 merge window

- Get rid of private VM_FAULT flags

- Add word-at-a-time implementation

- Add DCACHE_WORD_ACCESS support

- Cleanup control register handling

- Disallow CPU hotplug of CPU 0 to simplify its handling complexity,
  following a similar restriction in x86

- Optimize pai crypto map allocation

- Update the list of crypto express EP11 coprocessor operation modes

- Fixes and improvements for secure guests AP pass-through

- Several fixes to address incorrect page marking for address translation
  with the "cmma no-dat" feature, preventing potential incorrect guest
  TLB flushes

- Fix early IPI handling

- Several virtual vs physical address confusion fixes

- Various small fixes and improvements all over the code

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/crash: remove unused parameter
      s390/crash: fix virtual vs physical address confusion

Harald Freudenberger (3):
      s390/ap: re-init AP queues on config on
      s390/zcrypt: introduce new internal AP queue se_bound attribute
      s390/ap: show APFS value on error reply 0x8B

Heiko Carstens (55):
      s390/smp,mcck: fix early IPI handling
      s390/setup: use strlcat() instead of strcat()
      s390/ctlreg: move control register code to separate file
      s390/ctlreg: rename ctl_reg.h to ctlreg.h
      s390/ctlreg: cleanup inline assemblies
      s390/ctlreg: add local and system prefix to some functions
      s390/ctlreg: add local_ctl_load() and local_ctl_store()
      s390/ctlreg: use local_ctl_load() and local_ctl_store() where possible
      s390/ctlreg: change parameters of __local_ctl_load() and __local_ctl_store()
      s390/kprobes,ptrace: open code struct per_reg
      s390/ctlreg: add type checking to __local_ctl_load() and __local_ctl_store()
      s390/ctlreg: add struct ctlreg
      s390/ctltreg: make initialization of control register save area explicit
      s390/ctlreg: allow to call system_ctl_set/clear_bit() early
      s390/early: use system_ctl_set_bit() instead of local_ctl_set_bit()
      s390/ctlreg: add system_ctl_load()
      s390/setup: make use of system_ctl_load()
      s390/ctlreg: add missing defines
      s390/irq: use CR0 defines to define CR0_IRQ_SUBCLASS_MASK
      s390/ctlreg: add control register bits
      s390: use control register bit defines
      s390/extable: reduce number of extable macros
      s390: provide word-at-a-time implementation
      s390: add support for DCACHE_WORD_ACCESS
      s390/mm: remove __GFP_HIGHMEM masking
      s390/mm: make vmemmap_free() only for CONFIG_MEMORY_HOTPLUG available
      s390/mm,fault: remove and improve comments, adjust whitespace
      s390/mm,fault: reverse x-mas tree coding style
      s390/mm,fault: use __ratelimit() instead of printk_ratelimit()
      s390/mm,fault: use pr_warn_ratelimited()
      s390/mm,fault: use pr_warn(), pr_cont(), ... instead of open-coding
      s390/mm,fault: have balanced braces, remove unnecessary blanks
      s390/mm,fault: include linux/mmu_context.h
      s390/mm,fault: remove line break
      s390/mm,fault: remove noinline attribute from all functions
      s390/mm,fault: replace WARN_ON_ONCE() with unreachable()
      s390/mm,fault: use get_fault_address() everywhere
      s390/mm,fault: use static key for store indication
      s390/mm: move translation-exception identification structure to fault.h
      s390/mm,fault: improve readability by using teid union
      s390/mm,fault: use get_kernel_nofault() to dereference in dump_pagetable()
      s390/mm,fault: remove VM_FAULT_PFAULT
      s390/mm,fault: get rid of do_low_address()
      s390/mm,fault: call do_fault_error() only from do_exception()
      s390/mm,fault: simplify kfence fault handling
      s390/mm,fault: remove VM_FAULT_BADCONTEXT
      s390/mm,fault: remove VM_FAULT_SIGNAL
      s390/mm,fault: remove VM_FAULT_BADMAP and VM_FAULT_BADACCESS
      s390/mm,fault: move VM_FAULT_ERROR handling to do_exception()
      s390/diag: add missing virt_to_phys() translation to diag224()
      s390/cmma: fix initial kernel address space page table walk
      s390/mm: add missing arch_set_page_dat() call to vmem_crst_alloc()
      s390/mm: add missing arch_set_page_dat() call to gmap allocations
      s390/cmma: fix detection of DAT pages
      s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir

Ilya Leoshkevich (2):
      s390/smp: keep the original lowcore for CPU 0
      s390: delete the unused store_prefix() function

Ingo Franzki (1):
      s390/zcrypt: update list of EP11 operation modes

Justin Stitt (2):
      s390/sclp: replace deprecated strncpy with strtomem
      s390/cio: replace deprecated strncpy with strscpy

Peter Oberparleiter (2):
      s390/cio: export CMG value as decimal
      s390/cio: fix virtual vs physical address confusion

Sumanth Korikkar (1):
      s390/sclp: handle default case in sclp memory notifier

Thomas Richter (4):
      s390/pai_crypto: dynamically allocate percpu pai crypto map data structure
      s390/pai_crypto: use PERF_ATTACH_TASK define for per task detection
      s390/pai: initialize event count once at initialization
      s390/pai_crypto: remove per-cpu variable assignement in event initialization

Tobias Huschle (1):
      s390/smp: disallow CPU hotplug of CPU 0

Vasily Gorbik (1):
      s390/vmem: remove unused variable

 arch/s390/Kconfig                      |   1 +
 arch/s390/boot/startup.c               |   2 +-
 arch/s390/boot/vmem.c                  |  17 +-
 arch/s390/include/asm/asm-extable.h    |  27 +-
 arch/s390/include/asm/ctl_reg.h        | 146 -----------
 arch/s390/include/asm/ctlreg.h         | 251 ++++++++++++++++++
 arch/s390/include/asm/fault.h          |  28 ++
 arch/s390/include/asm/fpu/internal.h   |   1 -
 arch/s390/include/asm/irq.h            |  23 +-
 arch/s390/include/asm/kprobes.h        |   3 +-
 arch/s390/include/asm/lowcore.h        |  15 +-
 arch/s390/include/asm/mmu_context.h    |  10 +-
 arch/s390/include/asm/pgtable.h        |   3 +-
 arch/s390/include/asm/smp.h            |   1 -
 arch/s390/include/asm/uaccess.h        |   1 -
 arch/s390/include/asm/word-at-a-time.h |  64 +++++
 arch/s390/kernel/Makefile              |   2 +-
 arch/s390/kernel/crash_dump.c          |   6 +-
 arch/s390/kernel/ctlreg.c              | 121 +++++++++
 arch/s390/kernel/diag.c                |   3 +-
 arch/s390/kernel/early.c               |  22 +-
 arch/s390/kernel/guarded_storage.c     |   6 +-
 arch/s390/kernel/ipl.c                 |   2 +-
 arch/s390/kernel/irq.c                 |   4 +-
 arch/s390/kernel/kprobes.c             |  21 +-
 arch/s390/kernel/machine_kexec.c       |   6 +-
 arch/s390/kernel/nmi.c                 |  24 +-
 arch/s390/kernel/perf_cpum_cf.c        |   2 +-
 arch/s390/kernel/perf_pai_crypto.c     | 138 +++++++---
 arch/s390/kernel/perf_pai_ext.c        |  10 +-
 arch/s390/kernel/ptrace.c              |  45 ++--
 arch/s390/kernel/setup.c               |  23 +-
 arch/s390/kernel/smp.c                 | 132 +---------
 arch/s390/kernel/time.c                |   4 +-
 arch/s390/kvm/gaccess.c                |  45 +---
 arch/s390/kvm/kvm-s390.c               |   6 +-
 arch/s390/kvm/priv.c                   |   2 +-
 arch/s390/lib/uaccess.c                |  15 +-
 arch/s390/mm/dump_pagetables.c         |   2 +-
 arch/s390/mm/extable.c                 |  18 ++
 arch/s390/mm/fault.c                   | 460 +++++++++++++--------------------
 arch/s390/mm/gmap.c                    |  24 +-
 arch/s390/mm/init.c                    |   4 +-
 arch/s390/mm/maccess.c                 |   2 +-
 arch/s390/mm/page-states.c             |  25 +-
 arch/s390/mm/pageattr.c                |   2 +-
 arch/s390/mm/pgalloc.c                 |   8 +-
 arch/s390/mm/vmem.c                    |  15 +-
 arch/s390/pci/pci.c                    |   2 +-
 drivers/s390/char/diag_ftp.c           |   2 +-
 drivers/s390/char/sclp.c               |  14 +-
 drivers/s390/char/sclp_cmd.c           |   3 +-
 drivers/s390/char/sclp_early.c         |   2 +-
 drivers/s390/char/sclp_early_core.c    |   7 +-
 drivers/s390/cio/chp.c                 |   2 +-
 drivers/s390/cio/chsc.c                |   8 +-
 drivers/s390/cio/crw.c                 |   4 +-
 drivers/s390/cio/isc.c                 |   4 +-
 drivers/s390/crypto/ap_bus.c           |  21 +-
 drivers/s390/crypto/ap_bus.h           |   3 +
 drivers/s390/crypto/ap_queue.c         |  58 ++++-
 drivers/s390/crypto/zcrypt_api.c       |  10 +-
 drivers/s390/crypto/zcrypt_cex4.c      |   4 +
 drivers/s390/crypto/zcrypt_error.h     |  18 +-
 net/iucv/iucv.c                        |   4 +-
 65 files changed, 1111 insertions(+), 847 deletions(-)
 delete mode 100644 arch/s390/include/asm/ctl_reg.h
 create mode 100644 arch/s390/include/asm/ctlreg.h
 create mode 100644 arch/s390/include/asm/fault.h
 create mode 100644 arch/s390/include/asm/word-at-a-time.h
 create mode 100644 arch/s390/kernel/ctlreg.c
