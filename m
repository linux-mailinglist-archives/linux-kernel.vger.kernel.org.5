Return-Path: <linux-kernel+bounces-62122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F04851BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166FCB2670B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC73FB3A;
	Mon, 12 Feb 2024 17:39:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB33FB26;
	Mon, 12 Feb 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759567; cv=none; b=PORqMhzdIIV+Xzzq+3GkAwFRLzSedReVGQNGo5+DcT+IyXYpFqAxm14kkM84EgvSnMxDJ0cvUYbpZOsoqoEweHVlWqQcySrt5LUsRy52HLLybHDjrcbGwmcbBqlj7pTVUPuC9eF/42UUI/p3mXuW048/s3hQ2AQ8mzfjr9tH6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759567; c=relaxed/simple;
	bh=gNyvuA4x1YpZI9U3hEL71jPYN+FyvLHU64TaL0tMJ0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klnC5kUBhpR9TvVkMq3jSbmfeQ18EsQrnu3eiM1v/1ehxbb3c2Jrf03C63eRSZ+xGqJj0nz7Iku84CK4x0fwkcwzZ/pysTv59m6etoXbfrUW6R/pkBoeT2Osk1oKLJJkmXhWEXBbUjskQ9B2dFMJGlrVV8R9Y8f5fbI7DErFVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA6CEDA7;
	Mon, 12 Feb 2024 09:40:04 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD3E23F5A1;
	Mon, 12 Feb 2024 09:39:21 -0800 (PST)
Date: Mon, 12 Feb 2024 17:39:19 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, andersson@kernel.org, konrad.dybcio@linaro.org,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Message-ID: <ZcpXx8NkVImwRqX-@pluto>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117173458.2312669-4-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 11:04:54PM +0530, Sibi Sankar wrote:
> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> 
> SCMI QCOM vendor protocol provides interface to communicate with SCMI
> controller and enable vendor specific features like bus scaling capable
> of running on it.
> 

Hi Sibi,

a few comments down below.

> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> Co-developed-by: Amir Vajid <avajid@quicinc.com>
> Signed-off-by: Amir Vajid <avajid@quicinc.com>
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/Kconfig            |  11 ++
>  drivers/firmware/arm_scmi/Makefile           |   1 +
>  drivers/firmware/arm_scmi/qcom_scmi_vendor.c | 160 +++++++++++++++++++
>  include/linux/qcom_scmi_vendor.h             |  36 +++++
>  4 files changed, 208 insertions(+)
>  create mode 100644 drivers/firmware/arm_scmi/qcom_scmi_vendor.c
>  create mode 100644 include/linux/qcom_scmi_vendor.h
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index aa5842be19b2..86b5d6c18ec4 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -180,4 +180,15 @@ config ARM_SCMI_POWER_CONTROL
>  	  called scmi_power_control. Note this may needed early in boot to catch
>  	  early shutdown/reboot SCMI requests.
>  
> +config QCOM_SCMI_VENDOR_PROTOCOL
> +	tristate "Qualcomm Technologies, Inc. Qcom SCMI vendor Protocol"
> +	depends on ARM || ARM64 || COMPILE_TEST
> +	depends on ARM_SCMI_PROTOCOL
> +	help
> +	  The SCMI QCOM vendor protocol provides interface to communicate with SCMI
> +	  controller and enable vendor specific features like bus scaling.
> +
> +	  This driver defines the commands or message ID's used for this
> +	  communication and also exposes the ops used by the clients.
> +
>  endmenu
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index a7bc4796519c..eaeb788b93c6 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
>  
>  obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
> +obj-$(CONFIG_QCOM_SCMI_VENDOR_PROTOCOL) += qcom_scmi_vendor.o
>  

I am starting to think to put vendor protocols in their own dedicated
subdir given that a bunch of those appeared recently :D

...have to discuss with Sudeep...anyway not really an issue...

any thoughts about this ?

