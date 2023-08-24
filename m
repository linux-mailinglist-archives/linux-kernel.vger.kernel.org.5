Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E377870D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjHXNvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbjHXNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:51:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C368A8;
        Thu, 24 Aug 2023 06:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692885060; x=1724421060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ICzKArowwO6iQ6Ex8zmhTZkL3M8CHqdPy3t/xkN6Fqc=;
  b=MlMCSVB6j1msM1Xgkj1r7WBu36Kp1lGd7pNxOgDWlyen42vBYXY+1zWy
   c+TQcz19yFEa0oF/BV4XH72HjV9gTHD67DoJ87+p4YafomEreqOYyrqH/
   mwcD96qV3kYm2UBVpy0D+X+zltHf90ZMHntPq9CXVNMGl1P/j38lRCMwO
   OyckACs/pM5fby3uV5e38xzjuqd5ameNQJG7x9QjNCwLbUY8NsRE36E0l
   a7oLHsA97sXIcH9pReQXVRmO1o2o5Xs3eVpcVdtPFKPhmYpGxPO+ZmqO6
   4uAp5MY9iXNMqMbGZJQjOLujvtj2+ad64R6J/1BglicdwbLBRyISmjDvE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="438385279"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="438385279"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="772103538"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="772103538"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 24 Aug 2023 06:27:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qZAMT-005GFr-0J;
        Thu, 24 Aug 2023 16:26:57 +0300
Date:   Thu, 24 Aug 2023 16:26:56 +0300
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
Subject: Re: [PATCHv5 2/4] wiegand: add Wiegand bus driver
Message-ID: <ZOdaoE8jLpwGYPFr@smile.fi.intel.com>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824111015.57765-3-m.zatovic1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:10:13PM +0200, Martin Zaťovič wrote:
> The Wiegand protocol serves as a standardized interface protocol, extensively
> employed within electronic access control systems, to facilitate data exchange
> between credentials, readers, and door controllers. Its inception can be
> attributed to the widespread adoption of Wiegand card readers, leveraging the
> Wiegand effect - a physical phenomenon wherein a Wiegand wire (or card)
> generates small yet distinct magnetic fields. A Wiegand reader detects the
> magnetic pulses emitted by the internal wires of the card.
> 
> Three wires are central to the Wiegand protocol: a common ground wire and two
> distinct data wires designated as DATA0 and DATA1. During periods of inactivity,
> both DATA0 and DATA1 lines remain pulled up. For transmitting a '0,' the DATA0
> line is pulled down while DATA1 remains pulled up; conversely, transmitting
> a '1' causes DATA1 to be pulled down while DATA0 remains pulled up. Notably,
> this protocol ensures that the two lines never simultaneously experience a low
> state.
> 
> Timing characteristics within the Wiegand protocol lack a uniform
> standardization, introducing variability between devices. Generally, pulse
> durations hover between 50 to 100 microseconds, while inter-pulse gaps span 20
> to 100 milliseconds. There is no stop bit or similar delimiter to signal the
> conclusion of a message. Instead, the receiver either counts the bits within the
> message or enforces a timeout, often set at around ten times the inter-pulse gap
> duration.
> 
> The 26-Bit Wiegand Interface Standard, or 26-Bit Wiegand Format outlines the
> message format most commonly used among Wiegand devices. This format allocates
> the initial and terminal bits for parity. The subsequent eight bits following
> the initial parity bit are reserved for the Facility Code designed for distinct
> location identification. The remaining bits house the unique ID number. As the
> technology evolved, new Wiegand formats emerged, including 36-bit and 37-bit
> formats. It was also common practice for manufacturers to engineer devices
> compatible with proprietary Wiegand formats tailored to their specifications.
> 
> The Wiegand bus driver handles Wiegand controller and Wiegand device
> managemement and driver matching. The bus driver defines the structures for
> Wiegand controllers and Wiegand devices. Wiegand controller structure contains
> all attributes that define the communication such as the payload_len for
> configuring the size of a single Wiegand message in bits, thus choosing a
> format. Each Wiegand controller should be associated with one Wiegand device,
> as Wiegand is typically a point-to-point bus.

