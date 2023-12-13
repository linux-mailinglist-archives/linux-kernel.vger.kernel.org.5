Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB05F811CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjLMShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjLMShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:37:41 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D581D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:37:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1f8a1e9637so855989466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702492666; x=1703097466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5uPvnip3JZl3WuLxh7oPl48PoCiV1C8MB4jla1EX1AI=;
        b=ebjd3sbd0WSuyaLvveJp+g9UrOUMNRaQyqu+fWfIeY3o0a4JbMP3t8XmKWq6F3a3en
         /QP70L0FcdvNKFKTPUK/x395l9Ka4ze0RByPnCCPPLrlQ3BCF7+rzNtCzhnHeakTToBh
         5xKFKZImmhi1yGdqRlPDNGRvjL4Jc9HuCW6Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492666; x=1703097466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uPvnip3JZl3WuLxh7oPl48PoCiV1C8MB4jla1EX1AI=;
        b=CrJaIoudev9GkBsYqsne7Do5FFFLFIGes4F0h4+rkCnplKJNb3WzW7mJ6jmhsWoTyc
         oqSTzS4IW+WdoUkVZac2N8HzMFiIic5RbUCbUwIF68EEtNW3b07Z9mkEl6aQvOsAg7JO
         1/8ymlwnoxlZMRAG3uKQr1qsm7MLP65grPYznG3mVZs26dQVkmLWscARPLumr3QKKJiz
         yWakCbjB75vAXfoQnuGmyUxhK0FEFIrr2ecLiXMqQ4YNoVQl/plLOurfIYdaJ8aenmQR
         t9/4mkFtcTYGN/nFRj2jhpwS3TrxSGxu8TeJKSRyozKqFkmAxMQIHoZNN/OPHzFDzTWT
         mPxQ==
X-Gm-Message-State: AOJu0Yzlm6WNUG8suMfSHeiEb52PlQZ2TDKmOiEdtMnd0bixeUS2PivM
        L/NQHaiAPJaYy500RE986Kk3VwPlPOTRHK/sdTSbyg==
X-Google-Smtp-Source: AGHT+IG/hyoLETOAVHjV1Ok+F8yZIUMpufAfkY6VEitAgTFuCSHGyyOipTjBtJEzwoS0SyvpMmOZ1A==
X-Received: by 2002:a17:907:e86:b0:a1d:6cbc:c22 with SMTP id ho6-20020a1709070e8600b00a1d6cbc0c22mr10546877ejc.41.1702492665706;
        Wed, 13 Dec 2023 10:37:45 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-188.pool80182.interbusiness.it. [80.182.13.188])
        by smtp.gmail.com with ESMTPSA id rd12-20020a170907a28c00b00a11b2677acbsm8152775ejc.163.2023.12.13.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:37:45 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 0/3] Add displays support for bsh-smm-s2/pro boards
Date:   Wed, 13 Dec 2023 19:37:09 +0100
Message-ID: <20231213183737.4182996-1-dario.binacchi@amarulasolutions.com>
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

Changes in v7:
- Drop [3/4] dt-bindings: display: panel: Add synaptics r63353 panel controller
  because applied.

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
- Replace "synaptics,r63353" compatible with "syna,r63353", as
  required by vendor-prefixes.yaml.
- Squash patch [09/11] dt-bindings: ili9805: add compatible string for Tianma TM041XDHG01
  into [07/11] dt-bindings: display: panel: Add Ilitek ili9805 panel controller.

Changes in v2:
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

Michael Trimarchi (1):
  arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup

 .../freescale/imx8mn-bsh-smm-s2-common.dtsi   |   1 +
 .../freescale/imx8mn-bsh-smm-s2-display.dtsi  | 121 ++++++++++++++++++
 drivers/gpu/drm/bridge/samsung-dsim.c         |  14 +-
 3 files changed, 133 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi

-- 
2.43.0

