Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1E7A8341
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjITNY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjITNYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:24:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF74A9;
        Wed, 20 Sep 2023 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695216287; x=1726752287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Tyj0cydey/ymDMGIDQQo9CV3/1bKrFtgFm68wCMNQQQ=;
  b=IgwI43YxSrIxrsi21phOsNtbOD15VC74H8wjo+V/UqV9F+SJNHU89fsP
   jqVlBNR/llB2pbZ1aUdkDfqK+cXxs/tyioZR/VB1Vlc6oBLTOJDe/YIj5
   W7zr5wQUQKHHvfVcSKe8PCvlToH9bYSfBG23L47Ce6rOGy5CH7S1JTQnn
   JBv+Go2YoueRfMEOrcoMRS7Y5S+jvbZTj+WIYZFzN3SgjtmEsLGaSEZEF
   yiDud7DnsamInrX1Hxrxb0k9kMwFORK00+cOAg3pMvoLkaeqtvFyDHrx3
   OGJm3DjoP1K5ESh99PWNRQ/CX2NW4ciFOxvZeVFMyqRcpOIkiNzEVPKgR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446689696"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="446689696"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="696296960"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="696296960"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:24:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qixC5-0000000DMZP-2iOQ;
        Wed, 20 Sep 2023 16:24:41 +0300
Date:   Wed, 20 Sep 2023 16:24:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <ZQrymdrhH9BSylsb@smile.fi.intel.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com>
 <ZQggiuLyLGq/ekMS@smile.fi.intel.com>
 <CAM+2EuKXW+FsgY6rp=ugU03owJS6ReeWUNWOcMKiUfomiY_a2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM+2EuKXW+FsgY6rp=ugU03owJS6ReeWUNWOcMKiUfomiY_a2Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 04:13:51AM +0530, Jagath Jog J wrote:
> On Mon, Sep 18, 2023 at 3:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:

...

> >         unsigned int state_value = GENMASK();
> >
> > > +     switch (dir) {
> > > +     case IIO_EV_DIR_RISING:
> > > +             msk = BMI323_FEAT_IO0_XYZ_MOTION_MSK;
> > > +             raw = 512;
> > > +             config = BMI323_ANYMO1_REG;
> > > +             irq_msk = BMI323_MOTION_MSK;
> > > +             set_mask_bits(&irq_field_val, BMI323_MOTION_MSK,
> > > +                           FIELD_PREP(BMI323_MOTION_MSK, motion_irq));
> > > +             set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_MOTION_MSK,
> > > +                           FIELD_PREP(BMI323_FEAT_IO0_XYZ_MOTION_MSK,
> > > +                                      state ? 7 : 0));
> >
> > state_value
> 
> Sorry I didn't get this, I am updating field_value based on state value.
> What is the purpose of state_value?

Something like this I meant:

	unsigned int state_value = state ? GENMASK(2, 0) : 0;
	...
	switch (dir) {
	case IIO_EV_DIR_RISING:
		...
		set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_MOTION_MSK,
			      FIELD_PREP(BMI323_FEAT_IO0_XYZ_MOTION_MSK, state_value));

> > > +             break;
> > > +     case IIO_EV_DIR_FALLING:
> > > +             msk = BMI323_FEAT_IO0_XYZ_NOMOTION_MSK;
> > > +             raw = 0;
> > > +             config = BMI323_NOMO1_REG;
> > > +             irq_msk = BMI323_NOMOTION_MSK;
> > > +             set_mask_bits(&irq_field_val, BMI323_NOMOTION_MSK,
> > > +                           FIELD_PREP(BMI323_NOMOTION_MSK, motion_irq));
> > > +             set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_NOMOTION_MSK,
> > > +                           FIELD_PREP(BMI323_FEAT_IO0_XYZ_NOMOTION_MSK,
> > > +                                      state ? 7 : 0));

Ditto.

> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }

...

> > > +     ret = bmi323_feature_engine_events(data, BMI323_FEAT_IO0_STP_CNT_MSK,
> > > +                                        val ? 1 : 0);
> >
> > Ternary here...
> >
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     set_mask_bits(&data->feature_events, BMI323_FEAT_IO0_STP_CNT_MSK,
> > > +                   FIELD_PREP(BMI323_FEAT_IO0_STP_CNT_MSK, val ? 1 : 0));
> >
> > ...and here are dups.
> 
> Is the ternary operator not permitted to use?

Yes, it's permitted. My point that you can calculate once the value

	unsigned int value = val ? 1 : 0;

and use it everywhere where it makes sense.

...

> > > +static int bmi323_get_temp_data(struct bmi323_data *data, int *val)
> > > +{
> > > +     unsigned int value;
> >
> > Why it's not defined as __le16 to begin with?
> 
> To match the regmap_read() val parameter I used unsigned int*.
> 
> Note: each sensor register values are 16 bit wide
> and regmap is configured with .val_bits = 16.

> > > +     ret = regmap_read(data->regmap, BMI323_TEMP_REG, &value);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     *val = sign_extend32(le16_to_cpup((const __le16 *)&value), 15);
> >
> > No, simply no castings here.

This is an interesting case.

Your regmap configuration tells about endianess of the accessors. Default
IIRC is defined either by bus or by driver itself.

That said, since you are not using _raw variants of the accessors,
the above will give you a wrong result on BE.

Hence

	*val = sign_extend32(&value), 15);

should be enough.

(Note, the _raw variants take void pointer on purpose.)

...

> > > +     regmap = dev_get_regmap(dev, NULL);
> > > +     if (!regmap) {
> > > +             dev_err(dev, "No regmap\n");
> > > +             return -EINVAL;
> >
> > Why not dev_err_probe()?
> 
> There was no int return value from dev_get_regmap(),
> I think I can use -EINVAL for err in dev_err_probe as well.

Yes, it's fine.

> > > +     }

...

> > > +static int bmi323_regmap_i2c_write(void *context, const void *data,
> > > +                                size_t count)
> > > +{
> > > +     struct device *dev = context;
> > > +     struct i2c_client *i2c = to_i2c_client(dev);
> > > +     int ret;
> > > +     u8 reg;
> > > +
> > > +     reg = *(u8 *)data;
> > > +     ret = i2c_smbus_write_i2c_block_data(i2c, reg, count - 1,
> > > +                                          data + sizeof(u8));
> > > +
> > > +     return ret;
> > > +}
> >
> > Hmm... Don't we have a better approach for these? regmap doesn't provide SMBus
> > accessors?
> 
> Custom implementation is required for the 'read' operation, while
> 'write' can utilize the regmap SMBus accessors. Is it okay to have
> only custom read while write uses the SMBus accessor?

Yes, why not, but I don't know if regmap API allows this.

-- 
With Best Regards,
Andy Shevchenko


