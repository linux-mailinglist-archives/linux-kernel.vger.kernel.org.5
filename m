Return-Path: <linux-kernel+bounces-51190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61F0848788
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1D91F21A86
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510935F864;
	Sat,  3 Feb 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSUl0m++"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026435F557;
	Sat,  3 Feb 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979210; cv=none; b=kUK37viStk+NF84LmTIEfkyCP6qnd8fgM7fiN7YBRjowd2F9cIBxysAm7wf3DC83e1T4jMlm7RQgQIuUMGpH+IGMT/G1zAvo/9jLQbyA7Z+XhLb0qA9vyqAwFBOfexdAyQ1PTLO1EM/xnJc/sISJ65ifF6JxacLBXWRKAnecfJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979210; c=relaxed/simple;
	bh=BKBT3unrLVl3CNkXYfPnfYgbHcVesr7BHjyeV0j3qr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxzNVqtYyMknj1z00x+FkZdGqVxm6viLVqVHrXKu1k7s5BA0Iqv7BnMFKWEXe16FTs70BlfmKMv32N3vDbbN/hcZ4qpu+m4HLAb3OSG9NwTEE+fMBXPxLmIVjKbqTbxHpS+P0G7e8hew+pZ8YfGHuSYLELPu7O6KBR3AuyV2Eug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSUl0m++; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-363b2736544so5017205ab.1;
        Sat, 03 Feb 2024 08:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979208; x=1707584008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XUHyzhcEBPgUyedjboVKpnmtxonPsD2U3arujSm0XE=;
        b=XSUl0m++Ry2JxVhds/efj+tLnJA14Of0uMF6H2OZymAYh1CnBNBz/h9iphLIduGCCH
         udpoXMTBZthOAoQ/ZGQ3HMMr6dwzEew7sJ8TWUPKZKOcD2jnAI8uW1AZNSm4jNfyET7B
         VzvDpozXXiViLcj32cIVdGtVZGDhKK0KyvrLq6+25VFZ4bQF/JREg4ic42MKOZ6G78N0
         /xkxjbVfd0gh3xFL+XFY9vSh5tJro2KT+6znOrg52xV3TYqgmIZq5Jgm5TUrXqSv2y6u
         bXeTmmIb+/kjPeMSss7lgXnOxMvvaoTNLNEhBJl1x0rWJeAMXeRJhmgi0TjUFmSENvBM
         jbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979208; x=1707584008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XUHyzhcEBPgUyedjboVKpnmtxonPsD2U3arujSm0XE=;
        b=FysEn+NmQjZ2DbnThFZtz8c0SgaNoJnsNTe2sLMiK6X4OVHx22eWrEZQSD5zll/U7l
         UQ4lrLZLoZ/UNf2+PCG1gk+9jkaYJbWKF635p2f6axl//nE72fU7kNy8x/XK3ZqaLT30
         WmqwIfAy7wLNArQ1Z6gi9vaG1Uaphxuz/TRZk+0KsdiDD1OsVzBz8WzUNHEMzvW0UM0E
         B93+rsVegAH1+WrYqTxnwMt2HkL+TO3n3jwPPZs4nlmOnaSZveNCz+nu/huJ3prJD9Xi
         zuji0x4PIB7JwuM8nDDjSXXmGjrLmbMguSRuCbuQvhklNQRdtD33ZmrsNSabrbXt5E14
         Sfsw==
X-Gm-Message-State: AOJu0YzJo7HoFi8wppjX3d5PT4EjQJKxO6CzzJhlVqniaqVG+QvsmlEw
	5Fkd0Ng8SJyErb+oE+8Bt3g89RakZeOZA1v1PGY0G1IEqjq1QrPH
