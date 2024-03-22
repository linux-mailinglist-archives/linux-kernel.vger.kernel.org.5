Return-Path: <linux-kernel+bounces-111215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F34E886943
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E0B1F22873
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE93D3BC;
	Fri, 22 Mar 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PVIpcBH9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E438DDD;
	Fri, 22 Mar 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099753; cv=none; b=idq1DhIliKUSxpeJiqWZD5z+vif0Ep32ud+GWv9PlYOm02/e9m4KLiuEvez5jCuJwjw9WQ2K1WpG9XcAqaqZSELeaAhEPjDfywUkcY+tfojEyHI3F/mD6IVO5+cVV14CjMNoyNtXVuj4ttSKSxQaU+0AR0XXLP5jkbxh9nXrfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099753; c=relaxed/simple;
	bh=4amundVKYBlSE0uqGcpRga8XrKsqEbBI94uQCoLB7QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHcpgzdjXNKDE37by91b4l8O5rZyoYSTkfrEI6u4mNHqWBTZ6xRPYpEnKNRWUBYQyzGeYwGtqntBDfcdQ6/zoI24zkW8UcDAWd3mH96DClLfIzzYABxlK/8xcLp6JDPwonqHfNHPEvNQCwTOLw8FFRTU+Bnk0+EAy/nHbbDicgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PVIpcBH9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711099749;
	bh=4amundVKYBlSE0uqGcpRga8XrKsqEbBI94uQCoLB7QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVIpcBH9kYPJIol66J9sc/Vr0EkaiebpxVCoufid4xumEC07fgZw+lVFqgR75SOT6
	 T6nJXxPjlh8sIRoc4/2P954uCXCQUGFbPRssPKmiRNo2ra9dTECtFLYegwRZ9TSWn5
	 7DnODLDFVLV8KiQxlUWQUL3YsDJFPuJxUGVF2jTOAO5hr+eT2oFBYHDdfaeCZJtozy
	 bIlMgygoSTFUcjMMECc3GSl/3pmDCpNV6kRpjjlf8voWzeGGDD7tAryt5CiFU3GOWZ
	 GM59EcbHxGEKo6KnkP2/MDHM4bYBJOMHXbIXg9kMXykSQF0NQe/OUoM9+kKaBw7vW2
	 WrHEhHBwaOlmQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6492A378211A;
	Fri, 22 Mar 2024 09:29:08 +0000 (UTC)
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
Subject: [PATCH 4/4] media: platform: mtk-mdp3: Add support for MT8188 MDP3 components
Date: Fri, 22 Mar 2024 10:28:45 +0100
Message-ID: <20240322092845.381313-5-angelogioacchino.delregno@collabora.com>
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

MT8195 and MT8188 share a similar MDP3 macro-block, with minor
differences - as in, the latter supports a subset of the number
of components supported by the former, but are otherwise handled
in the same way.

Add driver data for MT8188, reusing the already present MT8195
data where possible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 280 ++++++++++++++++++
 .../platform/mediatek/mdp3/mtk-img-ipi.h      |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |   3 +
 4 files changed, 285 insertions(+)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index ecca52b45307..0b4c50bc1776 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -46,6 +46,53 @@ enum mt8183_mdp_comp_id {
 	MT8183_MDP_COMP_WROT1,          /* 25 */
 };
 
