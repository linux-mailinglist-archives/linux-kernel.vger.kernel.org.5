Return-Path: <linux-kernel+bounces-16310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF88823CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D139F2883E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6241EB2F;
	Thu,  4 Jan 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SlwhB+be"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FE1EB2B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so256638a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704353053; x=1704957853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUgVC7JEO7GhUBsHaMMn2sIj/0Ni7LYX/30T12HJpq8=;
        b=SlwhB+be1QpO69j6BrhGe7OeGBEbdk3Vii29Ry1ymEEwlIzAk11iWAhu7j5UxlX/Ja
         DE9imVo0Y3z4DrCIitAZ2n2y3pRmuKE/Gfzns0KOGUInjtPmr8MfDI556DBksb6FITRf
         a0oRITGn3QBeh0Z8zbvWE2VBvWapImXYCQO2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704353053; x=1704957853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUgVC7JEO7GhUBsHaMMn2sIj/0Ni7LYX/30T12HJpq8=;
        b=NEVRQS6/jAxauUbSLxJ4yy12ykXHclqZfeHlk6Q5CBPtSIl5DcKK4CM5uNb2MnANbu
         iR4uSZ2CaEyP/mH/eZf3qLUM2wPjhrsgecnngIDJUeaEkAvNteYoNfxJz4xaWASySAVc
         c+ak1qpmmBZaybyF9Gi+seMRQ4Utj3t02YMAAjsYa2V+yuyV7QdhmejXS3MasK3L/2gJ
         Wwq4a8quwHTCKAPascxrh/mzzL9jxT8Lv038sXjVObbDY9ODYknIr+SNvXs1JBfCnWd+
         jAeO0MDsg8ZEy1baGVTmjroCEdagO5BJxspQ/MpIsytzUNwCU5tWFHz4/gNV9OYHaKq1
         qeug==
X-Gm-Message-State: AOJu0YylqZm0glLXqcE07UiZuv9a2AKjmPJIM3LbmtoI+fDHUnUUsHkA
	Wi/ER7CETwzDYbLlXQWNLEiK0zFgle2lDIMLtsPbmcuAgCI=
X-Google-Smtp-Source: AGHT+IGmDyP/2rCvEVge4MJPNpo2+Gj+UXFPX8MUKMMpso0SylDp5k3+gnunyyZSiIr2eHvZUnp0ZQ==
X-Received: by 2002:a50:8e49:0:b0:553:ad79:b7d7 with SMTP id 9-20020a508e49000000b00553ad79b7d7mr54053edx.93.1704353052879;
        Wed, 03 Jan 2024 23:24:12 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (net-93-150-255-34.cust.vodafonedsl.it. [93.150.255.34])
        by smtp.gmail.com with ESMTPSA id d3-20020a056402000300b00553772c2968sm18530735edu.82.2024.01.03.23.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 23:24:12 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sean Nyekjaer <sean@geanix.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 0/8] Add display support for stm32f769-disco board
Date: Thu,  4 Jan 2024 08:23:36 +0100
Message-ID: <20240104072407.41290-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series adds display support for the stm32f769-disco board. It has been
tested on hardware revisions MB1225-B03 and MB1166-A09. This required
modifications to the nt35510 driver. As I do not have the Hydis HVA40WV1
display, it would be better if someone tested the driver in that
configuration.

Changes in v3:
- Use "enum" to have less code changed

Changes in v2:
- Add Acked-by tag of Conor Dooley
- Add a dash in front of each "items:"
- Change the status of panel_backlight node to "disabled"
- Delete backlight property from panel0 node.
- Re-write the patch [7/8] "drm/panel: nt35510: refactor panel initialization"
  in the same style as the original driver in order to maintain the same
  structure.
- Re-write the patch [8/8] "drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK"
  in the same style as the original driver.

Dario Binacchi (8):
  dt-bindings: mfd: stm32f7: Add binding definition for DSI
  ARM: dts: stm32: add DSI support on stm32f769
  ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
  ARM: dts: stm32: add display support on stm32f769-disco
  dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
  ARM: dts: add stm32f769-disco-mb1225-revb03-mb1166-reva09
  drm/panel: nt35510: move hardwired parameters to configuration
  drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK

 .../display/panel/novatek,nt35510.yaml        |   4 +-
 arch/arm/boot/dts/st/Makefile                 |   1 +
 ...f769-disco-mb1225-revb03-mb1166-reva09.dts |  18 +
 arch/arm/boot/dts/st/stm32f769-disco.dts      |  78 +++-
 arch/arm/boot/dts/st/stm32f769.dtsi           |  21 +
 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 422 +++++++++++++++---
 include/dt-bindings/mfd/stm32f7-rcc.h         |   1 +
 7 files changed, 484 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
 create mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi

-- 
2.43.0


