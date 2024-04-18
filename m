Return-Path: <linux-kernel+bounces-150268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC208A9C90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC72867C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D847168AE9;
	Thu, 18 Apr 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Om46ci8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F830165FD6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449833; cv=none; b=a9k4svg2zcR73ugsWcCGrIt2VGzbG7Al4mqezL56r956JSBl0YnJsBq4P0rPrp9Lb3DyoUkHv3VDfJ8ZyKlVj2TF7BnEO847FdmcuKxEHXXqRpZBYBha7Wh8CcAszUTSzdrbjgQdFrd5YcQoap2OJFqLi6GsgDEK6N4kjvkgBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449833; c=relaxed/simple;
	bh=iWyHmrvi91xVl8ESknpnnskQ0bzxK0EmmpfVyEtSIeU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cMiNzw0vK9CKFeVaTjJh12I9h6PpEuskgqxTxETHUfgeLZOBxFMBguqe55Ab1xTELOsWVP9gYY7Zs+tGNrF2h2te+Hnf3TstJtbHbWxiibO97IBHgvlcGfvmaFfYbngrhBEWy8UzDOY0uRH1ohl1QZ1sW2RklRVm5LoUTvml05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0Om46ci8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-415515178ceso7651705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449829; x=1714054629; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4qQ3BMswui5iA/lahEt8yxPrfztwgwq30rSThlaR7E=;
        b=0Om46ci8lcC/51F8e8C+C4ioAQ5WwG9QKFAvZ1zF7jngqz2zvAn2D1dw/zSbf+Al2H
         e2EnhI0Zcxy9Ptl4SzPA6FF+FO7Wvg73Tme5BXbG8zTYcEqF6RKl2XuiidD4t74N+sgM
         ghTyY5D6zjmv4tODcHmPpjFz0zVechCMgKXPH9pQkoB1eo2NWINh0faXi9oj/S4WG+PK
         Jl+Fjw4AA7YSIdhnfTIpXa3KGar4DmSnK21te1q7qJHfUQCOsTSzrXx8oxiHb7l3O6cb
         54iFx2KmK6N8yzH8HzWKHgU5ewWok/RukXQQMhB8BOV3tKzJNuNaWTlbHwLZ2TsrXA/m
         3Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449829; x=1714054629;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4qQ3BMswui5iA/lahEt8yxPrfztwgwq30rSThlaR7E=;
        b=DDZUuXdQG0bv3Ga0f1KICAfvsJTvtYTp6hvu5TSocUqaPnHrN+Nhx/e6L2QFRsv2nV
         ScveliXqBWydyzRDaYQt5KLtkC1kkbLYe/FoixD3bixSbzh69suHpC6ajvPi12wo+ty0
         N8NrTVGZwsau2JQdfh4hM+3KRMtSXip0hriUdY8ZhEnsCobO4iWoo2uPkGMVH0OumdNF
         P+CrhMOb3M+E3eoYWnRCnki2vktnMCPLjjsfiwSAjia9n10RtEtxTMDsS5dkFxhWFwck
         MZU6ppYj99j8Gr3DTWOd45eRx+w9OMOd02x//jqb/ShMZ3IY7bkGFrz1kfMS/v7IhhPN
         VIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLdcEOXDjhJaSoTeWUJCaPby4lf97hD+19CHxFYc5MMT6W9zld38aF0sAt8Npa1zXJqcMc9WOEKf7kjVqJj+WD/WrOXcjlInU3oxoB
X-Gm-Message-State: AOJu0Yy9xPOCHu9C7AMtIF+9BDvDuarYtz0SrNy3Mf6zuKZDZvr/4iMi
	GqqeAPf/oZw1eL7KcI6Hd3AAoISn0TJPPpsPQN3uqww0qLaklp5mtdTdB8SJ6UU=
X-Google-Smtp-Source: AGHT+IGVpb9Ci2p5M2/Njc+fC5gHT3nWfNz2iG6ShInHy82wcrtLmmoA8+qGrmtDPDbBpbRZRHxZLQ==
X-Received: by 2002:a05:600c:1d9f:b0:418:fb6f:5fb3 with SMTP id p31-20020a05600c1d9f00b00418fb6f5fb3mr231339wms.3.1713449828814;
        Thu, 18 Apr 2024 07:17:08 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:08 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 00/17] Add display support for the MT8365-EVK board
