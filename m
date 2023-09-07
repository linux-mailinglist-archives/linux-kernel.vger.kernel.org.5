Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44C79782D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbjIGQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjIGQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:42:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8AA269A;
        Thu,  7 Sep 2023 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102913; x=1725638913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7CHvxDHCHPtOuBCQWw9gx4GqYSPc7pMh1YaZILhTDkk=;
  b=mFDRC5xcsROPUpyNTYsgGvxNkUJiv6pBu/s+Fw7EItP7vBPAutXGSAXE
   myZ+oMrAGlSNAIYBKT4ojk97EFD9A4Dktl8VY6joGgXN7+eH2hu44Luvl
   ZjvommVLOUROBJnzdtWjX/ktRDT1uF8Th+0bBcwlB31hz19pjOJQbl/Zp
   tA6e4eQ4TG8wrSRBfJE+pEMyVLVv/MgROO9xmungiwPl04JcDtIMeMYkn
   zjxM6JI4n48yRZpPtzFZkeiCLqYi9mI9v8ddNFh7XK34oZTnXc+35hcmn
   jy20FDy4Cs9Oy+3LO8hmVN19b2IOf/PjN4SsmmDJu/Q1XFH6naE9yK8N2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="380093378"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="380093378"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="771291695"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="771291695"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:57:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qeFW4-007K8K-0c;
        Thu, 07 Sep 2023 16:57:52 +0300
Date:   Thu, 7 Sep 2023 16:57:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <ZPnW38eO6by1NjIr@smile.fi.intel.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
 <ZPifWlRvX5hLFPvG@smile.fi.intel.com>
 <4d8e2873-49bc-8314-ee16-dd327a92898d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e2873-49bc-8314-ee16-dd327a92898d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:57:17AM +0300, Matti Vaittinen wrote:
> On 9/6/23 18:48, Andy Shevchenko wrote:
> > On Wed, Sep 06, 2023 at 03:37:48PM +0300, Matti Vaittinen wrote:

...

> > > +struct bm1390_data {
> > > +	int64_t timestamp, old_timestamp;
> > 
> > Out of a sudden int64_t instead of u64?
> 
> Judging the iio_push_to_buffers_with_timestamp() and iio_get_time_ns(), IIO
> operates with signed timestamps. One being s64, the other int64_t.
> 
> > > +	struct iio_trigger *trig;
> > > +	struct regmap *regmap;
> > > +	struct device *dev;
> > > +	struct bm1390_data_buf buf;
> > > +	int irq;
> > > +	unsigned int state;
> > > +	bool trigger_enabled;
> > 
> > > +	u8 watermark;
> > 
> > Or u8 instead of uint8_t?
> 
> So, uint8_t is preferred? I don't really care all that much which of these
> to use - which may even show up as a lack of consistency... I think I did
> use uint8_t when I learned about it - but at some point someone somewhere
> asked me to use u8 instead.. This somewhere might have been u-boot though...
> 
> So, are you Suggesting I should replace u8 with uint8_t? Can do if it
> matters.

Consistency matters, since I do not know the intention behind, I suggest use
either, but be consistent in the entire code. However, uXX are specific Linux
kernel internal types and some maintainers prefer them. Also you may grep for
the frequency of intXX_t vs. sXX or their unsigned counterparts.

> > > +	/* Prevent accessing sensor during FIFO read sequence */
> > > +	struct mutex mutex;
> > > +};

...

> > > +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
> > > +{
> > > +	u8 temp_reg[2] __aligned(2);
> > 
> > Why?! Just use proper bitwise type.
> 
> What is the proper bitwise type in this case?
> 
> I'll explain my reasoning:
> What we really have in hardware (BM1390) and read from it is 8bit registers.
> This is u8 to me. And as we read two consecutive registers, we use u8
> arr[2]. In my eyes it describes the data perfectly well, right?

Two different registers?! Why bulk is used in that case?
To me looks like you are reading 16-bit (or one that fits in 16-bit) register
in BE notation.

> > > +	__be16 *temp_raw;
> > > +	int ret;
> > > +	s16 val;
> > > +	bool negative;
> > > +
> > > +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
> > > +			       sizeof(temp_reg));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (temp_reg[0] & 0x80)
> > > +		negative = true;
> > > +	else
> > > +		negative = false;
> > 
> > > +	temp_raw = (__be16 *)&temp_reg[0];
> > 
> > Heck no. Make temp_reg be properly typed.
> 
> As I explained above, to me it seems ur arr[2} is _the_ proper type to
> represent data we read from the device.
> 
> What we need to do is to convert the 16bits of data to an integer we can
> give to the rest of the system. And, we happen to know how to 'manipulate'
> the data to get it in format of understandable integer. As we have these 16
> bits in memory, aligned to 2 byte boundary - why shouldn't we just
> 'manipulate' the data and say - here we have your integer, please be my
> guest and use it?

Because it smell like a hack and is a hack here.
Either it's a single BE16 register, or it's two different registers that by
very unknown reason you are reading in a bulk. The code in this form is no
go.

> Well, I am keen to learn the 'correct bitwise type' you talk about - can you
> please explain me what this correct type for two 8bit integers is? Maybe I
> can improve.

If the registers are not of the same nature the bulk access is wrong.
Use one by one reads.

