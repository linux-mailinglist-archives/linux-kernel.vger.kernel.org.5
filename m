Return-Path: <linux-kernel+bounces-21953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B582970B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626111C25CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467203F8F0;
	Wed, 10 Jan 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrX9q1HJ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415113F8FB;
	Wed, 10 Jan 2024 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e741123acso4325874e87.0;
        Wed, 10 Jan 2024 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704881580; x=1705486380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNmekI8FqdK3KkKNSH8ho3ASdFd880+1WLuo6qQkhh4=;
        b=QrX9q1HJILIwati6DsCzu1Xy0LNxj3Skfsw43wsn40grZEgmtK+X4b2e9bQ2GY8pQd
         43D0FZumSPOs+ms6R6XsMsU9enZIceathDb6y+Z/A6J7BJReJV/ABPLCViDyXrI3BcHq
         7YsrEFISfaDqJ1mZEaMuGJSeojkwLH3jg5lFuyHc9zkXBuBJKxWvWzNVBaFQ2B1wiM5J
         ze9zjPZndEXCnEuDnI0mwNMLotF/t9doflgvCWy/yHO6cJSfao1Vj4xhXW117LaNBXN+
         PxqT2cXuMs8saV5wFW+7yjRFrkLsoCVYuKOuV8BWpNKWxF7y3O7cToTHzuAtVU7RLDRf
         CPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704881580; x=1705486380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNmekI8FqdK3KkKNSH8ho3ASdFd880+1WLuo6qQkhh4=;
        b=tiruXetsI5KXv1JJxYmnBR+UNkZfWqUp0PKebDEVo7DpKOvT5GDR+ErPVxoZPhmMlv
         ljhVSRM7O2wHCbsJYmpbuCdVGTYVlo6p3d/MByk7+LTTsnQGOYuBKWRMfDnPrAizmSK9
         Gn0pEIVUtdzQWY6WufnFwvAhF2jA2Wqt/Ui+m+4TBlYpPkB0w9JofUfvIDVdUJqg2ZXH
         mKFgl0CYAvRcFXTVOnh3nztFJ8a2Kk4I7owvzaBiwOH2z5xzyajvjbFYtLxivrJewMWu
         LprsaocYtUzhcXGu7HqCwzha+dvwAAdh8Wh+kVW2B0u9MBgbmjThh3/FKx0hYabXZ3zN
         xGMA==
X-Gm-Message-State: AOJu0Yw1LybaQZ6hZYWdb94vTDYwat+PIV46F1C954oMgd0PY7CCDKbu
	W5/p5pqQODzx8dt8JgzRKZQ=
X-Google-Smtp-Source: AGHT+IFWb9keTLE/Gfg2HaJpGrRhIpofTP5bvf7rShnadWhU7nUA/0qExDChzyq+uL5xbEqT+huEfg==
X-Received: by 2002:a05:6512:4026:b0:50e:8106:9e87 with SMTP id br38-20020a056512402600b0050e81069e87mr374897lfb.11.1704881579846;
        Wed, 10 Jan 2024 02:12:59 -0800 (PST)
Received: from drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id i29-20020a0565123e1d00b0050e76f019b7sm614192lfv.119.2024.01.10.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:12:58 -0800 (PST)
Date: Wed, 10 Jan 2024 12:12:55 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 2/3] iio: test: test gain-time-scale helpers
Message-ID: <6b839dd533fd93b75c2e6f6a8f2286233d4901fb.1704881096.git.mazziesaccount@gmail.com>
References: <cover.1704881096.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e/ypoMxtAn9bAWuu"
Content-Disposition: inline
In-Reply-To: <cover.1704881096.git.mazziesaccount@gmail.com>


--e/ypoMxtAn9bAWuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some light sensors can adjust both the HW-gain and integration time.
There are cases where adjusting the integration time has similar impact
to the scale of the reported values as gain setting has.

IIO users do typically expect to handle scale by a single writable 'scale'
entry. Driver should then adjust the gain/time accordingly.

It however is difficult for a driver to know whether it should change
gain or integration time to meet the requested scale. Usually it is
preferred to have longer integration time which usually improves
accuracy, but there may be use-cases where long measurement times can be
an issue. Thus it can be preferable to allow also changing the
integration time - but mitigate the scale impact by also changing the gain
underneath. Eg, if integration time change doubles the measured values,
the driver can reduce the HW-gain to half.

