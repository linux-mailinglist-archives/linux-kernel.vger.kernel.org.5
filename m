Return-Path: <linux-kernel+bounces-93075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349E7872A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF771F2290F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3F12D20E;
	Tue,  5 Mar 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DVSzHtou"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DE12CD8B;
	Tue,  5 Mar 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679430; cv=none; b=Kaoe/JQTEZ6rBLAIS7Jp9i9CgXOf5x0Jb85DiOxORu1P2f+py3Sk7jYViLLsEqUSwtPnahraST5+YQsvYl2DWP15Oc1ph8MDGaxt0QV0KjQUu1++3OzIZrQ06XTqHr307y7DBP0jKi3DC2IZzqTdwd+wDAuysbsRv2fD+COEYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679430; c=relaxed/simple;
	bh=rp0gPK4EeOuHqGO2Gs1iRSOyAflr2XcSUE/rs3uBvrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jb0geP/Zvz2Yode57gVHCtj87QIkFA3d4zMiRzEwqhPp/t4wVQjhAkM6NgYWVSzFr4r8Bxv4kGRpkXc+rrrB6/7uUUEJL8DUnkdo5+jHU5lr/VQp25wMw/YYU0c1rO51ybixSpgYdZ5kiolzPYf8zImPtxcNaIrFwnTuIFyCWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DVSzHtou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425MnQX7011485;
	Tue, 5 Mar 2024 22:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=am3hGTNnk/zo+P481rb5C0LwEy/0ZM20GvqbwO7vWOI=; b=DV
	SzHtou+wwlQknpvBycjXn+leUNsQsiKPVeF8uoNHubWg5FsYbWEdYl5MXBruGz+6
	Wi2eCCxvTv+S54TCnLZ80De12TWMcr2F3yPKoNzf0c5s7DFpDqGh3ptKjJdIa3UC
	nPdQcH53nxChP0Et0IZqdGyP9rUuQE+AgHjRxX0HDTyAoSKb3nn5qS735eZPBm6/
	+wmRooeVEtqzjLsU32Hdt0rXvcZa8CsBzl13AoRdREx2wx0aSoXf30RFT0QtsHiS
	F2bJXiL5qj3gym3a9Ep9yQeW1PagMnsPsOvrwAL3H5BaFZ/ViRjqGFz6b5upg3ht
	WkEQEQvBQlEN4+SgVRMw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp2uwsdbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 22:57:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425Mv3a1006479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 22:57:03 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 14:57:03 -0800
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: <djakov@kernel.org>
CC: <robdclark@chromium.org>, <quic_rlaggysh@quicinc.com>,
        <quic_okukatla@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH] interconnect: Don't access req_list while it's being manipulated
Date: Tue, 5 Mar 2024 14:56:52 -0800
Message-ID: <20240305225652.22872-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 14Gq446lONzfmA0m4rJDC1Y8R6zE_rhK
X-Proofpoint-ORIG-GUID: 14Gq446lONzfmA0m4rJDC1Y8R6zE_rhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_18,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050183

The icc_lock mutex was split into separate icc_lock and icc_bw_lock
mutexes in [1] to avoid lockdep splats. However, this didn't adequately
protect access to icc_node::req_list.

The icc_set_bw() function will eventually iterate over req_list while
only holding icc_bw_lock, but req_list can be modified while only
holding icc_lock. This causes races between icc_set_bw(), of_icc_get(),
and icc_put().

Example A:

  CPU0                               CPU1
  ----                               ----
  icc_set_bw(path_a)
    mutex_lock(&icc_bw_lock);
                                     icc_put(path_b)
                                       mutex_lock(&icc_lock);
    aggregate_requests()
      hlist_for_each_entry(r, ...
                                       hlist_del(...
        <r = invalid pointer>

Example B:

  CPU0                               CPU1
  ----                               ----
  icc_set_bw(path_a)
    mutex_lock(&icc_bw_lock);
                                     path_b = of_icc_get()
                                       of_icc_get_by_index()
                                         mutex_lock(&icc_lock);
                                         path_find()
                                           path_init()
    aggregate_requests()
      hlist_for_each_entry(r, ...
                                             hlist_add_head(...
        <r = invalid pointer>

Fix this by ensuring icc_bw_lock is always held before manipulating
icc_node::req_list. The additional places icc_bw_lock is held don't
perform any memory allocations, so we should still be safe from the
original lockdep splats that motivated the separate locks.

[1] commit af42269c3523 ("interconnect: Fix locking for runpm vs reclaim")

Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
Fixes: af42269c3523 ("interconnect: Fix locking for runpm vs reclaim")
---
 drivers/interconnect/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 5d1010cafed8..7e9b996b47c8 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -176,6 +176,8 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
 
 	path->num_nodes = num_nodes;
 
+	mutex_lock(&icc_bw_lock);
+
 	for (i = num_nodes - 1; i >= 0; i--) {
 		node->provider->users++;
 		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
@@ -186,6 +188,8 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
 		node = node->reverse;
 	}
 
+	mutex_unlock(&icc_bw_lock);
+
 	return path;
 }
 
@@ -792,12 +796,16 @@ void icc_put(struct icc_path *path)
 		pr_err("%s: error (%d)\n", __func__, ret);
 
 	mutex_lock(&icc_lock);
+	mutex_lock(&icc_bw_lock);
+
 	for (i = 0; i < path->num_nodes; i++) {
 		node = path->reqs[i].node;
 		hlist_del(&path->reqs[i].req_node);
 		if (!WARN_ON(!node->provider->users))
 			node->provider->users--;
 	}
+
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 
 	kfree_const(path->name);
-- 
2.17.1


