Return-Path: <linux-kernel+bounces-163885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3508B752B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B151C22A86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EAB13D272;
	Tue, 30 Apr 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osuft6+Y"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5413D26D;
	Tue, 30 Apr 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478508; cv=none; b=GluKep3xVqRdUqN5Dytk0DnCIZZXw3zzlntsevnINOe1PGP9dqZuac2DoFieOubSeafCFPtQXluS3IloWUpwo/PWMO1MHqBWBjIL/uf3bPSDEULCf9kI67qifwkvi3HuYLxQxXTY0CRJDF/9w3mDIY+XuMkxkbgakErN494GAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478508; c=relaxed/simple;
	bh=wQGekXScusyJJEoc162KtW8KqxOD0j1YRUh4HslumU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIyNk1d7JfwJb56BwIjuEQrTmRUTRA79S53VMTfWSXsFtwuhSitfKEf6YmhqJ6oMnwQU0Gm0a+D6uxyzP7flSPznMd4t9Zwdg8ahrLZpM8EWfcf+AQ88a3fT/SwT60NSztW2i+hDK7Bw/57B1/IwR7vV3pvhYzgp4CY69TOgYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osuft6+Y; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5171a529224so7095148e87.0;
        Tue, 30 Apr 2024 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478504; x=1715083304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnarjhVmXyTjaB4IeH3fm1CZtRk0J8KRD4dmXhLvoak=;
        b=Osuft6+Yob/CXmpSHp5xVf3rwR6EDJPMQhi38GnNo6BiTCmQ6XExLuglvqjCp0RN81
         bP5wDSFdHpobP260DI7TBuUNpYZvuaorAjj+vXCwLpPYm5nWwrLboa5zptiy4ltMN0UT
         G3TMwrMPNyLNWFSWcbRuDwfYMKJ2a4Ouk3pEEf4rRJ0M3h8PwBglgQuvUaXB1UZa2RRV
         z0EncvTLBPj8XfK4eON5EQCOKu6xAwPvt4+eGZ4IPmMQPvAZCF3oETZFADwPSic+bm3c
         z0CG6dbKQTOJwwZihlfCZQ3txScG9nkWEd29xmCLslxX7vqM3o6yQjK0ojHNDkcMHbvE
         rd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478504; x=1715083304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnarjhVmXyTjaB4IeH3fm1CZtRk0J8KRD4dmXhLvoak=;
        b=Ihj0d0VFEh5XuzfiJy1nOCfQbJ1QMfsbg3EdPR/HEcTlMWnMJevKFtNIGV8frxF7lm
         iJljQrMLHnqUZZhtSK6iBvU6YPo9TsxigLYMb0ezpUpYpLHNzM17dPPGucR2YLgwKDjs
         gaIJKlWMrJ4E+MLhUwIHz5Sj8w6k0zn3+VAg6fKiRBJ2R12HTVDdt5Qt9HRVwLwpYhLV
         //46KEfmhR1yMPVpVqXSvICNlBYxiWGM+jIYDzPx6J+EJyo0NtlmcaIYKaSw7hai1U2i
         6N0pYJkk+PhtagoyzdDEE9cOpimJKTNitj+xUQUMkKSLZWk+nG0D/H9OShc1ZOiUuAu6
         A1pA==
X-Forwarded-Encrypted: i=1; AJvYcCUV7YEuALJdu93P3EYzduKnSlrbaKkTegYHP02IYQCEEGB6zlBIiR5QwEoylJefXewW65ZFltyG2mgqqFexLFk7b+QfsfthJ/jBXm6YvmmXWtjPwnlY7QuO6AKib9bf7f9KLePFC6uGDD6L0VqklnASPv/TRAtvFISFk6t1i5jETwNPelDaE+ZZ
X-Gm-Message-State: AOJu0YwjEMQuzscl9bBuESZ+pOLVd2biO6BnrtJiri+NzXBNYmz3MbQq
	TxXHAAfgBtLusoctrOGv7XZgCpZxntlO58XaDqVZK0ZLCD8D+YAO
X-Google-Smtp-Source: AGHT+IE7RyGky1iY+1EIijSYgbMb9MT4nzOVNOTiLra8dhGbAx4DKJlU4qk5zqURKXJd5/VFBiljUg==
X-Received: by 2002:a05:6512:3109:b0:518:a66e:aad2 with SMTP id n9-20020a056512310900b00518a66eaad2mr1911800lfb.63.1714478503682;
        Tue, 30 Apr 2024 05:01:43 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c11-20020a056512074b00b005158558022bsm4475800lfs.288.2024.04.30.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:01:41 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:01:37 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v1 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Message-ID: <d1d5429e4a34a06af0ceb853d72344cf9b8ae67c.1714478142.git.mazziesaccount@gmail.com>
