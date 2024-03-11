Return-Path: <linux-kernel+bounces-98908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D48780EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659FA1F22D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F7F4087A;
	Mon, 11 Mar 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FM9lTZva"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019C3FE46;
	Mon, 11 Mar 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165103; cv=none; b=a7qQp+WHFKzaOUpmNaXZFIv4Agm+XZDqDvMcF0vwuCX2oNtrjboxyqm9xIVx5g4ZSJBmZb04GCmvyQm+ICrVq7fqQ+9dNPyfQdWZNqEJV2lcOLyPr8eywnkL6IlggHetCrseIqV7qeL83hNcJ5ySjxe4LUUGlst/Qo3INRWrTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165103; c=relaxed/simple;
	bh=3hi9Jqa8kSUrQrsnJ6TZgy7vYP+c7vAyo7eY7XqI/dU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9+Lop9jQSXZM4RyQuavLtunlbqXpnRW4XRHxXcBtolpzrwtrJX2AydGR1Woe6hZrt8alwOYl9Y+dAXpRWN9C9ByZG4QdhA6px7a4nWQl3IywY85w+IGrMtjEDzscmWYkhJwJiZD4NpOy4Pq5CoCt8Cwz3Fwo+S+54RVNCAm8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FM9lTZva; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9mtR2016550;
	Mon, 11 Mar 2024 06:51:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=1NPiW0fpbleW62FOBFXlYCKmD7f8dUdE+QJBKyg2EBw=; b=FM9
	lTZva+7wtboH74X/SqImsgGByklUmkvIx6Qh3D6y45UPufMDjScownycFnf14YD4
	vyTI7CXLkE4RO+8dj/e6vIB1XtPbJIP6X/bYyQPV+jMYbJuxsN67M9Y5xw683T9R
	mOsS9y9Hfqx5mTmjm4WY/CincvHFwEiGmHGYTle8Y6g2lpX24GH33sq1J/Bfnueh
	JxU0AQJymZiTqNn5sQfW3Rls2hBWr1hcMzxcAmLziaDYjfblcEneO2EStQE2MmzZ
	Dtau2Sn+uA40qlfAsgXfX8d4voAIOyGkRzjdhid8thlXZB3ao6t9cP17EAEOWVhp
	IA8Kf6bJk8AVxiufeOg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wsynb0nh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 06:51:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 06:51:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 06:51:28 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id C83AD3F7044;
	Mon, 11 Mar 2024 06:51:25 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH 3/3] net: marvell: prestera: force good base mac
Date: Mon, 11 Mar 2024 15:51:12 +0200
Message-ID: <20240311135112.2642491-4-enachman@marvell.com>
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
X-Proofpoint-GUID: X9qogWKBaT25Hod6WDXxWD4QmQyFTs7n
X-Proofpoint-ORIG-GUID: X9qogWKBaT25Hod6WDXxWD4QmQyFTs7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Since each switchport MAC address uses the switch base mac address
and adds the physical port number to it,
Force the last byte of the switch base mac address to be at
least 128, so when adding to it, we will not wrap around the
previous (more significant) mac address byte, resulting in a
warning message.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index bcaa8ea27b49..e17b1a24fe18 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -859,7 +859,9 @@ static int prestera_switch_set_base_mac_addr(struct prestera_switch *sw)
 	if (sw->np)
 		ret = of_get_mac_address(sw->np, sw->base_mac);
 	if (!is_valid_ether_addr(sw->base_mac) || ret) {
-		eth_random_addr(sw->base_mac);
+		do {
+			eth_random_addr(sw->base_mac);
+		} while (sw->base_mac[5] > 0x80);
 		dev_info(prestera_dev(sw), "using random base mac address\n");
 	}
 
-- 
2.25.1


