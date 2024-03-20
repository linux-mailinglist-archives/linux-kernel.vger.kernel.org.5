Return-Path: <linux-kernel+bounces-109157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B888157A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A463728281B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB2257300;
	Wed, 20 Mar 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="fEWG19CR"
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06554FAD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951663; cv=none; b=UtQI8jCIgElnKkT23w4KPD8jbBUsFTeOYYCUS01kOzUobRTS4/cQzWCDryk4IyP1ac0DxjjmkDJQF9QWzqmBxj6Cwpre9Ot+lSsTCtj5kzhO47PZob43BB8T+ngrKNTqhZ5gK4V1OcAxTwcZEgBC7t98VwY9MB5wJl1yUsMaeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951663; c=relaxed/simple;
	bh=ctS95Q/KqX2J/LUXSQyKH/pl2BP05hlflbuiDxVyUyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m16lC5F6RNJntO5hT83HRTpAdXZRjvfR/dusijSqbWC/gJE59aF1Go/el5SKF2cnI3WJB8otT604P0RnbhnogRjHZZNnBgk9CUVlqFi2JgHPrDSQPGnWCKsMpUEj0AZ5upA+nGNMKaJoFQT3PPLvLZY0gJHXclpVrGbRjh1uLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=fEWG19CR; arc=none smtp.client-ip=62.149.156.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.59] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id mydRrZKfJABX0mydSraZYc; Wed, 20 Mar 2024 17:17:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1710951472; bh=ctS95Q/KqX2J/LUXSQyKH/pl2BP05hlflbuiDxVyUyk=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=fEWG19CRlTCije51eKJeWgbgQkcpKTUa/eJ8vGADiEhNzEoOZtLYDOgN7zM0WSaIn
	 u/lswLkrYKB4QWg468VN3n3kemWYbuPwf7g2rGf9lG+bj2BDroy4of8ZtBe3fT3ivU
	 OiRnOv0BDVXEAmu0jHpxQS2enXXpWvbgyQKMGrx8PLBC+BfRDoJaECWnvMKvUGZMCC
	 p0ob78whtTAr56SEiMsM2gwdGFNQFA4ZlcFFEjqI6BEbWbrcPDJ6bVpg8y1teXeaXD
	 XUAjbzuX9B56/PXuDgzYBsAjjFOJOnXJBKeH/x/hAnT0Izp3DarF+IWvVgv2gpXZIN
	 LGsIZt3XpW8kA==
