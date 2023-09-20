Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227E27A721D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjITFeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITFd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:33:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6AA3;
        Tue, 19 Sep 2023 22:33:49 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K5LGn4002276;
        Wed, 20 Sep 2023 05:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=MkHt10FCB7GxRnjv9VZzrYkgEyA3R5AUHIQrT6AoSgg=;
 b=WPXk7WP5Buph/Juahw93Nv14T1rnfda/m4Os5FZc97Vbuf66T2E0gguLdzKGVORwn+In
 2/orHfcQ7gEmYfgmlW0QLITiWMXveSrpmpEyebAPnPA5+qSVNrf5xf235qzlx+/WzD/I
 3GMth/mqJ2sT1eKXVgfvB05KSip2k9sOeYP44MmW5m/lK6Keaf5LQWYaQq7cShJasRUW
 7ELjj7IQpcGb7NOXqrKOe7dAIPoK1NhNSnYI5hBTefpbomQJOny2QddLkNp5aKiAKfER
 xLvul7xngbJZROVoHXs8UGApC+9DmHYdS3pC3fcQblPrcwJ9R2w1yMuey5RJiyIg6FqQ bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7sh3r40v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:33:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K5Xdeh031269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:33:39 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 19 Sep 2023 22:33:35 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>,
        <quic_clew@quicinc.com>, <quic_srichara@quicinc.com>,
        <horms@kernel.org>
Subject: [PATCH V2 net-next 0/2] net: qrtr: Few qrtr changes
Date:   Wed, 20 Sep 2023 11:03:15 +0530
Message-ID: <20230920053317.2165867-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9PA7h-7XhiOHqEd-CH3umaeS4dF2nfhS
X-Proofpoint-GUID: 9PA7h-7XhiOHqEd-CH3umaeS4dF2nfhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=810
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 Addresses a race condition between qrtr driver, ns opening
the control post and sending data to it.

Patch #2 Address the issue with legacy targets sending the SSR
notifications using DEL_PROC control message.

 [v2] Patch #1, 
             Added more appropriate commit text,
             Removed a redundant check and fixed local variables
             in reverse-christmas tree order.

      Patch #2,
	     Fixed a sparse warning.

Chris Lew (1):
  net: qrtr: Prevent stale ports from sending

Sricharan Ramabadhran (1):
  net: qrtr: Add support for processing DEL_PROC type control message

 include/uapi/linux/qrtr.h |  1 +
 net/qrtr/af_qrtr.c        | 74 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

-- 
2.34.1

