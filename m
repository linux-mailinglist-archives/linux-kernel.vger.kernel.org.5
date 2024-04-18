Return-Path: <linux-kernel+bounces-149758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51E8A957E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6CE1C20D90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC1015AADB;
	Thu, 18 Apr 2024 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BD2mIXzj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5164136991;
	Thu, 18 Apr 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430739; cv=none; b=Z+axqfqG6zKaUgpyXGOwGB9VuLWcuF6OvhMdPLu82byH6vhHYsQbZWsP1cIJ+K2b3rySky42JZbjdtBPkD9PuvcaS3xXy+Z3cwDXSdeHNk2YI9SwnGP8LRola1TURDZQyYPWzTkUxxaWJt9kppwFZ3UecXQ8fqaKOmcL6CwkaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430739; c=relaxed/simple;
	bh=xvoAVCZn7y6cWhAIyRiSa8G/ubMxvgzRvPGzUq0Y6Ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjZMuUMMmSWSCdogj3IaY0DVcAcneRogPqHBEmRGCnx5iOUiojHX/X58dHa6f/JxVwRKG+Z8j+178i2BOIbCgLvgiKXe/chsbwdUqRORskvfvrPcpdE8Iiu9m0DvJCl0/4EJWxN7D3tuYmIYWUrtFk1QMotzDydJPzKCGVybrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BD2mIXzj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713430737; x=1744966737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xvoAVCZn7y6cWhAIyRiSa8G/ubMxvgzRvPGzUq0Y6Ak=;
  b=BD2mIXzjpuLP3p9zjTAbW4pFoic5nB3kw0A0GJw5NLoitO2Y6xjPIjW0
   rGHxAPpZmqlNgIO/y2Dw8o0KnaKaYgdJp3wJrq7xb4Kiavr4xWBGORKwM
   qAhR9ZvLbvz7qjlKk/HW2g55pRcTxGnxFBluCzDKD64Zdr0xA80vsMBWp
   s14XYYzp25j3tISPX7h4k7vtHWMIv1l6ew6IJ5VVg+8v5CiFUQe3Zq57s
   Kvuc/q9rUwsYKMIAJu7z+UUEdhoa+8QHHDImLKtcE+QGJFP4iCSM4T5+o
   QmYCjUFP7JONMrpAO9PFhBFmayAh0ZSyG+N/EvMApmaQK4hFtouG3FAxx
   g==;
X-CSE-ConnectionGUID: nOC82dQIQv+hluLRGLoAdw==
X-CSE-MsgGUID: KzPS7JK7REyXkQpf/18qng==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="scan'208";a="252380686"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 01:58:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 01:58:45 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 01:58:34 -0700
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
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH v7 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
Date: Thu, 18 Apr 2024 14:27:24 +0530
Message-ID: <20240418085725.373797-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418085725.373797-1-dharma.b@microchip.com>
References: <20240418085725.373797-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the newly added LVDS controller for the SAM9X7 SoC to the existing
MAINTAINERS entry.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changelog
v6 -> v7
- No changes.
v5 -> v6
- Correct the file name sam9x7-lvds.yaml -> sam9x75-lvds.yaml.
v4 -> v5
v3 -> v4
- No changes.
v2 -> v3
- Move the entry before "MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER".
v1 -> v2
- No Changes.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..e49347eac596 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14563,6 +14563,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 F:	drivers/pwm/pwm-atmel.c
 
+MICROCHIP SAM9x7-COMPATIBLE LVDS CONTROLLER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+M:	Dharma Balasubiramani <dharma.b@microchip.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
+F:	drivers/gpu/drm/bridge/microchip-lvds.c
+
 MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
-- 
2.25.1


