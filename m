Return-Path: <linux-kernel+bounces-26083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3555982DB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30AF281267
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780E1759A;
	Mon, 15 Jan 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ4n28vL"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DD17591;
	Mon, 15 Jan 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so10226770e87.2;
        Mon, 15 Jan 2024 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705328773; x=1705933573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIOsRYDHDhxxVXfuG9oGMdNEUD+sQmayiF+K0XyJDPk=;
        b=VZ4n28vLO5OFzGtcKI3PAI59mM8nStv0ttJhL/sgc/LyjUFT0mDM6ygGsN1E+zy5g1
         z9EEd2sIs+BXrVGuuCCI64xCidLDPlj8ar5zsHFPVhlAbFoIXKIBAa4Gndf5GDLlHhk5
         FiSfZ+1BVewVA8O600T5nmHhfLkhW2sGqcAfcHpyabq/8zLvVqrYU871an7HJnuP1ZQp
         K2xi+Ucf9CApzVEI63PB4oJWShjkjlDL2lNpxbwOp4yoRyaJR83Evh1QqT9lHDFPXG4d
         dwyzFtFvjXJuv52tlrB0iIqDtRwoD5QlWEuZiiEdB8PblPImt/ZwH6DJwY2TpkbRKlXy
         PAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328773; x=1705933573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIOsRYDHDhxxVXfuG9oGMdNEUD+sQmayiF+K0XyJDPk=;
        b=Rpddy/AZG/yDSv7dJTAx9PNS0gyJDQKjjN7Hiv//DQfLEAWfH+EdV6WifJDTXGZ95A
         VGRwNoPtZXEygKL9jWXV95V2RsVpiIelAMDmv8dQOqD3tEkFsMgafz+L5PCQMP3XXwD8
         7VMoqlsc5feBBFlV0sRitMTFpPzcOj5F8QPeQCSee0/oqP4O6xMYJAf5Nv+ZwbgA6Dew
         6sQwwMKQiBQVVeoQ9vy74Tk8/hQgj6S1oVe9Q8lk9Zqsr2dI6fB8MI2Q2GYBeQufB6lC
         rtE3/4JjeUBdgrIFXsOpc3pAP0ctTPDRYNsej7nsp3tcrccOq/6+pletoZkR/MCSt9jj
         6CBQ==
X-Gm-Message-State: AOJu0YzPf6VZheqEW0eLfoZZEbKQAh8weKcuHrixr3c6bm/qETo7efO9
	hKEZsiG4QUaQqY/mJdSTXUnVeMFENpZScQ==
X-Google-Smtp-Source: AGHT+IGLIe3PgaFFaD1kOijhimlYGaW7QnokEh4BeuGuNCPfBaG+icZ9EAcOBiq5ppy5ebJSFuHh/g==
X-Received: by 2002:ac2:5f6a:0:b0:50e:c483:9e2d with SMTP id c10-20020ac25f6a000000b0050ec4839e2dmr2248146lfc.40.1705328772424;
        Mon, 15 Jan 2024 06:26:12 -0800 (PST)
Received: from fedora (mobile-access-567347-211.dhcp.inet.fi. [86.115.71.211])
        by smtp.gmail.com with ESMTPSA id 15-20020ac2484f000000b0050e7964e2b7sm1475778lfy.290.2024.01.15.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:26:11 -0800 (PST)
Date: Mon, 15 Jan 2024 16:26:07 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] iio: test: test gain-time-scale helpers
Message-ID: <0f7505b43f91394dc3bb636369489c897b7e01a7.1705328293.git.mazziesaccount@gmail.com>
References: <cover.1705328293.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bUWf0HaggZun9IJ4"
Content-Disposition: inline
In-Reply-To: <cover.1705328293.git.mazziesaccount@gmail.com>


--bUWf0HaggZun9IJ4
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
v1 =3D> v2: (As per the review by Jonathan)
- remove extra whitespaces

Below history uses numbering from the series which added the GTS helpers
to the IIO - tree. The numbering was restarted as the GTS helpers series
was applied while this patch was dropped as kunit_device support was not
yet there.

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
 drivers/iio/test/iio-test-gts.c | 513 ++++++++++++++++++++++++++++++++
 3 files changed, 528 insertions(+)
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
index 000000000000..cf7ab773ea0b
--- /dev/null
+++ b/drivers/iio/test/iio-test-gts.c
@@ -0,0 +1,513 @@
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

--bUWf0HaggZun9IJ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmWlQH8ACgkQeFA3/03a
ocWWCAf/Xss1VuTpwVufm6GgqLkxlCGJwaYZOdPzcxIZzcAo6W0cexWEkVw2Zyem
pw9td/FI7EYTjdz8UwwInck8oI+nPaGB3byqRyUz3xQNqYXlcJ2e9XgKYAHh/YTq
0oNv9FWByxHW75lEjjSmq4oUBe4Brlo2+sG3AhGb6R/B6P84KrMvcnpnbGEPZbNJ
ZF2I+IX9dP8bcU1objg94UZGa0N7D275PhL7hKKwHk9/Ry2bE45OEd/ejbVdEW/a
VCzPaf5BiiQQlGaYqh7P0fFr/UXjy/2eJIJg7EF5wsWAIxlMWVMHEPcVo/xnDoS+
P9IBNH0Gz1essBQv5C/OgE9Vv0JcnQ==
=sk4D
-----END PGP SIGNATURE-----

--bUWf0HaggZun9IJ4--

