Return-Path: <linux-kernel+bounces-78369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D289861297
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91831F24AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AF7EEF6;
	Fri, 23 Feb 2024 13:24:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9E5DF00;
	Fri, 23 Feb 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694672; cv=none; b=JZC3g1Pvp+2nfWu48qq21rz+CSSN1fGhIfd2p2QhQ2b8XZAo0ayZzO4E/eP/vDvZsfHVE0vX/WlUrciBH4H3+Ynk20HUD80Ympt3uyLDjVJqigYH/wlMc87ovQ674X96EyjGjktwfY4vkNb/0WnGotwWVHkM1CHyJzhCFlIyxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694672; c=relaxed/simple;
	bh=si7eo+bEoYWeDrIgLTbmkzzgEEjga1X0bDAS71ME2LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExmAt+CLoz7EfMZL/1iAJ5oYfrILgFIVXhE2p4tj8B5FsiVk2TRoOm3yY2KZ6k1iXG1lERJREzWKi4nyQo31piB4leLrtaLtjAERkSieFS23FikAMGz2dupNKR6ChM4HfYAEnm6Gc2GFTmKPjIf//VLe7EB9h2FIpnSX96+TxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61DEF1FB;
	Fri, 23 Feb 2024 05:25:06 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD23E3F73F;
	Fri, 23 Feb 2024 05:24:25 -0800 (PST)
Date: Fri, 23 Feb 2024 13:24:23 +0000
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
Subject: Re: [PATCH 2/5] firmware: arm_scmi: add initial support for i.MX BBM
 protocol
Message-ID: <Zdich_nSNzAVgIJa@pluto>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
 <20240202-imx95-bbm-misc-v1-2-3cb743020933@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-imx95-bbm-misc-v1-2-3cb743020933@nxp.com>

On Fri, Feb 02, 2024 at 02:34:40PM +0800, Peng Fan (OSS) wrote:
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
>  drivers/firmware/arm_scmi/imx-sm-bbm.c | 381 +++++++++++++++++++++++++++++++++
>  include/linux/scmi_nxp_protocol.h      |  50 +++++
>  4 files changed, 442 insertions(+)
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
> index 000000000000..0e12aaeabc42
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/imx-sm-bbm.c
> @@ -0,0 +1,381 @@
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
> +#include <linux/scmi_nxp_protocol.h>
> +
> +#include "protocols.h"
> +#include "notify.h"
> +
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x0

Supported version 0 is a bit awkward...unless you fw returns version 0 too
for this protocol version, it will cause an attempted protocol version
negotitation (which is optionally supported on the fw side) and a splat of
warnings from the Kernel trying to use an older version (0) with a newer
platform version...it will carry-on anyway, just be aware of this.

> +
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
> +#define BBM_PROTO_ATTR_NUM_RTC(x)  (((x) & 0xFFU) << 16U)
> +#define BBM_PROTO_ATTR_NUM_GPR(x)  (((x) & 0xFFFFU) << 0U)

Are these 2 used anywhere ? (use bitfield & GENMASK anyway if needed)

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
> +	(SCMI_IMX_BBM_NOTIFY_RTC_UPDATED | \
> +	 SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER | \
> +	 SCMI_IMX_BBM_NOTIFY_RTC_ALARM)
> +
> +#define SCMI_IMX_BBM_EVENT_RTC_ID(x)        (((x) >> 24) & 0xFF)

bitfield.h ... but more on this down below...

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
> +	struct scmi_msg_imx_bbm_rtc_notify *rtc_notify;
> +	struct scmi_msg_imx_bbm_button_notify *button_notify;

You can move these 2, each one inside its if blocks, right ?

> +
> +	if (message_id == IMX_BBM_RTC_NOTIFY) {
> +		ret = ph->xops->xfer_get_init(ph, message_id, sizeof(*rtc_notify), 0, &t);
> +		if (ret)
> +			return ret;
> +
> +		rtc_notify = t->tx.buf;
> +		rtc_notify->rtc_id = cpu_to_le32(0);
> +		rtc_notify->flags = cpu_to_le32(enable ? SCMI_IMX_BBM_NOTIFY_RTC_FLAG : 0);
> +	} else if (message_id == IMX_BBM_BUTTON_NOTIFY) {
> +		ret = ph->xops->xfer_get_init(ph, message_id, sizeof(*button_notify), 0, &t);
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
> +		r->rtc_id = SCMI_IMX_BBM_EVENT_RTC_ID(le32_to_cpu(p->flags));

mmm... are you sure you want to handle endianity on a bitfield before
extracting the ID ?

looking at SCMI_IMX_BBM_EVENT_RTC_ID above , cannot this just be something like

	le32_get_bits(p->flags, GENMASK(31, 24))

> +		r->rtc_evt = le32_to_cpu(p->flags) & SCMI_IMX_BBM_NOTIFY_RTC_FLAG;

Same here...I dont thing endianity-conversion play on a flag bitfield is
right...dont you just need bit 0,1,2 here to extract ? .... maybe wrong
since I can only guess what all the payoad fields represents...

> +		dev_dbg(ph->dev, "RTC: %d evt: %x\n", r->rtc_id, r->rtc_evt);
> +		*src_id = r->rtc_evt;
> +	} else if (evt_id == SCMI_EVENT_IMX_BBM_BUTTON) {
> +		r->is_rtc = false;
> +		r->is_button = true;
> +		r->timestamp = timestamp;
> +		dev_dbg(ph->dev, "BBM Button\n");
> +		*src_id = 0;
> +	} else {
> +		WARN_ON(1);

..this can be heavy on receveing malformed notif... WARN_ON_ONCE() ?

> +		return NULL;
> +	}
> +
> +	return r;
> +}
> +
> +static int scmi_imx_bbm_get_num_sources(const struct scmi_protocol_handle *ph)
> +{
> +	return 1;
> +}

