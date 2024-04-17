Return-Path: <linux-kernel+bounces-147862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140E8A7AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93B41F22232
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266197482;
	Wed, 17 Apr 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q+C5sCj2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4AE566A;
	Wed, 17 Apr 2024 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321785; cv=none; b=oGgyxlBVyAk/jr3wRBrnGSGtQv7vA8TwY3u6Akksltgcoep5Aio6j1ztFrpBwZphB5m8z7kxXjNqAiL4hzOMk7vNPBDbw/bQYK7VyAlrriA9a6cjdnuObXY9TwIWpZ4zS0mX9V4lXilnGb9PHvsZn4PTS/1+lL4otqdohNBh+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321785; c=relaxed/simple;
	bh=po9zb6Qn/5fT2i3jnTl0DLe9EyYWr9PtZv3ZiG+LgXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXUfC+hw0qspf6LYHth/KLepFwVHHxSQnq2Yhh1+Ju5rymph8lspCPKR5S7Vx9NFsV6LeMSageyOkpacsrnTAf9EXloVhE0ZGqcQR6ZyNHEr9AA/84ooV52H9S+7AYiKCu8p8JNHHglN9bJi0yMjyfxLX4nQGxJOp05i1AoIQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q+C5sCj2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713321784; x=1744857784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=po9zb6Qn/5fT2i3jnTl0DLe9EyYWr9PtZv3ZiG+LgXk=;
  b=q+C5sCj2hOl5nuwL9BCHVSiOPDbhM6BKvGoFWjhVqtwyeHArhSUATzFY
   4NPmlDyihGveSlMn73DihzUHlMA2mruqpLWNOhPSBWQAbq9p2M619Y03W
   9baGTHTUEkIkIkeDQkRL2vPjHhwZbc3W0/1cZ8/jZiR8VranWKp1TpOqW
   WyrxVwyynSbSqaakrOI7lpqKghemUyF8hWjfX18AEjZTYGu/A37krHEMP
   3dosrq/eMu+/S+L53EVP+fkqg5B6jH6uPXVFyF/ch6yh8FE46vmjxiipY
   8A+rt85VzTw8T5bQrdIfUE8FDfbMYJAc31ByitpNBDHe5UUFcBqpqTYDB
   w==;
X-CSE-ConnectionGUID: lhqfj+ClRBmMsnzlRSNyvA==
X-CSE-MsgGUID: /4SB2i6AQ1W1hSmKUxDBJw==
X-IronPort-AV: E=Sophos;i="6.07,207,1708412400"; 
   d="scan'208";a="23379754"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 19:43:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 19:42:54 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 19:42:43 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <Dharma.B@microchip.com>, <andrzej.hajda@intel.com>,
	<neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Manikandan.M@microchip.com>, <arnd@arndb.de>,
	<geert+renesas@glider.be>, <Jason@zx2c4.com>, <mpe@ellerman.id.au>,
	<gerg@linux-m68k.org>, <rdunlap@infradead.org>, <vbabka@suse.cz>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Dharma Balasubiramani
	<dharma.b@microchip.com>, Hari Prasath Gujulan Elango
	<hari.prasathge@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v6 4/4] ARM: configs: at91: Enable LVDS serializer support
Date: Wed, 17 Apr 2024 08:11:37 +0530
Message-ID: <20240417024137.144727-5-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417024137.144727-1-dharma.b@microchip.com>
References: <20240417024137.144727-1-dharma.b@microchip.com>
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
v4 -> v5
v3 -> v4
v2 -> v3
- No Changes.
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 1d53aec4c836..6eabe2313c9a 100644
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


