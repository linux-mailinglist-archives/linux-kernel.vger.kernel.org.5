Return-Path: <linux-kernel+bounces-139984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C68A09FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A364B29D32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0A6144305;
	Thu, 11 Apr 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p4wFLxHf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79813E8A7;
	Thu, 11 Apr 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820892; cv=none; b=eo1Z5z45VggWUq209qkdFIbsSfnMYZ/tRxBSaOZjf5mmQwB05raA5S3CaswSXeUAfOaIXuAFSvdND3hxbUHZJ5v5jUMT1E9SJslvPUj4EYFCj0FxFrD+r85yS5wIcX7bfjSwgkBYRtK6ngSYbPxX9Cgo7GbE32FnOFHcXG06CEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820892; c=relaxed/simple;
	bh=fR9EirU0BsHeLhReUfwHcfDzjHOLnxd5IQM0a/6XQu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImjCYqP4//DYGLMXh3DDvWf3mhwVHgwfSUEmDC5+Y3TsJ51TpYsMoHjsU/w3S0ImVl6fQhpvyyAZXBanTp43LNYo7Zl7WDGGhgSTU/n7acsBRW2kM0tRR2Nzb/zV9Q3sK0rzPYT7y0OA/ki5AEryMAnGLDtJqCXbxh0grB33REY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p4wFLxHf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820890; x=1744356890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fR9EirU0BsHeLhReUfwHcfDzjHOLnxd5IQM0a/6XQu8=;
  b=p4wFLxHfPk972/QDPu2JnS2GYL/0+BgvTwj4TaE8edKtFhh4432KOPU3
   ITzbsxiLeO6lJ2FnnJTQv/xzPmuNX9PuYcdXG2VN9l4oxLS27XC+CSgwF
   hyCxLvRt9sw1+rhxA9X1FaA966V4/zL+miOEpWsKQrWEk3o1nYqq9XYeY
   rXYMdlkxdAMt9BkUatDYD8mx7NZuNhqjD2x0fzYhorHcoPj+z8UbKsGuw
   44rcT56n9LilQTexz1p/jC7CSdnVXhK5qTnQwOExlwfwcyuDY+CQiGkIy
   NjOYd/SbNw+1ee00lXis8tO2N3YXkpDjMJ0Ycm/rX8npEidvnmkm4W6QT
   Q==;
X-CSE-ConnectionGUID: jDRmTUiXRgK//h330KmRHg==
X-CSE-MsgGUID: 4gTm3zaWSrOWThig7WSjug==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="21068911"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:22 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:20 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 05/13] ARM: dts: microchip: sama5d27_wlsom1_ek: Remove the empty line 31
Date: Thu, 11 Apr 2024 10:33:45 +0300
Message-ID: <20240411073353.3831-6-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411073353.3831-1-mihai.sain@microchip.com>
References: <20240411073353.3831-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Remove the empty line 31 from gpio-keys node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886..6e485c9be889 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -28,7 +28,6 @@ chosen {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
-- 
2.44.0


