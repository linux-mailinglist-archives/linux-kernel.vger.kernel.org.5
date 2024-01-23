Return-Path: <linux-kernel+bounces-34902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25DA838904
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB9028D13C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680B58ACA;
	Tue, 23 Jan 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lhzbqjLB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02D56B90;
	Tue, 23 Jan 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998775; cv=none; b=EeLc0gZr7DGX8sqZFQPtAE5aiafFnFHPqyFh2EuZJPvTJ6vDKV+rkYCjUGVCb/TOzWQIRCNgaje8hgA7CATFaFo78mZZBjjtnQjdM+ZJeWTxnvk4dinr7v8dxETRQjFqfQehbqNfsEJ+fOwhtfZggNOVwxToth+heyElkNssNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998775; c=relaxed/simple;
	bh=2rEshG1L9H5gyrw7mwJdmChVLZQwSJK+Nixq0VCoQVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4OrY5UoIeKlIaPw/8zTKtNeePJFAu76U3hhXByj1yCpn9ywZXNDMMG1ch/gzjQgw7LH07ljYALf9r9WcWT+tepkuxdv+pl0FaSmq3y1NbU5KTR/0HgOtOdU8aMTWYrdSIZ7qlFvKZXsPMlQ97U4a0lxm17gIXrgRo6FXQhoz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lhzbqjLB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705998774; x=1737534774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2rEshG1L9H5gyrw7mwJdmChVLZQwSJK+Nixq0VCoQVk=;
  b=lhzbqjLBi/6ooK/OnlCtPd+mrEBSrSsFIt40TRI+CX27kMLzMKMvw4Ky
   is4qaA1pSEX3cr1N/pKAq8rnVuACldL4OPubQKZP634RwnWY+XPkCVo7/
   COmPvhpDEV1R03mpNPR3xqBALCtn99fFX49du5QpBRrDF0LL42555USgR
   fkGbDgrpFPft3k9XLYRSf0rn0NMkyWcC93pPMzKWJltu41Tw98iifSZV7
   LJfD/AJ5sFXEiB/i7f2+hdjvBBl2uHe3bW01mCgpL+2Z0/ror3yxZHgUH
   T0jbs3YhNhojXalnJk1FnQjyvFPwYSWrNGcpNEmXwvIaHIKxV23fj1e5l
   w==;
X-CSE-ConnectionGUID: 8Z0MiRbqTTiGlgq+aKWHzg==
X-CSE-MsgGUID: +k+MLh3USoSuv0ukYEHOFQ==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="15154462"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:32:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:32:34 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:32:31 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 4/8] ARM: dts: microchip: sama5d27_wlsom1: Add power-supply property for sdmmc1 node
Date: Tue, 23 Jan 2024 10:31:54 +0200
Message-ID: <20240123083158.7339-5-mihai.sain@microchip.com>
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

The sdmmc1 controller is powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc1 node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 4617805c7748..96819ea24cbd 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -368,6 +368,8 @@ &sdmmc1 {
 	no-1-8-v;
 	non-removable;
 	bus-width = <4>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 
 	wilc: wifi@0 {
-- 
2.43.0