...

> +#include <linux/bitops.h>

Should be bitmap.h

> +#include <linux/cdev.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>

mutex.h ?

> +#include <linux/of_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/wiegand.h>

...

> +static ssize_t wiegand_fwrite(struct file *filp, char __user const *buf, size_t len,
> +				loff_t *offset)
> +{
> +	int ret;
> +	struct wiegand_controller *ctlr = filp->private_data;
> +
> +	mutex_lock(&ctlr->file_lock);
> +
> +	if (!buf || len == 0)

Ouch?!

To avoid this, you can use cleanup.h and guard your functions with a lock,
moreover in this case the check is not even needed to be performed under
the lock.

> +		return -EINVAL;
> +
> +	ret = wiegand_get_user_data(ctlr, buf, len);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctlr->transfer_message(ctlr);
> +
> +	mutex_unlock(&ctlr->file_lock);
> +	return len;
> +}

...

> +static int wiegand_fopen(struct inode *ino, struct file *filp)
> +{
> +	int ret;
> +	struct wiegand_controller *ctlr = container_of(filp->f_op, struct wiegand_controller, fops);
> +
> +	filp->private_data = ctlr;
> +
> +	mutex_lock(&ctlr->file_lock);

Do you care about the call being interrupted by a signal?
Ditto for other system calls in the framework.

> +	if ((filp->f_flags & O_ACCMODE) == O_RDONLY || (filp->f_flags & O_ACCMODE) == O_RDWR) {
> +		dev_err(ctlr->miscdev.this_device, "device is write only\n");
> +		ret = -EIO;
> +		goto out_unlock;
> +	}
> +
> +	mutex_unlock(&ctlr->file_lock);
> +	return 0;
> +
> +out_unlock:
> +	mutex_unlock(&ctlr->file_lock);
> +	return ret;
> +}

...

> +	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());

Yeah, yet another user for a new macro in overflow.h (not yet there, though).

> +	size_t total_size;
> +
> +	if (check_add_overflow(size, ctlr_size, &total_size))
> +		return NULL;
> +
> +	ctlr = kzalloc(total_size, GFP_KERNEL);
> +	if (!ctlr)
> +		return NULL;

...

> +struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev, unsigned int size,
> +							bool secondary)
> +{
> +	struct wiegand_controller *ctlr;
> +
> +	ctlr = wiegand_alloc_controller(dev, size, secondary);
> +	if (ctlr)
> +		ctlr->devm_allocated = true;
> +	else
> +		return NULL;

	if (!ctrl)
		return NULL;

or maybe
		return ERR_PTR(-ENOMEM);


> +	if (devm_add_action_or_reset(dev, wiegand_controller_put, ctlr))
> +		return NULL;

	ret = ...
	if (ret)
		return ERR_PTR(ret);

?

> +
> +	return ctlr;

...

> +/**
> + * register_wiegand_device - allocates and registers a new Wiegand device
> + *
> + * @ctlr: controller structure to attach device to
> + * @node: firmware node for the device

Run

	scripts/kernel-doc -v -none -Wall ...

against this file and fix all warnings.

> + */

> +							struct fwnode_handle *node)

Usually we call it fwnode.

...

> +	device_set_node(&wiegand->dev, node);

	device_set_node(&wiegand->dev, fwnode_handle_get(fwnode));

> +out_node_put:

> +	fwnode_handle_put(node);

Hmm... Shouldn't we do this at the ->release()?

> +	put_device(&wiegand->dev);
> +	wiegand_cleanup(wiegand);
> +	return ERR_PTR(ret);
> +}

...

> +	struct fwnode_handle *node;

fwnode

here and everywhere else.

...

> +	fwnode_for_each_available_child_node(ctlr->dev.fwnode, node) {

	device_for_each_child_node()

> +		wiegand = register_wiegand_device(ctlr, node);
> +		if (IS_ERR(wiegand))
> +			dev_warn(&ctlr->dev, "failed to create wiegand device for %pfwf\n", node);
> +	}

...

> +	struct device *ctlr_dev = &ctlr->dev;

Just name it "dev". You can use similar approach in another functions,
like the above, to make them look nicer.