Message-ID: <27762fd2-123c-4286-904c-7ecaa748e9ff@enneenne.com>
Date: Wed, 20 Mar 2024 17:17:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] pps: generators: Add PPS Generator TIO Driver
Content-Language: en-US
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, jstultz@google.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, peter.hilber@opensynergy.com,
 pandith.n@intel.com, mallikarjunappa.sangannavar@intel.com,
 subramanian.mohan@intel.com, basavaraj.goudar@intel.com,
 thejesh.reddy.t.r@intel.com
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
 <20240319130547.4195-10-lakshmi.sowjanya.d@intel.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20240319130547.4195-10-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBQ3W1huGSm9HfyrIvb/sLpAPYZQlnEzdbAk5JwPRPc3uyz7Crng2g7hyJhJHOgua9I6/cH/vmxv4crNW/YjbciHweksht9+knPA1mxarj7t0NP7visW
 cCisaCmzTT73xYdkBAtXM7Yw8cGhqdgm7aYjSU+Sd61qhtsEQuh5Q7PtF2xvARUfqwr4oihER5csY1brvRZin/MPaEHYnQqbyQxuro4+FbLa7/tLC9xB4uDQ
 n+5q7m1uMpMiXGSAstwWuUizAJfFOlb6dsBVxCBrddE9UJS/7CWIXrN2f0WnQ4WfRWl+QetNxU8ehFAzgRQ8+pNaMIcEVgWugz5yOowt87gTWp0XBoe1nd7/
 sn7VZA56qgydY7Vk388+lYdbCYmBjrFomzGY1E9yuV14x8O/BKrY3bryJzcXwp1tWT7i9yxjR/RhsqDWPJQOrcchjrA6D5+dYRHiupfBrdNwLbFS4iFJ/1HK
 lRRt+5op9RHPTfu+qoX0SXsw4gyLltvW50vpb6Z7a5XUZIodyDsN5AefM2K8QNvBFKfsgG4tFx7NFbs9urmweCG211IjuFtRNl6Hppj76IrSGBi79auFZtEP
 lQaRFidQqTAUozQWyJz34OeXXa0jiaiA/jE7iRM4uc68Tgriuq8dE1DKINYNnHku4tagZYKlUulDGoN+NOvaZVrancmcwJaBQWGTjuSFkSDV0Jhm02KQzT6N
 EXmX22y0wlAEZTpyhDNb+Vp2vQ0a4I8KlYgj4KZXooxhAkR3fHGYfwUuAq7t3PjDFR1ldnkM7FnPcImuGBdXb2b0RZaB9bo13sd6qnIQXvIqXWrV+pT4xXc5
 XUj2aojbyr0VhgorKLKUSH4cr97hh8jjVkEVb7zyBRvRC9YEVY6RXtHwUQ0MwBjCkK32tlItk+Oh+cVO8Wx/tjrEKw5nOm2ajSKTxdpSkYVt/EiFN/UrBuO9
 fC/P9feaLnYjrm3E6Tzy1FNa0nIuhbWb2vjh9eFoV2SWRJ7XFHsfyflrVCD4LawMZ9S19wP+CbmxOTX/zxPbWL02sCShwhjZOdefACmbcF6P2ve6rbMypZHD
 JBrfpvRwyZqxCQQArwIxZqAG4ItlQqeW9/jKn4Z+TED6Ac/EPjrSEHS2v6tTHQL2CVGW9B8Y3BuQIQ==