The theory of the computations of gain-time-scale is simple. However,
some people (undersigned) got that implemented wrong for more than once.
Hence some gain-time-scale helpers were introduced.

Add some simple tests to verify the most hairy functions.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

This patch depends on the KUnit managed device APIs which seem to get
merged to v6.8-rc1.

Changes:
v6 =3D> v7:
- Fix available integration times to be expressed in seconds

v5 =3D> v6:
- Use kunit root-device registration wrapper

v4 =3D> v5:
- remove empty lines from Kconfig
- adapt to drop of the non devm iio_init
- test also init with couple of invalid tables

v3 =3D> v4:
- use dummy device to test devm interfaces
- adapt to the new header location
- drop tests for dropped interfaces

v2 =3D> v3:
- Use namespace for iio-gts-helpers

RFCv1 =3D> v2:
- add tests for available scales/times helpers
- adapt to renamed iio-gts-helpers.h header
---
 drivers/iio/test/Kconfig        |  14 +
 drivers/iio/test/Makefile       |   1 +
 drivers/iio/test/iio-test-gts.c | 517 ++++++++++++++++++++++++++++++++
 3 files changed, 532 insertions(+)
 create mode 100644 drivers/iio/test/iio-test-gts.c

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 0b6e4e278a2f..33cca49c8058 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,20 @@
 #
=20
 # Keep in alphabetical order
+config IIO_GTS_KUNIT_TEST
+	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select IIO_GTS_HELPER
+	select TEST_KUNIT_DEVICE_HELPERS
+	default KUNIT_ALL_TESTS
+	help
+	  build unit tests for the IIO light sensor gain-time-scale helpers.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N. Keep in alphabetical order
+
 config IIO_RESCALE_KUNIT_TEST
 	tristate "Test IIO rescale conversion functions" if !KUNIT_ALL_TESTS
 	depends on KUNIT && IIO_RESCALE
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index d76eaf36da82..e9a4cf1ff57f 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -6,4 +6,5 @@
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) +=3D iio-test-rescale.o
 obj-$(CONFIG_IIO_FORMAT_KUNIT_TEST) +=3D iio-test-format.o
+obj-$(CONFIG_IIO_GTS_KUNIT_TEST) +=3D iio-test-gts.o
 CFLAGS_iio-test-format.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gt=
