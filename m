Return-Path: <linux-kernel+bounces-98907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E08780EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0045B219CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6FF3FB9A;
	Mon, 11 Mar 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MLG6BxtV"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737D3FB94;
	Mon, 11 Mar 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165101; cv=none; b=e5X94sKqzlzOYrdaXHwRwLvgwb2e3vcc7q1MoUCQyLJUUZ0kU7P3OnSJg8WBGFYlLJhcaDe753KgUYLKuByrhE5QHK9pRrBShGUFKVxD3+JX8PyO4wKPuqGKGw9Qu8t3JhzKMee7YVUemQVVIj/yrZgaaAMOQgWcR/kWiUt0lHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165101; c=relaxed/simple;
	bh=S2AMHNhdH85sm9sQuLoX7BN3+6rRCcOQkDC+PX93YvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzywI5B/9HJk26PRfJ67+6w/opbE+9RP+zEVvfxB13787Xu0vVIYpIAO+t58yOVVGhMv3KU+zp/2RTr1Ik2wv0GpYDkX5/PvAy1/nDKmo5NQCC+2b/LSxVD7ICNKMEP/kq9KlDQg4iE7gVQvOenZufwTk0xjCYEP+w/3vJdWXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MLG6BxtV; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9mVFk015528;
	Mon, 11 Mar 2024 06:51:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=QOCLYC5BOQiDAq5ve6bOeoIDhTRVpXigGs5XH4/P9Ts=; b=MLG
	6BxtVk6SHuAyH0lwvxlUlDKswg6EvfUOZjRH0emj9IeeO9hqMvda1lTh4f1AIo4+
	ECRvtWNKFjhPuhL5GpMqDqRlE9JH+qkDo4Vp2uFTllS2qXgQWnkVs2ShHRypQazI
	O6TyBylFZle6lxFqydbk8eYQyFs9T6YnfWrT6OtMKQQTHtiWK066CLTuGtnBxDX+
	L1RXKiOAfUctnvOrxoHGM0mLDp5t7HhcgEDF9DN3ilkxqJ/2dOUCLKFGegqPTRJA
	gsLuP+ypgAN6DW9eA66sVo/ujdE7Po8TAGQcy6AzhkTCLwuEet/5YyH8UDAr7T/t
	I+tFg36F8N0jeOyYmYQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wsynb0nh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 06:51:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 06:51:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 06:51:25 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 8BF193F7051;
	Mon, 11 Mar 2024 06:51:22 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH 2/3] net: marvell: prestera: fix memory use after free
Date: Mon, 11 Mar 2024 15:51:11 +0200
Message-ID: <20240311135112.2642491-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311135112.2642491-1-enachman@marvell.com>
References: <20240311135112.2642491-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7vofUwBK2AyhoU-nGnRe9J_pqQtkfj8v
X-Proofpoint-ORIG-GUID: 7vofUwBK2AyhoU-nGnRe9J_pqQtkfj8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Prestera driver routing module cleanup process would
release memory and then reference it again, and eventually
free it again.
Remove the redundant first memory free call.
All such double free calls were detected using KASAN.

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


