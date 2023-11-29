Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3987FCF90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjK2G6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjK2G6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:58:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90119A6;
        Tue, 28 Nov 2023 22:58:25 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASNSLx9025752;
        Wed, 29 Nov 2023 06:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=LsICOZfGK90sPM4D4fqzedjtuDu0jx2XyVM/Kw8raRE=;
 b=jZBN/JzjtUulhYeuqNV//7MAOyI6Ur5aSWpcUDlbMnJEbWHlBKXryeZgqd7JNwkPoKfN
 EvWsNbfC5S3QJdIE4tY4iF6no/jGK6/fbnidZF3aH3ufn27Xrjwr7jk79L49UUCbH7fy
 No+l8fjgTXZQiPm/T/kQHQImIdWExSwqj4YxrrhBzzKeoeoKqeE0tD2+L+1GUB/mtkrK
 1iFFHNe0fs90XwITRZubX+gM2QG7W5jI5uBukKImpHfICLDHNTwS6+7pc7URv6kLnIoO
 aMbDpp3tj1mHTR9shw/ml9JhhtE6PJdrMOnliXyXjOredhAcwaSRvDUg0TzJybmh9I5b UA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unnpese8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 06:58:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT6wKsR020954
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 06:58:20 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 28 Nov 2023 22:58:16 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mdtipton@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <quic_asartor@quicinc.com>,
        <quic_lingutla@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 3/3] firmware: arm_scmi: Increase the maximum opp count
Date:   Wed, 29 Nov 2023 12:27:48 +0530
Message-ID: <20231129065748.19871-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129065748.19871-1-quic_sibis@quicinc.com>
References: <20231129065748.19871-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AR6n_PD1s-LLN0Fb8fWTsRCyat1A1kzT
X-Proofpoint-ORIG-GUID: AR6n_PD1s-LLN0Fb8fWTsRCyat1A1kzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_03,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=793 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of opps on certain variants of the X1E80100 SoC are greater
than current maximum, so increase the MAX_OPP count to the next log level
to accommodate that.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 3344ce3a2026..edf34a3c4d6a 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -24,7 +24,7 @@
 #include "protocols.h"
 #include "notify.h"
 
-#define MAX_OPPS		16
+#define MAX_OPPS		24
 
 enum scmi_performance_protocol_cmd {
 	PERF_DOMAIN_ATTRIBUTES = 0x3,
-- 
2.17.1

