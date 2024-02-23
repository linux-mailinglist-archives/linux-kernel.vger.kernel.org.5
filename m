Return-Path: <linux-kernel+bounces-78951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C966D861B46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D9C28A48C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F71420B8;
	Fri, 23 Feb 2024 18:13:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439812BE98;
	Fri, 23 Feb 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712019; cv=none; b=ujD/u03V9c2su11us3fci0B6djdpvxVYtOS997GTvUyPiNuO2pgGkEUt2I9NmZvipdAQrF2nr0xPyoQbj+jYoE1cq7l48ANKUk+/as7zLaY583hpuGHT5FJmDV8r6o/uyeB467PjjSV8uT6orx1FKvJurFCNAUp1ShoQpxnUUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712019; c=relaxed/simple;
	bh=LRvxdbFPyk56EUXVPOQLaEdClFPIz+8h5gG+ZcQB0JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuK5wZXwwt0YpTcEGieAAh8eJFUNB4agshnc3s7Th4ZIUHI1uWrlqOv+/UpI2xpeaTEiCn1oCYm2or9MRacfZh9/shV13l1PatzaaafNPoA7T0Ea7T/DTYCZFNMqNfBx2aojVA4acnRaq2GBxSk2wq3t/MEjcuRpzZ1G7bQIUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C86DA7;
	Fri, 23 Feb 2024 10:14:14 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64C833F762;
	Fri, 23 Feb 2024 10:13:33 -0800 (PST)
Date: Fri, 23 Feb 2024 18:13:31 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/5] firmware: imx: support BBM module
Message-ID: <ZdjgSxFx9YRP107y@pluto>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
 <20240202-imx95-bbm-misc-v1-4-3cb743020933@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-imx95-bbm-misc-v1-4-3cb743020933@nxp.com>

On Fri, Feb 02, 2024 at 02:34:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The BBM module provides RTC and BUTTON feature. To i.MX95, this module
> is managed by System Manager. Linux could use i.MX SCMI BBM Extension
> protocol to use RTC and BUTTON feature.
> 
> This driver is to use SCMI interface to get/set RTC, enable pwrkey.

Hi,

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/Makefile |   1 +
>  drivers/firmware/imx/sm-bbm.c | 317 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 318 insertions(+)
> 
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8f9f04a513a8..fb20e22074e1 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
> +obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o

So you have not added a Kconfig for this but you just rely on the SCMI NXP BBM
Vendor module to be configured....this causes the kernel-bot build failure because
I suppose that the RTC subsystem is not compiled in since its dependency is not
stated anywhere...

you could/should add a Kconfig here for this driver with a select on
CONFIG_IMX_SCMI_BBM_EXT and the RTC subsystem and put the

	default y if ARCH_MXC

instead of placing that on CONFIG_IMX_SCMI_BBM_EXT

> diff --git a/drivers/firmware/imx/sm-bbm.c b/drivers/firmware/imx/sm-bbm.c
> new file mode 100644
> index 000000000000..c5bc571881c7
> --- /dev/null
> +++ b/drivers/firmware/imx/sm-bbm.c
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/scmi_nxp_protocol.h>
> +#include <linux/suspend.h>
> +
> +#define DEBOUNCE_TIME		30
> +#define REPEAT_INTERVAL		60
> +
> +struct scmi_imx_bbm {
> +	struct rtc_device *rtc_dev;
> +	struct scmi_protocol_handle *ph;
> +	const struct scmi_imx_bbm_proto_ops *ops;
> +	struct notifier_block nb;
> +	int keycode;
> +	int keystate;  /* 1:pressed */
> +	bool suspended;
> +	struct delayed_work check_work;
> +	struct input_dev *input;
> +};
> +
> +static int scmi_imx_bbm_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	struct scmi_protocol_handle *ph = bbnsm->ph;
> +	u64 val;
> +	int ret;
> +
> +	ret = bbnsm->ops->rtc_time_get(ph, 0, &val);
> +	if (ret)
> +		dev_err(dev, "%s: %d\n", __func__, ret);
> +
> +	rtc_time64_to_tm(val, tm);

