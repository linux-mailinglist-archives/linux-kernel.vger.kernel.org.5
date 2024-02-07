Return-Path: <linux-kernel+bounces-55841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A65984C24E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20547B24459
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECECDDDA;
	Wed,  7 Feb 2024 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HcW7hEqG"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FA8C05
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272120; cv=none; b=H+0l8KytmVaom/G9NN2NrEGVdOQ32av3VGNqLnEaQYEaK5KWHJ5ocKqSpNQXKJOXhi+xK93AU6bTOMc/Idk5OIwsRZ4tLHNG/GchVwxnv/yriA1mO1pMI2U9gmhU1NP85dIji6TtfmlF71zxV3DSEzh2kb+j0gHtRD+M4OidRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272120; c=relaxed/simple;
	bh=ix1cmovieKIsQ+j80BYlxnrOuJfzq5bQLPl5KyFgSMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgGUUCOtgdiA98Bis2zQIxSAz8YRb3ps9AM+EXdMcaxAIQ+JVeYpoD9K2CcNWyEs5DQ7scsen7p5JyWjbj6GNqlFc2E0Yd973Krttb7ML0WURmU7m2nMkDidTjhGcxAuNNFUdJ5MjFtDdmvzSSDmnItneo2vYZ7ZPSFOc2sRGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HcW7hEqG; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ba85e336c55e11eea2298b7352fd921d-20240207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/9iu+hMwKPmAX48lO9etKmHZlNn7fbipD6oy4YQb2Tg=;
	b=HcW7hEqGBQufACMgjZNDoelGzZvYhcNUYpjsGV2WDbpTVKMtxLgdX4QjQaJ26GMAHkXE5lA0qPo6v1baMyIFCIuiSgZAfdEDpSS9WCQkq/n1ybbfwmVMlm0HysQ5rYJ8OkIYO7hIM3L7YD+IIuVV8VeI7BTDNCItfU5fNG+yRyc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:025a4cb3-c75d-41d4-948c-041318ccf651,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6f543d0,CLOUDID:3bc43380-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: ba85e336c55e11eea2298b7352fd921d-20240207
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 520137397; Wed, 07 Feb 2024 10:15:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Feb 2024 10:15:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Feb 2024 10:15:12 +0800
From: Hsiao Chien Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Hsiao Chien Sung" <shawn.sung@mediatek.corp-partner.google.com>
Subject: [PATCH v2 0/1] Filter modes according to hardware capability
Date: Wed, 7 Feb 2024 10:15:09 +0800
Message-ID: <20240207021510.24035-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.759200-8.000000
X-TMASE-MatchedRID: ATi5SS6xZln8rQJMqxBG8BlckvO1m+JccuFRT+prg4ZGL0g1nVmkYcDV
	CJRGn8Ul9thk9nbRgmWNpw2JbH/pLNm0JHSAKf2wA9lly13c/gFKPIx+MJF9o5soi2XrUn/J8m+
	hzBStansUGm4zriL0oQtuKBGekqUpnH7sbImOEBSNLjMwRubhFIJLAWlgYBj9j6bYDnm5z3RGIG
	Ft1pWKyYS780tUCheZS3sQQCJQ7LTHajbg+Suzu1HfVNA9wjvktgZwSK5A7V1Jmt82E/eyBQGH0
	CAFIQWsmb5gmylW+PbGS+seVPx64j6Qrn3xh/cy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.759200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1498373DF5AC87AD7C57785CDAB8BEF926E2F60C2A869894C2EAB08A0702ACA22000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

This series is based on mediatek-drm-next branch of
kernel/git/chunkuang.hu/linux.git.

Changes in v2:
- Refined the filtering formula
- Add the .mode_valid hook to the hardware that causes the limitation

Hsiao Chien Sung (1):
  drm/mediatek: Filter modes according to hardware capability

 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  4 ++
 drivers/gpu/drm/mediatek/mtk_disp_merge.c     | 56 +++++++++++++++++++
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 17 ++++++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 17 ++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   | 12 ++++
 6 files changed, 107 insertions(+)

--
2.18.0


