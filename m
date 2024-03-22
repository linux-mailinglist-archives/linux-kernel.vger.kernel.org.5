Return-Path: <linux-kernel+bounces-111213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C1888693D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2061D288FED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6D383AD;
	Fri, 22 Mar 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WbbnfJkv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4C20DD2;
	Fri, 22 Mar 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099750; cv=none; b=Vzit2k9KFSbT9sJ43cKLH5KzOnqcsh0Lx82hnUkbgv1FJYUn82y4T5FWyCQrBsgmgFOyuXqDHInSAcvcI15N+t+JDheLGljWc3WTmdJQdz2pLNLI3H1qJ3cGJYzleTm/xd62Rlow0h+kPqF3RYk77YCX2rL1kWWIJv3RJ0/xUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099750; c=relaxed/simple;
	bh=Wnqi/8nTyYsYR9mbf5gdbfjh3PIg2gYWbMWP18KoMGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr6+ZT3G9iRq6W3NPXeH8kHlpZ6x3/ivRoeCO7CX2fky6fdMSE3f9j31FsF0cMow321JJCorMWLawtlyeqXRk+wJINjpDH/9VPRWizEmx6CURhnEsDd3QrieioVtKiZOzXEEj9Bq/hB/Z8Yf1y/XwytNn/XWBoUlfpJloCmg/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WbbnfJkv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711099746;
	bh=Wnqi/8nTyYsYR9mbf5gdbfjh3PIg2gYWbMWP18KoMGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbbnfJkvuG+3oGfcgiF+MLOm95ihkIigk7440eh9slcpU19eIRFzpKyOBOFLUtmbC
	 IIYaS7aOYeqOxwT3L/neJBaljkpdy5u0+lAYkKZPmQAY8ivZlvumP+iXaWFLOMXdSd
	 gu4qBwltgrE33Dwo+EseuVMfbM39LUTF0iJp+VEodK+H6v2kE/drGt7H5rrZQffNzI
	 uHGBRLTk2TivbRjvpMl/VQivnTKoTUrPprjQF2x9wAvQeSUUIaJg3iZbmtWQkqO4CG
	 drhV0AThO2wTJbF3dq+NteYbXvQQPk7BjVIokpodDzxn+CNZPdbR7poNiZGoerIB+r
	 NhtWv2aT3EShg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A949A3782118;
	Fri, 22 Mar 2024 09:29:05 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com,
	moudy.ho@mediatek.com,
	hverkuil-cisco@xs4all.nl,
	sebastian.fricke@collabora.com,
	u.kleine-koenig@pengutronix.de,
	chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 2/4] soc: mediatek: mtk-mutex: Add support for MT8188 VPPSYS
Date: Fri, 22 Mar 2024 10:28:43 +0100
Message-ID: <20240322092845.381313-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MT8188 VPPSYS0 and VPPSYS1 mutex info to driver data

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 73c256d3950b..b5af1fb5847e 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -496,6 +496,39 @@ static const unsigned int mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_MERGE5] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE4,
 };
 
