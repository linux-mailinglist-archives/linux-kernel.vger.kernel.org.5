Return-Path: <linux-kernel+bounces-49029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4328464FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED911F26424
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51211374;
	Fri,  2 Feb 2024 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KkQWEYMw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC97E9;
	Fri,  2 Feb 2024 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706833101; cv=none; b=ZhsUhMrjtizB/fBxMoSb/czm1PEZcBkSE8OthbdjZhaI/l52FJydDI5ZLE2fUVOKTcnu86Fk0BqAsBp96qbPUQPiEKH5/JEKH8sYKFpvx0geC9fp9UdwAH7aGfXzKieQd3dBar9eNtcCb12shSRdEjNGWdZo1DipGCu73Piluuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706833101; c=relaxed/simple;
	bh=6lCpe1JWBv0gIutmOVn15+H+ejUjuih0/bmRqdymfH0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2sCnjKAYOoMSnmIJt2dqj1HWFNTxYsmDtzZ/CautBDmxMU40cPXmKJJFI6uBOYaUXbjEnPq92HEqrGijnrMU4cMXyraztd2qDWVc5dLbeS4e9GGSuthk6OtZSPDOsJi0mSdWG9Ps7tXEMKQQUVvfr45iOEeL84kRO8GRdph238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KkQWEYMw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706833099; x=1738369099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6lCpe1JWBv0gIutmOVn15+H+ejUjuih0/bmRqdymfH0=;
  b=KkQWEYMwJZTDr8dc/K+oE0lrlSLa2x22T49eBxn/3roWFr9+SUB99qok
   5ne2eQeIbm2yL2WQXP6lieMWIoTbVr8IONhNMjPZdSlhJMFkNlxyQK9iJ
   uYOwOcTDBvlAPfaFPdhfSz+WzOhyJgQUIIbWU/o+QqfdOHLoJjLH9aKBf
   urQODbmxIGmTrCLDAw9+5cNpzs7V2woe33eM/liVEW23C+XIppy61ebKs
   APsWdpVAXKEKse9WyX2NNU8VjZkAhyOFzhHLpTmgdj7YOPvf6hHsuFISF
   cOAZ5T1DCPaT687J0dwy6XsDQH8tZwEkCqMFn52912LNEDhdducdX0YbY
   Q==;
X-CSE-ConnectionGUID: q2aqr2bnSse6ZnRLstrm9A==
X-CSE-MsgGUID: ZMDnp1A7QAq47c0BW+chNg==
X-IronPort-AV: E=Sophos;i="6.05,236,1701154800"; 
   d="scan'208";a="15650200"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 17:18:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 17:17:45 -0700
Received: from che-lt-i70843lx.amer.actel.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 17:17:37 -0700
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
CC: <hari.prasathge@microchip.com>, <manikandan.m@microchip.com>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>
Subject: [linux][PATCH v6 0/3] Convert Microchip's HLCDC Text based DT bindings to JSON schema
Date: Fri, 2 Feb 2024 05:47:30 +0530
Message-ID: <20240202001733.91455-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Converted the text bindings to YAML and validated them individually using following commands

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
$ make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/

changelogs are available in respective patches.

Dharma Balasubiramani (3):
  dt-bindings: display: convert Atmel's HLCDC to DT schema
  dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
  dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format

 .../atmel/atmel,hlcdc-display-controller.yaml | 63 ++++++++++++
 .../bindings/display/atmel/hlcdc-dc.txt       | 75 --------------
 .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 99 +++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt   | 56 -----------
 .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 35 +++++++
 .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ------
 6 files changed, 197 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

-- 
2.25.1


