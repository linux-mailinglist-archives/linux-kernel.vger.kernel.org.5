Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72A7F4FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjKVSzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbjKVSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:55:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A2E93;
        Wed, 22 Nov 2023 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700679300; x=1732215300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DmyGZTLiw6DZM1o+vxlMQwrB7RXguFu8pPn+LN62oJw=;
  b=jnTQMss2fz4UBE/TMIQmLuG0Io/n2RQW7CWEABXXEUVE/hxDr5nMSYor
   SJHwteWKEeKOISVTxqzjiAcO1tMqO8P7tothrsWFTPekOnK7r2aFYJIaI
   4GD/FL4WqknfrAfqhBCQFqGSLPDZ68yQqR28Ue7xuUIZuTCaoIoBtVuDZ
   +DCtajs7U5gUIuG+UExWKY8y+xTLQpAs86wg+w1r2gAs4RlNakM2ULUNj
   5/K0j4DPLTRqg+igvyVy/vNnqdPj8wneZgXekkGLTT3RyWVcaro02FgjV
   pFGeM2WWVXqD7Qe4P6YTLkdNyrLrcy/HfZ43sdysKrdPinDbhpp1ExjBS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423249588"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="423249588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 10:39:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="796029519"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="796029519"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:49:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5kk2-0000000G47Y-272Q;
        Wed, 22 Nov 2023 12:45:58 +0200
Date:   Wed, 22 Nov 2023 12:45:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: driver for Honeywell HSC/SSC series
 pressure sensors
Message-ID: <ZV3b5sUrGEj5ZOF0@smile.fi.intel.com>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117164232.8474-2-petre.rodan@subdimension.ro>
 <ZVtSm5f-Qyp8LFFp@smile.fi.intel.com>
 <ZV2a213oidterHYZ@sunspire>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV2a213oidterHYZ@sunspire>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:08:27AM +0200, Petre Rodan wrote:
> On Mon, Nov 20, 2023 at 02:35:39PM +0200, Andy Shevchenko wrote:

...

> sorry, what is 'LKP' in this context and how do I reproduce?

It's an acronym for CI system run by Intel. You should have had an email in
your mailbox with complains. It also duplicates them to a mailing list which
address I don't know by heart.

...

> > Also there are missing at least these ones: array_size.h, types.h.
> 
> '#include <linux/array_size.h>' is a weird one.

Why?

> $ cd /usr/src/linux/drivers
> $ grep -r ARRAY_SIZE * | grep '\.c:' |  wc -l
>  32396
> $ grep -r 'include.*array_size\.h' * | grep -E '\.[ch]:' | wc -l
> 11
> $ grep -r 'include.*array_size\.h' * | grep -E '\.[ch]:' | grep -v '^pinctrl' | wc -l
> 0

Hint, use `git grep ...` which much, much faster against the Git indexed data.

> plus on a 6.1 version kernel, `make modules` actually reports that the header
> can't be found if I include it. can't comprehend that. so I'll be skipping
> that particular include.

No, the new code is always should be submitted against latest release cycle,
v6.7-rcX as of today. There is the header. Please, use it.

...

> > Can you utilize linear ranges data types and APIs? (linear_range.h)
> 
> not fit for this purpose, sorry.

NP.

...

> > > +	if (data->buffer[0] & 0xc0)
> > > +		return 0;
> > > +
> > > +	return 1;
> > 
> > You use bool and return integers.
> > 
> > Besides, it can be just a oneliner.
> 
> rewritten as a one-liner, without GENMASK.
> 
> > 	return !(buffer[0] & GENMASK(3, 2));
> > 
> > (Note, you will need bits.h for this.)
> > 
> > > +}

Why no GENMASK() ? What the meaning of the 0xc0?
Ideally it should be

#define ...meaningful name...  GENMASK()

...

> > > +		mutex_lock(&data->lock);
> > > +		ret = hsc_get_measurement(data);
> > > +		mutex_unlock(&data->lock);
> > 
> > Use guard() operator from cleanup.h.
> 
> I'm not familiar with that, for the time being I'll stick to
> mutex_lock/unlock if you don't mind.

I do mind. RAII is a method to make code more robust against forgotten
unlock/free calls.

