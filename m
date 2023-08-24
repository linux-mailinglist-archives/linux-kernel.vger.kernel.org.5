Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13739787055
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbjHXNfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbjHXNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:35:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF3A19A8;
        Thu, 24 Aug 2023 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884118; x=1724420118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1jZ/aiaJGxJZwBAAGXAHF5rMlxlslZZhT8hph6XpXvs=;
  b=oE3RIZ9t6WPPZmlcFLY0oXXbklbHFLubtSsc1S1tkBAbEMEj8xgOiT1U
   uzYiECu1qZv3lZWnCkzaZOXQkCw87r02/BMa2Ghol8GxdGdm6FrKz7PYQ
   kpwQJEUP3gqOJOO4Qq9E9B1108V6EyQt8KdY1q4LDzfZCwCGFSjSwGSR6
   vVwrIKEix9nfyHA2kOp1KjDAPMjjG/vPKIh4Dab7ajjsp8Fk1beqJ2XOE
   Qej+AobQnm8D6HJua9pnDhJR8JohqmctnZ6rkM5QgIebQGvVqnTR10E5L
   pdU2km34ZO5X6xN7Zq6N682WW/wI/QxkZJz7xqwaWsf9MJPCjPDqwRk4k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="373317461"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373317461"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860704164"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860704164"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 06:35:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qZAUO-005Xtp-0B;
        Thu, 24 Aug 2023 16:35:08 +0300
Date:   Thu, 24 Aug 2023 16:35:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        quic_jhugo@quicinc.com, nipun.gupta@amd.com, tzimmermann@suse.de,
        ogabbay@kernel.org, mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org
Subject: Re: [PATCHv5 4/4] wiegand: add Wiegand GPIO bitbanged controller
 driver
Message-ID: <ZOdciyyM4/BYxXL9@smile.fi.intel.com>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-5-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824111015.57765-5-m.zatovic1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:10:15PM +0200, Martin Zaťovič wrote:
> This controller formats the data to a Wiegand format and bit-bangs
> the message on devicetree defined GPIO lines.
> 
> The driver creates a dev file for writing messages on the bus.
> It also creates a sysfs file to control the payload length of
> messages(in bits). If a message is shorter than the set payload
> length, it will be discarded. On the other hand, if a message is
> longer, the additional bits will be stripped off.

...

> +Date:		August 2023

Unrealistic. Use https://hansen.beer/~dave/phb/ to define Date and
KernelVersion fields.

...

> +#define WIEGAND_DEFAULT_PAYLOAD_LEN 26

_LEN --> _BITS

...

> +	return store_ulong(&(ctlr->payload_len), buf, count, WIEGAND_MAX_PAYLEN_BYTES * 8);

Yeah, again use _BITS directly.

...

> +/**
> + * wiegand_gpio_send_bit - Sends a single bit

Do not forget to validate this with scripts/kernel-doc.

> + * @wiegand_gpio: Instance of the Wiegand
> + * @value: Bit value to send
> + * @last: Indicates last bit of a message
> + *
> + * To send a bit of value 1 following the wiegand protocol, one must set
> + * the wiegand_data_hi to low for the duration of pulse. Similarly to send
> + * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
> + * This way the two lines are never low at the same time.
> + */

...

> +	struct gpio_desc *gpio = value ? wiegand_gpio->gpios->desc[1] :
> +						wiegand_gpio->gpios->desc[0];

Make it separate line.

	gpio = value ? wiegand_gpio->gpios->desc[1] : wiegand_gpio->gpios->desc[0];

...

> +	wiegand_gpio->gpios = devm_gpiod_get_array(dev, "data", GPIOD_OUT_HIGH);

> +

Redundant blank line.

> +	if (IS_ERR(wiegand_gpio->gpios))
> +		dev_err(dev, "unable to get gpios\n");
> +
> +	return PTR_ERR_OR_ZERO(wiegand_gpio->gpios);

Oh.

	wiegand_gpio->gpios = devm_gpiod_get_array(dev, "data", GPIOD_OUT_HIGH);
	ret = PTR_...();
	if (ret)
		dev_err();

	return ret;

...

> +static int wiegand_gpio_probe(struct platform_device *device)

	device --> pdev

...

> +static const struct of_device_id wiegand_gpio_dt_idtable[] = {
> +	{ .compatible = "wiegand-gpio", },

Inner comma is not needed.

> +	{}
> +};

-- 
With Best Regards,
Andy Shevchenko


