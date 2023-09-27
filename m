Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1187B0D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjI0T77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0T76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:59:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1CD10A;
        Wed, 27 Sep 2023 12:59:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso7423552a12.3;
        Wed, 27 Sep 2023 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844794; x=1696449594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNaOKalGGr5fB0E4Vib9FjG5t+ODPWRm5MNzoAemRaY=;
        b=UMbhI9DrZbrgARjBurk1bRKgWicgZZbHaePsXMbXiAJ9TS6NVP7XoiNAE7wzV64/7P
         EONGqaw8D9LAX0CrORoD8DrMNL94ECaoLH/j+mMdsgHp9OgOUasRflGPfliB8e8qqoHg
         DfI7ClTjp/bug/KXderFaTT0cy18qCgVwgLDM/bT7pYb3x654jUfwVo4mewYSdqQT99G
         FHEfylKpiustp0LdAoI5fvaaSjXFAH0/5PzTj3RvscasSCeDY15xpV1JIVFXv21vpJfh
         lv9u3CZb/iQ8w7m6S82NZjXAutOhvX/lM530WfVJ5JJ35XRqOKgLGKNQ7ndMBdSeX8m6
         V54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844794; x=1696449594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNaOKalGGr5fB0E4Vib9FjG5t+ODPWRm5MNzoAemRaY=;
        b=kc/ZxMwHhG7tmyIF+fZHpuGo8GEop13QFUq4HS5SsRyfceLg085TfekHQpqGvRaQGw
         nc0jboEaNOVZD6OUoJEB4JbPva1ASirkrRPyr7m99NRkFZ1LGyUXC+3emeUtm/MMfhVB
         iB982bO7o0LGhrL8RvkWrDDje+bDEXs3rn5XQ5Mo6QdVutt4LgaR+GvYJgVUNGziV/P/
         eFJrTsekNPE9dLXDQiusF61YhHQDjt48QZkNBMKW4tAMHgGI8PgahFDs30cKugWz1sBm
         KSI1hCbVkzZQ+wWFh0CYm70Km091xl0cks1kpDaOB1sGO9kpxVkHiVczRSP1WGmB8m+8
         Eh8Q==
X-Gm-Message-State: AOJu0YyihVEQ4AzO81pI5mc2aXCNwN2oCxfRkBmP4eVjVyA8OONKnEJq
        8NXQQmb77AT+qIifYerdXvo7+hRCYZ8YTL9GWo4=
X-Google-Smtp-Source: AGHT+IH0XaPAMcB28CUPyifQ7iyQeX3PGjHkuh5W8e6PLcR8Rf8i4EjZQa5pyTnNXuw0gpI7NOTblZIOxmDmIkAYW3Q=
X-Received: by 2002:aa7:c402:0:b0:51e:53eb:88a3 with SMTP id
 j2-20020aa7c402000000b0051e53eb88a3mr2948315edq.25.1695844793993; Wed, 27 Sep
 2023 12:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com> <20230924153055.0b3486f9@jic23-huawei>
In-Reply-To: <20230924153055.0b3486f9@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Thu, 28 Sep 2023 01:29:42 +0530
Message-ID: <CAM+2EuJBxj7P-ymu84u308g8LCemSEsYi_TSHYtaK9PyrhqrfA@mail.gmail.com>
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Jonathan,

Thank you for the review.

On Sun, Sep 24, 2023 at 8:01=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 18 Sep 2023 13:33:14 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
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
> >
> > Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloa=
ds/datasheets/bst-bmi323-ds000.pdf
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
>
> Given Andy has done a thorough review (as he always does!)
> and there is quite a bit in my review queue, I'll just scan
> through quickly and call out a few things.  Will take a closer
> look at next version.
>
> One thing that is useful for a complex driver like this is to include
> (typically in the cover letter) a full listing of what shows up in sysfs.
> That gives an easy way to check the ABI looks right without having to fig=
ure
> out what all the generated file names are from the code.

Sure, I will add all ABI's in the cover letter.

