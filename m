Return-Path: <linux-kernel+bounces-136771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5889D7F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F6B1C24466
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51612E1F6;
	Tue,  9 Apr 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D14Qe1+d"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817512E1DF;
	Tue,  9 Apr 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662414; cv=none; b=EwfRLfcY1iV3Hu1PEnydopaG4ixOpq+c9v2UIqHjxDbwiB3A9TzY/Tqy08kNx327n1B8Ox5vaT6uW2oTqorGbeYsk3juSE8dfzOHmQ2EjOsOklYZNgK3nBZjmXjnj89Gl3YRg3IJiDDrMZhoVLTzzk2EaxphsOeXJSn8hlXmPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662414; c=relaxed/simple;
	bh=2sa0czol+M3wlqjbrCy6HFZ0ZDdi6agl2iY8luWcwKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lmm1VUuIggq9HxKPPpm6Hd/NRyzEttz8zCsc5NGILyb+nQr1rqyXOA9P11awUbsd0W6XzuZyaehBkzYHtMVPjB1Ic0L+gV86YW7A8N3OYKkaxQJugLvlaGi4uZQ7VBcjCFj2j/XhiueyYNaOgWaIGdzveRk21ASlLyFBU4V5Vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D14Qe1+d; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662410;
	bh=2sa0czol+M3wlqjbrCy6HFZ0ZDdi6agl2iY8luWcwKU=;
	h=From:To:Cc:Subject:Date:From;
	b=D14Qe1+dY6nxSzSEqTMvcCkZ+ZodJyh7mvU5newHJvq3qcXrDmRf6GOHmT5KpoJZg
	 T7CqC5zwpMpgqMSpI89xS0cO8VjusWoTFmW1lBKZ1Cv91N2OrC/J96jI6+Hnxu7Q48
	 T1j/m0J7QNTLGvAMpGfHkWwjnL8QkrQTjA7UWSNb/+ZHpwsPMNmb4iV7pkfLYJC6n7
	 bJbj+RvosTiSxyRq7b9EBkwh+byGWB/re5Hm6yDkG27YOSl5hZhjJdK2uuMndPlP+7
	 /Pduw0MhgSVu34XJGZVXirGEkOUvpGGTnZg5r3U0WAOnRAinqvv8gpVzsOlmfK2xWk
	 3Tb+8t959dnpw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4CEF637820F5;
	Tue,  9 Apr 2024 11:33:28 +0000 (UTC)
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
Subject: [PATCH v4 00/18] SoC: Cleanup MediaTek soundcard machine drivers
Date: Tue,  9 Apr 2024 13:32:52 +0200
Message-ID: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 - Rebased over next-20240409
 - Dropped the first 4 patches from v3 as were already picked by Mark

Changes in v3:
 - Added audio-routing names in enum in all yaml files
 - Added mention of disallowing old and new properties together in
   commit message of bindings patches
 - Fixed validation errors with sound-card-common.yaml inclusion
   due to missing model property in examples
 - Removed `else` enforcing headset-codec/speaker-codecs requirement
   if xxx-dai-link not present to avoid future commit noise as the
   deprecated statement will disallow deprecated properties as required

Changes in v2:
 - Bindings: Changed link-name/codec/clk-provider to remove `items`
   and leave just the enum
 - Moved .*-dai-link pattern additionalProperties after `type: object`
 - Added ref to sound-card-common.yaml
 - Fixed dai-link-xxx -> xxx-dai-link typo in example comment

This series performs a cleanup of most of the MediaTek AFE drivers and
soundcard machine drivers, reducing code duplication and setting a base
to be consistent with their devicetree bindings, as many of those are
using different properties and nodes for no good reason.

Summarizing:
 - Commonizes functions and ops where possible
 - Adds a common probe mechanism, increasing maintainability of
   soundcard drivers for older MediaTek SoCs
 - Migrates all drivers to support the new bindings
   - Obviously retains compatibility with old device trees
 - Reduces machine-specific parameters hardcoding in drivers
   - Can now set machine-specific params in device tree
   - Uses the `audio-routing` and `dai-link` nodes like some
     other non-MediaTek SoC sound drivers
 - Imposes consistency between MediaTek ASoC machine soundcard
   drivers bindings
 - Reduces code size and greatly reduces the amount of code that
   will be required for newer drivers (retaining compatibility with
   the old bindings was costly in terms of code size, otherwise
   this series would've removed ~1000 more lines, or something
   along that line).

This series was (manually) tested on MT8173, MT8192, MT8195 and MT8186
Chromebooks.

AngeloGioacchino Del Regno (18):
  ASoC: mediatek: Add common machine soundcard driver probe mechanism
  ASoC: mediatek: common: Constify struct mtk_sof_priv
  ASoC: mediatek: mt8188: Migrate to mtk_soundcard_common_probe
  ASoC: mediatek: mt8195: Migrate to mtk_soundcard_common_probe
  ASoC: mediatek: mt8192: Migrate to mtk_soundcard_common_probe
  ASoC: mediatek: mt8186: Migrate to mtk_soundcard_common_probe
  ASoC: mediatek: Add common snd_soc_ops .startup() callback
  ASoC: mediatek: mt8195: Migrate to the common mtk_soundcard_startup
  ASoC: mediatek: mt8192: Migrate to the common mtk_soundcard_startup
  ASoC: mediatek: mt8186-rt1019: Migrate to the common
    mtk_soundcard_startup
  ASoC: mediatek: Add common mtk_afe_component_probe callback
  ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb
  ASoC: mediatek: mt8186: Unify mt8186-mt6366 machine drivers
  ASoC: dt-bindings: mt8195: Document audio-routing and dai-link subnode
  ASoC: dt-bindings: mt8192: Document audio-routing and dai-link subnode
  ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode
  arm64: dts: mediatek: mt8195-cherry: Specify sound DAI links and
    routing
  arm64: dts: mediatek: mt8186-corsola: Specify sound DAI links and
    routing

 .../sound/mt8186-mt6366-da7219-max98357.yaml  |  131 +-
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   |  120 +-
 .../sound/mt8192-mt6359-rt1015-rt5682.yaml    |  139 +-
 .../bindings/sound/mt8195-mt6359.yaml         |  134 ++
 .../boot/dts/mediatek/mt8186-corsola.dtsi     |   42 +-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   45 +
 sound/soc/mediatek/Kconfig                    |   24 +-
 .../mediatek/common/mtk-afe-platform-driver.c |   18 +
 .../soc/mediatek/common/mtk-dsp-sof-common.c  |   15 +-
 .../soc/mediatek/common/mtk-dsp-sof-common.h  |    1 -
 sound/soc/mediatek/common/mtk-soc-card.h      |    7 +-
 .../mediatek/common/mtk-soundcard-driver.c    |  199 +++
 .../mediatek/common/mtk-soundcard-driver.h    |   42 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c    |   14 +-
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c    |   14 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c    |   14 +-
 sound/soc/mediatek/mt8186/Makefile            |    3 +-
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    |   19 +-
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c   |    2 +-
 .../mt8186/mt8186-mt6366-da7219-max98357.c    | 1189 -----------------
 ...t6366-rt1019-rt5682s.c => mt8186-mt6366.c} |  578 ++++----
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    |   21 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     |  203 +--
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    |   25 +-
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      |  301 ++---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |   21 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c     |  487 +++----
 27 files changed, 1613 insertions(+), 2195 deletions(-)
 delete mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
 rename sound/soc/mediatek/mt8186/{mt8186-mt6366-rt1019-rt5682s.c => mt8186-mt6366.c} (72%)

-- 
2.44.0


