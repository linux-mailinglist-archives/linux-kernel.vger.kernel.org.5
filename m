Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2837D0DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377092AbjJTKyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377095AbjJTKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:53:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF189E;
        Fri, 20 Oct 2023 03:53:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507adc3381cso891363e87.3;
        Fri, 20 Oct 2023 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697799234; x=1698404034; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrIXhW9fDb1wr4YgeeiJSlMMniaQbLXxwpyIEv7KRq8=;
        b=d9T5MakhaSzL6qp2PTYLkfi4MFvpR5v5ONs3wO9+tsRCBYRB1zGHQH8GMP5GQzXSav
         o5LJdpOA6JfXo0iGIgn4WcBBN7j5KfWnP7k/U9lj6H6cKZDCZTbTmwX4GnMn37uwLu6Z
         Ga5tlPwqUoR7NPo07b0hZpjNMLoqSLzU3fgSbId/uLhtVi3SnqJ/FwWxd8hq7XMIYxnl
         /+Ljf9yImki6VU+4foYP7M4i3qU+iqMQhOUGpv97EWQV9vvm3bjsfki3SaAqIrPJV2aA
         96Jv3xcw35zfsy/WIUEAlSPolU0jp5gagFbQ4xO8K5qhOQZeqN4zR/ThQCiYF74xgT+N
         lvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799234; x=1698404034;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrIXhW9fDb1wr4YgeeiJSlMMniaQbLXxwpyIEv7KRq8=;
        b=vIGrFtXcbzIZ6NCrFGrKOOsGq60MZjc+EbdzlLA/MW2AUNgf4mOMNOrpqylJlGBEu0
         npu//Ldne/YJ7jDzMwgBxfCvVQ/Ow9Z8sMwmwB5NJtd9f/jFliqNERizB/sGHeifdZHH
         6ja1bVR4+GHy+tq2xGtD7IaRSzjcTQjkc9PV1u/bB6EU1P+Jhf1SD//+h2ROXBpELPIR
         52nN3shAoM51fmVci6Tg8wkU+3286QUwHQRZBRgJfHSjkQ2j/+UFTkWtf4Q5Bn9ChY+d
         M+fLkTGDxXzeKjVyj8bSQ/u4ACAyVSuJWb2N+SeFgdLzrwyrZThQirgjj68qAF5ZVZH/
         pemA==
X-Gm-Message-State: AOJu0YyO0ctHwQOMV62w+3f3P6w1bkHLC/bF1UhVBD2X7Q/9aTbmb9yq
        APdCrgvkSpg6dNwJcwrwhW0=
X-Google-Smtp-Source: AGHT+IFbdAunxW/Q9e8+0t6SUOc93BsBHkpKPnqQsN04wGQYxI1uXWvvHuR+MM0m3CsDQlV7jgm5FA==
X-Received: by 2002:a19:434d:0:b0:507:984e:9f17 with SMTP id m13-20020a19434d000000b00507984e9f17mr910047lfj.34.1697799233969;
        Fri, 20 Oct 2023 03:53:53 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id l7-20020a056512110700b005031641b40asm298881lfg.159.2023.10.20.03.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:53:52 -0700 (PDT)
Date:   Fri, 20 Oct 2023 13:53:47 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: bu27008: Add illuminance channel
Message-ID: <ZTJcOxSb/WHzdN8h@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CZzpS91aR3CsPOh0"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CZzpS91aR3CsPOh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The RGB + IR data can be used to calculate the illuminance value (luxes).
Implement the equation obtained from the ROHM HW colleagues and add a
raw light data channel outputting illuminance values in (nano) Luxes.

Both the read_raw and buffering values are supported, with the limitation
that buffering is only allowed when a suitable scan-mask is used. (RGB+IR,
no clear).

The equation has been developed by ROHM HW colleagues for open air sensor.
Adding any lens to the sensor is likely to impact to used c1, c2, c3
coefficients. Also, the output values have only been tested on BU27008.

