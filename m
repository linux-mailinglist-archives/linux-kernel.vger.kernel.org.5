Return-Path: <linux-kernel+bounces-63742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A38533DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA461F2CE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C1960256;
	Tue, 13 Feb 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FrwC+Nn+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3135FDC4;
	Tue, 13 Feb 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836185; cv=none; b=qn5YL1RBm/MqfIaBPBHFRpr+lS1DpKQb0WL34WI+vy8gjhO4GoXt5jQAF8eaB2ZsGZ9DVOSTR/7RBkVTYjh4rIlnS/AqQN39nchhj9CLguQlAmGZt8Lkg5mv05Pxf7aAVqa+6w3qxUNb6Ye4h6ZpilDtNOqwSLG8ikeZaebMw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836185; c=relaxed/simple;
	bh=DS6Q5V5bX9RLnvwPPNFcvPuCL1BwXbl3LC1Dt1jD2YI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqZar061xwgH7Dk6QpEUElDdaIfvLj+7Np/LA8EyevZYRx4rzadW8XQ+c/A/EZxJjp5ULweDMPZkiI69sixp60Lq7Sfl5lN1vI5PiFpeJp8siwcJG07skl+pr6EIVOBPJ2ljy07dAe4s7+YLDF7aTPlHY8eVVYqnkj/kMfr/Qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FrwC+Nn+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836183; x=1739372183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DS6Q5V5bX9RLnvwPPNFcvPuCL1BwXbl3LC1Dt1jD2YI=;
  b=FrwC+Nn+O0Jik7Z/+50Qx9fBcPxcp7Ik2tzQSXnTpS8+Sw/esX9W1BNK
   WxiTe81LEBrZUpgrkShfSg8kCttyXDh1M3dNolenGjuiFnJLh7VIYNM19
   WeJPx5aSf89sOodQbIO3kmlRl/+G5rnw/j3lyOU+BA5mzsm7c51eJwdx8
   DMj74obuUak3wkBpAclWmYA2HRzv+VJePTszYVB+xmecLr3xNzSK0lUej
   WBHw0I/CsQuQMYlYLZbkmqzfiWJqXW7PjPJrrPwrnaMUg1UThrRRuj5hk
   bf/22u4b6B9VZIuiG9BsQ0mUMai9xm6Q9+RlPQcgIatAXtcid1la4vCIF
   Q==;
X-CSE-ConnectionGUID: notrBuGtRbuSS13mA3DSPA==
X-CSE-MsgGUID: Le84sXjyS+mTzTJk3ElkIg==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="17608946"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:56:10 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:56:08 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 7/8] ARM: dts: microchip: sama5d2_icp: Add power-supply property for sdmmc0 node
Date: Tue, 13 Feb 2024 16:55:41 +0200
Message-ID: <20240213145542.23207-8-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213145542.23207-1-mihai.sain@microchip.com>
References: <20240213145542.23207-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In order to avoid the issues from the tuning procedure required by
the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.
Add vmmc-supply and vqmmc-supply properties to sdmmc0 node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..adcb3240e5f5 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -712,6 +712,8 @@ &sdmmc0 {
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	vmmc-supply = <&vdd_io_reg>;	// 3.3V
+	vqmmc-supply = <&vdd_io_reg>;	// 3.3V
 	status = "okay";
 };
 
-- 
2.43.0


