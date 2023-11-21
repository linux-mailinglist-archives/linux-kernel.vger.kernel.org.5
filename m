Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778A7F2BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjKULZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjKULZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:25:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9DB9C;
        Tue, 21 Nov 2023 03:25:07 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALAEOFR009217;
        Tue, 21 Nov 2023 11:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jkyYIGLXZhSaLny8SWblEJDMbQIPF1/jb2ZGeBNxml0=;
 b=MyRUS+VAyXgOBZXovUDqH316YDAREF8ClOpYr34J9hocgtu7pVKeovwyg+WC/EaIcACf
 UwkLhjzKba/aB85OofdX+IGDg3kgUTzJzyWwST+g3hk2hdQtyrQBnvBWJMJDsEKjW3nE
 e1G5O9z46k/lsl99PdJ7DzXERVvucuDd8j0uYF4kzmbEa/tOMYjIifij0Uzp7URSPX8k
 t0pQ8jyEV3xGSZ7J7p9OvlBeEKkp/QlFlbkU74g4F/D6ui7WnlEVOwUK6z/3eLWxcm/H
 w1Km8QOZW9UULKnOpMkw74beYGWwmTXWoxqwpGlK65t2AIBg2EJUrwjQkz1oKAmwCRsX DA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugk9p983x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:25:05 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALBP4d5006496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:25:04 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 03:25:02 -0800
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] Add missing features to FastRPC driver
Date:   Tue, 21 Nov 2023 16:54:49 +0530
Message-ID: <20231121112454.12764-1-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BZN1Kc6hb2754u9bfz6OD8dNpdHEg3GT
X-Proofpoint-ORIG-GUID: BZN1Kc6hb2754u9bfz6OD8dNpdHEg3GT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=367
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
- Add wakelock management support

This patch series depends on multimode support series:
[1] https://lore.kernel.org/all/20231121094844.5764-1-quic_ekangupt@quicinc.com/

Ekansh Gupta (5):
  misc: fastrpc: Add early wakeup support for fastRPC driver
  misc: fastrpc: Add polling mode support for fastRPC driver
  misc: fastrpc: Add DSP PD notification support
  misc: fastrpc: Add support for users to clean up DSP user PD
  misc: fastrpc: Add wakelock management support

 drivers/misc/fastrpc.c      | 568 +++++++++++++++++++++++++++++++++++-
 include/uapi/misc/fastrpc.h |   8 +
 2 files changed, 562 insertions(+), 14 deletions(-)

-- 
2.17.1

