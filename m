Return-Path: <linux-kernel+bounces-88574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5B486E3A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE93285AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC836394;
	Fri,  1 Mar 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RhfsU9KW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0FF442A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304252; cv=none; b=fzFzPYpEdhoWWcsU8AfqzJWCSuCCNqXwm37jGF4KbMMlviI4tALm9FS4nDa8pv75cmX6EqDHAGvg3TSHNvVYQYlWemBcdrorVpkbgC7jgr6kouHcRCsObLCgzBBM2qfaVgWT1Z/xPwqSUmwj05iOHpNMDifVhrISTOfXZl2QGbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304252; c=relaxed/simple;
	bh=4cri7GWZvtfymO3i4ifGYTtb1dzB1XFX69OL/8181YQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvYPjDoMfTSrlSeN6LUnxudvStt4Rc2lFfyFXFcGs7K0th0rbpf7fohzGHHoDaQmx6Sk24kQoQtZx8Znu4quIH1LIa8cybPTwYFbmWsb+yG3rf9LC5Et5ekEJcbSy9Beb3aL+uD04dxBIDr6ADbS1dupHK7Agob3VWqbbK4rpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RhfsU9KW; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 27d25dc4d7da11eeb8927bc1f75efef4-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VnJZkRs7FJaidbK4N1YzbeeaXbJ0f9ifrcznh2lrwU4=;
	b=RhfsU9KWq/WpNm0b3isy4UfyMpLM1XpS1DUnKZyF3tqGzhr7KJZ8h7DeKornerK1Siu6ltFeg81eOhfGOkmlkxH13B5a7BsVyb7sTsuZpVlI0D2pd+l63qaKQWW+1Iqc3n1ff0Bg9C76phjr+beqfFAcV/VEvwzfbB9ncc3fk7g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0572084e-6cd3-4296-8eff-27c28bb2ac9d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:216d8184-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 27d25dc4d7da11eeb8927bc1f75efef4-20240301
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 5759617; Fri, 01 Mar 2024 22:44:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 22:44:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 22:44:04 +0800
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
Subject: [RESEND, PATCH 0/5] Add CMDQ API for upcoming ISP feature
Date: Fri, 1 Mar 2024 22:43:58 +0800
Message-ID: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.250400-8.000000
X-TMASE-MatchedRID: pJ+CdhK041Qssufzyd4qvjPDkSOzeDWW87QrIQgH3y3ANHjiWWI+7UBA
	1mlGP0dBD8GU8iW2GCEADeLgM5ytYg8C7Ybhht/Cbc297PAGtWZ8s8pjIsOUB1SOymiJfTYXLZ9
	FZe+H0T3QH2fwKI6prP3bv+uBVCY6WvrN47f+AFsflhDI6DvVln0tCKdnhB589yM15V5aWpj6C0
	ePs7A07QsfaqMZktsdeTJ3hIPnfh9URPUP4yQgVvLkFbJ7SJpFYRV4a8a1enQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.250400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6CAB453DCAB0B639D7FA623EBB3E06D3D5343A105286ABA2BBF80135705A06A92000:8
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


Change in RESEND v1:
1. Remove Change-Id in commit message.

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


