Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FD7ABF06
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjIWI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjIWI4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:56:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4857194;
        Sat, 23 Sep 2023 01:56:48 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38N8rbdD004418;
        Sat, 23 Sep 2023 08:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=lhJM4nHcNVKXoWsAi7uyveJv5UuaJLckzF29N/p01KM=;
 b=kIbC17fSMWhk7C2C6j1nD748svOZsUJRxx8uyvBMWt0UGdgIaPLcfqROhmoy5fUQOISJ
 eFkbB10U726QLAK4aubUuHgQOKz+iZLR1Epb0k0IT2p1GUODf3GDWA8Xdy8SNhdSuM+3
 lQcVr0I0N6nl2UZvkgOyFToIhoP/GIWwDIgZeuDL3MT8ngA+OAq/GEhtH67a2uJ1WKTc
 M0OHpPhwOHE0P9OsWEnWkyqO/hvyEpZHFdl/fD9tvWp/s4knF1x1M0nVFbiQpyYcEKJW
 3+gXYx77w0gL18aMjuEeAVYbi+mD4J7PnXszCAoG/3lHcpP4VsuXS+mrGtjXlT4ujfkl jA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9vwfr172-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Sep 2023 08:56:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38N8cF9e002541;
        Sat, 23 Sep 2023 08:56:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tspcqrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Sep 2023 08:56:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38N8uhbd44761648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Sep 2023 08:56:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECF2C2004E;
        Sat, 23 Sep 2023 08:56:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E99920043;
        Sat, 23 Sep 2023 08:56:42 +0000 (GMT)
Received: from localhost (unknown [9.171.34.117])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 23 Sep 2023 08:56:42 +0000 (GMT)
Date:   Sat, 23 Sep 2023 10:56:41 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.6-rc3
Message-ID: <your-ad-here.call-01695459401-ext-1349@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Htcmc5tdjTL7mBbnoJ6rxRS5wht_Cye9
X-Proofpoint-ORIG-GUID: Htcmc5tdjTL7mBbnoJ6rxRS5wht_Cye9
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-23_06,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=514 mlxscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309230073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.6-rc3.

Thank you,
Vasily

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-3

for you to fetch changes up to 5c95bf274665cc9f5126e4a48a9da51114f7afd2:

  s390/cert_store: fix string length handling (2023-09-19 13:25:44 +0200)

----------------------------------------------------------------
s390 updates for 6.6-rc3

- Fix potential string buffer overflow in hypervisor user-defined
  certificates handling.

- Update defconfigs.

----------------------------------------------------------------
Heiko Carstens (1):
      s390: update defconfigs

Peter Oberparleiter (1):
      s390/cert_store: fix string length handling

 arch/s390/configs/debug_defconfig    | 14 ++++++++++----
 arch/s390/configs/defconfig          | 13 +++++++++----
 arch/s390/configs/zfcpdump_defconfig |  4 ++--
 arch/s390/kernel/cert_store.c        |  7 ++++---
 4 files changed, 25 insertions(+), 13 deletions(-)
