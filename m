Return-Path: <linux-kernel+bounces-135797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396989CB6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09681F21A75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD814430A;
	Mon,  8 Apr 2024 18:04:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C1433A9;
	Mon,  8 Apr 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599491; cv=none; b=Mwddmp7Mo3LVXd1SfdX2kHDNobZf1QOwKQW/89ZDgeCGOoKRvtFm/j3Iuc0m1PfTKE0Xpo09dPoB5EV8P9rXypIwu+FEXFkko0hxcrBeFBiwINwKWE1z5nc8WDRQyBmReFPtfU+pLyamDUE+sc6sDp1GGMWjvmKb2Forti538XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599491; c=relaxed/simple;
	bh=6uHGx2M8BxAChT3hSfv+NWMZqGpz02N7CpM88H7uXlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5f8gYMYMLf4EE+RU8ikoAoYBeN7yTOKRKaqy74zOzMCYtQ6H9+zbz+WaZDrhvgQEIYo3IKkbktMJ0cItlJn0cEUFRLcby0Rw7AeC0WztNZaVeLcHkMXQgKoBWV2W1enRl1Ss2AiuvGtJZl38tgScpCvYe9jNfmPgO4DdUncNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AEA2DA7;
	Mon,  8 Apr 2024 11:05:18 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B26113F766;
	Mon,  8 Apr 2024 11:04:45 -0700 (PDT)
Date: Mon, 8 Apr 2024 19:04:43 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Message-ID: <ZhQxu8LVNKf5QDLm@pluto>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>

On Fri, Apr 05, 2024 at 08:39:25PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX BBM protocol is for managing i.MX BBM module which provides
> RTC and BUTTON feature.
> 

Hi,

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/Kconfig      |  10 +
>  drivers/firmware/arm_scmi/Makefile     |   1 +
>  drivers/firmware/arm_scmi/imx-sm-bbm.c | 378 +++++++++++++++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h      |  45 ++++
>  4 files changed, 434 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index aa5842be19b2..56d11c9d9f47 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -181,3 +181,13 @@ config ARM_SCMI_POWER_CONTROL
>  	  early shutdown/reboot SCMI requests.
>  
>  endmenu
> +
> +config IMX_SCMI_BBM_EXT
> +	tristate "i.MX SCMI BBM EXTENSION"
> +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +	default y if ARCH_MXC
> +	help
> +	  This enables i.MX System BBM control logic which supports RTC
> +	  and BUTTON.
> +
> +	  This driver can also be built as a module.
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index a7bc4796519c..327687acf857 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> +scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> diff --git a/drivers/firmware/arm_scmi/imx-sm-bbm.c b/drivers/firmware/arm_scmi/imx-sm-bbm.c
> new file mode 100644
> index 000000000000..92c0aedf65cc
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/imx-sm-bbm.c
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) NXP BBM Protocol
> + *
> + * Copyright 2024 NXP
> + */
> +
> +#define pr_fmt(fmt) "SCMI Notifications BBM - " fmt
> +
> +#include <linux/bits.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/scmi_imx_protocol.h>
> +
> +#include "protocols.h"
> +#include "notify.h"
> +
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> +

I appreciate that you added versioning but I think a bit of documentation
about what the protocol and its comamnds purpose is still lacking, as asked
by Sudeep previously

	https://lore.kernel.org/linux-arm-kernel/ZeGtoJ7ztSe8Kg8R@bogus/#t

