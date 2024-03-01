Return-Path: <linux-kernel+bounces-88310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D186DFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06260281DEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C26D1A6;
	Fri,  1 Mar 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UrkEDeyY"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C426BFC2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291509; cv=none; b=dSQgg/Dzn/ro8IZbD5L/dSl53bLWXrrTe2Xqs1PH6pfOxgDKMDV+ComkJIgoZGPf+tIeaHHKSHi8Dpi4sEzyM2cRPW3y0AQiETMijNk2rLw+cDeXCD3jrFZ2cjI+em+9m959MxgvjjTzQq3zArwFkNuqrljqPnY4++n7TZS5H8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291509; c=relaxed/simple;
	bh=/xDonUNC7ocYSfrZF0cRihan81CJlJLUmGBfW2so27Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AH5npPzQwqu6UkkFoS/AsPW54lksGJyIUS8naenYAIWHo+iwDcbZ2YZyiRtk9SU4K7iG2AmAj+AdtqE+fOxdNhs1KViKiulyIEa6wgD1xinIkxgfUyssgN0Qoq/wsMmvKbCVb8yoc6tKDxP4FI0H6/yMJpYDnxBVgVSYusfU03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UrkEDeyY; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a84b0dad7bc11ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Q5WuaCMJDw1pbZ4ztPZ18MjsiyYlAPImik90vW7Ffm8=;
	b=UrkEDeyYB8C0tXbtAs6ECT+ZyTDSt/I9p6j4HpVXU3mXt7wK9D5/aUO4/HDN0FXvlxMKefC07hzbmlcPiDRnvHeBjx4u6VZnaAb4p7vlFd9JPD7O38bbeSGcbj4DbqLwrRKXXyG82KovOs4f/91cIDRPDz3oqbvYvGrOkiuIuGk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:405a7b23-959c-4610-8378-1368add7859a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:6cf664ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7a84b0dad7bc11ee935d6952f98a51a9-20240301
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 358478159; Fri, 01 Mar 2024 19:11:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 19:11:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 19:11:39 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH 0/5] Add CMDQ API for upcoming ISP feature
Date: Fri, 1 Mar 2024 19:11:21 +0800
Message-ID: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

In order to support the upcoming ISP functions, some CMDQ APIs
need to be prepared:
- cmdq_pkt_mem_move(): for memory or register vaule copy
- cmdq_pkt_poll_addr(): extending cmdq_pkt_poll() to support polling
                        address of register 
- cmdq_pkt_acquire_event(): to support MUTEX_LOCK protection between
                            GCE threads
- cmdq_get_event()/cmdq_set_event(): to support ISP driver runtime control
                                     some GCE events.

Jason-JH.Lin (5):
  soc: mediatek: mtk-cmdq: Add specific purpose register definitions for
    GCE
  soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move() function
  soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr() function
  soc: mediatek: mtk-cmdq: Add cmdq_pkt_acquire_event() function
  mailbox: mtk-cmdq: Add support runtime get and set GCE event

 drivers/mailbox/mtk-cmdq-mailbox.c       | 37 +++++++++++
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 79 ++++++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |  2 +
 include/linux/soc/mediatek/mtk-cmdq.h    | 44 +++++++++++++
 4 files changed, 162 insertions(+)

-- 
2.18.0


