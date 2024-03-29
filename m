Return-Path: <linux-kernel+bounces-125306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B47A8923CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94771C2237B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3685644;
	Fri, 29 Mar 2024 19:01:02 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C44F8B1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738862; cv=none; b=IYVPBxu5CjbceiVdsJXIESXNUXN+YRFpXN8KkjHeAgzG0kYqApTcJGPsdWFKYpiMOUSqSm9ZlV/Xh5Ea30eEe7mZPUM2By1HbMnPmHZPnFP22yo98tIuMOSP8HUCeYCJ0uhVPgqTuvKAKBXXcKJ6odX/wBypSpnF3icihcmUFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738862; c=relaxed/simple;
	bh=GsKkA//w/F6p1DceLlnK3us287Q2nZOD7ADya93kfKs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcdxYEcqKFBvrs/7v3+Jk2KAFJdFJVIXOCju2wvKOTcggfcD20azHkHP+o6i2oy/8kVts/SXnz842+T+mEhc2pmL5CwJeQFUotDydJNo+yzMbaOL6J/bNaVMjQpj4EWDMQyE2IDBBYC1yrnpY4SUMoWma8MB4/Pb8hbjLk3PSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id a7c36e9b-edfe-11ee-b3cf-005056bd6ce9;
	Fri, 29 Mar 2024 21:00:49 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Mar 2024 21:00:48 +0200
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>

Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) kirjoitti:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add basic implementation of the SCMI v3.2 pincontrol protocol.

..

>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o

Actually you want to have := here.

> +scmi-protocols-y += pinctrl.o



>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)

Side note: The -objs has to be -y

..

> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>

This is semi-random list of headers. Please, follow IWYU principle
(include what you use). There are a lot of inclusions I see missing
(just in the context of this page I see bits.h, types.h, and
 asm/byteorder.h).

..

> +enum scmi_pinctrl_protocol_cmd {
> +	PINCTRL_ATTRIBUTES = 0x3,
> +	PINCTRL_LIST_ASSOCIATIONS = 0x4,
> +	PINCTRL_SETTINGS_GET = 0x5,
> +	PINCTRL_SETTINGS_CONFIGURE = 0x6,
> +	PINCTRL_REQUEST = 0x7,
> +	PINCTRL_RELEASE = 0x8,
> +	PINCTRL_NAME_GET = 0x9,
> +	PINCTRL_SET_PERMISSIONS = 0xa

Leave trailing comma as it's not a termination.

> +};

..

> +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
> +				       struct scmi_pinctrl_info *pi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr),
> +				      &t);

This looks much better on a single line.

> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
> +		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
> +		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}

..

> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
> +				      sizeof(*rx), &t);

Possible to have on a single line (if you use relaxed 100 limit).
Or (re)split it more logically:

	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES,
				      sizeof(*tx), sizeof(*rx), &t);

> +	if (ret)
> +		return ret;

..

> +	/*
> +	 * If supported overwrite short name with the extended one;
> +	 * on error just carry on and use already provided short name.
> +	 */
> +	if (!ret && ext_name_flag)

Please, use standard pattern, i.e.

	if (ret)
		return ret;

> +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
> +					    (u32 *)&type, name,

Why is an explicit casting needed?

> +					    SCMI_MAX_STR_SIZE);
> +	return ret;

..

> +	iter = ph->hops->iter_response_init(ph, &ops, size,
> +					    PINCTRL_LIST_ASSOCIATIONS,
> +					    sizeof(struct scmi_msg_pinctrl_list_assoc),
> +					    &ipriv);

> +

Redundant blank line.

> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);

..

> +	if (p->flag == 1)
> +		attributes |= FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> +	else if (!p->flag)

Be consistent, i.e. if (p->flag == 0)

> +		attributes |= FIELD_PREP(CONFIG_TYPE_MASK, p->config_types[0]);

..

> +		st->num_remaining = le32_get_bits(r->num_configs,
> +						  GENMASK(31, 24));

One line?

..

> +	if (!p->flag) {
> +		if (p->config_types[0] !=
> +		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
> +			return -EINVAL;
> +	} else if (p->flag == 1) {
> +		p->config_types[st->desc_index + st->loop_idx] =
> +			le32_get_bits(r->configs[st->loop_idx * 2],
> +				      GENMASK(7, 0));

With a temporary variable for r->configs[st->loop_idx * 2] the above can be
written in much better way.

> +	} else if (p->flag == 2) {
> +		return 0;
> +	}

> +	p->config_values[st->desc_index + st->loop_idx] =
> +		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);