X-Google-Smtp-Source: AGHT+IE2O1m7e/uXI5S9VSQpXsL+ogbmDdnqGeGTYadDkakIFJIrovcZVLpYBZWHH6ddMnEbqEyskg==
X-Received: by 2002:a92:ca8b:0:b0:363:b519:bfff with SMTP id t11-20020a92ca8b000000b00363b519bfffmr4848229ilo.20.1706979207672;
        Sat, 03 Feb 2024 08:53:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlcAHP1/xgDZnzgAuxHawH0NO6OJv8LhA66jcuqOf8c119mXkLUKYWDtiOCS2AZwWIXGNwJPx2OSyc962OYpHMWB29LqSIPLemncVT+De+t2R5vwLk0Ox1ThXvmlcTrwG5l+yG/3FgqJ6ZR3Nb0/FHtACItUzww3mV48EsnaeFc3b0QtPQfhEbNCs6TikO5IYzhpy0WSSfcMdCHz9fmzOmiL2coidv0mEK1AeSdlUm37QWp0Eikgx3TGavTmp7tfRAmAIN+geK8cjdEgL2O45joCJ88cQ5rXgEVJoQvY4fdiDvWiZpgEcG1LEqHPvGXz9RDyAlk7hiF/f2ZLwfWsaN6ARWS8+P5zErDJdHgFV0BnqjLjwsdS88j2xHF9tMLUa09ejKB7eRXht522VBUjOSqE+SH7A8FPHUk9m7VWWnW8ryXdp8S98lS2AUU5QPwpaLSzQywEnkRU6pJB7l11YiaA/FkMif7aebXQw7uAMl1BtlUnlgRpXhj4XNN6lhHHnNhyeJiL5cri1UEZMSjQJGl/h1FV05EWG1vPd4YqbtYVCgZyoKKDI31DpTeIxJ/vmROP9VRRALy05tS2Rw4KzmkvQEGG1Gciiq9/hYMyPkEvtz2f656fMzRsuy5aotI2tBk+o28PB22og6DVWxIZYgABsFlrldN5YNAg/yUiOKC4wLCiOQXFpKZCr/7bxSjukRSFy1qOKEBq0r3rz49VXX71n0CRCCDw334e9Kyf7BB5Mu736LlNJPYRYf3n05YZwTkge2RWvD2Di8p1nUtWsEX+nJb9RALNdbkIvp74VzECdd8XPkeEI5Rtig0OxGVSc9UKv4uvuYy4uE28iXe9WY4tHR8yIgD0h2LaH7/po/5bMjg1WsOBjuOVqlYY8wJQHQ7rDGOKGQs8+ED0MXhKeM3FYNNIqiHX7gj9D0gN9WJwAlGK5IX3SFMMWrtg5SMEjCUL
 hINOWO+Abubuq8a3n+enTDcH5zkNg6x+SQZaD2l3Wet2UK0QNm1RrPrf9lR7uUE5qUoibecwltghAvu9iRNB+vZ/xRyoLiOv5qsQcGl+cMWz5evixLeXyOY5FoAW8hTkK70zWankAhXpZDKHBf1rXv+4nPhglYSoOmv5iMdJTVo4KYP+orfjsmFSdYCJTskFIVoEyZjyGHY0N6DuLdIE/tuKaVyAiBhw==
Received: from aford-System-Version.lan ([2601:447:d002:5be:d9b2:bb4f:5531:6aa9])
        by smtp.gmail.com with ESMTPSA id t30-20020a05663836de00b00470b29b82b1sm1086256jau.154.2024.02.03.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:53:23 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	alexander.stein@ew.tq-group.com,
	frieder.schrempf@kontron.de,
	Adam Ford <aford173@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V8 00/12] soc: imx8mp: Add support for HDMI
Date: Sat,  3 Feb 2024 10:52:40 -0600
Message-ID: <20240203165307.7806-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8M Plus has an HDMI controller, but it depends on two
other systems, the Parallel Video Interface (PVI) and the
HDMI PHY from Samsung. The LCDIF controller generates the display
and routes it to the PVI which converts passes the parallel video
to the HDMI bridge.  The HDMI system has a corresponding power
domain controller whose driver was partially written, but the
device tree for it was never applied, so some changes to the
power domain should be harmless because they've not really been
used yet.

This series is adapted from multiple series from Lucas Stach with
edits and suggestions from feedback from various series, but it
since it's difficult to use and test them independently,
I merged them into on unified series.  The version history is a
bit ambiguous since different components were submitted at different
times and had different amount of retries.  In an effort to merge them
I used the highest version attempt.

Adam Ford (3):
  dt-bindings: soc: imx: add missing clock and power-domains to
    imx8mp-hdmi-blk-ctrl
  pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix
    domain
  arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module

Lucas Stach (9):
  dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
  phy: freescale: add Samsung HDMI PHY
  arm64: dts: imx8mp: add HDMI power-domains
  arm64: dts: imx8mp: add HDMI irqsteer
  dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
  drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
  dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
  drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI
  arm64: dts: imx8mp: add HDMI display pipeline

 .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  102 ++
 .../display/imx/fsl,imx8mp-hdmi-pvi.yaml      |   84 ++
 .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |   62 +
 .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |   22 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  145 +++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/gpu/drm/bridge/imx/Kconfig            |   18 +
 drivers/gpu/drm/bridge/imx/Makefile           |    2 +
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  207 ++++
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  154 +++
 drivers/phy/freescale/Kconfig                 |    6 +
 drivers/phy/freescale/Makefile                |    1 +
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 1075 +++++++++++++++++
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c        |   10 +-
 14 files changed, 1876 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
 create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
 create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
 create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c

-- 
2.43.0


