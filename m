Return-Path: <linux-kernel+bounces-52459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89E84987B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5AB1C220EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126CA1A286;
	Mon,  5 Feb 2024 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RhDRsEOE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9C1864D;
	Mon,  5 Feb 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131262; cv=none; b=COL+F48aMod4OL3CxSQ3Hn+Bld0ZgZwNJ0jYdfiub9vIdisS04AQ8FD5Yy5GXY9PR/HcR7b/ehFBdlNUXBnqQaCtmhYEDy2s+XEhN9TrbkkgEZVnPZ2ASGGkY0qBGJdI/Ltt4gvRQqi25Df7XLs+SmEZ1xmHXAj6fP+Qv/HhYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131262; c=relaxed/simple;
	bh=h1WG3UMHH5D0iOHOLKyKvreY2dXMkB2LB/fSkxyjgcM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jr5jewXq2yzH1MGcdXHCkaytgVkak0rJPC1qQN6nT9KxEWhjf/LfiE8jCjyL72J8JdeQBRc3lPa/JxrGbSjMpIpuAZakVixVwXBN4Mg/r7hxM6FV7J3AiaKfh3RFt9qMDzEnrzT9y8Rtm2W3gInUm/m0yDLqDTvHwJM5gp79GyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RhDRsEOE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707131260; x=1738667260;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=h1WG3UMHH5D0iOHOLKyKvreY2dXMkB2LB/fSkxyjgcM=;
  b=RhDRsEOE7tB0BCC/dE4/R/Me91gJOZvZ1uLQCegkDOS+s3zKvyegQQOh
   FnZhjsr0eORTMXh/sx/DnjHlTRpKtV1L+syQzbuqa5knnMA900DxmEsYd
   qHjAEzMGD0ecHFIcpMHoKKV/8k1Y5+RGvyY5e0t4grFFVXVv0kY+Ejtg4
   VoNwMY1pnDUVGLyd0BYhkwuTvFhD7zDbfVD9lwgRCLi+B/QDW3DpsYlsG
   4uJ3iAmMJLsURO3KCZPTsHO4SrDR+X2h1+udAb7RFfJnXaPNNgkzbhS7t
   /stQNrsJdn9ejcBN1pSleGPRMYcyDtg7G74iNEDLoHGqtSJQv9damUHpY
   A==;
X-CSE-ConnectionGUID: 2GfonfF1TQOVFAeAw91dnA==
X-CSE-MsgGUID: PG0Ncdl8SaK5OtSI4wbZmg==
X-IronPort-AV: E=Sophos;i="6.05,245,1701154800"; 
   d="scan'208";a="16285316"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 04:07:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 04:07:09 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 04:06:58 -0700
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
Subject: [linux][PATCH v2 4/4] ARM: configs: at91: Enable LVDS serializer support
Date: Mon, 5 Feb 2024 16:36:09 +0530
Message-ID: <20240205110609.217022-5-dharma.b@microchip.com>
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

Enable LVDS serializer support for display pipeline.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Acked-by: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>
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


