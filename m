Return-Path: <linux-kernel+bounces-86050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F586BF02
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D83A1C20E31
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303EA376E4;
	Thu, 29 Feb 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WxLEzrzo"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303E2032C;
	Thu, 29 Feb 2024 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174138; cv=none; b=q0y6qWquRcYTtJXiz1fWsl4QZWvXd3yjX8v0/9ZqBoW0yI/DPeLWwmOP3OXBD7RVLq6KuN5r9fiTnxCHvHrACHxDrKjX2Bpq05wjX2JLv34kiEVGkZyAyFPMD5QkxaBEwPO0kBtz9+kxa8MTtgvx7P9fHXCanCG6Z9I0gQYtSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174138; c=relaxed/simple;
	bh=R12aDNMBkz2/E9/QnuH5IPVgt9wpnX37VoQyPRX54MY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C7MWIGSOyGBEhP3HKf68hakxfoOsoV53yW+65pXZtXpJAcxwv60gzFMhvqPzD/T6BjDLQxVqHv3OXBf7iydptcf5IsW2kT6vdEAqqhd0YzaVvpB1qk7jPFrcRmnweBc3TdD/tfjtzwj5PMBo6Yd5A01TzxT4SGlsxTLpeDFB4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WxLEzrzo; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 31bf646ad6ab11ee935d6952f98a51a9-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/4b6Fa5B/5D8CIvq27+rD7xKd5V7SopVAeiyzUdv4zA=;
	b=WxLEzrzoBa6XiFC/6TkHMhSLEefUOVJBibjx4G1E4q8Kk0NTk3Zm6ik82T1Qkb2QFPDy6Yp6JiNkL5j/6UciW4iPIjTJDYKTine7bQuyuo8+0Ad177SE2ew3AoV2ZupGPw+Vx7yyK191+FJeIsD54EwUl/LjR0Gf0UkgsBItXKc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:04c228d7-6df1-493a-92eb-047f887bf96c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:d1016e84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 31bf646ad6ab11ee935d6952f98a51a9-20240229
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1729247641; Thu, 29 Feb 2024 10:35:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 10:35:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 10:35:24 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fei Shao
	<fshao@chromium.org>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH 0/3] Add GAMMA 12-bit LUT support for MT8188
Date: Thu, 29 Feb 2024 10:35:19 +0800
Message-ID: <20240229023522.15870-1-jason-jh.lin@mediatek.com>
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

Since MT8195 supports GAMMA 12-bit LUT after the landing of [1] series,
we can now add support for MT8188.

[1] MediaTek DDP GAMMA - 12-bit LUT support
- https://patchwork.kernel.org/project/linux-mediatek/list/?series=792516

Jason-JH.Lin (3):
  dt-bindings: display: mediatek: gamma: Change MT8195 to single enum
    group
  dt-bindings: display: mediatek: gamma: Add support for MT8188
  drm/mediatek: Add gamma support for MT8195

 .../bindings/display/mediatek/mediatek,gamma.yaml           | 6 +++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                      | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.18.0


