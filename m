Return-Path: <linux-kernel+bounces-128007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A456D8954DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB82FB29396
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A998405D;
	Tue,  2 Apr 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxtSwyqt"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4560DE9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063437; cv=none; b=lTkN+FXRc0iStVZMUGEVTwzvU7TgmI7BZFKQpmQmDh644aoMjH80YrY4iUdKK4WVtZQTpQHT3XMWYOVjsjhK9vNr9fA86YTlgfLu9FigOTquP/k0OUOEIb2MjuVdVN2mB+KwtRIQ3O8a8R45ri/eVUQBTf+OjQpUUCBt+Vl0uGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063437; c=relaxed/simple;
	bh=AsoO3Q/5/GcA6xDfgqJ3Pg9jEa0S8mhiR9JMj/ZcOiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyTNuIjrlOrMHN+/I/TAEtu3VDpBu89quOSsigEe64+6pT3bm5YHqEcUe84F8zJn+mBlhu+3+1mr68C4Ual9jd2a6iPwSNeQ5HakUhbcG8RKR+CzxIXArjuHcXCdtKqvtbPDZJxYBYd5R5NFkyiGQ+UIzWq9D59s1uoH1x+dKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxtSwyqt; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d718efedb2so73351641fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063430; x=1712668230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTD9f3oZUTixky53Gli16BnkyGnD74OBOaVgbJjKeeA=;
        b=QxtSwyqtskMC6r3C1wqGNmxzVwQRdxKCe4Y0pcHnNwL8TXfb8bj0QUBzCzQRrcXKGh
         lLavyJdgdrEXwQ4sDuSR8Da9hyyWRGaqvoRm1+x33NsevGDtIXrjpPvInrzRCPILrCW0
         KUitFlYaTvgKSqFNiX9ek9p2VB7NPZFOS+mBRRdByvK7s+7TyfGzQmeh0blD+p0cX1AF
         z8lTJVjtEjm6CQ+FaGrQrQwl8Tb5w3BSKDHH1kNYoBio+XwRVHdkGCmwcNTQoWEtypI0
         aptIZLL24n3tW8B0VgB7D/T21m1J1VfMmS8t7QSpZ28r7btZfLAIKlzVd7yiPRpBYOJL
         pW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063430; x=1712668230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTD9f3oZUTixky53Gli16BnkyGnD74OBOaVgbJjKeeA=;
        b=Wy14Q70kTzkBbA0GBdPpOYG6jrSZVk+RrGWwlgAL08Mv5ji5ayqF9R3om+IYsb5Uly
         Hsl1BNjFZzhZgKS2iZIDdAJnzGHeUe7X2uZRWsg0I2yBYkYOXCs036Gbjimph9cqWIqc
         zA3qQ2t+tIntSUzZhv/h/EZefaFoLltsO8m80mwH4WCBLkZ0VOYjecELfSvvRAHMxaM2
         YRwX/7kHvTaWo/g7w+myXaFBjaGuNzAQLX21t00to1in/ZitJymjfjf3j+vt4E8Vcvvn
         +5+F9RkzlJoxmU+xgpALDBNYy4BGMj2E3ZGerowVJhTN+E0/Ey+cJrRg2/Rhz9KLQ3hW
         fEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/ae2SgtomCA1GjIu4fM8B1ambiA3an245+hJ4C/FtIOhkXmEAZo9VW9JsSprU80eIxh7l7UxeMlLGdnCzr1JNgmS0nUxd7vg39h3U
X-Gm-Message-State: AOJu0YzTrYkGAo5xNZpuEBgcsLAdbNJvY+a/Joju86Gg28mGTpvVbUYK
	2Y9CD9oV+WSNEYxoliRKipCpUGS7+cYCWSmNLInEYwIql76SP37E
X-Google-Smtp-Source: AGHT+IGtEoXbV0W1F9JKLZZAbufacFR7177b2VNcDLk0UOQlHALVKg4RMZI5h/QeBSKfUJj5VxpaDA==
X-Received: by 2002:a2e:7207:0:b0:2d6:8e88:5a8b with SMTP id n7-20020a2e7207000000b002d68e885a8bmr1418818ljc.32.1712063429664;
        Tue, 02 Apr 2024 06:10:29 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05651c230b00b002d6daf3b41fsm1602632ljb.101.2024.04.02.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:10:27 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:10:23 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] regulator: bd96801: ROHM BD96801 PMIC regulators
Message-ID: <3a6839e2663bd064100af41f6df0cace746cf2e4.1712058690.git.mazziesaccount@gmail.com>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MB0BEC6uYYfm70NP"
Content-Disposition: inline
In-Reply-To: <cover.1712058690.git.mazziesaccount@gmail.com>


--MB0BEC6uYYfm70NP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96801 "Scalable PMIC" is an automotive grade PMIC which can
scale to different applications by allowing chaining of PMICs. The PMIC
also supports various protection features which can be configured either
to fire IRQs - or to shut down power outputs when failure is detected.

The driver supports the basic control of BUCKs and LDOs and configuring
Over/Under-voltage, over-current, over-temperature protections via
device-tree. Following constrains are worth noting:

The voltages can be enabled/disabled and protections configured only
when the PMIC is in STANDBY state.

The protections can't be disabled. UVP limit can't be configured.
OVP and OCP limits can be configured.

OVD and UVD for a regulator have common limit.
OCP and thermal protections are implemented by turning all INTB
notifications fatal. This means that OVD/UVD can not be used together
with OCP and thermal protection.

Thermal limits can't be configured. TSD is fixed to 175 Celsius, and
thermal warning is fixed close to 140 Celsius.

LDO's do not have own temperature monitor. The LDO limits use PMIC
core temperature.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Note. This patch implements controls which can only be done when the
BD96801 PMIC is in a 'standby' state. These controls include the
protection settings and 'initial' voltage settings.

The PMIC has a STBY pin which is used to control the PMIC power-state.

I don't have visibility to the design process or to most of the customer
use cases - so following is speculation:
 - Original idea seems to have been that, when the PMIC goes to STBY
   state, controlling processor will be powered-off. In the original DS1
   version all power outputs from the PMIC were turned off when PMIC
   entered STBY.
 - Someone somewhere needed to be able to keep the controlling processor
   and some peripherials powered on when the PMIC is in STBY. A very
   potential reason is to be able to do the initial voltage / protection
   configurations by software. A configuration option to keep desired
   power outputs enabled when PMIC is in STBY was added.
 - Current PMIC state can be read from the PMIC registers.

Obvious(?) dilemma for these 'STBY only' configurations is that it is
difficult to design generic way for the PMIC driver to synchronize the
configurations with the state changes. Designing it would at least require
knowledge on:
 - What is the PMIC STBY-state used for? Is it intended to be a
   power-off (or other low-power) state for the system? Or, is it
   intended to be used just a state where some of the configurations are
   done?
 - How is the hardware designed to control the STBY pin?

We *could* assume the STBY pin is controlled by a GPIO. We could grab
the GPIO here, and export functions to toggle the STBY state. We could
then 'lock' the state for the duration of config changes. But problem
is, I don't know what is the right thing to do.

So, this version of the patch just checks the PMIC state - and attempts
to write the configs if PMIC is in STBY state. This is racy unless the
entity controlling the STBY-pin is somehow (external to this driver)
synchronized. We could send a notification when configurations are
completed to help building such synchronization but this is not done as
I don't have a real-world user for it.

I am unsure if these 'STBY-only' controls should be just dropped, or if
they should be kept here to serve as an example / basis to build on. If
they are removed, it will be very hard for anyone using this PMIC to
implement those controls. OTOH, if they are kept here, it may
potentially encourage 'works on my machine' designs - although, I
believe that those who really need to do 'STBY-only' configs at run-time
will find a way to toggle the STBY-pin in a way that is synchronized
with the configs here.
---
 drivers/regulator/Kconfig             |   12 +
 drivers/regulator/Makefile            |    2 +
 drivers/regulator/bd96801-regulator.c | 2109 +++++++++++++++++++++++++
 3 files changed, 2123 insertions(+)
 create mode 100644 drivers/regulator/bd96801-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7db0a29b5b8d..2e8187a92952 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -268,6 +268,18 @@ config REGULATOR_BD957XMUF
 	  This driver can also be built as a module. If so, the module
 	  will be called bd9576-regulator.
=20
+config REGULATOR_BD96801
+	tristate "ROHM BD96801 Power Regulator"
+	depends on MFD_ROHM_BD96801
+	select REGULATOR_ROHM
+	help
+	  This driver supports voltage regulators on ROHM BD96801 PMIC.
+	  This will enable support for the software controllable buck
+	  and LDO regulators.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called bd96801-regulator.
+
 config REGULATOR_CPCAP
 	tristate "Motorola CPCAP regulator"
 	depends on MFD_CPCAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 46fb569e6be8..ae8896e879d5 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -37,6 +37,8 @@ obj-$(CONFIG_REGULATOR_BD718XX) +=3D bd718x7-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) +=3D bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_BD957XMUF) +=3D bd9576-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+=3D da903x-regulator.o
+obj-$(CONFIG_REGULATOR_BD96801) +=3D bd96801-regulator.o
+obj-$(CONFIG_REGULATOR_DA903X)	+=3D da903x.o
 obj-$(CONFIG_REGULATOR_DA9052)	+=3D da9052-regulator.o
 obj-$(CONFIG_REGULATOR_DA9055)	+=3D da9055-regulator.o
 obj-$(CONFIG_REGULATOR_DA9062)	+=3D da9062-regulator.o
diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
new file mode 100644
index 000000000000..d66fefc06308
--- /dev/null
+++ b/drivers/regulator/bd96801-regulator.c
@@ -0,0 +1,2109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 ROHM Semiconductors
+// bd96801-regulator.c ROHM BD96801 regulator driver
+
+/*
+ * The DS2 sample does not allow controlling much of anything besides the =
BUCK
+ * voltage tune value unless the PMIC is in STANDBY. This means the usual =
case
+ * where PMIC is controlled using processor which is powered by the PMIC d=
oes
+ * not allow much of control. Eg, enable/disable status or protection limi=
ts
+ * can't be set.
+ *
+ * It is however possible that the PMIC is controlled (at least partially)=
 from
+ * some supervisor processor which stays alive even when PMIC goes to STAN=
DBY.
+ *
+ * This calls for following actions:
+ *  - add STANDBY check also to protection setting.
+ *  - consider whether the ERRB IRQ would be worth handling
+ *
+ * Right. The demand for keeping processor alive when PMIC is configured h=
as
+ * emerged. The DS3 solves problem by allowing SW to specify power-rails w=
hich
+ * are kept powered when the PMIC goes to STANDBY. Eg, SW can (at least in
+ * theory)
+ *
+ * - Configure critical power-rails to be enabled at STANDBY
+ * - Switch PMIC to STANDBY mode
+ * - Perform the configuration
+ * - Turn the PMIC back to the ACTIVE mode.
+ *
+ * Toggling the STANDBY mode from a regulator driver does definitely not s=
ound like
+ * "the right thing to do". That should probably be initiated by early boot
+ * - or if it is required at later stage, then maybe by a consumer driver /
+ *   user-space application.
+ *
+ * Still, if STANDBY-only configuratins are needed then someone should ens=
ure
+ * the STBY request line stays asserted until all the necessary configurat=
ions
+ * are done. Using an evaluation board this can be done toggling a swicth
+ * manually - but for any real use-case we would need a SW control for thi=
s.
+ * This driver does not in any way ensure the PMIC stays in STANDBY. It on=
ly
+ * checks if PMIC is in STANDBY when some configuration is started - and w=
arns
+ * if the state is not correct.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/linear_range.h>
+#include <linux/mfd/rohm-generic.h>
+#include <linux/mfd/rohm-bd96801.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/coupler.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+
+enum {
+	BD96801_BUCK1,
+	BD96801_BUCK2,
+	BD96801_BUCK3,
+	BD96801_BUCK4,
+	BD96801_LDO5,
+	BD96801_LDO6,
+	BD96801_LDO7,
+	BD96801_REGULATOR_AMOUNT,
+};
+
+enum {
+	BD96801_PROT_OVP,
+	BD96801_PROT_UVP,
+	BD96801_PROT_OCP,
+	BD96801_PROT_TEMP,
+	BD96801_NUM_PROT,
+};
+
+#define BD96801_ALWAYS_ON_REG		0x3c
+#define BD96801_REG_ENABLE		0x0b
+#define BD96801_BUCK1_EN_MASK		BIT(0)
+#define BD96801_BUCK2_EN_MASK		BIT(1)
+#define BD96801_BUCK3_EN_MASK		BIT(2)
+#define BD96801_BUCK4_EN_MASK		BIT(3)
+#define BD96801_LDO5_EN_MASK		BIT(4)
+#define BD96801_LDO6_EN_MASK		BIT(5)
+#define BD96801_LDO7_EN_MASK		BIT(6)
+
+#define BD96801_BUCK1_VSEL_REG		0x28
+#define BD96801_BUCK2_VSEL_REG		0x29
+#define BD96801_BUCK3_VSEL_REG		0x2a
+#define BD96801_BUCK4_VSEL_REG		0x2b
+#define BD96801_LDO5_VSEL_REG		0x25
+#define BD96801_LDO6_VSEL_REG		0x26
+#define BD96801_LDO7_VSEL_REG		0x27
+#define BD96801_BUCK_VSEL_MASK		0x1F
+#define BD96801_LDO_VSEL_MASK		0xff
+
+#define BD96801_LOCK_REG		0x04
+#define BD96801_UNLOCK			0x9d
+#define BD96801_LOCK			0x00
+
+#define BD96801_MASK_RAMP_DELAY		0xc0
+#define BD96801_INT_VOUT_BASE_REG	0x21
+#define BD96801_BUCK_INT_VOUT_MASK	0xff
+
+#define BD96801_BUCK_VOLTS		256
+#define BD96801_LDO_VOLTS		256
+
+#define BD96801_OVP_MASK		0x03
+#define BD96801_MASK_BUCK1_OVP_SHIFT	0x00
+#define BD96801_MASK_BUCK2_OVP_SHIFT	0x02
+#define BD96801_MASK_BUCK3_OVP_SHIFT	0x04
+#define BD96801_MASK_BUCK4_OVP_SHIFT	0x06
+#define BD96801_MASK_LDO5_OVP_SHIFT	0x00
+#define BD96801_MASK_LDO6_OVP_SHIFT	0x02
+#define BD96801_MASK_LDO7_OVP_SHIFT	0x04
+
+#define BD96801_PROT_LIMIT_OCP_MIN	0x00
+#define BD96801_PROT_LIMIT_LOW		0x01
+#define BD96801_PROT_LIMIT_MID		0x02
+#define BD96801_PROT_LIMIT_HI		0x03
+
+#define BD96801_REG_BUCK1_OCP		0x32
+#define BD96801_REG_BUCK2_OCP		0x32
+#define BD96801_REG_BUCK3_OCP		0x33
+#define BD96801_REG_BUCK4_OCP		0x33
+
+#define BD96801_MASK_BUCK1_OCP_SHIFT	0x00
+#define BD96801_MASK_BUCK2_OCP_SHIFT	0x04
+#define BD96801_MASK_BUCK3_OCP_SHIFT	0x00
+#define BD96801_MASK_BUCK4_OCP_SHIFT	0x04
+
+#define BD96801_REG_LDO5_OCP		0x34
+#define BD96801_REG_LDO6_OCP		0x34
+#define BD96801_REG_LDO7_OCP		0x34
+
+#define BD96801_MASK_LDO5_OCP_SHIFT	0x00
+#define BD96801_MASK_LDO6_OCP_SHIFT	0x02
+#define BD96801_MASK_LDO7_OCP_SHIFT	0x04
+
+#define BD96801_MASK_SHD_INTB		BIT(7)
+#define BD96801_INTB_FATAL		BIT(7)
+
+#define BD96801_NUM_REGULATORS		7
+#define BD96801_NUM_LDOS		4
+
+/*
+ * Ramp rates for bucks are controlled by bits [7:6] as follows:
+ * 00 =3D> 1 mV/uS
+ * 01 =3D> 5 mV/uS
+ * 10 =3D> 10 mV/uS
+ * 11 =3D> 20 mV/uS
+ */
+static const unsigned int buck_ramp_table[] =3D { 1000, 5000, 10000, 20000=
 };
