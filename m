Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49B7E1937
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjKFDnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFDnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:43:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D548BD;
        Sun,  5 Nov 2023 19:43:15 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A61u2VA028023;
        Mon, 6 Nov 2023 03:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=OKCw/t7nq8IWz86AirlkzK8qrvqNo3WXJr+ctjpke+8=;
 b=nkDViSWwZKbSH985yDSYTmI2qehm2O5LGHICXhv1k+h7HWh5zvIWW1TvPLfxyYb/teqp
 flyDccDVsouIU5BLYZGPKLCwF3/ZIp2gqHWfLeRivJfXAJr+n21yghkZUGEsY6dNUmwv
 kIRMhK+n8lkLnp53m/+N/2zMJswHMGmsK3VlV3W85Vvs2pd70YvaCkkYSr05yHyQUk3J
 wAKA2xpVMWFdISdk0ojCWNprAeM0sbvn6laI4mocRrv8WohmkClHxrZplwQwE1ROrzlR
 lj78qBI4nKktsLtYghF6ExOBEakWU6Y5woesUEMuv4IN2RfXuBa3FAnj9WeZSW41Epst KQ== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5euytwbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 03:42:58 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A63gt5M027817;
        Mon, 6 Nov 2023 03:42:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3u5f1m0tt1-1;
        Mon, 06 Nov 2023 03:42:55 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A63gsid027812;
        Mon, 6 Nov 2023 03:42:55 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3A63gsR1027811;
        Mon, 06 Nov 2023 03:42:54 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id B35AF5438; Mon,  6 Nov 2023 11:42:53 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH 0/2] Add SDX75 support and its dependency
Date:   Mon,  6 Nov 2023 11:42:50 +0800
Message-Id: <1699242172-79472-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _uxDejwdqeg7rJswcsai-CMBHDgQNH-b
X-Proofpoint-ORIG-GUID: _uxDejwdqeg7rJswcsai-CMBHDgQNH-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_21,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=515
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060029
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add new configuration for SDX75 and new parameter
ready_timeout_ms for waiting ready state. 

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

