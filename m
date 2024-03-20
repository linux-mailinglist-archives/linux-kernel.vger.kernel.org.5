Return-Path: <linux-kernel+bounces-108719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6F880F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980581C220BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AECB3BBDF;
	Wed, 20 Mar 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCWX9BDb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D983BB50
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928395; cv=none; b=k7hixrYL+27kx+XEtP+Sti5oSjdvUQEhsoLR8Q2/x/37TwFhUNlGoVKFtmB7Ud0OIAHCpWcMi5Dfy+47d1N3thlsuOR9SkaBfxqOvadNhjxUG98TwiThCaSECLo7MuMKc9XZinfJlKtCRI7hdwG1jPqb7J+76yJXIZykADBODgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928395; c=relaxed/simple;
	bh=Xbz7RZs2qoxsSOVgBMXtuw7wrgJQ6iyANAo/cpTdYS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXWgDO+KU4yjovihw++ycc0qGpPZSbtOnY6hA0HJhuialZHxqNa0AwUq1WRZEV3a5wFXBJ3fdb4mvXHwth8z5gya9uqYgP30UFS12wYoJRR0YSAFqSEjsTGgkJHgkThX0Djp1Temj8tZ/M6WYzFPTVXgZBA2fBKUJsGdFMPWoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCWX9BDb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4146e7d7ce1so1174235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710928392; x=1711533192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWqSfDCJHms7lqXfIlaTfW+dy8ZdX9KOyEEBvt9xH0E=;
        b=lCWX9BDb9neM7H2OaosLnjqakKby+1ZDqtXGDTCkm3y+6gWiNyPpY1fSmTEvpXC2fR
         hU9ocgOr2Evpbe51spw7oEbl2Rv3fyII4VFtIOyPGtdX45K1zPD35ljxRNLJLxo1A3R/
         AZmPhwvUDQ0YiOzmk6bl+CdhRgbNACgN0aNzADaTMd+TacQpbGD9gNUohNfbdU+ibuqR
         D9ycalPKJe76sJ+mpZoXI2USqZGBIQyXL34lgAFu1ERbkyTr0ivFkGLIhDWSnOn4f2u5
         i9euurB22YaDolhYCMYevcUgd7rXS6AADbCu7YEKiegOUCfaTpTr1BVbRDOLREF3ObiN
         hOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710928392; x=1711533192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWqSfDCJHms7lqXfIlaTfW+dy8ZdX9KOyEEBvt9xH0E=;
        b=O2PyobzdB5f1ZiTfA6dv0m3NxLcEF8yAovG/sji/qEReia6rU5vNnCZL5BE7h4SUFp
         9F2ps1BypLTee1dzE3Ny910Q8V9RHD1+8DAduh9bfzGUTh93D2TNc23GGhsI/haF0W03
         6herThiPxJSWMI2NbfPJ2wqmtGNi3NvScDnjNCDwChhzFp6D0ocmgHygkXi6nbQg48y/
         7qh5xDVuTr52uN72nazwQeviztjYTcS217hA4QRyS8ttZSD9M3Apr2beDQySLe/A2Ivi
         3WVcmXgPLig9l05nVt1JDvocbVc3xJWAGoPM543HwYvbTyunpW+KUJ4z4PQALqvUfYLZ
         aVQw==
X-Forwarded-Encrypted: i=1; AJvYcCVuVgLNb3TMuFUBnxEntk2AO7dmvVAf75vSTGIjXNy3JkdPWlbpzvDQAgNi+tXgk1jgrYTJwb65vjsk77YsG+9azi5qPV+MO+li4tzw
X-Gm-Message-State: AOJu0Yw4CHd6GPTaroJz2L4VVmRchqBNHcCCwViznMfEkdL9rzboCs/6
	Lo3fE6PZMSxPOqEwG2hsskUnzM3Im0noGb9bT/4ILLDv+BSW4IWFTE3m2YZotmo=
X-Google-Smtp-Source: AGHT+IEGWam2BleDDIwAwkbAAZrry/0SqhJqmR1BrfBwYOhRWw9HQlg4QVKLKIvTSul95+1yqCvwQw==
X-Received: by 2002:a05:600c:4ed4:b0:414:37f:276f with SMTP id g20-20020a05600c4ed400b00414037f276fmr9306967wmq.22.1710928391476;
        Wed, 20 Mar 2024 02:53:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b2-20020a05600c4e0200b0041312c4865asm1720146wmq.2.2024.03.20.02.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 02:53:10 -0700 (PDT)