On 19/03/24 14:05, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> The Intel Timed IO PPS generator driver outputs a PPS signal using
> dedicated hardware that is more accurate than software actuated PPS.
> The Timed IO hardware generates output events using the ART timer.
> The ART timer period varies based on platform type, but is less than 100
> nanoseconds for all current platforms. Timed IO output accuracy is
> within 1 ART period.
> 
> PPS output is enabled by writing '1' the 'enable' sysfs attribute. The
> driver uses hrtimers to schedule a wake-up 10 ms before each event
> (edge) target time. At wakeup, the driver converts the target time in
> terms of CLOCK_REALTIME to ART trigger time and writes this to the Timed
> IO hardware. The Timed IO hardware generates an event precisely at the
> requested system time without software involvement.
> 
> Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> Co-developed-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Co-developed-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
> Signed-off-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Eddie Dong <eddie.dong@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   drivers/pps/generators/Kconfig       |  16 ++
>   drivers/pps/generators/Makefile      |   1 +
>   drivers/pps/generators/pps_gen_tio.c | 245 +++++++++++++++++++++++++++
>   3 files changed, 262 insertions(+)
>   create mode 100644 drivers/pps/generators/pps_gen_tio.c
> 
> diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
> index d615e640fcad..0f090932336f 100644
> --- a/drivers/pps/generators/Kconfig
> +++ b/drivers/pps/generators/Kconfig
> @@ -12,3 +12,19 @@ config PPS_GENERATOR_PARPORT
>   	  If you say yes here you get support for a PPS signal generator which
>   	  utilizes STROBE pin of a parallel port to send PPS signals. It uses
>   	  parport abstraction layer and hrtimers to precisely control the signal.
> +
> +config PPS_GENERATOR_TIO
> +	tristate "TIO PPS signal generator"
> +	depends on X86 && CPU_SUP_INTEL
> +	help
> +	  If you say yes here you get support for a PPS TIO signal generator
> +	  which generates a pulse at a prescribed time based on the system clock.
> +	  It uses time translation and hrtimers to precisely generate a pulse.
> +	  This hardware is present on 2019 and newer Intel CPUs. However, this
> +	  driver is not useful without adding highly specialized hardware outside
> +	  the Linux system to observe these pulses.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pps_gen_tio.
> +
> +	  If unsure, say N.
> diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
> index 2d56dd0495d5..07004cfd3996 100644
> --- a/drivers/pps/generators/Makefile
> +++ b/drivers/pps/generators/Makefile
> @@ -4,6 +4,7 @@
>   #
>   
>   obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
> +obj-$(CONFIG_PPS_GENERATOR_TIO) += pps_gen_tio.o
>   
>   ifeq ($(CONFIG_PPS_DEBUG),y)
>   EXTRA_CFLAGS += -DDEBUG
> diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
> new file mode 100644
> index 000000000000..3ee271524482
> --- /dev/null
> +++ b/drivers/pps/generators/pps_gen_tio.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Intel PPS signal Generator Driver
> + *
> + * Copyright (C) 2023 Intel Corporation
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hrtimer.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/kstrtox.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +#include <linux/timekeeping.h>
> +#include <linux/types.h>
> +
> +#include <asm/cpu_device_id.h>
> +
> +#define TIOCTL			0x00
> +#define TIOCOMPV		0x10
> +
> +/* Control Register */
> +#define TIOCTL_EN			BIT(0)
> +#define TIOCTL_DIR			BIT(1)
> +#define TIOCTL_EP			GENMASK(3, 2)
> +#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
> +#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
> +#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
> +
> +#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC) /* Safety time to set hrtimer early */
> +#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
> +#define ART_HW_DELAY_CYCLES		2
> +
> +struct pps_tio {
> +	struct hrtimer timer;
> +	struct device *dev;
> +	spinlock_t lock;
> +	struct attribute_group attrs;
> +	void __iomem *base;
> +	bool enabled;
> +};
> +
> +static inline u32 pps_ctl_read(struct pps_tio *tio)
> +{
> +	return readl(tio->base + TIOCTL);
> +}
> +
> +static inline void pps_ctl_write(struct pps_tio *tio, u32 value)
> +{
> +	writel(value, tio->base + TIOCTL);
> +}
> +
> +/* For COMPV register, It's safer to write higher 32-bit followed by lower 32-bit */
> +static inline void pps_compv_write(struct pps_tio *tio, u64 value)
> +{
> +	hi_lo_writeq(value, tio->base + TIOCOMPV);
> +}
> +
> +static inline ktime_t first_event(struct pps_tio *tio)
> +{
> +	return ktime_set(ktime_get_real_seconds() + 1, MAGIC_CONST);
> +}
> +
> +static u32 pps_tio_disable(struct pps_tio *tio)
> +{
> +	u32 ctrl;
> +
> +	ctrl = pps_ctl_read(tio);
> +	pps_compv_write(tio, 0);
> +
> +	ctrl &= ~TIOCTL_EN;
> +	pps_ctl_write(tio, ctrl);
> +
> +	return ctrl;
> +}
> +
> +static void pps_tio_direction_output(struct pps_tio *tio)
> +{
> +	u32 ctrl;
> +
> +	ctrl = pps_tio_disable(tio);
> +
> +	/* We enable the device, be sure that the 'compare' value is invalid */
> +	pps_compv_write(tio, 0);
> +
> +	ctrl &= ~(TIOCTL_DIR | TIOCTL_EP);
> +	ctrl |= TIOCTL_EP_TOGGLE_EDGE;
> +	pps_ctl_write(tio, ctrl);
> +
> +	ctrl |= TIOCTL_EN;
> +	pps_ctl_write(tio, ctrl);
> +}
> +
> +static bool pps_generate_next_pulse(struct pps_tio *tio, ktime_t expires)
> +{
> +	u64 art;
> +
> +	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art)) {
> +		pps_tio_disable(tio);
> +		return false;
> +	}
> +
> +	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
> +	return true;
> +}
> +
> +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
> +{
> +	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
> +	ktime_t expires, now;
> +
> +	guard(spinlock)(&tio->lock);
> +
> +	expires = hrtimer_get_expires(timer);
> +	now = ktime_get_real();
> +
> +	if (now - expires < SAFE_TIME_NS) {
> +		if (!pps_generate_next_pulse(tio, expires + SAFE_TIME_NS))
> +			return HRTIMER_NORESTART;
> +	}
> +
> +	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
> +	return HRTIMER_RESTART;
> +}
> +
> +static ssize_t enable_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +			    size_t count)
> +{
> +	struct pps_tio *tio = dev_get_drvdata(dev);
> +	bool enable;
> +	int err;
> +
> +	err = kstrtobool(buf, &enable);
> +	if (err)
> +		return err;
> +
> +	guard(spinlock_irqsave)(&tio->lock);
> +	if (enable && !tio->enabled) {
> +		if (!timekeeping_clocksource_has_base(CSID_X86_ART)) {
> +			dev_err(tio->dev, "PPS cannot be started as clock is not related to ART");
> +			return -EPERM;
> +		}
> +		pps_tio_direction_output(tio);
> +		hrtimer_start(&tio->timer, first_event(tio), HRTIMER_MODE_ABS);
> +		tio->enabled = true;
> +	} else if (!enable && tio->enabled) {
> +		hrtimer_cancel(&tio->timer);
> +		pps_tio_disable(tio);
> +		tio->enabled = false;
> +	}
> +	return count;
> +}
> +
> +static ssize_t enable_show(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct pps_tio *tio = dev_get_drvdata(dev);
> +	u32 ctrl;
> +
> +	ctrl = pps_ctl_read(tio);
> +	ctrl &= TIOCTL_EN;
> +
> +	return sysfs_emit(buf, "%u\n", ctrl);
> +}
> +static DEVICE_ATTR_RW(enable);
> +
> +static struct attribute *pps_tio_attrs[] = {
> +	&dev_attr_enable.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(pps_tio);
> +
> +static int pps_tio_probe(struct platform_device *pdev)
> +{
> +	struct pps_tio *tio;
> +
> +	if (!(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ) &&
> +	      cpu_feature_enabled(X86_FEATURE_ART))) {
> +		dev_warn(&pdev->dev, "TSC/ART is not enabled");
> +		return -ENODEV;
> +	}
> +
> +	tio = devm_kzalloc(&pdev->dev, sizeof(*tio), GFP_KERNEL);
> +	if (!tio)
> +		return -ENOMEM;
> +
> +	tio->dev = &pdev->dev;
> +	tio->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(tio->base))
> +		return PTR_ERR(tio->base);
> +
> +	pps_tio_disable(tio);
> +	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
> +	tio->timer.function = hrtimer_callback;
> +	spin_lock_init(&tio->lock);
> +	tio->enabled = false;
> +	platform_set_drvdata(pdev, tio);
> +
> +	return 0;
> +}
> +
> +static int pps_tio_remove(struct platform_device *pdev)
> +{
> +	struct pps_tio *tio = platform_get_drvdata(pdev);
> +
> +	hrtimer_cancel(&tio->timer);
> +	pps_tio_disable(tio);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
> +	{ "INTC1021" },
> +	{ "INTC1022" },
> +	{ "INTC1023" },
> +	{ "INTC1024" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, intel_pmc_tio_acpi_match);
> +
> +static struct platform_driver pps_tio_driver = {
> +	.probe          = pps_tio_probe,
> +	.remove         = pps_tio_remove,
> +	.driver         = {
> +		.name                   = "intel-pps-generator",
> +		.acpi_match_table       = intel_pmc_tio_acpi_match,
> +		.dev_groups             = pps_tio_groups,
> +	},
> +};
> +module_platform_driver(pps_tio_driver);
> +
> +MODULE_AUTHOR("Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>");
> +MODULE_AUTHOR("Christopher Hall <christopher.s.hall@intel.com>");
> +MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
> +MODULE_AUTHOR("Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>");
> +MODULE_DESCRIPTION("Intel PMC Time-Aware IO Generator Driver");
> +MODULE_LICENSE("GPL");

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


