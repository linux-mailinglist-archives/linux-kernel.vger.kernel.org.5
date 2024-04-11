Return-Path: <linux-kernel+bounces-139983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D78A09F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6CB1C224AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02034140E3C;
	Thu, 11 Apr 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ice5wF9Y"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBC13E898;
	Thu, 11 Apr 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820892; cv=none; b=uEtChONNNry/CE71Ke573m8K2Ej+uSkWXNfBxhqsWDIV0HpjadDDjDSFf2sWZWxWasgn08z0kYsoLYHWMoeRDz8R0vgtTV35oGWB019dbO/3I/Z+5LOXLlcAYl+6cOKXKrE1HAWO4xmJcMzziX8s6FPfIfvt9LBSDT1KjzTtbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820892; c=relaxed/simple;
	bh=+DuTIuaxUwVXepW0FwTuQjXnvnUKwqlEq+4fg7nDV5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhY0rt4zqcM2qP+ArCMoTWXyVm8laQFV97Bgs9bmrwOSpU4jHIv4JgprNacKjRZUTDPzsxG0WIJK9eJgR4r8mS9pzrdf4ly6gO6Ltggyb/sDrZ9B/GQMAXs2o0gyDj6gvj/IVMis2KJKJRUZ0hTgFNeQ6l/rvOxknxbMQdprooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ice5wF9Y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820890; x=1744356890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+DuTIuaxUwVXepW0FwTuQjXnvnUKwqlEq+4fg7nDV5s=;
  b=Ice5wF9YhywgTxz0QHpaqScUHKlJWKx8YN5wQ2spTuCJ1stIVqFcaj/W
   tjSAH2+91BbsUnjoO91B2tpgEP1KiEK80tgC3Ei8ClMVV+R/gguW5oOcE
   RTi3bgSYGv7PwyKwKBi3TAfQffpP7pIeH1rZUy9vgnWlOzuZMweGtAFsQ
   sqoR4+p/mYBLGVyIfUTQeAZpdwWC2Bqt3sSP1ye+l5mNTI/iEmoPUXeWD
   F1DS5SUq8gxNozXV9Fhx6R+pZOnNwMLSEyQW4LmYp9SNnvLSxF8dtemZy
   ImGc4FNhH9ZY7zDGDQj1zp1yyDAkvDteO7RWSe69PJ/T6YA7rm1DfM+CM
   Q==;
X-CSE-ConnectionGUID: dQ5jbtg2Q1GDLCjGLtSnbQ==
X-CSE-MsgGUID: 0CaMP3NcQr2gLqlhT4BQkw==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="20534670"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:32 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:30 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 09/13] ARM: dts: microchip: sama5d2_xplained: Remove the empty line 710
Date: Thu, 11 Apr 2024 10:33:49 +0300
Message-ID: <20240411073353.3831-10-mihai.sain@microchip.com>
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

Remove the empty line 710 from gpio-keys node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
index 6680031387e8..ae7fcbe2436b 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
@@ -707,7 +707,6 @@ can1: can@fc050000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
-- 
2.44.0


