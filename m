Return-Path: <linux-kernel+bounces-129549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56F5896C71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABDFB24C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BBD13F43C;
	Wed,  3 Apr 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ohg4sjH2"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D013A88A;
	Wed,  3 Apr 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140034; cv=none; b=aSFNYDb7JocfScCHIqdx2n8xY7es4yion5BtDaLOM6G689etCRBe0fYTq6hunp4WJaGx2oxgljJGb/SPOqsLZxAvFJzAsuVJNCiW0JLdoPt1ytT/opupxEcIHRhDt/+YwYEfXYQZXOk56EQRjDnuLwk4W8EvuaSsop8qvGfrbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140034; c=relaxed/simple;
	bh=A0CG10tU6JTWT/SwjpceAY2Fysd/fIs0mq9NvQmvriE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByrhBFufWdtf+J1HtKM6u1jhsYpjMFegQgH32VLJ9i+S2uBJoMseorpya4NuiMG/JfLoFkAvLjE8ZPe914Xjj3J/HrmFopII2D8cqtuhgl4jKI+tRhOUh20TzMpUuB40wK1psxzrhKrgz6RVZsz48hYkf1JMZd4irhxuYigpck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ohg4sjH2; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b6cf28d4f1a411eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HU1I/VZAAlLwOVCfFci18SC3VkHndwh9c7tHr0pvp3c=;
	b=Ohg4sjH2NG15orU1upkhBo8ImPi9bRgrLnEF/aoCJoQbNQr+t/S3nCiZ3mix35C1gfEVTn20BfrN44JneOEyJqMVbV9G5XuwjIwN0+S6fhavb6pJMBJseBEK9k2CbU8F/T4Z996eHB1UZVVD3Gg4jvn9VyuvX43jwyX3Tt/2cDM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:185fd118-a6a7-4881-bf7c-18866658c81c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:02fec585-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b6cf28d4f1a411eeb8927bc1f75efef4-20240403
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1396889109; Wed, 03 Apr 2024 18:27:03 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 18:27:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 18:27:02 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Sumit Semwal
	<sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-JH.Lin <jason-jh.lin@mediatek.com>,
	Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v5 5/9] drm/mediatek: Add get_sec_port interface to mtk_ddp_comp
Date: Wed, 3 Apr 2024 18:26:57 +0800
Message-ID: <20240403102701.369-6-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403102701.369-1-shawn.sung@mediatek.com>
References: <20240403102701.369-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.033400-8.000000
X-TMASE-MatchedRID: I4WY2Dgn0PgxFdXyW/P+XQI0yP/uoH+DUAjrAJWsTe/7efdnqtsaE1+K
	LrHzzAboRhP7mhvK/WwnOAFYLaUTjQDNPxu11HXjDB+ErBr0bAMK3n1SHen81R/H14cDyzexo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtz0raTJJg2rffJLQ2j2H43UN0/kZu525xKPXZlBX+4BjVI0
	NI7k2clkMMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.033400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7D9A0F3BCF93507C2B3E6C9EFD6EA0D3EC6A586F687581143A856C4008B1366C2000:8
X-MTK: N

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

Add get_sec_port interface to ddp_comp to get the secure port settings
from ovl and ovl_adaptor.
Then mediatek-drm will use secure cmdq driver to configure DRAM access
permission in secure world by their secure port settings.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index 17c690e1f477f..cddad8978c1c5 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -92,6 +92,7 @@ struct mtk_ddp_comp_funcs {
 	size_t (*crc_cnt)(struct device *dev);
 	u32 *(*crc_entry)(struct device *dev);
 	void (*crc_read)(struct device *dev);
+	u64 (*get_sec_port)(struct mtk_ddp_comp *comp, unsigned int idx);
 };
 
 struct mtk_ddp_comp {
@@ -237,6 +238,14 @@ static inline unsigned int mtk_ddp_gamma_get_lut_size(struct mtk_ddp_comp *comp)
 	return 0;
 }
 
+static inline u64 mtk_ddp_comp_layer_get_sec_port(struct mtk_ddp_comp *comp,
+						  unsigned int idx)
+{
+	if (comp->funcs && comp->funcs->get_sec_port)
+		return comp->funcs->get_sec_port(comp, idx);
+	return 0;
+}
+
 static inline void mtk_ddp_gamma_set(struct mtk_ddp_comp *comp,
 				     struct drm_crtc_state *state)
 {
-- 
2.18.0