+
+/*
+ * This is a voltage range that get's appended to selected
+ * bd96801_buck_init_volts value. The range from 0x0 to 0xF is actually
+ * bd96801_buck_init_volts + 0 ... bd96801_buck_init_volts + 150mV
+ * and the range from 0x10 to 0x1f is bd96801_buck_init_volts - 150mV ...
+ * bd96801_buck_init_volts - 0. But as the members of linear_range
+ * are all unsigned I will apply offset of -150 mV to value in
+ * linear_range - which should increase these ranges with
+ * 150 mV getting all the values to >=3D 0.
+ */
+static const struct linear_range bd96801_tune_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(150000, 0x00, 0xF, 10000),
+	REGULATOR_LINEAR_RANGE(0, 0x10, 0x1F, 10000),
+};
+
+static const struct linear_range bd96801_buck_init_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(500000 - 150000, 0x00, 0xc8, 5000),
+	REGULATOR_LINEAR_RANGE(1550000 - 150000, 0xc9, 0xec, 50000),
+	REGULATOR_LINEAR_RANGE(3300000 - 150000, 0xed, 0xff, 0),
+};
+
+static const struct linear_range bd96801_ldo_int_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(300000, 0x00, 0x78, 25000),
+	REGULATOR_LINEAR_RANGE(3300000, 0x79, 0xff, 0),
+};
+
+#define BD96801_LDO_SD_VOLT_MASK	0x1
+#define BD96801_LDO_MODE_MASK		0x6
+#define BD96801_LDO_MODE_INT		0x0
+#define BD96801_LDO_MODE_SD		0x2
+#define BD96801_LDO_MODE_DDR		0x4
+
+static int ldo_ddr_volt_table[] =3D {500000, 300000};
+static int ldo_sd_volt_table[] =3D {3300000, 1800000};
+
+/* Constant IRQ initialization data (templates) */
+struct bd96801_irqinfo {
+	int type;
+	struct regulator_irq_desc irq_desc;
+	int err_cfg;
+	int wrn_cfg;
+	const char *irq_name;
+};
+
+#define BD96801_IRQINFO(_type, _name, _irqoff_ms, _irqname)	\
+{								\
+	.type =3D (_type),					\
+	.err_cfg =3D -1,						\
+	.wrn_cfg =3D -1,						\
+	.irq_name =3D (_irqname),					\
+	.irq_desc =3D {						\
+		.name =3D (_name),				\
+		.irq_off_ms =3D (_irqoff_ms),			\
+		.map_event =3D regulator_irq_map_event_simple,	\
+	},							\
+}
+
+static const struct bd96801_irqinfo buck1_irqinfo[] =3D {
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck1-over-curr-h", 500,
+			"bd96801-buck1-overcurr-h"),
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck1-over-curr-l", 500,
+			"bd96801-buck1-overcurr-l"),
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck1-over-curr-n", 500,
+			"bd96801-buck1-overcurr-n"),
+	BD96801_IRQINFO(BD96801_PROT_OVP, "buck1-over-voltage", 500,
+			"bd96801-buck1-overvolt"),
+	BD96801_IRQINFO(BD96801_PROT_UVP, "buck1-under-voltage", 500,
+			"bd96801-buck1-undervolt"),
+	BD96801_IRQINFO(BD96801_PROT_TEMP, "buck1-over-temp", 500,
+			"bd96801-buck1-thermal")
+};
+
+static const struct bd96801_irqinfo buck2_irqinfo[] =3D {
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck2-over-curr-h", 500,
+			"bd96801-buck2-overcurr-h"),
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck2-over-curr-l", 500,
+			"bd96801-buck2-overcurr-l"),
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck2-over-curr-n", 500,
+			"bd96801-buck2-overcurr-n"),
+	BD96801_IRQINFO(BD96801_PROT_OVP, "buck2-over-voltage", 500,
+			"bd96801-buck2-overvolt"),
+	BD96801_IRQINFO(BD96801_PROT_UVP, "buck2-under-voltage", 500,
+			"bd96801-buck2-undervolt"),
+	BD96801_IRQINFO(BD96801_PROT_TEMP, "buck2-over-temp", 500,
+			"bd96801-buck2-thermal")
+};
+
+static const struct bd96801_irqinfo buck3_irqinfo[] =3D {
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck3-over-curr-h", 500,
+			"bd96801-buck3-overcurr-h"),
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck3-over-curr-l", 500,
+			"bd96801-buck3-overcurr-l"),
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck3-over-curr-n", 500,
+			"bd96801-buck3-overcurr-n"),
+	BD96801_IRQINFO(BD96801_PROT_OVP, "buck3-over-voltage", 500,
+			"bd96801-buck3-overvolt"),
+	BD96801_IRQINFO(BD96801_PROT_UVP, "buck3-under-voltage", 500,
+			"bd96801-buck3-undervolt"),
+	BD96801_IRQINFO(BD96801_PROT_TEMP, "buck3-over-temp", 500,
+			"bd96801-buck3-thermal")
+};
+
+static const struct bd96801_irqinfo buck4_irqinfo[] =3D {
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck4-over-curr-h", 500,
+			"bd96801-buck4-overcurr-h"),
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck4-over-curr-l", 500,
+			"bd96801-buck4-overcurr-l"),
+	BD96801_IRQINFO(BD96801_PROT_OCP, "buck4-over-curr-n", 500,
+			"bd96801-buck4-overcurr-n"),
+	BD96801_IRQINFO(BD96801_PROT_OVP, "buck4-over-voltage", 500,
+			"bd96801-buck4-overvolt"),
+	BD96801_IRQINFO(BD96801_PROT_UVP, "buck4-under-voltage", 500,
+			"bd96801-buck4-undervolt"),
+	BD96801_IRQINFO(BD96801_PROT_TEMP, "buck4-over-temp", 500,
+			"bd96801-buck4-thermal")
+};
+
+static const struct bd96801_irqinfo ldo5_irqinfo[] =3D {
+	BD96801_IRQINFO(BD96801_PROT_OCP, "ldo5-overcurr", 500,
+			"bd96801-ldo5-overcurr"),
+	BD96801_IRQINFO(BD96801_PROT_OVP, "ldo5-over-voltage", 500,
+			"bd96801-ldo5-overvolt"),
+	BD96801_IRQINFO(BD96801_PROT_UVP, "ldo5-under-voltage", 500,
+			"bd96801-ldo5-undervolt"),
+};
+
+static const struct bd96801_irqinfo ldo6_irqinfo[] =3D {
+	BD96801_IRQINFO(BD96801_PROT_OCP, "ldo6-overcurr", 500,
+			"bd96801-ldo6-overcurr"),
+	BD96801_IRQINFO(BD96801_PROT_OVP, "ldo6-over-voltage", 500,
+			"bd96801-ldo6-overvolt"),
+	BD96801_IRQINFO(BD96801_PROT_UVP, "ldo6-under-voltage", 500,
+			"bd96801-ldo6-undervolt"),
+};
+
+static const struct bd96801_irqinfo ldo7_irqinfo[] =3D {
+	BD96801_IRQINFO(BD96801_PROT_OCP, "ldo7-overcurr", 500,
+			"bd96801-ldo7-overcurr"),
+	BD96801_IRQINFO(BD96801_PROT_OVP, "ldo7-over-voltage", 500,
+			"bd96801-ldo7-overvolt"),
+	BD96801_IRQINFO(BD96801_PROT_UVP, "ldo7-under-voltage", 500,
+			"bd96801-ldo7-undervolt"),
+};
+
+struct bd96801_irq_desc {
+	struct bd96801_irqinfo *irqinfo;
+	int num_irqs;
+};
+
+struct bd96801_regulator_data {
+	struct regulator_desc desc;
+	const struct linear_range *init_ranges;
+	int num_ranges;
+	struct bd96801_irq_desc irq_desc;
+	int initial_voltage;
+	int ldo_vol_lvl;
+	/* OCP tables are fixed size - four values */
+	const int *ocp_table;
+	u8 prot_reg_shift;
+	u8 ocp_shift;
+	u8 ovp_reg;
+	u8 ovd_reg;
+	u8 ocp_reg;
+	int ldo_errs;
+};
+
+struct bd96801_pmic_data {
+	struct bd96801_regulator_data regulator_data[BD96801_NUM_REGULATORS];
+	struct regmap *regmap;
+	int fatal_ind;
+};
+
+/*
+ * Return 0 if limit should be set.
+ * Return 1 if limit should not be set but we want to proceed with regulat=
or
+ * registration.
+ * Return other error to propagate issues to regulator framework.
+ */
+static int sanity_check_ovd_uvd(struct device *dev, struct bd96801_irqinfo=
 *new,
+				struct bd96801_irqinfo *old, int lim_uV,
+				int severity, bool enable)
+{
+	int old_err =3D 0, old_wrn =3D 0;
+	int *cfg;
+
+	if (!new) {
+		dev_warn(dev, "No protection IRQ\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (severity =3D=3D REGULATOR_SEVERITY_ERR)
+		cfg =3D &new->err_cfg;
+	else
+		cfg =3D &new->wrn_cfg;
+
+
+	if (!enable) {
+		*cfg =3D 0;
+
+		return 1;
+	}
+
+	/* Don't allow overriding ERR with WRN */
+	if (severity =3D=3D REGULATOR_SEVERITY_WARN && new->err_cfg &&
+	    new->err_cfg !=3D -1) {
+		dev_warn(dev, "Both WARNING and ERROR limits given.\n");
+		return 1;
+	}
+
+	/*
+	 * BD96801 has common limit for OVD and UVD.
+	 * See that there is no existing settings
+	 * conflicting. Warn if there is.
+	 */
+	if (old) {
+		if (old->err_cfg && old->err_cfg !=3D -1 && old->err_cfg !=3D 1)
+			old_err =3D old->err_cfg;
+		if (old->wrn_cfg && old->wrn_cfg !=3D -1 && old->wrn_cfg !=3D 1)
+			old_wrn =3D old->wrn_cfg;
+
+		if (lim_uV && ((old_err && (old_err !=3D lim_uV)) ||
+		    (old_wrn && (old_wrn !=3D lim_uV)))) {
+			dev_warn(dev, "conflicting OVD and UVD limits given\n");
+			/*
+			 * If both OVD and UVD is configured, do not
+			 * override ERR by WARN and don't increase already set
+			 * limit.
+			 */
+			if (severity =3D=3D REGULATOR_SEVERITY_WARN) {
+				if (old_err || (old_wrn && old_wrn < lim_uV))
+					return -1;
+			} else {
+				/*
+				 * We prefer ERROR over WARNING even though it
+				 * is likely to relax the limit.
+				 */
+				if (old_wrn && old_wrn < lim_uV)
+					dev_warn(dev,
+						 "Increasing warning limit\n");
+
+				/*
+				 * If for some reason the existing warning has
+				 * strictier limit than our error - then we will
+				 * just disable the warning to prevent it being
+				 * errorneously sent. We won't leave warning
+				 * and not send errors as we expect the errors
+				 * to be much more severe.
+				 */
+				if (old_wrn && old_wrn > lim_uV) {
+					dev_warn(dev,
+						 "Disabling conflicting warning\n");
+					old->wrn_cfg =3D 0;
+				}
+
+				if (old_err && old_err < lim_uV) {
+					dev_warn(dev, "Leaving old limit %u\n",
+						 old_err);
+
+					return -1;
+				}
+				dev_warn(dev, "Using new limit %u\n", lim_uV);
+			}
+		}
+	}
+
+	if (lim_uV)
+		*cfg =3D lim_uV;
+	else
+		*cfg =3D 1;
+
+	/*
+	 * The BD96801 has only one OVD IRQ. We can either use it for
+	 * warning or for error - not for both
+	 */
+	if (new->err_cfg && new->wrn_cfg) {
+		dev_warn(dev,
+			 "Both WARN and ERROR limit given. Discarding WARN\n");
+		new->wrn_cfg =3D 0;
+	}
+
+	return 0;
+}
+
+static int set_ovp_limit(struct regulator_dev *rdev, int lim_uV)
+{
+	int voltage, lim, set_uv, shift;
+	struct bd96801_regulator_data *rdata;
+	struct bd96801_pmic_data *pdata;
+	struct device *dev;
+
+	dev =3D rdev_get_dev(rdev);
+	rdata =3D container_of(rdev->desc, struct bd96801_regulator_data, desc);
+	pdata =3D rdev_get_drvdata(rdev);
+
+	/*
+	 * OVP can be configured to be 9%, 15% or 20% of the set voltage.
+	 *
+	 * Let's compute the OVP based on the current INT_VOUT + Vtune here.
+	 *
+	 * This is not 100% according to the spec as the (absolute) limit
+	 * value in HW will vary depending on the set voltage.
+	 *
+	 * We could store the desired limit and re-compute the proportional
+	 * OVP/UVP values when regulator voltage is adjusted. If we're getting
+	 * out of the spec we could then change the setting of limits to ensure
+	 * we stay below the absolute limit value given from DT.
+	 *
+	 * My initial guess on the use-cases is that the INT_VOUT is only set
+	 * at boot - and the impact of Vtune is so small we can ignore the
+	 * potenrial limit error for now. Let's fix this only if we see actual
+	 * problems.
+	 */
+	voltage =3D regulator_get_voltage_rdev(rdev);
+	if (voltage < 0)
+		return voltage;
+
+	set_uv =3D voltage * 9 / 100;
+
+	if (set_uv > lim_uV) {
+		dev_err(dev, "too small OVP limit %d\n",
+			lim_uV);
+		lim =3D BD96801_PROT_LIMIT_LOW;
+	} else if (voltage * 15 / 100 > lim_uV) {
+		lim =3D BD96801_PROT_LIMIT_LOW;
+	} else if (voltage * 20 / 9 > lim_uV) {
+		set_uv =3D voltage * 15 / 100;
+		lim =3D BD96801_PROT_LIMIT_MID;
+	} else {
+		set_uv =3D voltage * 20 / 100;
+		lim =3D BD96801_PROT_LIMIT_HI;
+	}
+	dev_info(dev,
+		 "OVP limit %u requested. Setting %u\n",
+			 lim_uV, set_uv);
+
+	shift =3D rdata->prot_reg_shift;
+
+	return regmap_update_bits(pdata->regmap, rdata->ovp_reg,
+				  BD96801_OVP_MASK << shift,
+				  lim << shift);
+}
+
+/*
+ * Supported detection limits for BUCKs are absolute values, 9mV, 15mV and
+ * 20mV. The limits for LDOs depend on initial voltage register value. Sca=
le
+ * limit to what is supported by HW.
+ */
+static int get_xvd_limits(struct regulator_dev *rdev, int *lim_uV, int *re=
g)
+{
+	int ret, regu_xvd_limits[3] =3D { 9000, 15000, 20000 };
+	struct bd96801_regulator_data *rdata;
+	struct bd96801_pmic_data *pdata;
+	struct device *dev;
+
+	dev =3D rdev_get_dev(rdev);
+	rdata =3D container_of(rdev->desc, struct bd96801_regulator_data, desc);
+	pdata =3D rdev_get_drvdata(rdev);
+
+	dev_dbg(dev, "OVD limit %u requested\n", *lim_uV);
+
+	if (rdata->ldo_vol_lvl) {
+		int val;
+
+		ret =3D regmap_read(pdata->regmap, rdata->ldo_vol_lvl, &val);
+		if (ret)
+			return ret;
+
+		if (val > 15) {
+			if (val < 38) {
+				regu_xvd_limits[0] =3D 16000;
+				regu_xvd_limits[1] =3D 30000;
+				regu_xvd_limits[2] =3D 40000;
+			} else {
+				regu_xvd_limits[0] =3D 36000;
+				regu_xvd_limits[1] =3D 60000;
+				regu_xvd_limits[2] =3D 80000;
+			}
+		}
+	}
+	/*  LDO's have different limits */
+	if (*lim_uV < regu_xvd_limits[0]) {
+		dev_warn(dev, "Unsupported UVD limit %d\n",
+			       *lim_uV);
+		*lim_uV =3D regu_xvd_limits[0];
+		*reg =3D BD96801_PROT_LIMIT_LOW;
+	} else if (*lim_uV < regu_xvd_limits[1]) {
+		*lim_uV =3D regu_xvd_limits[0];
+		*reg =3D BD96801_PROT_LIMIT_LOW;
+	} else if (*lim_uV < regu_xvd_limits[2]) {
+		*lim_uV =3D regu_xvd_limits[1];
+		*reg =3D BD96801_PROT_LIMIT_MID;
+	} else {
+		*lim_uV =3D regu_xvd_limits[1];
+		*reg =3D BD96801_PROT_LIMIT_HI;
+	}
+	dev_info(dev, "Using UVD limit %u\n", *lim_uV);
+
+	return 0;
+}
+
+static inline int bd96801_in_stby(struct regmap *rmap)
+{
+	int ret, val;
+
+	ret =3D regmap_read(rmap, BD96801_REG_PMIC_STATE, &val);
+	if (ret)
+		return ret;
+
+	return (val =3D=3D BD96801_STATE_STBY);
+}
+
+static int bd96801_set_ovp(struct regulator_dev *rdev, int lim_uV, int sev=
erity,
+			   bool enable)
+{
+	int shift, stby;
+	struct bd96801_pmic_data *pdata;
+	struct bd96801_regulator_data *rdata;
+	struct bd96801_irq_desc *idesc;
+	struct device *dev;
+	struct bd96801_irqinfo *ovp_iinfo =3D NULL;
+	struct bd96801_irqinfo *uvp_iinfo =3D NULL;
+	int reg;
+	int ret;
+	int i;
+
+	dev =3D rdev_get_dev(rdev);
+	rdata =3D container_of(rdev->desc, struct bd96801_regulator_data, desc);
+	pdata =3D rdev_get_drvdata(rdev);
+	idesc =3D &rdata->irq_desc;
+
+	if (!idesc)
+		return -EOPNOTSUPP;
+
+	stby =3D bd96801_in_stby(rdev->regmap);
+	if (stby < 0)
+		return stby;
+	if (!stby)
+		dev_warn(dev, "Can't set OVP. PMIC not in STANDBY\n");
+
+	if (severity =3D=3D REGULATOR_SEVERITY_PROT) {
+		if (!enable) {
+			dev_err(dev, "Can't disable over voltage protection\n");
+			return -EOPNOTSUPP;
+		}
+		if (!lim_uV)
+			return 0;
+
+		return set_ovp_limit(rdev, lim_uV);
+	}
+
+	/* See the comment at bd96801_set_uvp() below */
+	if (enable && pdata->fatal_ind =3D=3D 1) {
+		dev_err(dev,
+			"All errors are fatal. Can't provide notifications\n");
+		if (severity =3D=3D REGULATOR_SEVERITY_WARN)
+			return -EINVAL;
+	}
+
+	if (lim_uV) {
+		ret =3D get_xvd_limits(rdev, &lim_uV, &reg);
+		if (ret)
+			return ret;
+	}
+	for (i =3D 0; i < idesc->num_irqs; i++) {
+		struct bd96801_irqinfo *iinfo =3D &idesc->irqinfo[i];
+
+		if (iinfo->type =3D=3D BD96801_PROT_OVP)
+			ovp_iinfo =3D iinfo;
+
+		if (iinfo->type =3D=3D BD96801_PROT_UVP)
+			uvp_iinfo =3D iinfo;
+	}
+
+	ret =3D sanity_check_ovd_uvd(dev, ovp_iinfo, uvp_iinfo, lim_uV,
+				   severity, enable);
+
+	if (ret) {
+		if (ret =3D=3D 1)
+			return 0;
+		return ret;
+	}
+
+	shift =3D rdata->prot_reg_shift;
+
+	if (enable && lim_uV)
+		return regmap_update_bits(pdata->regmap, rdata->ovd_reg,
+					  BD96801_OVP_MASK << shift,
+					  reg << shift);
+	return 0;
+}
+
+static int bd96801_set_uvp(struct regulator_dev *rdev, int lim_uV, int sev=
erity,
+			   bool enable)
+{
+	int shift, stby;
+	struct bd96801_pmic_data *pdata;
+	struct bd96801_regulator_data *rdata;
+	struct bd96801_irq_desc *idesc;
+	struct device *dev;
+	struct bd96801_irqinfo *ovp_iinfo =3D NULL;
+	struct bd96801_irqinfo *uvp_iinfo =3D NULL;
+	int reg;
+	int ret;
+	int i;
+
+	dev =3D rdev_get_dev(rdev);
+	rdata =3D container_of(rdev->desc, struct bd96801_regulator_data, desc);
+	pdata =3D rdev_get_drvdata(rdev);
+	idesc =3D &rdata->irq_desc;
+
+	if (!idesc)
+		return -EOPNOTSUPP;
+
+	stby =3D bd96801_in_stby(rdev->regmap);
+	if (stby < 0)
+		return stby;
+	if (!stby)
+		dev_warn(dev, "Can't set UVP. PMIC not in STANDBY\n");
+
+	if (severity =3D=3D REGULATOR_SEVERITY_PROT) {
+		/* There is nothing we can do for UVP protection on BD96801 */
+		if (!enable) {
+			dev_err(dev, "Can't disable under voltage protection\n");
+			return -EOPNOTSUPP;
+		}
+		if (lim_uV)
+			dev_warn(dev,
+				 "Can't set under voltage protection limit\n");
+		return 0;
+	}
+
+	/*
+	 * The PMIC provides option to turn all indications fatal. The
+	 * OCP (protection) does utilize this. If DT enables OCP then we
+	 * can't provide warning/error notifications as these events are also
+	 * causing a shutdown. If this is the case we refuse to set the WARN
+	 * limit - but allow setting ERROR limit in order to prevent HW damage
+	 * if someone trusts on the ERRORs. The protection shutdown won't
+	 * inform software so this is not exactly a graceful thing. Thus punt
+	 * error log message also for the REGULATOR_SEVERITY_ERR config.
+	 */
+	if (enable && pdata->fatal_ind =3D=3D 1) {
+		dev_err(dev,
+			"All errors are fatal. Can't provide notifications\n");
+		if (severity =3D=3D REGULATOR_SEVERITY_WARN)
+			return -EINVAL;
+	}
+
+	if (lim_uV) {
+		ret =3D get_xvd_limits(rdev, &lim_uV, &reg);
+		if (ret)
+			return ret;
+	}
+	for (i =3D 0; i < idesc->num_irqs; i++) {
+		struct bd96801_irqinfo *iinfo =3D &idesc->irqinfo[i];
+
+		if (iinfo->type =3D=3D BD96801_PROT_OVP)
+			ovp_iinfo =3D iinfo;
+
+		if (iinfo->type =3D=3D BD96801_PROT_UVP)
+			uvp_iinfo =3D iinfo;
+	}
+
+	ret =3D sanity_check_ovd_uvd(dev, uvp_iinfo, ovp_iinfo, lim_uV,
+				   severity, enable);
+
+	if (ret) {
+		if (ret =3D=3D 1)
+			return 0;
+		return ret;
+	}
+
+	shift =3D rdata->prot_reg_shift;
+
+	if (enable && lim_uV)
+		return regmap_update_bits(pdata->regmap, rdata->ovd_reg,
+					  BD96801_OVP_MASK << shift,
+					  reg << shift);
+	return 0;
+}
+
+
+/*
+ * Driver uses fixed size OCP tables. If new variant with more OCP values =
is
+ * added we need to handle different sizes and selectors
+ */
+
+/* 1.5 A ... 3 A step 0.5 A*/
+static const int bd96801_buck12_ocp[] =3D { 1500000, 2000000, 2500000, 300=
0000 };
+
+/* 3 A ... 6 A *step 1 A */
+static const int bd96801_buck34_ocp[] =3D { 3000000, 4000000, 5000000, 600=
0000 };
+
+/* 400 mA ... 550 mA, step 50 mA*/
+static const int bd96801_ldo_ocp[] =3D { 400000, 450000, 500000, 550000 };
+
+static int __drop_warns(struct bd96801_regulator_data *rdata,
+			struct regmap *regmap, struct device *dev,
+			struct bd96801_irqinfo *iinfo)
+{
+	int ret =3D 0;
+
+	if (!iinfo->wrn_cfg && !iinfo->err_cfg)
+		return 0;
+
+	dev_err(dev, "All errors are fatal. Can't provide notifications\n");
+
+	if (iinfo->wrn_cfg) {
+		int mask;
+		int val;
+
+		if (iinfo->type =3D=3D BD96801_PROT_OVP ||
+		    iinfo->type =3D=3D BD96801_PROT_UVP) {
+			mask =3D BD96801_OVP_MASK << rdata->prot_reg_shift;
+			val =3D BD96801_PROT_LIMIT_HI << rdata->prot_reg_shift;
+
+			ret =3D regmap_update_bits(regmap, rdata->ovd_reg,
+						 mask, val);
+		} else if (iinfo->type =3D=3D BD96801_PROT_OCP) {
+			mask =3D BD96801_OVP_MASK << rdata->ocp_shift;
+			val =3D BD96801_PROT_LIMIT_HI << rdata->ocp_shift;
+			ret =3D regmap_update_bits(regmap, rdata->ocp_reg,
+					 mask, val);
+		}
+		if (ret)
+			return ret;
+
+		iinfo->wrn_cfg =3D -1;
+	}
+
+	return 0;
+}
+
+/*
+ * When we configure INTB to cause SHDN we will also make _all_ problems f=
atal.
+ * This is likely to cause shutdown at too early phase if WARNs are config=
ured.
+ * Thus we reset all already configured WARN limits.
+ *
+ * NOTE: We don't cancel both WARNs and ERRs. The typical and expected rec=
overy
+ * for ERRs is anyways a shutdown (although graceful). We'd better to leave
+ * those limits respected even though the shutdown won't be pretty. In most
+ * cases this should still be better than allowing things to go off more t=
han
+ * ERR boundary.
+ *
+ * For any already added WARNs we just configure the max limit. (We _could_
+ * store the HW default at startup and use it - but let's not overdo this.=
 We
+ * do punt out a big red error message - hopefully that is read by board R=
&D
+ * folks and they will review limits and fix the offending DT limits...
+ */
+static int bd96801_drop_all_warns(struct device *dev,
+				  struct bd96801_pmic_data *pdata)
+{
+	int i, ret;
+
+	for (i =3D 0; i < BD96801_NUM_REGULATORS; i++) {
+		struct bd96801_regulator_data *rdata;
+
+		rdata =3D &pdata->regulator_data[i];
+		for (i =3D 0; i < rdata->irq_desc.num_irqs; i++) {
+			struct bd96801_irqinfo *iinfo;
+
+			iinfo =3D &rdata->irq_desc.irqinfo[i];
+			ret =3D __drop_warns(rdata, pdata->regmap, dev, iinfo);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int bd96801_set_oc_det(struct device *dev,
+			      struct bd96801_pmic_data *pdata,
+			      struct bd96801_regulator_data *rdata, bool enable,
+			      int severity)
+{
+	struct bd96801_irqinfo *iinfo;
+	bool found =3D false;
+	int i, *cfg;
+
+	if (enable && pdata->fatal_ind =3D=3D 1) {
+		dev_err(dev, "Can't support fatal and non fatal OCP\n");
+		return -EINVAL;
+	}
+
+	/* Bucks have 3 OCP IRQs. mark them all. */
+	for (i =3D 0; i < rdata->irq_desc.num_irqs; i++) {
+		iinfo =3D &rdata->irq_desc.irqinfo[i];
+		if (iinfo->type !=3D BD96801_PROT_OCP)
+			continue;
+
+		if (severity =3D=3D REGULATOR_SEVERITY_WARN) {
+			if (enable && iinfo->err_cfg &&
+			    iinfo->err_cfg !=3D -1) {
+				dev_err(dev,
+					"Can't support both OCP WARN and ERR\n");
+				return -EINVAL;
+			}
+			cfg =3D &iinfo->wrn_cfg;
+		} else {
+			if (enable && iinfo->err_cfg &&
+			    iinfo->err_cfg !=3D -1) {
+				/* Print only once for this regulator's OCP */
+				if (!found)
+					dev_err(dev,
+						"Can't support both OCP WARN and ERR\n");
+				iinfo->wrn_cfg =3D 0;
+			}
+			cfg =3D &iinfo->err_cfg;
+		}
+		if (!enable)
+			*cfg =3D 0;
+		else
+			*cfg =3D 1;
+
+		found =3D true;
+	}
+	if (!found)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int bd96801_set_ocp(struct regulator_dev *rdev, int lim_uA,
+				int severity, bool enable)
+{
+	struct bd96801_pmic_data *pdata;
+	struct bd96801_regulator_data *rdata;
+	struct device *dev;
+	int reg, stby;
+
+	dev =3D rdev_get_dev(rdev);
+	rdata =3D container_of(rdev->desc, struct bd96801_regulator_data, desc);
+	pdata =3D rdev_get_drvdata(rdev);
+
+	/*
+	 * Most of the configs can only be done when PMIC is in STANDBY
+	 * And yes. This is racy, we don't know when PMIC state is changed.
+	 * So we can't promise config works as PMIC state may change right
+	 * after this check - but at least we can warn if this attempted
+	 * when PMIC isn't in STANDBY.
+	 */
+	stby =3D bd96801_in_stby(rdev->regmap);
+	if (stby < 0)
+		return stby;
+	if (!stby)
+		dev_warn(dev, "Can't set OCP. PMIC not in STANDBY\n");
+
+	if (severity =3D=3D REGULATOR_SEVERITY_PROT) {
+		if (enable) {
+			if (pdata->fatal_ind =3D=3D 0)
+				dev_err(dev, "Conflicting protection settings.\n");
+
+			pdata->fatal_ind =3D 1;
+			bd96801_drop_all_warns(dev, pdata);
+		} else {
+			if (pdata->fatal_ind =3D=3D 1) {
+				dev_err(dev, "Conflicting protection settings.\n");
+				return -EINVAL;
+			}
+			pdata->fatal_ind =3D 0;
+		}
+		if (!lim_uA)
+			return 0;
+	} else {
+		int ret;
+
+		ret =3D bd96801_set_oc_det(dev, pdata, rdata, enable, severity);
+		if (ret)
+			return ret;
+
+		if (!enable || !lim_uA)
+			return 0;
+	}
+	/*
+	 * zero is valid selector for OCP unlike for OVP/UVP.
+	 * We only set the limit for INT OCPH. OCPL OCPN and EXT_OCP limits
+	 * are not supported. Those could probably be handled using own vendor
+	 * DTS property.
+	 */
+	if (lim_uA > rdata->ocp_table[BD96801_PROT_LIMIT_MID]) {
+		reg =3D BD96801_PROT_LIMIT_HI;
+	} else if (lim_uA > rdata->ocp_table[BD96801_PROT_LIMIT_LOW]) {
+		reg =3D BD96801_PROT_LIMIT_MID;
+	} else if (lim_uA > rdata->ocp_table[BD96801_PROT_LIMIT_OCP_MIN]) {
+		reg =3D BD96801_PROT_LIMIT_LOW;
+	} else {
+		if (lim_uA < rdata->ocp_table[BD96801_PROT_LIMIT_OCP_MIN])
+			dev_warn(dev, "Can't support OCP %u, set %u\n",
+					lim_uA,
+					rdata->ocp_table[BD96801_PROT_LIMIT_OCP_MIN]);
+		reg =3D 0;
+	}
+
+	return regmap_update_bits(pdata->regmap, rdata->ocp_reg,
+					 BD96801_OVP_MASK << rdata->ocp_shift,
+					 reg << rdata->ocp_shift);
+}
+
+#define BD96801_TSD_KELVIN	448
+#define BD96801_TW_MIN_KELVIN	404
+#define BD96801_TW_MAX_KELVIN	422
+
+static int config_thermal_prot(struct bd96801_pmic_data *pdata,
+			       struct device *dev, int lim, bool enable)
+{
+	if (enable) {
+		/*
+		 * If limit is not given we assume the protection
+		 * refers to the TSD at BD96801_TSD_KELVIN. This
+		 * is always enabled so we have a no-op here.
+		 *
+		 * If limit is given then we try using fatal INTB
+		 */
+		if (!lim)
+			return 0;
+
+		if (pdata->fatal_ind =3D=3D 0)
+			dev_err(dev, "Conflicting protection settings.\n");
+
+		pdata->fatal_ind =3D 1;
+		bd96801_drop_all_warns(dev, pdata);
+	} else {
+		if (pdata->fatal_ind =3D=3D 1) {
+			dev_err(dev,
+				"Conflicting protection settings.\n");
+			return -EINVAL;
+		}
+		pdata->fatal_ind =3D 0;
+	}
+
+	return 0;
+}
+
+static int bd96801_ldo_set_tw(struct regulator_dev *rdev, int lim, int sev=
erity,
+			  bool enable)
+{
+	struct bd96801_regulator_data *rdata;
+	struct bd96801_pmic_data *pdata;
+	struct device *dev;
+
+	dev =3D rdev_get_dev(rdev);
+	rdata =3D container_of(rdev->desc, struct bd96801_regulator_data, desc);
+	pdata =3D rdev_get_drvdata(rdev);
+
+	/*
+	 * Let's handle the TSD case, After this we can focus on INTB.
+	 * See if given limit is the BD96801 TSD. If so, the enable request for
+	 * protection is valid (TSD is always enabled and does always forcibly
+	 * shut-down the PMIC. All other configurations for this temperature
+	 * are unsupported.
+	 */
+	if (lim =3D=3D BD96801_TSD_KELVIN) {
+		if (severity =3D=3D REGULATOR_SEVERITY_PROT && enable)
+			return 0;
+
+		dev_err(dev, "Unsupported TSD configuration\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The PMIC provides Thermal warning IRQ with limit that is not
+	 * configurable. If protection matching this limit is configured we can
+	 * use the INTB IRQ either for HW protection (fatal INTB), or WARN or
+	 * ERROR level notifications.
+	 */
+	if (lim && (lim < BD96801_TW_MIN_KELVIN ||
+		      lim > BD96801_TW_MAX_KELVIN)) {
+		dev_err(dev, "Unsupported thermal protection limit\n");
+		return -EINVAL;
+	}
+
+	if (severity =3D=3D REGULATOR_SEVERITY_PROT)
+		return config_thermal_prot(pdata, dev, lim, enable);
+	if (!enable)
+		return 0;
+
+	if (rdata->ldo_errs) {
+		dev_err(dev,
+			"Multiple protection notification configs for %s\n",
+			rdev->desc->name);
+		return -EINVAL;
+	}
+	if (severity =3D=3D REGULATOR_SEVERITY_ERR)
+		rdata->ldo_errs =3D REGULATOR_ERROR_OVER_TEMP;
+	else
+		rdata->ldo_errs =3D REGULATOR_ERROR_OVER_TEMP_WARN;
+
+	return 0;
+}
+
+static int ldo_map_notif(int irq, struct regulator_irq_data *rid,
+			 unsigned long *dev_mask)
+{
+	int i;
+
+	for (i =3D 0; i < rid->num_states; i++) {
+		struct bd96801_regulator_data *rdata;
+		struct regulator_dev *rdev;
+
+		rdev =3D rid->states[i].rdev;
+		rdata =3D container_of(rdev->desc, struct bd96801_regulator_data,
+				     desc);
+		rid->states[i].notifs =3D regulator_err2notif(rdata->ldo_errs);
+		rid->states[i].errors =3D rdata->ldo_errs;
+		*dev_mask |=3D BIT(i);
+	}
+	return 0;
+}
+
+/*
+ * Data-Sheet states that for BUCKs the IC can monitor driver MOS temperat=
ure
+ * or each internal power MOSFET temperature. Additionally there seems to =
be
+ * measurement of temperature at the center of the chip. These temperature
+ * detections will again generate INTB interrupt - and again, the INTB can
+ * be set to shut-down the faulting power-output (or group of outputs). Li=
mit
+ * for thermal warning (INTB) is arounf 140 degree C. (Data-sheet says 131=
 to
+ * 149 but I see no configuration for the limit.
+ *
+ * Let's use the same PROTECTION (fatal INTB behaviour) as we use with the
+ * OCP.
+ *
+ * On top of this it seems the IC has TSD (thermal shut-down). This is not
+ * configurable or maskable. The temperature limit for TSD is 175 degree C
+ * but the measurement point is not mentioned (any of the measurements
+ * exceed this?)
+ */
+static int bd96801_buck_set_tw(struct regulator_dev *rdev, int lim, int se=
verity,
+			       bool enable)
+{
+	struct bd96801_regulator_data *rdata;
+	struct bd96801_pmic_data *pdata;
+	struct bd96801_irqinfo *iinfo;
+	struct device *dev;
+	int i;
+
+	dev =3D rdev_get_dev(rdev);
+	rdata =3D container_of(rdev->desc, struct bd96801_regulator_data, desc);
+	pdata =3D rdev_get_drvdata(rdev);
+
+	/*
+	 * Let's handle the TSD case, After this we can focus on INTB.
+	 * See if given limit is the BD96801 TSD. If so, the enable request for
+	 * protection is valid (TSD is always enabled and does always forcibly
+	 * shut-down the PMIC). All other configurations for this temperature
+	 * are unsupported.
+	 */
+	if (lim =3D=3D BD96801_TSD_KELVIN) {
+		if (severity =3D=3D REGULATOR_SEVERITY_PROT && enable)
+			return 0;
+
+		dev_err(dev, "Unsupported TSD configuration\n");
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < rdata->irq_desc.num_irqs; i++) {
+		iinfo =3D &rdata->irq_desc.irqinfo[i];
+		if (iinfo->type =3D=3D BD96801_PROT_TEMP)
+			break;
+	}
+
+	if (i =3D=3D rdata->irq_desc.num_irqs)
+		return -EOPNOTSUPP;
+	/*
+	 * If limit is given, see it is within the detection range mentioned
+	 * in BD96801 data-sheet. We can't configure the limit but we can fail
+	 * if limit is given and it does not fit in typical thermal warning
+	 * detection range.
+	 */
+	if (lim && (lim < BD96801_TW_MIN_KELVIN ||
+		      lim > BD96801_TW_MAX_KELVIN)) {
+		dev_err(dev, "Unsupported thermal protection limit\n");
+		return -EINVAL;
+	}
+
+	if (severity =3D=3D REGULATOR_SEVERITY_PROT)
+		return config_thermal_prot(pdata, dev, lim, enable);
+
+	if (pdata->fatal_ind =3D=3D 1) {
+		/*
+		 * INTB is set fatal =3D> there will be no warning to consumers.
+		 * Let's still not fail the probe as this is not going to fry
+		 * the HW - it rather will make us do protection shutdown too
+		 * early. So just spill out a warning but let the boot proceed.
+		 */
+		dev_warn(dev, "INTB set fatal. Notifications not supported\n");
+		return 0;
+	}
+
+	if (severity =3D=3D REGULATOR_SEVERITY_ERR)
+		iinfo->err_cfg =3D (enable) ? 1 : 0;
+	else
+		iinfo->wrn_cfg =3D (enable) ? 1 : 0;
+
+	if (iinfo->wrn_cfg && iinfo->wrn_cfg !=3D -1 && iinfo->err_cfg &&
+	    iinfo->err_cfg !=3D -1)
+		dev_warn(dev, "Both temperature WARN and ERR given\n");
+
+	return 0;
+}
+
+static int bd96801_list_voltage_lr(struct regulator_dev *rdev,
+				   unsigned int selector)
+{
+	int voltage;
+	struct bd96801_regulator_data *data;
+
+	data =3D container_of(rdev->desc, struct bd96801_regulator_data, desc);
+
+	/*
+	 * The BD096801 has voltage setting in two registers. One giving the
+	 * "initial voltage" (can be changed only when regulator is disabled.
+	 * This driver caches the value and sets it only at startup. The other
+	 * register is voltage tuning value which applies -150 mV ... +150 mV
+	 * offset to the voltage.
+	 *
+	 * Note that the cached initial voltage stored in regulator data is
+	 * 'scaled down' by the 150 mV so that all of our tuning values are
+	 * >=3D 0. This is done because the linear_ranges uses unsigned values.
+	 *
+	 * As a result, we increase the tuning voltage which we get based on
+	 * the selector by the stored initial_voltage.
+	 */
+	voltage =3D regulator_list_voltage_linear_range(rdev, selector);
+	if (voltage < 0)
+		return voltage;
+
+	return voltage + data->initial_voltage;
+}
+
+/*
+ * BD96801 does not allow controlling the output enable/disable status
+ * unless PMIC is in STANDBY state. So this may be next to useless - unless
+ * the PMIC is controlled from processor not powered by the PMIC. AFAIK
+ * this really is a potential use-case with the BD96801 - hence these
+ * controls are implemented.
+ */
+static int bd96801_enable_regmap(struct regulator_dev *rdev)
+{
+	int stby;
+
+	stby =3D bd96801_in_stby(rdev->regmap);
+	if (stby < 0)
+		return stby;
+	if (!stby)
+		return -EBUSY;
+
+	return regulator_enable_regmap(rdev);
+}
+
+static int bd96801_disable_regmap(struct regulator_dev *rdev)
+{
+	int stby;
+
+	stby =3D bd96801_in_stby(rdev->regmap);
+	if (stby < 0)
+		return stby;
+	if (!stby)
+		return -EBUSY;
+
+	return regulator_disable_regmap(rdev);
+}
+
+/*
+ * Latest data-sheet says LDO voltages can only be changed in STANDBY(?)
+ * I think the original limitation was that the LDO must not be enabled
+ * when voltage is changed..
+ */
+static int bd96801_regulator_set_voltage_sel_restricted(struct regulator_d=
ev *rdev,
+							unsigned int sel)
+{
+	int stby;
+
+	stby =3D bd96801_in_stby(rdev->regmap);
+	if (stby)
+		return -EBUSY;
+
+	return rohm_regulator_set_voltage_sel_restricted(rdev, sel);
+}
+
+static const struct regulator_ops bd96801_ldo_table_ops =3D {
+	.enable =3D bd96801_enable_regmap,
+	.disable =3D bd96801_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.list_voltage =3D regulator_list_voltage_table,
+	.set_voltage_sel =3D rohm_regulator_set_voltage_sel_restricted,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_over_voltage_protection =3D bd96801_set_ovp,
+	.set_under_voltage_protection =3D bd96801_set_uvp,
+	.set_over_current_protection =3D bd96801_set_ocp,
+	.set_thermal_protection =3D bd96801_ldo_set_tw,
+};
+
+static const struct regulator_ops bd96801_buck_ops =3D {
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.list_voltage =3D bd96801_list_voltage_lr,
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel =3D regulator_set_voltage_time_sel,
+	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
+	.set_over_voltage_protection =3D bd96801_set_ovp,
+	.set_under_voltage_protection =3D bd96801_set_uvp,
+	.set_over_current_protection =3D bd96801_set_ocp,
+	.set_thermal_protection =3D bd96801_buck_set_tw,
+};
+
+static const struct regulator_ops bd96801_ldo_ops =3D {
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.list_voltage =3D regulator_list_voltage_linear_range,
+	.set_voltage_sel =3D bd96801_regulator_set_voltage_sel_restricted,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_over_voltage_protection =3D bd96801_set_ovp,
+	.set_under_voltage_protection =3D bd96801_set_uvp,
+	.set_over_current_protection =3D bd96801_set_ocp,
+	.set_thermal_protection =3D bd96801_ldo_set_tw,
+};
+
+static int buck_set_initial_voltage(struct regmap *regmap, struct device *=
dev,
+				    struct bd96801_regulator_data *data,
+				    struct device_node *np)
+{
+	int ret =3D 0;
+
+	if (data->num_ranges) {
+		int sel, val, stby;
+		bool found;
+		u32 initial_uv;
+		int reg =3D BD96801_INT_VOUT_BASE_REG + data->desc.id;
+
+		/* See if initial value should be configured */
+		ret =3D of_property_read_u32(np, "rohm,initial-voltage-microvolt",
+					   &initial_uv);
+		if (ret) {
+			if (ret =3D=3D EINVAL)
+				goto get_initial;
+			return ret;
+		}
+
+		/* We can only change initial voltage when PMIC is in STANDBY */
+		stby =3D bd96801_in_stby(regmap);
+		if (stby < 0)
+			goto get_initial;
+
+		if (!stby) {
+			dev_warn(dev,
+				 "Can't set initial voltage, PMIC not in STANDBY\n");
+			goto get_initial;
+		}
+
+		/*
+		 * Check if regulator is enabled - if not, then we can change
+		 * the initial voltage.
+		 */
+		ret =3D regmap_read(regmap, data->desc.enable_reg, &val);
+		if (ret)
+			return ret;
+
+		if ((val & data->desc.enable_mask) !=3D data->desc.enable_mask) {
+			dev_warn(dev,
+				 "%s: enabled. Can't set initial voltage\n",
+				 data->desc.name);
+			goto get_initial;
+		}
+
+		dev_dbg(dev, "%s: Setting INITIAL voltage %u\n",
+			data->desc.name,  initial_uv);
+		/*
+		 * The initial uV range is scaled down by 150mV to make all
+		 * tuning values positive. Hence we decrease value by 150 mV
+		 * so that the set voltage will really match the one requested
+		 * via DT.
+		 */
+		ret =3D linear_range_get_selector_low_array(data->init_ranges,
+							  data->num_ranges,
+							  initial_uv - 150000, &sel,
+							  &found);
+		if (ret) {
+			const struct linear_range *lr;
+			int max;
+
+			lr =3D &data->init_ranges[data->num_ranges - 1];
+			max =3D linear_range_get_max_value(lr);
+
+			dev_err(dev, "Unsupported initial voltage %u\n",
+				initial_uv);
+			dev_err(dev, "%u ranges, [%u .. %u]\n",
+				data->num_ranges, data->init_ranges->min, max);
+			return ret;
+		}
+
+		if (!found)
+			dev_warn(dev,
+				 "Unsupported initial voltage %u requested, setting lower\n",
+				 initial_uv);
+
+		ret =3D regmap_update_bits(regmap, reg,
+					 BD96801_BUCK_INT_VOUT_MASK,
+					 sel);
+		if (ret)
+			return ret;
+get_initial:
+		ret =3D regmap_read(regmap, reg, &sel);
+		sel &=3D BD96801_BUCK_INT_VOUT_MASK;
+
+		ret =3D linear_range_get_value_array(data->init_ranges,
+						   data->num_ranges, sel,
+						   &initial_uv);
+		if (ret)
+			return ret;
+
+		data->initial_voltage =3D initial_uv;
+		dev_dbg(dev, "Tune-scaled initial voltage %u\n",
+			data->initial_voltage);
+	}
+
+	return 0;
+}
+
+static int set_ldo_initial_voltage(struct regmap *regmap,
+				   struct device *dev,
+				   struct bd96801_regulator_data *data,
+				   struct device_node *np)
+{
+	int ret, val, stby;
+	u32 initial_uv;
+	int cfgreg =3D 0;
+	int mask =3D BD96801_LDO_SD_VOLT_MASK | BD96801_LDO_MODE_MASK;
+
+	ret =3D of_property_read_u32(np, "rohm,initial-voltage-microvolt",
+				   &initial_uv);
+	if (ret) {
+		if (ret =3D=3D EINVAL)
+			goto get_initial;
+		return ret;
+	}
+
+	/* We can only change initial voltage when PMIC is in STANDBY */
+	stby =3D bd96801_in_stby(regmap);
+	if (stby < 0)
+		return stby;
+
+	if (!stby) {
+		dev_warn(dev, "Can't set initial voltage, PMIC not in STANDBY\n");
+		goto get_initial;
+	}
+
+	ret =3D regmap_read(regmap, data->desc.enable_reg, &val);
+	if (ret)
+		return ret;
+
+	if ((val & data->desc.enable_mask) !=3D data->desc.enable_mask) {
+		dev_warn(dev, "%s: enabled. Can't set initial voltage\n",
+			 data->desc.name);
+		goto get_initial;
+	}
+
+	/* Regulator is Disabled */
+	dev_dbg(dev, "%s: Setting INITIAL voltage %u\n", data->desc.name,
+		initial_uv);
+
+	/*
+	 * Should this be two properties - one for mode (SD/DDR) and
+	 * one for voltage (3.3, 1.8, 0.5, 0.3?)
+	 */
+	switch (initial_uv) {
+	case 300000:
+		cfgreg |=3D BD96801_LDO_MODE_DDR;
+		cfgreg |=3D 1;
+		break;
+	case 500000:
+		cfgreg |=3D BD96801_LDO_MODE_DDR;
+		break;
+	case 1800000:
+		cfgreg |=3D BD96801_LDO_MODE_SD;
+		cfgreg |=3D 1;
+		break;
+	case 3300000:
+		cfgreg |=3D BD96801_LDO_MODE_SD;
+		break;
+	default:
+		dev_err(dev, "unsupported initial voltage for LDO\n");
+		return -EINVAL;
+	}
+	ret =3D regmap_update_bits(regmap, data->ldo_vol_lvl, mask,
+				 cfgreg);
+	if (ret)
+		return ret;
+
+get_initial:
+	if (!cfgreg) {
+		ret =3D regmap_read(regmap, data->ldo_vol_lvl, &cfgreg);
+		if (ret)
+			return ret;
+	}
+	switch (cfgreg & BD96801_LDO_MODE_MASK) {
+	case BD96801_LDO_MODE_DDR:
+		data->desc.volt_table =3D ldo_ddr_volt_table;
+		data->desc.n_voltages =3D ARRAY_SIZE(ldo_ddr_volt_table);
+		break;
+	case BD96801_LDO_MODE_SD:
+		data->desc.volt_table =3D ldo_sd_volt_table;
+		data->desc.n_voltages =3D ARRAY_SIZE(ldo_sd_volt_table);
+		break;
+	default:
+		dev_info(dev, "Leaving LDO to normal mode");
+		return 0;
+	}
+
+	/* SD or DDR mode =3D> override default ops */
+	data->desc.ops =3D &bd96801_ldo_table_ops,
+	data->desc.vsel_mask =3D 1;
+	data->desc.vsel_reg =3D data->ldo_vol_lvl;
+
+	return 0;
+}
+
+static int set_initial_voltage(struct device *dev, struct regmap *regmap,
+			struct bd96801_regulator_data *data,
+			struct device_node *np)
+{
+	/* BUCK */
+	if (data->desc.id <=3D BD96801_BUCK4)
+		return buck_set_initial_voltage(regmap, dev, data, np);
+
+	/* LDO */
+	return set_ldo_initial_voltage(regmap, dev, data, np);
+}
+
+static int bd96801_walk_regulator_dt(struct device *dev, struct regmap *re=
gmap,
+				     struct bd96801_regulator_data *data,
+				     int num)
+{
+	int i, ret;
+	struct device_node *np;
+	struct device_node *nproot =3D dev->parent->of_node;
+
+	nproot =3D of_get_child_by_name(nproot, "regulators");
+	if (!nproot) {
+		dev_err(dev, "failed to find regulators node\n");
+		return -ENODEV;
+	}
+	for_each_child_of_node(nproot, np)
+		for (i =3D 0; i < num; i++) {
+			if (!of_node_name_eq(np, data[i].desc.of_match))
+				continue;
+			ret =3D set_initial_voltage(dev, regmap, &data[i], np);
+			if (ret) {
+				dev_err(dev,
+					"Initializing voltages for %s failed\n",
+					data[i].desc.name);
+				of_node_put(np);
+				of_node_put(nproot);
+
+				return ret;
+			}
+			if (of_property_read_bool(np, "rohm,keep-on-stby")) {
+				ret =3D regmap_set_bits(regmap,
+						      BD96801_ALWAYS_ON_REG,
+						      1 << data[i].desc.id);
+				if (ret) {
+					dev_err(dev,
+						"failed to set %s on-at-stby\n",
+						data[i].desc.name);
+					of_node_put(np);
+					of_node_put(nproot);
+
+					return ret;
+				}
+			}
+		}
+	of_node_put(nproot);
+
+	return 0;
+}
+
+/*
+ * Template for regulator data. Probe will allocate dynamic / driver insta=
nce
+ * struct so we should be on a safe side even if there were multiple PMICs=
 to
+ * control. Note that there is a plan to allow multiple PMICs to be used so
+ * systems can scale better. I am however still slightly unsure how the
+ * multi-PMIC case will be handled. I don't know if the processor will hav=
e I2C
+ * acces to all of the PMICs or only the first one. I'd guess there will be
+ * access provided to all PMICs for voltage scaling - but the errors will =
only
+ * be informed via the master PMIC. Eg, we should prepare to support multi=
ple
+ * driver instances - either with or without the IRQs... Well, let's first
+ * just support the simple and clear single-PMIC setup and ponder the mult=
i PMIC
+ * case later. What we can easly do for preparing is to not use static glo=
bal
+ * data for regulators though.
+ */
+static const struct bd96801_pmic_data bd96801_data =3D {
+	.regulator_data =3D {
+	{
+		.desc =3D {
+			.name =3D "buck1",
+			.of_match =3D of_match_ptr("BUCK1"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK1,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_tune_volts),
+			.n_voltages =3D BD96801_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK1_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK1_VSEL_REG,
+			.vsel_mask =3D BD96801_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK1_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.init_ranges =3D bd96801_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96801_buck_init_volts),
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck1_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck1_irqinfo),
+		},
+		.prot_reg_shift =3D BD96801_MASK_BUCK1_OVP_SHIFT,
+		.ovp_reg =3D BD96801_REG_BUCK_OVP,
+		.ovd_reg =3D BD96801_REG_BUCK_OVD,
+		.ocp_table =3D bd96801_buck12_ocp,
+		.ocp_reg =3D BD96801_REG_BUCK1_OCP,
+		.ocp_shift =3D BD96801_MASK_BUCK1_OCP_SHIFT,
+	},
+	{
+		.desc =3D {
+			.name =3D "buck2",
+			.of_match =3D of_match_ptr("BUCK2"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK2,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_tune_volts),
+			.n_voltages =3D BD96801_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK2_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK2_VSEL_REG,
+			.vsel_mask =3D BD96801_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK2_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck2_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck2_irqinfo),
+		},
+		.init_ranges =3D bd96801_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96801_buck_init_volts),
+		.prot_reg_shift =3D BD96801_MASK_BUCK2_OVP_SHIFT,
+		.ovp_reg =3D BD96801_REG_BUCK_OVP,
+		.ovd_reg =3D BD96801_REG_BUCK_OVD,
+		.ocp_table =3D bd96801_buck12_ocp,
+		.ocp_reg =3D BD96801_REG_BUCK2_OCP,
+		.ocp_shift =3D BD96801_MASK_BUCK2_OCP_SHIFT,
+	},
+	{
+		.desc =3D {
+			.name =3D "buck3",
+			.of_match =3D of_match_ptr("BUCK3"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK3,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_tune_volts),
+			.n_voltages =3D BD96801_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK3_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK3_VSEL_REG,
+			.vsel_mask =3D BD96801_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK3_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck3_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck3_irqinfo),
+		},
+		.init_ranges =3D bd96801_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96801_buck_init_volts),
+		.prot_reg_shift =3D BD96801_MASK_BUCK3_OVP_SHIFT,
+		.ovp_reg =3D BD96801_REG_BUCK_OVP,
+		.ovd_reg =3D BD96801_REG_BUCK_OVD,
+		.ocp_table =3D bd96801_buck34_ocp,
+		.ocp_reg =3D BD96801_REG_BUCK3_OCP,
+		.ocp_shift =3D BD96801_MASK_BUCK3_OCP_SHIFT,
+	},
+	{
+		.desc =3D {
+			.name =3D "buck4",
+			.of_match =3D of_match_ptr("BUCK4"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK4,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_tune_volts),
+			.n_voltages =3D BD96801_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK4_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK4_VSEL_REG,
+			.vsel_mask =3D BD96801_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK4_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck4_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck4_irqinfo),
+		},
+		.init_ranges =3D bd96801_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96801_buck_init_volts),
+		.prot_reg_shift =3D BD96801_MASK_BUCK4_OVP_SHIFT,
+		.ovp_reg =3D BD96801_REG_BUCK_OVP,
+		.ovd_reg =3D BD96801_REG_BUCK_OVD,
+		.ocp_table =3D bd96801_buck34_ocp,
+		.ocp_reg =3D BD96801_REG_BUCK4_OCP,
+		.ocp_shift =3D BD96801_MASK_BUCK4_OCP_SHIFT,
+	},
+	{
+		.desc =3D {
+			.name =3D "ldo5",
+			.of_match =3D of_match_ptr("LDO5"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_LDO5,
+			.ops =3D &bd96801_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_ldo_int_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_ldo_int_volts),
+			.n_voltages =3D BD96801_LDO_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_LDO5_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_LDO5_VSEL_REG,
+			.vsel_mask =3D BD96801_LDO_VSEL_MASK,
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&ldo5_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(ldo5_irqinfo),
+		},
+		.ldo_vol_lvl =3D BD96801_LDO5_VOL_LVL_REG,
+		.prot_reg_shift =3D BD96801_MASK_LDO5_OVP_SHIFT,
+		.ovp_reg =3D BD96801_REG_LDO_OVP,
+		.ovd_reg =3D BD96801_REG_LDO_OVD,
+		.ocp_table =3D bd96801_ldo_ocp,
+		.ocp_reg =3D BD96801_REG_LDO5_OCP,
+		.ocp_shift =3D BD96801_MASK_LDO5_OCP_SHIFT,
+	},
+	{
+		.desc =3D {
+			.name =3D "ldo6",
+			.of_match =3D of_match_ptr("LDO6"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_LDO6,
+			.ops =3D &bd96801_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_ldo_int_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_ldo_int_volts),
+			.n_voltages =3D BD96801_LDO_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_LDO6_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_LDO6_VSEL_REG,
+			.vsel_mask =3D BD96801_LDO_VSEL_MASK,
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&ldo6_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(ldo6_irqinfo),
+		},
+		.ldo_vol_lvl =3D BD96801_LDO6_VOL_LVL_REG,
+		.prot_reg_shift =3D BD96801_MASK_LDO6_OVP_SHIFT,
+		.ovp_reg =3D BD96801_REG_LDO_OVP,
+		.ovd_reg =3D BD96801_REG_LDO_OVD,
+		.ocp_table =3D bd96801_ldo_ocp,
+		.ocp_reg =3D BD96801_REG_LDO6_OCP,
+		.ocp_shift =3D BD96801_MASK_LDO6_OCP_SHIFT,
+	},
+	{
+		.desc =3D {
+			.name =3D "ldo7",
+			.of_match =3D of_match_ptr("LDO7"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_LDO7,
+			.ops =3D &bd96801_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_ldo_int_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_ldo_int_volts),
+			.n_voltages =3D BD96801_LDO_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_LDO7_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_LDO7_VSEL_REG,
+			.vsel_mask =3D BD96801_LDO_VSEL_MASK,
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&ldo7_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(ldo7_irqinfo),
+		},
+		.ldo_vol_lvl =3D BD96801_LDO7_VOL_LVL_REG,
+		.prot_reg_shift =3D BD96801_MASK_LDO7_OVP_SHIFT,
+		.ovp_reg =3D BD96801_REG_LDO_OVP,
+		.ovd_reg =3D BD96801_REG_LDO_OVD,
+		.ocp_table =3D bd96801_ldo_ocp,
+		.ocp_reg =3D BD96801_REG_LDO7_OCP,
+		.ocp_shift =3D BD96801_MASK_LDO7_OCP_SHIFT,
+	},
+	},
+	.fatal_ind =3D -1,
+};
+
+static int initialize_pmic_data(struct device *dev,
+				struct bd96801_pmic_data *pdata)
+{
+	int r, i;
+
+	*pdata =3D bd96801_data;
+
+	/*
+	 * Allocate and initialize IRQ data for all of the regulators. We
+	 * wish to modify IRQ information independently for each driver
+	 * instance.
+	 */
+	for (r =3D 0; r < BD96801_NUM_REGULATORS; r++) {
+		const struct bd96801_irqinfo *template;
+		struct bd96801_irqinfo *new;
+		int num_infos;
+
+		template =3D pdata->regulator_data[r].irq_desc.irqinfo;
+		num_infos =3D pdata->regulator_data[r].irq_desc.num_irqs;
+
+		new =3D devm_kzalloc(dev, num_infos * sizeof(*new), GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		pdata->regulator_data[r].irq_desc.irqinfo =3D new;
+
+		for (i =3D 0; i < num_infos; i++)
+			new[i] =3D template[i];
+	}
+
+	return 0;
+}
+
+static int bd96801_map_event_all(int irq, struct regulator_irq_data *rid,
+			  unsigned long *dev_mask)
+{
+	int i;
+
+	for (i =3D 0; i < rid->num_states; i++) {
+		rid->states[i].notifs =3D REGULATOR_EVENT_FAIL;
+		rid->states[i].errors =3D REGULATOR_ERROR_FAIL;
+		*dev_mask |=3D BIT(i);
+	}
+
+	return 0;
+}
+
+static int bd96801_rdev_errb_irqs(struct platform_device *pdev,
+				  struct regulator_dev *rdev)
+{
+	int i;
+	void *retp;
+	static const char * const single_out_errb_irqs[] =3D {
+		"bd96801-%s-pvin-err", "bd96801-%s-ovp-err",
+		"bd96801-%s-uvp-err", "bd96801-%s-shdn-err",
+	};
+
+	for (i =3D 0; i < ARRAY_SIZE(single_out_errb_irqs); i++) {
+		char tmp[255];
+		int irq;
+		struct regulator_irq_desc id =3D {
+			.map_event =3D bd96801_map_event_all,
+			.irq_off_ms =3D 1000,
+		};
+		struct regulator_dev *rdev_arr[1] =3D { rdev };
+
+		snprintf(tmp, 255, single_out_errb_irqs[i], rdev->desc->name);
+		tmp[254] =3D 0;
+		id.name =3D tmp;
+
+		irq =3D platform_get_irq_byname(pdev, tmp);
+		if (irq < 0)
+			continue;
+
+		retp =3D devm_regulator_irq_helper(&pdev->dev, &id, irq, 0,
+						 REGULATOR_ERROR_FAIL, NULL,
+						 rdev_arr, 1);
+		if (IS_ERR(retp))
+			return PTR_ERR(retp);
+
+	}
+	return 0;
+}
+
+static int bd96801_global_errb_irqs(struct platform_device *pdev,
+				    struct regulator_dev **rdev, int num_rdev)
+{
+	int i, num_irqs;
+	void *retp;
+	static const char * const global_errb_irqs[] =3D {
+		"bd96801-otp-err", "bd96801-dbist-err", "bd96801-eep-err",
+		"bd96801-abist-err", "bd96801-prstb-err", "bd96801-drmoserr1",
+		"bd96801-drmoserr2", "bd96801-slave-err", "bd96801-vref-err",
+		"bd96801-tsd", "bd96801-uvlo-err", "bd96801-ovlo-err",
+		"bd96801-osc-err", "bd96801-pon-err", "bd96801-poff-err",
+		"bd96801-cmd-shdn-err", "bd96801-int-shdn-err"
+	};
+
+	num_irqs =3D ARRAY_SIZE(global_errb_irqs);
+	for (i =3D 0; i < num_irqs; i++) {
+		int irq;
+		struct regulator_irq_desc id =3D {
+			.name =3D global_errb_irqs[i],
+			.map_event =3D bd96801_map_event_all,
+			.irq_off_ms =3D 1000,
+		};
+
+		irq =3D platform_get_irq_byname(pdev, global_errb_irqs[i]);
+		if (irq < 0)
+			continue;
+
+		retp =3D devm_regulator_irq_helper(&pdev->dev, &id, irq, 0,
+						 REGULATOR_ERROR_FAIL, NULL,
+						  rdev, num_rdev);
+		if (IS_ERR(retp))
+			return PTR_ERR(retp);
+	}
+
+	return 0;
+}
+
+static int bd96801_probe(struct platform_device *pdev)
+{
+	struct device *parent;
+	int i, ret, irq;
+	void *retp;
+	struct regulator_config config =3D {};
+	struct bd96801_regulator_data *rdesc;
+	struct bd96801_pmic_data *pdata;
+	struct regulator_dev *ldo_errs_rdev_arr[BD96801_NUM_LDOS];
+	int ldo_errs_arr[BD96801_NUM_LDOS];
+	int temp_notif_ldos =3D 0;
+	struct regulator_dev *all_rdevs[BD96801_NUM_REGULATORS];
+	bool use_errb;
+
+	parent =3D pdev->dev.parent;
+
+	pdata =3D devm_kzalloc(&pdev->dev, sizeof(bd96801_data), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	if (initialize_pmic_data(&pdev->dev, pdata))
+		return -ENOMEM;
+
+	pdata->regmap =3D dev_get_regmap(parent, NULL);
+	if (!pdata->regmap) {
+		dev_err(&pdev->dev, "No register map found\n");
+		return -ENODEV;
+	}
+
+	rdesc =3D &pdata->regulator_data[0];
+
+	config.driver_data =3D pdata;
+	config.regmap =3D pdata->regmap;
+	config.dev =3D parent;
+
+	ret =3D of_property_match_string(pdev->dev.parent->of_node,
+				       "interrupt-names", "errb");
+	if (ret < 0)
+		use_errb =3D false;
+	else
+		use_errb =3D true;
+
+
+	ret =3D regmap_write(pdata->regmap, BD96801_LOCK_REG, BD96801_UNLOCK);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't unlock PMIC\n");
+		return ret;
+	}
+
+	ret =3D bd96801_walk_regulator_dt(&pdev->dev, pdata->regmap, rdesc,
+					BD96801_NUM_REGULATORS);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < ARRAY_SIZE(pdata->regulator_data); i++) {
+		struct regulator_dev *rdev;
+		struct regulator_dev *rdev_arr[1];
+		struct bd96801_irq_desc *idesc =3D &rdesc[i].irq_desc;
+		int j, stby;
+
+		rdev =3D devm_regulator_register(&pdev->dev,
+					       &rdesc[i].desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev,
+				"failed to register %s regulator\n",
+				rdesc[i].desc.name);
+			return PTR_ERR(rdev);
+		}
+		all_rdevs[i] =3D rdev;
+		if (pdata->fatal_ind) {
+			stby =3D bd96801_in_stby(pdata->regmap);
+			if (stby < 0)
+				return stby;
+
+			if (!stby)
+				dev_warn(&pdev->dev,
+					 "PMIC not in STANDBY. Can't change INTB fatality\n");
+
+			/*
+			 * This means we may set the INTB fatality many times
+			 * but it's better to enable it immediately after a
+			 * regulator is enabled to protect early on.
+			 */
+			ret =3D regmap_update_bits(pdata->regmap,
+						 BD96801_REG_SHD_INTB,
+						 BD96801_MASK_SHD_INTB,
+						 BD96801_INTB_FATAL);
+			if (ret)
+				return ret;
+		}
+		/*
+		 * LDOs don't have own temperature monitoring. If temperature
+		 * notification was requested for this LDO from DT then we will
+		 * add the regulator to be notified if central IC temperature
+		 * exceeds threshold.
+		 */
+		if (rdesc[i].ldo_errs) {
+			ldo_errs_rdev_arr[temp_notif_ldos] =3D rdev;
+			ldo_errs_arr[temp_notif_ldos] =3D rdesc[i].ldo_errs;
+			temp_notif_ldos++;
+		}
+		if (!idesc)
+			continue;
+		/*
+		 * TODO: Can we split adding the INTB notifiers in own
+		 * function ?
+		 */
+		/* Register INTB handlers for configured protections */
+		for (j =3D 0; j < idesc->num_irqs; j++) {
+			struct bd96801_irqinfo *iinfo;
+			int err =3D 0;
+			int err_flags[] =3D {
+				[BD96801_PROT_OVP] =3D REGULATOR_ERROR_REGULATION_OUT,
+				[BD96801_PROT_UVP] =3D REGULATOR_ERROR_UNDER_VOLTAGE,
+				[BD96801_PROT_OCP] =3D REGULATOR_ERROR_OVER_CURRENT,
+				[BD96801_PROT_TEMP] =3D REGULATOR_ERROR_OVER_TEMP,
+
+			};
+			int wrn_flags[] =3D {
+				[BD96801_PROT_OVP] =3D REGULATOR_ERROR_OVER_VOLTAGE_WARN,
+				[BD96801_PROT_UVP] =3D REGULATOR_ERROR_UNDER_VOLTAGE_WARN,
+				[BD96801_PROT_OCP] =3D REGULATOR_ERROR_OVER_CURRENT_WARN,
+				[BD96801_PROT_TEMP] =3D REGULATOR_ERROR_OVER_TEMP_WARN,
+			};
+
+			iinfo =3D &idesc->irqinfo[j];
+			/*
+			 * Don't install IRQ handler if both error and warning
+			 * notifications are explicitly disabled
+			 */
+			if (!iinfo->err_cfg && !iinfo->wrn_cfg)
+				continue;
+
+			if (WARN_ON(iinfo->type >=3D BD96801_NUM_PROT))
+				return -EINVAL;
+
+			if (iinfo->err_cfg)
+				err =3D err_flags[iinfo->type];
+			else if (iinfo->wrn_cfg)
+				err =3D wrn_flags[iinfo->type];
+
+			iinfo->irq_desc.data =3D pdata;
+			irq =3D platform_get_irq_byname(pdev, iinfo->irq_name);
+			if (irq < 0)
+				return irq;
+			/* Find notifications for this IRQ (WARN/ERR) */
+
+			rdev_arr[0] =3D rdev;
+			retp =3D devm_regulator_irq_helper(&pdev->dev,
+							 &iinfo->irq_desc, irq,
+							 0, err, NULL, rdev_arr,
+							 1);
+			if (IS_ERR(retp))
+				return PTR_ERR(retp);
+		}
+		/* Register per regulator ERRB notifiers */
+		if (use_errb) {
+			ret =3D bd96801_rdev_errb_irqs(pdev, rdev);
+			if (ret)
+				return ret;
+		}
+	}
+	if (temp_notif_ldos) {
+		int irq;
+		struct regulator_irq_desc tw_desc =3D {
+			.name =3D "bd96801-core-thermal",
+			.irq_off_ms =3D 500,
+			.map_event =3D ldo_map_notif,
+		};
+
+		irq =3D platform_get_irq_byname(pdev, "bd96801-core-thermal");
+		if (irq < 0)
+			return irq;
+
+		retp =3D devm_regulator_irq_helper(&pdev->dev, &tw_desc, irq, 0,
+						 0, &ldo_errs_arr[0],
+						 &ldo_errs_rdev_arr[0],
+						 temp_notif_ldos);
+		if (IS_ERR(retp))
+			return PTR_ERR(retp);
+	}
+
+	if (use_errb)
+		return bd96801_global_errb_irqs(pdev, all_rdevs,
+						ARRAY_SIZE(all_rdevs));
+
+	return 0;
+}
+
+static struct platform_driver bd96801_regulator =3D {
+	.driver =3D {
+		.name =3D "bd96801-pmic"
+	},
+	.probe =3D bd96801_probe,
+};
+
+module_platform_driver(bd96801_regulator);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD96801 voltage regulator driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd96801-pmic");
--=20
2.43.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--MB0BEC6uYYfm70NP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYMA78ACgkQeFA3/03a
ocU4qAgA1WYYQlV0aGM6+9KOkHttl6rDFlqRoKKVIMWvfEdsjPmHEnsC6GCQT/Tb
MsWaxRkVn9ipvXhoZedjwk0NO9cCZ9ncqGDBjh0Aqp8eP4ysyB/sRUV9LELYUddL
U7AtXiX7dl0Gx04CeYZQnGWLUa/B7E5cvhifqqzLGFfoFBJRhJ6IhxYWUYcd5ewe
PqeQBO1kUlO0fLVqMLPr70JgPO1nkHw4p8jcZurI8rELUuQiP0OqcKdX4+ks5MzG
lSyk39U04OQJ35Szj801lgH4XPw5bThOmWli2lK26enNcX2hO836wvFddk/Seuyl
/JJfmW/COLUib27p3AIaYDzyH7WL5Q==
=9ViM
-----END PGP SIGNATURE-----

--MB0BEC6uYYfm70NP--

