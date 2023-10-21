Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34527D1C30
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJUJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJUJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:44:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF213E;
        Sat, 21 Oct 2023 02:44:09 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39L9gNAp028149;
        Sat, 21 Oct 2023 09:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=wiznSzPHeDvgCYmBpLCxQSz2kUh0Y5cwbWCJqEw6UC4=;
 b=B++XRKSFFkRhrwMFPwI7jYlIAUaBh+ZtowErnbxY77jeVtPjU7UK1UoC/XHpObzaR7xP
 TwTN5Xnq1+7G/dONwKE+gMpOdfrl8IYNoUTirTcoPptgZ9QsPiww51guYwi1uj9SXG3m
 hEC+MtD531KNTi40qxOdAy9GrNanVf6rU0xMUjrHZD7cA0ZsXIh68IzMpD/6e5oed5+4
 5Mwjap40CtfCo64cvNNKffI7gsVbo14uz1vfEf6xOCS6QOMGha8aILYVHmfspW01n3lf
 o2zfzK4k/Db2GoBRaUgfYg1E3ET2napegbcadpmXxsRGZQsWAHF7DADfEJ56nlE+COeN pw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvc88r1e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Oct 2023 09:44:06 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39L5rstq024179;
        Sat, 21 Oct 2023 09:44:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc29akkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Oct 2023 09:44:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39L9i2eU000512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 09:44:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE6CB2004E;
        Sat, 21 Oct 2023 09:44:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C82620043;
        Sat, 21 Oct 2023 09:44:01 +0000 (GMT)
Received: from localhost (unknown [9.179.5.188])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 21 Oct 2023 09:44:01 +0000 (GMT)
Date:   Sat, 21 Oct 2023 11:44:00 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.6-rc7
Message-ID: <your-ad-here.call-01697881440-ext-2458@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cJbZbqwRyhTlqxB2eXYiZ6KhBivFH6Ep
X-Proofpoint-ORIG-GUID: cJbZbqwRyhTlqxB2eXYiZ6KhBivFH6Ep
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1011 mlxscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=602
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 fixes for 6.6-rc7.

Thank you,
Vasily

The following changes since commit 5c95bf274665cc9f5126e4a48a9da51114f7afd2:

  s390/cert_store: fix string length handling (2023-09-19 13:25:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-4

for you to fetch changes up to c1ae1c59c8c6e0b66a718308c623e0cb394dab6b:

  s390/pci: fix iommu bitmap allocation (2023-10-19 16:35:41 +0200)

----------------------------------------------------------------
s390 updates for 6.6-rc7

- Fix IOMMU bitmap allocation in s390 PCI to avoid out of bounds access
  when IOMMU pages aren't a multiple of 64.

- Fix kasan crashes when accessing DCSS mapping in memory holes by adding
  corresponding kasan zero shadow mappings.

- Fix a memory leak in css_alloc_subchannel in case dma_set_coherent_mask
  fails.

----------------------------------------------------------------
Dinghao Liu (1):
      s390/cio: fix a memleak in css_alloc_subchannel

Niklas Schnelle (1):
      s390/pci: fix iommu bitmap allocation

Vasily Gorbik (1):
      s390/kasan: handle DCSS mapping in memory holes

 arch/s390/boot/vmem.c   |  7 ++++++-
 arch/s390/pci/pci_dma.c | 15 +++++++++++++--
 drivers/s390/cio/css.c  |  6 ++++--
 3 files changed, 23 insertions(+), 5 deletions(-)