For the sake of consistency with the above suggestion also temporary for next
config value.

..

> +	iter = ph->hops->iter_response_init(ph, &ops, 1, PINCTRL_SETTINGS_GET,
> +					    sizeof(struct scmi_msg_settings_get),
> +					    &ipriv);

> +

Redundant blank line.

> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);

..

> +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
> +				       u32 selector,
> +				       struct scmi_group_info *group)
> +{
> +	int ret;

> +	if (!group)
> +		return -EINVAL;

When the above is not a dead code?

> +	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> +				      group->name,
> +				      &group->nr_pins);
> +	if (ret)
> +		return ret;
> +
> +	if (!group->nr_pins) {
> +		dev_err(ph->dev, "Group %d has 0 elements", selector);
> +		return -ENODATA;
> +	}
> +
> +	group->group_pins = kmalloc_array(group->nr_pins,
> +					  sizeof(*group->group_pins),
> +					  GFP_KERNEL);
> +	if (!group->group_pins)
> +		return -ENOMEM;
> +
> +	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> +					     group->nr_pins, group->group_pins);
> +	if (ret) {
> +		kfree(group->group_pins);
> +		return ret;
> +	}
> +
> +	group->present = true;
> +	return 0;
> +}

..

> +		ret = scmi_pinctrl_get_group_info(ph, selector,
> +						  &pi->groups[selector]);

One line?

> +		if (ret)
> +			return ret;

..

> +	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
> +				      func->name,
> +				      &func->nr_groups);

At least last two lines can be joined.

> +	if (ret)
> +		return ret;

..

> +	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
> +				      pin->name, NULL);

It's pleany of room on the previous line.

> +	if (ret)
> +		return ret;

..

> +		ret = scmi_pinctrl_get_pin_info(ph, selector,
> +						&pi->pins[selector]);

Ditto.

> +		if (ret)
> +			return ret;

..

> +static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	int ret;
> +	u32 version;
> +	struct scmi_pinctrl_info *pinfo;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
> +		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);

Huh?!

Please, get yourself familiar with the scope of devm APIs.

> +	if (!pinfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_pinctrl_attributes_get(ph, pinfo);
> +	if (ret)
> +		return ret;
> +
> +	pinfo->pins = devm_kcalloc(ph->dev, pinfo->nr_pins,
> +				   sizeof(*pinfo->pins),
> +				   GFP_KERNEL);
> +	if (!pinfo->pins)
> +		return -ENOMEM;
> +
> +	pinfo->groups = devm_kcalloc(ph->dev, pinfo->nr_groups,
> +				     sizeof(*pinfo->groups),
> +				     GFP_KERNEL);
> +	if (!pinfo->groups)
> +		return -ENOMEM;
> +
> +	pinfo->functions = devm_kcalloc(ph->dev, pinfo->nr_functions,
> +					sizeof(*pinfo->functions),
> +					GFP_KERNEL);
> +	if (!pinfo->functions)
> +		return -ENOMEM;
> +
> +	pinfo->version = version;
> +
> +	return ph->set_priv(ph, pinfo, version);
> +}
> +
> +static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle *ph)
> +{
> +	int i;
> +	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
> +
> +	for (i = 0; i < pi->nr_groups; i++) {
> +		if (pi->groups[i].present) {
> +			kfree(pi->groups[i].group_pins);
> +			pi->groups[i].present = false;
> +		}
> +	}
> +
> +	for (i = 0; i < pi->nr_functions; i++) {
> +		if (pi->functions[i].present) {
> +			kfree(pi->functions[i].groups);

This is wrong in conjunction with the above.

> +			pi->functions[i].present = false;
> +		}
> +	}
> +
> +	return 0;
> +}

..

> +static const struct scmi_protocol scmi_pinctrl = {
> +	.id = SCMI_PROTOCOL_PINCTRL,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_pinctrl_protocol_init,
> +	.instance_deinit = &scmi_pinctrl_protocol_deinit,
> +	.ops = &pinctrl_proto_ops,
> +	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
> +};

> +

Redundant blank line.

> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)


-- 
With Best Regards,
Andy Shevchenko