According to the HW colleagues, the very same equation should work on
BU27010 as well.

Calculate and output illuminance values from BU27008 and BU27010.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
- reduce lux function parameters using an array
- streamline code by converting channel data to meaningful values in
  bu27008_calc_nlux() for both the raw read and buffering
- some minor styling

I did very dummy testing at very normal daylight inside a building. No
special equipments were used - I simply compared values computed from
BU27008 RGB+IR channels, to values displayed by the ALS in my mobile
phone. Results were roughly the same (around 400 lux). Couldn't repeat
test on BU27010, but the data it outputs should be same format as
BU27008 data so equation should work for both sensors.
---
 drivers/iio/light/rohm-bu27008.c | 201 ++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
index 6a6d77805091..0f010eff1981 100644
--- a/drivers/iio/light/rohm-bu27008.c
+++ b/drivers/iio/light/rohm-bu27008.c
@@ -130,6 +130,7 @@
  * @BU27008_BLUE:	Blue channel. Via data2 (when used).
  * @BU27008_CLEAR:	Clear channel. Via data2 or data3 (when used).
  * @BU27008_IR:		IR channel. Via data3 (when used).
+ * @BU27008_LUX:	Illuminance channel, computed using RGB and IR.
  * @BU27008_NUM_CHANS:	Number of channel types.
  */
 enum bu27008_chan_type {
@@ -138,6 +139,7 @@ enum bu27008_chan_type {
 	BU27008_BLUE,
 	BU27008_CLEAR,
 	BU27008_IR,
+	BU27008_LUX,
 	BU27008_NUM_CHANS
 };
=20
@@ -172,6 +174,8 @@ static const unsigned long bu27008_scan_masks[] =3D {
 	ALWAYS_SCANNABLE | BIT(BU27008_CLEAR) | BIT(BU27008_IR),
 	/* buffer is R, G, B, IR */
 	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR),
+	/* buffer is R, G, B, IR, LUX */
+	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR) | BIT(BU27008_LUX),
 	0
 };