You convert to tm and return success anyway on SCMI get error ?

> +
> +	return 0;
> +}
> +
> +static int scmi_imx_bbm_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	struct scmi_protocol_handle *ph = bbnsm->ph;
> +	u64 val;
> +	int ret;
> +
> +	val = rtc_tm_to_time64(tm);
> +
> +	ret = bbnsm->ops->rtc_time_set(ph, 0, val);
> +	if (ret)
> +		dev_err(dev, "%s: %d\n", __func__, ret);
> +

Return Success on error to set ?

> +	return 0;
> +}
> +
> +static int scmi_imx_bbm_alarm_irq_enable(struct device *dev, unsigned int enable)
> +{
> +	return 0;
> +}
> +
> +static int scmi_imx_bbm_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	struct scmi_protocol_handle *ph = bbnsm->ph;
> +	struct rtc_time *alrm_tm = &alrm->time;
> +	u64 val;
> +	int ret;
> +
> +	val = rtc_tm_to_time64(alrm_tm);
> +
> +	ret = bbnsm->ops->rtc_alarm_set(ph, 0, val);
> +	if (ret)
> +		dev_err(dev, "%s: %d\n", __func__, ret);
> +

Same pattern error--> success...I suppose is fine at this point but maybe
explain why in a comment....

> +	return 0;
> +}
> +
> +static const struct rtc_class_ops smci_imx_bbm_rtc_ops = {
> +	.read_time = scmi_imx_bbm_read_time,
> +	.set_time = scmi_imx_bbm_set_time,
> +	.set_alarm = scmi_imx_bbm_set_alarm,
> +	.alarm_irq_enable = scmi_imx_bbm_alarm_irq_enable,
> +};
> +
> +static void scmi_imx_bbm_pwrkey_check_for_events(struct work_struct *work)
> +{
> +	struct scmi_imx_bbm *bbnsm = container_of(work, struct scmi_imx_bbm, check_work.work);

there is a to_delayed_work() in workqueue.h to get the delayed work from
work and then in turn get to bbnsm...just to avoid relying on
delayed_work internal naming...

> +	struct scmi_protocol_handle *ph = bbnsm->ph;
> +	struct input_dev *input = bbnsm->input;
> +	u32 state = 0;
> +	int ret;
> +
> +	ret = bbnsm->ops->button_get(ph, &state);
> +	if (ret) {
> +		pr_err("%s: %d\n", __func__, ret);
> +		return;
> +	}
> +
> +	pr_debug("%s: state: %d, keystate %d\n", __func__, state, bbnsm->keystate);
> +
> +	/* only report new event if status changed */
> +	if (state ^ bbnsm->keystate) {
> +		bbnsm->keystate = state;
> +		input_event(input, EV_KEY, bbnsm->keycode, state);
> +		input_sync(input);
> +		pm_relax(bbnsm->input->dev.parent);
> +		pr_debug("EV_KEY: %x\n", bbnsm->keycode);
> +	}
> +
> +	/* repeat check if pressed long */
> +	if (state)
> +		schedule_delayed_work(&bbnsm->check_work, msecs_to_jiffies(REPEAT_INTERVAL));
> +}
> +
> +static int scmi_imx_bbm_pwrkey_event(struct scmi_imx_bbm *bbnsm)
> +{
> +	struct input_dev *input = bbnsm->input;
> +
> +	schedule_delayed_work(&bbnsm->check_work, msecs_to_jiffies(DEBOUNCE_TIME));
> +
> +	/*
> +	 * Directly report key event after resume to make no key press
> +	 * event is missed.
> +	 */
> +	if (bbnsm->suspended) {

So this bbnsm->suspended is checked here from inside the SCMI notifier and it
is set by a couple of pm_ops you provide down below which are called by
the core PM subsys, so is it not high likely that you could have issues with the
order of such reads/writes ? 

Would it be worth to add a READ_ONCE here and WRITE_ONCE in the
pm_ops...or I am overthinking ?

> +		bbnsm->keystate = 1;
> +		input_event(input, EV_KEY, bbnsm->keycode, 1);
> +		input_sync(input);
> +	}
> +
> +	return 0;
> +}
> +
> +static void scmi_imx_bbm_pwrkey_act(void *pdata)
> +{
> +	struct scmi_imx_bbm *bbnsm = pdata;
> +
> +	cancel_delayed_work_sync(&bbnsm->check_work);
> +}
> +
> +static int scmi_imx_bbm_notifier(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	struct scmi_imx_bbm *bbnsm = container_of(nb, struct scmi_imx_bbm, nb);
> +	struct scmi_imx_bbm_notif_report *r = data;
> +
> +	if (r->is_rtc)
> +		rtc_update_irq(bbnsm->rtc_dev, 1, RTC_AF | RTC_IRQF);
> +	if (r->is_button) {
> +		pr_debug("BBM Button Power key pressed\n");
> +		scmi_imx_bbm_pwrkey_event(bbnsm);
> +	}
> +
> +	return 0;
> +}
> +
> +static int scmi_imx_bbm_pwrkey_init(struct scmi_device *sdev)
> +{
> +	const struct scmi_handle *handle = sdev->handle;
> +	struct device *dev = &sdev->dev;
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	struct input_dev *input;
> +	int ret;
> +
> +	if (device_property_read_u32(dev, "linux,code", &bbnsm->keycode)) {
> +		bbnsm->keycode = KEY_POWER;
> +		dev_warn(dev, "key code is not specified, using default KEY_POWER\n");
> +	}
> +
> +	INIT_DELAYED_WORK(&bbnsm->check_work, scmi_imx_bbm_pwrkey_check_for_events);
> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input) {
> +		dev_err(dev, "failed to allocate the input device for SCMI IMX BBM\n");
> +		return -ENOMEM;
> +	}
> +
> +	input->name = dev_name(dev);
> +	input->phys = "bbnsm-pwrkey/input0";
> +	input->id.bustype = BUS_HOST;
> +
> +	input_set_capability(input, EV_KEY, bbnsm->keycode);
> +
> +	ret = devm_add_action_or_reset(dev, scmi_imx_bbm_pwrkey_act, bbnsm);
> +	if (ret) {
> +		dev_err(dev, "failed to register remove action\n");
> +		return ret;
> +	}
> +
> +	bbnsm->input = input;
> +
> +	ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
> +							       SCMI_EVENT_IMX_BBM_BUTTON,
> +							       NULL, &bbnsm->nb);

