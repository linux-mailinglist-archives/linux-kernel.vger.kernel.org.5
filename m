Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54C79C2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbjILCVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbjILCUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:20:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B252769E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:43:09 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMSZG0010734;
        Mon, 11 Sep 2023 22:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kTFHJn2S/c7IFWD+LKXoP8nJNVtexf0j4tHWjlm2E1s=;
 b=K/M6fhjARGvLiOr9XsWVjgwLiiuc94pEqU4ldVxoK6NPGD+dsIxlUObCKe3vLyas5+V2
 +2KE7n5tMTOf1C7Wo/3LfM0P6hPKQfLLKUAmqXkGKD9eEN7dq084ThwtcxO9fbFEkNiJ
 mCkxmfTaHQ/WyaldKmr9jmZQFJEFaLDkQihLL8E5lJ0mBCPC123dOr3KCA75zj8+5L7Z
 QYIzCWh0jvptd3AjbgqzU5a+VnhISWybF6DmCTvgpl+JzeJQAkqu3Pu/2+gwCmK8wvda
 riGYLar78+F+VcyRpk81plhlSHhism9ZNE4nMGyVHE/q20aJtv5lRBOaG8oxNj+lu1Is OA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2bq9rdsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:38:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BKeBTA002410;
        Mon, 11 Sep 2023 22:38:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158jwww6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:38:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BMcCWe61473032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:38:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0958A5806D;
        Mon, 11 Sep 2023 22:38:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0C3C5806E;
        Mon, 11 Sep 2023 22:38:11 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 22:38:11 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v2 0/2] fsi: sbefifo: fixes
Date:   Mon, 11 Sep 2023 17:38:07 -0500
Message-Id: <20230911223809.3505431-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ab-sd5BAAgRjS7JKi55JudtDsqj6ytSX
X-Proofpoint-ORIG-GUID: Ab-sd5BAAgRjS7JKi55JudtDsqj6ytSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxlogscore=646 clxscore=1015 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Please review the version 2 of patchset. I have incorporated review
comments by Joel.

Ninad Palsule (2):
  fsi: sbefifo: Bump up user write cmd length
  fsi: sbefifo: Validate pending user write

 drivers/fsi/fsi-sbefifo.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.39.2

