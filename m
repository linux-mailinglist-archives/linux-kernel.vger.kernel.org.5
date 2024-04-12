Return-Path: <linux-kernel+bounces-142569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C88A2D43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2DB1F22EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B08753811;
	Fri, 12 Apr 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXPaSMQX"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B054670;
	Fri, 12 Apr 2024 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920975; cv=none; b=czeHYucu49V0gjdzcjcnQJbyzKwR482KklVBzewNAGfS+lAzRG9l5cKemWZVLe4UKS1p9hZkuF5wn9H2uMB0s2/q+ZUUaRcX4eGIUD8AbmWrgya2cMyAtxDt3qYpcdAI0QTx2APFQwOaBFRHyIKQkOZMnXWIq2zJTNkqm3KStzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920975; c=relaxed/simple;
	bh=7VRuVeqJpE/HL9U5475Bsfa08nEPvxrOFrhiR4M6pRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC6I7s2cDhkL3iX8ELRT6v65N3Vcpmr8D/sSi6dnTa36inled18aekO3AWdrmfGBihzq2Dm7oiBwtWRvPpTQVArb5/qifXEG0KhAqMy2Ar5tAGqg1OiIrcnDIRBdxV96ZuU/hRmw+KjYfJiUeJMDVBAnwaMxNUC/esU9IzwvYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXPaSMQX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d3776334so1027920e87.1;
        Fri, 12 Apr 2024 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712920972; x=1713525772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4STWKI2lb8P3u5Uj3xotvbRcQh3eVz9AayDWUkWaaA=;
        b=KXPaSMQX7LYxnZ8A2hiAStU3K1Dy0+Sjkv/CXT1oYCEbZ5MTdGpn1C4FFuf1aHaJdy
         chTECTYlcvnZdrlDArvZxMzrZGLJSJpDqYwNceRIwNVamPlQeCQWz8mH3tbE02+k3spx
         hxxbAGFUEl1ctCCdNu/TZ6Cln6twMlGdnycigfd4TP8BSgRe7aonPE7QTew1cfGc5MWq
         WG6yC5QzrpGhuQboXVpsS3X9tCVodb8nBwk9Ul4FlXyw6nlUBVEQ6aRa1K0vBuV3O+yn
         eKalXcGhRciiffs6RhoxlHpKFuSELLZpoOKZkCmC4R0wzcfzYFAGjdnaFKGkJWTlgZ4h
         tpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712920972; x=1713525772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4STWKI2lb8P3u5Uj3xotvbRcQh3eVz9AayDWUkWaaA=;
        b=nOz6ZAB73X+PMjfwSHzqPlCWoJJWHAUSU7bwws8efZbhJflLS36XRA/1cXucGk+YFe
         0akhRxXUU5dH+322HkezT8USCQNuZz1febN2rmayYNMHk3HvjIUTybyC02VGDaDqFkPI
         4rlzA7GspTZWDG4A0V5FcyR2MnSyIIvc20S9RsQbqCNwZgiwtfzgzDqOY/kdwQFIkSsE
         jYFCEcvrlhehsPa3VifVxh2xkmSyZoFOZkuA9u9Twh40R93yyRSlSrVnpAWvIWOvlp3+
         HS0Cz8Ooo8TbZAbjI11KG4E9wuAbIkOG6xwCgP894/CnQkdb/7+t/V+2gPZTNc+f14eQ
         YuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0PvC08GqvtSCETuLLPUXyOTXdK7egJYTiHgklMM/DQ1gzfFhifekmFA/ASX/Fk3j7bltUZEoTI46A5LonF1aFL9LV8IKMOxoy1N8HxvkmLedtKeWNrATK2tDJMci8afon11GT0Zo6BZbB8yhdklzkEDpxqV2bsw/v5abLlLWGlmp5wRSgc8Mq
X-Gm-Message-State: AOJu0YxSfo34PQM9ZdNa/fhB1kKC2ONNc/QXKnhA7zohWinCHg4N725F
	zkX/TLpi5GnK04f7kcZvO88/j4GjKBOOTNVQaWYE+V4AvEa/M/Ic
X-Google-Smtp-Source: AGHT+IFWEJj3Poq8Hn8frLp95R9BnK2HLmscPAkR2GjeckphlpYfDo6T7QhRSD0mFsdfu+/qM+g0rw==
X-Received: by 2002:ac2:48a7:0:b0:516:d0d5:6f60 with SMTP id u7-20020ac248a7000000b00516d0d56f60mr1718635lfg.38.1712920971532;
        Fri, 12 Apr 2024 04:22:51 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id s23-20020a197717000000b00516a25e9ce1sm507183lfc.294.2024.04.12.04.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:22:50 -0700 (PDT)
Date: Fri, 12 Apr 2024 14:22:46 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH v2 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Message-ID: <d52fd63e98635293022e5a607fd763b580e24189.1712920132.git.mazziesaccount@gmail.com>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wzoSZayes0OpL2hG"
Content-Disposition: inline
In-Reply-To: <cover.1712920132.git.mazziesaccount@gmail.com>


--wzoSZayes0OpL2hG
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
RFCv1 =3D> RFCv2:
- remove always running
- add IRQ handling
- call emergency_restart()
- drop MODULE_ALIAS and add MODULE_DEVICE_TABLE
---
 drivers/watchdog/Kconfig       |  13 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/bd96801_wdt.c | 389 +++++++++++++++++++++++++++++++++
 3 files changed, 403 insertions(+)
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
index 000000000000..08fab9a87aec
--- /dev/null
+++ b/drivers/watchdog/bd96801_wdt.c
@@ -0,0 +1,389 @@
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
+extern void emergency_restart(void);
+static irqreturn_t bd96801_irq_hnd(int irq, void *data)
+{
+	emergency_restart();
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

--wzoSZayes0OpL2hG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYZGYYACgkQeFA3/03a
ocUOAwgAjbZxxDFR7/Kdt+1+nDqp0npWMdd/KdWT97nOhLY1uiG0tzL2QLkuJdZA
RWLc2zyvf6+Dp24pViMokRVlfj5wm9TLLbu3LJdxHxjRXZph9Tbx2IOvkXE/IE+Y
7nuEy7AxYADwRNGnQIn6D18Tg1nDHDbCqirfyXl0YmYECwcfDWQQW1CUsl3/WdsO
HD3Yz60YDLChqTsTFvTLruYRyOYFH6f7OnfeJgXSgaBqYlYwai5fg8eM2Ns/Wnu7
UMHzWyUboxv7VUwOBWwia6pI2uamrgqLYTKryeqtIL2jrUzdkaeJJoc4Dw/gYw1+
1Ub3vJAQKx5i1WnLxjuZaEPb+nxmsg==
=RyXo
-----END PGP SIGNATURE-----

--wzoSZayes0OpL2hG--

