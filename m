Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5F7A6ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjISWoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjISWoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:44:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FBDD8;
        Tue, 19 Sep 2023 15:44:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50098cc8967so10088057e87.1;
        Tue, 19 Sep 2023 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695163443; x=1695768243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpO83YeRKs36G7wDLGtdKkeTJjMUq7Z3/in/MBit8+s=;
        b=MlnlCPErpOc/A/rXthsdu4M/G3KUaxz//jbd24P98P77OJ+DRf+YYjd96BMKlGWhV4
         V/aooXrUud+vNk1TWnBGDkCxuudZ6LryGX1PbT0GjAB5moS8Vo6WulF8xTcs4omaJHn4
         9DSbU+494TtPW5MGlRPxd/9tH21zxeRsa/j/GzE+6PthkM8GRtq98RL6RnPLLbUARBLL
         dLkDihYXvioZCUVVjesFVSiBiDOyM3x0W8+SB5xDVHVq6zKsft1dtG8H2lc5wQGXQ7cW
         RvM2Jjsv7xSkMkhUhOp3VdtiO7FRUcLku9q5otgGvw7H263CXPxB3d/Ai78sXv0f4bKF
         tOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695163443; x=1695768243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpO83YeRKs36G7wDLGtdKkeTJjMUq7Z3/in/MBit8+s=;
        b=lrhQdQAiZAKmVKWtTntPo989RkYVpYLpTCB8v4S+riw+NdaNAov4volL+V8OPanb1T
         OUOF8mPKqnnVD12mulVimst1KKecpoXoMarEyTc3W/MyBMMlpcVWm7WtV9Ss32QshzWp
         iqk2X97BYaBnveJh2UB0UD3a6gntrUJqMWY2SsvadQ4A8gYeJaxTfKw61gS++gJrBrcV
         eYMuuFg3WIGOCGWj+ZODSTtzXtxW1WUO4zTG/jjDlYnh1VWydeZS1BTpCCk4CKjXyj5z
         J0Rkmc2wezLLwFDqg7mKOaK0UkMsKNbRygVgi3hRaHIMm3QZY42Zd4KVAM2qrh1UeSzC
         gExw==
X-Gm-Message-State: AOJu0YxHXyH6wJxygFYTeSpQ0uvjJ6BhaNdQcpdYZHW4/86Yj9H/bd2H
        4JiNvwYMvBC/A+6oCzxf1/13EAt2ZBBEg4Ryx1Y=
X-Google-Smtp-Source: AGHT+IHFNi9yBdsDUb53zJ4emuJ6OU6dqoa2VtYATaMkMyUi7VYePvlHlQaqICmvjMcfe9WMmgytxHrWsmyRdo+hSFY=
X-Received: by 2002:a19:8c08:0:b0:500:97e4:587e with SMTP id
 o8-20020a198c08000000b0050097e4587emr783598lfd.44.1695163442608; Tue, 19 Sep
 2023 15:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com> <ZQggiuLyLGq/ekMS@smile.fi.intel.com>
In-Reply-To: <ZQggiuLyLGq/ekMS@smile.fi.intel.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Wed, 20 Sep 2023 04:13:51 +0530
Message-ID: <CAM+2EuKXW+FsgY6rp=ugU03owJS6ReeWUNWOcMKiUfomiY_a2Q@mail.gmail.com>
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for reviewing.

On Mon, Sep 18, 2023 at 3:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:
> > The Bosch BMI323 is a 6-axis low-power IMU that provide measurements fo=
r
> > acceleration, angular rate, and temperature. This sensor includes
> > motion-triggered interrupt features, such as a step counter, tap detect=
ion,
> > and activity/inactivity interrupt capabilities.
> >
> > The driver supports various functionalities, including data ready, FIFO
> > data handling, and events such as tap detection, step counting, and
> > activity interrupts
>
> Missing period.
>
> ...
>
> > +#include <linux/regmap.h>
> > +#include <linux/bits.h>
>
> Ordered?
>
> Missing units.h.

Sure I will correct these in the next series.
Please note that I omitted certain portions of your reviews
while responding, and I fully agree with the comments that
I didn't address. I intend to make the necessary corrections
in the next series.
....