+static const unsigned int mt8188_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
+	[MUTEX_MOD_IDX_MDP_RDMA0] = MT8195_MUTEX_MOD_MDP_RDMA0,
+	[MUTEX_MOD_IDX_MDP_RDMA2] = MT8195_MUTEX_MOD_MDP_RDMA2,
+	[MUTEX_MOD_IDX_MDP_RDMA3] = MT8195_MUTEX_MOD_MDP_RDMA3,
+	[MUTEX_MOD_IDX_MDP_FG0] = MT8195_MUTEX_MOD_MDP_FG0,
+	[MUTEX_MOD_IDX_MDP_FG2] = MT8195_MUTEX_MOD_MDP_FG2,
+	[MUTEX_MOD_IDX_MDP_FG3] = MT8195_MUTEX_MOD_MDP_FG3,
+	[MUTEX_MOD_IDX_MDP_HDR0] = MT8195_MUTEX_MOD_MDP_HDR0,
+	[MUTEX_MOD_IDX_MDP_HDR2] = MT8195_MUTEX_MOD_MDP_HDR2,
+	[MUTEX_MOD_IDX_MDP_HDR3] = MT8195_MUTEX_MOD_MDP_HDR3,
+	[MUTEX_MOD_IDX_MDP_AAL0] = MT8195_MUTEX_MOD_MDP_AAL0,
+	[MUTEX_MOD_IDX_MDP_AAL2] = MT8195_MUTEX_MOD_MDP_AAL2,
+	[MUTEX_MOD_IDX_MDP_AAL3] = MT8195_MUTEX_MOD_MDP_AAL3,
+	[MUTEX_MOD_IDX_MDP_RSZ0] = MT8195_MUTEX_MOD_MDP_RSZ0,
+	[MUTEX_MOD_IDX_MDP_RSZ2] = MT8195_MUTEX_MOD_MDP_RSZ2,
+	[MUTEX_MOD_IDX_MDP_RSZ3] = MT8195_MUTEX_MOD_MDP_RSZ3,
+	[MUTEX_MOD_IDX_MDP_MERGE2] = MT8195_MUTEX_MOD_MDP_MERGE2,
+	[MUTEX_MOD_IDX_MDP_MERGE3] = MT8195_MUTEX_MOD_MDP_MERGE3,
+	[MUTEX_MOD_IDX_MDP_TDSHP0] = MT8195_MUTEX_MOD_MDP_TDSHP0,
+	[MUTEX_MOD_IDX_MDP_TDSHP2] = MT8195_MUTEX_MOD_MDP_TDSHP2,
+	[MUTEX_MOD_IDX_MDP_TDSHP3] = MT8195_MUTEX_MOD_MDP_TDSHP3,
+	[MUTEX_MOD_IDX_MDP_COLOR0] = MT8195_MUTEX_MOD_MDP_COLOR0,
+	[MUTEX_MOD_IDX_MDP_COLOR2] = MT8195_MUTEX_MOD_MDP_COLOR2,
+	[MUTEX_MOD_IDX_MDP_COLOR3] = MT8195_MUTEX_MOD_MDP_COLOR3,
+	[MUTEX_MOD_IDX_MDP_OVL0] = MT8195_MUTEX_MOD_MDP_OVL0,
+	[MUTEX_MOD_IDX_MDP_PAD0] = MT8195_MUTEX_MOD_MDP_PAD0,
+	[MUTEX_MOD_IDX_MDP_PAD2] = MT8195_MUTEX_MOD_MDP_PAD2,
+	[MUTEX_MOD_IDX_MDP_PAD3] = MT8195_MUTEX_MOD_MDP_PAD3,
+	[MUTEX_MOD_IDX_MDP_WROT0] = MT8195_MUTEX_MOD_MDP_WROT0,
+	[MUTEX_MOD_IDX_MDP_WROT2] = MT8195_MUTEX_MOD_MDP_WROT2,
+	[MUTEX_MOD_IDX_MDP_WROT3] = MT8195_MUTEX_MOD_MDP_WROT3,
+};
+
 static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8192_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8192_MUTEX_MOD_DISP_CCORR0,
@@ -735,6 +768,13 @@ static const struct mtk_mutex_data mt8188_mutex_driver_data = {
 	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
 };
 
+static const struct mtk_mutex_data mt8188_vpp_mutex_driver_data = {
+	.mutex_sof = mt8188_mutex_sof,
+	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
+	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+	.mutex_table_mod = mt8188_mdp_mutex_table_mod,
+};
+
 static const struct mtk_mutex_data mt8192_mutex_driver_data = {
 	.mutex_mod = mt8192_mutex_mod,
 	.mutex_sof = mt8183_mutex_sof,
@@ -1089,6 +1129,7 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt8186-disp-mutex", .data = &mt8186_mutex_driver_data },
 	{ .compatible = "mediatek,mt8186-mdp3-mutex", .data = &mt8186_mdp_mutex_driver_data },
 	{ .compatible = "mediatek,mt8188-disp-mutex", .data = &mt8188_mutex_driver_data },
+	{ .compatible = "mediatek,mt8188-vpp-mutex",  .data = &mt8188_vpp_mutex_driver_data },
 	{ .compatible = "mediatek,mt8192-disp-mutex", .data = &mt8192_mutex_driver_data },
 	{ .compatible = "mediatek,mt8195-disp-mutex", .data = &mt8195_mutex_driver_data },
 	{ .compatible = "mediatek,mt8195-vpp-mutex",  .data = &mt8195_vpp_mutex_driver_data },
-- 
2.44.0


