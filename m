Return-Path: <linux-kernel+bounces-133359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6589A2D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80971F22816
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9617165E;
	Fri,  5 Apr 2024 16:44:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96B17164E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335473; cv=none; b=snEl7fG8Yh/B2psACOALcaScreOAPTIgs6he9tcGAsw8ycN0HMAO4FwYoC31Z4/HTqAaASlbRW+wlN4Dp7io7xPzJa5ECdF93BYqJsP3RMDGhXbv0DkiCbVS5OrZrmMADLKvf4t5YDeH7YcQe376r20QSrJ2QH2V1b9V3zZGqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335473; c=relaxed/simple;
	bh=X+tQ+F9zFRo+NeHUeH0ZHKDG+AN3DRCvq73kJ37fjcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJLe7rqtT2CWlnuntwQn3sd2SndK1C3aLoP91RAPL1Wp2owkUrHf2L8LG8bpysKHxAQghUZ6pMpkWM/6bU2aeF1UuPPYFh3DOfGMlRzyAzkm3G++xFqbtCtRwHTVgRN+D9fe9Rk2wyHcw8wVUuQ/mnfRkONtGy/dBpq8b/kiUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rsmfn-0000zo-A0; Fri, 05 Apr 2024 18:44:15 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rsmfm-00AanH-HK; Fri, 05 Apr 2024 18:44:14 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rsmfm-00FjmI-1P;
	Fri, 05 Apr 2024 18:44:14 +0200
Date: Fri, 5 Apr 2024 18:44:14 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Message-ID: <20240405164414.t3fqhnwudxxt2ozv@pengutronix.de>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-4-9fc9186856c2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-4-9fc9186856c2@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Peng,

On 24-04-05, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX MISC protocol is for misc settings, such as gpio expander
> wakeup.

Can you elaborate a bit more please?

Regards,
  Marco


> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/Kconfig       |  10 ++
>  drivers/firmware/arm_scmi/Makefile      |   1 +
>  drivers/firmware/arm_scmi/imx-sm-misc.c | 305 ++++++++++++++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h       |  17 ++
>  4 files changed, 333 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index 56d11c9d9f47..bfeae92f6420 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -191,3 +191,13 @@ config IMX_SCMI_BBM_EXT
>  	  and BUTTON.
>  
>  	  This driver can also be built as a module.
> +
> +config IMX_SCMI_MISC_EXT
> +	tristate "i.MX SCMI MISC EXTENSION"
> +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +	default y if ARCH_MXC
> +	help
> +	  This enables i.MX System MISC control logic such as gpio expander
> +	  wakeup
> +
> +	  This driver can also be built as a module.
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index 327687acf857..a23fde721222 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -12,6 +12,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
>  scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
> +scmi-protocols-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> diff --git a/drivers/firmware/arm_scmi/imx-sm-misc.c b/drivers/firmware/arm_scmi/imx-sm-misc.c
> new file mode 100644
> index 000000000000..1b0ec2281518
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/imx-sm-misc.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System control and Management Interface (SCMI) NXP MISC Protocol
> + *
> + * Copyright 2024 NXP
> + */
> +
> +#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
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
> +enum scmi_imx_misc_protocol_cmd {
> +	SCMI_IMX_MISC_CTRL_SET	= 0x3,
> +	SCMI_IMX_MISC_CTRL_GET	= 0x4,
> +	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
> +};
> +
> +struct scmi_imx_misc_info {
> +	u32 version;
> +	u32 nr_dev_ctrl;
> +	u32 nr_brd_ctrl;
> +	u32 nr_reason;
> +};
> +
> +struct scmi_msg_imx_misc_protocol_attributes {
> +	__le32 attributes;
> +};
> +
> +#define GET_BRD_CTRLS_NR(x)	le32_get_bits((x), GENMASK(31, 24))
> +#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
> +#define GET_DEV_CTRLS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> +#define BRD_CTRL_START_ID	BIT(15)
> +
> +struct scmi_imx_misc_ctrl_set_in {
> +	__le32 id;
> +	__le32 num;
> +	__le32 value[MISC_MAX_VAL];
> +};
> +
> +struct scmi_imx_misc_ctrl_notify_in {
> +	__le32 ctrl_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_misc_ctrl_notify_payld {
> +	__le32 ctrl_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_misc_ctrl_get_out {
> +	__le32 num;
> +	__le32 *val;
> +};
> +
> +static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
> +					struct scmi_imx_misc_info *mi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_imx_misc_protocol_attributes *attr;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
> +				      sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		mi->nr_dev_ctrl = GET_DEV_CTRLS_NR(attr->attributes);
> +		mi->nr_brd_ctrl = GET_BRD_CTRLS_NR(attr->attributes);
> +		mi->nr_reason = GET_REASONS_NR(attr->attributes);
> +		dev_info(ph->dev, "i.MX MISC NUM DEV CTRL: %d, NUM BRD CTRL: %d,NUM Reason: %d\n",
> +			 mi->nr_dev_ctrl, mi->nr_brd_ctrl, mi->nr_reason);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_misc_ctrl_validate_id(const struct scmi_protocol_handle *ph,
> +					  u32 ctrl_id)
> +{
> +	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
> +
> +	if ((ctrl_id < BRD_CTRL_START_ID) && (ctrl_id > mi->nr_dev_ctrl))
> +		return -EINVAL;
> +	if (ctrl_id >= BRD_CTRL_START_ID + mi->nr_brd_ctrl)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int scmi_imx_misc_ctrl_notify(const struct scmi_protocol_handle *ph,
> +				     u32 ctrl_id, u32 flags)
> +{
> +	struct scmi_imx_misc_ctrl_notify_in *in;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
> +				      sizeof(*in), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->ctrl_id = cpu_to_le32(ctrl_id);
> +	in->flags = cpu_to_le32(flags);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int
> +scmi_imx_misc_ctrl_set_notify_enabled(const struct scmi_protocol_handle *ph,
> +				      u8 evt_id, u32 src_id, bool enable)
> +{
> +	int ret;
> +
> +	ret = scmi_imx_misc_ctrl_notify(ph, src_id, enable ? evt_id : 0);
> +	if (ret)
> +		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] - ret:%d\n",
> +			evt_id, src_id, ret);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_misc_ctrl_get_num_sources(const struct scmi_protocol_handle *ph)
> +{
> +	return GENMASK(15, 0);
> +}
> +
> +static void *
> +scmi_imx_misc_ctrl_fill_custom_report(const struct scmi_protocol_handle *ph,
> +				      u8 evt_id, ktime_t timestamp,
> +				      const void *payld, size_t payld_sz,
> +				      void *report, u32 *src_id)
> +{
> +	const struct scmi_imx_misc_ctrl_notify_payld *p = payld;
> +	struct scmi_imx_misc_ctrl_notify_report *r = report;
> +
> +	if (sizeof(*p) != payld_sz)
> +		return NULL;
> +
> +	r->timestamp = timestamp;
> +	r->ctrl_id = p->ctrl_id;
> +	r->flags = p->flags;
> +	*src_id = r->ctrl_id;
> +	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__,
> +		r->ctrl_id, r->flags);
> +
> +	return r;
> +}
> +
> +static const struct scmi_event_ops scmi_imx_misc_event_ops = {
> +	.get_num_sources = scmi_imx_misc_ctrl_get_num_sources,
> +	.set_notify_enabled = scmi_imx_misc_ctrl_set_notify_enabled,
> +	.fill_custom_report = scmi_imx_misc_ctrl_fill_custom_report,
> +};
> +
> +static const struct scmi_event scmi_imx_misc_events[] = {
> +	{
> +		.id = SCMI_EVENT_IMX_MISC_CONTROL_DISABLED,
> +		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
> +	},
> +	{
> +		.id = SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE,
> +		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
> +	},
> +	{
> +		.id = SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE,
> +		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
> +	}
> +};
> +
> +static struct scmi_protocol_events scmi_imx_misc_protocol_events = {
> +	.queue_sz = SCMI_PROTO_QUEUE_SZ,
> +	.ops = &scmi_imx_misc_event_ops,
> +	.evts = scmi_imx_misc_events,
> +	.num_events = ARRAY_SIZE(scmi_imx_misc_events),
> +};
> +
> +static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_misc_info *minfo;
> +	u32 version;
> +	int ret;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	minfo = devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
> +	if (!minfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_imx_misc_attributes_get(ph, minfo);
> +	if (ret)
> +		return ret;
> +
> +	return ph->set_priv(ph, minfo, version);
> +}
> +
> +static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle *ph,
> +				  u32 ctrl_id, u32 *num, u32 *val)
> +{
> +	struct scmi_imx_misc_ctrl_get_out *out;
> +	struct scmi_xfer *t;
> +	int ret, i;
> +
> +	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET, sizeof(u32),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(ctrl_id, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		*num = le32_to_cpu(out->num);
> +		for (i = 0; i < *num && i < MISC_MAX_VAL; i++)
> +			val[i] = le32_to_cpu(out->val[i]);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
> +				  u32 ctrl_id, u32 num, u32 *val)
> +{
> +	struct scmi_imx_misc_ctrl_set_in *in;
> +	struct scmi_xfer *t;
> +	int ret, i;
> +
> +	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> +	if (ret)
> +		return ret;
> +
> +	if (num > MISC_MAX_VAL)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET, sizeof(*in),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->id = cpu_to_le32(ctrl_id);
> +	in->num = cpu_to_le32(num);
> +	for (i = 0; i < num; i++)
> +		in->value[i] = cpu_to_le32(val[i]);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
> +	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
> +	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
> +};
> +
> +static const struct scmi_protocol scmi_imx_misc = {
> +	.id = SCMI_PROTOCOL_IMX_MISC,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_imx_misc_protocol_init,
> +	.ops = &scmi_imx_misc_proto_ops,
> +	.events = &scmi_imx_misc_protocol_events,
> +	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
> +};
> +module_scmi_protocol(scmi_imx_misc);
> diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
> index 90ce011a4429..a69bd4a20f0f 100644
> --- a/include/linux/scmi_imx_protocol.h
> +++ b/include/linux/scmi_imx_protocol.h
> @@ -13,8 +13,14 @@
>  #include <linux/notifier.h>
>  #include <linux/types.h>
>  
> +#define SCMI_PAYLOAD_LEN	100
> +
> +#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
> +#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
> +
>  enum scmi_nxp_protocol {
>  	SCMI_PROTOCOL_IMX_BBM = 0x81,
> +	SCMI_PROTOCOL_IMX_MISC = 0x84,
>  };
>  
>  struct scmi_imx_bbm_proto_ops {
> @@ -42,4 +48,15 @@ struct scmi_imx_bbm_notif_report {
>  	unsigned int		rtc_id;
>  	unsigned int		rtc_evt;
>  };
> +
> +struct scmi_imx_misc_ctrl_notify_report {
> +	ktime_t			timestamp;
> +	unsigned int		ctrl_id;
> +	unsigned int		flags;
> +};
> +
> +struct scmi_imx_misc_proto_ops {
> +	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id, u32 num, u32 *val);
> +	int (*misc_ctrl_get)(const struct scmi_protocol_handle *ph, u32 id, u32 *num, u32 *val);
> +};
>  #endif
> 
> -- 
> 2.37.1
> 
> 
> 

