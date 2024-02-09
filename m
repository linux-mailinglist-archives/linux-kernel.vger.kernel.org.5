Return-Path: <linux-kernel+bounces-59512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7375684F838
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA94289B25
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82571B2F;
	Fri,  9 Feb 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W00OKl0h"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5B69958;
	Fri,  9 Feb 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491368; cv=none; b=kph1ocEV9P9QNWLsjZMuZ+fFhnymLGu7LRvDYvDVU95dGXmX5mGfRY6kK2r5qeIRdJthQYDzIm3g2aV4Uc3ig52RxC5dqjJ/IlEjbbyDDTzWfaUtpPHkEqakIk1E8aqe8FsTMkzWkS3wLFk42viZ65TFeBXfdg/gie62h+v7QaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491368; c=relaxed/simple;
	bh=PM51gHeCFEK5iONhCM2ibXVO8eHJ0sHQL+dlsYPqUVM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqjsQaH68Va+4ISuciBNQNbH7JkSjR3RSYsMXS39ZLvNI91H9VxBTWXfXS06n1LCqP3/DJpdaxTrbtX92Rlk6l2tMX9XxOEbJ0yyQRP6fuVk3sxEpKTI9TZcQ/9odp380iKXSPoclR4sLvsDwQcVj+c9rEJH/vrbrEFpEGiLzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W00OKl0h; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707491366; x=1739027366;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PM51gHeCFEK5iONhCM2ibXVO8eHJ0sHQL+dlsYPqUVM=;
  b=W00OKl0hiof77ncQqc2L04np3bJ1h2hjEqvEFIkxJIa//pabSLSeofZ7
   hSNzFcf3G+lCg8h91eBINpkkzcJGKuFpuBlasFXBUhj7SMchRQ+hKi8Gk
   MIaLTutFq8CcgkTjLY1JNzb27jb8CPMEXe+xeoHcLEk3b8a0gADysKu8n
   U5yD1S1v3wU66UxC7ajGroywjxvDcJcA47cwwbrqUHBhvvuRMiM2IjJQA
   eQcT3t0ZHpkOlnoQ2nmDNOCXHqr69yLok4MFUWFgqWNnYF9eBeK/K53h/
   UT3ZOJ/9kjSYuIWKTu8x2iift84fJEr/JJx5rQ3nFK3sLfaWY+YVgdpm3
   A==;
X-CSE-ConnectionGUID: /ftgHdBDRUKkBO7najs1cw==
X-CSE-MsgGUID: bbYucXZHQiexd9EbIAja6g==
X-IronPort-AV: E=Sophos;i="6.05,257,1701154800"; 
   d="scan'208";a="17424564"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 08:09:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 08:09:01 -0700
Received: from che-lt-i70843lx.amer.actel.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 08:08:49 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <manikandan.m@microchip.com>,
	<dharma.b@microchip.com>, <arnd@arndb.de>, <geert+renesas@glider.be>,
	<Jason@zx2c4.com>, <mpe@ellerman.id.au>, <gerg@linux-m68k.org>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <hari.prasathge@microchip.com>,
	<akpm@linux-foundation.org>, <deller@gmx.de>
Subject: [PATCH v4 4/4] ARM: configs: at91: Enable LVDS serializer support
Date: Fri, 9 Feb 2024 20:37:57 +0530
Message-ID: <20240209150757.66914-5-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209150757.66914-1-dharma.b@microchip.com>
References: <20240209150757.66914-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable LVDS serializer support for display pipeline.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Acked-by: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changelog
v3 -> v4
- No Changes.
v2 -> v3
- No Changes.
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 71b5acc78187..6a7714beb099 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -143,6 +143,7 @@ CONFIG_VIDEO_OV2640=m
 CONFIG_VIDEO_OV7740=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
+CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_FB_ATMEL=y
-- 
2.25.1


