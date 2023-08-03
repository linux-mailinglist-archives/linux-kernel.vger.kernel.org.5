Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BAE76E245
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHCIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjHCIAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:00:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2054686;
        Thu,  3 Aug 2023 00:47:48 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3737gqZG031222;
        Thu, 3 Aug 2023 07:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=UlQ7XXlWS4BJghJZiG7o3JQs+7gOWdl+dgaNdEr06vw=;
 b=YEa1UFQhnwXtjCCwoI0hB0rU2HETYqQMJfeDaV2JadjHzFD8L9FCFjDPpmT0n0bjvACL
 S6B2xMSE2JP/CFMFf7RwVT8BdgyT6pzwPQMPqrUgJ8w7F1ueyKs5FWoWt8QDL/Y/5tGj
 cm7twYRx5t47zDEDw9yP1jgZYPF03QxVhuLTgcvhcc4C4IRXcs7307uDOyrThOaRPVOL
 D+BM0CyFEx4YvKnuHWaS9LHTHvOThWtGk+myf3PSGzG7+fujxPO81wWoSFfcHQCJtcYd
 PnFstw4aTia7VzPTA4fIfQk5qQPcCtm6pstGmuWPpvV++we4lrbFZ0D4G4vJgnUZwIwO Rw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s87x1racp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:47:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3736CQvE015496;
        Thu, 3 Aug 2023 07:47:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3nbpj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:47:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3737lhRl066054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 07:47:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF2D220063;
        Thu,  3 Aug 2023 07:47:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74AD12004B;
        Thu,  3 Aug 2023 07:47:43 +0000 (GMT)
Received: from osiris (unknown [9.152.212.233])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Aug 2023 07:47:43 +0000 (GMT)
Date:   Thu, 3 Aug 2023 09:47:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.5-rc5
Message-ID: <20230803074742.9170-C-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: codbMzRlGbSguAy57z0tyhiPOMxAfCjV
X-Proofpoint-GUID: codbMzRlGbSguAy57z0tyhiPOMxAfCjV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull a couple of s390 fixes for 6.5-rc5.

Thanks,
Heiko

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-4

for you to fetch changes up to 388acb471662c273d94163a8502f09668f380686:

  s390/ptrace: add missing linux/const.h include (2023-08-01 16:47:03 +0200)

----------------------------------------------------------------
s390 fixes for 6.5-rc5

- Split kernel large page mappings into 4k mappings in case debug
  pagealloc is enabled again. This got by accident removed with
  commit bb1520d581a3 ("s390/mm: start kernel with DAT enabled")

- Fix error handling in KVM's sthyi handling

- Add missing include to s390's uapi ptrace.h

- Update defconfigs

----------------------------------------------------------------
Heiko Carstens (3):
      s390: update defconfigs
      KVM: s390: fix sthyi error handling
      s390/ptrace: add missing linux/const.h include

Sven Schnelle (1):
      s390/vmem: split pages when debug pagealloc is enabled

 arch/s390/configs/debug_defconfig    | 11 ++++++-----
 arch/s390/configs/defconfig          |  9 +++++----
 arch/s390/configs/zfcpdump_defconfig |  1 -
 arch/s390/include/uapi/asm/ptrace.h  |  2 ++
 arch/s390/kernel/sthyi.c             |  6 +++---
 arch/s390/kvm/intercept.c            |  9 ++++++---
 arch/s390/mm/vmem.c                  |  2 ++
 7 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index aa95cf6dfabb..32bf2c7b4057 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -116,7 +116,6 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
-CONFIG_NET_TC_SKB_EXT=y
 CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
@@ -193,6 +192,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NETFILTER_XTABLES_COMPAT=y
 CONFIG_NETFILTER_XT_SET=m
 CONFIG_NETFILTER_XT_TARGET_AUDIT=m
 CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
@@ -379,6 +379,7 @@ CONFIG_NET_ACT_SIMP=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_ACT_CSUM=m
 CONFIG_NET_ACT_GATE=m
+CONFIG_NET_TC_SKB_EXT=y
 CONFIG_DNS_RESOLVER=y
 CONFIG_OPENVSWITCH=m
 CONFIG_VSOCKETS=m
@@ -395,6 +396,7 @@ CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_SAFE=y
+# CONFIG_FW_LOADER is not set
 CONFIG_CONNECTOR=y
 CONFIG_ZRAM=y
 CONFIG_BLK_DEV_LOOP=m
@@ -502,7 +504,6 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_GOOGLE is not set
 # CONFIG_NET_VENDOR_HUAWEI is not set
 # CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_WANGXUN is not set
 # CONFIG_NET_VENDOR_LITEX is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 CONFIG_MLX4_EN=m
@@ -542,6 +543,7 @@ CONFIG_MLX5_CORE_EN=y
 # CONFIG_NET_VENDOR_TI is not set
 # CONFIG_NET_VENDOR_VERTEXCOM is not set
 # CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WANGXUN is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_PPP=m
@@ -646,7 +648,6 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_TMPFS_INODE64=y
 CONFIG_HUGETLBFS=y
-CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
 CONFIG_CRAMFS=m
 CONFIG_SQUASHFS=m
@@ -690,7 +691,6 @@ CONFIG_HARDENED_USERCOPY=y
 CONFIG_FORTIFY_SOURCE=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
-CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_LOCKDOWN_LSM=y
 CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
 CONFIG_SECURITY_LANDLOCK=y
