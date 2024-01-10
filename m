Return-Path: <linux-kernel+bounces-21991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A89829797
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C1828F4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF43146541;
	Wed, 10 Jan 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YHOxF9Gs"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D546525;
	Wed, 10 Jan 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704882392; x=1736418392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1E6SGPMyspfxdGXcr6MF97yBDgvECpeTUGECKTrub6g=;
  b=YHOxF9Gsx59laybDjb12lEx3ZkPbQJWojXy6+0GY6rf19Gns9Sy1pW1+
   DcXxRCmAlVkD5S6iS2wdhlNeArKqOjgA3IA3akjC4loBPlDUHqi8tSj3Q
   JXg98genbAmcRCmaLdmkI44ESvHhPh4nLvn1oFbJRbP9ocR84VxArIoUR
   9+Y1l/amMNYhsn/JbzZBHQRO6Ven6ambjjtanlw1bC/8WVeVAZOa9hHMg
   rIFFN/l6lTwk8c+VEzno3QEzbPXMLO3wvsjZ0FpkqcNB/Ry4HFFLVdGbR
   dK4twe/WkoFyalzp0EjvlbeIdThPDpEyi1ENYNFbIbd08iqf7xNVEPWaK
   g==;
X-CSE-ConnectionGUID: 4FLeVdXIRtGRQjBQXLr/AA==
X-CSE-MsgGUID: t5Eg5YbQRdCgP9shtgUuhw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="181745210"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2024 03:26:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 03:26:00 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 03:25:53 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH 0/3] Convert Microchip's HLCDC Text based DT bindings to JSON schema
Date: Wed, 10 Jan 2024 15:55:32 +0530
Message-ID: <20240110102535.246177-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Converted the text bindings to YAML and validated them using following commands

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
$ make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/

Dharma Balasubiramani (3):
  dt-bindings: display: convert Atmel's HLCDC to DT schema
  dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
  dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema

 .../display/atmel/atmel,hlcdc-dc.yaml         | 133 ++++++++++++++++++
 .../bindings/display/atmel/hlcdc-dc.txt       |  75 ----------
 .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 106 ++++++++++++++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt   |  56 --------
 .../bindings/pwm/atmel,hlcdc-pwm.yaml         |  62 ++++++++
 .../bindings/pwm/atmel-hlcdc-pwm.txt          |  29 ----
 6 files changed, 301 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

-- 
2.25.1


