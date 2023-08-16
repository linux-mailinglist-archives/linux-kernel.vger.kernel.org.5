Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03D77E218
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245348AbjHPNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245137AbjHPNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:02:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDD1FF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:02:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GBIg4I005868;
        Wed, 16 Aug 2023 13:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=gKxMbXmQSCBGgVaeiPE/RTBTHJ70HDlWSNhe4Vr/jC4=;
 b=POwKQeA6Bkynj4oV9H0nbi6UXNbpYx4fyZtv++mw79Ozt5xJ0Kf3+EOXP63IDpqj2Lgd
 ExXZOF982xr14nnqHYHIeh3oi33hKaB2KdD5PvlK12jxRxEcstK3BqN4yHSGRSjcxtUb
 tOFkX57yNi4+IPEpy8PNtaCfW4vdDZs3aG3cjtL6DwxhsCWBoFWN+Ng0OGB5s+rht93W
 SCmnNoaF4JXPhy4bVN7g9qbILfQp2L4UTd6t6oD1iwdi9QGAA6a2jZYNSE2lzcAadvua
 RmDbJ/9LZV+/wR0rk3AOx6nyxpxrrBYJw7/FiBdJ1up70uL+XImdYFGKSivYXegzJcC2 pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sg83raq65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 13:01:44 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GD1hho031411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 13:01:43 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 16 Aug 2023 06:01:41 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmem: sec-qfprom: Remove unused variable 'ret'
Date:   Wed, 16 Aug 2023 18:30:57 +0530
Message-ID: <20230816130057.28717-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LIKusHPc6CFqSnk_1lgsAb2X-7fYzEIX
X-Proofpoint-ORIG-GUID: LIKusHPc6CFqSnk_1lgsAb2X-7fYzEIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_12,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=777
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
drivers/nvmem/sec-qfprom.c:59:13: warning: unused variable 'ret' [-Wunused-variable]

Fixes: 9c7f2bce8a0e ("nvmem: sec-qfprom: Add Qualcomm secure QFPROM support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308142248.QsUg82Wt-lkp@intel.com/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20230815202508.0523ecce@canb.auug.org.au/
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/nvmem/sec-qfprom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
index 868a91c81197..e48c2dc0c44b 100644
--- a/drivers/nvmem/sec-qfprom.c
+++ b/drivers/nvmem/sec-qfprom.c
@@ -56,7 +56,6 @@ static int sec_qfprom_probe(struct platform_device *pdev)
 	struct nvmem_device *nvmem;
 	struct sec_qfprom *priv;
 	struct resource *res;
-	int ret;

 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
--
2.41.0

