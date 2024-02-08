Return-Path: <linux-kernel+bounces-58806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6F384EC4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874E3B28051
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992A50271;
	Thu,  8 Feb 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lGM7vBWV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FB50244;
	Thu,  8 Feb 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433926; cv=none; b=euynMnm6Cil6fvM5wPd/9Re5rbuty3r4m6T8cNNTmwIh8EBPd91WkHZ6dP6sM4qecUoAigrdF1Hth+1kh6pdsz6/jPRD8fgyjZ7JQp/7BiFuu2dUc/6mYI6qjRVpPEtDi1QIOXPkvnMBE6tdq60LfVFKG9c3nEWU7EVmgWmnr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433926; c=relaxed/simple;
	bh=DVFoMTR1w9+PzhHgP5navN+7GT8dw0J1k5hs5Fwa09s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPnte1uNixeIU35sPHejmvoybZRhcyTbiiI3UnL8oqaBYrm7qlgaifJTTVcGyojVl6bKJGqVSmYoIMrMb/9b04vz7O6yJj+SRMQmy/rOKn0NlUE67136Aw26uHZWnPkR8BH6YvpcEwl05i6s/edGtQKDbdIgZvJX1Skdo6Bv7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lGM7vBWV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418KN0nj017495;
	Thu, 8 Feb 2024 23:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=MYr7RqbkI24DdXTRPAmW
	g5WD1wbGsIeujnA+npP7CZk=; b=lGM7vBWVWAiE73Ea96rN8OBaBjzmIKqbUzre
	JSDJck0HOKz4OmLFSpoZz2DyyC2ii7a3OovKb0x06/YOP6D9UOjw9IMWRs/48ToL
	KGkVBO3+fOIBkiWyjW6D7Ca6Nv1OIz9djfHtbWAwkxZSGGGOkI/fCrdGwvq3b3GT
	1+NcKvXPNhUenRM0IYXoNr+mdZpl62ABlvNwJXhBjzm+Y2kP20NOvzeG+JlqsRGN
	u8klHYYZCU4ofVcxNChuSg1kdlMczjsTjZ+kFz8QsIraYTHHDDIfxuCvbRCUSGWH
	1eDbDT2KHFH6X31ZhjGYiHlcsZiZtx5JSDiY+CplpQ/0Lm2qwQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4uphsypf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:11:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 418NBjM4006159;
	Thu, 8 Feb 2024 23:11:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3w502k31bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:11:45 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418NBjjU006154;
	Thu, 8 Feb 2024 23:11:45 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 418NBjK2006153
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:11:45 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 6BA832270D; Thu,  8 Feb 2024 15:11:45 -0800 (PST)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: kernel@quicinc.com
Subject: [PATCH net-next v4] net: stmmac: dwmac-qcom-ethqos: Enable TBS on all queues but 0
Date: Thu,  8 Feb 2024 15:11:45 -0800
Message-Id: <20240208231145.2732931-1-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: osft6LiMV2DWc-ZUSgATWs8TH2yP2Kf7
X-Proofpoint-GUID: osft6LiMV2DWc-ZUSgATWs8TH2yP2Kf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=873
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080131

TSO and TBS cannot co-exist. TBS requires special descriptor to be
allocated at bootup. Initialising Tx queues at probe to support
TSO and TBS can help in allocating those resources at bootup.

TX queues with TBS can support etf qdisc hw offload.

This is similar to the patch raised by NXP
commit 3b12ec8f618e ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings")

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v3:
- The change is Tested-by Andrew Halaney <ahalaney@redhat.com>
  on Qualcomm Ride platform
- Change log is removed from the commit text

Changes since v2:
- Fixed the styling of comment in the dwmac-qcom-ethqos.c
- Followed the upstream format to give other glue
  driver references to solve the same problem
- Appended  the subject with net-next
- Discussion of why this patch is required is discussed in
https://lore.kernel.org/netdev/c2497eef-1041-4cd0-8220-42622c8902f4@quicinc.com/

Changes since v1:
- Subject is changed as per upstream guidelines
- Added a reference of a similar change done by NXP in
  body of the commit message

 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 31631e3f89d0..2691a250a5a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -728,7 +728,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	struct qcom_ethqos *ethqos;
-	int ret;
+	int ret, i;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
 	if (ret)
@@ -822,6 +822,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}
 
+	/* Enable TSO on queue0 and enable TBS on rest of the queues */
+	for (i = 1; i < plat_dat->tx_queues_to_use; i++)
+		plat_dat->tx_queues_cfg[i].tbs_en = 1;
+
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
-- 
2.25.1


