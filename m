Return-Path: <linux-kernel+bounces-52172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA68E8494F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8AA1F239E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3801118A;
	Mon,  5 Feb 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nIzwYrGx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85610A2E;
	Mon,  5 Feb 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120071; cv=none; b=FJC3Q/KCRurrWznuRpX57UNSf+qiFzpQ7lCMRU7/evN0o5WroYDvcj9vwLRXeg2J+AciZCKlcvIthnk6/ErYfXIE5w8T4ySjBGpRf+4FD5x5b2YJCVHS7geGM1C+IUORJrZ0Ix6LuuXfb/S+vjk9Vueb6XsIKDemN72KXWVMuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120071; c=relaxed/simple;
	bh=p+Uj34kCikvUIdbvpZfE2Fe1DJXGR4Kpf8PdpkBdJMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/77xmtwc9WHm0I4rdYalhJ5XPLhqVdr7Hlrb3HwC8kglJwOHTHcVnK+HDRgR76ypyKf0bRiFsiWP3Iue20CxoKlLiqauYwk0CwPW7kCp60nGx1Z2fFHPTju/zLqC3QebluiCkwPjTB/ConIOM1FFKfCH+51gPBl2z0QNovF//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nIzwYrGx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120070; x=1738656070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+Uj34kCikvUIdbvpZfE2Fe1DJXGR4Kpf8PdpkBdJMQ=;
  b=nIzwYrGxwyaCzWk2b4nLNJKzUHeP5G/dd1JN5jXOIASoDt0Oc49zcqY8
   KX51TCBBQq93Cfngo7rtjoTm+oR8LekD6J21nTqJEr9ZUQXEOZGsRnWfc
   vH6QR6FsNUlVsRWLbpwEp7fX0MVNIBwu1POTPVgqHHKwU7iFYFAztxUvT
   /XJCr1Xvq+H28IRnYbeaJa3DhoR8/yJNyBx0uKr3eyAHmbH1ZALqGdH9p
   w1UVnzeN39eZV1dN0kh2et1Dj6ZNmJmD2yFNFnFARmZrqHjCS3Xnd/k/w
   oYOr44jUngS56QfHMHpnhTvD6nhOEoC7YvNzaUrvA6VaYCgiPWYMuRmT/
   Q==;
X-CSE-ConnectionGUID: /sWzmiszTQ2ztYFgEFabog==
X-CSE-MsgGUID: yUJNFHmJSSe5k+KN7KP6gg==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="16278236"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:01:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:47 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:45 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 6/8] ARM: dts: microchip: sama5d29_curiosity: Add power-supply properties for sdmmc nodes
Date: Mon, 5 Feb 2024 10:00:24 +0200
Message-ID: <20240205080027.4565-7-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205080027.4565-1-mihai.sain@microchip.com>
References: <20240205080027.4565-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc0 and sdmmc1 controllers are powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.
The sdmmc controller from SAMA5D2 MPU has support for IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by the UHS cards,
keep the vqmmc at 3V3 to use the sd high-speed mode.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 6b02b7bcfd49..4a86597d089a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -504,6 +504,8 @@ &sdmmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
 	disable-wp;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 };
 
@@ -512,6 +514,8 @@ &sdmmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	disable-wp;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


