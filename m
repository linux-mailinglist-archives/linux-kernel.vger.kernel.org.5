Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE67B534E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbjJBMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjJBMdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:33:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D66883;
        Mon,  2 Oct 2023 05:33:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5031ccf004cso25182166e87.2;
        Mon, 02 Oct 2023 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696250029; x=1696854829; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ccscJTYG0Q2IcsDa7Ds1vsKDg7Jem9n0Wcf6EhcTis=;
        b=bvqKJnm8/jhYB5M7lpD3Z2w5qUwW4WSVkisCvHg99QAiuWjzJ3NSLbwDTvjWA1gxgq
         U5dR3nVxXFUl4zYbUSxv850oclNRBt+Y/dZ7GA2xE1Ysxi7AFHisV3BrsMsLMf42ZOqb
         keVZBsBpZbmM/YRL+Exc7RayJ+Dm0CDA3JshMT0kplvSHK+VwjjDIQskjjIphOuVP/8u
         nSRD3pImzs+zWK9E55E9J0GuRZXDw/g5QYQNcBT+UWxZgPXuC1oE1FPxczJo85Tq/XlK
         DXfDfAZsAj7sfPQgz2y7lcom3gwXuIHcirOLz1DiafJ3G0+mf9c1yTzA/iPiSvkz+TGr
         0XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696250029; x=1696854829;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ccscJTYG0Q2IcsDa7Ds1vsKDg7Jem9n0Wcf6EhcTis=;
        b=FlPTzRfPMg7GwTxvkpZ1IIafVWy2yMtm1GAga7pswg73G6v1mzzKlmCuZb+zJ40RWF
         aN8N3AkL2fsWgXPOXyFzOpA1nzV9+6G9MSrfT14+/EP60YxX8Xad5ey6h7oRPHkxYijd
         RPTb2WBnN1Vogqgo793Nzhd9nRFvaI2qtlc3Wp95CoybNPwSSXt5DUf3IKWiuC4lp8kg
         G0AmgANv+hZM2cmMxq4WvHyWs8Zn6RuKjIoBd1DlsipcpuW+v7vxtl6rD6Flvx4E8xJ0
         xPNFn/onHVS64d0+v+8NobTdOOoOoOd5xbKfjqQ1vvBL6SyW0rP29xtRHGF4qQV87F+G
         AG6A==
X-Gm-Message-State: AOJu0Yx35+EuRpEOGL1nUcrMIYSjQHrAgy/zTBhLd/WDZxYxGhmEVQ5m
        2ukvl6HgVPbZBe2dtjXqODI=
X-Google-Smtp-Source: AGHT+IFHxfRt2KpDxKbAjIdtEtCxVPpZDxlg9i2hqpu6e9a9C4WgRatlrslXpwU5SIdksu9PQ+/WkQ==
X-Received: by 2002:a05:6512:3295:b0:503:5d8:da2e with SMTP id p21-20020a056512329500b0050305d8da2emr8122821lfe.13.1696250028454;
        Mon, 02 Oct 2023 05:33:48 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24341000000b004fe1bc7e4acsm4749638lfl.131.2023.10.02.05.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:33:47 -0700 (PDT)
Date:   Mon, 2 Oct 2023 15:33:41 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: bu27008: Add processed illuminance channel
Message-ID: <ZRq4pdDn6N73n7BO@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bUIe+GZkBQwM5C57"
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


--bUIe+GZkBQwM5C57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The RGB + IR data can be used to calculate illuminance value (Luxes).
Implement the equation obtained from the ROHM HW colleagues and add a
light data channel outputting illuminance values in (nano) Luxes.

Both the read_raw and buffering values is supported, with the limitation
that buffering is only allowed when suitable scan-mask is used. (RGB+IR,
no clear).

The equation has been developed by ROHM HW colleagues for open air sensor.
Adding any lens to the sensor is likely to impact to the used c1, c2, c3
coefficients. Also, The output values have only been tested on BU27008.

According to the HW colleagues, the very same equation should work also
on BU27010.

Calculate and output illuminance values from BU27008 and BU27010.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

I did very dummy testing at very normal daylight inside a building. No
special equipments were used - I simply compared values computed from
BU27008 RGB+IR channels, to values displayed by the ALS in my mobile
phone. Results were roughly the same (around 400 lux). Couldn't repeat
test on BU27010, but the data it outputs should be same format as
BU27008 data so equation should work for both sensors.
---
 drivers/iio/light/rohm-bu27008.c | 216 ++++++++++++++++++++++++++++++-
 1 file changed, 211 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
index 6a6d77805091..d480cf761377 100644
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
@@ -1004,6 +1021,183 @@ static int bu27008_read_one(struct bu27008_data *da=
ta, struct iio_dev *idev,
 	return ret;
 }
=20
+static int bu27008_get_rgb_ir(struct bu27008_data *data, unsigned int *red,
+		    unsigned int *green, unsigned int *blue, unsigned int *ir)
+{
+	int ret, chan_sel, int_time, tmpret, valid;
+	__le16 chans[BU27008_NUM_HW_CHANS];
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
+	ret =3D bu27008_get_int_time_us(data);
+	if (ret < 0)
+		int_time =3D BU27008_MEAS_TIME_MAX_MS;
+	else
+		int_time =3D ret / USEC_PER_MSEC;
+
+	msleep(int_time);
+
+	ret =3D regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
+				       valid, (valid & BU27008_MASK_VALID),
+				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
+				       BU27008_MAX_VALID_RESULT_WAIT_US);
+	if (ret)
+		goto out;
+
+	ret =3D regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, chans,
+			       sizeof(chans));
+	if (ret)
+		goto out;
+
+	*red =3D le16_to_cpu(chans[0]);
+	*green =3D le16_to_cpu(chans[1]);
+	*blue =3D le16_to_cpu(chans[2]);
+	*ir =3D le16_to_cpu(chans[3]);
+
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
+ * 0x4FFFB000 which still fits in 32-bit integer. So this can't overflow.
+ */
+#define NORM_CHAN_DATA_FOR_LX_CALC(chan, gain, time) ((chan) * 1024 * 20 /=
 \
