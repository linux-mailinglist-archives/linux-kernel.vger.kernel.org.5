Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29587C7500
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379609AbjJLRms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjJLRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:42:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EC7CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:42:46 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CH2IhP007409;
        Thu, 12 Oct 2023 17:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cEqeJI7HQsfdFlGZKhpTdsBgaJEphttefgQPDQdnvZI=;
 b=iLUr6LfADJxjaZqnCSY2cGzJbcmJoJ/oe48r4GxTXDF76IqGGDYmdSvv4SZmQPrMLFfj
 2PXSXZXbmlzZeXr/4+n7SPWE+PnVYXeqx2q11srLprsHOoKSRnSSsYiGZxXxo7JiXF0Y
 DhQZgynWQPdkag2Q9drodI0ZusqYjvEDbVyxm89OFGy1gErUKGDQWNlfxdk3cOIVepgA
 qrEMPisQ6gYBhDxxMjdX5Y+cDstMAy1Pv8tCaopi/U6eQekt+q7ZVSL36AwQq+K/2i87
 ErMZnEcytVZPPZR52j+gNLL2DSI7iVEDuQ/B+i+gMMoX0ivScAtvo0Fr/vm0tUQsvRlX xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpmuj1aha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 17:42:41 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CH2gOl008977;
        Thu, 12 Oct 2023 17:42:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpmuj1ah1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 17:42:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CG6pxg000640;
        Thu, 12 Oct 2023 17:42:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5m13kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 17:42:39 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CHgcCM23397106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 17:42:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BDE258055;
        Thu, 12 Oct 2023 17:42:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B925F58043;
        Thu, 12 Oct 2023 17:42:37 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 17:42:37 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     joel@jms.id.au, eajames@linux.ibm.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        lakshmiy@us.ibm.com
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1] regulator: core: Convert warning to debug print
Date:   Thu, 12 Oct 2023 12:42:35 -0500
Message-Id: <20231012174235.2424670-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iO51A1k9MQ6K7qHX8Xskc2ZxviScW5s5
X-Proofpoint-GUID: sRbHWc3PZtZ_sHtmQK_tHFlwMHILt8Il
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some boards without the vcc regulators for eeprom or other
devices. In such cases, we should not see the following warning and
this confuses the user. We want to see this only when it is compiled
with CONFIG_REGULATOR_DEBUG option.

[0.747347] at24 6-0055: supply vcc not found, using dummy regulator
[0.752877] pca953x 6-0074: supply vcc not found, using dummy regulator

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e1caaf207e..7d2e2495234e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2204,7 +2204,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			 * enabled, even if it isn't hooked up, and just
 			 * provide a dummy.
 			 */
-			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
+			dev_dbg(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
 			get_device(&rdev->dev);
 			break;
-- 
2.39.2