References: <cover.1714478142.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zmtLMzOYuNxYSMSt"
Content-Disposition: inline
In-Reply-To: <cover.1714478142.git.mazziesaccount@gmail.com>


--zmtLMzOYuNxYSMSt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce driver for WDG block on ROHM BD96801 scalable PMIC.

This driver only supports watchdog with I2C feeding and delayed
response detection. Whether the watchdog toggles PRSTB pin or
just causes an interrupt can be configured via device-tree.

The BD96801 PMIC HW supports also window watchdog (too early
feeding detection) and Q&A mode. These are not supported by
this driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
RFCv2 =3D> v1:
- Fix watchdog time-outs to match DS4
- Fix target timeout overflow
- Improve dbg prints

RFCv1 =3D> RFCv2:
- remove always running
- add IRQ handling
- call emergency_restart()
- drop MODULE_ALIAS and add MODULE_DEVICE_TABLE
---
 drivers/watchdog/Kconfig       |  13 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/bd96801_wdt.c | 400 +++++++++++++++++++++++++++++++++
 3 files changed, 414 insertions(+)
 create mode 100644 drivers/watchdog/bd96801_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6bee137cfbe0..d97e735e1faa 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -181,6 +181,19 @@ config BD957XMUF_WATCHDOG
 	  watchdog. Alternatively say M to compile the driver as a module,
 	  which will be called bd9576_wdt.
=20
+config BD96801_WATCHDOG
+	tristate "ROHM BD96801 PMIC Watchdog"
+	depends on MFD_ROHM_BD96801
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the ROHM BD96801 PMIC. Watchdog can be
+	  configured to only generate IRQ or to trigger system reset via reset
+	  pin.
+
+	  Say Y here to include support for the ROHM BD96801 watchdog.
+	  Alternatively say M to compile the driver as a module,
+	  which will be called bd96801_wdt.
+
 config CROS_EC_WATCHDOG
 	tristate "ChromeOS EC-based watchdog"
 	select WATCHDOG_CORE
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 3710c218f05e..31bc94436c81 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -217,6 +217,7 @@ obj-$(CONFIG_XEN_WDT) +=3D xen_wdt.o
=20
 # Architecture Independent
 obj-$(CONFIG_BD957XMUF_WATCHDOG) +=3D bd9576_wdt.o
+obj-$(CONFIG_BD96801_WATCHDOG) +=3D bd96801_wdt.o
 obj-$(CONFIG_CROS_EC_WATCHDOG) +=3D cros_ec_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) +=3D da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) +=3D da9055_wdt.o