s.c
new file mode 100644
index 000000000000..4d5271b0c7bc
--- /dev/null
+++ b/drivers/iio/test/iio-test-gts.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unit tests for IIO light sensor gain-time-scale helpers
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <linux/device.h>
+#include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/types.h>
+
+/*
+ * Please, read the "rant" from the top of the lib/test_linear_ranges.c if
+ * you see a line of helper code which is not being tested.
+ *
+ * Then, please look at the line which is not being tested. Is this line
+ * somehow unusually complex? If answer is "no", then chances are that the
+ * "development inertia" caused by adding a test exceeds the benefits.
+ *
+ * If yes, then adding a test is probably a good idea but please stop for a
+ * moment and consider the effort of changing all the tests when code gets
+ * refactored. Eventually it neeeds to be.
+ */
+
+#define TEST_TSEL_50		1
+#define TEST_TSEL_X_MIN		TEST_TSEL_50
+#define TEST_TSEL_100		0
+#define TEST_TSEL_200		2
+#define TEST_TSEL_400		4
+#define TEST_TSEL_X_MAX		TEST_TSEL_400
+
+#define TEST_GSEL_1		0x00
+#define TEST_GSEL_X_MIN		TEST_GSEL_1
+#define TEST_GSEL_4		0x08
+#define TEST_GSEL_16		0x0a
+#define TEST_GSEL_32		0x0b
+#define TEST_GSEL_64		0x0c
+#define TEST_GSEL_256		0x18
+#define TEST_GSEL_512		0x19
+#define TEST_GSEL_1024		0x1a
+#define TEST_GSEL_2048		0x1b
+#define TEST_GSEL_4096		0x1c
+#define TEST_GSEL_X_MAX		TEST_GSEL_4096
+
+#define TEST_SCALE_1X		64
+#define TEST_SCALE_MIN_X	TEST_SCALE_1X
+#define TEST_SCALE_2X		32
+#define TEST_SCALE_4X		16
+#define TEST_SCALE_8X		8
+#define TEST_SCALE_16X		4
+#define TEST_SCALE_32X		2
+#define TEST_SCALE_64X		1
+
+#define TEST_SCALE_NANO_128X	500000000
+#define TEST_SCALE_NANO_256X	250000000
+#define TEST_SCALE_NANO_512X	125000000
+#define TEST_SCALE_NANO_1024X	62500000
+#define TEST_SCALE_NANO_2048X	31250000
+#define TEST_SCALE_NANO_4096X	15625000
+#define TEST_SCALE_NANO_4096X2	7812500
+#define TEST_SCALE_NANO_4096X4	3906250
+#define TEST_SCALE_NANO_4096X8	1953125
+
+#define TEST_SCALE_NANO_MAX_X TEST_SCALE_NANO_4096X8
+
+/*
+ * Can't have this allocated from stack because the kunit clean-up will
+ * happen only after the test function has already gone
+ */
+static struct iio_gts gts;
+
+static const struct iio_gain_sel_pair gts_test_gains[] =3D {
+	GAIN_SCALE_GAIN(1, TEST_GSEL_1),
+	GAIN_SCALE_GAIN(4, TEST_GSEL_4),
+	GAIN_SCALE_GAIN(16, TEST_GSEL_16),
+	GAIN_SCALE_GAIN(32, TEST_GSEL_32),
+	GAIN_SCALE_GAIN(64, TEST_GSEL_64),
+	GAIN_SCALE_GAIN(256, TEST_GSEL_256),
+	GAIN_SCALE_GAIN(512, TEST_GSEL_512),
+	GAIN_SCALE_GAIN(1024, TEST_GSEL_1024),
+	GAIN_SCALE_GAIN(2048, TEST_GSEL_2048),
+	GAIN_SCALE_GAIN(4096, TEST_GSEL_4096),
+#define HWGAIN_MAX 4096
+};
+
+static const struct iio_itime_sel_mul gts_test_itimes[] =3D {
+	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
+	GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
+	GAIN_SCALE_ITIME_US(100 * 1000, TEST_TSEL_100, 2),
+	GAIN_SCALE_ITIME_US(50 * 1000, TEST_TSEL_50, 1),
+#define TIMEGAIN_MAX 8
+};
+#define TOTAL_GAIN_MAX	(HWGAIN_MAX * TIMEGAIN_MAX)
+#define IIO_GTS_TEST_DEV "iio-gts-test-dev"
+
+static struct device *__test_init_iio_gain_scale(struct kunit *test,
+		struct iio_gts *gts, const struct iio_gain_sel_pair *g_table,
+		int num_g, const struct iio_itime_sel_mul *i_table, int num_i)
+{
+	struct device *dev;
+	int ret;
+
+	dev =3D kunit_device_register(test, IIO_GTS_TEST_DEV);
+
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
+	if (IS_ERR_OR_NULL(dev))
+		return NULL;
+
+	ret =3D devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, g_table, num_g,
+				    i_table, num_i, gts);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return NULL;
+
+	return dev;
+}
+
+#define test_init_iio_gain_scale(test, gts)	\
+	__test_init_iio_gain_scale(test, gts, gts_test_gains, \
+				   ARRAY_SIZE(gts_test_gains), gts_test_itimes, \
+				   ARRAY_SIZE(gts_test_itimes))
+
+static void test_init_iio_gts_invalid(struct kunit *test)
+{
+	struct device *dev;
+	int ret;
+	const struct iio_itime_sel_mul itimes_neg[] =3D {
+		GAIN_SCALE_ITIME_US(-10, TEST_TSEL_400, 8),
+		GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
+	};
+	const struct iio_gain_sel_pair gains_neg[] =3D {
+		GAIN_SCALE_GAIN(1, TEST_GSEL_1),
+		GAIN_SCALE_GAIN(2, TEST_GSEL_4),
+		GAIN_SCALE_GAIN(-2, TEST_GSEL_16),
+	};
+	/* 55555 * 38656 =3D 2147534080 =3D> overflows 32bit int */
+	const struct iio_itime_sel_mul itimes_overflow[] =3D {
+		GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 55555),
+		GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
+	};
+	const struct iio_gain_sel_pair gains_overflow[] =3D {
+		GAIN_SCALE_GAIN(1, TEST_GSEL_1),
+		GAIN_SCALE_GAIN(2, TEST_GSEL_4),
+		GAIN_SCALE_GAIN(38656, TEST_GSEL_16),
+	};
+
+	dev =3D kunit_device_register(test, IIO_GTS_TEST_DEV);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
+	if (!dev)
+		return;
+
+	/* Ok gains, negative time */
+	ret =3D devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, gts_test_gains,
+				    ARRAY_SIZE(gts_test_gains), itimes_neg,
+				    ARRAY_SIZE(itimes_neg), &gts);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	/* Ok times, negative gain */
+	ret =3D devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, gains_neg,
+				    ARRAY_SIZE(gains_neg), gts_test_itimes,
+				    ARRAY_SIZE(gts_test_itimes), &gts);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	/* gain * time overflow int */
+	ret =3D devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, gains_overflow,
+				    ARRAY_SIZE(gains_overflow), itimes_overflow,
+				    ARRAY_SIZE(itimes_overflow), &gts);
+	KUNIT_EXPECT_EQ(test, -EOVERFLOW, ret);
+}
+
+static void test_iio_gts_find_gain_for_scale_using_time(struct kunit *test)
+{
+	struct device *dev;
+	int ret, gain_sel;
+
+	dev =3D test_init_iio_gain_scale(test, &gts);
+	if (!dev)
+		return;
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_100,
+						TEST_SCALE_8X, 0, &gain_sel);
+	/*
+	 * Meas time 100 =3D> gain by time 2x
+	 * TEST_SCALE_8X matches total gain 8x
+	 * =3D> required HWGAIN 4x
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_4, gain_sel);
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_200, 0,
+						TEST_SCALE_NANO_256X, &gain_sel);
+	/*
+	 * Meas time 200 =3D> gain by time 4x
+	 * TEST_SCALE_256X matches total gain 256x
+	 * =3D> required HWGAIN 256/4 =3D> 64x
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_64, gain_sel);
+
+	/* Min time, Min gain */
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_X_MIN,
+						TEST_SCALE_MIN_X, 0, &gain_sel);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_1, gain_sel);
+
+	/* Max time, Max gain */
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_X_MAX,
+					0, TEST_SCALE_NANO_MAX_X, &gain_sel);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_4096, gain_sel);
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_100, 0,
+						TEST_SCALE_NANO_256X, &gain_sel);
+	/*
+	 * Meas time 100 =3D> gain by time 2x
+	 * TEST_SCALE_256X matches total gain 256x
+	 * =3D> required HWGAIN 256/2 =3D> 128x (not in gain-table - unsupported)
+	 */
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_200, 0,
+						TEST_SCALE_NANO_MAX_X, &gain_sel);
+	/* We can't reach the max gain with integration time smaller than MAX */
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_50, 0,
+						TEST_SCALE_NANO_MAX_X, &gain_sel);
+	/* We can't reach the max gain with integration time smaller than MAX */
+	KUNIT_EXPECT_NE(test, 0, ret);
+}
+
+static void test_iio_gts_find_new_gain_sel_by_old_gain_time(struct kunit *=
test)
+{
+	struct device *dev;
+	int ret, old_gain, new_gain, old_time_sel, new_time_sel;
+
+	dev =3D test_init_iio_gain_scale(test, &gts);
+	if (!dev)
+		return;
+
+	old_gain =3D 32;
+	old_time_sel =3D TEST_TSEL_200;
+	new_time_sel =3D TEST_TSEL_400;
+
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * Doubling the integration time doubles the total gain - so old
+	 * (hw)gain must be divided by two to compensate. =3D> 32 / 2 =3D> 16
+	 */
+	KUNIT_EXPECT_EQ(test, 16, new_gain);
+
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_50;
+	new_time_sel =3D TEST_TSEL_200;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * gain by time 1x =3D> 4x - (hw)gain 4x =3D> 1x
+	 */
+	KUNIT_EXPECT_EQ(test, 1, new_gain);
+
+	old_gain =3D 512;
+	old_time_sel =3D TEST_TSEL_400;
+	new_time_sel =3D TEST_TSEL_50;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * gain by time 8x =3D> 1x - (hw)gain 512x =3D> 4096x)
+	 */
+	KUNIT_EXPECT_EQ(test, 4096, new_gain);
+
+	/* Unsupported gain 2x */
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_200;
+	new_time_sel =3D TEST_TSEL_400;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	/* Too small gain */
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_50;
+	new_time_sel =3D TEST_TSEL_400;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	/* Too big gain */
+	old_gain =3D 1024;
+	old_time_sel =3D TEST_TSEL_400;
+	new_time_sel =3D TEST_TSEL_50;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+}
+
+static void test_iio_find_closest_gain_low(struct kunit *test)
+{
+	struct device *dev;
+	bool in_range;
+	int ret;
+
+	const struct iio_gain_sel_pair gts_test_gains_gain_low[] =3D {
+		GAIN_SCALE_GAIN(4, TEST_GSEL_4),
+		GAIN_SCALE_GAIN(16, TEST_GSEL_16),
+		GAIN_SCALE_GAIN(32, TEST_GSEL_32),
+	};
+
+	dev =3D test_init_iio_gain_scale(test, &gts);
+	if (!dev)
+		return;
+
+	ret =3D iio_find_closest_gain_low(&gts, 2, &in_range);
+	KUNIT_EXPECT_EQ(test, 1, ret);
+	KUNIT_EXPECT_EQ(test, true, in_range);
+
+	ret =3D iio_find_closest_gain_low(&gts, 1, &in_range);
+	KUNIT_EXPECT_EQ(test, 1, ret);
+	KUNIT_EXPECT_EQ(test, true, in_range);
+
+	ret =3D iio_find_closest_gain_low(&gts, 4095, &in_range);
+	KUNIT_EXPECT_EQ(test, 2048, ret);
+	KUNIT_EXPECT_EQ(test, true, in_range);
+
+	ret =3D iio_find_closest_gain_low(&gts, 4097, &in_range);
+	KUNIT_EXPECT_EQ(test, 4096, ret);
+	KUNIT_EXPECT_EQ(test, false, in_range);
+
+	kunit_device_unregister(test, dev);
+
+	dev =3D __test_init_iio_gain_scale(test, &gts, gts_test_gains_gain_low,
+				ARRAY_SIZE(gts_test_gains_gain_low),
+				gts_test_itimes, ARRAY_SIZE(gts_test_itimes));
+	if (!dev)
+		return;
+
+	ret =3D iio_find_closest_gain_low(&gts, 3, &in_range);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+	KUNIT_EXPECT_EQ(test, false, in_range);
+
+}
+
+static void test_iio_gts_total_gain_to_scale(struct kunit *test)
+{
+	struct device *dev;
+	int ret, scale_int, scale_nano;
+
+	dev =3D test_init_iio_gain_scale(test, &gts);
+	if (!dev)
+		return;
+
+	ret =3D iio_gts_total_gain_to_scale(&gts, 1, &scale_int, &scale_nano);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_SCALE_1X, scale_int);
+	KUNIT_EXPECT_EQ(test, 0, scale_nano);
+
+	ret =3D iio_gts_total_gain_to_scale(&gts, 1, &scale_int, &scale_nano);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_SCALE_1X, scale_int);
+	KUNIT_EXPECT_EQ(test, 0, scale_nano);
+
+	ret =3D iio_gts_total_gain_to_scale(&gts, 4096 * 8, &scale_int,
+					  &scale_nano);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 0, scale_int);
+	KUNIT_EXPECT_EQ(test, TEST_SCALE_NANO_4096X8, scale_nano);
+
+}
+
+static void test_iio_gts_chk_times(struct kunit *test, const int *vals)
+{
+	static const int expected[] =3D {0, 50000, 0, 100000, 0, 200000, 0, 40000=
0};
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(expected); i++)
+		KUNIT_EXPECT_EQ(test, expected[i], vals[i]);
+}
+
+static void test_iio_gts_chk_scales_all(struct kunit *test, struct iio_gts=
 *gts,
+					const int *vals, int len)
+{
+	static const int gains[] =3D {1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
+				    1024, 2048, 4096, 4096 * 2, 4096 * 4,
+				    4096 * 8};
+
+	int expected[ARRAY_SIZE(gains) * 2];
+	int i, ret;
+	int exp_len =3D ARRAY_SIZE(gains) * 2;
+
+	KUNIT_EXPECT_EQ(test, exp_len, len);
+	if (len !=3D exp_len)
+		return;
+
+	for (i =3D 0; i < ARRAY_SIZE(gains); i++) {
+		ret =3D iio_gts_total_gain_to_scale(gts, gains[i],
+						  &expected[2 * i],
+						  &expected[2 * i + 1]);
+		KUNIT_EXPECT_EQ(test, 0, ret);
+		if (ret)
+			return;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(expected); i++)
+		KUNIT_EXPECT_EQ(test, expected[i], vals[i]);
+}
+
+static void test_iio_gts_chk_scales_t200(struct kunit *test, struct iio_gt=
s *gts,
+					 const int *vals, int len)
+{
+	/* The gain caused by time 200 is 4x */
+	static const int gains[] =3D {
+		1 * 4,
+		4 * 4,
+		16 * 4,
+		32 * 4,
+		64 * 4,
+		256 * 4,
+		512 * 4,
+		1024 * 4,
+		2048 * 4,
+		4096 * 4
+	};
+	int expected[ARRAY_SIZE(gains) * 2];
+	int i, ret;
+
+	KUNIT_EXPECT_EQ(test, 2 * ARRAY_SIZE(gains), len);
+	if (len < 2 * ARRAY_SIZE(gains))
+		return;
+
+	for (i =3D 0; i < ARRAY_SIZE(gains); i++) {
+		ret =3D iio_gts_total_gain_to_scale(gts, gains[i],
+						  &expected[2 * i],
+						  &expected[2 * i + 1]);
+		KUNIT_EXPECT_EQ(test, 0, ret);
+		if (ret)
+			return;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(expected); i++)
+		KUNIT_EXPECT_EQ(test, expected[i], vals[i]);
+}
+
+static void test_iio_gts_avail_test(struct kunit *test)
+{
+	struct device *dev;
+	int ret;
+	int type, len;
+	const int *vals;
+
+	dev =3D test_init_iio_gain_scale(test, &gts);
+	if (!dev)
+		return;
+
+	/* test table building for times and iio_gts_avail_times() */
+	ret =3D iio_gts_avail_times(&gts, &vals, &type, &len);
+	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
+	if (ret)
+		return;
+
+	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_MICRO, type);
+	KUNIT_EXPECT_EQ(test, 8, len);
+	if (len < 8)
+		return;
+
+	test_iio_gts_chk_times(test, vals);
+
+	/* Test table building for all scales and iio_gts_all_avail_scales() */
+	ret =3D iio_gts_all_avail_scales(&gts, &vals, &type, &len);
+	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
+	if (ret)
+		return;
+
+	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
+
+	test_iio_gts_chk_scales_all(test, &gts, vals, len);
+
+	/*
+	 * Test table building for scales/time and
+	 * iio_gts_avail_scales_for_time()
+	 */
+	ret =3D iio_gts_avail_scales_for_time(&gts, 200000, &vals, &type, &len);
+	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
+	if (ret)
+		return;
+
+	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
+	test_iio_gts_chk_scales_t200(test, &gts, vals, len);
+}
+
+static struct kunit_case iio_gts_test_cases[] =3D {
+	KUNIT_CASE(test_init_iio_gts_invalid),
+	KUNIT_CASE(test_iio_gts_find_gain_for_scale_using_time),
+	KUNIT_CASE(test_iio_gts_find_new_gain_sel_by_old_gain_time),
+	KUNIT_CASE(test_iio_find_closest_gain_low),
+	KUNIT_CASE(test_iio_gts_total_gain_to_scale),
+	KUNIT_CASE(test_iio_gts_avail_test),
+	{}
+};
+
+static struct kunit_suite iio_gts_test_suite =3D {
+	.name =3D "iio-gain-time-scale",
+	.test_cases =3D iio_gts_test_cases,
+};
+
+kunit_test_suite(iio_gts_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Test IIO light sensor gain-time-scale helpers");
+MODULE_IMPORT_NS(IIO_GTS_HELPER);
+
--=20
2.43.0


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

--e/ypoMxtAn9bAWuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmWebacACgkQeFA3/03a
ocWsOAgAkXUmcWzX4kjHuSY5rlrGTNSNI3+3S7/Q2184tif+N+UebZNLQDbCT/vo
4U5bmhmYpcKOD/30hM87iOzLbQA8AfkaP9OAh/swEWOcmBWyw3L1eR88YKNWAJ/M
56xl98Qw4cG7QSE3I7Htz2g4VloswiSxVQIa5JcBLTyvz/w7brydQG63Yg9pkACq
TMz4i5DtA7+jBfMgZFz8YnYBhefV7HZi8mIIi+tktvgFtufI4gmXRdLz1mKxpQ/Z
mJXuNFbUe5AdTt1Tv9rlhi6PKkqJyXi1N2RL70wFTsUxjWErSSFAF1yA0zYyaTKu
5RtthOYpPIsRWWppohUmMtQ7iIUAZg==
=NVwv
-----END PGP SIGNATURE-----

--e/ypoMxtAn9bAWuu--