...

> +	ret = device_property_read_u32(ctlr_dev, "pulse-len-us", &pulse_len);
> +	if (!ret && pulse_len > 0)
> +		timing->pulse_len = pulse_len;
> +	else
> +		timing->pulse_len = WIEGAND_DEFAULT_PULSE_LEN;

What about

	/* Use default if property is absent or can't be read */
	pulse_len = WIEGAND_DEFAULT_PULSE_LEN;
	device_property_read_u32(dev, "pulse-len-us", &pulse_len);
	timing->pulse_len = pulse_len;

Wrong values should be caught up by DT schema linter, no? If the parameters are
0 it's not your problem, although you can warn.

I'm not sure about this, so your current variant is okay.

Ditto for the rest.

...

> +static int __unregister(struct device *dev, void *null)

It is recommended to use namespace even if it's static function.

...

> +void wiegand_unregister_controller(void *ptr)
> +{

Why the parameter is not properly typed?
Yes for devm you probably need a wrapper

static devm_..._unregister_...(void *ctrl)
{
	wiegand_unregister_controller(ctrl)
}


For the exported _unregister, taking into account the possible optional support
for this, you may need to check the parameter to be valid.

	if (IS_ERR_OR_NULL(...)) // _OR_NULL probably is not needed as per above
		return;

> +}

> +	status = misc_register(&ctlr->miscdev);
> +	if (status) {
> +		dev_err(&ctlr->dev, "couldn't register misc device\n");
> +		goto out_free_ida_name;
> +	}

> +	mutex_init(&ctlr->file_lock);

Shouldn't it be needed to be initialized before device itself?

...

> +	status = device_add(&ctlr->dev);
> +	if (status < 0)

Don't we need to call something like device_del() or put_device() at this point?
OK, read doc for device_add() it clarifies this.

> +		goto out_free_ida_name_misc;

...

> +	status = __wiegand_add_device(wiegand);
> +	if (!status) {
> +		ctlr->device_count++;
> +		wiegand->id = wiegand->controller->device_count;
> +	}
> +
> +	return status;

	if (status)
		return status;
	...
	return 0;

...

> +void wiegand_unregister_device(struct wiegand_device *wiegand)
> +{
> +	if (!wiegand)

	IS_ERR_OR_NULL() or alike (see above)

> +		return;
> +
> +	fwnode_handle_put(wiegand->dev.fwnode);

No, do not dereference fwnode in struct device, always use proper API
and/or dev_fwnode() accessor.

> +	device_del(&wiegand->dev);
> +	wiegand_cleanup(wiegand);
> +	put_device(&wiegand->dev);
> +}

...

> +static int wiegand_match_device(struct device *dev, struct device_driver *drv)
> +{
> +	struct wiegand_device *wiegand_dev = to_wiegand_device(dev);
> +
> +	if (of_driver_match_device(dev, drv))
> +		return 1;

I would add ACPI support as well as

	if (acpi_driver_match_device(dev, drv))
		return 1;

> +	return strcmp(wiegand_dev->modalias, drv->name) == 0;
> +}

...

> +static int __init wiegand_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&wiegand_bus_type);
> +	if (ret < 0)
> +		pr_err("Wiegand bus registration failed: %d\n", ret);

pr_fmt() may help to have unified prefix for all messages printed with help of
pr_*() macros.

> +	return ret;
> +}

...

> +#define WIEGAND_MAX_PAYLEN_BYTES 256

I don't see you use BYTES, but rather BITS. Can you define _BITS instead?

...

> +struct wiegand_device;

+ Blank line.

> +/**
> + * struct wiegand_timing - Wiegand timings in microseconds

Perhaps timings ?

> + * @pulse_len: length of the low pulse
> + * @interval_len: length of a whole bit (both the pulse and the high phase)
> + * @frame_gap: length of the last bit of a frame (both the pulse and the high phase)
> + */

...

> +	struct wiegand_timing timing;

Perhaps timings ?

...

> +#endif	/* H_LINUX_INCLUDE_LINUX_WIEGAND_H */

Leading H is something unusual?

-- 
With Best Regards,
Andy Shevchenko


