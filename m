Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA947706A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjHDRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjHDRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:06:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25380198B;
        Fri,  4 Aug 2023 10:06:36 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374H0Nkp010444;
        Fri, 4 Aug 2023 17:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=xqfMw6XKPKcjh4M4gVckVU1kKfLsqZcU56TDYjL3Pj8=;
 b=VQYF7zOqcZEJs+4TW/pdZD0h838xQ0JjSIyUXSTo8tq0a4watRWR6BoyNJ8oSHBdvRuO
 vy9idbyxorw3R9On6Wrl6xJ/THE9ekwok5RYUucgH+RY5XnRTkALL4AmiGtuIjxQuEos
 HQ5LJ4FFtXYooRppmQK80p5EjI6NQ+eOh3y2qdsgidT1m8thIIJggVAM2KkIQZJq4hZP
 +WNbHI2l3N+xI5esSKCgSn6Sie1jiPy3qh5/Ixa1a+CUBwrpZo/vUrMjRY4Wplk/cXTg
 G3PnwRzIR2yoRNCZW2hbqdWl/1tE7zMLkm+2l07+m7UY3uyYNo3XWr28t58QOfhReMpu KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s95bsg59w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 17:06:29 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374H1wqK016842;
        Fri, 4 Aug 2023 17:06:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s95bsg59d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 17:06:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374FrfLJ021566;
        Fri, 4 Aug 2023 17:06:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kmcfh8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 17:06:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374H6P3W60817766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 17:06:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1860E2004D;
        Fri,  4 Aug 2023 17:06:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AECDE20040;
        Fri,  4 Aug 2023 17:06:24 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.155.208.153])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 17:06:24 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] net/smc: Fix effective buffer size
Date:   Fri,  4 Aug 2023 19:06:22 +0200
Message-ID: <20230804170624.940883-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QIqSaFGeEF69K_E-YoZtcGIXQhNfPaBS
X-Proofpoint-GUID: yhSKcdVY6SjF60-QbYRMecX2gNfKnEwF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_16,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=670 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040149
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
and make them tunable") started to derive the effective buffer size for
SMC connections inconsistently in case a TCP fallback was used and
memory consumption of SMC with the default settings was doubled when
a connection negotiated SMC. That was not what we want.

This series consolidates the resulting effective buffer size that is
used with SMC sockets, which is based on Jan Karcher's effort (see 
[1]). For all TCP exchanges (in particular in case of a fall back when
no SMC connection was possible) the values from net.ipv4.tcp_[rw]mem
are used. If SMC succeeds in establishing a SMC connection, the newly
introduced values from net.smc.[rw]mem are used.

net.smc.[rw]mem is initialized to 64kB, respectively. Internal test 
have show this to be a good compromise between throughput/latency 
and memory consumption. Also net.smc.[rw]mem is now decoupled completely
from any tuning through net.ipv4.tcp_[rw]mem.

If a user chose to tune a socket's receive or send buffer size with
setsockopt, this tuning is now consistently applied to either fall-back
TCP or proper SMC connections over the socket.

Thanks,
Gerd 

v2 - v3:
 - Rebase to and resolve conflict of second patch with latest net/master.
v1 - v2:
 - In second patch, use sock_net() helper as suggested by Tony and demanded
   by kernel test robot.


Gerd Bayer (2):
  net/smc: Fix setsockopt and sysctl to specify same buffer size again
  net/smc: Use correct buffer sizes when switching between TCP and SMC

 net/smc/af_smc.c     | 77 ++++++++++++++++++++++++++++++--------------
 net/smc/smc.h        |  2 +-
 net/smc/smc_clc.c    |  4 +--
 net/smc/smc_core.c   | 25 +++++++-------
 net/smc/smc_sysctl.c | 10 ++++--
 5 files changed, 76 insertions(+), 42 deletions(-)


base-commit: 1733d0be68ab1b89358a3b0471ef425fd61de7c5
-- 
2.41.0

