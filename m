Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23E97766FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjHISIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHISIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:08:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127210F5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:08:35 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379I1SeW009386;
        Wed, 9 Aug 2023 18:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8qGuDNGJVKuGDnU/yhmu80z32ACGSZoOoL3arqIjno8=;
 b=oW5HEZ1aY/woTANUqKt0EBf5RlyVAViNAJS4V2WgDz5+5pvQa6J6O8720JvtSiMNFH3G
 KJqgWcxKEboUVroDcRBuknboQA0SqzNaFmQS42Zxfu8p0v4HSbZRSVGFzU1MXGg2f3Er
 UNRLEi55xI9/09FyiNkSrctQH4JxjqRsUAHVUYtoS9WGIvVLM5zWTxBdTZMPPpFQdCCu
 iF9Q5f8p0sSVI1uiKOgooVS4nKvixgPj+aUCsdt8zRGT8N7qsIfIIy2x5U+tMc8J4V+5
 vqt4ot8dG6oBW/atbyx0+8tiGGfqFdPMa2xwHQuU+5iUl43aBxVawXV3zQMvwWyIjM3L vA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scfq50cxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:08:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379HOcp1030353;
        Wed, 9 Aug 2023 18:08:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rnjgxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:08:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379I8Ijx4260578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 18:08:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C235805E;
        Wed,  9 Aug 2023 18:08:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E7CE5805D;
        Wed,  9 Aug 2023 18:08:18 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.73.158])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 18:08:17 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     joel@jms.id.au, linux-kernel@vger.kernel.org,
        alistair@popple.id.au, k@ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] fsi: Improve master indexing
Date:   Wed,  9 Aug 2023 13:08:12 -0500
Message-Id: <20230809180814.151984-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IEYtS56APnqo89FpfhqS9S7S_mOTUeFp
X-Proofpoint-ORIG-GUID: IEYtS56APnqo89FpfhqS9S7S_mOTUeFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_16,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=667 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some issues with FSI scanning and device registration.

Eddie James (2):
  fsi: Improve master indexing
  fsi: Lock mutex for master device registration

 drivers/fsi/fsi-core.c        | 40 +++++++++++++++++++----------------
 drivers/fsi/fsi-master-i2cr.c |  4 +---
 drivers/fsi/fsi-master-i2cr.h |  9 ++++++++
 drivers/fsi/fsi-master.h      |  1 -
 drivers/fsi/i2cr-scom.c       |  2 +-
 5 files changed, 33 insertions(+), 23 deletions(-)

-- 
2.39.3