Please note that I omitted certain portions of your reviews
while responding, and I agree with the review comments that
I didn't address. I intend to make the necessary corrections
in the next series.

>
> Thanks,
>
> Jonathan
>

> > +struct bmi323_data {
> > +     struct device *dev;
> > +     struct regmap *regmap;
> > +     struct iio_mount_matrix orientation;
> > +     enum bmi323_irq_pin irq_pin;
> > +     struct iio_trigger *trig;
> > +     bool drdy_trigger_enabled;
> > +     enum bmi323_state state;
> > +     s64 fifo_tstamp, old_fifo_tstamp;
> > +     u32 odrns[2];
> > +     u32 odrhz[2];
> > +     unsigned int feature_events;
> > +
> > +     /*
> > +      * Lock to protect the members of device's private data from conc=
urrent
> > +      * access and also to serialize the access of extended registers.
> > +      * See bmi323_write_ext_reg(..) for more info.
> > +      */
> > +     struct mutex mutex;
> > +     int watermark;
> > +     __le16 fifo_buff[BMI323_FIFO_FULL_IN_WORDS] __aligned(IIO_DMA_MIN=
ALIGN);
> > +     struct {
> > +             __le16 channels[6];
> > +             s64 ts __aligned(8);
>
> Hopefully Andy's aligned_s64 set will land soon and we can tidy this up.
> I'm a bit unsure of this, but can you overlap some of these buffers or ar=
e
> they used concurrently? (if they are then we have problems with DMA safet=
y.)
>
> Perhaps an anonymous union is appropriate?

Yes both buffers are used at the same time. In fifo_flush
fifo_buff is used to store all fifo data, and buffer is
used to push a single data frame to iio buffers, overlapping
will corrupt the data, so I used separate buffers for both.

> > +static int bmi323_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > +                                          bool state)
> > +{
> > +     struct bmi323_data *data =3D iio_trigger_get_drvdata(trig);
> > +     enum bmi323_irq_pin irq_pin;
> > +     int ret;
> > +
> > +     mutex_lock(&data->mutex);
> guard(mutex)(&data->mutex);

Andy also suggested the same.
Sure I will use helpers from cleanup.h.

> > +static IIO_DEVICE_ATTR_RW(in_accel_gyro_averaging, 0);
> > +static IIO_CONST_ATTR(in_accel_gyro_averaging_available, "2 4 8 16 32 =
64");
> > +
> > +static struct attribute *bmi323_attributes[] =3D {
> > +     &iio_dev_attr_in_accel_gyro_averaging.dev_attr.attr,
> > +     &iio_const_attr_in_accel_gyro_averaging_available.dev_attr.attr,
>
> So averaging often maps directly to oversampling.  Kind of different name=
s
> for the same thing.  Perhaps that standard ABI can be used?
> It tends to make sampling frequency reporting need to take it into accoun=
t
> though as that drops as divided by oversampling ratio.

Yes, oversampling can be used, but changing the average
value doesn't alter the sampling frequency. The sampling
frequency is same even with the increase in averaging value.

> > +#define BMI323_SCAN_MASK_ACCEL_3AXIS         \
> > +     (BIT(BMI323_ACCEL_X) | BIT(BMI323_ACCEL_Y) | BIT(BMI323_ACCEL_Z))
> > +
> > +#define BMI323_SCAN_MASK_GYRO_3AXIS          \
> > +     (BIT(BMI323_GYRO_X) | BIT(BMI323_GYRO_Y) | BIT(BMI323_GYRO_Z))
> > +
> > +static const unsigned long bmi323_avail_scan_masks[] =3D {
> > +     /* 3-axis accel + 3-axis gyro */
> > +     BMI323_SCAN_MASK_ACCEL_3AXIS | BMI323_SCAN_MASK_GYRO_3AXIS,
>
> Can you poke this an see if you get what you expect which is the minimum
> sufficient set of channels.  Matti pointed out earlier that the search
> logic isn't well documented in iio_scan_mask_match() but it
> looks to match against first case where the requested values are a subset=
.
> So this would need to be in the opposite order or you will always
> get everything turned on.

Sure, I will check and update you further on this.

>
> Chances are we have this wrong in other drivers as well :(
> Won't break things, but may mean that we over read in some configurations=
.
>
> > +     /* 3-axis accel */
> > +     BMI323_SCAN_MASK_ACCEL_3AXIS,
> > +     /* 3-axis gyro */
> > +     BMI323_SCAN_MASK_GYRO_3AXIS,
> > +     0
> > +};
> > +

> > +     irq_type =3D irqd_get_trigger_type(desc);
> > +
> > +     switch (irq_type) {
> > +     case IRQF_TRIGGER_RISING:
> > +             latch =3D false;
> > +             active_high =3D true;
> > +             break;
> > +     case IRQF_TRIGGER_HIGH:
> > +             latch =3D true;
> > +             active_high =3D true;
> > +             break;
> > +     case IRQF_TRIGGER_FALLING:
> > +             latch =3D false;
> > +             active_high =3D false;
> > +             break;
> > +     case IRQF_TRIGGER_LOW:
> > +             latch =3D true;
> > +             active_high =3D false;
> > +             break;
> > +     default:
> > +             dev_err(data->dev, "Invalid interrupt type 0x%x specified=
\n",
> > +                     irq_type);
> > +             return -EINVAL;
> > +     }
> > +
> > +     open_drain =3D fwnode_property_read_bool(fwnode, "drive-open-drai=
n");
> > +
> > +     ret =3D bmi323_int_pin_config(data, irq_pin, active_high, open_dr=
ain,
> > +                                 latch);
> > +     if (ret)
> > +             return dev_err_probe(data->dev, ret,
> > +                                  "Failed to configure irq line\n");
> > +
> > +     data->trig =3D devm_iio_trigger_alloc(data->dev, "%s-trig-%d",
> > +                                         indio_dev->name, irq_pin);
> > +     if (!data->trig)
> > +             return -ENOMEM;
> > +
> > +     data->trig->ops =3D &bmi323_trigger_ops;
> > +     iio_trigger_set_drvdata(data->trig, data);
> > +
> > +     ret =3D devm_request_threaded_irq(data->dev, irq, NULL,
> > +                                     bmi323_irq_thread_handler,
> > +                                     irq_type | IRQF_ONESHOT,
>
> I think if you leave the irq_type bit out, it will be set up to match wha=
t was
> specified in firmware anyway. Could be wrong on that though so check.

Yes, irq_type is not required __setup_irq() is handling that.
Thanks for pointing it out.

> > +
> > +static int bmi323_feature_engine_enable(struct bmi323_data *data, bool=
 en)
> > +{
> > +     unsigned int feature_status;
> > +     int ret, i;
> > +
> > +     if (en) {
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
> > +
> > +             i =3D 5;
>
> Why 5?

No specific reason, during testing the feature engine was
taking around 4 milliseconds, so I thought of checking
every 2 milliseconds and max of 5 trials.

>
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

> > +
> > +     indio_dev->name =3D "bmi323-imu";
> > +     indio_dev->info =3D &bmi323_info;
> > +     indio_dev->channels =3D bmi323_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(bmi323_channels);
> > +     indio_dev->available_scan_masks =3D bmi323_avail_scan_masks;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> > +     dev_set_drvdata(data->dev, indio_dev);
> > +
> > +     ret =3D bmi323_trigger_probe(data, indio_dev);
>
> What if interrupt isn't wired?  Do we need it for basic read of channels?
> Would expect the interfaces provided to be more limited, but not that we
> would provide none at all.

Yes, the basic read of channels will be available even
if none of the interrupts are wired and trigger buffer
through sysfs or hrt timer is also available.

>
> > +     if (ret)
> > +             return -EINVAL;
> > +
> > +     ret =3D devm_iio_triggered_buffer_setup_ext(data->dev, indio_dev,
> > +                                               &iio_pollfunc_store_tim=
e,
> > +                                               bmi323_trigger_handler,
> > +                                               IIO_BUFFER_DIRECTION_IN=
,
> > +                                               &bmi323_buffer_ops,
> > +                                               bmi323_fifo_attributes)=
;
> > +     if (ret)
> > +             return dev_err_probe(data->dev, ret,
> > +                                  "Failed to setup trigger buffer\n");

> > + * From BMI323 datasheet section 4: Notes on the Serial Interface Supp=
ort.
> > + * Each I2C register read operation requires to read two dummy bytes b=
efore
> > + * the actual payload.
> > + */
> > +static int bmi323_regmap_i2c_read(void *context, const void *reg_buf,
> > +                               size_t reg_size, void *val_buf,
> > +                               size_t val_size)
> > +{
> > +     struct device *dev =3D context;
> > +     struct i2c_client *i2c =3D to_i2c_client(dev);
> > +     struct i2c_msg msgs[2];
> > +     u8 *buff =3D NULL;
> > +     int ret;
> > +
> > +     buff =3D kmalloc(val_size + BMI323_I2C_DUMMY, GFP_KERNEL);
> > +     if (!buff)
> > +             return -ENOMEM;
> > +
> > +     msgs[0].addr =3D i2c->addr;
> > +     msgs[0].flags =3D i2c->flags;
> > +     msgs[0].len =3D reg_size;
> > +     msgs[0].buf =3D (u8 *)reg_buf;
> > +
> > +     msgs[1].addr =3D i2c->addr;
> > +     msgs[1].len =3D val_size + BMI323_I2C_DUMMY;
> > +     msgs[1].buf =3D (u8 *)buff;
> > +     msgs[1].flags =3D i2c->flags | I2C_M_RD;
> > +
> > +     ret =3D i2c_transfer(i2c->adapter, msgs, ARRAY_SIZE(msgs));
> > +     if (ret < 0) {
> > +             kfree(buff);
> > +             return -EIO;
> > +     }
> > +
> > +     memcpy(val_buf, buff + BMI323_I2C_DUMMY, val_size);
>
> Annoyingly can't do same trick as I suggest for SPI as we need
> the address send vs when data turns up to be correct.
>
> Whilst this code is 'generic' do you know the max size of the
> buffer that might be read?  If it's small I'd just use an array
> on the stack.  If large, then the cleanup.h stuff will help
> with code, but it's still annoying to have to do an allocation
> in here.  You can probably put something in context alongside
> dev.

A buffer size of 2028 bytes is required when configuring
the FIFO watermark for maximum capacity. Since the
necessary buffer size is substantial, I am allocating
it dynamically.

I will try to use an additional buffer from the device's
private structure and pass it through the context.
This approach will help reduce the memory allocation
and deallocation on every device access.

> > + * From BMI323 datasheet section 4: Notes on the Serial Interface Supp=
ort.
> > + * Each SPI register read operation requires to read one dummy byte be=
fore
> > + * the actual payload.
> > + */
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
> Hmm.  Regmap has pad_bits (which can be multiple bytes) but this case
> is unusual in that they only apply to reads.
>
> I wonder if we can make this cheaper though rather than having
> to handle either some context or having dynamic allocations in here.
>
> How about making the write bigger?  Does that have any effect?
> Looks like don't care state in Figure 31.  If that's the case,
> send some zeros on that as it's known fixed size (2 bytes including
> the padding) and then you can directly use the read buffer without
> yet another memcpy.

For spi with pad_bits=3D8 and without any custom read and
write functions, regmap_read() works but regmap_write()
does not. Write is also adding 8 bits of padding and
the device is treating it as data.
(7.2.3 SPI Protocol Figure 30)

>
>
> > +     if (!buff)
> > +             return -ENOMEM;
> > +
> > +     reg =3D *(u8 *)reg_buf | 0x80;
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

Regards
Jagath
