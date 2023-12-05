Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D86805134
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376504AbjLEKx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjLEKx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:53:57 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691610F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:54:03 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1c7b20f895so50484966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701773642; x=1702378442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vMrXeU9PccX6SmGwv0uL8uz2m+ssCwq/m3VB0zUtRA=;
        b=ezD/ZUP2ME2wTuwRKud9JPmBTlxyCvn1zYcnkWpD127A6GYqGSkRo9XpMMk3dfW1Ft
         x2NGk+UJE/1dQWdpPOysyyBwTj8kt3rINjqdfnTrf8wBSYmz9U011MxVsG3lulHw/PtQ
         FM4hNPZVt2OXHSYPVkOvZYKrfN/3Gwx0FXX5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773642; x=1702378442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vMrXeU9PccX6SmGwv0uL8uz2m+ssCwq/m3VB0zUtRA=;
        b=AH45UiI2FW5LLXdr/DX/uPepyQReTMK6cDLcvyF6+KEWC+LqiNyVgKC8Q42L/OjyJZ
         /iYD/m8CPiiSUs9WIxcO4ZGWWAO6RifZAE62d+ML83UR51y2IMb9ofVhcUcKFJeAl9ln
         wrw38W3MmKgvGyIjEf2HapEtbsDoiXwlCw09YI/T4XrdBL5IeXRKUb5IMeS7PwcMpF+b
         6GcyhZW7xyYiriGFQNAqvC6+yNxqE0TzcYm2HicCtq8ChJbGnfIR8/qiwvPidvCPx8z0
         5pkkvNrkZmzkqd5nUEYSQctQwi7mqlT5L1U7yB2Nj7aJf30RcxRb1G34mFUQAqbGRyye
         KR/g==
X-Gm-Message-State: AOJu0YzTor/RGOYMGpApIHNrUWVEQNGkt7NMu6KRCjUMoJFpThh28GAr
        P3Hq2JED/+4zj1/Lq2RuwcAxPE3GEdg3aHIhlzBzIg==
X-Google-Smtp-Source: AGHT+IFuMd+CZo1e3WCy0qTpcsuyyZxRhrA2D9Fm6zF+vDpSe64HfbUduReMi+n70WxZd3wbPaRzFQ==
X-Received: by 2002:a17:906:1c2:b0:a1c:795b:405a with SMTP id 2-20020a17090601c200b00a1c795b405amr366504ejj.109.1701773641775;
        Tue, 05 Dec 2023 02:54:01 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906089700b0099297782aa9sm6413491eje.49.2023.12.05.02.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:54:01 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 00/10] Add displays support for bsh-smm-s2/pro boards
Date:   Tue,  5 Dec 2023 11:52:47 +0100
Message-ID: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds drivers for the displays used by bsh-smm-s2/pro boards.
This required applying some patches to the samsung-dsim driver and the
drm_bridge.c module.

Changes in v4:
- Set the reset gpio to low in a single operation
- Remove duplicated code for prepare/unprepare callbacks
- Add 'Reviewed-by; tag of Neil Armstrong

Changes in v3:
- Add 'Reviewed-by' tag of Krzysztof Kozlowski.
- Replace "synaptics,r63353" compatible with "syna,r63353", as
  required by vendor-prefixes.yaml.
- Drop power-supply
- Replace "synaptics,r63353" compatible with "syna,r63353", as
  required by vendor-prefixes.yaml.
- Squash patch [09/11] dt-bindings: ili9805: add compatible string for Tianma TM041XDHG01
  into [07/11] dt-bindings: display: panel: Add Ilitek ili9805 panel controller.

Changes in v2:
- Add $ref to panel-common.yaml
- Drop port, reset-gpios, and backlight
- Set port and backlight ad required
- Replace additionalProperties with unevaluatedProperties
- Adjust the timings of the panel reset
- Add $ref to panel-common.yaml
- Drop port, reset-gpios, and backlight
- Set port and backlight ad required
- Replace additionalProperties with unevaluatedProperties
- Adjust the mipi_dsi node based on the latest patches merged into
  the mainline in the dtsi files it includes.
- Added to the series the following patches:
  - 0001 drm/bridge: Fix bridge disable logic
  - 0002 drm/bridge: Fix a use case in the bridge disable logic
  - 0003 samsung-dsim: enter display mode in the enable() callback
  - 0004 drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting

Dario Binacchi (4):
  drm/bridge: Fix bridge disable logic
  drm/bridge: Fix a use case in the bridge disable logic
  drm: bridge: samsung-dsim: enter display mode in the enable() callback
  drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting

Michael Trimarchi (6):
  dt-bindings: display: panel: Add synaptics r63353 panel controller
  drm/panel: Add Synaptics R63353 panel driver
  dt-bindings: display: panel: Add Ilitek ili9805 panel controller
  drm/panel: Add Ilitek ILI9805 panel driver
  drm/panel: ilitek-ili9805: add support for Tianma TM041XDHG01 panel
  arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup

 .../display/panel/ilitek,ili9805.yaml         |  62 +++
 .../display/panel/synaptics,r63353.yaml       |  61 +++
 MAINTAINERS                                   |  12 +
 .../freescale/imx8mn-bsh-smm-s2-common.dtsi   |   1 +
 .../freescale/imx8mn-bsh-smm-s2-display.dtsi  | 121 ++++++
 drivers/gpu/drm/bridge/samsung-dsim.c         |  14 +-
 drivers/gpu/drm/drm_bridge.c                  |   9 +-
 drivers/gpu/drm/panel/Kconfig                 |  18 +
 drivers/gpu/drm/panel/Makefile                |   2 +
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c  | 406 ++++++++++++++++++
 .../gpu/drm/panel/panel-synaptics-r63353.c    | 363 ++++++++++++++++
 11 files changed, 1062 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9805.c
 create mode 100644 drivers/gpu/drm/panel/panel-synaptics-r63353.c

-- 
2.43.0

