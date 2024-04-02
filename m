Return-Path: <linux-kernel+bounces-128010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4B8954ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DA7288F85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56F1292C9;
	Tue,  2 Apr 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF4q5kVQ"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6B84A52;
	Tue,  2 Apr 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063515; cv=none; b=ZD8SRt8BZ3Os9g3Q/R9kv65YxMzS5hUF12Zftft2BDn6bI9xlMUaGKNX1mumBMgRsZHqWs3NDjOVeD/JO780IAld5rPjM/yXMe7Xes5JPLOv+cMzMMUIrEYhb8kSVCED8EgT1AWplu8nNBReDCoqzBez7dArMCKvMtAWyVcOT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063515; c=relaxed/simple;
	bh=qGt5iRI0K8zpkOpv8lPhpSuDh5VnQX3sA76dNXvYPF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtAWuMGdAWfoilGoGGNhr1tfKcYiQFusOqlB+T8h4IPWSbTDRN4Ud4tYIR+/Orsed9e16EgDuKkBdEZT4xFkaLRAhUa/1rrJpoqU2UHK821G1I9WeRr5MEGDvN1SxWUlfva1epvSdZ/zOn0eNaxEQBNAecYfh+tEagTyLUVqE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF4q5kVQ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so53621851fa.3;
        Tue, 02 Apr 2024 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063511; x=1712668311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8Gs10CeDaTSe5ADrLJyCGEWg8jY8aRJq8qad0f7Q58=;
        b=XF4q5kVQFpqJAMJ0szE9B9yoaEg/J7PJCk/UJDMk5ofWKsgnj15lL1ckeZERYAO+8m
         mxNJ9TTocuE04o0qwQrQ6pTJBkF+U/i3akXimP2zkBBUhYEoVWv5pi2FYfegi5x9iaC0
         J92m9IZ8eFbrunk/fEGlFFaZ1pE3Y4MC24k6ymtprlwU7E+PxiJFXZUQcQLh0+eJm9yw
         MKNcmRhBCfoSSBsSq63sZ4yGcnH8YDe+1Yzm74TGXJ0jLo6NkuGnrsyk+PZPes+aBzlG
         tRBnpF5QSRaEh6gsSYloagzmwAKsC4qTVhkfwLiPK/lvI3wa47r+0z2HlP0PdAvEdAKT
         23Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063511; x=1712668311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8Gs10CeDaTSe5ADrLJyCGEWg8jY8aRJq8qad0f7Q58=;
        b=hpzlOaG8ngvFEZdP0hyTO1t7RbiHKa/9FSPQIqR8AYlNc7ad3xndr6jqitzF2Jl7BY
         5qrSAdQyEUnqTSQEqnBIlmz4M4ryYmX4MSHnBebrKDhkuSwFtRzsSRQLX2nGcxMO9IzF
         4ufBqLMBa0KU5mD1NJaoAXY2aNHP5aeOnBd/p0SEaUbHp4ZEPX4RaKWz4Al3wug2Yl48
         PgyQzVyacZjE0X21QnyKyjy1IKeNmWPmUvtdi0TlVdYlHX7NWaLnbCmKTrTgSd6Jxf6v
         zH030HAUhaPfln79WXy58xnDJorOkJeSydqwTOJHhy3HxF9lJBrXk3qUrCdeMRdxj+BR
         S/iA==
X-Forwarded-Encrypted: i=1; AJvYcCUfVr1WmnxLLerSqgVx1TQgWg7ZlxZWJx+uCntFT0lVLbc710KqIAoOwRHyoaCHfR0rHPz4gvPIhRPd2hj0RWfzyv1mX8cssF1R0fF1DZwgbtmYMbvtI6xfkvlSzLA6oJyqPRKA4e0DJj4GbrEtm67tTeyChkpXuJWC5zzr7+WOci5PjZXhoCF+
X-Gm-Message-State: AOJu0YylSBn12CIaYCknNQy/BLBlonbpbdNsUnuV8EOX/8EubwQPlRo1
	hISO1Lkvy+JqNnQzGKAln7Aa1fHON7btftJwziIED9XppZTNbLWkTNZYYg8o
X-Google-Smtp-Source: AGHT+IHqX+8OaYDd9FjZkgwMs3buJX7CwodBKBXVoQG5uogRujwpDqC8mziCzGIX88ZCpl8Dvq8fNQ==
X-Received: by 2002:a2e:9996:0:b0:2d6:c5c6:f5b1 with SMTP id w22-20020a2e9996000000b002d6c5c6f5b1mr9211945lji.23.1712063506592;
        Tue, 02 Apr 2024 06:11:46 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w13-20020a2ea3cd000000b002d6ebf4a491sm1638439lje.44.2024.04.02.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:11:45 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:11:41 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Message-ID: <f8e743a6c49607de0dd7a27778383477e051b130.1712058690.git.mazziesaccount@gmail.com>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ORI/UsGENi/cI1aq"
Content-Disposition: inline
In-Reply-To: <cover.1712058690.git.mazziesaccount@gmail.com>