@@ -744,7 +744,6 @@ CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -844,6 +843,7 @@ CONFIG_PREEMPT_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_USER_EVENTS=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_FTRACE_STARTUP_TEST=y
 # CONFIG_EVENT_TRACE_STARTUP_TEST is not set
@@ -866,6 +866,7 @@ CONFIG_FAIL_MAKE_REQUEST=y
 CONFIG_FAIL_IO_TIMEOUT=y
 CONFIG_FAIL_FUTEX=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FAULT_INJECTION_CONFIGFS=y
 CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
 CONFIG_LKDTM=m
 CONFIG_TEST_MIN_HEAP=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index f041945f9148..f95b7c62a043 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -107,7 +107,6 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
-CONFIG_NET_TC_SKB_EXT=y
 CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
@@ -184,6 +183,7 @@ CONFIG_NFT_REJECT=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_HASH=m
 CONFIG_NFT_FIB_INET=m
+CONFIG_NETFILTER_XTABLES_COMPAT=y
 CONFIG_NETFILTER_XT_SET=m
 CONFIG_NETFILTER_XT_TARGET_AUDIT=m
 CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
@@ -369,6 +369,7 @@ CONFIG_NET_ACT_SIMP=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_ACT_CSUM=m
 CONFIG_NET_ACT_GATE=m
+CONFIG_NET_TC_SKB_EXT=y
 CONFIG_DNS_RESOLVER=y
 CONFIG_OPENVSWITCH=m
 CONFIG_VSOCKETS=m
@@ -385,6 +386,7 @@ CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_UEVENT_HELPER=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_SAFE=y
+# CONFIG_FW_LOADER is not set
 CONFIG_CONNECTOR=y
 CONFIG_ZRAM=y
 CONFIG_BLK_DEV_LOOP=m
@@ -492,7 +494,6 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_GOOGLE is not set
 # CONFIG_NET_VENDOR_HUAWEI is not set
 # CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_WANGXUN is not set
 # CONFIG_NET_VENDOR_LITEX is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 CONFIG_MLX4_EN=m
@@ -532,6 +533,7 @@ CONFIG_MLX5_CORE_EN=y
 # CONFIG_NET_VENDOR_TI is not set
 # CONFIG_NET_VENDOR_VERTEXCOM is not set
 # CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WANGXUN is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_PPP=m
@@ -673,7 +675,6 @@ CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
-CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_LOCKDOWN_LSM=y
 CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
 CONFIG_SECURITY_LANDLOCK=y
@@ -729,7 +730,6 @@ CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_WP512=m
@@ -793,6 +793,7 @@ CONFIG_STACK_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_USER_EVENTS=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_TRACE_PRINTK=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 6f68b39817ef..e62fb2015102 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -53,7 +53,6 @@ CONFIG_ZFCP=y
 # CONFIG_HVC_IUCV is not set
 # CONFIG_HW_RANDOM_S390 is not set
 # CONFIG_HMC_DRV is not set
-# CONFIG_S390_UV_UAPI is not set
 # CONFIG_S390_TAPE is not set
 # CONFIG_VMCP is not set
 # CONFIG_MONWRITER is not set
diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index f0fe3bcc78a8..bb0826024bb9 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -8,6 +8,8 @@
 #ifndef _UAPI_S390_PTRACE_H
 #define _UAPI_S390_PTRACE_H
 
+#include <linux/const.h>
+
 /*
  * Offsets in the user_regs_struct. They are used for the ptrace
  * system call and in entry.S
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 4d141e2c132e..2ea7f208f0e7 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -459,9 +459,9 @@ static int sthyi_update_cache(u64 *rc)
  *
  * Fills the destination with system information returned by the STHYI
  * instruction. The data is generated by emulation or execution of STHYI,
- * if available. The return value is the condition code that would be
- * returned, the rc parameter is the return code which is passed in
- * register R2 + 1.
+ * if available. The return value is either a negative error value or
+ * the condition code that would be returned, the rc parameter is the
+ * return code which is passed in register R2 + 1.
  */
 int sthyi_fill(void *dst, u64 *rc)
 {
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 954d39adf85c..341abafb96e4 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -389,8 +389,8 @@ static int handle_partial_execution(struct kvm_vcpu *vcpu)
  */
 int handle_sthyi(struct kvm_vcpu *vcpu)
 {
-	int reg1, reg2, r = 0;
-	u64 code, addr, cc = 0, rc = 0;
+	int reg1, reg2, cc = 0, r = 0;
+	u64 code, addr, rc = 0;
 	struct sthyi_sctns *sctns = NULL;
 
 	if (!test_kvm_facility(vcpu->kvm, 74))
@@ -421,7 +421,10 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	cc = sthyi_fill(sctns, &rc);
-
+	if (cc < 0) {
+		free_page((unsigned long)sctns);
+		return cc;
+	}
 out:
 	if (!cc) {
 		if (kvm_s390_pv_cpu_is_protected(vcpu)) {
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b26649233d12..24a66670f5c3 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -763,6 +763,8 @@ void __init vmem_map_init(void)
 	if (static_key_enabled(&cpu_has_bear))
 		set_memory_nx(0, 1);
 	set_memory_nx(PAGE_SIZE, 1);
+	if (debug_pagealloc_enabled())
+		set_memory_4k(0, ident_map_size >> PAGE_SHIFT);
 
 	pr_info("Write protected kernel read-only data: %luk\n",
 		(unsigned long)(__end_rodata - _stext) >> 10);
