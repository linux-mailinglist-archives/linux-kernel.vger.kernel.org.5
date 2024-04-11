Return-Path: <linux-kernel+bounces-139723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D968A06DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251E51F2361E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552D13C3CC;
	Thu, 11 Apr 2024 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JLshGaH2"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824B13BAEF;
	Thu, 11 Apr 2024 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806684; cv=none; b=uXBokcu+uFI4OiBs3IhnvRSJzGh6OtzecyiLBtrNIEYet18NQILgW2JKLSY+rj5ABXof9Vjg3w5KyEqGnydZ1ZWpLbBZaQdkx6K+ZproFKiWLQxYlhmvN1yeqG9yXtorSheo7eJ+q90cf7dSb0nWmG2/rWEXpOMgMGoSiI6BUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806684; c=relaxed/simple;
	bh=pz1rT3cpx3P5SfxVYkWgMRQ4d7jTO20Tqk5wJuH1FFw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XpojevLIUe/1L995JGqzSCTOwSnmtMapju546GwVhSPN4484rbzvJbzFQylSlsxhtHfkTTy6sJC5jFfviwxmSz4mIyUMqqEw/0JRs6Uf7Dtr+G3WdDFeESJTSV8yzktdqFl+7eZOMdMtY0OCv8DRnfQ5sU79pKQ7djuayp5+/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JLshGaH2; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e312976cf7b411ee935d6952f98a51a9-20240411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CEUv8/vX9Yj8LYxJzEvWBhJg+Z+9IJKRp+0lTzE59Rs=;
	b=JLshGaH2HuWZgCz+wT3BghPpjZJfR427NB06oU8Zc1GVhjMt0M9imHxbSYoep4+dmyByONjMi2UPqeLtW5KsAPphzkuZTd1nedNH/CMOo3hUlxQSxxiG55OeDl2pS+jkoPLMDSzCmP1YJJkgnMVeF9/sVhfNIPJle1r9EkeLU5Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e1e37312-d11d-4036-9477-7dbbf9cb2a93,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ceaec6fa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e312976cf7b411ee935d6952f98a51a9-20240411
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 770570878; Thu, 11 Apr 2024 11:37:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Apr 2024 11:37:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Apr 2024 11:37:53 +0800
From: olivia.wen <olivia.wen@mediatek.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Tinghan Shen" <tinghan.shen@mediatek.com>,
	<linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<jason-ch.chen@mediatek.com>, <yaya.chang@mediatek.com>,
	<teddy.chen@mediatek.com>, <olivia.wen@mediatek.com>
Subject: [PATCH 0/2] Support MT8188 SCP core 1
Date: Thu, 11 Apr 2024 11:37:48 +0800
Message-ID: <20240411033750.6476-1-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.728900-8.000000
X-TMASE-MatchedRID: 5QkmdD6LvPKtGUuyWCB/KosKNaNh88CQTJDl9FKHbrlGL0g1nVmkYV2k
	xKIqW9ov4vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8jfhP1xgyx3DNbluTaZDCfQexs
	PsLsZUCpUMEaxhqvmXiMu2Y9Ez16wi+7vFLFx0XSzJ7sL1nbh6SwXJUWXOqeHm110BD6OWbQ2zu
	p2rewEAI6H7DI0GsVcMmI24qiENwrMpIbcl3IoA+q1XYAYw09qIdY9jOi4lTI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.728900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	744BD5FC53961DB76626F4B855044EB74205B7C16E9164E059E8D277DFA8359C2000:8
X-MTK: N

Add below patches to support MT8188 SCP core 1
[PATCH 1/2] dt-bindings: remoteproc: mediatek: 
               Support MT8188 dual-core SCP
[PATCH 2/2] remoteproc: mediatek: Support MT8188 SCP core 1

olivia.wen (2):
  dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
  remoteproc: mediatek: Support MT8188 SCP core 1

 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |  3 +-
 drivers/remoteproc/mtk_common.h                    |  5 +-
 drivers/remoteproc/mtk_scp.c                       | 62 ++++++++++++++++++----
 drivers/remoteproc/mtk_scp_ipi.c                   |  9 +++-
 include/linux/remoteproc/mtk_scp.h                 |  1 +
 5 files changed, 64 insertions(+), 16 deletions(-)

-- 
2.6.4