=20
@@ -331,6 +335,19 @@ static const struct iio_chan_spec bu27008_channels[] =
=3D {
 	 * Hence we don't advertise available ones either.
 	 */
 	BU27008_CHAN(IR, DATA3, 0),
+	{
+		.type =3D IIO_LIGHT,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.channel =3D BU27008_LUX,
+		.scan_index =3D BU27008_LUX,
+		.scan_type =3D {
+			.sign =3D 'u',
+			.realbits =3D 64,
+			.storagebits =3D 64,
+			.endianness =3D IIO_CPU,
+		},
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(BU27008_NUM_CHANS),
 };
=20
@@ -1004,6 +1021,169 @@ static int bu27008_read_one(struct bu27008_data *da=
ta, struct iio_dev *idev,
 	return ret;
 }
=20
+#define BU27008_LUX_DATA_RED	0
+#define BU27008_LUX_DATA_GREEN	1
+#define BU27008_LUX_DATA_BLUE	2
+#define BU27008_LUX_DATA_IR	3
+#define LUX_DATA_SIZE (BU27008_NUM_HW_CHANS * sizeof(__le16))
+
+static int bu27008_read_lux_chans(struct bu27008_data *data, unsigned int =
time,
+				  __le16 *chan_data)
+{
+	int ret, chan_sel, tmpret, valid;
+
+	chan_sel =3D BU27008_BLUE2_IR3 << (ffs(data->cd->chan_sel_mask) - 1);
+
+	ret =3D regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
+				 data->cd->chan_sel_mask, chan_sel);
+	if (ret)
+		return ret;
+
+	ret =3D bu27008_meas_set(data, true);
+	if (ret)
+		return ret;
+
+	msleep(time / USEC_PER_MSEC);
+
+	ret =3D regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
+				       valid, (valid & BU27008_MASK_VALID),
+				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
+				       BU27008_MAX_VALID_RESULT_WAIT_US);
+	if (ret)
+		goto out;
+
+	ret =3D regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, chan_data,
+			       LUX_DATA_SIZE);
+	if (ret)
+		goto out;
+out:
+	tmpret =3D bu27008_meas_set(data, false);
+	if (tmpret)
+		dev_warn(data->dev, "Stopping measurement failed\n");
+
+	return ret;
+}
+
+/*
+ * Following equation for computing lux out of register values was given by
+ * ROHM HW colleagues;
+ *
+ * Red =3D RedData*1024 / Gain * 20 / meas_mode
+ * Green =3D GreenData* 1024 / Gain * 20 / meas_mode
+ * Blue =3D BlueData* 1024 / Gain * 20 / meas_mode
+ * IR =3D IrData* 1024 / Gain * 20 / meas_mode
+ *
+ * where meas_mode is the integration time in mS / 10
+ *
+ * IRratio =3D (IR > 0.18 * Green) ? 0 : 1
+ *
+ * Lx =3D max(c1*Red + c2*Green + c3*Blue,0)
+ *
+ * for
+ * IRratio 0: c1 =3D -0.00002237, c2 =3D 0.0003219, c3 =3D -0.000120371
+ * IRratio 1: c1 =3D -0.00001074, c2 =3D 0.000305415, c3 =3D -0.000129367
+ */
+
+/*
+ * The max chan data is 0xffff. When we multiply it by 1024 * 20, we'll get
+ * 0x4FFFB000 which still fits in 32-bit integer. This won't overflow.
+ */
+#define NORM_CHAN_DATA_FOR_LX_CALC(chan, gain, time) (le16_to_cpu(chan) * \
+				   1024 * 20 / (gain) / (time))
+static u64 bu27008_calc_nlux(struct bu27008_data *data, __le16 *lux_data,
+		unsigned int gain, unsigned int gain_ir, unsigned int time)
+{
+	unsigned int red, green, blue, ir;
+	s64 c1, c2, c3, nlux;
+
+	time /=3D 10000;
+	ir =3D NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_IR], gain_ir,=
 time);
