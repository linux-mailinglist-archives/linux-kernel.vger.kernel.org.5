Return-Path: <linux-kernel+bounces-52458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B421F849879
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D511C22094
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F9D18E3F;
	Mon,  5 Feb 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lF9Tpyva"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0418EB2;
	Mon,  5 Feb 2024 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131252; cv=none; b=CSDo2Ss3BNQFhPe7cpk4ZXW3lUv7AFQHKxO9GAkDGE+q8xWXfa3VECi+G1gF1pGiDxbz5TF1SnFZ84e3pnvZGEoxaGIclJo6BJWe17ybrvMNqM3BWmhqHNhZBGgXUxMZisEiYK3RDkmuRSRYbLL10p9TbIxYIU4CHo+lKsAvef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131252; c=relaxed/simple;
	bh=xpa5OEHrZhzJFKNUpZbNZM8rzmZMnZWnSvw1+lSjgOU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpzMeYqXNcR6DqvVXqnhME4Zhg9nDU3i/Ea4LMWrmTZr2OH4Bv0U1i8svIfgSvqcLAPT5OpxeDVPVbk8+c5n6d9+0qajoZmhatE5f1GP2AlzwJ2wCa+FYfPmwKm9fGd/+e8OvJ5RLjo7x/t+jkxzoIcmdUpfRrTTxGj3WtUoCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lF9Tpyva; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707131251; x=1738667251;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xpa5OEHrZhzJFKNUpZbNZM8rzmZMnZWnSvw1+lSjgOU=;
  b=lF9TpyvalllZY+5I13TlZTy96hf6AvEIO1N1/ecOI9kKqql0cMVcLbyn
   z/tlIKxbFw9m6j5E6AQlbK469t8fE8Ao1VbY1h2D5qgnhKqzWT6U4NPiy
   MscxFnK8D4YSUOx/DOuH7Re8iLug/eDN2i04sfD/HPIEjKDyzsSb1vJGg
   29VkX6F8A5eRY5pOt0r/ZBgloR4dZudyqzFVPx+hL9MNSUXNxYVb2nZ8B
   qNnT84kBQFyg4dmtSQyBU3BHKGqMF3xIxdigKLy3tZ5RgQMqAHjv27fu+
   qV9IUG7okztVKbiLsxGKlDf1x1BziNiigwtqxN5xGv33LBVMGsOlparO9
   w==;
X-CSE-ConnectionGUID: 3y4Nx3goS+WM5v3ulNT5AA==
X-CSE-MsgGUID: y2eWaWXhRMKpJxkvRZCu7Q==
X-IronPort-AV: E=Sophos;i="6.05,245,1701154800"; 
   d="scan'208";a="183034596"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 04:07:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 04:06:57 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 04:06:47 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <dharma.b@microchip.com>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <geert+renesas@glider.be>, <arnd@arndb.de>,
	<hari.prasathge@microchip.com>, <Jason@zx2c4.com>, <rientjes@google.com>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>, <manikandan.m@microchip.com>
Subject: [linux][PATCH v2 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
Date: Mon, 5 Feb 2024 16:36:08 +0530
Message-ID: <20240205110609.217022-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205110609.217022-1-dharma.b@microchip.com>
References: <20240205110609.217022-1-dharma.b@microchip.com>
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
---
Changelog
v1 -> v2
- No Changes.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..24a266d20df6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14230,6 +14230,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
+MICROCHIP SAM9x7-COMPATIBLE LVDS CONTROLLER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+M:	Dharma Balasubiramani <dharma.b@microchip.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
+F:	drivers/gpu/drm/bridge/microchip-lvds.c
+
 MICROCHIP SOC DRIVERS
 M:	Conor Dooley <conor@kernel.org>
 S:	Supported
-- 
2.25.1


