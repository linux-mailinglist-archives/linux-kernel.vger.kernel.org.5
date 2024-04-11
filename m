Return-Path: <linux-kernel+bounces-139977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EE28A09E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C809B28F70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129B13E3F4;
	Thu, 11 Apr 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g267XWbF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F213E039;
	Thu, 11 Apr 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820888; cv=none; b=mraHO7NX3Zu6hFn+p/kGiZf+NSvUMm6Y16ripzkDjweY0Rk30zjAZOeaHqeesMdwWmaYzdFK/0SdkV8NRB9d98QPetm/sn9EWLSGlxy0hG0/BbA/OrzQHVAe9QK8n3rubfFB85U0H7TQt2lCYcEB3GoemkmaUc9xy7ZJCVHIj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820888; c=relaxed/simple;
	bh=9mgSJr2sWYmB8FQE7jSTgaIzS/2tzmSLSQ5ufV9zJBs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EvK8c2fEy8BNYxLZv0ISyBtkx9rKvFHvLnh3sjCV9V0myb0mO/jFDwoNJrISIyiNhr5ji0uWWauXXjrN4nwgMbjOG41oktNHpm7dyaIAlhLUeANXU8VD+dDlCNEmarC5q45LBWiq1JiStQsCht6IVdwghp1yCsIh4kGt3rVsv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g267XWbF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820885; x=1744356885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9mgSJr2sWYmB8FQE7jSTgaIzS/2tzmSLSQ5ufV9zJBs=;
  b=g267XWbFCZ/RZlx6wl5TYVfcWE+NLczFvsXI3DsK0i+bZOiWQhJ3tAuW
   pH64PFagbmi2qsGAbgu5X7/gzkeKFL4dCDXg4Y92REYFx5JbsicLN016o
   2wkZR6iLzaZvZaJZ50D/F+c9tFeSgB0KbO3I6sGK+JHamGcmMW+Xr7RPV
   +j8dkCFOjHxRzbORGscI15PNdmEmvCYTm3erEOogyq0mhLd+OQo3ggeQR
   P4fmlxEOkRER4Xzynb4ulQAa29CVcZY6zjaxmDblaLW8utKlhJs4SksNq
   HJm4gbxE9L3WUVt2+8xSWGDoNfwdeYBfnalbrmEyrJZlsLLQNgVL/Gb85
   g==;
X-CSE-ConnectionGUID: jDRmTUiXRgK//h330KmRHg==
X-CSE-MsgGUID: by41cpSVR0mB644cGEjoug==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="21068901"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:09 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:07 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 00/13] Remove the empty lines from sama5 and sama7 DT files
Date: Thu, 11 Apr 2024 10:33:40 +0300
Message-ID: <20240411073353.3831-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series removes the empty lines from sama5 and sama7 DT files.

Mihai Sain (13):
  ARM: dts: microchip: sama7g5ek: Remove the empty line 50
  ARM: dts: microchip: sama7g5: Remove the empty line 139
  ARM: dts: microchip: sama5d2: Remove the empty lines 47 and 63
  ARM: dts: microchip: sama5d27_som1_ek: Remove the empty lines
  ARM: dts: microchip: sama5d27_wlsom1_ek: Remove the empty line 31
  ARM: dts: microchip: sama5d29_curiosity: Remove the empty line 48
  ARM: dts: microchip: sama5d2_icp: Remove the empty line 47
  ARM: dts: microchip: sama5d2_ptc_ek: Remove the empty line 401
  ARM: dts: microchip: sama5d2_xplained: Remove the empty line 710
  ARM: dts: microchip: sama5d3_eds: Remove the empty line 24
  ARM: dts: microchip: sama5d3_xplained: Remove the empty line 377
  ARM: dts: microchip: sama5d4_xplained: Remove the empty line 247
  ARM: dts: microchip: sama5d4ek: Remove the empty line 274

 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts   | 4 ----
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 1 -
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 1 -
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts        | 1 -
 arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts     | 1 -
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts   | 1 -
 arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts        | 1 -
 arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts   | 1 -
 arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts   | 1 -
 arch/arm/boot/dts/microchip/at91-sama5d4ek.dts          | 1 -
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts          | 1 -
 arch/arm/boot/dts/microchip/sama5d2.dtsi                | 2 --
 arch/arm/boot/dts/microchip/sama7g5.dtsi                | 1 -
 13 files changed, 17 deletions(-)


base-commit: e8c39d0f57f358950356a8e44ee5159f57f86ec5
-- 
2.44.0


