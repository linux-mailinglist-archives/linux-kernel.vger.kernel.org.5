Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD05F7973CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245741AbjIGPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbjIGP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96C198E;
        Thu,  7 Sep 2023 08:29:02 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387B7BH4026681;
        Thu, 7 Sep 2023 11:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=jghDJWKbU4WyoWwwYDICU+1lrxq0o3QcDHslt8jbfR0=;
 b=S2jItPlh63GkqXH+Ac6KQYkvClORfuukyAjFgrFvj9fUgFM6Zl/6IsL87x69bRYmW+Qs
 R0sYrj49cgamKgtnjzJtXSyMNRbpC54Z9R2Qc5I44g2W5R4VsiyE0L/5yTlw87hAOSbY
 vvfh1EzOb5kmA0mSUVPVOdUMrPAzvoiIvpt6/r2SA/niatPv0vjD5aZhp33N2b/rjsqH
 JbO4bgrZzzjLXEuay7RX5eP6ytC2OpermG/+ibZbjbOAVMRFtYuJCtSdkNipckcRh/xn
 FVoTKyuAeSHYyVx3gdCy2wQ5hox4dI9asoeb7VFjm3+qm9+MApoiobR4WUUfsGKPXz5m hQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syd5agv4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 11:27:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3879A73f006603;
        Thu, 7 Sep 2023 11:27:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvktyeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 11:27:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 387BRknG45220494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 11:27:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB49420043;
        Thu,  7 Sep 2023 11:27:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8173920040;
        Thu,  7 Sep 2023 11:27:46 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Sep 2023 11:27:46 +0000 (GMT)
Date:   Thu, 7 Sep 2023 13:27:43 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.6 merge window
Message-ID: <20230907112743.6134-E-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YDH4etDBfsDpwKTaYlLnxH1yd0gP19s0
X-Proofpoint-ORIG-GUID: YDH4etDBfsDpwKTaYlLnxH1yd0gP19s0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of additional s390 patches for the 6.6 merge
window.

Thanks,
Heiko

The following changes since commit e5b7ca09e9aa4d483ab84c5f2ba88f0cc7c66540:

  Merge tag 's390-6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2023-08-28 17:22:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-2

for you to fetch changes up to 06fc3b0d2251b550f530a1c42e0f9c5d022476dd:

  s390/vmem: do not silently ignore mapping limit (2023-09-05 20:12:52 +0200)

----------------------------------------------------------------
more s390 updates for 6.6 merge window

- Couple of virtual vs physical address confusion fixes

- Rework locking in dcssblk driver to address a lockdep warning

- Remove support for "noexec" kernel command line option since there
  is no use case where it would make sense

- Simplify kernel mapping setup and get rid of quite a bit of code

- Add architecture specific __set_memory_yy() functions which allow to
  modify kernel mappings. Unlike the set_memory_xx() variants they
  take void pointer start and end parameters, which allows to use them
  without the usual casts, and also to use them on areas larger than
  8TB.
  Note that the set_memory_xx() family comes with an int num_pages
  parameter which overflows with 8TB. This could be addressed by
  changing the num_pages parameter to unsigned long, however requires
  to change all architectures, since the module code expects an int
  parameter (see module_set_memory()).
  This was indeed an issue since for debug_pagealloc() we call
  set_memory_4k() on the whole identity mapping. Therefore address
  this for now with the __set_memory_yy() variant, and address common
  code later

- Use dev_set_name() and also fix memory leak in zcrypt driver error
  handling

- Remove unused lsi_mask from airq_struct

- Add warning for invalid kernel mapping requests

----------------------------------------------------------------
Alexander Gordeev (3):
      s390/vmem: fix virtual vs physical address confusion
      s390/mm: fix MAX_DMA_ADDRESS physical vs virtual confusion
      s390/vmem: do not silently ignore mapping limit

Andy Shevchenko (2):
      s390/zcrypt: don't leak memory if dev_set_name() fails
      s390/zcrypt: utilize dev_set_name() ability to use a formatted string

Benjamin Block (1):
      s390/airq: remove lsi_mask from airq_struct

Gerald Schaefer (2):
      s390/monreader: fix virtual vs physical address confusion
      s390/dcssblk: fix lockdep warning

Heiko Carstens (7):
      s390: remove "noexec" option
      s390/mm: simplify kernel mapping setup
      s390/amode31: change type of __samode31, __eamode31, etc
      s390/mm: improve description of mapping permissions of prefix pages
      s390/set_memory: generate all set_memory() functions
      s390/set_memory: add __set_memory() variant
      s390/mm: use __set_memory() variants where useful

 arch/s390/boot/ipl_parm.c          |   7 --
 arch/s390/boot/startup.c           |   4 +-
 arch/s390/boot/vmem.c              |  12 ++-
 arch/s390/include/asm/airq.h       |   1 -
 arch/s390/include/asm/dma.h        |   2 +-
 arch/s390/include/asm/sections.h   |   4 +-
 arch/s390/include/asm/set_memory.h |  64 ++++++++--------
 arch/s390/include/asm/setup.h      |   1 -
 arch/s390/kernel/early.c           |   5 +-
 arch/s390/kernel/machine_kexec.c   |   4 +-
 arch/s390/kernel/setup.c           |  17 ++---
 arch/s390/kvm/interrupt.c          |   3 +-
 arch/s390/mm/dump_pagetables.c     |   4 +-
 arch/s390/mm/init.c                |   4 +-
 arch/s390/mm/pageattr.c            |   2 +-
 arch/s390/mm/vmem.c                | 148 ++++++-------------------------------
 drivers/s390/block/dcssblk.c       |  13 ++--
 drivers/s390/char/monreader.c      |  12 ++-
 drivers/s390/cio/airq.c            |   4 +-
 drivers/s390/crypto/zcrypt_api.c   |  11 +--
 drivers/s390/virtio/virtio_ccw.c   |   1 -
 21 files changed, 99 insertions(+), 224 deletions(-)