So you are registering for another SCMI event but you want to use the
same callback and notifier_bock to handle different events, BUT internally
the SCMI core creates a DISTINCT kernel regular notification chain for each event
and each resource (or one for ALL resources of an event) against which a
devm_event_notifier_register() has been called AND so, being a notification_chain
the notifier_blocks that you provide MUST be distinct, because the notification
chain is indeed a simply-linked list and so when you register bbnsm->nb the second
time you will indeed add the nb to another list at the same....

..thing which I suppose could work in your case since you have only nb/callback
per event BUT as soon as you (or someone else) will try to register another nb 
for these same events the 2 notification chains will start melting together....

..and it will be a hell to debug...

so IOW...even if it works now for you, please use 2 distinct nb_pwr. nb_rtc
notifier blocks with 2 distinct callbacks (to be able to use container_of in
them) to register to 2 distinct events...you can register for multiple sources
using only one nb BUT you cannot register for multiple events using the same
nb/callback as of now.

With this internal design the queues and the worker threads dispatching these
notifs are dedicated to a single event and possible to a single event/resource...
..no event ever queues behind any other...

This probably would need better clarification in the SCMI docs, my bad, and
maybe a new option to register for ANY event the same nb (like you can do with
src_id if you dont specify one), IF you are fine with the possibility that your
events notification will be serialized in a single queue.