You can drop this...see down below.

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
> +	.get_num_sources = scmi_imx_bbm_get_num_sources,

if the number of sources is statically defined, you dont need this
helper and just set .num_sources=1 down below...as in
	
	drivers/firmware/arm_scmi/system.c

> +	.set_notify_enabled = scmi_imx_bbm_set_notify_enabled,
> +	.fill_custom_report = scmi_imx_bbm_fill_custom_report,
> +};
> +
> +static const struct scmi_protocol_events scmi_imx_bbm_protocol_events = {
> +	.queue_sz = SCMI_PROTO_QUEUE_SZ,
> +	.ops = &scmi_imx_bbm_event_ops,
> +	.evts = scmi_imx_bbm_events,
> +	.num_events = ARRAY_SIZE(scmi_imx_bbm_events),

num_sources = 1

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
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_BBM_RTC_TIME_SET, sizeof(*cfg), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(rtc_id);
> +	cfg->flags = 0;
> +	cfg->value_low = cpu_to_le32(sec & 0xffffffff);
> +	cfg->value_high = cpu_to_le32(sec >> 32);
> +
lower_32_bits() / upper_32_bits .. it also handles casting

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
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_BBM_RTC_TIME_GET, sizeof(*cfg), sizeof(u64), &t);
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
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_BBM_RTC_ALARM_SET, sizeof(*cfg), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(rtc_id);
> +	cfg->flags = SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG;
> +	cfg->value_low = cpu_to_le32(sec & 0xffffffff);
> +	cfg->value_high = cpu_to_le32(sec >> 32);

lower_32_bits() / upper_32_bits
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_bbm_button_get(const struct scmi_protocol_handle *ph, u32 *state)
> +{
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_BBM_BUTTON_GET, 0, sizeof(u32), &t);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)
> +		*state = get_unaligned_le32(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static const struct scmi_imx_bbm_proto_ops scmi_imx_bbm_proto_ops = {
> +	.rtc_time_get = scmi_imx_bbm_rtc_time_get,
> +	.rtc_time_set = scmi_imx_bbm_rtc_time_set,
> +	.rtc_alarm_set = scmi_imx_bbm_rtc_alarm_set,
> +	.button_get = scmi_imx_bbm_button_get,
> +};
> +
> +static const struct scmi_protocol scmi_imx_bbm = {
> +	.id = SCMI_PROTOCOL_IMX_BBM,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_imx_bbm_protocol_init,
> +	.ops = &scmi_imx_bbm_proto_ops,
> +	.events = &scmi_imx_bbm_protocol_events,
> +	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,

..as said elsewhere you will *probably* need to add here:

	.vendor_id = "NXP_vendor_id"

or whatever is your 16-bytes NULL terminated vendor_id as exposed by
your platform SCMI fw in response the BASE_DISCOVER_VENDOR

and optionally a .sub_vendor_id / impl_ver (up to you)

. *probably* because the mechanism has just been posted and
is under review

> +};
> +
> +module_scmi_protocol(scmi_imx_bbm);
> diff --git a/include/linux/scmi_nxp_protocol.h b/include/linux/scmi_nxp_protocol.h
> new file mode 100644
> index 000000000000..a2077e1ef5d8
> --- /dev/null
> +++ b/include/linux/scmi_nxp_protocol.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SCMI Message Protocol driver NXP extension header
> + *
> + * Copyright 2024 NXP.
> + */
> +
> +#ifndef _LINUX_SCMI_NXP_PROTOCOL_H
> +#define _LINUX_SCMI_NXP_PROTOCOL_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/notifier.h>
> +#include <linux/types.h>
> +
> +enum scmi_nxp_protocol {
> +	SCMI_PROTOCOL_IMX_BBM = 0x81,
> +};
> +
> +struct scmi_imx_bbm_proto_ops {
> +	int (*rtc_time_set)(const struct scmi_protocol_handle *ph, u32 id,
> +			    uint64_t sec);
> +	int (*rtc_time_get)(const struct scmi_protocol_handle *ph, u32 id,
> +			    u64 *val);
> +	int (*rtc_alarm_set)(const struct scmi_protocol_handle *ph, u32 id,
> +			     u64 sec);
> +	int (*button_get)(const struct scmi_protocol_handle *ph, u32 *state);
> +};
> +
> +enum scmi_nxp_notification_events {
> +	SCMI_EVENT_IMX_BBM_RTC = 0x0,
> +	SCMI_EVENT_IMX_BBM_BUTTON = 0x1,
> +	SCMI_EVENT_IMX_MISC_CONTROL_DISABLED = 0x0,
> +	SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE = 0x1,
> +	SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE = 0x2,
> +};
> +
> +#define SCMI_IMX_BBM_RTC_TIME_SET	0x6
> +#define SCMI_IMX_BBM_RTC_TIME_GET	0x7
> +#define SCMI_IMX_BBM_RTC_ALARM_SET	0x8
> +#define SCMI_IMX_BBM_BUTTON_GET		0x9
> +

Why these protocol internal commands are exposed here too ? they are
already defined above in the file containing the protocol implemenation
(rightly so)

> +struct scmi_imx_bbm_notif_report {
> +	bool			is_rtc;
> +	bool			is_button;
> +	ktime_t			timestamp;
> +	unsigned int		rtc_id;
> +	unsigned int		rtc_evt;
> +};
> +#endif
> 


All in all, beside the minor remarks above, LGTM.

Main open thing which remains (on our side) is the handling of vendor
protocol module by the core (as said)...I will chase Sudeep for an
opinion..also about the layout in the source code of all these new
upcoming vendor modules...maybe a common subdir ?

Thank,
Cristian

