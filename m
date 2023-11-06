Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541ED7E2BDB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjKFS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjKFS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:26:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF8D94;
        Mon,  6 Nov 2023 10:26:14 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FMouU010307;
        Mon, 6 Nov 2023 18:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=RRWRgFaAfm7cZ7J8Siauhh/pe7RSZ+2aVReaG7ZVh64=;
 b=ke9M8AKX+yB+eUwBFNj10BkCs/MHJx1AVXv6peYVMYCClfE9cIiLY+2IuoI+Vb+daron
 Myr1PUy4lUU7liROGJlJxAgDe9ho3Z0TmP5brJfJDzYFrkDV/g5obX0EpmXz9Zu6Cj2+
 VSCO2BKCxdD1MkqfFthGh4RcNikX1OnjRIOQsEDm+Nf96Lra7leSssMZtiUDLkQZbskz
 rmYPbNqxBgmRei9VGKjvDjW1rp0b4eDTbHu6NXYqSiScIQCC05vMGZ+1ZugPDvDmDkWL
 JCgJifATOYBxWrB+DZjI8hBxxIgU/1ZvCKuZSkQZBtwSG2RxZp9/LyeSF+zFPSTBdnck Hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72r28f9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 18:26:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6IQ4X7029692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 18:26:04 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 10:26:03 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/4] wifi: ath: Cleanup WMI peer flags
Date:   Mon, 6 Nov 2023 10:26:02 -0800
Message-ID: <20231106-ath-peer-flags-v1-0-781e83b7e8e8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALsvSWUC/33MQQ6CMBCF4auQrq1ppyroynsYF8O0hUkUsMVGQ
 7i7hZ0LXf4ved8kogvsojgVkwguceS+y6E3haAWu8ZJtrkFKDBaK5A4tnJwLkh/wybKCnboTaW
 gVLXIpyE4z68VvFxztxzHPrxXP+ll/UklLZUktMaCLRHr+vx4MnFHW+rvYsES/AcgA/7oywMZs
 lrvv4F5nj8UNqe87wAAAA==
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
X-Proofpoint-GUID: kR5dy0D9mzBaXAl28jm49zqSGNjHBM1y
X-Proofpoint-ORIG-GUID: kR5dy0D9mzBaXAl28jm49zqSGNjHBM1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=314 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both ath11k and ath12k inherited from ath10k some WMI peer flag
definitions that are unused, so remove them.

This series is compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Jeff Johnson (4):
      wifi: ath11k: Remove obsolete struct wmi_peer_flags_map *peer_flags
      wifi: ath12k: Remove obsolete struct wmi_peer_flags_map *peer_flags
      wifi: ath11k: Consolidate WMI peer flags
      wifi: ath12k: Consolidate WMI peer flags

 drivers/net/wireless/ath/ath11k/wmi.h | 61 ++++++++++-----------------------
 drivers/net/wireless/ath/ath12k/wmi.h | 63 +++++++++++------------------------
 2 files changed, 37 insertions(+), 87 deletions(-)
---
base-commit: ac2f43d3d34e52b0d388b4c573ff6bbac90235b9
change-id: 20231102-ath-peer-flags-824af380270b

