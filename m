Return-Path: <linux-kernel+bounces-56318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9A84C8A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E76B234AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E602560B;
	Wed,  7 Feb 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LCghbwMn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021B25614
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301766; cv=none; b=b7QurP5+fdl25UWA5n9NHif6jZ6KDGq8WC0jCYR1oo2aUICgFsH/atpvlTUbm8KsQVFkh0t/l+bi+rsU+afU2vY7yRdjpq8gj0vJLujUeEGt2oZ70vDslDlETMpSWVdKgE5tTRFwDOokSg4LdyW32WGdLrSqADp5fieUpch+0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301766; c=relaxed/simple;
	bh=wH2zsP9JGzlyrwRpnqv+pfFWgVa5nzc70+du/OHojQY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKTh0vIxbaDpldQzqqWCICCrbZZwQ6ilbivVVa7wqyueE/dr8LNloKI/6zvOMwoYj8wuCzzVSAqrmE+Vr3WQ0aMhI7bhW1YR9M015rATkE2WJRqBpXbFuM/ccTzQXv/E08roSlMlrrYfrhTqDYy171qZ6c3TkREhiGo3pdwaNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LCghbwMn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707301765; x=1738837765;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=wH2zsP9JGzlyrwRpnqv+pfFWgVa5nzc70+du/OHojQY=;
  b=LCghbwMnJ2KUFqylaLCqHKaJEkmFGVtWWApP6Zh4hKWZmJbEHTARnUHX
   m7ZVOFEAzaosKI4czMxZ3iijAFpFXb/GR32XNT484B6wG1R3XRcY81tLk
   U7R5MWk7pMRLothBqa/nv3JFuybY1h1OWtuARujbngVkTP6kCSKzEYylk
   QqxzqgimCg5XXyC4zX1briyhFJ6XSZ1Ne1bbJlgg0U7ZCyK1zBuVVYqem
   rhpcgYpkUZKn8FggwBmKODZDApfVbJMfunCDLsIO0rvTmILCTG/cC1ZXb
   YRXNvp0gpsk77ravNxlqfChowl57ziFCog4fgFykDH435NxGRwDSssNE2
   w==;
X-CSE-ConnectionGUID: vlwDUa2MSzqzjUOhgJNZgw==
X-CSE-MsgGUID: Cg5+GJ1KSwChd2f5YCSPIA==
X-IronPort-AV: E=Sophos;i="6.05,250,1701154800"; 
   d="scan'208";a="15886077"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 03:29:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 03:28:51 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 03:28:40 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <dharma.b@microchip.com>,
	<manikandan.m@microchip.com>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <geert+renesas@glider.be>, <arnd@arndb.de>,
	<palmer@rivosinc.com>, <akpm@linux-foundation.org>, <gerg@linux-m68k.org>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
Date: Wed, 7 Feb 2024 15:58:01 +0530
Message-ID: <20240207102802.200220-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207102802.200220-1-dharma.b@microchip.com>
References: <20240207102802.200220-1-dharma.b@microchip.com>
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
v2 -> v3
- Move the entry before "MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER".

v1 -> v2
- No Changes.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..ce592b6cf375 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14216,6 +14216,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 F:	drivers/pwm/pwm-atmel.c
 
+MICROCHIP SAM9x7-COMPATIBLE LVDS CONTROLLER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+M:	Dharma Balasubiramani <dharma.b@microchip.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
+F:	drivers/gpu/drm/bridge/microchip-lvds.c
+
 MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
-- 
2.25.1