+enum mt8188_mdp_comp_id {
+	/* MT8188 Comp id */
+	/* ISP */
+	MT8188_MDP_COMP_WPEI = 0,
+	MT8188_MDP_COMP_WPEO,           /* 1 */
+
+	/* MDP */
+	MT8188_MDP_COMP_CAMIN,          /* 2 */
+	MT8188_MDP_COMP_RDMA0,          /* 3 */
+	MT8188_MDP_COMP_RDMA2,          /* 4 */
+	MT8188_MDP_COMP_RDMA3,          /* 5 */
+	MT8188_MDP_COMP_FG0,            /* 6 */
+	MT8188_MDP_COMP_FG2,            /* 7 */
+	MT8188_MDP_COMP_FG3,            /* 8 */
+	MT8188_MDP_COMP_TO_SVPP2MOUT,   /* 9 */
+	MT8188_MDP_COMP_TO_SVPP3MOUT,   /* 10 */
+	MT8188_MDP_COMP_TO_WARP0MOUT,   /* 11 */
+	MT8188_MDP_COMP_VPP0_SOUT,      /* 12 */
+	MT8188_MDP_COMP_VPP1_SOUT,      /* 13 */
+	MT8188_MDP_COMP_PQ0_SOUT,       /* 14 */
+	MT8188_MDP_COMP_HDR0,           /* 15 */
+	MT8188_MDP_COMP_HDR2,           /* 16 */
+	MT8188_MDP_COMP_HDR3,           /* 17 */
+	MT8188_MDP_COMP_AAL0,           /* 18 */
+	MT8188_MDP_COMP_AAL2,           /* 19 */
+	MT8188_MDP_COMP_AAL3,           /* 20 */
+	MT8188_MDP_COMP_RSZ0,           /* 21 */
+	MT8188_MDP_COMP_RSZ2,           /* 22 */
+	MT8188_MDP_COMP_RSZ3,           /* 23 */
+	MT8188_MDP_COMP_TDSHP0,         /* 24 */
+	MT8188_MDP_COMP_TDSHP2,         /* 25 */
+	MT8188_MDP_COMP_TDSHP3,         /* 26 */
+	MT8188_MDP_COMP_COLOR0,         /* 27 */
+	MT8188_MDP_COMP_COLOR2,         /* 28 */
+	MT8188_MDP_COMP_COLOR3,         /* 29 */
+	MT8188_MDP_COMP_OVL0,           /* 30 */
+	MT8188_MDP_COMP_PAD0,           /* 31 */
+	MT8188_MDP_COMP_PAD2,           /* 32 */
+	MT8188_MDP_COMP_PAD3,           /* 33 */
+	MT8188_MDP_COMP_TCC0,           /* 34 */
+	MT8188_MDP_COMP_WROT0,          /* 35 */
+	MT8188_MDP_COMP_WROT2,          /* 36 */
+	MT8188_MDP_COMP_WROT3,          /* 37 */
+	MT8188_MDP_COMP_MERGE2,         /* 38 */
+	MT8188_MDP_COMP_MERGE3,         /* 39 */
+};
+
 enum mt8195_mdp_comp_id {
 	/* MT8195 Comp id */
 	/* ISP */
@@ -123,6 +170,13 @@ static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
 	[MDP_INFRA_SCP] = { .compatible = "mediatek,mt8183-scp" }
 };
 
+static const struct of_device_id mt8188_mdp_probe_infra[MDP_INFRA_MAX] = {
+	[MDP_INFRA_MMSYS] = { .compatible = "mediatek,mt8188-vppsys0" },
+	[MDP_INFRA_MMSYS2] = { .compatible = "mediatek,mt8188-vppsys1" },
+	[MDP_INFRA_MUTEX] = { .compatible = "mediatek,mt8188-vpp-mutex" },
+	[MDP_INFRA_MUTEX2] = { .compatible = "mediatek,mt8188-vpp-mutex" },
+};
+
 static const struct of_device_id mt8195_mdp_probe_infra[MDP_INFRA_MAX] = {
 	[MDP_INFRA_MMSYS] = { .compatible = "mediatek,mt8195-vppsys0" },
 	[MDP_INFRA_MMSYS2] = { .compatible = "mediatek,mt8195-vppsys1" },
@@ -167,6 +221,40 @@ static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_CCORR0] = MUTEX_MOD_IDX_MDP_CCORR0,
 };
 