>  ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
>  # The use of R7 in the SMCCC conflicts with the compiler's use of R7 as a frame
> diff --git a/drivers/firmware/arm_scmi/qcom_scmi_vendor.c b/drivers/firmware/arm_scmi/qcom_scmi_vendor.c
> new file mode 100644
> index 000000000000..878b99f0d1ef
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/qcom_scmi_vendor.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/qcom_scmi_vendor.h>
> +
> +#include "common.h"
> +
> +#define	EXTENDED_MSG_ID			0
> +#define	SCMI_MAX_TX_RX_SIZE		128
> +#define	PROTOCOL_PAYLOAD_SIZE		16
> +#define	SET_PARAM			0x10
> +#define	GET_PARAM			0x11
> +#define	START_ACTIVITY			0x12
> +#define	STOP_ACTIVITY			0x13
> +
> +static int qcom_scmi_set_param(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
> +			       u32 param_id, size_t size)
> +{
> +	int ret = -EINVAL;
> +	struct scmi_xfer *t;
> +	u32 *msg;
> +
> +	if (!ph || !ph->xops)
> +		return ret;

If you get to call this protocol operation, the protocol itself has to
have been initialized already and registered with the SCMI core, and get
assigned a protocol_handle *ph, so ph and ph->xops are definitely non-NULL
here....if they are please report as a bug :P

> +
> +	ret = ph->xops->xfer_get_init(ph, SET_PARAM, size + PROTOCOL_PAYLOAD_SIZE,
> +				      SCMI_MAX_TX_RX_SIZE, &t);

This parameter, which you set to SCMI_MAX_TX_RX_SIZE, is meant to carry the
max RX payload size for the specific message you are sending, if you known it;
if you do NOT known it you can set this to ZERO and the SCMI core will bump it
to the maximum message size for the currently configured underlying transport
AND check if the reply fits in.

Here it seems that you are trying to somehow set the max RX to the max size you
know the transport can support (which is indeed 128bytes for nmailbox/shmem), but
you dont need to (as explained), it is something that does NOT belong to
the protocol layer in fact (if you meant to use the transport layer max size),
AND you wont be able in any case to override the underlying maximum RX payload
size, since that is the size of the pre-allocated message buffers in the SCMI
xore, and it is enforced by xfer_get_init().

So, in case somehow the underlying transport was or will be configured to be
shorter than you requested here, you will fail the xfer_get_init() in
teh future.

> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);

..just shift as Konrad (I think) was saying...of use FIELD_GET() (probably overkill)

.moreover... if the message PROTOCOL_PAYLOAD that you use is always the
same (surely the same in size) you should just define some sort of:
(just making up names here)

	struct qc_msg {
		__le32 ext_id;
		__le32 algo_low;
		__le32 algo_high;
		__le32 param_id;
		__le32 buf[];
	}

.so that you can easily write the above as:

	msg->ext_id = cpu_to_le32(EXTENDED_MSG_ID);
	...

which is more readable and MOST importantly can be checked by static
analyzer like smatch for consistent usage of endianess macros...(that we
all love...:P)
	
> +	*msg++ = cpu_to_le32(param_id);
> +	memcpy(msg, buf, size);

..mmm...this is correct at the end since you allocate a TX len buffer
of (size + PROTOCOL_PAYLOAD_SIZE) and just move the dst_buf @msg by just
PROTOCOL_PAYLOAD_SIZE before the memcpy, BUT the memcpy @size param
should represent the maximum amount of bytes that fits into the dst_buf,
and here it represent the src_buf size and it WORKS just fine since it
is indeed the amount of space left in msg, BUT ONLY because of how you
allocate the buffer above depending on the define PROTOCOL_PAYLOAD_SIZE...

..seems to me not so much future/error proof in these regards, what
happens if by mistake the msg fields and the define get of sync ?

.what about instead something like (applying also all of the remarks
above):

	struct qc_msg *msg;

	ret = ph->xops->xfer_get_init(ph, SET_PARAM, size + sizeof(*msg), 0 , &t);

	...

	msg = t->tx.buf;
	msg->ext_id = cpu_to_le32(EXTENDED_MSG_ID);
	...
	memcpy(msg->buf, buf, t->tx.len - sizeof(*msg));


..thoughts ?

> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int qcom_scmi_get_param(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
> +			       u32 param_id, size_t tx_size, size_t rx_size)
> +{
> +	int ret = -EINVAL;
> +	struct scmi_xfer *t;
> +	u32 *msg;
> +
> +	if (!ph || !ph->xops || !buf)
> +		return ret;
> +

Ditto. ph and ph->xops checks not needed

> +	ret = ph->xops->xfer_get_init(ph, GET_PARAM, tx_size + PROTOCOL_PAYLOAD_SIZE,
> +				      SCMI_MAX_TX_RX_SIZE, &t);

Shouldn't this be simply:
				     rx_size, &t);

> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
> +	*msg++ = cpu_to_le32(param_id);
> +	memcpy(msg, buf, tx_size);

Ditto. qc_msg + above remarks

