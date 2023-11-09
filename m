Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993E97E70EE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344859AbjKIRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbjKIRyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:54:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FCD3A81;
        Thu,  9 Nov 2023 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699552484; x=1731088484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W+SHpRUTX0bjysEqjA1XdgPiJiwC/4AQT1Ukvj3HDhQ=;
  b=ZzCzhH+o8KycKVCBQS8bUHF7VfpciT21DTI/LTuSMnlijTKAmVE0H3v6
   gyt8eE+EyNn+vUXxbU+08PMFpgF+CsnguTU1LGw1IOG5zgANvF+T5L4wA
   89efGH4uR1Xpll7HeExWOrb+YaSrsbq8u5oP/kbcheLUunvZXB2D51d1F
   laOno1z6ZaPJgHS0lNpdyVeO8wv8kxzhQPlLSEJHurnXR1v1cYPhmkzPG
   CJ+jqZIKJtvTuQl/WII1gHVxqP/sZ4c9MIs8/RbXrbmwwGnZSfYklacH/
   AEy2EgJtVIf46j32gVRkKR4lrjVe4pHfJ3GtxIVMCBs8fwcWMmi8j3Xp8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="389845723"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="389845723"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="854147773"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="854147773"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:54:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r19Ef-0000000Cekh-33M3;
        Thu, 09 Nov 2023 19:54:33 +0200
Date:   Thu, 9 Nov 2023 19:54:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linus.walleij@linaro.org,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, james.clark@arm.com, james@equiv.tech,
        keescook@chromium.org, petr.tesarik.ext@huawei.com,
        rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [RFC PATCH v2 2/7] of: Introduce hardware prober driver
Message-ID: <ZU0c2fuRSoqrpffA@smile.fi.intel.com>
References: <20231109100606.1245545-1-wenst@chromium.org>
 <20231109100606.1245545-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109100606.1245545-3-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:05:59PM +0800, Chen-Yu Tsai wrote:
> Some devices are designed and manufactured with some components having
> multiple drop-in replacement options. These components are often
> connected to the mainboard via ribbon cables, having the same signals
> and pin assignments across all options. These may include the display
> panel and touchscreen on laptops and tablets, and the trackpad on
> laptops. Sometimes which component option is used in a particular device
> can be detected by some firmware provided identifier, other times that
> information is not available, and the kernel has to try to probe each
> device.
> 
> This change attempts to make the "probe each device" case cleaner. The
> current approach is to have all options added and enabled in the device
> tree. The kernel would then bind each device and run each driver's probe
> function. This works, but has been broken before due to the introduction
> of asynchronous probing, causing multiple instances requesting "shared"
> resources, such as pinmuxes, GPIO pins, interrupt lines, at the same
> time, with only one instance succeeding. Work arounds for these include
> moving the pinmux to the parent I2C controller, using GPIO hogs or
> pinmux settings to keep the GPIO pins in some fixed configuration, and
> requesting the interrupt line very late. Such configurations can be seen
> on the MT8183 Krane Chromebook tablets, and the Qualcomm sc8280xp-based
> Lenovo Thinkpad 13S.
> 
> Instead of this delicate dance between drivers and device tree quirks,
> this change introduces a simple I2C component prober. For any given
> class of devices on the same I2C bus, it will go through all of them,
> doing a simple I2C read transfer and see which one of them responds.
> It will then enable the device that responds.
> 
> This requires some minor modifications in the existing device tree.
> The status for all the device nodes for the component options must be
> set to "failed-needs-probe-xxx". This makes it clear that some mechanism
> is needed to enable one of them, and also prevents the prober and device
> drivers running at the same time.

...

> +config HW_PROBER

config OF_HW_PROBER // or anything with explicit OF

Don't give a false impression that this is something that may works without
OF support.

...

> +	bool "Hardware Prober driver"

Ditto.

...

> +/*
> + * hw_prober.c - Hardware prober driver

Do not include filename into the file itself.

> + *
> + * Copyright (c) 2023 Google LLC
> + */

...

> +	node = of_find_node_by_name(NULL, node_name);
> +	if (!node)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Could not find %s device node\n",
> +				     node_name);

With

	struct device *dev = &pdev->dev;

this and other lines can be made neater.

...


For better maintenance it's good to have ret assignment be placed here

	ret = 0;

> +	for_each_child_of_node(i2c_node, node) {
> +		struct property *prop;
> +		union i2c_smbus_data data;
> +		u32 addr;
> +
> +		if (!of_node_name_prefix(node, node_name))
> +			continue;
> +		if (of_property_read_u32(node, "reg", &addr))
> +			continue;
> +		if (i2c_smbus_xfer(i2c, addr, 0, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data) < 0)
> +			continue;
> +
> +		dev_info(&pdev->dev, "Enabling %pOF\n", node);
> +
> +		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +		if (!prop) {
> +			ret = -ENOMEM;
> +			of_node_put(node);
> +			break;
> +		}
> +
> +		prop->name	= "status";
> +		prop->length	= 5;
> +		prop->value	= "okay";
> +
> +		/* Found a device that is responding */
> +		ret = of_update_property(node, prop);
> +		if (ret)
> +			kfree(prop);
> +
> +		of_node_put(node);
> +		break;
> +	}

...

> +static const struct hw_prober_entry hw_prober_platforms[] = {
> +	{ .compatible = "google,hana", .prober = i2c_component_prober, .data = "touchscreen" },
> +	{ .compatible = "google,hana", .prober = i2c_component_prober, .data = "trackpad" },
> +};

Why can't OF ID table be used for this?

...

> +	for (int i = 0; i < ARRAY_SIZE(hw_prober_platforms); i++)

unsigned?

> +		if (of_machine_is_compatible(hw_prober_platforms[i].compatible)) {
> +			int ret;
> +
> +			ret = hw_prober_platforms[i].prober(pdev, hw_prober_platforms[i].data);
> +			if (ret)
> +				return ret;
> +		}

...

> +	pdev = platform_device_register_simple(DRV_NAME, -1, NULL, 0);

-1 is defined in the header, use that definition.

> +	if (!IS_ERR(pdev))
> +		return 0;
> +
> +	platform_driver_unregister(&hw_prober_driver);
> +
> +	return PTR_ERR(pdev);

Can you use standard pattern, i.e. checking for the _error_ condition?

-- 
With Best Regards,
Andy Shevchenko


