Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1581141B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441819AbjLMOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379372AbjLMOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:04:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB2B124
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:04:48 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1e35c2807fso922061666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702476286; x=1703081086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CxEUP7qYPBcDPYzsksTnnlAXJNNegc2JSrRO3JNlQY4=;
        b=dAqbjjDbnIx7q60K8v+t57rrb4k0S7hEWnXw1YHKdBI6J1VO65YX8QdSB9huAx7itu
         eFDklwUG0UIkNnaJniovDDVuxiRq+8+7XGF6xUeA/aMpqPnHAAeu77/lrer0TXZFigAS
         TJlyqY0zVtSey5hKX0FFFmgHGCkRHMktnYF7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476286; x=1703081086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxEUP7qYPBcDPYzsksTnnlAXJNNegc2JSrRO3JNlQY4=;
        b=mFSWE5AETYx43/zvyvmkDjR8pUscx+cMr8pdRNLYV35aYWJNQuvuCDq21OxrKz1fvI
         OK4J6BKqgUsSxXhflleMZzWgnW5Ierp1lqGoLEWQ9p0keFVu7mtR/fY7cu0NK+L6Vh+l
         mLO95Y0yFmEMWXnLc81dUqQyO67HgEpU0qlIEWC3rsBvS2cqG5yqGbJLALwQBjHXyzq7
         1tdrqqSVL3LIMbQIMhGWD/8nJlj7HMun3tmbEoQL/2wwUL0AKL0/FkmOJFDS0HG2qvQN
         qFUyYNL+z+MhKouO01wPHKTp8QO5mydnPL9KXAHxZOwdUm0rtWnDf7K8ylx0e48rrDIo
         zRJA==
X-Gm-Message-State: AOJu0YwIthdlcFgaB7DRe0NKybUPpNrG3AA8f3FvnfxJd6wypYRvfp6e
        dCaEhnswIldIaGjUb7QAZg0tMlkRV2Y05vyfs2qS9w==
X-Google-Smtp-Source: AGHT+IEhnj9Dk+3Iy7miMJdrLcUIRMNmcjW058SMV2W+UJd5eQMjPJjB0agCJO0xZSSdrYvij6DwUg==
X-Received: by 2002:a17:906:2098:b0:a1c:654a:1c0e with SMTP id 24-20020a170906209800b00a1c654a1c0emr4061606ejq.21.1702476286492;
        Wed, 13 Dec 2023 06:04:46 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-188.pool80182.interbusiness.it. [80.182.13.188])
        by smtp.gmail.com with ESMTPSA id sf22-20020a1709078a9600b00a1ca020cdfasm7797635ejc.161.2023.12.13.06.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:04:46 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
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
Subject: [PATCH v6 0/4] Add displays support for bsh-smm-s2/pro boards
Date:   Wed, 13 Dec 2023 15:03:41 +0100
Message-ID: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
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
This required applying some patches to the samsung-dsim driver.

Changes in v6:
- Drop patches:
  - [06/10] drm/panel: Add Synaptics R63353 panel driver
  - [07/10] dt-bindings: display: panel: Add Ilitek ili9805 panel controller
  - [08/10] drm/panel: Add Ilitek ILI9805 panel driver
  - [09/10] drm/panel: ilitek-ili9805: add support for Tianma TM041XDHG01 panel
  Because applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
  Drop patches:
  - [01/10] drm/bridge: Fix bridge disable logic
  - [02/10] drm/bridge: Fix a use case in the bridge disable logic
  Because they are wrong

Changes in v3:
- Add 'Reviewed-by' tag of Krzysztof Kozlowski.
- Replace "synaptics,r63353" compatible with "syna,r63353", as
  required by vendor-prefixes.yaml.
- Replace "synaptics,r63353" compatible with "syna,r63353", as
  required by vendor-prefixes.yaml.
- Squash patch [09/11] dt-bindings: ili9805: add compatible string for Tianma TM041XDHG01
  into [07/11] dt-bindings: display: panel: Add Ilitek ili9805 panel controller.

Changes in v2:
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

Dario Binacchi (2):
  drm: bridge: samsung-dsim: enter display mode in the enable() callback
  drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting

Michael Trimarchi (2):
  dt-bindings: display: panel: Add synaptics r63353 panel controller
  arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup

 .../display/panel/synaptics,r63353.yaml       |  61 +++++++++
 .../freescale/imx8mn-bsh-smm-s2-common.dtsi   |   1 +
 .../freescale/imx8mn-bsh-smm-s2-display.dtsi  | 121 ++++++++++++++++++
 drivers/gpu/drm/bridge/samsung-dsim.c         |  14 +-
 4 files changed, 194 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi

-- 
2.43.0