Date: Wed, 20 Mar 2024 12:53:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <dc43e3ac-584c-4b93-92bf-44bb6cee144a@moroto.mountain>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <20240314-pinctrl-scmi-v5-4-b19576e557f2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pinctrl-scmi-v5-4-b19576e557f2@nxp.com>

On Thu, Mar 14, 2024 at 09:35:21PM +0800, Peng Fan (OSS) wrote:
> +/* Define num configs, if not large than 4 use stack, else use kcalloc */
> +#define SCMI_NUM_CONFIGS	4
> +
> +static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
> +
> +struct scmi_pinctrl_funcs {
> +	unsigned int num_groups;
> +	const char **groups;
> +};
> +
> +struct scmi_pinctrl {
> +	struct device *dev;
> +	struct scmi_protocol_handle *ph;
> +	struct pinctrl_dev *pctldev;
> +	struct pinctrl_desc pctl_desc;
> +	struct scmi_pinctrl_funcs *functions;
> +	unsigned int nr_functions;
> +	char **groups;
> +	unsigned int nr_groups;

groups and nr_groups are set/allocated but not used anywhere.  Delete
them.

> +	struct pinctrl_pin_desc *pins;
> +	unsigned int nr_pins;

These last two struct members duplicate the information in
pmx->pctl_desc.pins and pmx->pctl_desc.npins.  They're not used outside
of the pinctrl_scmi_get_pins() function.  Delete them.

> +};
> +
> +static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->count_get(pmx->ph, GROUP_TYPE);
> +}
> +
> +static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev,
> +					       unsigned int selector)
> +{
> +	int ret;
> +	const char *name;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	ret = pinctrl_ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
> +	if (ret) {
> +		dev_err(pmx->dev, "get name failed with err %d", ret);
> +		return NULL;
> +	}
> +
> +	return name;
> +}
> +
> +static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
> +				       unsigned int selector,
> +				       const unsigned int **pins,
> +				       unsigned int *num_pins)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->group_pins_get(pmx->ph, selector, pins, num_pins);
> +}
> +
> +static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
> +	.get_groups_count = pinctrl_scmi_get_groups_count,
> +	.get_group_name = pinctrl_scmi_get_group_name,
> +	.get_group_pins = pinctrl_scmi_get_group_pins,
> +#ifdef CONFIG_OF
> +	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
> +	.dt_free_map = pinconf_generic_dt_free_map,
> +#endif
> +};
> +
> +static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->count_get(pmx->ph, FUNCTION_TYPE);
> +}
> +
> +static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
> +						  unsigned int selector)
> +{
> +	int ret;
> +	const char *name;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	ret = pinctrl_ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
> +	if (ret) {
> +		dev_err(pmx->dev, "get name failed with err %d", ret);
> +		return NULL;
> +	}
> +
> +	return name;
> +}
> +
> +static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
> +					    unsigned int selector,
> +					    const char * const **groups,
> +					    unsigned int * const num_groups)
> +{
> +	const unsigned int *group_ids;
> +	int ret, i;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!groups || !num_groups)
> +		return -EINVAL;
> +
> +	if (selector < pmx->nr_functions &&
> +	    pmx->functions[selector].num_groups) {
> +		*groups = (const char * const *)pmx->functions[selector].groups;
> +		*num_groups = pmx->functions[selector].num_groups;
> +		return 0;
> +	}
> +
> +	ret = pinctrl_ops->function_groups_get(pmx->ph, selector,
> +					       &pmx->functions[selector].num_groups,
> +					       &group_ids);
> +	if (ret) {
> +		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
> +		return ret;
> +	}
> +
> +	*num_groups = pmx->functions[selector].num_groups;
> +	if (!*num_groups)
> +		return -EINVAL;
> +
> +	pmx->functions[selector].groups =
> +		devm_kcalloc(pmx->dev, *num_groups,
> +			     sizeof(*pmx->functions[selector].groups),
> +			     GFP_KERNEL);
> +	if (!pmx->functions[selector].groups)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < *num_groups; i++) {
> +		pmx->functions[selector].groups[i] =
> +			pinctrl_scmi_get_group_name(pmx->pctldev,
> +						    group_ids[i]);
> +		if (!pmx->functions[selector].groups[i]) {
> +			ret = -ENOMEM;

-EINVAL would be a more appropriate error code than -ENOMEM.  Nothing
is allocated here.

> +			goto err_free;
> +		}
> +	}
> +
> +	*groups = (const char * const *)pmx->functions[selector].groups;
> +
> +	return 0;
> +
> +err_free:
> +	devm_kfree(pmx->dev, pmx->functions[selector].groups);
> +
> +	return ret;
> +}