...

> > > +		case IIO_PRESSURE:
> > > +			*val =
> > > +			    ((data->buffer[0] & 0x3f) << 8) + data->buffer[1];
> > > +			return IIO_VAL_INT;
> > > +		case IIO_TEMP:
> > > +			*val =
> > > +			    (data->buffer[2] << 3) +
> > > +			    ((data->buffer[3] & 0xe0) >> 5);
> > 
> > Is this some endianess / sign extension? Please convert using proper APIs.
> 
> the raw conversion data is spread over 4 bytes and interlaced with other info
> (see comment above the function).  I'm just cherry-picking the bits I'm
> interested in, in a way my brain can understand what is going on.

So, perhaps you need to use get_unaligned_.e32() and then FIELD_*() from
bitfield.h. This will be much better in terms of understanding the semantics
of these magic bit shifts and masks.

...

> > > +			ret = 0;
> > > +			if (!ret)
> > 
> > lol
> 
> I should leave that in for comic relief. missed it after a lot of code
> changes.

I understand, that's why no shame on you, just fun code to see :-)

...

> > Strange indentation of }:s...
> 
> I blame `indent -linux --line-length 80` for these and weirdly-spaced pointer
> declarations.  are you using something else?

Some maintainers suggest to use clang-format. I find it weird in some corner
cases. So, I would suggest to use it and reread the code and fix some
strangenesses.

...

> > > +	if (strcasecmp(hsc->range_str, "na") != 0) {
> > > +		// chip should be defined in the nomenclature
> > > +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> > > +			if (strcasecmp
> > > +			    (hsc_range_config[index].name,
> > > +			     hsc->range_str) == 0) {
> > > +				hsc->pmin = hsc_range_config[index].pmin;
> > > +				hsc->pmax = hsc_range_config[index].pmax;
> > > +				found = 1;
> > > +				break;
> > > +			}
> > > +		}
> > 
> > Reinventing match_string() / sysfs_match_string() ?
> 
> match_string() is case-sensitive and operates on string arrays, so unfit for
> this purpose.

Let's put it this way: Why do you care of the relaxed case?
I.o.w. why can we be slightly stricter?

...

> > Can you use regmap I2C?
> 
> the communication is one-way as in the sensors do not expect anything except
> 4 bytes-worth of clock signals per 'packet' for both the i2c and spi
> versions.  regmap is suited to sensors with an actual memory map.

If not yet, worse to add in the comment area of the patch
(after the cutter '---' line).

...

> > No use of this function prototype, we have a new one.
> 
> oops, I was hoping my 6.1.38 kernel is using the same API as 6.7.0
> fixed.

Same way with a (new) header :-)

...

> > > +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> > > +	if (ret == -EPROBE_DEFER)
> > > +		return -EPROBE_DEFER;
> > 
> > Oh, boy, this should check for ENODEV or so, yeah, regulator APIs a bit
> > interesting.
> 
> since I'm unable to test this I'd rather remove the block altogether.
> if I go the ENODEV route my module will never load since I can't see any
> vdd-supply support on my devboard.

No, what I meant is to have something like

	if (ret) {
		if (ret != -ENODEV)
			return ret;
		...regulator is not present...
	}

This is how it's being used in dozens of places in the kernel. Just utilize
`git grep ...` which should be a top-10 tool for the Linux kernel developer.

Q: ...
A: Try `git grep ...` to find your answer in the existing code.

...

> > > +	if (!dev_fwnode(dev))
> > > +		return -EOPNOTSUPP;
> > 
> > Why do you need this?
> > And why this error code?
> 
> it's intentional.
> this module has a hard requirement on the correct parameters (transfer
> function and pressure range) being provided in the devicetree.  without those
> I don't want to provide any measurements since there can't be a default
> transfer function and pressure range for a generic driver that supports an
> infinite combination of those.
> 
> echo hsc030pa 0x28 > /sys/bus/i2c/devices/i2c-0/new_device
> I want iio_info to detect 0 devices.

So, fine, but the very first mandatory property check will fail as it has
the very same check inside. So, why do you need a double check?

-- 
With Best Regards,
Andy Shevchenko


