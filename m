Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0E787889
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbjHXTdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbjHXTdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:33:03 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D11FC0;
        Thu, 24 Aug 2023 12:32:58 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64f5aeb81d1so1238556d6.0;
        Thu, 24 Aug 2023 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692905577; x=1693510377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXTiADtFRccT5Y0voFX1op9t21pDs8SfnmVkAo137ds=;
        b=jAMC81iGLsIWjAraBZgU89taVexv2lGcT2XTVx0NSJT5edaiaL82F0Fo6k2LU7afwv
         yNO7vcns1ie2vGK886yelsn9ltvOtbIvL03DF6noVdGO0R09Q7NVGsjaO0vdrSdnKEjb
         1yzK73KgWPELXEXqerthwGzLVcLxpMefghRGGu/9tLnqQ1Z1rdkBBSU3DLbUGVhj2lLW
         +GuDEWkp9klPubtECtYzftIM/YzTLQERtAzVNY3UVj3xXjcyzpaGihe0I6RBLr3KN0mh
         NopzbXMokeS5ptQ4HXoKe7aCd6KY3HckI0G/sG1eZXIN+etAltRrFfv7Abvb630Golx4
         YGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692905577; x=1693510377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXTiADtFRccT5Y0voFX1op9t21pDs8SfnmVkAo137ds=;
        b=K6FlC2qg8HUN+UM7kpdIO6Ey1i3XISLp4JNym8I+wXvbN+mXYIq2YsGXy4h2zM9huQ
         Ppx627TLTYNZ2E6PRBULm+F4zIUYGyJp9zIDqEUIHV5z1Xuu7sdvNP+L0jGNCwxIG5lT
         36GiLBkZI5G4/D72+i1joF8hjvfwaL1lWm7pCtzfaMcWaErUi8tX3UO/rBz2pMdZLIGO
         E6xiNg0XIW8UuzNiExWVqIQFhj+XvEsZ8ClrsgDeyJkUfgzC/fDuUU2x8UKZgyYDSY/W
         INjlUEtM6KI8lS3iixb2AuBNnIfu6evtK9qbofCxPsGQWTn9He6BjyvS43sagFleyxYt
         YnBQ==
X-Gm-Message-State: AOJu0YxmtbXhocyoSPzsqB4YDFc7T6UxTZihHGbyyZwtSJjmwCYhaKNy
        Ohv8fgv4xK2ZkQBlYeyljeU=
X-Google-Smtp-Source: AGHT+IGwWWK+z/JuHDt19SBFENb3BLGaGrIO8dsgT43TTRjXI0smAq9VkMOoyvvThqOYKrJbhlcj7g==
X-Received: by 2002:a05:6214:3bc4:b0:64f:42f7:8452 with SMTP id ng4-20020a0562143bc400b0064f42f78452mr14950509qvb.40.1692905577002;
        Thu, 24 Aug 2023 12:32:57 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id l9-20020a0ce509000000b0064a5de64668sm14353qvm.141.2023.08.24.12.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 12:32:56 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:32:54 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: add ltc2309 support
Message-ID: <20230824193254.GB3659959@shaak>
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
 <20230824-ltc2309-v1-1-b87b4eb8030c@gmail.com>
 <fe4a3bf9-2260-fb41-a20b-2bf05b6c02e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4a3bf9-2260-fb41-a20b-2bf05b6c02e9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:00:11PM +0200, Krzysztof Kozlowski wrote:
