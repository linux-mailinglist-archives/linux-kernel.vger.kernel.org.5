Return-Path: <linux-kernel+bounces-144019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB88A40DF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B5C1F2134E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2C1EF01;
	Sun, 14 Apr 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="G5vdpaEH"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D34EACE;
	Sun, 14 Apr 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713079274; cv=none; b=CLl8FgXdBBYW300eZiwvDZK8sfv11KLmZl6iymbcPAYHI0jsj4uEmDtg4iXYeqh/ay5JwsTFmAhQv9AGGz+C67CzsO50au2gPSFMGVmuRhbWe1o6uXhxJ2eJZNH8Giu/ZcsGIumleViUY/Jr18Jnth9In0ixvWMjgjmnZrY7orE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713079274; c=relaxed/simple;
	bh=LffLWXbtrO8JQrVOEfI+ZVrSsRAK0cusnGbM3eJq/es=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cCWZuK1I6HZTr2A2IbpSPEVX9maj+VpBEMRiJwwArwbDjpZhftpX935cMq+IrvaoOboHZSOnYzG825wEFGR75H0y9CD0ztU6uyuT/HkII7XyS4cJiS624+z+hoZYdsw6dQKpsZhIKqBx6x/lYcKtcakggVWXoD/Q3+Kgnc/mAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=G5vdpaEH; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vu9Xri76MUEo7vu9YrFcTz; Sun, 14 Apr 2024 09:19:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713079195;
	bh=HcKjhMiD/D1TvETHVyrW4OtEDwfkxXYGFLmr6OM5lX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=G5vdpaEHpJGN+C1v8XPSeNstGe8DdVLj57FyMhZY6BrpI9LOYflZile28IB43SWPm
	 rnyixRiouyggiFlEUVncy0hWFoCweS8qWPl+0Ih2oXSGEgCqT+NFFnm3ASpOTqZ532
	 9xVwMCqlBPdENLaw+3vXwxg/swzgvr8tj/wsjMg2oaPXxhoT8iSqXJU4EAcNWQ+dPo
	 981uouKuhVykrQvgpn55J2Do4jQtURkVh2dGjbibR5QwIlu1sRtfdwhBBuY7yt3Kh2
	 dmDzQYk2TsTwLYaiANIwJPMU5NBgXoRKI8Dtnh3PlEyx/aEF2TSx4HreqlQAc1zPrB
	 2gDvrZs97RwvA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 09:19:54 +0200
X-ME-IP: 86.243.17.157
Message-ID: <66b11910-c6e2-401c-a293-441f6d85bb90@wanadoo.fr>
Date: Sun, 14 Apr 2024 09:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] pinctrl: bcm: Add pinconf/pinmux controller driver
 for BCM2712
To: Andrea della Porta <andrea.porta@suse.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <8fb5dde9404875777587c867e7bdb4f691ab83f2.1713036964.git.andrea.porta@suse.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <8fb5dde9404875777587c867e7bdb4f691ab83f2.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/04/2024 à 00:14, Andrea della Porta a écrit :
> Add a pincontrol driver for BCM2712. BCM2712 allows muxing GPIOs
> and setting configuration on pads.
> 
> Originally-by: Jonathan Bell <jonathan@raspberrypi.com>
> Originally-by: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   drivers/pinctrl/bcm/Kconfig           |    9 +
>   drivers/pinctrl/bcm/Makefile          |    1 +
>   drivers/pinctrl/bcm/pinctrl-bcm2712.c | 1247 +++++++++++++++++++++++++
>   3 files changed, 1257 insertions(+)
>   create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm2712.c

..

> +static int bcm2712_pmx_get_function_groups(struct pinctrl_dev *pctldev,
> +		unsigned selector,
> +		const char * const **groups,
> +		unsigned * const num_groups)
> +{
> +	struct bcm2712_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);

Missing empty new line.

> +	/* every pin can do every function */
> +	*groups = pc->gpio_groups;
> +	*num_groups = pc->pctl_desc.npins;
> +
> +	return 0;
> +}

..

> +static int bcm2712_pinconf_get(struct pinctrl_dev *pctldev,
> +			unsigned pin, unsigned long *config)
> +{
> +	struct bcm2712_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param param = pinconf_to_config_param(*config);
> +	u32 arg;
> +
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		arg = (bcm2712_pull_config_get(pc, pin) == BCM2712_PULL_NONE);
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		arg = (bcm2712_pull_config_get(pc, pin) == BCM2712_PULL_DOWN);
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		arg = (bcm2712_pull_config_get(pc, pin) == BCM2712_PULL_UP);
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	*config = pinconf_to_config_packed(param, arg);
> +
> +	return -ENOTSUPP;

Strange.

	return 0;
?

> +}
> +
> +static int bcm2712_pinconf_set(struct pinctrl_dev *pctldev,
> +			       unsigned int pin, unsigned long *configs,
> +			       unsigned int num_configs)
> +{
> +	struct bcm2712_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
> +	u32 param, arg;
> +	int i;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		param = pinconf_to_config_param(configs[i]);
> +		arg = pinconf_to_config_argument(configs[i]);
> +
> +		switch (param) {
> +		case PIN_CONFIG_BIAS_DISABLE:
> +			bcm2712_pull_config_set(pc, pin, BCM2712_PULL_NONE);
> +			break;
> +		case PIN_CONFIG_BIAS_PULL_DOWN:
> +			bcm2712_pull_config_set(pc, pin, BCM2712_PULL_DOWN);
> +			break;
> +		case PIN_CONFIG_BIAS_PULL_UP:
> +			bcm2712_pull_config_set(pc, pin, BCM2712_PULL_UP);
> +			break;
> +		default:
> +			return -ENOTSUPP;
> +		}
> +	} /* for each config */

This comment is not really usefull, IMHO.

> +
> +	return 0;
> +}

..

> +static int bcm2712_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	//struct device_node *np = dev->of_node;
> +	const struct bcm_plat_data *pdata;
> +	//const struct of_device_id *match;
> +	struct bcm2712_pinctrl *pc;
> +	const char **names;
> +	int num_pins, i;
> +
> +	pdata = device_get_match_data(&pdev->dev);
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pc);
> +	pc->dev = dev;
> +	spin_lock_init(&pc->lock);
> +
> +	//pc->base = devm_of_iomap(dev, np, 0, NULL);

Any use for this commented code? (and variable declarations above)

CJ

> +	pc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (WARN_ON(IS_ERR(pc->base))) {
> +		//dev_err(dev, "could not get IO memory\n");
> +		return PTR_ERR(pc->base);
> +	}
> +
> +	pc->pctl_desc = *pdata->pctl_desc;
> +	num_pins = pc->pctl_desc.npins;
> +	names = devm_kmalloc_array(dev, num_pins, sizeof(const char *),
> +				   GFP_KERNEL);
> +	if (!names)
> +		return -ENOMEM;
> +	for (i = 0; i < num_pins; i++)
> +		names[i] = pc->pctl_desc.pins[i].name;
> +	pc->gpio_groups = names;
> +	pc->pin_regs = pdata->pin_regs;
> +	pc->pin_funcs = pdata->pin_funcs;
> +	pc->pctl_dev = devm_pinctrl_register(dev, &pc->pctl_desc, pc);
> +	if (IS_ERR(pc->pctl_dev))
> +		return PTR_ERR(pc->pctl_dev);
> +
> +	pc->gpio_range = *pdata->gpio_range;
> +	pinctrl_add_gpio_range(pc->pctl_dev, &pc->gpio_range);
> +
> +	return 0;
> +}

..


