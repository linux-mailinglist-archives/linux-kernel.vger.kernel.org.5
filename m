Return-Path: <linux-kernel+bounces-32566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF08835D47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13572B27977
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0313D3AF;
	Mon, 22 Jan 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PbdD3Z0z"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEF38F8F;
	Mon, 22 Jan 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913307; cv=none; b=SaRdFkMcrxF92WaJcrHOmwNEQ7NWeVwPm+iKmRg/xoP8g48VSKNxDfzhI3aH/rByTy2/kBUg/K6T1A3JSFYXtE1YTLy4obdclZs1qBedheqjErJveEdU+VplkpM7bHfEXvq/0/iXEYP1oZg0B6cQIZ3SNStKj+T06EYnWqrAyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913307; c=relaxed/simple;
	bh=WYvUJM6Lln/O7kMg7YLdb6gXjy+H8J71CclA1VdAyD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwVY7stdxYXdssnFfEbU/BrrR6Nq5nHBdKu3Byx0ZKfry1jiB4eTHfMn3mdv8+V5RdlYtFOoI1yZ8SZCS6AA3gduKvO94mCZaOEnXBh669ZT8pc7X1kc5Y/sfpkyOdHkC9DPbjXoPsVLkzJsQNKdoo9Uv62oc+/2+ytCwEbsZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PbdD3Z0z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705913305; x=1737449305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WYvUJM6Lln/O7kMg7YLdb6gXjy+H8J71CclA1VdAyD8=;
  b=PbdD3Z0zZyqZPssJ1jRGUp97yERSto0Td81xnc+CujYHf/y/4XdEruqC
   E3hX38B2sidv5Y/FtUI954CdAZYJpCB/gCvf4/ldtpLUAUrlN1Yhm6JK5
   rqp8983Hr71VEyKs8jZYygswKr4QyK53An3R6Lf9iu/Es/doHYnEdIfR7
   BpWOohAmIfHI+IK584kVAOgac6wTMbxxCuNd7m2hVT09+m2QqFDU3GTc6
   BBFNai0+fAL5tfSybnr2oa+kZxA8YkvzJ7jg7V0l3gNHr6UhL1IuL9ww6
   2JEXWghXl8Q5bD10BZPUgbZ1UTMLhKsbJ9+erZwJrkEX1ysLr1t06DU/I
   g==;
X-CSE-ConnectionGUID: 4ytLpERVSI+Hb+Gl/SsgFQ==
X-CSE-MsgGUID: Bvw4fyzxTSmyLuJ1xX4WYw==
X-IronPort-AV: E=Sophos;i="6.05,211,1701154800"; 
   d="scan'208";a="15087208"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 01:48:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 01:47:18 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Jan 2024 01:47:15 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v4 0/2] adding support for Microchip PAC193X Power Monitor
Date: Mon, 22 Jan 2024 10:47:10 +0200
Message-ID: <20240122084712.11507-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip PAC193X series of Power Monitor with
Accumulator chip family. This driver covers the following part numbers:
 - PAC1931, PAC1932, PAC1933 and PAC1934

  This device is at the boundary between IIO and HWMON (if you are
looking just at the "shunt resistors, vsense, power, energy"). The
device also has ADC internally that can measure voltages (up to 4
channels) and also currents (up to 4 channels). The current is measured as
voltage across the shunt_resistor.

  I have started with a simple driver (this one that is more appropriate to be
a HWMON) and willing to add more functionality later (like data buffering that
is quite important for example if someone wants to profile power consumption
of the processor itself, or a peripheral device, or a battery, this kind of
functionality was requested by our customers).


Differences related to previous patch:
v4:
  - remove the "reset_accumulators" proprietary attribute
  - add enable/disable for energy channels
  - remove "reset_accumulators" attribute
  - remove unused/redundant defines
  - rename variable to be more relevant into a certain context
  - make "storagebits" naturally aligned power of 2
  - fix coding style issues
  - use to_iio_dev_attr to access address field in the IIO_DEVICE_ATTR()
  - remove unnecesarry "break" from switch case
  - remove double increment and initialization of a variable
  - use address as index in IIO_DEVICE_ATTR
  - properly handle memory allocation failure

v3:
- this version was sent also to HWMON list
- fix review comments:
  - drop redundant description from device tree bindings
  - reorder "patternProperties:" to follow "properties:" in device tree bindings
  - update comments to proper describe code
  - use numbers instead of defines for clarity in some part of the code
  - use the new "guard(mutex)"
  - use "clamp()" instead of duplicating code
  - remove extra layer of checking in some switch cases
  - use "i2c_get_match_data()"
  - replace while with for loops for the code to look cleaner
  - reverse the logic to reduce indent.
  - add comment related to channels numbering
  - remove memory duplicate when creating dynamic channels
  - add "devm_add_action_or_reset" to handle the "cancel_delayed_work_sync"
  - remove "pac1934_remove()" function

v2:
- fix review comments:
  - change the device tree bindings
  - use label property
  - fix coding style issues
  - remove unused headers
  - use get_unaligned_bexx instead of own functions
  - change to use a system work queue
  - use probe_new instead of old probe

v1:
- first version committed to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding support for PAC193X
  iio: adc: adding support for PAC193x

 .../ABI/testing/sysfs-bus-iio-adc-pac1934     |    9 +
 .../bindings/iio/adc/microchip,pac1934.yaml   |  120 ++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1934.c                     | 1646 +++++++++++++++++
 6 files changed, 1795 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 create mode 100644 drivers/iio/adc/pac1934.c


base-commit: b1a1eaf6183697b77f7243780a25f35c7c0c8bdf
-- 
2.34.1