I re-wrote this function.  I'm not totally sure it's better...

static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
					    unsigned int selector,
					    const char * const **p_groups,
					    unsigned int * const p_num_groups)
{
	struct scmi_pinctrl_funcs *func;
	const unsigned int *group_ids;
	unsigned int num_groups;
	const char **groups;
	int ret, i;
	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);

	if (!p_groups || !p_num_groups)
		return -EINVAL;

	if (selector >= pmx->nr_functions)
		return -EINVAL;

	func = &pmx->functions[selector];
	if (func->num_groups)
		goto done;

	ret = pinctrl_ops->function_groups_get(pmx->ph, selector, &num_groups,
					       &group_ids);
	if (ret) {
		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
		return ret;
	}
	if (!num_groups)
		return -EINVAL;

	groups = devm_kcalloc(pmx->dev, num_groups, sizeof(*groups), GFP_KERNEL);
	if (!groups)
		return -ENOMEM;

	for (i = 0; i < num_groups; i++) {
		groups[i] = pinctrl_scmi_get_group_name(pctldev, group_ids[i]);
		if (!groups[i]) {
			ret = -EINVAL;
			goto err_free;
		}
	}

	func->num_groups = num_groups;
	func->groups = groups;
done:
	*p_groups = (const char * const *)func->groups;
	*p_num_groups = func->num_groups;

	return 0;

err_free:
	devm_kfree(pmx->dev, groups);

	return ret;
}