+static const u32 mt8188_mutex_idx[MDP_MAX_COMP_COUNT] = {
+	[MDP_COMP_RDMA0] = MUTEX_MOD_IDX_MDP_RDMA0,
+	[MDP_COMP_RDMA2] = MUTEX_MOD_IDX_MDP_RDMA2,
+	[MDP_COMP_RDMA3] = MUTEX_MOD_IDX_MDP_RDMA3,
+	[MDP_COMP_FG0] = MUTEX_MOD_IDX_MDP_FG0,
+	[MDP_COMP_FG2] = MUTEX_MOD_IDX_MDP_FG2,
+	[MDP_COMP_FG3] = MUTEX_MOD_IDX_MDP_FG3,
+	[MDP_COMP_HDR0] = MUTEX_MOD_IDX_MDP_HDR0,
+	[MDP_COMP_HDR2] = MUTEX_MOD_IDX_MDP_HDR2,
+	[MDP_COMP_HDR3] = MUTEX_MOD_IDX_MDP_HDR3,
+	[MDP_COMP_AAL0] = MUTEX_MOD_IDX_MDP_AAL0,
+	[MDP_COMP_AAL2] = MUTEX_MOD_IDX_MDP_AAL2,
+	[MDP_COMP_AAL3] = MUTEX_MOD_IDX_MDP_AAL3,
+	[MDP_COMP_RSZ0] = MUTEX_MOD_IDX_MDP_RSZ0,
+	[MDP_COMP_RSZ2] = MUTEX_MOD_IDX_MDP_RSZ2,
+	[MDP_COMP_RSZ3] = MUTEX_MOD_IDX_MDP_RSZ3,
+	[MDP_COMP_MERGE2] = MUTEX_MOD_IDX_MDP_MERGE2,
+	[MDP_COMP_MERGE3] = MUTEX_MOD_IDX_MDP_MERGE3,
+	[MDP_COMP_TDSHP0] = MUTEX_MOD_IDX_MDP_TDSHP0,
+	[MDP_COMP_TDSHP2] = MUTEX_MOD_IDX_MDP_TDSHP2,
+	[MDP_COMP_TDSHP3] = MUTEX_MOD_IDX_MDP_TDSHP3,
+	[MDP_COMP_COLOR0] = MUTEX_MOD_IDX_MDP_COLOR0,
+	[MDP_COMP_COLOR2] = MUTEX_MOD_IDX_MDP_COLOR2,
+	[MDP_COMP_COLOR3] = MUTEX_MOD_IDX_MDP_COLOR3,
+	[MDP_COMP_OVL0] = MUTEX_MOD_IDX_MDP_OVL0,
+	[MDP_COMP_PAD0] = MUTEX_MOD_IDX_MDP_PAD0,
+	[MDP_COMP_PAD2] = MUTEX_MOD_IDX_MDP_PAD2,
+	[MDP_COMP_PAD3] = MUTEX_MOD_IDX_MDP_PAD3,
+	[MDP_COMP_TCC0] = MUTEX_MOD_IDX_MDP_TCC0,
+	[MDP_COMP_WROT0] = MUTEX_MOD_IDX_MDP_WROT0,
+	[MDP_COMP_WROT2] = MUTEX_MOD_IDX_MDP_WROT2,
+	[MDP_COMP_WROT3] = MUTEX_MOD_IDX_MDP_WROT3,
+};
+
 static const u32 mt8195_mutex_idx[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_RDMA0] = MUTEX_MOD_IDX_MDP_RDMA0,
 	[MDP_COMP_RDMA1] = MUTEX_MOD_IDX_MDP_RDMA1,
@@ -288,6 +376,171 @@ static const struct mdp_comp_data mt8183_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
 	},
 };
 
