Return-Path: <linux-kernel+bounces-23489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B582AD7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D4BB21BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2A15493;
	Thu, 11 Jan 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I/PzYTXV"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9B156C4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26f73732c5so613045666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704972709; x=1705577509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3RgnmjR61D7s9CNo+AYUolzQugH4TGJWl8/1Xh6+YQ=;
        b=I/PzYTXV824h46TOAs1rTYL3l9g6jmCRHboOje5P8vwjpKvlb1jG+Yiom9pDpT4oMx
         9zr49rMuT9+GJLgV+vY8pCL1Qwwq7CYlWdSVVs6t3qBEpumbkALJodpm+IpdhoSnwIPj
         TimFx+gmVhYVEQBUdziIxSv3zz7uuO/IWIOds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704972709; x=1705577509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3RgnmjR61D7s9CNo+AYUolzQugH4TGJWl8/1Xh6+YQ=;
        b=RKmtCnhoBRyIm3wfkFIaFayronPQaL4q8pEfcQRV9UJuXUARybr5HqrOPex4fy4Kmc
         oZv0uN+AobUI0ieiLNwdbTx8YMpb1RXGPlEHVTLILolA+3KN8wgM2hVDqPcOTWn9Gxum
         BJlUaC93Y+PXladCqjANqRz8hi6ab5MS1ER6X6gQ4klrkzazujswq0R5JnSbwlo6J+3J
         h7yDoILME6Cui3NtBPENfWyo0JJA2bcQJ7egfkP/WiQxVJs1u4tz4nBBoj1pt3/ChXwI
         aeK7n5NnodEpYJgRp1Bs//6tXOGcXN/0qrqd6akgSBFpAHjkkmgpUPlwCEcgVmAu1qNG
         vaNA==
X-Gm-Message-State: AOJu0YxJbxRdQ6N/uL0CjVL3/Q/jV163+5cvkVxCpYnJBD3bqkFDO/lz
	9vsAySr6JJnCQHAJAm9NL3aox8w7L6aUbG1nFb20mwnN6hM=
X-Google-Smtp-Source: AGHT+IGZ6q2rR+1ieqVBtWSdEMPS5oa96gFPgtNJnNkI/8J4MxZtb83opPPSS+JHqHoOpJzHU8MufA==
X-Received: by 2002:a17:907:9712:b0:a26:b524:226a with SMTP id jg18-20020a170907971200b00a26b524226amr652836ejc.40.1704972708978;
        Thu, 11 Jan 2024 03:31:48 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it ([95.236.91.90])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906688300b00a26aa734349sm461565ejr.39.2024.01.11.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:31:48 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-amarula@amarulasolutions.com,
	Lee Jones <lee@kernel.org>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v7 0/5] Add display support for stm32f769-disco board
Date: Thu, 11 Jan 2024 12:31:37 +0100
Message-ID: <20240111113146.16011-1-dario.binacchi@amarulasolutions.com>
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
modifications to the nt35510 driver that have already been applied.

Changes in v7:
- Replace .dts with .dtb in the Makefile

Changes in v6:
- Drop patches
  - [5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
  - [7/8] drm/panel: nt35510: move hardwired parameters to configuration
  - [8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
  because applied by the maintainer Linus Walleij

Changes in v5:
- Replace GPIOD_ASIS with GPIOD_OUT_HIGH in the call to devm_gpiod_get_optional().

Changes in v2:
- Add Acked-by tag of Conor Dooley
- Change the status of panel_backlight node to "disabled"
- Delete backlight property from panel0 node.
- Re-write the patch [8/8] "drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK"
  in the same style as the original driver.

Dario Binacchi (5):
  dt-bindings: mfd: stm32f7: Add binding definition for DSI
  ARM: dts: stm32: add DSI support on stm32f769
  ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
  ARM: dts: stm32: add display support on stm32f769-disco
  ARM: dts: add stm32f769-disco-mb1225-revb03-mb1166-reva09

 arch/arm/boot/dts/st/Makefile                 |  1 +
 ...f769-disco-mb1225-revb03-mb1166-reva09.dts | 18 +++++
 arch/arm/boot/dts/st/stm32f769-disco.dts      | 78 ++++++++++++++++++-
 arch/arm/boot/dts/st/stm32f769.dtsi           | 21 +++++
 include/dt-bindings/mfd/stm32f7-rcc.h         |  1 +
 5 files changed, 115 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
 create mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi

-- 
2.43.0


