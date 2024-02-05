Return-Path: <linux-kernel+bounces-53000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B088849F58
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E667D1F232AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4D44C6B;
	Mon,  5 Feb 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dUA+mIgH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF7446B9;
	Mon,  5 Feb 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149788; cv=none; b=tMzc1qZcJph1DpQviUGTDRzIkil1cgt01WJXSb8Fo9+HI4esSZFtpeI4PJK+rZA6T5RLraB1TS4ATKoIXOcm8idjp+jlR5MihDjSdZnuIU7itbT5J9aQxvlX6ah+m2RScFTWrVqoF1MLBjP4Pj9PLhtH34fppEhHmu4JCaHRGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149788; c=relaxed/simple;
	bh=cVLnSSDuIrEUqurO8au8nS5UEB4MPb9rwK01+4IsWo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qwx0PtU4+J0I8N3VVGtpQIAIDtc1UjaPQlyS+DhGUjNkOZp6V88EP3AAl44qwTrNsDGQaEItvOBtRGy/2vjLVBHoyG8Dw5A9bHp1RElazQ8WoTNG+Q0+4Flfz1kN35NEX3QF93f81/zlOiQwnEudYycoYxOLRY2Rr6qVD4D/0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dUA+mIgH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415DHLrI015193;
	Mon, 5 Feb 2024 16:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=zPu
	0prb4nccSH9+jtCfIlnlhcNHzdd56+EtrKCVstAA=; b=dUA+mIgH+6PSd9yqFbs
	Dq77PpcoD3Ewb378a9TkYkGwJCMh2hdKKQTC2IPeowg3lIMtOgH6jQPXWqiK9+JD
	WiRPT5kQBlz2egSssGQUF86+uLhDtEsuvbfqqampYfbAD7PH5PSCW+CKyFHxz+A+
	uE1Gq3HmrZLeiSiHnORljTX31RovF1m4bDyDoVjPSXXObDdoUiFGnCIHCi8gBJg/
	t+2f21nDNYXnc5k0zgUjifmMjx80qT8/VLUyKjJTXZ5U4MCHk6ebgLUrmAfz7wCw
	PA2CQwOCIQIdSIQsi9RUXJa0nKZqRMZjt1Gs4FN3k0G+Qfsd0djUh3w16geRTD2Z
	GQA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rvj9bye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:16:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415GGJh9006593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 16:16:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 08:16:19 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 5 Feb 2024 08:16:18 -0800
Subject: [PATCH] wifi: ath11k: Really consistently use
 ath11k_vif_to_arvif()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-ath11k_vif_to_arvif-v1-1-7c41313c8318@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANEJwWUC/32NWwrCMBREt1Lut5HcJJbol/uQUtI87EVsNKlBK
 d27sQvwb87AnFkg+0Q+w6lZIPlCmeJUAXcN2NFMV8/IVQbBheKCIzPziHjrC4V+jr1JNbBw4EM
 rnZJODlCXj+QDvTfrpas8Up5j+mwnBX/tf19BhkxLJY86aGydPj9fZGmyexvv0K3r+gUv36Stu
 AAAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cEReiFH1q4CrXsPbZ169JR6Zzt-mpO22
X-Proofpoint-GUID: cEReiFH1q4CrXsPbZ169JR6Zzt-mpO22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=915 bulkscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050123

Patch 9476cda44c13 ("wifi: ath11k: Consistently use ath11k_vif_to_arvif()")
previously replaced all open coding of the ath11k_vif_to_arvif()
functionality. Subsequently two more instances of open coding were
introduced, one in patch 92425f788fee ("wifi: ath11k: fill parameters for
vdev set tpc power WMI command") and one in patch 6f4e235be655 ("wifi:
ath11k: add parse of transmit power envelope element"), so fix those as
well.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index bbf4d1f4d310..18b949352547 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7585,7 +7585,7 @@ void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 				  struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	struct ath11k_reg_tpc_power_info *reg_tpc_info = &arvif->reg_tpc_info;
 	struct ieee80211_channel *chan, *temp_chan;
@@ -7758,7 +7758,7 @@ static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
 					struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	struct ieee80211_tx_pwr_env *single_tpe;
 	enum wmi_reg_6ghz_client_type client_type;

---
base-commit: 2a71528427c635f0a8bff704b2e62ce81c641d6f
change-id: 20240201-ath11k_vif_to_arvif-f50b63d43d3b


