Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415867EE198
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjKPNhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjKPNhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:37:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC11A0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:37:17 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGDF6Bk032470;
        Thu, 16 Nov 2023 13:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2f/fmn8IsHKQlBOidJi3QH/ZHjLfdSu+1J0yUaa+0as=;
 b=PbcPtrP/B3SFGkndgZLQozhQEY8xD6WE83sCwV+QtZJfQJ+1rb5ma+WQlZ1zFic9s24W
 6iBkmFowFzgZYt3+n3zMIoyYsybXlf8Ew6eYiUkNR4lMym6NC94IcDHHa+PYLjQmuDtO
 Hb7GZ+BNyXOnnDAfMw0zGNu0jKonLFfhrU/RLLMrPVtxRvWS5ua5hhiP1pb0W5vaWGpk
 uQkDYfWNaUolSStaSFB9BVfaciuM4yV0ZrZxYgQl6oFEqLpwF9uH0bj0H1zaI3TVr94K
 YjAp8hLoFhUTsdoPsV+kKhqfrcfR4u0JJelfee0FKd/kyWE+kcOVZj2YyBbvdZCZzLHS OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udkt18mh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:42 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGDHMga009656;
        Thu, 16 Nov 2023 13:36:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udkt18mga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGBciwo004483;
        Thu, 16 Nov 2023 13:36:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5keewf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGDadOd66519404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 13:36:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0549E20043;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7A7720040;
        Thu, 16 Nov 2023 13:36:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Nov 2023 13:36:38 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Remove unused code after IA-64 removal
Date:   Thu, 16 Nov 2023 14:36:35 +0100
Message-Id: <20231116133638.1636277-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 63Vc0xH7kiEbOTviNrIvez1XiV0TLpMg
X-Proofpoint-ORIG-GUID: u2EpWi-BLgc814pOQDJNEL2L9D-YlmTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_13,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 mlxlogscore=778 bulkscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking into something different I noticed that there are a couple of
Kconfig options which were only selected by IA-64 and which are now unused.

So remove them and simplify the code a bit.

Heiko Carstens (3):
  arch: remove ARCH_THREAD_STACK_ALLOCATOR
  arch: remove ARCH_TASK_STRUCT_ALLOCATOR
  arch: remove ARCH_TASK_STRUCT_ON_STACK

 arch/Kconfig                 | 13 -------------
 arch/powerpc/kexec/core_64.c |  3 +--
 include/linux/init_task.h    |  7 -------
 include/linux/sched.h        |  2 --
 init/init_task.c             | 10 ++--------
 kernel/fork.c                | 26 --------------------------
 6 files changed, 3 insertions(+), 58 deletions(-)

-- 
2.39.2

