Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB91078F139
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbjHaQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHaQ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:28:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E82B0;
        Thu, 31 Aug 2023 09:28:23 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VB0DfM012181;
        Thu, 31 Aug 2023 16:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=3PxAJP4NfnF5mvxqtDN21eanTm6iyMe5UVPif6eVHK4=;
 b=LP8oUuysTKJQ7Htspz2THUArF10H344qWcP0q+X14EnzCQUO9XDESeq97ZSqN+g6NIT2
 vdrmfHjiLlfLtermf2mFuePwabaPwT6Pymd5xX4v7zSX/NlUp1Yw/3unu/wueDw0vKrF
 svdvEaoJEFNLXX01tB2OjbpxbkFr0noVSQespx7eukbl/dnODQzUE64/wCUlan8y49sr
 pjW1A8hiXAbP/MmcPJgGUi6OLFWh0neG5Kmiole9plDtMVQ4h6ISkcXPXKxCE1O2ffkX
 aIJr6hM7GCbuNzSiWrBeaiJNLmOxE+T9AW77BdSWjZQ7a5f1s2mzB0ycKk02Fftrj1Vn XA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stku29nxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 16:28:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VGSKmF023526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 16:28:20 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 31 Aug 2023 09:28:17 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 0/5] Add multimode invoke request IOCTl support
Date:   Thu, 31 Aug 2023 21:58:07 +0530
Message-ID: <1693499292-19083-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hebuvt9Y2YbKNXZRBATgNFOpI7GVWGd-
X-Proofpoint-ORIG-GUID: hebuvt9Y2YbKNXZRBATgNFOpI7GVWGd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_14,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=552
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

 drivers/misc/fastrpc.c      | 478 ++++++++++++++++++++++++++++++++++++--------
 include/uapi/misc/fastrpc.h |  39 ++++
 2 files changed, 433 insertions(+), 84 deletions(-)

-- 
2.7.4

