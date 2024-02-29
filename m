Return-Path: <linux-kernel+bounces-86866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5011786CBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5F5B22A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C29137C38;
	Thu, 29 Feb 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J+3/eSbU"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A9137750;
	Thu, 29 Feb 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218136; cv=none; b=ApNs2F2b7cMfzUwWCS4PY1UrYbcoCLUOqkE7AbBn7F+0byCM/H11Fl9+wcz2t4oJSANmGxAGlmJ9nlizT3afKdJyl65DKlD+VYbwVQe5hVyANTeN2DXBqwKjfu6CwV914NEJ5XhvtRFCUnmRJGJG0lcMhG9dUGuNY1JAYIAGfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218136; c=relaxed/simple;
	bh=J7zMkYOe2z8RSW6CzHBrvBDRO22h9G0bvk/JDVtgOP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tErM/RVqcV6wOTyDDqGn/IZ3RdUvJRGLt+xt6rbc3oLZRrqcyaoDYSQsZJBX4P5X0ZaRGnPIELApxBfug0K7AIotUJC9KIQqbgnLpWQC7K+ekUnlV2v5JZi+qV9bfGP8wEJAVnO5tAohwrNZvQbd1TPCipXqDF8gTy4qcVqI6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=J+3/eSbU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5027550d71111ee935d6952f98a51a9-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YDUB1R45Ja1nwbtgjCXo8zSwQLjgVdrkkmfZ6bu7GoU=;
	b=J+3/eSbUeoXKccyIhkaSnKldhx9CcZfyYNtzBG0t6tYC3c+7rsTUHEICXI70zFHELoGN1b0l1EuhaOWjSIar7F70giHF94az1kP5jERP689rcRIvtBmVaqfQ8QcoB+s3yx7c/mkuReLhoe+T2+Yj/0J4dzbutgNZhYeThSbfMWk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:112a96f9-84d3-4b6b-8219-523cd1fef6ee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c517f580-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a5027550d71111ee935d6952f98a51a9-20240229
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1723561320; Thu, 29 Feb 2024 22:48:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 22:48:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 22:48:46 +0800
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
Subject: [PATCH v2 0/3] Add GAMMA 12-bit LUT support for MT8188
Date: Thu, 29 Feb 2024 22:48:41 +0800
Message-ID: <20240229144844.1688-1-jason-jh.lin@mediatek.com>
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

Change in v2:
1. Keep MT8195 compatible in the group of MT8183.
2. Move MT8195 compatible group to the end of items list.

Jason-JH.Lin (3):
  dt-bindings: display: mediatek: gamma: Change MT8195 to single enum
    group
  dt-bindings: display: mediatek: gamma: Add support for MT8188
  drm/mediatek: Add gamma support for MT8195

 .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml | 5 +++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                       | 2 ++
 2 files changed, 7 insertions(+)

-- 
2.18.0