> On 24/08/2023 18:55, Liam Beguin wrote:
> > The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> > 
> > This implements support for all single-ended and differential channels,
> > in unipolar mode only.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > ---
> >  drivers/iio/adc/Kconfig   |  10 ++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/ltc2309.c | 232 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 243 insertions(+)
> > 
> 
> 
> 
> > +static int ltc2309_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct ltc2309 *ltc2309 = iio_priv(indio_dev);
> > +	u16 buf;
> > +	int ret;
> > +	u8 din;
> > +
> > +	mutex_lock(&ltc2309->lock);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		din = FIELD_PREP(LTC2309_DIN_CH_MASK, chan->address & 0x0f) |
> > +			FIELD_PREP(LTC2309_DIN_UNI, 1) |
> > +			FIELD_PREP(LTC2309_DIN_SLEEP, 0);
> > +
> > +		ret = i2c_smbus_write_byte(ltc2309->client, din);
> > +		if (ret < 0) {
> > +			dev_err(ltc2309->dev, "i2c command failed: %pe\n",
> > +				ERR_PTR(ret));
> > +			goto out;
> > +		}
> > +
> > +		ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
> > +		if (ret < 0) {
> > +			dev_err(ltc2309->dev, "i2c read failed: %pe\n",
> > +				ERR_PTR(ret));
> > +			goto out;
> > +		}
> > +
> > +		*val = be16_to_cpu(buf) >> 4;
> > +
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = ltc2309->vref_mv;
> > +		*val2 = LTC2309_ADC_RESOLUTION;
> > +		ret = IIO_VAL_FRACTIONAL_LOG2;
> 
> Why this case is in critical section?
> 

my bad, I'll reduce it to INFO_RAW.

> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&ltc2309->lock);
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info ltc2309_info = {
> > +	.read_raw = ltc2309_read_raw,
> > +};
> > +
> > +static int ltc2309_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct ltc2309 *ltc2309;
> > +	int ret = 0;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ltc2309));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	ltc2309 = iio_priv(indio_dev);
> > +	ltc2309->dev = &indio_dev->dev;
> > +	ltc2309->client = client;
> > +	ltc2309->vref_mv = 4096; /* Default to the internal ref */
> > +
> > +	indio_dev->name = DRIVER_NAME;
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = ltc2309_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
> > +	indio_dev->info = &ltc2309_info;
> > +
> > +	ltc2309->refcomp = devm_regulator_get_optional(&client->dev, "refcomp");
> > +	if (!IS_ERR_OR_NULL(ltc2309->refcomp)) {
> > +		ret = regulator_enable(ltc2309->refcomp);
> > +		if (ret) {
> > +			dev_err(ltc2309->dev, "failed to enable REFCOMP\n");
> > +			return ret;
> > +		}
> > +
> > +		ret = regulator_get_voltage(ltc2309->refcomp);
> > +		if (ret < 0)
> 
> You have unbalanced regulator. Same in all further error paths.
> 

Right, will fix.

I was going to add an action with devm_add_action_or_reset(), and
noticed a lot of duplicate code adding a custom disable action. Does
adding something like this make sense?

-- >8 --

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 90bb0d178885..ff94f35fad87 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -70,12 +70,17 @@ struct regulator *devm_regulator_get_exclusive(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_get_exclusive);

-static void regulator_action_disable(void *d)
+/**
+ * regulator_action_disable - Generic disable action for managed resource
+ * @d: regulator to disable
+ */
+void regulator_action_disable(void *d)
 {
 	struct regulator *r = (struct regulator *)d;

 	regulator_disable(r);
 }
+EXPORT_SYMBOL_GPL(regulator_action_disable);

 static int _devm_regulator_get_enable(struct device *dev, const char *id,
 				      int get_type)
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 39b666b40ea6..4c018af5d008 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -207,6 +207,8 @@ struct regulator *__must_check regulator_get_optional(struct device *dev,
 						      const char *id);
 struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
 							   const char *id);
+
+void regulator_action_disable(void *d);
 int devm_regulator_get_enable(struct device *dev, const char *id);
 int devm_regulator_get_enable_optional(struct device *dev, const char *id);
 void regulator_put(struct regulator *regulator);

-- >8 --

This would let consumers reuse it directly with something like:

	devm_add_action_or_reset(ltc2309->dev,
				 regulator_action_disable,
				 ltc2309->vref);


Maybe it should be a separate series, including the cleanup?

> > +			return ret;
> > +
> > +		ltc2309->vref_mv = ret / 1000;
> > +		if (ret)
> > +			return ret;

I just noticed this extra if. will remove too.

> > +	}
> > +
> > +	mutex_init(&ltc2309->lock);
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Liam
