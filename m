Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72267E2BE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjKFS0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjKFS0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:26:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6994;
        Mon,  6 Nov 2023 10:26:15 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6HDGUP015545;
        Mon, 6 Nov 2023 18:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=XVadJ5FtOZUj7BdXludjBrV8IYXamHKfAgfYVk8+ESo=;
 b=RcOYpPXNOUbjxCpoN1XsPRelvY2mS++TOOlILDelp6/w0nsNBZ9raaACMaP5b0/Ofypt
 jGN4t3ZDhA5UetlsJinKWsnIArrjAGTC6s+CEcird2457GMSM+ybuubXIREADe2lKSHb
 bSDEyNU1V69A2DTkOgSD4ik1/wBlzHXjrFDYAICVFbeLt2u8/FL+2XIEslHamnHxFN2L
 Bu9PidtbeaTLj4BV/MZvBzPx5lvRi9At8NTBMRGiUxCR1XXWEL67HgHF9jlON9HiiH67
 aHUzvY5y/UvijMb2EeWiij2Mhz5ZatzndhCvLDhIwT343+57tQNUv81G4pLeTAObYpip pA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72avrjbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 18:26:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6IQ4I0011305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 18:26:04 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 10:26:04 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 6 Nov 2023 10:26:04 -0800
Subject: [PATCH 2/4] wifi: ath12k: Remove obsolete struct
 wmi_peer_flags_map *peer_flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231106-ath-peer-flags-v1-2-781e83b7e8e8@quicinc.com>
References: <20231106-ath-peer-flags-v1-0-781e83b7e8e8@quicinc.com>
In-Reply-To: <20231106-ath-peer-flags-v1-0-781e83b7e8e8@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WOAlPVjTgU3kIAs4mf9Hu0pzDErDITZI
X-Proofpoint-GUID: WOAlPVjTgU3kIAs4mf9Hu0pzDErDITZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=707 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Currently both struct ath12k_wmi_pdev and struct ath12k_wmi_base
define:
        const struct wmi_peer_flags_map *peer_flags;

But that member is not used, and in fact, struct wmi_peer_flags_map
is not defined within ath12k; these are obsolete remnants inherited
from ath11k. So remove them.

Compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 629373d67421..7d295330e6f1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4770,7 +4770,6 @@ struct wmi_probe_tmpl_cmd {
 struct ath12k_wmi_pdev {
 	struct ath12k_wmi_base *wmi_ab;
 	enum ath12k_htc_ep_id eid;
-	const struct wmi_peer_flags_map *peer_flags;
 	u32 rx_decap_mode;
 };
 
@@ -4784,7 +4783,6 @@ struct ath12k_wmi_base {
 	struct completion unified_ready;
 	DECLARE_BITMAP(svc_map, WMI_MAX_EXT2_SERVICE);
 	wait_queue_head_t tx_credits_wq;
-	const struct wmi_peer_flags_map *peer_flags;
 	u32 num_mem_chunks;
 	u32 rx_decap_mode;
 	struct ath12k_wmi_host_mem_chunk_arg mem_chunks[WMI_MAX_MEM_REQS];

-- 
2.42.0