> +
> +	if (ret)
> +		dev_err(dev, "Failed to register BBM Button Events %d:", ret);
> +

So why not failing if you could NOT register the notifications ?

> +	ret = input_register_device(input);
> +	if (ret) {
> +		dev_err(dev, "failed to register input device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int scmi_imx_bbm_rtc_init(struct scmi_device *sdev)
> +{
> +	const struct scmi_handle *handle = sdev->handle;
> +	struct device *dev = &sdev->dev;
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	int ret;
> +
> +	bbnsm->rtc_dev = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(bbnsm->rtc_dev))
> +		return PTR_ERR(bbnsm->rtc_dev);
> +
> +	bbnsm->rtc_dev->ops = &smci_imx_bbm_rtc_ops;
> +	bbnsm->rtc_dev->range_min = 0;
> +	bbnsm->rtc_dev->range_max = U32_MAX;
> +
> +	ret = devm_rtc_register_device(bbnsm->rtc_dev);
> +	if (ret)
> +		return ret;
> +
> +	bbnsm->nb.notifier_call = &scmi_imx_bbm_notifier;
> +	return handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
> +								SCMI_EVENT_IMX_BBM_RTC,
> +								NULL, &bbnsm->nb);

As said, this will get mixed up when pwrkey_init tries to register again the same nb
for a different event...

> +}
> +
> +static int scmi_imx_bbm_probe(struct scmi_device *sdev)
> +{
> +	const struct scmi_handle *handle = sdev->handle;
> +	struct device *dev = &sdev->dev;
> +	struct scmi_protocol_handle *ph;
> +	struct scmi_imx_bbm *bbnsm;
> +	int ret;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	bbnsm = devm_kzalloc(dev, sizeof(struct scmi_imx_bbm), GFP_KERNEL);

sizeof(*bbnsm)

> +	if (!bbnsm)
> +		return -ENOMEM;
> +
> +	bbnsm->ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_BBM, &ph);

proto ops can be global really..since are always the same pointer even
if this is probed mutiple times... this could be

	bbnsm_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_BBM, &bbnsm->ph);

with bbnsm_ops static global to this file

> +	if (IS_ERR(bbnsm->ops))
> +		return PTR_ERR(bbnsm->ops);
> +
> +	bbnsm->ph = ph;
> +
> +	device_init_wakeup(dev, true);

Not fully familiar with this, but it seems to me that when this is
issued some wakeup related sysfs entries are created too...so I suppose
you want to disable this back on failure to have those entries removed.

or maybe just move this right before the final return 0....but I am not
sure if you want to have it called BEFORE the pwrkey notifier if
registered or AFTER is fine too...potentially loosing some wakeup, though.

> +
> +	dev_set_drvdata(dev, bbnsm);
> +
> +	ret = scmi_imx_bbm_rtc_init(sdev);
> +	if (ret) {
> +		dev_err(dev, "rtc init failed: %d\n", ret);

like ??
		device_init_wakeup(dev, false);

> +		return ret;
> +	}
> +
> +	ret = scmi_imx_bbm_pwrkey_init(sdev);
> +	if (ret) {
> +		dev_err(dev, "pwr init failed: %d\n", ret);
and... 
		device_init_wakeup(dev, false);

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused scmi_imx_bbm_suspend(struct device *dev)
> +{
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +
> +	bbnsm->suspended = true;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused scmi_imx_bbm_resume(struct device *dev)
> +{
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +
> +	bbnsm->suspended = false;
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_ops, scmi_imx_bbm_suspend, scmi_imx_bbm_resume);
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_IMX_BBM, "imx-bbm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static struct scmi_driver scmi_imx_bbm_driver = {
> +	.driver = {
> +		.pm = &scmi_imx_bbm_pm_ops,
> +	},
> +	.name = "scmi-imx-bbm",
> +	.probe = scmi_imx_bbm_probe,
> +	.id_table = scmi_id_table,
> +};
> +module_scmi_driver(scmi_imx_bbm_driver);
> +

Thanks,
Cristian

