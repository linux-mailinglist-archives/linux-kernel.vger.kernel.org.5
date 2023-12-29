Return-Path: <linux-kernel+bounces-13105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BE281FFCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0EA1F21C58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4511725;
	Fri, 29 Dec 2023 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YfRat/G+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0511711
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5553f768149so2976049a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703857939; x=1704462739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MzUGxEaP1+NpXvTfTtwZMhBYJcrSPGpvA0YzGDUtLvw=;
        b=YfRat/G+Xb3qIIWF3iN1mD9s71TDDgdXRa3233i0HkM/tmLis8qtkN2uZaIJy7j0n1
         U15tW/0B77suU6AmVHVIUt4MGo5Ft1j5iTYR5ZqHVYt7FCUezLy7hAgxADDdc+tY3xkS
         CGLOXd0ohFUV2evzANUBSJkWJlN0uD+SYbJMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703857939; x=1704462739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzUGxEaP1+NpXvTfTtwZMhBYJcrSPGpvA0YzGDUtLvw=;
        b=aI8zwsdaGHMa2VWMc8iTUBalZ8sRXi+xPDDPYn6zHOxVcatSY5rMvyG6CFRE1EiXxY
         +Itrrc6vtgAuKqK/cutsc6fZynkqZXZX7w63d30FMHk+Km4mNceQ969hw0N2ipQeG8zb
         cusp1e20zVUKejDCYG5RN0vBOPuMCuwryhpnr2F2A8dE6yeuhKpnmyYMvH4OC7na4gkl
         SWA8MS7chjEJC3IP5vhbBMlM3DFvzNLj1b5RhyeTgmU5uigSaq27Ox1YMFGzir8PCTHG
         gYawe56LYFjFL1905hrfvYknYg8A/0un6nHr4LgmOu6XO6PSDivbV5UZ/xethQ8gCgCL
         ypuA==
X-Gm-Message-State: AOJu0Yzhp2uoUQiCwca0LnMncWGHfsZLjNaiaW830rNG4agWulLeZyAT
	yy3epOCHc3Hq4te+BcfTwICc7am/f0S+TjNoK6JyY8Z4mPI=
X-Google-Smtp-Source: AGHT+IGKAnJQHr73ga51Hv9Dt4zjqRc48HnDDCm3n7scTC1Qqv8aUw24GfpouEj3L2DFYiFoIwwAnw==
X-Received: by 2002:a50:cd97:0:b0:554:5192:5bdf with SMTP id p23-20020a50cd97000000b0055451925bdfmr6826417edi.43.1703857939105;
        Fri, 29 Dec 2023 05:52:19 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-49-57-70.retail.telecomitalia.it. [79.49.57.70])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c710000000b00553b243b1a8sm11019160edq.92.2023.12.29.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:52:18 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sean Nyekjaer <sean@geanix.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tony Lindgren <tony@atomide.com>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/8] Add display support for stm32f769-disco board
Date: Fri, 29 Dec 2023 14:51:15 +0100
Message-ID: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
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


Dario Binacchi (8):
  dt-bindings: mfd: stm32f7: Add binding definition for DSI
  ARM: dts: stm32: add DSI support on stm32f769
  ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
  ARM: dts: stm32: add display support on stm32f769-disco
  dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
  ARM: dts: add stm32f769-disco-mb1225-revb03-mb1166-reva09
  drm/panel: nt35510: refactor panel initialization
  drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK

 .../display/panel/novatek,nt35510.yaml        |  20 +-
 arch/arm/boot/dts/st/Makefile                 |   1 +
 ...f769-disco-mb1225-revb03-mb1166-reva09.dts |  13 +
 arch/arm/boot/dts/st/stm32f769-disco.dts      |  78 +-
 arch/arm/boot/dts/st/stm32f769.dtsi           |  21 +
 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 872 +++++-------------
 include/dt-bindings/mfd/stm32f7-rcc.h         |   1 +
 7 files changed, 362 insertions(+), 644 deletions(-)
 create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
 create mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi

-- 
2.43.0


