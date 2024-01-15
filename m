Return-Path: <linux-kernel+bounces-25925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A0C82D860
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E12826A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9FA2C68F;
	Mon, 15 Jan 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nFX2iE/I"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7B2C683;
	Mon, 15 Jan 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: daa14486b39711eea2298b7352fd921d-20240115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Reply-To:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JL8etJQJZZlxR7+amaW8doF71Tvptr0HhTmq5ofDFk8=;
	b=nFX2iE/IKpTCVXvJp5icHv94H4aX+ShCfcbswSgJqxTuISdW3CwT63nnRbNYXctXien316BRp6mEwdGvdHsgcKcXkxhqz30Hafn19BHT1CqhdWwDXLfANehcYD1YdAwxGWSOvW17VBijJk0GoUYbt0BLakyh0uArgBnKMcW7y50=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:860ce534-1785-4e39-a344-7b5f2019e2a1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a683dd82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: daa14486b39711eea2298b7352fd921d-20240115
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 115360283; Mon, 15 Jan 2024 19:18:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Jan 2024 19:18:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Jan 2024 19:18:46 +0800
From: yu-chang.lee <yu-chang.lee@mediatek.com>
To: <msp@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <fparent@baylibre.com>, Ben Lok
	<ben.lok@mediatek.com>, Chris-qj Chen <Chris-qj.Chen@mediatek.com>, Louis Yu
	<louis.yu@mediatek.com>, Bear Wang <bear.wang@mediatek.com>, MandyJH Liu
	<MandyJH.Liu@mediatek.com>, Fan Chen <fan.chen@mediatek.com>, Xiufeng Li
	<Xiufeng.Li@mediatek.com>, <abailon@baylibre.com>, <amergnat@baylibre.com>,
	<afgros@baylibre.com>, yu-chang.lee <yu-chang.lee@mediatek.com>
Subject: [PATCH 0/1] Need help to validate power domain driver modification on mt8365
Date: Mon, 15 Jan 2024 19:18:43 +0800
Message-ID: <20240115111844.22240-1-yu-chang.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Need help to validate power domain driver modification on mt8365>
References: <Need help to validate power domain driver modification on mt8365>
Reply-To: <msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.523200-8.000000
X-TMASE-MatchedRID: fXkh6SfpfhtM4VjZ76ar2IQ6iEG+7EHnQKuv8uQBDjos7eP5cPCWQxLB
	HER/v45pa888eHP8TjxdPJV7o2tMJaLCTO1UKypvbQ9aoPSmWJFKPIx+MJF9o5soi2XrUn/JlR1
	cT9YafQUG3jF6chFcDnS4vQrt84k3IAcCikR3vq/Yh98d0MMCXCdiKF9WF8aIyjYtBKCN99W//3
	PsX06R2V2kuxS4dcf0
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.523200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5D51DBEE3B8543E096065A55E9CD6ACC2AC7770FC9861491344DB8422BAE874B2000:8
X-MTK: N

Hi Markus,

In reply to mail "Need help to validate power domain driver modification on
mt8365", the timing of "smi clamp protection" being called is completely 
different from the one of "bus protection" that is why I think there should
be another member represent "smi clamp protection" since these are 
different thing essentially. In this way we match smi to its protection
in an 1 to 1 manner which is more direct way to support multiple smi I
think.

By adding "scpsys_clamp_bus_protection_enable" at the end of bus protection
function we also can guarantee bus protection still remain the same as
before, while, at the same time, forcing bus protection sequence in the
future.

yu-chang.lee (1):
  soc: mediatek: pm-domains: support clamp protection

 drivers/pmdomain/mediatek/mt8183-pm-domains.h |  52 ++++---
 drivers/pmdomain/mediatek/mt8188-pm-domains.h |  41 +++++-
 drivers/pmdomain/mediatek/mt8365-pm-domains.h |  12 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 132 +++++++++++++++---
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |   2 +
 5 files changed, 189 insertions(+), 50 deletions(-)

-- 
2.18.0


