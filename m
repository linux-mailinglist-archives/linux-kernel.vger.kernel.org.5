Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877D3767445
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjG1SKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjG1SKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:10:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E044BE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:09:47 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SHL8VH022569;
        Fri, 28 Jul 2023 18:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MiNih1TreF2bQ84DR5ZYkbhz39CI8jbZhgMSwNvh2mI=;
 b=paurwDYT+4t4xkgJyao4rlCHxsnFnYWhROz/3k8TzbKzc9bug2aFHLNUeigJcC2K2hRc
 LHXsEQO2M9LCerqgS/HsFH9/MPCqmdGWa6xrquATlEpJZHE3TRKss606L5DvIZs66rh/
 l/qCqvdjfJQ9S5PrEy36nxpUzg499uUlejDzK2nd3AI1kMuPEO8A0YHort3y36/EpELS
 xkGsWoGiFZhIqHOzAw2lUZQifpf6WiVkqUbv7kkGTcn+UjUHUJ09ypZB6kLDDm0uafc2
 uajS52hamZv8rvJAE/MPAW45GzlV9QGoXcHHToMpD6EkJut760dtjCXNOvQPYrT5al89 3w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4j0g0356-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 18:09:25 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SI9NG6022496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 18:09:24 GMT
Received: from blr-ubuntu-498.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 11:09:20 -0700
From:   Pintu Kumar <quic_pintu@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <hch@lst.de>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <iommu@lists.linux.dev>
CC:     <quic_pintu@quicinc.com>, <pintu.ping@gmail.com>
Subject: [PATCH] dma-contiguous: define proper name for global cma region
Date:   Fri, 28 Jul 2023 23:38:13 +0530
Message-ID: <1690567693-22082-1-git-send-email-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cgVwNJ-yHOn6m5eNHYQPWeBb3RDzPQkv
X-Proofpoint-ORIG-GUID: cgVwNJ-yHOn6m5eNHYQPWeBb3RDzPQkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=737 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current global cma region name defined as "reserved"
which is misleading, creates confusion and too generic.

Also, the default cma allocation happens from global cma region,
so, if one has to figure out all allocations happening from
global cma region, this seems easier.

Thus, change the name from "reserved" to "global-cma-region".

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
---
 kernel/dma/contiguous.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 26a8e53..4628b62 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -237,7 +237,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 	int ret;
 
 	ret = cma_declare_contiguous(base, size, limit, 0, 0, fixed,
-					"reserved", res_cma);
+					"global-cma-region", res_cma);
 	if (ret)
 		return ret;
 
-- 
2.7.4