+				   (gain) / (time))
+static u64 bu27008_calc_nlux(struct bu27008_data *data, unsigned int red,
+		unsigned int green, unsigned int blue,  unsigned int ir,
+		unsigned int gain, unsigned int gain_ir, unsigned int time)
+{
+	s64 c1, c2, c3, nlux;
+
+	time /=3D 10000;
+	ir =3D NORM_CHAN_DATA_FOR_LX_CALC(ir, gain_ir, time);
+	red =3D NORM_CHAN_DATA_FOR_LX_CALC(red, gain, time);
+	green =3D NORM_CHAN_DATA_FOR_LX_CALC(green, gain, time);
+	blue =3D NORM_CHAN_DATA_FOR_LX_CALC(blue, gain, time);
+
+	if ((u64)ir * 100LLU > 18LLU * (u64)green) {
+		c1 =3D -22370;
+		c2 =3D 321900;
+		c3 =3D -120371;
+	} else {
+		c1 =3D -10740;
+		c2 =3D 305415;
+		c3 =3D -129367;
+	}
+	nlux =3D c1 * red + c2 * green + c3 * blue;
+	if (nlux < 0)
+		nlux =3D 0;
+
+	return nlux;
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
+	/* Max integration time is 400000i. Fits in signed int. */
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
+static int bu27008_buffer_get_lux(struct bu27008_data *data,
+				  struct bu27008_buf *raw)
+{
+	unsigned int red, green, blue, ir, gain, gain_ir, time;
+	int ret;
+
+	red =3D le16_to_cpu(raw->chan[0]);
+	green =3D le16_to_cpu(raw->chan[1]);
+	blue =3D le16_to_cpu(raw->chan[2]);
+	ir =3D le16_to_cpu(raw->chan[3]);
+	ret =3D bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
+	if (ret)
+		return ret;
+
+	raw->lux =3D bu27008_calc_nlux(data, red, green, blue, ir, gain, gain_ir,
+				     time);
+
+	return 0;
+}
+
+static int bu27008_read_lux(struct bu27008_data *data, struct iio_dev *ide=
v,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2)
+{
+	unsigned int red, green, blue, ir, gain, gain_ir, time;
+	u64 nlux;
+	int ret;
+
+	ret =3D bu27008_get_rgb_ir(data, &red, &green, &blue, &ir);
+	if (ret)
+		return ret;
+
+	ret =3D bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
+	if (ret)
+		return ret;
+
+	nlux =3D bu27008_calc_nlux(data, red, green, blue, ir, gain, gain_ir,
+				 time);
+	*val =3D (int)nlux;
+	*val2 =3D nlux >> 32LLU;
+
+	return IIO_VAL_INT_64;
+}
+
 static int bu27008_read_raw(struct iio_dev *idev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -1012,13 +1206,17 @@ static int bu27008_read_raw(struct iio_dev *idev,
 	int busy, ret;
=20
 	switch (mask) {
+
 	case IIO_CHAN_INFO_RAW:
 		busy =3D iio_device_claim_direct_mode(idev);
 		if (busy)
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
@@ -1026,6 +1224,11 @@ static int bu27008_read_raw(struct iio_dev *idev,
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
@@ -1231,15 +1434,13 @@ static const struct iio_trigger_ops bu27008_trigger=
_ops =3D {
 	.reenable =3D bu27008_trigger_reenable,
 };
=20
+
 static irqreturn_t bu27008_trigger_handler(int irq, void *p)
 {
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
@@ -1256,6 +1457,11 @@ static irqreturn_t bu27008_trigger_handler(int irq, =
void *p)
 			       sizeof(raw.chan));
 	if (ret < 0)
 		goto err_read;
+	if (test_bit(BU27008_LUX, idev->active_scan_mask)) {
+		ret =3D bu27008_buffer_get_lux(data, &raw);
+		if (ret)
+			goto err_read;
+	}
=20
 	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
 err_read:

base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec
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

--bUIe+GZkBQwM5C57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUauKEACgkQeFA3/03a
ocVXRgf+JXwNbXA9jSguoSY6AuyK9PLv8h13m0h+1C3g69lp6DkxHKXsl11J1U/n
rRs5je9Jp2iN8ULEBHPAF58dsrKVTCSNlm6LpNVxVgwH+M8fNPOQebEn+n91jQk0
9GV9oaZSwLAQ8qMol8qGjJ7XBCgV3ZQy8hg/rlpinK7SrNFpTH3uomSbgpPftOfr
wUBLE8sNTlLBKXCB7AmfEcdgRXEHhUqkwJcd8BaWV3+pja+MSiezCqOQ9NmwixkR
rQxs0R45290viE8g24Ei/RCE9w+TvkoFxQB9nGiReL0F6v5U7mPH78WgpF2ZhASx
XhcUZOnYBpiTh80Kjkviv/rTVNgnOw==
=U31X
-----END PGP SIGNATURE-----

--bUIe+GZkBQwM5C57--
