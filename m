Return-Path: <linux-kernel+bounces-32518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D45835C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082851F22CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D321357;
	Mon, 22 Jan 2024 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JHmvf14f"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E7210E4;
	Mon, 22 Jan 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912209; cv=none; b=XjO41CVur6QfbjQJJRXDDGqaHRhMJ524lIiG+hzqGAz6FL2Hf7sgHeZzJI87F0obhH07AVNFSpuylWwUUwmECZpZwsZUCoDb6nQzGi94RpPwGNThfg7ajYSWDfkxoXGZ8ncdJE4dhCR9cKx5oMYnJC7dRzgRY0TP8mHJu+G9VEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912209; c=relaxed/simple;
	bh=A6Z1p3lKL8ECmJxJR7QxwWwSIZ/W6jb5X4+kBV5gOKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B2FgSomfd2l7cZ4wvMLl1oLXjJPzXQE5Q1swXeLTNfsaD3HKSMF31PHB2Stfu029L0KydXFL80qnq/Sjf/p/c50fOxiG2kL2vMHZ+ybxHu1VKWJQUUph2QdQjPcV87MWYWL+QGXogvdebGG+86T8jCQktHL9y7MsYSgE908tJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JHmvf14f; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705912208; x=1737448208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A6Z1p3lKL8ECmJxJR7QxwWwSIZ/W6jb5X4+kBV5gOKU=;
  b=JHmvf14fUZEpXp7wCiYIknfWPwi8jS23mTMHP9zD99nQe21YPlZzARng
   aJ5bCOvPamxULg33mJGxIhThAaJR1C66ZRm7swdh7i0muoFzXNN+Z9wSB
   WlZknm1IcSSnvXpPFPm/B76En6HQCby0Ii2cNw31KkwK4VfVgm7QbGd+i
   hfwz7hdfiZumqM6OL0RPbK6BMOV5oR0oH0JM5z/zHSMVS/EsB4FT+AB05
   CaLs/LQb5pTkVGUumoQHZ5rgfZXjf7DJzJRx82BEWhIv3uuYIeu/6J0Az
   iJVhAzwY38nW2gKKneX5xaw6rJxbLMOdTpsvl4nOffpcEV2YHqPIfB9+n
   A==;
X-CSE-ConnectionGUID: IjoLBs+VScKotNOuD0Q1rQ==
X-CSE-MsgGUID: H3WbuieAQiSXKUEYhVfTTQ==
X-IronPort-AV: E=Sophos;i="6.05,211,1701154800"; 
   d="scan'208";a="245805640"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 01:30:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 01:29:57 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 01:29:50 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <manikandan.m@microchip.com>, <dharma.b@microchip.com>,
	<andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux4microchip@microchip.com>
Subject: [PATCH 0/3] LVDS Controller Support for SAM9X7 SoC
Date: Mon, 22 Jan 2024 13:59:44 +0530
Message-ID: <20240122082947.21645-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series introduces LVDS controller support for the SAM9X7 SoC. The
LVDS controller is designed to work with Microchip's sam9x7 series
System-on-Chip (SoC) devices, providing Low Voltage Differential Signaling
capabilities.

Dharma Balasubiramani (3):
  dt-bindings: display: bridge: add sam9x7-lvds compatible
  drm/bridge: add lvds controller support for sam9x7
  MAINTAINERS: add SAM9X7 SoC's LVDS controller

 .../display/bridge/microchip,sam9x7-lvds.yaml |  59 +++++
 MAINTAINERS                                   |   8 +
 drivers/gpu/drm/bridge/Kconfig                |   7 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/microchip-lvds.c       | 250 ++++++++++++++++++
 5 files changed, 325 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
 create mode 100644 drivers/gpu/drm/bridge/microchip-lvds.c

-- 
2.25.1