> +
> +static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev,
> +				     unsigned int selector, unsigned int group)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->mux_set(pmx->ph, selector, group);
> +}
> +
> +static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
> +				unsigned int offset)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->pin_request(pmx->ph, offset);
> +}
> +
> +static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int offset)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->pin_free(pmx->ph, offset);
> +}
> +
> +static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
> +	.request = pinctrl_scmi_request,
> +	.free = pinctrl_scmi_free,
> +	.get_functions_count = pinctrl_scmi_get_functions_count,
> +	.get_function_name = pinctrl_scmi_get_function_name,
> +	.get_function_groups = pinctrl_scmi_get_function_groups,
> +	.set_mux = pinctrl_scmi_func_set_mux,
> +};
> +
> +static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param,
> +					 enum scmi_pinctrl_conf_type *type)
> +{
> +	u32 arg = param;
> +
> +	switch (arg) {
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		*type = SCMI_PIN_BIAS_BUS_HOLD;
> +		break;
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		*type = SCMI_PIN_BIAS_DISABLE;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*type = SCMI_PIN_BIAS_HIGH_IMPEDANCE;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		*type = SCMI_PIN_BIAS_PULL_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
> +		*type = SCMI_PIN_BIAS_PULL_DEFAULT;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		*type = SCMI_PIN_BIAS_PULL_UP;
> +		break;
> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +		*type = SCMI_PIN_DRIVE_OPEN_DRAIN;
> +		break;
> +	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
> +		*type = SCMI_PIN_DRIVE_OPEN_SOURCE;
> +		break;
> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
> +		*type = SCMI_PIN_DRIVE_PUSH_PULL;
> +		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH:
> +		*type = SCMI_PIN_DRIVE_STRENGTH;
> +		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH_UA:
> +		*type = SCMI_PIN_DRIVE_STRENGTH;
> +		break;
> +	case PIN_CONFIG_INPUT_DEBOUNCE:
> +		*type = SCMI_PIN_INPUT_DEBOUNCE;
> +		break;
> +	case PIN_CONFIG_INPUT_ENABLE:
> +		*type = SCMI_PIN_INPUT_MODE;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT:
> +		*type = SCMI_PIN_INPUT_SCHMITT;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		*type = SCMI_PIN_INPUT_MODE;
> +		break;
> +	case PIN_CONFIG_MODE_LOW_POWER:
> +		*type = SCMI_PIN_LOW_POWER_MODE;
> +		break;
> +	case PIN_CONFIG_OUTPUT:
> +		*type = SCMI_PIN_OUTPUT_VALUE;
> +		break;
> +	case PIN_CONFIG_OUTPUT_ENABLE:
> +		*type = SCMI_PIN_OUTPUT_MODE;
> +		break;
> +	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
> +		*type = SCMI_PIN_OUTPUT_VALUE;
> +		break;
> +	case PIN_CONFIG_POWER_SOURCE:
> +		*type = SCMI_PIN_POWER_SOURCE;
> +		break;
> +	case PIN_CONFIG_SLEW_RATE:
> +		*type = SCMI_PIN_SLEW_RATE;
> +		break;
> +	case SCMI_PIN_OEM_START ... SCMI_PIN_OEM_END:
> +		*type = arg;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin, unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_type;
> +	enum scmi_pinctrl_conf_type type;
> +	u32 config_value;
> +
> +	if (!config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);
> +
> +	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
> +	if (ret) {
> +		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, type,
> +				      &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static int
> +pinctrl_scmi_alloc_configs(struct pinctrl_dev *pctldev, u32 num_configs,
> +			   u32 **p_config_value,
> +			   enum scmi_pinctrl_conf_type **p_config_type)
> +{
> +	if (num_configs <= SCMI_NUM_CONFIGS)
> +		return 0;
> +
> +	*p_config_value = kcalloc(num_configs, sizeof(u32), GFP_KERNEL);
> +	*p_config_type = kcalloc(num_configs,
> +				 sizeof(enum scmi_pinctrl_conf_type),
> +				 GFP_KERNEL);
> +
> +	if (!*p_config_value || !*p_config_type) {
> +		kfree(*p_config_value);
> +		kfree(*p_config_type);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +pinctrl_scmi_free_configs(struct pinctrl_dev *pctldev, u32 num_configs,
> +			  u32 **p_config_value,
> +			  enum scmi_pinctrl_conf_type **p_config_type)
> +{
> +	if (num_configs <= SCMI_NUM_CONFIGS)
> +		return;
> +
> +	kfree(*p_config_value);
> +	kfree(*p_config_type);
> +}
> +
> +static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin,
> +				    unsigned long *configs,
> +				    unsigned int num_configs)
> +{
> +	int i, ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
> +	u32 config_value[SCMI_NUM_CONFIGS];
> +	enum scmi_pinctrl_conf_type *p_config_type = config_type;
> +	u32 *p_config_value = config_value;
> +	enum pin_config_param param;
> +
> +	if (!configs || !num_configs)
> +		return -EINVAL;
> +
> +	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
> +					 &p_config_value);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		param = pinconf_to_config_param(configs[i]);
> +		ret = pinctrl_scmi_map_pinconf_type(param, &p_config_type[i]);
> +		if (ret) {
> +			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +			goto free_config;
> +		}
> +		p_config_value[i] = pinconf_to_config_argument(configs[i]);
> +	}
> +
> +	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, num_configs,
> +				      p_config_type,  p_config_value);
> +	if (ret)
> +		dev_err(pmx->dev, "Error parsing config %d\n", ret);
> +
> +free_config:
> +	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
> +				  &p_config_value);
> +	return ret;
> +}
> +
> +static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
> +					  unsigned int group,
> +					  unsigned long *configs,
> +					  unsigned int num_configs)
> +{
> +	int i, ret;
> +	struct scmi_pinctrl *pmx =  pinctrl_dev_get_drvdata(pctldev);
> +	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
> +	u32 config_value[SCMI_NUM_CONFIGS];
> +	enum scmi_pinctrl_conf_type *p_config_type = config_type;
> +	u32 *p_config_value = config_value;
> +	enum pin_config_param param;
> +
> +	if (!configs || !num_configs)
> +		return -EINVAL;
> +
> +	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
> +					 &p_config_value);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		param = pinconf_to_config_param(configs[i]);
> +		ret = pinctrl_scmi_map_pinconf_type(param,
> +						    &p_config_type[i]);
> +		if (ret) {
> +			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +			goto free_config;
> +		}
> +
> +		p_config_value[i] = pinconf_to_config_argument(configs[i]);
> +	}
> +
> +	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, num_configs,
> +				      p_config_type, p_config_value);
> +	if (ret)
> +		dev_err(pmx->dev, "Error parsing config %d", ret);
> +
> +free_config:
> +	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
> +				  &p_config_value);
> +	return ret;
> +};
> +
> +static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
> +					  unsigned int group,
> +					  unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_type;
> +	enum scmi_pinctrl_conf_type type;
> +	u32 config_value;
> +
> +	if (!config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);
> +	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
> +	if (ret) {
> +		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, type,
> +				      &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
> +	.is_generic = true,
> +	.pin_config_get = pinctrl_scmi_pinconf_get,
> +	.pin_config_set = pinctrl_scmi_pinconf_set,
> +	.pin_config_group_set = pinctrl_scmi_pinconf_group_set,
> +	.pin_config_group_get = pinctrl_scmi_pinconf_group_get,
> +	.pin_config_config_dbg_show = pinconf_generic_dump_config,
> +};
> +
> +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> +				 unsigned int *nr_pins,
> +				 const struct pinctrl_pin_desc **pins)
> +{
> +	int ret, i;
> +
> +	if (!pins || !nr_pins)
> +		return -EINVAL;
> +
> +	if (pmx->nr_pins) {

This condition is testing whether we can re-use the information from the
previous call.  However, the function is only called once (from probe)
so there is no previous call and this condition can be removed.

> +		*pins = pmx->pins;
> +		*nr_pins = pmx->nr_pins;
> +		return 0;
> +	}
> +
> +	*nr_pins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> +
> +	pmx->nr_pins = *nr_pins;
> +	pmx->pins = devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins),
> +				       GFP_KERNEL);
> +	if (!pmx->pins)
> +		return -ENOMEM;

