Return-Path: <linux-kernel+bounces-3181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B02816879
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8739D1F21773
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF07410959;
	Mon, 18 Dec 2023 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GoJcuhc4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE910941
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a235eb41251so46318266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702889041; x=1703493841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uwBMo6h6CLFvzeF8BNuqk3mwyXmRoxEOvbk3nd1BFNQ=;
        b=GoJcuhc4btKeVMd2F6jUBxOF20xGAr9Ur37mgGQ5/+5nk4y3pyt/IpjwrAoladhmT7
         oK9m+vbdln8Q/9ZEAn7phHq+qg6Dbw5uRgS9VVWgqtm0ejwmcJdrVWpmQw/dUTCAa5Ua
         0Lpd6wW5Ww9KztU+HCtphHiZ8iny0Y6hFA2Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702889041; x=1703493841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwBMo6h6CLFvzeF8BNuqk3mwyXmRoxEOvbk3nd1BFNQ=;
        b=aaej808zMwsuRo5Px9LPpwP2MWh1JC+q5vgWTw0/08DBQRWZepKAXeF4gLoCSvZReP
         IiILVOKmqNCKhwRqCwV2odDHf+ogsvLcixJq2jhlwXDfVj4mEF5TlemAHQ6Xia00BVYD
         hB7lZrtQUsA8j9YPNOcgsGXxFMCc72UPeyRXnJdRuN0PghIFiPvRZeS4oBEqPNRHyAvK
         cGdAJU6csrFKbi+qbKHWjc5CjrQUoROm4N1htDQTxYSeMYJoWuS4mCeD//jcWKC7XUAe
         ufgrtksQP57ytY5J+CsIMzAa9kstDLRxzQP1mxRuusWKiDECEFpcF824sEMHJ2DdTIyN
         ZpoA==
X-Gm-Message-State: AOJu0YzPs5I0+wFpyMdGOlGKtteTzznV+rzi8VIYWWDoRdrK1K/Bc+z9
	gES8I8UhOz7siMvMgMgHXejYYIPvf+46dIW0dgTJ0w==
X-Google-Smtp-Source: AGHT+IEm7GShvAvUVER372jEsNFgBOui/TD2GxKgfn1iLVvV9s2Ggpc1aSVL5uNloELUBBA8G0Q2fA==
X-Received: by 2002:a17:906:20d3:b0:a23:4472:57e7 with SMTP id c19-20020a17090620d300b00a23447257e7mr553006ejc.174.1702889041657;
        Mon, 18 Dec 2023 00:44:01 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-188.retail.telecomitalia.it. [80.182.13.188])
        by smtp.gmail.com with ESMTPSA id un5-20020a170907cb8500b009ff77c2e1dasm13775480ejc.167.2023.12.18.00.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:44:01 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: michael@amarulasolutions.com,
	Amarula patchwork <linux-amarula@amarulasolutions.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v9 0/2] Add displays support for bsh-smm-s2/pro boards
Date: Mon, 18 Dec 2023 09:43:36 +0100
Message-ID: <20231218084354.508942-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The series adds drivers for the displays used by bsh-smm-s2/pro boards.
This required applying some patches to the samsung-dsim driver and the
drm_bridge.c module.

Changes in v9:
- Updated commit message
- Drop [3/3] arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
  because applied.

Changes in v8:
- Move the 'status' property to the end of the list of nodes:
  - pwm1
  - lcdif
  - mipi_dsi
- Add a newline between properties and child node (mipi_dsi_out).
- Sort the iomuxc node alphabetically
- Rename pwm1grp to blgrp

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

 drivers/gpu/drm/bridge/samsung-dsim.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0