> > > +	val = be16_to_cpu(*temp_raw);
> > > +
> > > +	if (negative) {
> > > +		/*
> > > +		 * Two's complement. I am not sure if all supported
> > > +		 * architectures actually use 2's complement represantation of
> > > +		 * signed ints. If yes, then we could just do the endianes
> > > +		 * conversion and say this is the s16 value. However, as I
> > > +		 * don't know, and as the conversion is pretty simple. let's
> > > +		 * just convert the signed 2's complement to absolute value and
> > > +		 * multiply by -1.
> > > +		 */
> > > +		val = ~val + 1;
> > > +		val *= -1;
> > > +	}
> > > +
> > > +	*temp = val;
> > > +
> > > +	return 0;
> > > +}

...

> > > +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
> > > +{
> > > +	int ret;
> > > +	u8 raw[3];
> > > +
> > > +	ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
> > > +			       &raw[0], sizeof(raw));

&raw[0] --> raw

> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);

This, btw, looks like le24, but I'm puzzled with right shift.
I need to read datasheet carefully to understand this.

> > > +	return 0;
> > > +}

...

> > > + /* The enum values map directly to register bits */
> > 
> > In this case assign _all_ values explicitly. Currently it's prone to errors
> > if somebody squeezed a value in between.
> 
> Agree. This is a good practice. Thanks. (although, it shouldn't really
> matter here as nobody really should squeeze a value in between as enum is
> short and we have this just comment above).

Right, but code can be done more robust against these. I do not see any
argument against this. It's cheap and correct to add assignments and
then we do not care about the sequence, even if somebody messes it up.

> > > +enum bm1390_meas_mode {
> > > +	BM1390_MEAS_MODE_STOP = 0x0,
> > > +	BM1390_MEAS_MODE_1SHOT,
> > > +	BM1390_MEAS_MODE_CONTINUOUS,
> > > +};

...

> > > +	mutex_lock(&data->mutex);
> > 
> > Wouldn't you like to start using cleanup.h?
> 
> The new macro "thingee" for C++ destructor like constructs?

I was talking about these: guard() / scoped_guard().

> TBH, I am not really in a rush with it for two reasons.
> 1) The syntax looks very alien to me. I would like to get some time to get
> used to it before voluntarily ending up maintaining a code using it. (I
> don't like practicing things upstream as practicing tends to include making
> more errors).
> 
> 2. Related to 1). I am not (yet) convinced incorporating changes in stuff
> using these cleanups is easy. I'm a bit reserved and would like to see how
> things play out.
> 
> 3. I expect I will get a few requests to backport the code to some older
> kernels used by some big customers. (I've been doing plenty of extra work
> when backporting my kernel improvements like regmap_irq stuff, linear
> ranges, regulator pickable ranges, gts-helpers to customer kernels to get my
> drivers working - or working around the lack of thiose features. I have been
> willing to pay this prize to get those helpers upstream for everyone to use.
> The cleanup.h however is there so it does not _need_ new users. I don't
> think _all_ existing drivers will be converted to use it so one more should
> probably not hurt. I think that in a year at least some customers will be
> using kernel containing the cleanup.h - so by latest then it is time for me
> to jump on that train. I hope I am used to reading those macros by then).

OK.

...

> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		if (chan->type == IIO_TEMP) {
> > > +			*val = 31;
> > > +			*val2 = 250000;
> > > +
> > > +			return IIO_VAL_INT_PLUS_MICRO;
> > > +		} else if (chan->type == IIO_PRESSURE) {
> > > +			*val = 0;
> > > +			/*
> > > +			 * pressure in hPa is register value divided by 2048.
> > > +			 * This means kPa is 1/20480 times the register value,
> > > +			 * which equals to 48828.125 * 10 ^ -9
> > > +			 * This is 48828.125 nano kPa.
> > > +			 *
> > > +			 * When we scale this using IIO_VAL_INT_PLUS_NANO we
> > > +			 * get 48828 - which means we lose some accuracy. Well,
> > > +			 * let's try to live with that.
> > > +			 */
> > > +			*val2 = 48828;
> > > +
> > > +			return IIO_VAL_INT_PLUS_NANO;
> > > +		}
> > > +
> > > +		return -EINVAL;
> > 
> > Why not switch-case like other drivers do?
> 
> In my eyes avoiding the very simple if - else if does not warrant nested
> switches which look ugly to me.

Okay, yet another disagreement.

> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret = iio_device_claim_direct_mode(idev);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret = bm1390_read_data(data, chan, val, val2);
> > > +		iio_device_release_direct_mode(idev);
> > 
> > > +		if (!ret)
> > > +			return IIO_VAL_INT;
> > > +
> > > +		return ret;
> > 
> > Why not usual pattern?
> > 
> > 		if (ret)
> > 			return ret;
> 
> I see your point, ok.
> 
> > > +	default:
> > > +		return -EINVAL;
> > > +	}

...

> > > +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
> > 
> > > +
> > 
> > Unneeded blank line.
> > 
> > > +	if (smp_lvl > 4) {
> > > +		/*
> > > +		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
> > > +		 * bit errors in I2C line. Don't overflow if this happens.
> > > +		 */
> > > +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
> > > +		smp_lvl = 4;
> > > +	}
> > 
> > > +	if (!smp_lvl)
> > > +		return ret;
> > 
> > This can be checked first as it's and error condition
> 
> I wouldn't say it is an error condition.

Returning ret suggests otherwise.

> It just means there was no samples
> collected in buffer.

But as you explained below, the code is actually 0 there.
In any case bailing out conditionals are better to be first.

>  and previous branch has
> > no side effects on this. Also, wouldn't be better to use error code explicitly?
> 
> Yes. For the clarity we definitely should explicitly do "return 0" here.
> Thanks.

-- 
With Best Regards,
Andy Shevchenko