If we were going to re-use the information then we'd need to set
pmx->nr_pins = 0; on this path.  But we're not, so that's fine.

> +
> +	for (i = 0; i < *nr_pins; i++) {
> +		pmx->pins[i].number = i;
> +		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE,
> +					    &pmx->pins[i].name);
> +		if (ret) {
> +			dev_err(pmx->dev, "Can't get name for pin %d: rc %d", i, ret);
> +			pmx->nr_pins = 0;

No need to set ->nr_pins = 0;

> +			return ret;
> +		}
> +	}
> +
> +	*pins = pmx->pins;
> +	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
> +
> +	return 0;
> +}

Ok, I put way too much thought into reviewing this function and I ended
up re-writing it slightly:

static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
				 struct pinctrl_desc *desc)
{
	struct pinctrl_pin_desc *pins;
	unsigned int npins;
	int ret, i;

	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
	pins = devm_kmalloc_array(pmx->dev, npins, sizeof(*pins), GFP_KERNEL);
	if (!pins)
		return -ENOMEM;

	for (i = 0; i < npins; i++) {
		pins[i].number = i;
		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
		if (ret)
			return dev_err_probe(pmx->dev, ret,
					     "Can't get name for pin %d", i);
	}

	desc->npins = npins;
	desc->pins = pins;
	dev_dbg(pmx->dev, "got pins %d", npins);

	return 0;
}

> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static int scmi_pinctrl_probe(struct scmi_device *sdev)
> +{
> +	int ret;
> +	struct device *dev = &sdev->dev;
> +	struct scmi_pinctrl *pmx;
> +	const struct scmi_handle *handle;
> +	struct scmi_protocol_handle *ph;
> +
> +	if (!sdev || !sdev->handle)
> +		return -EINVAL;
> +
> +	handle = sdev->handle;
> +
> +	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
> +						&ph);
> +	if (IS_ERR(pinctrl_ops))
> +		return PTR_ERR(pinctrl_ops);
> +
> +	pmx = devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
> +	if (!pmx)
> +		return -ENOMEM;
> +
> +	pmx->ph = ph;
> +
> +	pmx->dev = dev;
> +	pmx->pctl_desc.name = DRV_NAME;
> +	pmx->pctl_desc.owner = THIS_MODULE;
> +	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
> +	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
> +	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
> +
> +	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
> +				    &pmx->pctl_desc.pins);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
> +					     &pmx->pctldev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
> +
> +	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
> +	pmx->nr_groups = pinctrl_scmi_get_groups_count(pmx->pctldev);
> +
> +	if (pmx->nr_functions) {

You don't need to have this condition.  kcalloc() can allocate zero
element arrays.

> +		pmx->functions = devm_kcalloc(dev, pmx->nr_functions,
> +					      sizeof(*pmx->functions),
> +					      GFP_KERNEL);
> +		if (!pmx->functions)
> +			return -ENOMEM;
> +	}
> +
> +	if (pmx->nr_groups) {

Same.

> +		pmx->groups = devm_kcalloc(dev, pmx->nr_groups,
> +					   sizeof(*pmx->groups), GFP_KERNEL);
> +		if (!pmx->groups)
> +			return -ENOMEM;
> +	}
> +
> +	return pinctrl_enable(pmx->pctldev);

There is a double free bug in pinctrl_enable() but it's not related to
your patch.  I'll send a fix for that.

> +}

regards,
dan carpenter