> > +struct bmi323_data {
>
> > +     u32 odrns[2];
> > +     u32 odrhz[2];
>
>
> > +     __le16 steps_count[2];
> > +};
>
> I'm wondering if these 2:s anyhow semantically the same? Shouldn't a defi=
nition
> be used instead of magic number?

The arrays odrns[] and odrhz[] are used to store the ODR in nanoseconds and
frequency for both the accelerometer and gyro. Instead of the magic number =
2,
I will define an enum. For steps_count[] array is of size 2 words and
I will define
a separate macro.

> ...
>
> > +static int bmi323_write_ext_reg(struct bmi323_data *data, unsigned int=
 ext_addr,
> > +                             unsigned int ext_data)
> > +{
> > +     int ret, feature_status;
> > +
> > +     mutex_lock(&data->mutex);
>
> You can start using cleanup.h, it will reduce your code by a few percents=
!
> But the point is it makes it less error prone and less verbose.
>
> Ditto for the entire code base.

Sure, thanks for pointing this I will go through cleanup.h.
If required I will get back with some questions.

>
> > +     ret =3D regmap_read(data->regmap, BMI323_FEAT_DATA_STATUS,
> > +                       &feature_status);
> > +     if (ret)
> > +             goto unlock_out;
> > +
> > +     if (!FIELD_GET(BMI323_FEAT_DATA_TX_RDY_MSK, feature_status)) {
> > +             ret =3D -EBUSY;
> > +             goto unlock_out;
> > +     }
> > +
> > +     ret =3D regmap_write(data->regmap, BMI323_FEAT_DATA_ADDR, ext_add=
r);
> > +     if (ret)
> > +             goto unlock_out;
> > +
> > +     ret =3D regmap_write(data->regmap, BMI323_FEAT_DATA_TX, ext_data)=
;
> > +
> > +unlock_out:
> > +     mutex_unlock(&data->mutex);
> > +     return ret;
> > +}
> ...
>
>         unsigned int state_value =3D GENMASK();
>
> > +     switch (dir) {
> > +     case IIO_EV_DIR_RISING:
> > +             msk =3D BMI323_FEAT_IO0_XYZ_MOTION_MSK;
> > +             raw =3D 512;
> > +             config =3D BMI323_ANYMO1_REG;
> > +             irq_msk =3D BMI323_MOTION_MSK;
> > +             set_mask_bits(&irq_field_val, BMI323_MOTION_MSK,
> > +                           FIELD_PREP(BMI323_MOTION_MSK, motion_irq));
> > +             set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_MOTION_MS=
K,
> > +                           FIELD_PREP(BMI323_FEAT_IO0_XYZ_MOTION_MSK,
> > +                                      state ? 7 : 0));
>
> state_value

Sorry I didn't get this, I am updating field_value based on state value.
What is the purpose of state_value?

>
> > +             break;
> > +     case IIO_EV_DIR_FALLING:
> > +             msk =3D BMI323_FEAT_IO0_XYZ_NOMOTION_MSK;
> > +             raw =3D 0;
> > +             config =3D BMI323_NOMO1_REG;
> > +             irq_msk =3D BMI323_NOMOTION_MSK;
> > +             set_mask_bits(&irq_field_val, BMI323_NOMOTION_MSK,
> > +                           FIELD_PREP(BMI323_NOMOTION_MSK, motion_irq)=
);
> > +             set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_NOMOTION_=
MSK,
> > +                           FIELD_PREP(BMI323_FEAT_IO0_XYZ_NOMOTION_MSK=
,
> > +                                      state ? 7 : 0));
>
> Ditto.
>
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
>
> ...
>
> > +static ssize_t in_accel_gesture_tap_max_dur_show(struct device *dev,
> > +                                              struct device_attribute =
*attr,
> > +                                              char *buf)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct bmi323_data *data =3D iio_priv(indio_dev);
> > +     unsigned int reg_value, raw;
> > +     int ret, val[2];
>
> Why val is int (i.e. not unsigned)?

iio_format_value() expects int* so I used int.

>
> > +     ret =3D bmi323_read_ext_reg(data, BMI323_TAP2_REG, &reg_value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     raw =3D FIELD_GET(BMI323_TAP2_MAX_DUR_MSK, reg_value);
>
> > +     val[0] =3D raw / BMI323_MAX_GES_DUR_SCALE;
> > +     val[1] =3D BMI323_RAW_TO_MICRO(raw, BMI323_MAX_GES_DUR_SCALE);
>
> > +     return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, val);
>
> ARRAY_SIZE()
Okay, I will use ARRAY_SIZE() instead of number.

