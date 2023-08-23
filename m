Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5E785E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbjHWRbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbjHWRbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:31:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777210C2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:31:41 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NHNfaA012986;
        Wed, 23 Aug 2023 17:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=iOBugGskYHmD0uJFkfQL4c+7e2X+OOWA3+L/qWS03Vk=;
 b=HH+SqFStYfRpdnTK3fGjDobC3kUMLSLIvmx+Ye2VFvs76Rm+CWSxh6itM4Gc8I0rN1cs
 ob15T90nH/nK8OhobfkY67+se7flt71TDpS96erCFoZqAWnnCd+vkG3wN61VIyFhsxdO
 jpCDAZQFDg5Wym5eYfR2J80vZP9Nx5MBdrgBP+8O3exwwjPxQapzgAepY4qvP39ODPJW
 yExbdkhfpEg6O9ee5PwB8XBC1a28/rrVOwXNos8XzDSiCwnEmDq4wyjMfVdS2vwIigUI
 PMgS9AYNdBTimwE4CYL0/3rsQtByr73+9VspMFlMuGr2MRAfu4t0bSoCZeNOKsJJwj8z 6A== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snp7a0m5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 17:31:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37NGfdHJ016435;
        Wed, 23 Aug 2023 17:31:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn227r672-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 17:31:10 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37NHV9ST34669158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 17:31:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C13D058065;
        Wed, 23 Aug 2023 17:31:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C05F5805A;
        Wed, 23 Aug 2023 17:31:09 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Aug 2023 17:31:09 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com
Cc:     Ninad Palsule <ninad@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 0/1] Host side BMC device driver
Date:   Wed, 23 Aug 2023 12:31:03 -0500
Message-Id: <20230823173104.3219128-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZyRyjJk49C0uHXMgTFHXfzxt3tHL8j6u
X-Proofpoint-GUID: ZyRyjJk49C0uHXMgTFHXfzxt3tHL8j6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_12,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=574
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This is a version 2 patch. I have incorporated review comments
and fixed warning reported by kernel test robot.

Ninad Palsule (1):
  soc/aspeed: Add host side BMC device driver

 drivers/soc/aspeed/Kconfig               |   8 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 250 +++++++++++++++++++++++
 3 files changed, 259 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.39.2

