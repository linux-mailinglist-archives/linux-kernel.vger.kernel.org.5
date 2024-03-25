Return-Path: <linux-kernel+bounces-116988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02988A951
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6E9BC0C07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10895CDE6;
	Mon, 25 Mar 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gpHywCdi"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87D146D40;
	Mon, 25 Mar 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369165; cv=none; b=Pvo7uhRrKf3MoKDUHKF1eLUWd3muCG/ircSsFUj3Sbjo3Dl1c6r9mnhzIhpjSLMF27nTAPajvhbCzSLpJCT29ohUBVexh9Q/1kZQwwJMpG+SFI0qdXheiYf+rHrVevFKgJx6UkpsQ2dfN+qzgK7QWOynrv/7fCzIpBYaRnUubxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369165; c=relaxed/simple;
	bh=GIZSh66U6z+v0FZReaLZ5gUmsUuxR/pzA9kedxsUGSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRqqP5uUkirFoEbHc7dhwTkF/SYH91bgAZp7XuycjGl8OqIE6wSoEbM2xK2UGjpgGD0/JCw/JEy6SRrn9R/eqCpoxMa82zflhttny7pZNPg6FPhU9Hggq/7OKZ+kP0GvnKP33NFEvdGUmSZePoVHxe6JEWK8tu7j60O8uJeUPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gpHywCdi; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e5dd499eeaa111eeb8927bc1f75efef4-20240325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lmpuo9I0bbZzu8NWnzQ5XfVCX4DjRHWuUIyZfU8/iiM=;
	b=gpHywCdiRo2Ru6odRRrjEEEzxmAXxLRLDQtrrgIWXORUu+skFjGiNFvxEX60TyyiznLF4cACZRUQcVeS6vFuXmtceP6qGDg1mrcJJE1FtFve3rrNIfjlC/mwaWEazyXoOmGdSXWSVLgJwNY+AjCoofV6hVogTDoldn4U/1sYOhE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:bbb19d4c-fd55-4fbb-9d95-1ec1d7888c50,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:e8466885-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e5dd499eeaa111eeb8927bc1f75efef4-20240325
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 335187936; Mon, 25 Mar 2024 20:19:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Mar 2024 20:19:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Mar 2024 20:19:14 +0800
From: yu-chang.lee <yu-chang.lee@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<mandyjh.liu@mediatek.com>, <fan.chen@mediatek.com>,
	<xiufeng.li@mediatek.com>, <yu-chang.lee@mediatek.com>
Subject: [PATCH 0/2] soc: mediatek: pm-domains: solve power domain glitch issue
Date: Mon, 25 Mar 2024 20:19:06 +0800
Message-ID: <20240325121908.3958-1-yu-chang.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.339100-8.000000
X-TMASE-MatchedRID: u0D5i0POlXiYvtVftxNfQUvrB8UvzFr4BdebOqawiLuCsBeCv8CM/Sse
	9qdFFe49mI8EBZ3uTGtSzpXv5ekotFrgS5K/qcaqDko+EYiDQxFQCOsAlaxN7w6QlBHhBZuwkwm
	4GnFKyckb7ifYusSVqcMHFIKAT3DiXSJ4c3nT+QcZXJLztZviXLLiLKO9VZOiXCmcAC8DBrOekk
	V1yzofFtYn7aUb4In+oFW8SPM0GkIfE8yM4pjsDwtuKBGekqUpOlxBO2IcOBYegoblg+i7rGCnQ
	UssYJ15MlFYtzBbKQ1vcglu/p3CKKy2KbCWZSoB
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.339100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9765538F42BCE3697C87BD1816866E3CD6EB2C80F0C481004623D67ED9900FF22000:8
X-MTK: N

Hi,

This series aims to solve power-off failures and occasional SMI hang issues that
occur during camera stress tests. The issue arises because, when MTCMOS powers on
or off, signal glitches are sometimes produced. This is fairly normal, but the 
software must address it to avoid mistaking the glitch for a transaction signal.

The solutions in these patches can be summarized as follows:

1. Disable the sub-common port after turning off the Larb CG and before turning 
   off the Larb MTCMOS.
2. Use CLAMP to disable/enable the SMI common port.
3. Implement an AXI reset.
For previous discussion on the direction of the code modifications, please refer
to: https://lore.kernel.org/linux-arm-kernel/c476cc48-17ec-4e14-98d8-35bdffb5d296@collabora.com/


yu-chang.lee (2):
  soc: mediatek: pm-domains: add smi_larb_reset function when power on
  soc: mediatek: pm-domains: support smi clamp protection

 drivers/pmdomain/mediatek/mt8188-pm-domains.h |  69 +++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 206 +++++++++++++++---
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  13 ++
 3 files changed, 255 insertions(+), 33 deletions(-)

-- 
2.18.0


