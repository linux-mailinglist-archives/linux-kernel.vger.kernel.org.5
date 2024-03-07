Return-Path: <linux-kernel+bounces-94828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04FE8745AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B26286BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8394C4C92;
	Thu,  7 Mar 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dxxK26ul"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC16AA7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775307; cv=none; b=jxMWS3L0XLzwiKlEOQ0dVXmYoxiLaRJUyK+3r/J6IeoGXQgRQTj/OqJPB66reSTSl81NLymQnwHjCBAoVy+DF/KCL4cabS3xgYfq7aUl9clkqauQm8+JNApVzxDPUt4fkXyJFCEfhZ1f8Ycw9QwPni0Be6qXO5ldMm3wDNorHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775307; c=relaxed/simple;
	bh=YpGRtlThcsNiB6M8IGk4O/YuB/PRPXqsfFpV5g88Gwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KbieQqurkEhxBisn/ATZB7aZGVN4zhjU0U3O6uB3fRE2togjSSq8ESM9xf1odUBDr0RNaxJ7wGB0A1B2EVZm0nFPTClRBgoMVVExlVvlLQiKovCxhp7bHJo1McfWSi6SFN8lpcP4Mzr+rzSmBlTHJ7xeA93tBHowBMKdVTd8BEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dxxK26ul; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eaaffec2dc2211eeb8927bc1f75efef4-20240307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qsVeZY7ariDbPPGgJAwyIB3C+kJL90wnCgmOhDPi0CE=;
	b=dxxK26ulPzJVIYey3EwXlO9fT+Tlm/G6xbTaPD7K74x5UxMZW9PlxyDQ6/VmU1FfNJFXp7uxr47DRFvBLSetkEPfyMQ+/0cCVo+Q5ip1Le7dpYsz3V0emZAU3ZieOjwL38mSfgze1UuhjQq6AymwoeYtRW5WHne0H92lA9AcGzM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a5073234-0e4d-41bb-9376-455107af8c36,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:f82299ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eaaffec2dc2211eeb8927bc1f75efef4-20240307
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 130986230; Thu, 07 Mar 2024 09:35:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Mar 2024 09:35:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Mar 2024 09:35:00 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH v2 0/4] Add CMDQ API for upcoming ISP feature
Date: Thu, 7 Mar 2024 09:34:54 +0800
Message-ID: <20240307013458.23550-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.233100-8.000000
X-TMASE-MatchedRID: pJ+CdhK041Qssufzyd4qvjPDkSOzeDWW87QrIQgH3y3ANHjiWWI+7d96
	V2NgrEHiDoqCl/x+niurnPeXenpUwBaTj8lkRWbAXSKcwPTzq/IhotH7bEpEMlwpnAAvAwaz0gE
	LN9U+w7GDefyXDwaGu/3bv+uBVCY6WvrN47f+AFsflhDI6DvVln0tCKdnhB589yM15V5aWpj6C0
	ePs7A07fk39LXMSri60LeqKkxroARqlYmP1kxHlxV5ziwakIth1e5jJb9JJQc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.233100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 28C47FC7FE85B52C197D796DD901F072AA0166C80A81E406F968B2F69C21CA932000:8
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

In order to support the upcoming ISP functions, some CMDQ APIs
need to be prepared:
1. cmdq_pkt_mem_move():
   For memory or register value from copy src_addr to dst_addr.
2. cmdq_pkt_poll_addr():
   Extending cmdq_pkt_poll() to support polling the register address
   which doesn't have a subsys id.
3. cmdq_pkt_acquire_event():
   To support mutex_lock protection between GCE threads.

Change in v2:
1. Change the return variable from 'err' to 'ret'.
2. Add more comment and commit message.
3. Drop the last PATCH 5/5 in v1.

Change in RESEND v1:
1. Remove Change-Id in commit message.

Jason-JH.Lin (4):
  soc: mediatek: mtk-cmdq: Add specific purpose register definitions for
    GCE
  soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move() function
  soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr() function
  soc: mediatek: mtk-cmdq: Add cmdq_pkt_acquire_event() function

 drivers/soc/mediatek/mtk-cmdq-helper.c | 90 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 52 +++++++++++++++
 2 files changed, 142 insertions(+)

-- 
2.18.0


