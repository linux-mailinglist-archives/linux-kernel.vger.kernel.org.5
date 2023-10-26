Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7C7D7EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbjJZIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344815AbjJZIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:53:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169B1BB;
        Thu, 26 Oct 2023 01:53:28 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q7PTTa025620;
        Thu, 26 Oct 2023 08:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=RJlzOzHC5iZh/utcbPrqXN6D/kAevzLzW2/zGsammJ0=;
 b=Rs60F/HI8AOojrzBo5LaBgVWCqNajN0c5G2CFsXOyGwQji9KeGiAr/wWgURV0DHDTCPy
 iKzWkRQhwOiwFAVIVHjqWIAtATLFVlAC5d9wg7AB2PZykYFgUbk2wuvMgvgZgw32TtBh
 3lTNKQeQ8/oTR1l+D2E8mWtaNfYKDPUyVRWeJXeLbQaZcLvvIcB8CJkWvHldBCGb19pe
 KnKKqVNGf26qgNDzw2GIH7mkOlSyu6LjuRv5nX4RkAGZPY42XbKjqvRj8k2OafYzHcvC
 WtqwUlSQFWgl9HuDa7b6bq7BQ5OT+G3Hq4cHlTMMcuST8x6/Iwo59lHHl/zw4hFIt9ZJ XA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txwjpjwk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:53:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q8rPLN012839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:53:25 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 01:53:23 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Add missing features to FastRPC driver
Date:   Thu, 26 Oct 2023 14:23:16 +0530
Message-ID: <1698310400-5601-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YFzu6ytryBUtZNDrq-ETGUTITu-Vvu4e
X-Proofpoint-GUID: YFzu6ytryBUtZNDrq-ETGUTITu-Vvu4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_06,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=487 priorityscore=1501 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

This patch series depends on multimode support series:
[1] https://lore.kernel.org/all/1698308282-8648-1-git-send-email-quic_ekangupt@quicinc.com/

Ekansh Gupta (4):
  misc: fastrpc: Add early wakeup support for fastRPC driver
  misc: fastrpc: Add polling mode support for fastRPC driver
  misc: fastrpc: Add DSP PD notification support
  misc: fastrpc: Add support for users to clean up DSP user PD

 drivers/misc/fastrpc.c      | 464 ++++++++++++++++++++++++++++++++++++++++++--
 include/uapi/misc/fastrpc.h |   8 +
 2 files changed, 457 insertions(+), 15 deletions(-)

-- 
2.7.4

