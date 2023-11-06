Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9152D7E2BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjKFSVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjKFSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:21:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A9394;
        Mon,  6 Nov 2023 10:21:13 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Gknvh011661;
        Mon, 6 Nov 2023 18:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=ceL5f11GRLXt9jwnLwk2T1E0KMg/oQbyhBZC5O9i/ck=;
 b=mVWEBAGscTxmDukwqBjGf+txaRZLHnP7zohArfTVAqvVr+w8b/7Rb1avsMAT39wLMHra
 mqxjLBy5lAbqdaMXtZpy8PqJCtCbKsDdpiKnP1fCYJQ5pwXZRhlA960FjPt1BoWiMYSn
 vv7ke/ILMhCaGJTb9SUO7b+cVInW5yXZBH+9da3MWNBDBBUVkO+SmN6obNeB90ZgoU5G
 MmZk6cqvhTll3TcFDNI0BSxw/N5r6GQ9gEZj/nE0V6JUeLMcoO9oneiNufP6khvzFZ9Q
 fTTJKRVVyGrsL3oZje123x6P0zVfcdVBm+iDKW+V87fu5+/TQ5twJf+PgUeMOnZZdnug Cw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72c00hum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 18:21:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6IL44E005509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 18:21:04 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 10:21:04 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: ath: Remove unused struct ieee80211_ops *ops
Date:   Mon, 6 Nov 2023 10:21:03 -0800
Message-ID: <20231106-ath12k-remove-ieee80211_ops-v1-0-d72cef1a855b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI8uSWUC/42NQQ6CMBBFr0JmbU2nSFNdcQ9DDLajnRgotthoC
 He3cgKX7/3k/QUSRaYEp2qBSJkTh7EA7iqwvh/vJNgVBiVVjShr0c8e1UNEGkIuIxEZqRAvYUo
 CtXRGN3Sk/gClMEW68Xurn7vCntMc4mc7y/iz/3UzCika7bS+GmNJ2/b5Ysuj3dswQLeu6xd2O
 oF4yAAAAA==
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ha_CJw8WRaAxs88KjvnrEMgUSSCEFpxc
X-Proofpoint-GUID: Ha_CJw8WRaAxs88KjvnrEMgUSSCEFpxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=453 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311060149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both ath11k and ath12k define the following:
	struct ieee80211_ops *ops;

This is being flagged by checkpatch.pl:
WARNING: struct ieee80211_ops should normally be const

But it turns out that in both cases this is unused, so remove it.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Jeff Johnson (2):
      wifi: ath11k: Remove struct ath11k::ops
      wifi: ath12k: Remove struct ath12k::ops

 drivers/net/wireless/ath/ath11k/core.h | 1 -
 drivers/net/wireless/ath/ath12k/core.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)
---
base-commit: ac2f43d3d34e52b0d388b4c573ff6bbac90235b9
change-id: 20231103-ath12k-remove-ieee80211_ops-160d865e9ea4