>
> > +static const struct attribute_group bmi323_event_attribute_group =3D {
> > +     .attrs =3D bmi323_event_attributes,
> > +};
>
> ATTRIBUTE_GROUPS() ?

Okay, I will use ATTRIBUTE_GROUPS.

>
> ...
>
> > +     state =3D data->state =3D=3D BMI323_BUFFER_FIFO ? true : false;
>
> =3D=3D already results in boolean type.

Sure I will directly assign the result of comparison.
state =3D (data->state =3D=3D BMI323_BUFFER_FIFO);

> ...
>
> > +     int ret, raw;
>
> Why raw is signed?

I don't have a specific reason for this; however, since it
stores register value, it should be unsigned. I will make
this correction in the next series

>
> > +     for (raw =3D 0; raw < ARRAY_SIZE(bmi323_accel_gyro_avrg); raw++)
> > +             if (avg =3D=3D bmi323_accel_gyro_avrg[raw])
> > +                     break;
>
> > +     if (raw >=3D ARRAY_SIZE(bmi323_accel_gyro_avrg))
>
> When is the > part true?
>
> > +             return -EINVAL;
>

I missed this, > is not possible, I should have used while() here
also, I will correct this in the next series.


> > +     ret =3D bmi323_feature_engine_events(data, BMI323_FEAT_IO0_STP_CN=
T_MSK,
> > +                                        val ? 1 : 0);
>
> Ternary here...
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     set_mask_bits(&data->feature_events, BMI323_FEAT_IO0_STP_CNT_MSK,
> > +                   FIELD_PREP(BMI323_FEAT_IO0_STP_CNT_MSK, val ? 1 : 0=
));
>
> ...and here are dups.

Is the ternary operator not permitted to use?