diff --git a/drivers/watchdog/bd96801_wdt.c b/drivers/watchdog/bd96801_wdt.c
new file mode 100644
index 000000000000..6069f1d75356
--- /dev/null
+++ b/drivers/watchdog/bd96801_wdt.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ROHM Semiconductors
+ *
+ * ROHM BD96801 watchdog driver
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/rohm-bd96801.h>
+#include <linux/mfd/rohm-generic.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+static bool nowayout;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		"Watchdog cannot be stopped once started (default=3D\"false\")");
+
+#define BD96801_WD_TMO_SHORT_MASK	0x70
+#define BD96801_WD_RATIO_MASK		0x3
+#define BD96801_WD_TYPE_MASK		0x4
+#define BD96801_WD_TYPE_SLOW		0x4
+#define BD96801_WD_TYPE_WIN		0x0
+
+#define BD96801_WD_EN_MASK		0x3
+#define BD96801_WD_IF_EN		0x1
+#define BD96801_WD_QA_EN		0x2
+#define BD96801_WD_DISABLE		0x0
+
+#define BD96801_WD_ASSERT_MASK		0x8
+#define BD96801_WD_ASSERT_RST		0x8
+#define BD96801_WD_ASSERT_IRQ		0x0
+
+#define BD96801_WD_FEED_MASK		0x1
+#define BD96801_WD_FEED			0x1
+
+/* units in uS */
+#define FASTNG_MIN			11
+
+#define BD96801_WDT_DEFAULT_MARGIN_MS	1843
+/* Unit is seconds */
+#define DEFAULT_TIMEOUT 30
+
+/*
+ * BD96801 WDG supports window mode so the TMO consists of SHORT and LONG
+ * timeout values. SHORT time is meaningfull only in window mode where fee=
ding
+ * period shorter than SHORT would be an error. LONG time is used to detec=
t if
+ * feeding is not occurring within given time limit (SoC SW hangs). The LO=
NG
+ * timeout time is a multiple of (2, 4, 8 0r 16 times) the SHORT timeout.
+ */
+
+struct wdtbd96801 {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct watchdog_device	wdt;
+};
+
+static int bd96801_wdt_ping(struct watchdog_device *wdt)
+{
+	struct wdtbd96801 *w =3D watchdog_get_drvdata(wdt);
+
+	return regmap_update_bits(w->regmap, BD96801_REG_WD_FEED,
+				  BD96801_WD_FEED_MASK, BD96801_WD_FEED);
+}
+
+static int bd96801_wdt_start(struct watchdog_device *wdt)
+{
+	struct wdtbd96801 *w =3D watchdog_get_drvdata(wdt);
+
+	return regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
+				  BD96801_WD_EN_MASK, BD96801_WD_IF_EN);
+}
+
+static int bd96801_wdt_stop(struct watchdog_device *wdt)
+{
+	struct wdtbd96801 *w =3D watchdog_get_drvdata(wdt);
+
+	return regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
+				  BD96801_WD_EN_MASK, BD96801_WD_DISABLE);
+}
+
+static const struct watchdog_info bd96801_wdt_info =3D {
+	.options	=3D WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
+			  WDIOF_SETTIMEOUT,
+	.identity	=3D "BD96801 Watchdog",
+};
+
+static const struct watchdog_ops bd96801_wdt_ops =3D {
+	.start		=3D bd96801_wdt_start,
+	.stop		=3D bd96801_wdt_stop,
+	.ping		=3D bd96801_wdt_ping,
+};
+
+static int find_closest_fast(unsigned int target, int *sel, unsigned int *=
val)
+{
+	unsigned int window =3D FASTNG_MIN;
+	int i;
+
+	for (i =3D 0; i < 8 && window < target; i++)
+		window <<=3D 1;
+
+	*val =3D window;
+	*sel =3D i;
+
+	if (i =3D=3D 8)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int find_closest_slow_by_fast(unsigned int fast_val, unsigned int *=
target, int *slowsel)
+{
+	static const int multipliers[] =3D {2, 4, 8, 16};
+	int sel;
+
+	for (sel =3D 0; sel < ARRAY_SIZE(multipliers) &&
+	     multipliers[sel] * fast_val < *target; sel++)
+		;
+
+	if (sel =3D=3D ARRAY_SIZE(multipliers))
+		return -EINVAL;
+
+	*slowsel =3D sel;
+	*target =3D multipliers[sel] * fast_val;
+
+	return 0;
+}
+
+static int find_closest_slow(unsigned int *target, int *slow_sel, int *fas=
t_sel)
+{
+	static const int multipliers[] =3D {2, 4, 8, 16};
+	unsigned int window =3D FASTNG_MIN;
+	unsigned int val =3D 0;
+	int i, j;
+
+	for (i =3D 0; i < 8; i++) {
+		for (j =3D 0; j < ARRAY_SIZE(multipliers); j++) {
+			unsigned int slow;
+
+			slow =3D window * multipliers[j];
+			if (slow >=3D *target && (!val || slow < val)) {
+				val =3D slow;
+				*fast_sel =3D i;
+				*slow_sel =3D j;
+			}
+		}
+		window <<=3D 1;
+	}
+	if (!val)
+		return -EINVAL;
+
+	*target =3D val;
+
+	return 0;
+}
+
+static int bd96801_set_wdt_mode(struct wdtbd96801 *w, unsigned int hw_marg=
in,
+			       unsigned int hw_margin_min)
+{
+	int fastng, slowng, type, ret, reg, mask;
+	struct device *dev =3D w->dev;
+
+	/*
+	 * Convert to 100uS to guarantee reasonable timeouts fit in
+	 * 32bit maintaining also a decent accuracy.
+	 */
+	hw_margin *=3D 10;
+	hw_margin_min *=3D 10;
+
+	if (hw_margin_min) {
+		unsigned int min;
+
+		type =3D BD96801_WD_TYPE_WIN;
+		dev_dbg(dev, "Setting type WINDOW 0x%x\n", type);
+		ret =3D find_closest_fast(hw_margin_min, &fastng, &min);
+		if (ret) {
+			dev_err(dev, "bad WDT window for fast timeout\n");
+			return ret;
+		}
+
+		ret =3D find_closest_slow_by_fast(min, &hw_margin, &slowng);
+		if (ret) {
+			dev_err(dev, "bad WDT window\n");
+			return ret;
+		}
+		w->wdt.min_hw_heartbeat_ms =3D min / 10;
+	} else {
+		type =3D BD96801_WD_TYPE_SLOW;
+		dev_dbg(dev, "Setting type SLOW 0x%x\n", type);
+		ret =3D find_closest_slow(&hw_margin, &slowng, &fastng);
+		if (ret) {
+			dev_err(dev, "bad WDT window\n");
+			return ret;
+		}
+	}
+
+	w->wdt.max_hw_heartbeat_ms =3D hw_margin / 10;
+
+	fastng <<=3D ffs(BD96801_WD_TMO_SHORT_MASK) - 1;
+
+	reg =3D slowng | fastng;
+	mask =3D BD96801_WD_RATIO_MASK | BD96801_WD_TMO_SHORT_MASK;
+	ret =3D regmap_update_bits(w->regmap, BD96801_REG_WD_TMO,
+				 mask, reg);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
+				 BD96801_WD_TYPE_MASK, type);
+
+	return ret;
+}
+
+static int bd96801_set_heartbeat_from_hw(struct wdtbd96801 *w,
+					 unsigned int conf_reg)
+{
+	int ret;
+	unsigned int val, sel, fast;
+
+	/*
+	 * The BD96801 supports a somewhat peculiar QA-mode, which we do not
+	 * support in this driver. If the QA-mode is enabled then we just
+	 * warn and bail-out.
+	 */
+	if ((conf_reg & BD96801_WD_EN_MASK) !=3D BD96801_WD_IF_EN) {
+		dev_warn(w->dev, "watchdog set to Q&A mode - exiting\n");
+		return -EINVAL;
+	}
+
+	ret =3D regmap_read(w->regmap, BD96801_REG_WD_TMO, &val);
+	if (ret)
+		return ret;
+
+	sel =3D val & BD96801_WD_TMO_SHORT_MASK;
+	sel >>=3D ffs(BD96801_WD_TMO_SHORT_MASK) - 1;
+	fast =3D FASTNG_MIN << sel;
+
+	sel =3D (val & BD96801_WD_RATIO_MASK) + 1;
+	w->wdt.max_hw_heartbeat_ms =3D (fast << sel) / USEC_PER_MSEC;
+
+	if ((conf_reg & BD96801_WD_TYPE_MASK) =3D=3D BD96801_WD_TYPE_WIN)
+		w->wdt.min_hw_heartbeat_ms =3D fast / USEC_PER_MSEC;
+
+	return 0;
+}
+
+static int init_wdg_hw(struct wdtbd96801 *w)
+{
+	u32 hw_margin[2];
+	int count, ret;
+	u32 hw_margin_max =3D BD96801_WDT_DEFAULT_MARGIN_MS, hw_margin_min =3D 0;
+
+	count =3D device_property_count_u32(w->dev->parent, "rohm,hw-timeout-ms");
+	if (count < 0 && count !=3D -EINVAL)
+		return count;
+
+	if (count > 0) {
+		if (count > ARRAY_SIZE(hw_margin))
+			return -EINVAL;
+
+		ret =3D device_property_read_u32_array(w->dev->parent,
+						     "rohm,hw-timeout-ms",
+						     &hw_margin[0], count);
+		if (ret < 0)
+			return ret;
+
+		if (count =3D=3D 1)
+			hw_margin_max =3D hw_margin[0];
+
+		if (count =3D=3D 2) {
+			if (hw_margin[1] > hw_margin[0]) {
+				hw_margin_max =3D hw_margin[1];
+				hw_margin_min =3D hw_margin[0];
+			} else {
+				hw_margin_max =3D hw_margin[0];
+				hw_margin_min =3D hw_margin[1];
+			}
+		}
+	}
+
+	ret =3D bd96801_set_wdt_mode(w, hw_margin_max, hw_margin_min);
+	if (ret)
+		return ret;
+
+	ret =3D device_property_match_string(w->dev->parent, "rohm,wdg-action",
+					   "prstb");
+	if (ret >=3D 0) {
+		ret =3D regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
+				 BD96801_WD_ASSERT_MASK,
+				 BD96801_WD_ASSERT_RST);
+		return ret;
+	}
+
+	ret =3D device_property_match_string(w->dev->parent, "rohm,wdg-action",
+					   "intb-only");
+	if (ret >=3D 0) {
+		ret =3D regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
+				 BD96801_WD_ASSERT_MASK,
+				 BD96801_WD_ASSERT_IRQ);
+		return ret;
+	}
+
+	return 0;
+}
+
+extern void emergency_restart(void);
+static irqreturn_t bd96801_irq_hnd(int irq, void *data)
+{
+	emergency_restart();
+
+	return IRQ_NONE;
+}
+
+static int bd96801_wdt_probe(struct platform_device *pdev)
+{
+	struct wdtbd96801 *w;
+	int ret, irq;
+	unsigned int val;
+
+	w =3D devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return -ENOMEM;
+
+	w->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
+	w->dev =3D &pdev->dev;
+
+	w->wdt.info =3D &bd96801_wdt_info;
+	w->wdt.ops =3D  &bd96801_wdt_ops;
+	w->wdt.parent =3D pdev->dev.parent;
+	w->wdt.timeout =3D DEFAULT_TIMEOUT;
+	watchdog_set_drvdata(&w->wdt, w);
+
+	ret =3D regmap_read(w->regmap, BD96801_REG_WD_CONF, &val);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to get the watchdog state\n");
+
+	/*
+	 * If the WDG is already enabled we assume it is configured by boot.
+	 * In this case we just update the hw-timeout based on values set to
+	 * the timeout / mode registers and leave the hardware configs
+	 * untouched.
+	 */
+	if ((val & BD96801_WD_EN_MASK) !=3D BD96801_WD_DISABLE) {
+		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
+		ret =3D bd96801_set_heartbeat_from_hw(w, val);
+		if (ret)
+			return ret;
+
+		set_bit(WDOG_HW_RUNNING, &w->wdt.status);
+	} else {
+		/* If WDG is not running so we will initializate it */
+		ret =3D init_wdg_hw(w);
+		if (ret)
+			return ret;
+	}
+
+	dev_dbg(w->dev, "heartbeat set to %u - %u\n",
+		w->wdt.min_hw_heartbeat_ms, w->wdt.max_hw_heartbeat_ms);
+
+	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
+	watchdog_set_nowayout(&w->wdt, nowayout);
+	watchdog_stop_on_reboot(&w->wdt);
+
+	irq =3D platform_get_irq_byname(pdev, "bd96801-wdg");
+	if (irq > 0) {
+		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						bd96801_irq_hnd,
+						IRQF_ONESHOT,  "bd96801-wdg",
+						NULL);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to register IRQ\n");
+	}
+
+	return devm_watchdog_register_device(&pdev->dev, &w->wdt);
+}
+
+static const struct platform_device_id bd96801_wdt_id[] =3D {
+	{ "bd96801-wdt", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, bd96801_wdt_id);
+
+static struct platform_driver bd96801_wdt =3D {
+	.driver =3D {
+		.name =3D "bd96801-wdt"
+	},
+	.probe =3D bd96801_wdt_probe,
+	.id_table =3D bd96801_wdt_id,
+};
+module_platform_driver(bd96801_wdt);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD96801 watchdog driver");
+MODULE_LICENSE("GPL");
--=20
2.44.0


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

--zmtLMzOYuNxYSMSt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYw3aEACgkQeFA3/03a
ocVldggAm+2V/6GX5lpzm1sxBgsYNSO2BY3hGxG12yHjk16UNGB1Z1vf3T76Olrx
hbd1WZu9jOGHiLTIlt4nDMrgEGt/IZ7j5O0IOSid9N5nyAnoUPZxEk4rmMda2o2O
vCZSuMSfhOQ/KOrSJnmRqxXME3xiGVug7y0499QWggT5vi6V1qSV/tbfYhDI551l
nUBOmh0qXL5Ye1huf+W12M9JkHvew6WXIrR0dYMiCQPvYStmj39m80BSwMaK47IS
MBFriIdpHHwA64k9CbPVOkvDOni2xnUZFh1v1CG2x3A2WR30oJVQ+fjYdChcvQSA
UoVJAvIrHDCkciNuUj9aG1s/va+9Ew==
=yLPp
-----END PGP SIGNATURE-----

--zmtLMzOYuNxYSMSt--

