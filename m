Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3787E367F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjKGIPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjKGIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:15:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30D210C2;
        Tue,  7 Nov 2023 00:14:59 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A774Jww002051;
        Tue, 7 Nov 2023 08:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Ye6FCLjWdRk2oDlGqeyerZ54UhxPJCiJAh5veftcq1E=;
 b=dIl5BSrvm3YIlekj8G+jJKFdBHIW3coX9qjrpuVl7Aybo0uXUdJ3bwt79Hrdkff+w6ln
 VW4N8qxOzTm+46+EzTsTwqG6Gajzlz5hZad8zEVaHO2DxTKEyNMHVH10qks/L374W+1L
 fvzuOV51+zJQP9VCOmIvFVLorZwONhm9omJvUwfJDBA6l5ItPaMZB1aTUNo1ageIbFQ5
 J8uXL/Oukb+BS7XZGLF8kkRYOLn1CwJK7OYEu7pgom7l1bAdxO9yFIob8V+AzB2UMswg
 izWLGaE2CXpEOZs5q7U+3Gll9GSIo+n4eFUA+eaHaVfBFIGkQAbO8nsNY9wpKvX7cyG1 KQ== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6wer2wqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 08:14:55 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A78EqTE029303;
        Tue, 7 Nov 2023 08:14:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3u5f1ke4kp-1;
        Tue, 07 Nov 2023 08:14:52 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A78Eq9b029292;
        Tue, 7 Nov 2023 08:14:52 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3A78EqhK029291;
        Tue, 07 Nov 2023 08:14:52 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 70041544C; Tue,  7 Nov 2023 16:14:51 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 0/2] bus: mhi: host: Add SDX75 support and its dependency
Date:   Tue,  7 Nov 2023 16:14:48 +0800
Message-Id: <1699344890-87076-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i9BQc2riPHKNrwNYZaj0HhTFbdrl4scV
X-Proofpoint-GUID: i9BQc2riPHKNrwNYZaj0HhTFbdrl4scV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=609 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070067
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add new configuration for Qualcomm SDX75 and new parameter
ready_timeout_ms for waiting ready state.

v1->v2: Start with "bus: mhi: host:" for the cover letter subjects
v2->v3: Use Qualcomm SDX75 in commit message of the cover letter

Qiang Yu (2):
  bus: mhi: host: Add a separate timeout parameter for waiting ready
  bus: mhi: host: pci_generic: Add SDX75 based modem support

 drivers/bus/mhi/host/init.c        |  1 +
 drivers/bus/mhi/host/internal.h    |  2 +-
 drivers/bus/mhi/host/main.c        |  5 +++--
 drivers/bus/mhi/host/pci_generic.c | 22 ++++++++++++++++++++++
 drivers/bus/mhi/host/pm.c          | 24 +++++++++++++++++-------
 include/linux/mhi.h                |  4 ++++
 6 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.7.4

