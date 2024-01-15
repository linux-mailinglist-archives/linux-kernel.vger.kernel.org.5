Return-Path: <linux-kernel+bounces-25892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3AD82D774
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFBE1C21866
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9CF2BB03;
	Mon, 15 Jan 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cPlnzwHF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135342BAF9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e779f0273so7779255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1705314861; x=1705919661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3SJqDr5KvSGyh2V1znLlQnEJgiCqsoWDRe3D5i0IsMQ=;
        b=cPlnzwHF9mWBc+qKVB/BvD3Y38xwXCxEBDRdF1xqAVWjqwnd8951c7suSQg264wIRq
         TdPE2n0w5eT9hKhcZJwr83EGCUfR+UA3VM8x2iRfXfroMNJp8Y16+3s2GR97Jj8TJoF4
         8B2o5OeW1BreP3giKDTKTOX0Hw19dvff8kJ2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314861; x=1705919661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SJqDr5KvSGyh2V1znLlQnEJgiCqsoWDRe3D5i0IsMQ=;
        b=JO/nmY3i+VsHCBCpLBpjgISN1TUX3TpxXrcn7l/pVFrZ2Pr7FbUHl9QGWqOxjX4T55
         eaJM9mDC6d5kNyiuq8sLOOMq1Ca+7si+KrVvP71RJVFS7muDyzJVEGHvaUIDmuIEJFPc
         qWmgQMbtYePMIioYdc4BsTkQ3kY8IDYy1dzusV/chHkH5rrmabaLUsVNps2Hp93qii7z
         LdRtf5ozAKMAI2owYS2szIuItOe3VvHbSM3jYrZPvKnoT3DxynmX1gA52cnUD+sxaF3V
         NSXrqbghraBRb4OYi6RPfA1WsH+s8UD1/0W0t11h08oJvOXw3m0HzH4zlkPR9HhW+v5t
         cX+A==
X-Gm-Message-State: AOJu0Yxly81hA1VMgzeGreClcob4sn+veWF1HtIWuikSDGm7SUZ8FmGZ
	KGUK5sn/agWlI9ZhlwvoY3HBs2K/yGEyIbzIc7Co9joLL8E=
X-Google-Smtp-Source: AGHT+IEPp+cjxMkNUhf7IxEn4EJ35Sc/ijO1hlsPRawgLTBX2AkEeCZqx6+bsD5VZgysYrbeBpq2iQ==
X-Received: by 2002:a05:600c:1c91:b0:40e:4913:58b5 with SMTP id k17-20020a05600c1c9100b0040e491358b5mr2981492wms.174.1705314860956;
        Mon, 15 Jan 2024 02:34:20 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (mob-5-90-63-69.net.vodafone.it. [5.90.63.69])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b0040e50d82af5sm15536120wms.32.2024.01.15.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:34:20 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Amarula patchwork <linux-amarula@amarulasolutions.com>,
	michael@amarulasolutions.com,
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
Subject: [RESEND PATCH v9 0/2] Add displays support for bsh-smm-s2/pro boards
Date: Mon, 15 Jan 2024 11:33:46 +0100
Message-ID: <20240115103416.978481-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series adds drivers for the displays used by bsh-smm-s2/pro boards.
The patches for the ili9805 and r63353 LCD panels, which have already
been merged into the mainline, do not work without the patch [1/2] "drm:
bridge: samsung-dsim: enter display mode in the enable() callback".

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


