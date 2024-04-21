Return-Path: <linux-kernel+bounces-152424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865F68ABE3F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A016F1C208D2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE84C92;
	Sun, 21 Apr 2024 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Tf3S5cDc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69023BF;
	Sun, 21 Apr 2024 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661952; cv=none; b=cE2WTvPV0U9R+MaV6B9v1aHTozcWOw9RI7/3gWBI0/EEIV92YAjelrRYP6XPOS6Y7IVeX7iwR0fDeFUlkcyP/cMKRxJPTsM0BeHZOtaKrYM6UbP0i0sfti/oDgCXzAtuKHytWTzbTBbTOZvugsfZDMzLYf/LSGk9ZrAFs6z+va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661952; c=relaxed/simple;
	bh=VxI0y2xAIarqYhKwEizX+PbrbY/RmC0gcEHXjghD+Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHc3WQKudATgWwJxb4Z7G+y0RjqRQQ1r+TfzYZgZRoJ/TmxVuJ+Ot7ipoqHa6iC7n5Jkrde4nEoYUMj2Jh/iBUDmy1/HDD3X+vZ/HLiT/S+0wottUDGJRH0VZw3g2UNGdEDwnFhAzZvMdpiV3iNujumo09icZUy9C37wGmB7lQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Tf3S5cDc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713661950; x=1745197950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VxI0y2xAIarqYhKwEizX+PbrbY/RmC0gcEHXjghD+Vw=;
  b=Tf3S5cDcihUKuvbwj9O27jL8kBVRaKcUJJfGyXUhSvl3F/DUr++QMxM/
   14gnGA8wzYkmRG3u/LrWQXtne0s+HI6fI/Ys2a99YeNZ+ThIuH/u4qCP9
   PFiOGMvFp7sBPspVlcGHNHLJESXWQr0I93OjpSATtm7rw3xg1YAzMq6fy
   upCF694S/rdZuj9dIsJqgdr6HLPMG2ibYMkThyHY/IbeajnziH1qWvJJK
   Jditnj43TW66I0t9pWp3g+8XIhTtrGbNL5LGKiUxl0lKB0sNTbZ361rUO
   feB7qGO8712XFmWxCubznNktn5wj8PS5z6CWysG1R3HG4NkuIp+DxAsmd
   g==;
X-CSE-ConnectionGUID: X3ajO9lXT+ihQOZ80YRISA==
X-CSE-MsgGUID: dxhgNLj0Q3KWK7a37tkPqQ==
X-IronPort-AV: E=Sophos;i="6.07,217,1708412400"; 
   d="scan'208";a="21942819"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2024 18:12:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Apr 2024 18:12:21 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 20 Apr 2024 18:12:08 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: "dmitry . baryshkov @ linaro . org" <dmitry.baryshkov@linaro.org>,
	"andrzej . hajda @ intel . com" <andrzej.hajda@intel.com>, "neil . armstrong
 @ linaro . org" <neil.armstrong@linaro.org>, "rfoss @ kernel . org"
	<rfoss@kernel.org>, "Laurent . pinchart @ ideasonboard . com"
	<Laurent.pinchart@ideasonboard.com>, "jonas @ kwiboo . se" <jonas@kwiboo.se>,
	"jernej . skrabec @ gmail . com" <jernej.skrabec@gmail.com>, "maarten .
 lankhorst @ linux . intel . com" <maarten.lankhorst@linux.intel.com>,
	"mripard @ kernel . org" <mripard@kernel.org>, "tzimmermann @ suse . de"
	<tzimmermann@suse.de>, "airlied @ gmail . com" <airlied@gmail.com>, "daniel @
 ffwll . ch" <daniel@ffwll.ch>, "robh+dt @ kernel . org" <robh+dt@kernel.org>,
	"krzysztof . kozlowski+dt @ linaro . org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt @ kernel . org"
	<conor+dt@kernel.org>, "linux @ armlinux . org . uk" <linux@armlinux.org.uk>,
	"Nicolas . Ferre @ microchip . com" <Nicolas.Ferre@microchip.com>, "alexandre
 . belloni @ bootlin . com" <alexandre.belloni@bootlin.com>, "claudiu . beznea
 @ tuxon . dev" <claudiu.beznea@tuxon.dev>, "Manikandan . M @ microchip . com"
	<Manikandan.M@microchip.com>, "arnd @ arndb . de" <arnd@arndb.de>,
	"geert+renesas @ glider . be" <geert+renesas@glider.be>, "Jason @ zx2c4 .
 com" <Jason@zx2c4.com>, "mpe @ ellerman . id . au" <mpe@ellerman.id.au>,
	"gerg @ linux-m68k . org" <gerg@linux-m68k.org>, "rdunlap @ infradead . org"
	<rdunlap@infradead.org>, "vbabka @ suse . cz" <vbabka@suse.cz>, "dri-devel @
 lists . freedesktop . org" <dri-devel@lists.freedesktop.org>, "devicetree @
 vger . kernel . org" <devicetree@vger.kernel.org>, "linux-kernel @ vger .
 kernel . org" <linux-kernel@vger.kernel.org>, "oe-kbuild-all @ lists . linux
 . dev" <oe-kbuild-all@lists.linux.dev>, "Hari . PrasathGE @ microchip . com"
	<Hari.PrasathGE@microchip.com>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, "Hari Prasath Gujulan
 Elango" <hari.prasathge@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH v8 4/4] ARM: configs: at91: Enable LVDS serializer support
Date: Sun, 21 Apr 2024 06:40:50 +0530
Message-ID: <20240421011050.43265-5-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240421011050.43265-1-dharma.b@microchip.com>
References: <20240421011050.43265-1-dharma.b@microchip.com>
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
v7 -> v8
v6 -> v7
v5 -> v6
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


