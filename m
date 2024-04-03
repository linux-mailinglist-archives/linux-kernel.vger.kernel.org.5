Return-Path: <linux-kernel+bounces-129102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF35896508
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22440283E18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4519535BF;
	Wed,  3 Apr 2024 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O+vF5cVd"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5C182C3;
	Wed,  3 Apr 2024 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127373; cv=none; b=KEziyEi7T0EAKtlhDwaOhK8U97jmS7nBFIa7BkHPAM2eSypNbD1/lswus9p5AuCuIrCyyXjbogjzlNO0PjhObPndrKMwbHXrM1KXUWK4yWS1+yaYn7baTvWcfe1C+zj6FNJo+LRpKWWw3e42diszuqwnybquoPGr5vBUGhLatIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127373; c=relaxed/simple;
	bh=uqVwYTyQOZVJHlZotcWXVyaTQDCcSERT5CjmSuSRGe4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SuYm9GhgvfqnpnnRjlseIAD2StDhBcRiuiXlFzBHM2KsnSVd8BjyJBJvcaLB0a2yCOAxVAXDZhxB8uDK9F6zWQOuDHTkP1+5lQnPbfQfFppuOkgJ/7Fgbn9UyrFBBZmygZxiMze7k1SLKalBF+7X65WRG8qvtoWWj6vJF5v0Gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=O+vF5cVd; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3e307288f18711ee935d6952f98a51a9-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YThtGDRM6zbty1cpurINdKseOrsyodu8CUsRPn0dnuA=;
	b=O+vF5cVdSGSi3Ty17u4zYwXIOLY20+GAyUBgClk1tpRPOYANSRC9chcFnMSWrDA5tDCPjDQeG0zDXC6svSOvXyLLChO+IvTJ/Nj08GHUHGNNHPB4odvfeOZzNS+KoPMqgJQ6b1LVngO7bhFvv8gOkDeB9yWQsAIk3U8KB1DffwQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:42fda0ed-4940-43dc-a928-99d11cec27a2,IP:0,U
	RL:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:100
X-CID-META: VersionHash:6f543d0,CLOUDID:2acc4282-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
	il,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 3e307288f18711ee935d6952f98a51a9-20240403
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 686901047; Wed, 03 Apr 2024 14:56:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 14:56:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 14:56:04 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Hsiao Chien Sung
	<shawn.sung@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Hsiao Chien Sung
	<shawn.sung@mediatek.corp-partner.google.com>
Subject: [PATCH v4 0/9] Add CMDQ secure driver for SVP
Date: Wed, 3 Apr 2024 14:55:54 +0800
Message-ID: <20240403065603.21920-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

For the Secure Video Path (SVP) feature, inculding the memory stored
secure video content, the registers of display HW pipeline and the
HW configure operations are required to execute in the secure world.

So using a CMDQ secure driver to make all display HW registers
configuration secure DRAM access permision settings execute by GCE
secure thread in the secure world.

We are landing this feature on mt8188 and mt8195 currently.
---
Based on 2 series and 1 patch:
[1] Add CMDQ driver support for mt8188
- https://patchwork.kernel.org/project/linux-mediatek/list/?series=810382
[2] Add mediatek,gce-events definition to mediatek,gce-mailbox bindings
- https://patchwork.kernel.org/project/linux-mediatek/list/?series=810938
[3] soc: mediatek: Add register definitions for GCE
- https://patchwork.kernel.org/project/linux-mediatek/patch/20231017064717.21616-2-shawn.sung@mediatek.com/
---

Changes in v4:
1. Rebase on mediatek-drm-next(278640d4d74cd) and fix the conflicts
2. This series is based on 20240307013458.23550-1-jason-jh.lin@mediatek.com

Changes in v3:
1. separate mt8188 driver porting patches to another series
2. separate adding 'mediatek,gce-events' event prop to another series
3. sepatate mailbox helper and controller driver modification to a
   single patch for adding looping thread
4. add kerneldoc for secure mailbox related definition
5. add moving reuseable definition patch before adding secure mailbox
   driver patch
6. adjust redundant logic in mtk-cmdq-sec-mailbox

Changes in v2:
1. adjust dt-binding SW event define patch before the dt-binding patch using it
2. adjust dt-binding patch for secure cmdq driver
3. remove the redundant patches or merge the patches of modification for the same API

Jason-JH.Lin (9):
  dt-bindings: gce: mt8195: Add CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
  dt-bindings: mailbox: Add mboxes property for CMDQ secure driver
  soc: mediatek: cmdq: Add cmdq_pkt_logic_command to support math
    operation
  soc: mediatek: cmdq: Add cmdq_pkt_write_s_reg_value to support write
    value to reg
  mailbox: mtk-cmdq: Support GCE loop packets in interrupt handler
  mediatek: cmdq: Add cmdq_pkt_finalize_loop for looping cmd with irq
  mailbox: mediatek: Move reuseable definition to header for secure
    driver
  mailbox: mediatek: Add CMDQ secure mailbox driver
  mailbox: mediatek: Add secure CMDQ driver support for CMDQ driver

 .../mailbox/mediatek,gce-mailbox.yaml         |    3 +
 drivers/mailbox/Makefile                      |    2 +-
 drivers/mailbox/mtk-cmdq-mailbox.c            |   79 +-
 drivers/mailbox/mtk-cmdq-sec-mailbox.c        | 1091 +++++++++++++++++
 drivers/mailbox/mtk-cmdq-sec-tee.c            |  165 +++
 drivers/soc/mediatek/mtk-cmdq-helper.c        |   72 ++
 include/dt-bindings/gce/mt8195-gce.h          |    6 +
 include/linux/mailbox/mtk-cmdq-mailbox.h      |   36 +
 .../linux/mailbox/mtk-cmdq-sec-iwc-common.h   |  385 ++++++
 include/linux/mailbox/mtk-cmdq-sec-mailbox.h  |  158 +++
 include/linux/mailbox/mtk-cmdq-sec-tee.h      |  105 ++
 include/linux/soc/mediatek/mtk-cmdq.h         |   61 +
 12 files changed, 2132 insertions(+), 31 deletions(-)
 create mode 100644 drivers/mailbox/mtk-cmdq-sec-mailbox.c
 create mode 100644 drivers/mailbox/mtk-cmdq-sec-tee.c
 create mode 100644 include/linux/mailbox/mtk-cmdq-sec-iwc-common.h
 create mode 100644 include/linux/mailbox/mtk-cmdq-sec-mailbox.h
 create mode 100644 include/linux/mailbox/mtk-cmdq-sec-tee.h

--
2.18.0


