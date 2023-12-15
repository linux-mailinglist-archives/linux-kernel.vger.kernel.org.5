Return-Path: <linux-kernel+bounces-644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A04E8143FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E9C283D82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B611A271;
	Fri, 15 Dec 2023 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dHPBjDKg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91818C09
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 150a060a9b2711eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DOL3MAEWpk4auwrZ/0QVpsKL7LKneCSNGLT6LUjYF8A=;
	b=dHPBjDKgrXByGafMRoSskvy2iQJ13cTeOFlQR7q4pU+juK9dZQE5TXXPPZ4WDU8J8f65k17UoA82gJED+YWA2QkAbcXFp53kEQF8J2wym+Yg9GSbUVdaopwo46VrMcYB7zL6+033t+JvB/4Nla+976hAftbQboTYJSJOyuDySlo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:2cba1c37-4a5c-4df4-984b-05c96e9e48a8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:836bb5fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 150a060a9b2711eeba30773df0976c77-20231215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 113372297; Fri, 15 Dec 2023 16:51:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 16:51:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 16:51:03 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jeffrey Kardatzke
	<jkardatzke@google.com>, Jason-ch Chen <jason-ch.chen@mediatek.com>, "Johnson
 Wang" <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	"Jason-jh Lin" <jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH v2 0/3] Add CMDQ driver support for mt8188
Date: Fri, 15 Dec 2023 15:00:23 +0800
Message-ID: <20231215070026.2507-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.689500-8.000000
X-TMASE-MatchedRID: REQh4LCxv5Ab+BGg6rnrdlz+axQLnAVBfLPKYyLDlAcH8UzOewTxw4HP
	3u3XDM5D4vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8jfhP1xgyx3DIPPQq+LR9HCWW1
	s94V1YY4IIMzOvFTgJ534wuSfusGeD8/Mp+zrIDxdsm03R8LRuBwOHg/YG1GNCRijtNma6heKIY
	1utScIUo6H7DI0GsVcMmI24qiENwrMpIbcl3IoA+q1XYAYw09qIdY9jOi4lTI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.689500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E8E29A6DB722F00B81D96420E5F5E3A2510A85ADCBD8D6300001CA5154F675FA2000:8
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

Since mt8188 has 32 GCE HW thread, we nedd a new platform data to
support it.

So we sort the platform data in numerical order of compatible names and
add a new mt8188 platform data.

Change in v2:
Add a ptach to rename gce_plat variable postfix from 'v1~v7' to SoC names.

Jason-JH.Lin (3):
  mailbox: mtk-cmdq: Rename gce_plat variable with SoC name postfix
  mailbox: mtk-cmdq: Sort cmdq platform data by compatible name
  mailbox: mtk-cmdq: Add CMDQ driver support for mt8188

 drivers/mailbox/mtk-cmdq-mailbox.c | 44 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 18 deletions(-)

-- 
2.18.0