> +	ret = ph->xops->do_xfer(ph, t);
> +	if (t->rx.len > rx_size) {

..if you use above rx_size for the desired payload max size, that will be also
used as the t->rx.len by the SCMI core and the configured transport layer to
enforce that the buffer RX payload size is not overflowed....
(see drivers/firmware/arm_scmi/shmem.c as an example)

..well you'll get you buffer silently truncated if it is too big than
expected...to be honest...

..but in any case you wont need this check...maybe here you can just anyway
warn if it is too small than expected (and was truncated)...if you want

> +		pr_err("SCMI received buffer size %zu is more than expected size %zu\n",
> +		       t->rx.len, rx_size);
> +		return -EMSGSIZE;
> +	}
> +	memcpy(buf, t->rx.buf, t->rx.len);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int qcom_scmi_start_activity(const struct scmi_protocol_handle *ph,
> +				    void *buf, u64 algo_str, u32 param_id, size_t size)
> +{
> +	int ret = -EINVAL;
> +	struct scmi_xfer *t;
> +	u32 *msg;
> +
> +	if (!ph || !ph->xops)
> +		return ret;
Ditto.
> +
> +	ret = ph->xops->xfer_get_init(ph, START_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
> +				      SCMI_MAX_TX_RX_SIZE, &t);
Ditto.
> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
> +	*msg++ = cpu_to_le32(param_id);
> +	memcpy(msg, buf, size);
Ditto.
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int qcom_scmi_stop_activity(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
> +				   u32 param_id, size_t size)
> +{
> +	int ret = -EINVAL;
> +	struct scmi_xfer *t;
> +	u32 *msg;
> +
> +	if (!ph || !ph->xops)
> +		return ret;
Ditto.
> +
> +	ret = ph->xops->xfer_get_init(ph, STOP_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
> +				      SCMI_MAX_TX_RX_SIZE, &t);
Ditto.
> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
> +	*msg++ = cpu_to_le32(param_id);
> +	memcpy(msg, buf, size);
Ditto.
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static struct qcom_scmi_vendor_ops qcom_proto_ops = {
> +	.set_param = qcom_scmi_set_param,
> +	.get_param = qcom_scmi_get_param,
> +	.start_activity = qcom_scmi_start_activity,
> +	.stop_activity = qcom_scmi_stop_activity,
> +};
> +
> +static int qcom_scmi_vendor_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	u32 version;
> +
> +	ph->xops->version_get(ph, &version);
> +
> +	dev_info(ph->dev, "qcom scmi version %d.%d\n",
> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	return 0;
> +}
> +
> +static const struct scmi_protocol qcom_scmi_vendor = {
> +	.id = QCOM_SCMI_VENDOR_PROTOCOL,
> +	.owner = THIS_MODULE,
> +	.instance_init = &qcom_scmi_vendor_protocol_init,
> +	.ops = &qcom_proto_ops,
> +};
> +module_scmi_protocol(qcom_scmi_vendor);

As said already, I posted an RFC, which I am gonna cleanup and repost soon
(probably within the week) in order to allow for multiple custom protocols
from multipl distinct Vendors to co-exist within the same 0x80-0xFF
protocols numbers space....in a nutshell you will have to populate here one
or more fields to this struct at compile time so as to be able to identify
this protocol as yours...so that we can then compile all vendors protocols
into defconfig but then, at run-time, load only the ones matching the
effective platform you are running in.

I understand that you now have "your one and only protocol to rule them
all (0x80)" :P...  but this does not mean that other vendors cannot choose
that same number of yours for their own protocols (..I think it is already
happening), so we need a compile/runtime mechanism to properly select...


> +
> +MODULE_DESCRIPTION("QTI SCMI vendor protocol");

As already said, it seems a bit strange to have just one protocol where
you channel all the current and future stuff...this protocol seems related to
_MEMLAT configs at the moment only...

..consider that you can reserve/dedicate a channel to a protocol (if the
underlying transport allows) for performance purposes BUT clearly if you stick
all of your machinery into one single protocol you wont have this capability...

(... and I dont charge for new protocol numbers :P .... joking ah...)

> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/qcom_scmi_vendor.h b/include/linux/qcom_scmi_vendor.h
> new file mode 100644
> index 000000000000..bde57bb18367
> --- /dev/null
> +++ b/include/linux/qcom_scmi_vendor.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * QTI SCMI vendor protocol's header
> + *
> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _QCOM_SCMI_VENDOR_H
> +#define _QCOM_SCMI_VENDOR_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define QCOM_SCMI_VENDOR_PROTOCOL    0x80
> +
> +struct scmi_protocol_handle;
> +extern struct scmi_device *get_qcom_scmi_device(void);

..what is this extern ? I maybe missing something...

> +
> +/**
> + * struct qcom_scmi_vendor_ops - represents the various operations provided
> + *				 by qcom scmi vendor protocol
> + */
> +struct qcom_scmi_vendor_ops {
> +	int (*set_param)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
> +			 u32 param_id, size_t size);
> +	int (*get_param)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
> +			 u32 param_id, size_t tx_size, size_t rx_size);
> +	int (*start_activity)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
> +			      u32 param_id, size_t size);
> +	int (*stop_activity)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
> +			     u32 param_id, size_t size);
> +};
> +


Thanks,
Cristian


