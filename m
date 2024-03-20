Return-Path: <linux-kernel+bounces-109227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A412881675
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1591C23175
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B336BB56;
	Wed, 20 Mar 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="itBkJnTU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7D6A326;
	Wed, 20 Mar 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955246; cv=none; b=obvWX9JgU0fNeifCmcrchaaCLTpHwIQlfdMFd6Otm+nQVFRSxv4tmyQsKqPNQnHC/xtSSSzovj2Iq9aFiSUIDNOKO/TVNl7HLX8rLXhJqzr5iCJTGo/CLzNritc2VpO+wmZcO1ZyvflkkBIXw67bPZWie5FT/kgxzIeO2jdkCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955246; c=relaxed/simple;
	bh=BnBdnBUe4XaArwHjwRXi2KQIzBfK+Sut+of7NENF5lU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5d414/E6FLuYqjsVh+GnjHPd5SNGE9O7eQXjYcqKRwYsMqQdAfrYdndHMBzRWKeggqOf/D835nOlRkTiGUY7Oo4pO41f5RKwwEWiMnSMMEvfL7hmThrniam0uUJ5um+Y7YfecOMhUCdRfXKn90d8KmI2R/9y1y/Bu8e7OO0Lhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=itBkJnTU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KFIWm9003494;
	Wed, 20 Mar 2024 10:20:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=C2fd2iktPU965blDdrMdyZ78vxK2GQivfgnP62HESJo=; b=itB
	kJnTU/YtISP1UCxsr+IixsGRc1Tlf/ymgrT+AsdLeen4w0uCqgIZnCri246Ojhfk
	jr3tt11pAV1eA+cVfFh5QEU341EuFaVu7ABc5RKo1/W3s/dTtQE29yJhVOqOIJmq
	200Xfm7DpV5KqHY6dixSb/0GvqNcJEZFHpanRpEnpJB6IKKxrIMlKj+c4vKOsWAX
	HhR//YDBhoh3MsARAu7WuHKGaKmE+e3SeqlHuB033Ar/5SIqzkafK8+nGJdwu1PF
	iKW00p1Lnj9TG3GSFSzHdAqmYAMYgeCkUy0NSJIkg9uztQ/T6yYzfgVIhwWznUdq
	rUehgDTEOuLMz5B4D7Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka52e3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 10:20:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Wed, 20 Mar 2024 10:20:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Wed, 20 Mar 2024 10:20:29 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 35E675B692D;
	Wed, 20 Mar 2024 10:20:26 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <przemyslaw.kitszel@intel.com>,
        <dkirjanov@suse.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 4/5] net: marvell: prestera: force good base mac
Date: Wed, 20 Mar 2024 19:20:07 +0200
Message-ID: <20240320172008.2989693-5-enachman@marvell.com>
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
X-Proofpoint-GUID: bEMz6VlC1jVdV3F1ZW_H65e9b02namqt
X-Proofpoint-ORIG-GUID: bEMz6VlC1jVdV3F1ZW_H65e9b02namqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

The switching ASIC router HW unit MAC Source Address is configured with
40-bits of MAC base address in its registers (done in the firmware code),
requiring all ports doing L3 routing in HW to have the same upper 40-bit
MAC address.

Since each switchport MAC address uses the switch base mac address and
then adds the physical port number to it, Force the last byte of the
switch base mac address to be at most 127, so when adding to it, we
will not wrap around the previous (more significant) mac address byte,
resulting in a warning message.

Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index bcaa8ea27b49..87d8fc4162b3 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -860,6 +860,7 @@ static int prestera_switch_set_base_mac_addr(struct prestera_switch *sw)
 		ret = of_get_mac_address(sw->np, sw->base_mac);
 	if (!is_valid_ether_addr(sw->base_mac) || ret) {
 		eth_random_addr(sw->base_mac);
+		sw->base_mac[5] &= 0x7f;
 		dev_info(prestera_dev(sw), "using random base mac address\n");
 	}
 
-- 
2.25.1