+static const struct mdp_comp_data mt8188_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
+	[MDP_COMP_WPEI] = {
+		{MDP_COMP_TYPE_WPEI, 0, MT8188_MDP_COMP_WPEI, MDP_MM_SUBSYS_0},
+		{0, 0, 0}
+	},
+	[MDP_COMP_WPEO] = {
+		{MDP_COMP_TYPE_EXTO, 0, MT8188_MDP_COMP_WPEO, MDP_MM_SUBSYS_0},
+		{0, 0, 0}
+	},
+	[MDP_COMP_CAMIN] = {
+		{MDP_COMP_TYPE_DL_PATH, 0, MT8188_MDP_COMP_CAMIN, MDP_MM_SUBSYS_0},
+		{3, 3, 0}
+	},
+	[MDP_COMP_RDMA0] = {
+		{MDP_COMP_TYPE_RDMA, 0, MT8188_MDP_COMP_RDMA0, MDP_MM_SUBSYS_0},
+		{3, 0, 0}
+	},
+	[MDP_COMP_RDMA2] = {
+		{MDP_COMP_TYPE_RDMA, 1, MT8188_MDP_COMP_RDMA2, MDP_MM_SUBSYS_1},
+		{3, 0, 0}
+	},
+	[MDP_COMP_RDMA3] = {
+		{MDP_COMP_TYPE_RDMA, 2, MT8188_MDP_COMP_RDMA3, MDP_MM_SUBSYS_1},
+		{3, 0, 0}
+	},
+	[MDP_COMP_FG0] = {
+		{MDP_COMP_TYPE_FG, 0, MT8188_MDP_COMP_FG0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_FG2] = {
+		{MDP_COMP_TYPE_FG, 1, MT8188_MDP_COMP_FG2, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_FG3] = {
+		{MDP_COMP_TYPE_FG, 2, MT8188_MDP_COMP_FG3, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_HDR0] = {
+		{MDP_COMP_TYPE_HDR, 0, MT8188_MDP_COMP_HDR0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_HDR2] = {
+		{MDP_COMP_TYPE_HDR, 1, MT8188_MDP_COMP_HDR2, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_HDR3] = {
+		{MDP_COMP_TYPE_HDR, 2, MT8188_MDP_COMP_HDR3, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_AAL0] = {
+		{MDP_COMP_TYPE_AAL, 0, MT8188_MDP_COMP_AAL0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_AAL2] = {
+		{MDP_COMP_TYPE_AAL, 1, MT8188_MDP_COMP_AAL2, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_AAL3] = {
+		{MDP_COMP_TYPE_AAL, 2, MT8188_MDP_COMP_AAL3, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_RSZ0] = {
+		{MDP_COMP_TYPE_RSZ, 0, MT8188_MDP_COMP_RSZ0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_RSZ2] = {
+		{MDP_COMP_TYPE_RSZ, 1, MT8188_MDP_COMP_RSZ2, MDP_MM_SUBSYS_1},
+		{2, 0, 0},
+		{MDP_COMP_MERGE2, true, true}
+	},
+	[MDP_COMP_RSZ3] = {
+		{MDP_COMP_TYPE_RSZ, 2, MT8188_MDP_COMP_RSZ3, MDP_MM_SUBSYS_1},
+		{2, 0, 0},
+		{MDP_COMP_MERGE3, true, true}
+	},
+	[MDP_COMP_TDSHP0] = {
+		{MDP_COMP_TYPE_TDSHP, 0, MT8188_MDP_COMP_TDSHP0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_TDSHP2] = {
+		{MDP_COMP_TYPE_TDSHP, 1, MT8188_MDP_COMP_TDSHP2, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_TDSHP3] = {
+		{MDP_COMP_TYPE_TDSHP, 2, MT8188_MDP_COMP_TDSHP3, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_COLOR0] = {
+		{MDP_COMP_TYPE_COLOR, 0, MT8188_MDP_COMP_COLOR0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_COLOR2] = {
+		{MDP_COMP_TYPE_COLOR, 1, MT8188_MDP_COMP_COLOR2, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_COLOR3] = {
+		{MDP_COMP_TYPE_COLOR, 2, MT8188_MDP_COMP_COLOR3, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_OVL0] = {
+		{MDP_COMP_TYPE_OVL, 0, MT8188_MDP_COMP_OVL0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_PAD0] = {
+		{MDP_COMP_TYPE_PAD, 0, MT8188_MDP_COMP_PAD0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_PAD2] = {
+		{MDP_COMP_TYPE_PAD, 1, MT8188_MDP_COMP_PAD2, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_PAD3] = {
+		{MDP_COMP_TYPE_PAD, 2, MT8188_MDP_COMP_PAD3, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_TCC0] = {
+		{MDP_COMP_TYPE_TCC, 0, MT8188_MDP_COMP_TCC0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_WROT0] = {
+		{MDP_COMP_TYPE_WROT, 0, MT8188_MDP_COMP_WROT0, MDP_MM_SUBSYS_0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_WROT2] = {
+		{MDP_COMP_TYPE_WROT, 1, MT8188_MDP_COMP_WROT2, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_WROT3] = {
+		{MDP_COMP_TYPE_WROT, 2, MT8188_MDP_COMP_WROT3, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_MERGE2] = {
+		{MDP_COMP_TYPE_MERGE, 0, MT8188_MDP_COMP_MERGE2, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_MERGE3] = {
+		{MDP_COMP_TYPE_MERGE, 1, MT8188_MDP_COMP_MERGE3, MDP_MM_SUBSYS_1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_PQ0_SOUT] = {
+		{MDP_COMP_TYPE_DUMMY, 0, MT8188_MDP_COMP_PQ0_SOUT, MDP_MM_SUBSYS_0},
+		{0, 0, 0}
+	},
+	[MDP_COMP_TO_WARP0MOUT] = {
+		{MDP_COMP_TYPE_DUMMY, 1, MT8188_MDP_COMP_TO_WARP0MOUT, MDP_MM_SUBSYS_0},
+		{0, 0, 0}
+	},
+	[MDP_COMP_TO_SVPP2MOUT] = {
+		{MDP_COMP_TYPE_DUMMY, 2, MT8188_MDP_COMP_TO_SVPP2MOUT, MDP_MM_SUBSYS_1},
+		{0, 0, 0}
+	},
+	[MDP_COMP_TO_SVPP3MOUT] = {
+		{MDP_COMP_TYPE_DUMMY, 3, MT8188_MDP_COMP_TO_SVPP3MOUT, MDP_MM_SUBSYS_1},
+		{0, 0, 0}
+	},
+	[MDP_COMP_VPP0_SOUT] = {
+		{MDP_COMP_TYPE_PATH, 0, MT8188_MDP_COMP_VPP0_SOUT, MDP_MM_SUBSYS_1},
+		{2, 6, 0}
+	},
+	[MDP_COMP_VPP1_SOUT] = {
+		{MDP_COMP_TYPE_PATH, 1, MT8188_MDP_COMP_VPP1_SOUT, MDP_MM_SUBSYS_0},
+		{2, 8, 0}
+	},
+};
+
 static const struct mdp_comp_data mt8195_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_WPEI] = {
 		{MDP_COMP_TYPE_WPEI, 0, MT8195_MDP_COMP_WPEI, MDP_MM_SUBSYS_0},
@@ -1046,6 +1299,15 @@ static const struct mdp_pipe_info mt8183_pipe_info[] = {
 	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, MDP_MM_SUBSYS_0, 3}
 };
 
+static const struct mdp_pipe_info mt8188_pipe_info[] = {
+	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, MDP_MM_SUBSYS_0, 0},
+	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, MDP_MM_SUBSYS_0, 1},
+	[MDP_PIPE_RDMA2] = {MDP_PIPE_RDMA2, MDP_MM_SUBSYS_1, 0},
+	[MDP_PIPE_RDMA3] = {MDP_PIPE_RDMA3, MDP_MM_SUBSYS_1, 1},
+	[MDP_PIPE_VPP1_SOUT] = {MDP_PIPE_VPP1_SOUT, MDP_MM_SUBSYS_0, 2},
+	[MDP_PIPE_VPP0_SOUT] = {MDP_PIPE_VPP0_SOUT, MDP_MM_SUBSYS_1, 2},
+};
+
 static const struct mdp_pipe_info mt8195_pipe_info[] = {
 	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, MDP_MM_SUBSYS_0, 0},
 	[MDP_PIPE_WPEI2] = {MDP_PIPE_WPEI2, MDP_MM_SUBSYS_0, 1},
@@ -1082,6 +1344,24 @@ const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.pp_used = MDP_PP_USED_1,
 };
 
+const struct mtk_mdp_driver_data mt8188_mdp_driver_data = {
+	.mdp_plat_id = MT8188,
+	.mdp_con_res = 0x14001000,
+	.mdp_probe_infra = mt8188_mdp_probe_infra,
+	.mdp_sub_comp_dt_ids = mt8195_sub_comp_dt_ids,
+	.mdp_cfg = &mt8195_plat_cfg,
+	.mdp_mutex_table_idx = mt8188_mutex_idx,
+	.comp_data = mt8188_mdp_comp_data,
+	.comp_data_len = ARRAY_SIZE(mt8188_mdp_comp_data),
+	.format = mt8195_formats,
+	.format_len = ARRAY_SIZE(mt8195_formats),
+	.def_limit = &mt8195_mdp_def_limit,
+	.pipe_info = mt8188_pipe_info,
+	.pipe_info_len = ARRAY_SIZE(mt8188_pipe_info),
+	.pp_criteria = &mt8195_mdp_pp_criteria,
+	.pp_used = MDP_PP_USED_2,
+};
+
 const struct mtk_mdp_driver_data mt8195_mdp_driver_data = {
 	.mdp_plat_id = MT8195,
 	.mdp_con_res = 0x14001000,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
index f83ac408306e..4764c5b5107b 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
@@ -116,6 +116,7 @@ struct img_frameparam {
 
 /* Platform config indicator */
 #define MT8183 8183
+#define MT8188 8195
 #define MT8195 8195
 
 #define CFG_CHECK(plat, p_id) ((plat) == (p_id))
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
index 49cdf45f6e59..7f7625299ce7 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 
 extern const struct mtk_mdp_driver_data mt8183_mdp_driver_data;
+extern const struct mtk_mdp_driver_data mt8188_mdp_driver_data;
 extern const struct mtk_mdp_driver_data mt8195_mdp_driver_data;
 
 struct mdp_dev;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 5209f531ef8d..61a798f33041 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -21,6 +21,9 @@ static const struct of_device_id mdp_of_ids[] = {
 	{ .compatible = "mediatek,mt8183-mdp3-rdma",
 	  .data = &mt8183_mdp_driver_data,
 	},
+	{ .compatible = "mediatek,mt8188-mdp3-rdma",
+	  .data = &mt8188_mdp_driver_data,
+	},
 	{ .compatible = "mediatek,mt8195-mdp3-rdma",
 	  .data = &mt8195_mdp_driver_data,
 	},
-- 
2.44.0