--ORI/UsGENi/cI1aq
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
 drivers/watchdog/Kconfig       |  13 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/bd96801_wdt.c | 375 +++++++++++++++++++++++++++++++++
 3 files changed, 389 insertions(+)
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
index 000000000000..cb2b526ecc21
--- /dev/null
+++ b/drivers/watchdog/bd96801_wdt.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 ROHM Semiconductors
+ *
+ * ROHM BD96801 watchdog driver
+ */
+
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
+#define FASTNG_MIN			3370
+#define BD96801_WDT_DEFAULT_MARGIN	6905120
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
+	bool			always_running;
+	struct watchdog_device	wdt;
+};
+
+static int bd96801_wdt_ping(struct watchdog_device *wdt)
+{
+	struct wdtbd96801 *w =3D watchdog_get_drvdata(wdt);
+
+	return regmap_update_bits(w->regmap, BD96801_REG_WD_FEED,
+				 BD96801_WD_FEED_MASK, BD96801_WD_FEED);
+}
+
+static int bd96801_wdt_start(struct watchdog_device *wdt)
+{
+	struct wdtbd96801 *w =3D watchdog_get_drvdata(wdt);
+	int ret;
+
+	ret =3D regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
+				 BD96801_WD_EN_MASK, BD96801_WD_IF_EN);
+
+	return ret;
+}
+
+static int bd96801_wdt_stop(struct watchdog_device *wdt)
+{
+	struct wdtbd96801 *w =3D watchdog_get_drvdata(wdt);
+
+	if (!w->always_running)
+		return regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
+				 BD96801_WD_EN_MASK, BD96801_WD_DISABLE);
+	set_bit(WDOG_HW_RUNNING, &wdt->status);
+
+	return 0;
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
+static int find_closest_fast(int target, int *sel, int *val)
+{
+	int i;
+	int window =3D FASTNG_MIN;
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
+static int find_closest_slow_by_fast(int fast_val, int *target, int *slows=
el)
+{
+	int sel;
+	static const int multipliers[] =3D {2, 4, 8, 16};
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
+static int find_closest_slow(int *target, int *slow_sel, int *fast_sel)
+{
+	static const int multipliers[] =3D {2, 4, 8, 16};
+	int i, j;
+	int val =3D 0;
+	int window =3D FASTNG_MIN;
+
+	for (i =3D 0; i < 8; i++) {
+		for (j =3D 0; j < ARRAY_SIZE(multipliers); j++) {
+			int slow;
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
+static int bd96801_set_wdt_mode(struct wdtbd96801 *w, int hw_margin,
+			       int hw_margin_min)
+{
+	int ret, fastng, slowng, type, reg, mask;
+	struct device *dev =3D w->dev;
+
+	/* convert to uS */
+	hw_margin *=3D 1000;
+	hw_margin_min *=3D 1000;
+	if (hw_margin_min) {
+		int min;
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
+		w->wdt.min_hw_heartbeat_ms =3D min / 1000;
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
+	w->wdt.max_hw_heartbeat_ms =3D hw_margin / 1000;
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
+	u32 hw_margin_max =3D BD96801_WDT_DEFAULT_MARGIN, hw_margin_min =3D 0;
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
+			hw_margin_max =3D hw_margin[1];
+			hw_margin_min =3D hw_margin[0];
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
+static int bd96801_wdt_probe(struct platform_device *pdev)
+{
+	struct wdtbd96801 *w;
+	int ret;
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
+	w->always_running =3D device_property_read_bool(pdev->dev.parent,
+						      "always-running");
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
+	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
+	watchdog_set_nowayout(&w->wdt, nowayout);
+	watchdog_stop_on_reboot(&w->wdt);
+
+	if (w->always_running)
+		bd96801_wdt_start(&w->wdt);
+
+	return devm_watchdog_register_device(&pdev->dev, &w->wdt);
+}
+
+static struct platform_driver bd96801_wdt =3D {
+	.driver =3D {
+		.name =3D "bd96801-wdt"
+	},
+	.probe =3D bd96801_wdt_probe,
+};
+module_platform_driver(bd96801_wdt);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD96801 watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd96801-wdt");
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

--ORI/UsGENi/cI1aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYMBAwACgkQeFA3/03a
ocW7iAf+KgMrrpYwl5lvQuixsYr/ZzUpZ2OF8Kg15MDl8ATcyZBWqUTq53ZQjHI8
j+vZYCTfqfQFhAlAmJsfpmNY5VlIfxmJWCnBFmRt3fR/65uNumQGgGcu4uMKY83v
XsPi5N7hR/sAHZVWWWSP4ywNVJR5nxC5KjdoUVEmuYrIebvs/jxvjyhwYiT1qmPB
5cAd8LQgIW/UMt2QzteGehjK1p0fGCrgpQ2WQ4uuSqeqhs5W5KOcJ7QUhlkrmp+G
SjdMQ46nbKbXf6AIBCcc5YjcIeAiGBQdQuqhv5qHdnuRtwO5fiGi3m7pPk7y+IKe
9jRDZhUa0Q/CEZ2R0Fb83DxcuKx7ig==
=vF5o
-----END PGP SIGNATURE-----

--ORI/UsGENi/cI1aq--