> +enum scmi_imx_bbm_protocol_cmd {
> +	IMX_BBM_GPR_SET = 0x3,
> +	IMX_BBM_GPR_GET = 0x4,
> +	IMX_BBM_RTC_ATTRIBUTES = 0x5,
> +	IMX_BBM_RTC_TIME_SET = 0x6,
> +	IMX_BBM_RTC_TIME_GET = 0x7,
> +	IMX_BBM_RTC_ALARM_SET = 0x8,
> +	IMX_BBM_BUTTON_GET = 0x9,
> +	IMX_BBM_RTC_NOTIFY = 0xA,
> +	IMX_BBM_BUTTON_NOTIFY = 0xB,
> +};
> +
> +#define GET_RTCS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
> +#define GET_GPRS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> +
> +#define SCMI_IMX_BBM_NOTIFY_RTC_UPDATED		BIT(2)
> +#define SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER	BIT(1)
> +#define SCMI_IMX_BBM_NOTIFY_RTC_ALARM		BIT(0)
> +
> +#define SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG	BIT(0)
> +
> +#define SCMI_IMX_BBM_NOTIFY_RTC_FLAG	\
> +	(SCMI_IMX_BBM_NOTIFY_RTC_UPDATED | SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER | \
> +	 SCMI_IMX_BBM_NOTIFY_RTC_ALARM)
> +
> +#define SCMI_IMX_BBM_EVENT_RTC_MASK		GENMASK(31, 24)
> +
> +struct scmi_imx_bbm_info {
> +	u32 version;
> +	int nr_rtc;
> +	int nr_gpr;
> +};
> +
> +struct scmi_msg_imx_bbm_protocol_attributes {
> +	__le32 attributes;
> +};
> +
> +struct scmi_imx_bbm_set_time {
> +	__le32 id;
> +	__le32 flags;
> +	__le32 value_low;
> +	__le32 value_high;
> +};
> +
> +struct scmi_imx_bbm_get_time {
> +	__le32 id;
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_bbm_alarm_time {
> +	__le32 id;
> +	__le32 flags;
> +	__le32 value_low;
> +	__le32 value_high;
> +};
> +
> +struct scmi_msg_imx_bbm_rtc_notify {
> +	__le32 rtc_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_msg_imx_bbm_button_notify {
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_bbm_notify_payld {
> +	__le32 flags;
> +};
> +
> +static int scmi_imx_bbm_attributes_get(const struct scmi_protocol_handle *ph,
> +				       struct scmi_imx_bbm_info *pi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_imx_bbm_protocol_attributes *attr;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		pi->nr_rtc = GET_RTCS_NR(attr->attributes);
> +		pi->nr_gpr = GET_GPRS_NR(attr->attributes);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_bbm_notify(const struct scmi_protocol_handle *ph,
> +			       u32 src_id, int message_id, bool enable)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +
> +	if (message_id == IMX_BBM_RTC_NOTIFY) {
> +		struct scmi_msg_imx_bbm_rtc_notify *rtc_notify;
> +
> +		ret = ph->xops->xfer_get_init(ph, message_id,
> +					      sizeof(*rtc_notify), 0, &t);
> +		if (ret)
> +			return ret;
> +
> +		rtc_notify = t->tx.buf;
> +		rtc_notify->rtc_id = cpu_to_le32(0);
> +		rtc_notify->flags =
> +			cpu_to_le32(enable ? SCMI_IMX_BBM_NOTIFY_RTC_FLAG : 0);
> +	} else if (message_id == IMX_BBM_BUTTON_NOTIFY) {
> +		struct scmi_msg_imx_bbm_button_notify *button_notify;
> +
> +		ret = ph->xops->xfer_get_init(ph, message_id,
> +					      sizeof(*button_notify), 0, &t);
> +		if (ret)
> +			return ret;
> +
> +		button_notify = t->tx.buf;
> +		button_notify->flags = cpu_to_le32(enable ? 1 : 0);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static enum scmi_imx_bbm_protocol_cmd evt_2_cmd[] = {
> +	IMX_BBM_RTC_NOTIFY,
> +	IMX_BBM_BUTTON_NOTIFY
> +};
> +
> +static int scmi_imx_bbm_set_notify_enabled(const struct scmi_protocol_handle *ph,
> +					   u8 evt_id, u32 src_id, bool enable)
> +{
> +	int ret, cmd_id;
> +
> +	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
> +		return -EINVAL;
> +
> +	cmd_id = evt_2_cmd[evt_id];
> +	ret = scmi_imx_bbm_notify(ph, src_id, cmd_id, enable);
> +	if (ret)
> +		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
> +			 evt_id, src_id, ret);
> +
> +	return ret;
> +}
> +
> +static void *scmi_imx_bbm_fill_custom_report(const struct scmi_protocol_handle *ph,
> +					     u8 evt_id, ktime_t timestamp,
> +					     const void *payld, size_t payld_sz,
> +					     void *report, u32 *src_id)
> +{
> +	const struct scmi_imx_bbm_notify_payld *p = payld;
> +	struct scmi_imx_bbm_notif_report *r = report;
> +
> +	if (sizeof(*p) != payld_sz)
> +		return NULL;
> +
> +	if (evt_id == SCMI_EVENT_IMX_BBM_RTC) {
> +		r->is_rtc = true;
> +		r->is_button = false;
> +		r->timestamp = timestamp;
> +		r->rtc_id = le32_get_bits(p->flags, SCMI_IMX_BBM_EVENT_RTC_MASK);
> +		r->rtc_evt = le32_get_bits(p->flags, SCMI_IMX_BBM_NOTIFY_RTC_FLAG);
> +		dev_dbg(ph->dev, "RTC: %d evt: %x\n", r->rtc_id, r->rtc_evt);
> +		*src_id = r->rtc_evt;
> +	} else if (evt_id == SCMI_EVENT_IMX_BBM_BUTTON) {
> +		r->is_rtc = false;
> +		r->is_button = true;
> +		r->timestamp = timestamp;
> +		dev_dbg(ph->dev, "BBM Button\n");
> +		*src_id = 0;
> +	} else {
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
> +
> +	return r;
> +}
> +
> +static const struct scmi_event scmi_imx_bbm_events[] = {
> +	{
> +		.id = SCMI_EVENT_IMX_BBM_RTC,
> +		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
> +	},
> +	{
> +		.id = SCMI_EVENT_IMX_BBM_BUTTON,
> +		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
> +	},
> +};
> +
> +static const struct scmi_event_ops scmi_imx_bbm_event_ops = {
> +	.set_notify_enabled = scmi_imx_bbm_set_notify_enabled,
> +	.fill_custom_report = scmi_imx_bbm_fill_custom_report,
> +};
> +
> +static const struct scmi_protocol_events scmi_imx_bbm_protocol_events = {
> +	.queue_sz = SCMI_PROTO_QUEUE_SZ,
> +	.ops = &scmi_imx_bbm_event_ops,
> +	.evts = scmi_imx_bbm_events,
> +	.num_events = ARRAY_SIZE(scmi_imx_bbm_events),
> +	.num_sources = 1,
> +};
> +
> +static int scmi_imx_bbm_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	u32 version;
> +	int ret;
> +	struct scmi_imx_bbm_info *binfo;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(ph->dev, "NXP SM BBM Version %d.%d\n",
> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	binfo = devm_kzalloc(ph->dev, sizeof(*binfo), GFP_KERNEL);
> +	if (!binfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_imx_bbm_attributes_get(ph, binfo);
> +	if (ret)
> +		return ret;
> +
> +	return ph->set_priv(ph, binfo, version);
> +}
> +
> +static int scmi_imx_bbm_rtc_time_set(const struct scmi_protocol_handle *ph,
> +				     u32 rtc_id, u64 sec)
> +{
> +	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
> +	struct scmi_imx_bbm_set_time *cfg;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	if (rtc_id >= pi->nr_rtc)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_SET, sizeof(*cfg), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(rtc_id);
> +	cfg->flags = 0;
> +	cfg->value_low = lower_32_bits(sec);
> +	cfg->value_high = upper_32_bits(sec);

Sorry I may have not been clear on this, but when I mentioned lower/upper
helpers I did not mean that they solved ALSO the endianity problem, so I
suppose that after having chunked your 64bits value in 2, you still want
to transmit it as 2 LE quantity....this is generally the expectation for
SCMI payloads...in this case any available documentation about the
expected command layout would have helped...

> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_bbm_rtc_time_get(const struct scmi_protocol_handle *ph,
> +				     u32 rtc_id, u64 *value)
> +{
> +	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
> +	struct scmi_imx_bbm_get_time *cfg;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	if (rtc_id >= pi->nr_rtc)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_GET, sizeof(*cfg),
> +				      sizeof(u64), &t);
> +	if (ret)
> +		return ret;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(rtc_id);
> +	cfg->flags = 0;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)
> +		*value = get_unaligned_le64(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_bbm_rtc_alarm_set(const struct scmi_protocol_handle *ph,
> +				      u32 rtc_id, u64 sec)
> +{
> +	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
> +	struct scmi_imx_bbm_alarm_time *cfg;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	if (rtc_id >= pi->nr_rtc)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_ALARM_SET, sizeof(*cfg), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(rtc_id);
> +	cfg->flags = SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG;
> +	cfg->value_low = lower_32_bits(sec);
> +	cfg->value_high = upper_32_bits(sec);

Same.

Thanks,
Cristian

