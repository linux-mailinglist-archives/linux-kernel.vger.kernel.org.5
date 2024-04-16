Return-Path: <linux-kernel+bounces-146395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DDE8A64BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EC11C20383
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545915B12A;
	Tue, 16 Apr 2024 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rq4HZUZ3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49F15ADB0;
	Tue, 16 Apr 2024 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251687; cv=none; b=k8yAASfivgfFD7cMe8Y7lhkKBFOynM5r1+t6VTd5KQR70roWEyGJFTuDuDEVEHpK8ti9O71OuL4OPWLdf3mHqgZTQcZLWl+EWd78OM2SzHhxQMafeL/ZVWBhSReM7q6a8pBuuE54Bb3T/Xe5j2W9ZyLxYB+uw2+Hi1spwR3L3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251687; c=relaxed/simple;
	bh=ZihqOvAsqLa0MvqNqKVldLZPj/NVl1J4njOx31ufWsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVZhwB30+Tf+O+VypsM3noc3S2oH1N/hvLNNpJTXd8HFM4UECkh2adqZ0n/mt/Y+c04t/ZgQrq5RVGjDAat1Yxk0yDuTDANvtI8Ef61CgIWfQffNsXmxPcKT1UZR/Kdutin2VwZ2XkE7K1kXye243bb92cqgJQH7xqup7kEIFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rq4HZUZ3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713251684;
	bh=ZihqOvAsqLa0MvqNqKVldLZPj/NVl1J4njOx31ufWsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rq4HZUZ3E3NWylxpfqb3YWQ7uGToD4AoQLEpIj4QzP5CXUZnSVMksgV1kN6+p7hBU
	 7VBzx5dPCVVWSbuu0NiJ5GN3VWZppUrgskfOZLuej4mFvpl54zE7BSTcY4DyuxkJ3u
	 tWg/HybegIjqli+sTup6etrGwZHiAhPYZ2gf1BGvgeJyNKMf3cHzcf/nQV3fszJKG0
	 +fC/tDbJK9sA8Ziz3l/da3HsXG9V85WnIQXfMPNKhsCrWeSR7G4J64S+4iJreCTsLA
	 t5ovTOct7L+KbYRm25nKoBh/gk2ndsrfffhEdAOB6KYtZ+s5tnM3/p3IwGQ3bDd48S
	 cBZHDv6OPJscQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8E96A3782123;
	Tue, 16 Apr 2024 07:14:42 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 11/18] ASoC: mediatek: Add common mtk_afe_component_probe callback
Date: Tue, 16 Apr 2024 09:14:03 +0200
Message-ID: <20240416071410.75620-12-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
References: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple MediaTek AFE PCM component drivers are using their own .probe()
callback, but most of those are simply duplicated functions as they are
doing exactly the same thing over and over.

Add a common probe callback for this component to reduce duplication.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/common/mtk-afe-platform-driver.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 32edcb6d5219..9b72b2a7ae91 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -126,10 +126,28 @@ int mtk_afe_pcm_new(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);
 
+static int mtk_afe_component_probe(struct snd_soc_component *component)
+{
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	snd_soc_component_init_regmap(component, afe->regmap);
+
+	/* If the list was never initialized there are no sub-DAIs */
+	if (afe->sub_dais.next && afe->sub_dais.prev) {
+		ret = mtk_afe_add_sub_dai_control(component);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct snd_soc_component_driver mtk_afe_pcm_platform = {
 	.name		= AFE_PCM_NAME,
 	.pointer	= mtk_afe_pcm_pointer,
 	.pcm_construct	= mtk_afe_pcm_new,
+	.probe		= mtk_afe_component_probe,
 };
 EXPORT_SYMBOL_GPL(mtk_afe_pcm_platform);
 
-- 
2.44.0