>
> > +     return ret;
>
> Can it be not 0 here?
>
> ...
>
> > +static int bmi323_get_temp_data(struct bmi323_data *data, int *val)
> > +{
> > +     unsigned int value;
>
> Why it's not defined as __le16 to begin with?

To match the regmap_read() val parameter I used unsigned int*.

Note: each sensor register values are 16 bit wide
and regmap is configured with .val_bits =3D 16.

> > +
> > +     ret =3D bmi323_get_error_status(data);
> > +     if (ret)
> > +             return -EINVAL;
> > +
> > +     ret =3D regmap_read(data->regmap, BMI323_TEMP_REG, &value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     *val =3D sign_extend32(le16_to_cpup((const __le16 *)&value), 15);
>
> No, simply no castings here.
>
> > +     return IIO_VAL_INT;
> > +}
>
> ...
>
> > +     if (bmi323_acc_gyro_odr[odr_index][0] <=3D 25)
>
> Why not positive check: if (... > 25) ... else ...?
>
> > +             mode =3D ACC_GYRO_MODE_DUTYCYCLE;
> > +     else
> > +             mode =3D ACC_GYRO_MODE_CONTINOUS;

Sure, this can also be used. I will update this

>
> ...
>
> > +     int odr_raw, ret;
>
> Why odr_raw is signed?

In the below conditions, I am checking for -ve value so
odr_raw is signed.

>
> > +
> > +     odr_raw =3D ARRAY_SIZE(bmi323_acc_gyro_odr);
> > +
> > +     while (odr_raw--)
> > +             if (odr =3D=3D bmi323_acc_gyro_odr[odr_raw][0] &&
> > +                 uodr =3D=3D bmi323_acc_gyro_odr[odr_raw][1])
> > +                     break;
> > +     if (odr_raw < 0)
> > +             return -EINVAL;
>
> In one case in the code you used for-loop, here is while-loop. Maybe a bi=
t of
> consistency?

Sure, for other case, I will use a while loop instead of a for loop.

>
> > +     fwnode =3D dev_fwnode(data->dev);
> > +     if (!fwnode)
> > +             return -ENODEV;
> > +
> > +     irq =3D fwnode_irq_get_byname(fwnode, "INT1");
> > +     if (irq > 0) {
> > +             irq_pin =3D BMI323_IRQ_INT1;
> > +     } else {
> > +             irq =3D fwnode_irq_get_byname(fwnode, "INT2");
> > +             if (irq <=3D 0)
>
> When can it be =3D=3D 0?

Right, fwnode_irq_get_byname won't return 0, I will correct this
in the next series.

>
> > +     if (en) {
>
> > +             ret =3D regmap_write(data->regmap, BMI323_FEAT_IO2_REG,
> > +                                0x012c);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D regmap_write(data->regmap, BMI323_FEAT_IO_STATUS_=
REG,
> > +                                BMI323_FEAT_IO_STATUS_MSK);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D regmap_write(data->regmap, BMI323_FEAT_CTRL_REG,
> > +                                BMI323_FEAT_ENG_EN_MSK);
> > +             if (ret)
> > +                     return ret;
>
> > +             i =3D 5;
> > +             do {
> > +                     ret =3D regmap_read(data->regmap, BMI323_FEAT_IO1=
_REG,
> > +                                       &feature_status);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     i--;
> > +                     mdelay(2);
> > +             } while (feature_status !=3D 0x01 && i);
>
> NIH regmap_read_poll_timeout().

Okay.

>
> > +             if (feature_status !=3D 0x01) {
> > +                     dev_err(data->dev, "Failed to enable feature engi=
ne\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             return ret;
>
> > +     } else {
>
> Redundant. But here it's okay to leave (I can understand the justificatio=
n).
>
> > +             return regmap_write(data->regmap, BMI323_FEAT_CTRL_REG, 0=
);
> > +     }
>
> ...
>
> > +     if ((val & 0xFF) !=3D BMI323_CHIP_ID_VAL) {
>
> GENMASK() ? (BIT(x) - 1) ? A defined constant?
>
> > +             dev_err(data->dev, "Chip ID mismatch\n");
> > +             return -EINVAL;
>
> Why not dev_err_probe() in this entire function?

Okay I will make use of dev_err_probe() here and in all
probe paths.

>
> > +     ret =3D devm_add_action_or_reset(data->dev, bmi323_disable, data)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
>
>         return devm_...
>
> ...
>
> > +     regmap =3D dev_get_regmap(dev, NULL);
> > +     if (!regmap) {
> > +             dev_err(dev, "No regmap\n");
> > +             return -EINVAL;
>
> Why not dev_err_probe()?

There was no int return value from dev_get_regmap(),
I think I can use -EINVAL for err in dev_err_probe as well.

>
> > +     }
>
>
> > +static int bmi323_regmap_i2c_write(void *context, const void *data,
> > +                                size_t count)
> > +{
> > +     struct device *dev =3D context;
> > +     struct i2c_client *i2c =3D to_i2c_client(dev);
> > +     int ret;
> > +     u8 reg;
> > +
> > +     reg =3D *(u8 *)data;
> > +     ret =3D i2c_smbus_write_i2c_block_data(i2c, reg, count - 1,
> > +                                          data + sizeof(u8));
> > +
> > +     return ret;
> > +}
>
> Hmm... Don't we have a better approach for these? regmap doesn't provide =
SMBus
> accessors?

Custom implementation is required for the 'read' operation, while
'write' can utilize the regmap SMBus accessors. Is it okay to have
only custom read while write uses the SMBus accessor?

>
> > +static int bmi323_regmap_spi_read(void *context, const void *reg_buf,
> > +                               size_t reg_size, void *val_buf,
> > +                               size_t val_size)
> > +{
> > +     struct spi_device *spi =3D context;
> > +     u8 reg, *buff =3D NULL;
> > +     int ret;
> > +
> > +     buff =3D kmalloc(val_size + BMI323_SPI_DUMMY, GFP_KERNEL);
 >
> As per i2c part.
>
> > +     if (!buff)
> > +             return -ENOMEM;
> > +
> > +     reg =3D *(u8 *)reg_buf | 0x80;
>
> Doesn't regmap configuration provide a way to set this?

Okay, I will make use of regmap .read_flag_mask member.
I will update this in the next series.

>
> > +     ret =3D spi_write_then_read(spi, &reg, sizeof(reg), buff,
> > +                               val_size + BMI323_SPI_DUMMY);
> > +     if (ret) {
> > +             kfree(buff);
> > +             return ret;
> > +     }
> > +
> > +     memcpy(val_buf, buff + BMI323_SPI_DUMMY, val_size);
> > +     kfree(buff);
> > +
> > +     return ret;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thank you
Jagath
