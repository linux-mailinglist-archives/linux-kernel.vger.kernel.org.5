Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DD37B2D25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjI2Hmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI2Hmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:42:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FE180;
        Fri, 29 Sep 2023 00:42:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7DfW1028785;
        Fri, 29 Sep 2023 07:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Zz59mZdc5Pusdp8B04rBQ0gXnQBxG2lAxGu36E4tWrg=;
 b=BC1Eo1LQv/2rtGVZK4yDnETXmeV7pl7bCz7gEPrQwXFRHtOc0DjjfyCn7lQW+hDak5Vt
 u+CL+2w4w75gEQTlwiqphso3Vc+G+/i5G0et/EyxFEqTY7VvnrEMntJgWlNI3831atjA
 OkBaJgBYNkxM0Z9k+7cr5t5wZIhBKkmPjzGFaDOhmQDxMb03oIRjabmM7IwuDAam78V4
 ujzr0D1H7oeHJ1geVvB6MfG3jV2flPT/arbSGp6sw5Ioc+zDyN8dvxRnxfaZ8SlsHNGk
 gzAj1u18wyDDnV3btu11d7f4Vt8F6Ye6m/DVoxaY/PWGZumPzrxyhDAce/lXoJ/6Lt/i +g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td24uast9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:42:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T7glQV021063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:42:47 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 29 Sep 2023 00:42:44 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 0/3] Add fixes for FastRPC driver
Date:   Fri, 29 Sep 2023 13:12:37 +0530
Message-ID: <1695973360-14369-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SL3U3ePJ8NltjpQzUqSf-gSqcW-DcBvT
X-Proofpoint-ORIG-GUID: SL3U3ePJ8NltjpQzUqSf-gSqcW-DcBvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_05,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=799 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset carries the following fixes.
- Reset metadata buffer to avoid incorrect fd getting freed
- Free DMA handles for remote calls with no arguments
- Clean buffers on remote call failures

Ekansh Gupta (3):
  misc: fastrpc: Reset metadata buffer to avoid incorrect free
  misc: fastrpc: Free DMA handles for RPC calls with no arguments
  misc: fastrpc: Clean buffers on remote invocation failures

 drivers/misc/fastrpc.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

-- 
2.7.4

