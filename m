Return-Path: <linux-kernel+bounces-76891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602185FE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9107FB263DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41347153BC9;
	Thu, 22 Feb 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rk4yls/b"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F961474B6;
	Thu, 22 Feb 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620144; cv=none; b=T7DMZ05pnLEmZn262Vukqz7dEn6qpy4cuyHBMokNPUa+SgaOCLJ+3wdfaUgh4rd4qzY3H6SxkKIaGVt9FvbWV+05M1LSCJH9m2wg5DMQnadfOJHqbROEC54TDVGYHlhKao3ZVxbCuf/wq3yEBCqrXUrti4MNHpjehlrL7gnvwFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620144; c=relaxed/simple;
	bh=TlsyCxsx6t2l1kb/1VF6kn77np7doIMVXGCQWbJ2Xl4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCVtsUFtdCVWlyUIpqNL1Qc4kqMkhufziXxWxgq/4PEOtksZQNH9uqDnrt7qoL7vRyPr0ZegAag+RJow0mh2O7hPe195SR/FcB+EjrJ49c0+tlXhDfB6V1J/IH63IKy9ArMXzLTSNASpTExieFMqCnUtl7EqGyxGlQhv8ZeAH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rk4yls/b; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708620141; x=1740156141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TlsyCxsx6t2l1kb/1VF6kn77np7doIMVXGCQWbJ2Xl4=;
  b=rk4yls/byXnhC99PcxzM3AtN4pBh7csMBHI5Z6Ui2gQVw5yZ6NfBf87N
   egV4Z0vhKWqb2xq8u713BzFp7prhDoNIEFho1nFoRrIu6spxobkVD+X49
   z7WyHoSqug8HamhR3FrOdgy9NlaIR0nAS9Gnacq3EzU8pP0g3xCrzkzMr
   WOHEdLjvebIANO5Iv2QcdaoIlpeeCyWRTPOQgsihfDsk9vzRG1wF04tjd
   sTFzKSK89R+f3RzBvjFEzh/96EOVhi1WUHrR6NpvddyI8hsG6cc4kfBuQ
   bwq1lZ79jupRKPiKuacm69/GUortAv5phdmYYVHXxtQQssqUhBKZ0vvfn
   w==;
X-CSE-ConnectionGUID: OvPE6kvdT3CJBCGLPKRzYQ==
X-CSE-MsgGUID: wQakEbkGSSSHtESXrSmXTA==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="18201586"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2024 09:42:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:42:17 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 22 Feb 2024 09:42:14 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v5 0/2] adding support for Microchip PAC193X Power Monitor
Date: Thu, 22 Feb 2024 18:42:04 +0200
Message-ID: <20240222164206.65700-1-marius.cristea@microchip.com>
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

  The above statement it's a left over comment / attempt to summarize the
discussion of whether IIO or HWMON was a better home for a driver for this
device.  Based on current feature set that's not an obvious decision, but there
are other planned features that fit better in IIO.

Differences related to previous patch:
v5:
- fix review comments:
  - remove | from device tree binding (not needed because there is no
    formatting to preserve).
  - update in_shunt_resistor_X attribute to in_shunt_resistorX
  - use channel enable to reset the energy counter for each acctive channels
  - update values of IIO elements to be in naturally aligned power of 2
  - use address in the attribute (IIO_DEVICE_ATTR) to extract address field
  - update the code to use mod_delayed_work
  - change from kfree to ACPI_FREE
  - fix "0-day" issue related to double counter increment
  - check functions return in case of errors (like devm_kzalloc that could fail)
  - fix coding style issues

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
 drivers/iio/adc/Kconfig                       |   11 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1934.c                     | 1637 +++++++++++++++++
 6 files changed, 1785 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 create mode 100644 drivers/iio/adc/pac1934.c


base-commit: b1a1eaf6183697b77f7243780a25f35c7c0c8bdf
-- 
2.34.1