Date: Thu, 18 Apr 2024 16:16:48 +0200
Message-Id: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFErIWYC/4WNyw7CIBREf8WwFsOjrejK/zAugF7tTWohgMSm6
 b8LXZoYF7M4k8yZhUQICJGcdwsJkDGimwrI/Y7YQU8PoNgXJoIJyUtoj9GPeqbx5b0Lidqu4cp
 IBg0/kbIyOgI1QU92qLsEMfHa+wB3fG9P11vhAWNyYd6OM6/t74/MKaOtVR2DvrVSmovR84gmw
 MG6J6m6LP4oRFFIaUGprjFCHL8U67p+AJXgYVoMAQAA
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Fabien Parent <fparent@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4094; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=iWyHmrvi91xVl8ESknpnnskQ0bzxK0EmmpfVyEtSIeU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStiDXn1Y76NsQCVXp2PgP1cU00kHkVfB6KmCx1+
 ZS5ACLWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYgAKCRArRkmdfjHURZacD/
 wNigbamUMpZ+kDSd8kSTVcAUnAHnBfhlQxARr20EYEsdJvr0dxAvYPFGzqy7D3V9JymwmbVdCSWV5v
 AmBgZO0Y+9lq0n+HHvGunQdRPjD6FeZkk5FOR93No/AdVsjkEisrZiZfUorTmIUe2jFLEZBY1PjKWp
 cq8eKYi7OQr2jjzgWEQTCwz4c2peq+05lAG8EBGa65mZiGR1At2etEN/mFE9L+KSBHrD3ye6Xhb9rX
 RePvXJTY8g4Ei5f3OIlYTyMXKbFBqhXYWfnIerD99LnhCqP8phhK4R9GPMM1FgzEKXaHhsarHj/hU5
 3G3dlhjbCy8zbHehVNeoDW6dYE8XLyGSxcsmvkoP8mk0u6QSmPYeddRqNjBiiiB8Dyt3+Gw2gfWZiA
 9brSdizNF3kil+S7N/MOyueiFY5+TNOf/LHgamwQuVP8tvpr1GKcMNM/CuB0pHIV93cCJPwORGHoUX
 YsVflyh1cjCYKeoM9HtjNht4psmHG7gQyJA4XQ6+2BzwAaO7sYjGvVY5b0rlYakZjENpKjMTGsjhdV
 SK0hiEfDk+Lg628vPNfN9cNoRF8tGIFHbtIyi8DUpHYzFNdpnALxR+JIKA65JIrjnNuj+C7zO6O3x7
 l7B1vhm0t8sNymp0uo5e2+CY2fbcUuqEnAQOMRq41K74P7V1VirFehKL7WLA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

The purpose of this series is to add the display support for the mt8365-evk.

This is the list of HWs / IPs support added:
- Connectors (HW):
  - HDMI
  - MIPI DSI (Mobile Industry Processor Interface Display Serial Interface)
- HDMI bridge (it66121)
- DSI pannel (startek,kd070fhfid015)
- SoC display blocks (IP):
  - OVL0 (Overlay)
  - RDMA0 (Data Path Read DMA)
  - Color0
  - CCorr0 (Color Correction)
  - AAL0 (Adaptive Ambient Light)
  - GAMMA0
  - Dither0
  - DSI0 (Display Serial Interface)
  - RDMA1 (Data Path Read DMA)
  - DPI0 (Display Parallel Interface)

The Mediatek DSI, DPI and DRM drivers are also improved.

Regards,
Alex

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v3:
- Drop "drm/mediatek: add mt8365 dpi support" because it's the same
  config as mt8192 SoC
- Drop "dt-bindings: pwm: mediatek,pwm-disp: add power-domains property"
  because an equivalent patch has been merge already.
- Add DPI clock fix in a separate commit.
- Improve DTS(I) readability.
- Link to v2: https://lore.kernel.org/r/20231023-display-support-v2-0-33ce8864b227@baylibre.com

Changes in v2:
- s/binding/compatible/ in commit messages/titles.
- Improve commit messages as Conor suggest.
- pwm-disp: Set power domain property for MT8365. This one is optionnal
  and can be used for other SoC.
- Fix mediatek,dsi.yaml issue.
- Remove the extra clock in the DPI node/driver and fix the dpi clock
  parenting to be consistent with the DPI clock assignement.
- Link to v1: https://lore.kernel.org/r/20231023-display-support-v1-0-5c860ed5c33b@baylibre.com

---
Alexandre Mergnat (15):
      dt-bindings: display: mediatek: aal: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: ccorr: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: color: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dither: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dsi: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dpi: add compatible for MT8365
      dt-bindings: display: mediatek: gamma: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: ovl: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: rdma: add compatible for MT8365 SoC
      dt-bindings: pwm: mediatek,pwm-disp: add compatible for mt8365 SoC
      clk: mediatek: mt8365-mm: fix DPI0 parent
      drm/mediatek: dsi: Improves the DSI lane setup robustness
      arm64: defconfig: enable display connector support
      arm64: dts: mediatek: add display blocks support for the MT8365 SoC
      arm64: dts: mediatek: add display support for mt8365-evk

Fabien Parent (2):
      dt-bindings: display: mediatek: dpi: add power-domains property
      drm/mediatek: add MT8365 SoC support

 .../bindings/display/mediatek/mediatek,aal.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,ccorr.yaml  |   3 +
 .../bindings/display/mediatek/mediatek,color.yaml  |   1 +
 .../bindings/display/mediatek/mediatek,dither.yaml |   1 +
 .../bindings/display/mediatek/mediatek,dpi.yaml    |   9 ++
 .../bindings/display/mediatek/mediatek,dsi.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,gamma.yaml  |   1 +
 .../bindings/display/mediatek/mediatek,ovl.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,rdma.yaml   |   1 +
 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        | 180 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 133 +++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/mediatek/clk-mt8365-mm.c               |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  30 ++++
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   2 +
 16 files changed, 367 insertions(+), 1 deletion(-)
---
base-commit: be0c499a5c5ff8eab746f36e2aa1e920edcb7e37
change-id: 20231023-display-support-c6418b30e419

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


