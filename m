Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F217CD4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJRHDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjJRHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:02:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C96912E;
        Wed, 18 Oct 2023 00:02:53 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I6ox6s021202;
        Wed, 18 Oct 2023 07:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ifqRCltxvTbgUWdpLs0nzht25Xok/zc8SeaY70fDy6c=;
 b=WuOpeexNwt9UmaIAugi13zZLfmsOA90uRL9adXscMchWnNYa0HlIYQUumkvPYppwGl2D
 +uKaeGOWdH35g9KJVcF6iU76/LwDiCeoBXFs41if+OiT3Kx2Jfy1n+9YIsNcju/Hc1tO
 veKpksUqdB0e2RLHPqYhgRHVbDDh27XNC0e0oWFN3y0jUF5EOYT6mZ0CGRDTg9IKyuAQ
 Kf/dz3jbBboJKJMNsfeZiKZDuVBmwKnXeoFLjpBBvoFec82xA1QY08MFKrr1weDnbxux
 MVn75D/vBNpGf2WZSoSY7luKblc08VP29yHdwuactjPNR30yMH6ULyJ7ZM8JBvl22uva EQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsr7c2bhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 07:02:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I72odE020423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 07:02:50 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 00:02:47 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/5] Add multimode invoke request IOCTL support
Date:   Wed, 18 Oct 2023 12:32:35 +0530
Message-ID: <1697612560-9726-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1bLGwZSgh1Cypjs0NCiceBlTjga5d44V
X-Proofpoint-GUID: 1bLGwZSgh1Cypjs0NCiceBlTjga5d44V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_04,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=523
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to support multimode invocation ioctl request. This
ioctl call facilitates multiple types of requests from user including
CRC check, performance counters, shared context bank usage, etc.
This series also carries patch to save and restore interrupted
context.

Ekansh Gupta (5):
  misc: fastrpc: Add fastrpc multimode invoke request support
  misc: fastrpc: Add CRC support for remote buffers
  misc: fastrpc: Capture kernel and DSP performance counters
  misc: fastrpc: Add support to save and restore interrupted
  misc: fastrpc: Add support to allocate shared context bank

 drivers/misc/fastrpc.c      | 491 ++++++++++++++++++++++++++++++++++++--------
 include/uapi/misc/fastrpc.h |  52 +++++
 2 files changed, 458 insertions(+), 85 deletions(-)

-- 
2.7.4

