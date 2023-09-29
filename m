Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4533C7B2CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjI2HAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjI2HAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:00:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5591A5;
        Fri, 29 Sep 2023 00:00:50 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T6knHI011069;
        Fri, 29 Sep 2023 07:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dzNv6I8ssnUHDK3cRH/+aA2ScM8TjKIX1N+wXRxSrGc=;
 b=R+uJ/JlZbL+IshSSE3JgVJl3I9c2anhqnu6wTNb+LVepv81Yt9Sn1HRR4VEwrwiKlSWv
 B4umEka9co8LXk7XsI4PzlTy9K1o9YgjUoID7CEErMe9WgxNaWpp7J7X8nyUPjkJ0u2n
 9R5SrKLwo3OW+6OppRMkeDxqFCySornIawy2FjpkY+Tk0OuD5FQkL79DkhiGp6+mmjbO
 e7cSyD+U5Xr9UDHmtH0/dNWmMTtxSrEZ9ZJ3ram4UvLrsg6T8jhlCP2HPgAjnGQ3D76w
 zcQzSRtYTLOJcuwiyhazlkRtJ8u5MbTU4H3jRdijDeaWngtvt9S+YDmhERADHoBzKEQd eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdhru0mg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:00:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T70lHX027229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:00:47 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 29 Sep 2023 00:00:44 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 0/4] Add missing features to FastRPC driver
Date:   Fri, 29 Sep 2023 12:30:26 +0530
Message-ID: <1695970830-12331-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ilzxDUG-4gRh_M40ux0JNz4m4WDsh4qf
X-Proofpoint-GUID: ilzxDUG-4gRh_M40ux0JNz4m4WDsh4qf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_04,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the listed features that have been missing
in upstream fastRPC driver.

- Add early wakeup support to allow DSP user to send early response
  to CPU and improve fastrpc performance.
- Add polling mode support with which driver polls on memory to avoid
  CPU from going to low power modes.
- Add notifications frameworks to provide users with the DSP PD status
  notifications.
- Add a control mechanism to allow users to clean up DSP user PD

Ekansh Gupta (4):
  misc: fastrpc: Add early wakeup support for fastRPC driver
  misc: fastrpc: Add polling mode support for fastRPC driver
  misc: fastrpc: Add DSP PD notification support
  misc: fastrpc: Add support for users to clean up DSP user PD

 drivers/misc/fastrpc.c      | 463 ++++++++++++++++++++++++++++++++++++++++++--
 include/uapi/misc/fastrpc.h |   8 +
 2 files changed, 456 insertions(+), 15 deletions(-)

-- 
2.7.4

