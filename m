Return-Path: <linux-kernel+bounces-109228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACC881677
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABFEB23AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA806E2AA;
	Wed, 20 Mar 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MIDLcd7U"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61706A35F;
	Wed, 20 Mar 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955247; cv=none; b=SE/wwIjmb7MTMdCFWqNTp62OoizPxkg0LJIhrOVL3pKIo8yosDlhTRhgwjT9l4zQHlvkOAn/mScUnPIsy/yVgRKXs+byhEYnKvbFxjjO3Wbbzrv7UIRQiW2XnWZMJS10a1mZh/n/oFzFJZLlAonjhzf2vGssNTR2NTHqls0k1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955247; c=relaxed/simple;
	bh=poPQEITnyrIDULNTnvjDHS0Cg6w/a22EvIAT6aLzFWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D75kUBJpr+gg8CoUez7VBjfKVwxNFt+39TH5IUJeyv/nEkcHP5lBCHs6qxiF1/qeg1vW4On5QUHelxZWxMe/ExF78uSzXxm3jIrN2Ww4Runp7r0EXGHkFQ1OiGlW8J2lPEBts73RLR6wEMVT3gyfoIBwM2ZQAs52dAcUd2YW4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MIDLcd7U; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KFJHDe003970;
	Wed, 20 Mar 2024 10:20:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=1uT73EtgrEIN+G8RFHbk37HPotPJFAnZS5+C5PYjCtM=; b=MID
	Lcd7UGUNaPQ5ICGO4Kcnna57iZXBEDAm5RIiOdiBXrkcUctpQ1zPRysP/YDa79cN
	NW8HMH7KkP6gTMHSK3v3JbvNRXCStWzOG8NvTN+8xHVEqIAVFDoeplHDM4ZptnXD
	B4IxdAtOMBz6ljSTff1RiVAQD31b4iaQm9i9mnUsJcK8l76rbqsWVXp6QUPCWUgG
	dh8L0nNoxDeM7w3znIhQoNKxSP0fE7uYhhpMZJbYHCisVWvKo2AW9VVE0bejFQ8Z
	dUB2CkuIr/HeYdryoXcklylODH3yO+n2mtonQCsRsihepUkhDwUmljOdSsLpJzzg
	f57UoT71DUba1YvzRwA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka52e3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 10:20:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Wed, 20 Mar 2024 10:20:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Wed, 20 Mar 2024 10:20:26 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 8A9625B692A;
	Wed, 20 Mar 2024 10:20:22 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <przemyslaw.kitszel@intel.com>,
        <dkirjanov@suse.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 3/5] net: marvell: prestera: fix memory use after free
Date: Wed, 20 Mar 2024 19:20:06 +0200
Message-ID: <20240320172008.2989693-4-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320172008.2989693-1-enachman@marvell.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NrP0FnnWxeoTIjyEfaMx2OvyMnZFL6qO
X-Proofpoint-ORIG-GUID: NrP0FnnWxeoTIjyEfaMx2OvyMnZFL6qO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Prestera driver routing module cleanup process would release memory,
then reference it again and eventually free it again the second time.

Remove the redundant first memory free call.
All such double free calls were detected using KASAN.

Fixes: 4394fbcb78cf ("net: marvell: prestera: handle fib notifications")
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_router.c    | 1 -
 drivers/net/ethernet/marvell/prestera/prestera_router_hw.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/drivers/net/ethernet/marvell/prestera/prestera_router.c
index de317179a7dc..2da04a17efad 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
@@ -1638,7 +1638,6 @@ void prestera_router_fini(struct prestera_switch *sw)
 	prestera_k_arb_abort(sw);
 
 	kfree(sw->router->nhgrp_hw_state_cache);
-	rhashtable_destroy(&sw->router->kern_fib_cache_ht);
 	prestera_router_hw_fini(sw);
 	kfree(sw->router);
 	sw->router = NULL;
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
index 02faaea2aefa..254107f664b4 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
@@ -102,7 +102,6 @@ void prestera_router_hw_fini(struct prestera_switch *sw)
 				    prestera_fib_node_destroy_ht_cb, sw);
 	WARN_ON(!list_empty(&sw->router->vr_list));
 	WARN_ON(!list_empty(&sw->router->rif_entry_list));
-	rhashtable_destroy(&sw->router->fib_ht);
 	rhashtable_destroy(&sw->router->nexthop_group_ht);
 	rhashtable_destroy(&sw->router->nh_neigh_ht);
 }
-- 
2.25.1


