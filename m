Return-Path: <linux-kernel+bounces-9347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDED81C46D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0743F1F25E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C963156FF;
	Fri, 22 Dec 2023 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gyfbGJ/0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3623D0;
	Fri, 22 Dec 2023 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eaf17a2ea08511eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hGQXyaJNf/o7b/qI6wJ2J1Jb9/jZ0HEC85oCttNOJfQ=;
	b=gyfbGJ/0x+GIa5BUiy4ZnjTZ+uU9W/c0bkiI+NbhyRUU89Gigdqx4LErpBxa+/1olkw+wAND7siwL8ga1uaEZ1Hnpj+Ef1mQiIKYcQFfw5JEOz0G8E3+9UrcesQQG89Uz6Z8SQsrqsc9u20deNsdLu11JwXCsDX5wR0L16Q4Lpw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:658b9339-fdc2-4a40-88e2-42d3a8f55b81,IP:0,U
	RL:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:100
X-CID-META: VersionHash:5d391d7,CLOUDID:edac8c7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
	il,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR
	:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: eaf17a2ea08511eeba30773df0976c77-20231222
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1468741933; Fri, 22 Dec 2023 12:52:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 12:52:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 12:52:30 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, Johnson Wang
	<johnson.wang@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH v3 0/9] Add CMDQ secure driver for SVP
Date: Fri, 22 Dec 2023 12:52:19 +0800
Message-ID: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.181400-8.000000
X-TMASE-MatchedRID: z9c31Y7/SCZsLX/Zy50gf4QnnAFRgjn9OlW1BAebvzBzwVmY5TMrNmSQ
	gJ6pnW8lfTfiNIO3sGjdzcJEB3Zs4Q9FV6kNYiPHnVTWWiNp+v8oUVkB7ifJnlksP1I0n2wSjBH
	2O7lhl4DK6iR9ysOAQIalUHBsLUDlkBR3dHBozcejFYHTfcPkwl67veYUroY0KwCIxrnPtx5Tp6
	Yz4AquMuRqqfObKAcHcAVxZL8H4DMdsKV+lYHQBmBLcedPqO9/Jjlv06yk4fDfUZT83lbkEDCsA
	me4bhohL+uMrUIyem6AMuqetGVetq6be/Gn3AzX3QfwsVk0UbvqwGfCk7KUs+qFCZ0F6mjZQgtb
	LYmBkC59OdV9M5CNK+wMxe7BlyQorswyK85GcjnWnWc77nowXnmstbP+hDZLaSnFm8zareWvDmO
	SQrdPEhdGg+ZY7eN6THB2Q+oKru8MTI34nyF36MJL1aANdU8KftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.181400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D2D62DFB20DA81C4F9D194E20D591121FCD44886093F8C5662FB4EF394754FF82000:8
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

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
Change in v3:
1. separate mt8188 driver porting patches to another series
2. separate adding 'mediatek,gce-events' event prop to another series
3. sepatate mailbox helper and controller driver modification to a
   single patch for adding looping thread
4. add kerneldoc for secure mailbox related definition
5. add moving reuseable definition patch before adding secure mailbox
   driver patch
6. adjust redundant logic in mtk-cmdq-sec-mailbox

Change in v2:

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
  soc: mediatek: cmdq: Add cmdq_pkt_finalize_loop for looping cmd with
    irq
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


