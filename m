Return-Path: <linux-kernel+bounces-34899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576258388FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8994F1C24DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC656B87;
	Tue, 23 Jan 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Myb1YVci"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9AA42A8D;
	Tue, 23 Jan 2024 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998766; cv=none; b=CeRm2Cw/+yksjUObh4sjpaTNrLJjLD8+kFm0bAD10jL21HmU8yyktS9oUgxpE9S9FVY0Bv4rC2YGqSZRWwOad3j3uNUh+T9ta0bV5QRsS4afan1MOOH73qhYBkk8bmsy6j4luQ+4g3BZD3D7Wd3i4GEcWmH1vEeRb57zomjZkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998766; c=relaxed/simple;
	bh=JgzsX4U88+o/TQLzF6JvKA7gVpU2Xjb5kwOL7j3FcTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8+CE9t1KtHzWP7oxlOk1qrjgNt4yOMEuHm+NXfSFf4YmIG/Qw+haSgTZid4dt+5mcK5h2F2NNr4nOt0MKlJL4Tc4MKTXENRDOgrJ1kg/hGuaxszNdyBOp0+sW22gFmy1HEStgi0NO48y7X/aV4VLUp5NMu/OLSNTzp9+C3qnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Myb1YVci; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705998765; x=1737534765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JgzsX4U88+o/TQLzF6JvKA7gVpU2Xjb5kwOL7j3FcTI=;
  b=Myb1YVcirDG82GmQXb0ugX89rEFhUZ7GHzv5FjhG9uflQD3ODAYZHSLB
   CvYz6K11VMVaCKOA99Smd890X1iCJV5WA+/iIOXgkQefPn+lTcFwEEbHv
   fw27g3qOt57BXfjAcm9lml+4vWQB6TfLqaoEiCmBzircmDn3lPx7+SzzC
   GDDdlyoQVzfvn7osHmvCQAcV1mxujeqH5psCi7OhojXHa2EcKzZ9pXyhL
   6q0n7JMsV+YG5NvK60vOu1LKwY6pV02O+WJIo6pVhYEAYDG/wqm7IfmYW
   EuG9h0krPIkTU2kBYLoeTWEcKUUxPeJzp4zO7mI+W0FFPSctVtVM7Y7Ex
   g==;
X-CSE-ConnectionGUID: d5ZmezpQQju+JS/ZUCZJPA==
X-CSE-MsgGUID: PQqRyH6zRZqdG09AJeVohQ==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="245869076"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:32:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:32:26 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:32:24 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/8] ARM: dts: microchip: sam9x60_curiosity: Add power-supply properties for sdmmc nodes
Date: Tue, 23 Jan 2024 10:31:51 +0200
Message-ID: <20240123083158.7339-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123083158.7339-1-mihai.sain@microchip.com>
References: <20240123083158.7339-1-mihai.sain@microchip.com>
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

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
index c6fbdd29019f..457c54dde0b7 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
@@ -452,6 +452,8 @@ &sdmmc0 {
 	pinctrl-0 = <&pinctrl_sdmmc0_default &pinctrl_sdmmc0_cd>;
 	cd-gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	vmmc-supply = <&vdd1_3v3>;
+	vqmmc-supply = <&vdd1_3v3>;
 	status = "okay";
 };
 
@@ -460,6 +462,8 @@ &sdmmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	disable-wp;
+	vmmc-supply = <&vdd1_3v3>;
+	vqmmc-supply = <&vdd1_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


