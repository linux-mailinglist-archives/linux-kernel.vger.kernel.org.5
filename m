Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31CA7E5F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjKHUdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHUdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:33:10 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3010D5;
        Wed,  8 Nov 2023 12:33:08 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8KGKvJ002263;
        Wed, 8 Nov 2023 20:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=IYwZ9SivaHS+MljhzK6A4ysjL11f9Bp7kqoMlkC090E=;
 b=tLTKV7W7rwMcJQTVVuRPWHHZJ6SBe6A1jJv7f5sc6tHSxeQoyUTxMfgN8OzR1K0JYlRb
 BJscQAtc+3NdNAUCv/CUID7LpRlSIpu4mGkLb3KmQ/oHfLa4bKPPDJcGsiHYVqTW8Q8j
 f5bIOQiV25YzK71kmP/0En5T1UzFmtx0qqpRSRG62tr5kk3BfDRR0bUiXgg+KHzhaihA
 YkV+Q8MG579US5Fi03stmzyW18JYLME4KhoX6TbMiQ5OVfVbTCxiFyM5EXRH5FZfH5OC
 AJJ5zjWzrUs4khbfkLpv+oLvJcpc8I+iVPe8Ek24kEMyXEwCIqtufWRuEXpACJONzrzg Gg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8h7gghxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 20:33:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8J3O43014506;
        Wed, 8 Nov 2023 20:33:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w21ydga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 20:33:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A8KX3Xw3080852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 20:33:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E6C120043;
        Wed,  8 Nov 2023 20:33:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C422A20040;
        Wed,  8 Nov 2023 20:33:02 +0000 (GMT)
Received: from localhost (unknown [9.171.18.100])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Nov 2023 20:33:02 +0000 (GMT)
Date:   Wed, 8 Nov 2023 21:33:01 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.7 merge window
Message-ID: <your-ad-here.call-01699475581-ext-3562@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D8ta2JOGByfSHIxTBZ3yfxUWgK95E0Yy
X-Proofpoint-GUID: D8ta2JOGByfSHIxTBZ3yfxUWgK95E0Yy
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_09,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=675 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull more s390 updates for 6.7 merge window.

Thank you,
Vasily

The following changes since commit e392ea4d4d00880bf94550151b1ace4f88a4b17a:

  Merge tag 's390-6.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2023-11-03 10:17:22 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-2

for you to fetch changes up to 02e790ee3077c0571794d0ab8f71413edbe129cc:

  s390/mm: make pte_free_tlb() similar to pXd_free_tlb() (2023-11-05 22:34:58 +0100)

----------------------------------------------------------------
more s390 updates for 6.7 merge window

- Get rid of s390 specific use of two PTEs per 4KB page with complex
  half-used pages tracking. Using full 4KB pages for 2KB PTEs increases
  the memory footprint of page tables but drastically simplify mm code,
  removing a common blocker for common code changes and adaptations

- Simplify and rework "cmma no-dat" handling. This is a follow up
  for recent fixes which prevent potential incorrect guest TLB flushes

- Add perf user stack unwinding as well as USER_STACKTRACE support for
  user space built with -mbackchain compile option

- Add few missing conversion from tlb_remove_table to tlb_remove_ptdesc

- Fix crypto cards vanishing in a secure execution environment due to
  asynchronous errors

- Avoid reporting crypto cards or queues in check-stop state as online

- Fix null-ptr deference in AP bus code triggered by early config change
  via SCLP

- Couple of stability improvements in AP queue interrupt handling

----------------------------------------------------------------
Alexander Gordeev (4):
      s390/mm: add missing conversion to use ptdescs
      s390/mm: use full 4KB page for 2KB PTE
      s390/mm: use compound page order to distinguish page tables
      s390/mm: make pte_free_tlb() similar to pXd_free_tlb()

Harald Freudenberger (4):
      s390/ap: rework to use irq info from ap queue status
      s390/ap: re-enable interrupt for AP queues
      s390/ap: fix AP bus crash on early config change callback invocation
      s390/ap: fix vanishing crypto cards in SE environment

Heiko Carstens (7):
      s390/perf: implement perf_callchain_user()
      s390: add USER_STACKTRACE support
      s390/cmma: cleanup inline assemblies
      s390/cmma: move parsing of cmma kernel parameter to early boot code
      s390/cmma: move set_page_stable() and friends to header file
      s390/cmma: move arch_set_page_dat() to header file
      s390/cmma: rework no-dat handling

Ingo Franzki (1):
      s390/zcrypt: don't report online if card or queue is in check-stop state

 arch/s390/Kconfig                   |   1 +
 arch/s390/boot/ipl_parm.c           |   8 +
 arch/s390/boot/startup.c            |  44 ++++++
 arch/s390/boot/vmem.c               |  17 ++
 arch/s390/include/asm/mmu.h         |   2 -
 arch/s390/include/asm/mmu_context.h |   1 -
 arch/s390/include/asm/page-states.h |  59 +++++++
 arch/s390/include/asm/page.h        |   1 -
 arch/s390/include/asm/pgalloc.h     |   1 -
 arch/s390/include/asm/setup.h       |   3 -
 arch/s390/include/asm/stacktrace.h  |   7 +
 arch/s390/include/asm/tlb.h         |  13 +-
 arch/s390/kernel/early.c            |   1 +
 arch/s390/kernel/perf_event.c       |  41 +++++
 arch/s390/kernel/stacktrace.c       |  43 ++++++
 arch/s390/mm/gmap.c                 |   4 +-
 arch/s390/mm/init.c                 |   4 -
 arch/s390/mm/page-states.c          | 213 +-------------------------
 arch/s390/mm/pgalloc.c              | 298 ++++--------------------------------
 arch/s390/mm/vmem.c                 |   4 +-
 drivers/s390/crypto/ap_bus.c        |  47 +++---
 drivers/s390/crypto/ap_bus.h        |   1 -
 drivers/s390/crypto/ap_queue.c      |  36 +++--
 drivers/s390/crypto/zcrypt_card.c   |   4 +-
 drivers/s390/crypto/zcrypt_queue.c  |   5 +-
 25 files changed, 320 insertions(+), 538 deletions(-)
