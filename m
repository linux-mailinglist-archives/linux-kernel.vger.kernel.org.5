Return-Path: <linux-kernel+bounces-86640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19586C840
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B672C282957
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C677C0A7;
	Thu, 29 Feb 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="16yimMNY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8317C0B3;
	Thu, 29 Feb 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206906; cv=none; b=jnEAY5STLuYQ3kmDWRSAcZDV9PZVCZrp9Bzv/562tFCNWqkC6bqo29hR6YI5/b2gLKuGEYh/paPxpgGr4FsTq6BzG+n6IDJGueX7DW1te8JeytvyY63+X/bq8p4RLqDpvrlICetbejIrgzbUPRkDv883JbglAFFUIXkSSksWuFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206906; c=relaxed/simple;
	bh=xZvNmd9Co2CBVcWZAK1TV8E96evcBzcg7imrikzbhYE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=hKnGTSKIJ4meUyT+rtk0BGB7Tx+XpO/VYryS1goiR1H+3YZjaqdfdWAxs9RBU/WS/8AZKIxCIeTAgmxMbwDT0YVdaB21syJZM62gWn0DevUpAhVSfXKSjLj9QxbUV+OAS17CiXrN0ngFzMculioqVfFVwonr0pMsl37litM4h0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=16yimMNY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709206903; x=1740742903;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=xZvNmd9Co2CBVcWZAK1TV8E96evcBzcg7imrikzbhYE=;
  b=16yimMNYj9hRLIHoX/9nHotxPjMl1NIQD3ww88h9F99BWFhYZt2QmBwg
   gT0KE6R0rLeEK2l+K9YqSiRg9/lONbzV+mfNHblPZ7IQiMf+32JPxyW/l
   HMunmPz3L0qjOkHjM4Q8KeSWXVRl/e16MueKHvEJPIWHlwPqQiAQguD+o
   G44gpentpPQxllOUBjTjbXOabh7aAvuvmt7XLM99K/Adj0cf+Y/VdvxLU
   01AL2WNBKFFhKPQbnOsiTvuak5ovi+ZVS/MLGvJdV0Xa+p90oIlueI6Il
   F6tO/NocSCLDkO3QC0DFkKAs9EXtCDNuNCf4TPh1ReTOOXRv2/foNszPI
   A==;
X-CSE-ConnectionGUID: 3CkcnVRnRlyAYMMQwYqwlA==
X-CSE-MsgGUID: GdryfS4tRei073hzJQPw1A==
X-IronPort-AV: E=Sophos;i="6.06,194,1705388400"; 
   d="scan'208";a="17008184"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 04:41:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 04:41:33 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Feb 2024 04:41:29 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH 0/3] convert Atmel's PIO4 bindings to json-schema
Date: Thu, 29 Feb 2024 17:09:29 +0530
Message-ID: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJs4GUC/x2MQQqAIBAAvyJ7TtjWCuor0UFsq4Uy0Ygi+nvSZ
 WAOMw8kjsIJOvVA5FOS7D5LWShwi/UzaxmzAyFVSGR0kL3K8O6Iq77ttmqHjSuREE1bQ+5C5Em
 u/9kP7/sB/vbRJmMAAAA=
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Linus Walleij <linus.walleij@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>, "Balakrishnan
 Sambath" <balakrishnan.s@microchip.com>
X-Mailer: b4 0.13.0

- Convert Atmel's PIO4 pin controller Device Tree bindings to a
YAML-based DT schema.

- Move sama5d2-pinfunc.h and sama7g5-pinfunc.h files to the
include/dt-bindings/pinctrl directory to enable their inclusion in YAML
DT-binding examples.

- The bindings are tested with make dt_binding_check dtbs_check

Note:
- The patch "[PATCH 3/3] dt-bindings: pinctrl: at91-pio4: convert
Atmel's PIO4 bindings to json-schema" has dependency on "[PATCH 1/3]
ARM: dts: microchip: sama5d2: Move pinfunc.h headers [PATCH 2/3] ARM:
dts: microchip: sama7g5: Move pinfunc.h headers"  

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
Balakrishnan Sambath (3):
      ARM: dts: microchip: sama5d2: Move pinfunc.h headers
      ARM: dts: microchip: sama7g5: Move pinfunc.h headers
      dt-bindings: pinctrl: at91-pio4: convert Atmel's PIO4 bindings to json-schema

 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  98 ---------------
 .../bindings/pinctrl/atmel,sama5d2-pinctrl.yaml    | 140 +++++++++++++++++++++
 .../boot/dts/microchip/at91-kizbox3_common.dtsi    |   2 +-
 .../arm/boot/dts/microchip/at91-sama5d27_som1.dtsi |   2 +-
 .../boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   |   2 +-
 .../boot/dts/microchip/at91-sama5d29_curiosity.dts |   2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts   |   2 +-
 .../arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts |   2 +-
 .../boot/dts/microchip/at91-sama5d2_xplained.dts   |   2 +-
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts     |   2 +-
 .../dt-bindings/pinctrl}/sama5d2-pinfunc.h         |   0
 .../dt-bindings/pinctrl}/sama7g5-pinfunc.h         |   0
 12 files changed, 148 insertions(+), 106 deletions(-)
---
base-commit: 805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
change-id: 20240223-pio4-pinctrl-yaml-c06c10200395

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>