+	red =3D NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_RED], gain, =
time);
+	green =3D NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_GREEN], ga=
in, time);
+	blue =3D NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_BLUE], gain=
, time);
+
+	if ((u64)ir * 100LLU > (u64)green * 18LLU) {
+		c1 =3D -22370;
+		c2 =3D 321900;
+		c3 =3D -120371;
+	} else {
+		c1 =3D -10740;
+		c2 =3D 305415;
+		c3 =3D -129367;
+	}
+	nlux =3D c1 * red + c2 * green + c3 * blue;
+
+	return max_t(s64, 0, nlux);
+}
+
+static int bu27008_get_time_n_gains(struct bu27008_data *data,
+		unsigned int *gain, unsigned int *gain_ir, unsigned int *time)
+{
+	int ret;
+
+	ret =3D bu27008_get_gain(data, &data->gts, gain);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bu27008_get_gain(data, &data->gts_ir, gain_ir);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bu27008_get_int_time_us(data);
+	if (ret < 0)
+		return ret;
+
+	/* Max integration time is 400000. Fits in signed int. */
+	*time =3D ret;
+
+	return 0;
+}
+
+struct bu27008_buf {
+	__le16 chan[BU27008_NUM_HW_CHANS];
+	u64 lux __aligned(8);
+	s64 ts __aligned(8);
+};
+
+static int bu27008_buffer_fill_lux(struct bu27008_data *data,
+				   struct bu27008_buf *raw)
+{
+	unsigned int gain, gain_ir, time;
+	int ret;
+
+	ret =3D bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
+	if (ret)
+		return ret;
+
+	raw->lux =3D bu27008_calc_nlux(data, raw->chan, gain, gain_ir, time);
+
+	return 0;
+}
+
+static int bu27008_read_lux(struct bu27008_data *data, struct iio_dev *ide=
v,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2)
+{
+	__le16 lux_data[BU27008_NUM_HW_CHANS];
+	unsigned int gain, gain_ir, time;
+	u64 nlux;
+	int ret;
+
+	ret =3D bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
+	if (ret)
+		return ret;
+
+	ret =3D bu27008_read_lux_chans(data, time, lux_data);
+	if (ret)
+		return ret;
+
+	nlux =3D bu27008_calc_nlux(data, lux_data, gain, gain_ir, time);
+	*val =3D (int)nlux;
+	*val2 =3D nlux >> 32LLU;
+
+	return IIO_VAL_INT_64;
+}
+
 static int bu27008_read_raw(struct iio_dev *idev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -1018,7 +1198,10 @@ static int bu27008_read_raw(struct iio_dev *idev,
 			return -EBUSY;
=20
 		mutex_lock(&data->mutex);
-		ret =3D bu27008_read_one(data, idev, chan, val, val2);
+		if (chan->type =3D=3D IIO_LIGHT)
+			ret =3D bu27008_read_lux(data, idev, chan, val, val2);
+		else
+			ret =3D bu27008_read_one(data, idev, chan, val, val2);
 		mutex_unlock(&data->mutex);
=20
 		iio_device_release_direct_mode(idev);
@@ -1026,6 +1209,11 @@ static int bu27008_read_raw(struct iio_dev *idev,
 		return ret;
=20
 	case IIO_CHAN_INFO_SCALE:
+		if (chan->type =3D=3D IIO_LIGHT) {
+			*val =3D 0;
+			*val2 =3D 1;
+			return IIO_VAL_INT_PLUS_NANO;
+		}
 		ret =3D bu27008_get_scale(data, chan->scan_index =3D=3D BU27008_IR,
 					val, val2);
 		if (ret)
@@ -1236,10 +1424,7 @@ static irqreturn_t bu27008_trigger_handler(int irq, =
void *p)
 	struct iio_poll_func *pf =3D p;
 	struct iio_dev *idev =3D pf->indio_dev;
 	struct bu27008_data *data =3D iio_priv(idev);
-	struct {
-		__le16 chan[BU27008_NUM_HW_CHANS];
-		s64 ts __aligned(8);
-	} raw;
+	struct bu27008_buf raw;
 	int ret, dummy;
=20
 	memset(&raw, 0, sizeof(raw));
@@ -1257,6 +1442,12 @@ static irqreturn_t bu27008_trigger_handler(int irq, =
void *p)
 	if (ret < 0)
 		goto err_read;
=20
+	if (test_bit(BU27008_LUX, idev->active_scan_mask)) {
+		ret =3D bu27008_buffer_fill_lux(data, &raw);
+		if (ret)
+			goto err_read;
+	}
+
 	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
 err_read:
 	iio_trigger_notify_done(idev->trig);

base-commit: 89e2233386a5670d15908628b63e611cb03b0d03
--=20
2.41.0


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

--CZzpS91aR3CsPOh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUyXDgACgkQeFA3/03a
ocUxFAgAwqKEwKXLo429cwZg8xw7/vq42UhhyL6t5vxsLhXlo6B5JvPUzIhddZrs
Uunl5UkkA82DLFPsw0UBBVTDUsQQ6OJnYg4Dl7UdoiB/4FqzQXz7VHZ0ngH5Jctp
AmPjgAgE69KFUnhDHQcAGOMJK1nhFSiqE/xklgyseL/fp3lske9F4m3RxryDl3nf
YeFDpenmyhpej99kaQmCPss17SX4YVJEiGw7Oiib0Ql4ev36ED93eVi9KqpGaFz8
e3KobYXFqbt5mwGtFuuGtbLxvP+JddSKArNejGsDK3O2WgL8zlmS+kzH2auMxe4l
3F9ewy1P0rHOqrS0KaUaAoMiRHcRCA==
=xF4o
-----END PGP SIGNATURE-----

--CZzpS91aR3CsPOh0--
