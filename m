Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218027C87CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJMOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjJMOYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:24:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F68CE;
        Fri, 13 Oct 2023 07:24:40 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DAuaAC013450;
        Fri, 13 Oct 2023 14:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=L8NexJFtiBE32UC3WUV4sNP/C/3qdQ5NgLrpJU2Wo7E=;
 b=Z21KcenVdRDEmv2SFtWN27J/c66AzKpLLsoSRcqXTzK90JLiM5Jn214l96h9FUMQ500x
 uJfPK6wFAH6tLrhQq+c3lv8U9xHB/fNKbqtvrMQd/B8VFMRVUhlECX63x0VDo6Rw7NVb
 HFtx58uhrKQdp42GX6o36VCbRyn++0Hwe8KLxA0U1NyyfOg6icawExZbkvqs4++vN+9p
 vsSvT07sxT6GbF8HnkgVifvLUErrGmaE8DVxTwp44FVGIHlpFYqFR9p6GNOYpxfn+8ei
 27fHTXSxwYoOD+oopNerBrNDVR03GgCQgLWLvg1zg6Ryn+4MbFH8uOFRmR86sLYswOjf Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tq2xqgk7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:24:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DEO9JB008645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:24:09 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 07:24:09 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: ath: Remove ath*_base::bd_api
Date:   Fri, 13 Oct 2023 07:24:07 -0700
Message-ID: <20231013-ath11k_bd_api-v1-0-3fefe4629706@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdTKWUC/3XMQQ6CMBCF4auQWVvTAYvgynsYQtqh2omRYotEQ
 3p3K3uX/0vet0K0gW2EU7FCsAtH9mMO3BVATo83K3jIDaUsK5SIQs8O8d6bodcTC90S1sfGHsg
 Q5M8U7JXfm3fpcjuOsw+fjV/wt/6TFhRSSFOqpq6UUa06P19MPNKe/AO6lNIX4kEM66wAAAA=
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rJuZxbGD7o1tr1XBWnhU_s4pSqlahjML
X-Proofpoint-GUID: rJuZxbGD7o1tr1XBWnhU_s4pSqlahjML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=465 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both ath11k and ath12k inherited the bd_api member in their struct
ath*_base.  In ath10k this member is accessed from both
ath10k_core_fetch_board_file() and ath10k_debug_print_board_info(), so
it is justified. However, in ath11k and ath12k, this member is only
used within a single function, so it is not justified in those
drivers.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Jeff Johnson (2):
      wifi: ath11k: Remove ath11k_base::bd_api
      wifi: ath12k: Remove ath12k_base::bd_api

 drivers/net/wireless/ath/ath11k/core.c | 7 ++++---
 drivers/net/wireless/ath/ath11k/core.h | 1 -
 drivers/net/wireless/ath/ath12k/core.c | 7 ++++---
 drivers/net/wireless/ath/ath12k/core.h | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 13556aef0bdc0e98df7b6bf2e10d706c59dce6f4
change-id: 20231011-ath11k_bd_api-a9c1678e4cbc

