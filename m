Return-Path: <linux-kernel+bounces-45711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8F6843480
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8340B22C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4B11CA1;
	Wed, 31 Jan 2024 03:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yu+VeSoO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063718AFA;
	Wed, 31 Jan 2024 03:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672144; cv=none; b=uCzOk7AqeavFNLXqwimyL0B6epZHAzLyO64Z/6pZbvjQvKsHg7O4+Xy/TsuBvsTiJtbQ1cURCRNlkxi664QhD7KYkF44EgtAN0h+2IOjMHKcJ8qwcwdAOFg+wYBNWFHDISHhnNinixUYY6CGFXayw86pmEfrSw1NfmiVYkoCc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672144; c=relaxed/simple;
	bh=f0XKxASiWqQLt7IJY+mMMoBts6D4KCVhB8RusSPYAvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k+Ad5jf9AfLW8fjE4y2t9p4g4Mr9mCQHcLXGD50u5uOcXkJc9Or8PdmC0mk3ByJ0tNMN733uQOeDRqGvCvM0s4w7emjdr3amRpZxcuQKMMbwblMBaBbBtPYC1PJLrOdJEjj1Yk4VVBCi6woi6fHEBKBS3DzHm/Fv21ZCGorK0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yu+VeSoO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706672143; x=1738208143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f0XKxASiWqQLt7IJY+mMMoBts6D4KCVhB8RusSPYAvY=;
  b=yu+VeSoOqRJwl9UKNTP5T97tOSGgXVMahzqiyANE7510MEav2lnwn5up
   PRLUsGUc35JcacGSCfqPeF5xf+xyMy/Wudit8OT1rbLDWq7TK6nBngVJY
   CzlnDfAYOkbxf8LTd0WCCdIz0I+ewBI9OXfsZe34qO5VFxKPcX1OTEmY/
   eLrCW5t7mnaJghiW0+B3Yx3vSHfOn1owFYXTfynX0Y0hbFcmTNdsN1W/L
   krPPVj+QUvYb52GoDaWMwH/e1A2QPyJ/TmdWKYjRRsoEeGoHWvRBZ9WUA
   a4OKyYyEE2zA7LFLra2W7AnB2s3HMsbDdleS5x+jLoCvfwmg/WLvtLXht
   Q==;
X-CSE-ConnectionGUID: nlghDPAHRPKfgwJ/dbSwLg==
X-CSE-MsgGUID: Iurwu5k6SxCsDUlGefwzgg==
X-IronPort-AV: E=Sophos;i="6.05,231,1701154800"; 
   d="scan'208";a="246268336"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2024 20:35:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 20:35:33 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 20:35:25 -0700
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
Subject: [linux][PATCH v5 0/3] Convert Microchip's HLCDC Text based DT bindings to JSON schema
Date: Wed, 31 Jan 2024 09:05:20 +0530
Message-ID: <20240131033523.577450-1-dharma.b@microchip.com>
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

As Sam suggested I'm sending the PWM binding as it is in this patch series, clean up patch
will be sent as separate patch.

Dharma Balasubiramani (3):
  dt-bindings: display: convert Atmel's HLCDC to DT schema
  dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
  dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format

 .../atmel/atmel,hlcdc-display-controller.yaml | 85 ++++++++++++++++
 .../bindings/display/atmel/hlcdc-dc.txt       | 75 --------------
 .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 99 +++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt   | 56 -----------
 .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 44 +++++++++
 .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ------
 6 files changed, 228 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

-- 
2.25.1


