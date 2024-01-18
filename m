Return-Path: <linux-kernel+bounces-30410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC8831E56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44E2B253EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51262C84E;
	Thu, 18 Jan 2024 17:22:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011B2C843;
	Thu, 18 Jan 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598552; cv=none; b=WubPC9J3r/M4QJOcgCAAUO3N88Fb2PTHjcfajqfMygbR1PML0pJef7mTOn+IWC46Vp9/Sz0Ht5uTvY7SUzajB+gbWO9sgoIxO2OREg8FrLc+M9RCsDOBfw48s4OgCEKhlIaPzp+oUnltLTUANK4Zn6uqKeDa9zzO+G15UJX+aWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598552; c=relaxed/simple;
	bh=uh/ZegrayGjehc4ODdNQcSBJrpivXNQEjMOnrwqqNrw=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=VW0KgaxEiJFPWJ9qbflHzT13D9pMMjgnsymPC2V0+roHW8SVAdbdC1DfbXF4487PE5gnSUdSstbrDfWoIKaaT2w96lBhmMdd1Tt7lirNiTQLROLJZR3EiTubtn0xLOpB3JpuUYbFVVVe/LkLIDXrJu9vMCmf+f/z+fyP1PQygpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3F861042;
	Thu, 18 Jan 2024 09:23:12 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C00C3F5A1;
	Thu, 18 Jan 2024 09:22:24 -0800 (PST)
Date: Thu, 18 Jan 2024 17:22:21 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <cristian.marussi@arm.com>, <andersson@kernel.org>,
	<konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
	<conor+dt@kernel.org>, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Message-ID: <ZaleTVhYlUj6iufT@bogus>
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

I assume it will include all the Qualcomm specific vendor protocol
handling here. Not sure how it it implemented across different platforms
and but I already assume different platforms will use same protocol id
for different things and this implementation will abstract all those
details.

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

This gives me no clue what this means ?

> +#define	SCMI_MAX_TX_RX_SIZE		128
> +#define	PROTOCOL_PAYLOAD_SIZE		16
> +#define	SET_PARAM			0x10

I assume these are the actual message IDs ? Any idea why 0x0-0xF is skipped ?
I assume atleast the required 0x0-0x2 are implemented.

> +#define	GET_PARAM			0x11
> +#define	START_ACTIVITY			0x12
> +#define	STOP_ACTIVITY			0x13

In general, good to add description of these in the implementation here
or under Documentation or a pointer to the url where I can get the info.
If documenting within the kernel, please use SCMI spec format as it may
be easy to follow the same pattern even in the vendor protocols.

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
> +
> +	ret = ph->xops->xfer_get_init(ph, SET_PARAM, size + PROTOCOL_PAYLOAD_SIZE,
> +				      SCMI_MAX_TX_RX_SIZE, &t);
> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
> +	*msg++ = cpu_to_le32(param_id);
> +	memcpy(msg, buf, size);
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
> +	ret = ph->xops->xfer_get_init(ph, GET_PARAM, tx_size + PROTOCOL_PAYLOAD_SIZE,
> +				      SCMI_MAX_TX_RX_SIZE, &t);
> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
> +	*msg++ = cpu_to_le32(param_id);
> +	memcpy(msg, buf, tx_size);
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (t->rx.len > rx_size) {
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
> +
> +	ret = ph->xops->xfer_get_init(ph, START_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
> +				      SCMI_MAX_TX_RX_SIZE, &t);
> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
> +	*msg++ = cpu_to_le32(param_id);
> +	memcpy(msg, buf, size);
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
> +
> +	ret = ph->xops->xfer_get_init(ph, STOP_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
> +				      SCMI_MAX_TX_RX_SIZE, &t);
> +	if (ret)
> +		return ret;
> +
> +	msg = t->tx.buf;
> +	*msg++ = cpu_to_le32(EXTENDED_MSG_ID);
> +	*msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
> +	*msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
> +	*msg++ = cpu_to_le32(param_id);
> +	memcpy(msg, buf, size);
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

As Cristian might have pointed out, this will conflict and we need better
matching to ensure each vendor and protocols with each implementation has
unique matching mechanism so that only one match occurs per protocol on
any platform.

-- 
Regards,
Sudeep

