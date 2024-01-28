Return-Path: <linux-kernel+bounces-41560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F683F48E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C1E1C211DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08170D520;
	Sun, 28 Jan 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lNPnO8Lt"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C017CA4E;
	Sun, 28 Jan 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706428863; cv=none; b=XrQIzevBG1ZHyE1PaTwn5ziXppSki7QX74EUkzGzGLTnEmIU7M28TfDxPC11IaGoPH12wofmvUNABYQG/b5vxc2sW/c9hOGMSbNuOJ3qSS3eBE+jufPf7EwLeVZyX79CVUYvHPTVy6aIfjO226plau66xWs5ir19nx0bzpWlL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706428863; c=relaxed/simple;
	bh=T4METYcAZkjFh/mJCuNuZBxdEgskEbxwtwRQLMK6uFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hY3uuD4eCD+MtUY97u4pqrZ4l/bYDf8mFTF9ZIa5gy05AtIEscS0ZHFoDi0DM0dhj6LODrBtHEpPWu8upRZiVoP1+UGAsjboH8FiwGqz1K/k6kGCn2Kzw203B4nIb/3lU0UNDNOkAZxGFYqbn4S+spmv0ZAZ0Bzdbz2oRPzvXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lNPnO8Lt; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Tzxcr9tOf3ZDyTzxdrCxUn; Sun, 28 Jan 2024 08:52:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706428336;
	bh=r+0qjH378TiTSwFjUyd4p9CMqmeCRqj1m8DnL6D02Fs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lNPnO8LtOmgaPHv4YuPvMIR0GrxSE48lTBQQSDoz7FLOHLvq3xLiGRKieIOmpIGKg
	 XHXaam8yx0Ntn7h+n88ShlromrAwk/8cDOjL98Ax6KYHvTQJ9iC9v4635Pfi8YHeg/
	 qT6rhXRHgKrXft1n4EZPzgG8O55pV5Jpe9i0y8hiHOnJXLhx6d3L0scFjtpxEEjin2
	 xMyfBYEXCKdtGb1+YRv+LbHgGZuljCaq+Mj1/54MeafM3Fnl5rDOeHMoRIq34m9ZgY
	 0A/oqX/qU65fhqRmIyKOAIM1epM1LcRTKi/XN6S1USI+p9rWmJBN8N2GUsgDaGyeD8
	 trwTNqmSUcw7g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Jan 2024 08:52:16 +0100
X-ME-IP: 92.140.202.140
Message-ID: <a2a4bb76-0e6a-425d-bfb8-e1a844b44274@wanadoo.fr>
Date: Sun, 28 Jan 2024 08:52:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
To: Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240123080637.1902578-1-ychuang570808@gmail.com>
 <20240123080637.1902578-5-ychuang570808@gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240123080637.1902578-5-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/01/2024 à 09:06, Jacky Huang a écrit :
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add common pinctrl and GPIO driver for Nuvoton MA35 series SoC, and
> add support for ma35d1 pinctrl.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---

Hi,

Should there be a v4, a few nits below.

CJ

> +static int ma35_pinctrl_dt_node_to_map_func(struct pinctrl_dev *pctldev,
> +					    struct device_node *np,
> +					    struct pinctrl_map **map,
> +					    unsigned int *num_maps)
> +{
> +	struct ma35_pinctrl *npctl = pinctrl_dev_get_drvdata(pctldev);
> +	struct ma35_pin_group *grp;
> +	struct pinctrl_map *new_map;
> +	struct device_node *parent;
> +	int map_num = 1;
> +	int i;
> +
> +	/*
> +	 * first find the group of this node and check if we need create
> +	 * config maps for pins
> +	 */
> +	grp = ma35_pinctrl_find_group_by_name(npctl, np->name);
> +	if (!grp) {
> +		dev_err(npctl->dev, "unable to find group for node %s\n", np->name);
> +		return -EINVAL;
> +	}
> +
> +	map_num += grp->npins;
> +	new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num, GFP_KERNEL);

devm_kcalloc()?

> +	if (!new_map)
> +		return -ENOMEM;
> +
> +	*map = new_map;
> +	*num_maps = map_num;
> +	/* create mux map */
> +	parent = of_get_parent(np);
> +	if (!parent) {
> +		devm_kfree(pctldev->dev, new_map);
> +		return -EINVAL;
> +	}
> +
> +	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
> +	new_map[0].data.mux.function = parent->name;
> +	new_map[0].data.mux.group = np->name;
> +	of_node_put(parent);
> +
> +	new_map++;
> +	for (i = 0; i < grp->npins; i++) {
> +		new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
> +		new_map[i].data.configs.group_or_pin = pin_get_name(pctldev, grp->pins[i]);
> +		new_map[i].data.configs.configs = grp->settings[i].configs;
> +		new_map[i].data.configs.num_configs = grp->settings[i].nconfigs;
> +	}
> +	dev_dbg(pctldev->dev, "maps: function %s group %s num %d\n",
> +		(*map)->data.mux.function, (*map)->data.mux.group, map_num);
> +
> +	return 0;
> +}

..

> +static int ma35_pinctrl_parse_groups(struct device_node *np, struct ma35_pin_group *grp,
> +				     struct ma35_pinctrl *npctl, u32 index)
> +{
> +	unsigned long *configs;
> +	unsigned int nconfigs;
> +	struct ma35_pin_setting *pin;
> +	const __be32 *list;
> +	int i, j, size, ret;
> +
> +	dev_dbg(npctl->dev, "group(%d): %s\n", index, np->name);
> +
> +	grp->name = np->name;
> +
> +	ret = pinconf_generic_parse_dt_config(np, NULL, &configs, &nconfigs);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * the binding format is nuvoton,pins = <bank pin-mfp pin-function>,
> +	 * do sanity check and calculate pins number
> +	 */
> +	list = of_get_property(np, "nuvoton,pins", &size);
> +	size /= sizeof(*list);
> +	if (!size || size % 3) {
> +		dev_err(npctl->dev, "wrong setting!\n");
> +		return -EINVAL;
> +	}
> +	grp->npins = size / 3;
> +
> +	grp->pins = devm_kzalloc(npctl->dev, grp->npins * sizeof(*grp->pins), GFP_KERNEL);

devm_kcalloc()?

> +	if (!grp->pins)
> +		return -ENOMEM;
> +
> +	grp->settings = devm_kzalloc(npctl->dev, grp->npins * sizeof(*grp->settings), GFP_KERNEL);

devm_kcalloc()?

> +	if (!grp->settings)
> +		return -ENOMEM;
> +
> +	pin = grp->settings;
> +
> +	for (i = 0, j = 0; i < size; i += 3, j++) {
> +		pin->offset = be32_to_cpu(*list++) * MA35_MFP_REG_SZ_PER_BANK + MA35_MFP_REG_BASE;
> +		pin->shift = (be32_to_cpu(*list++) * MA35_MFP_BITS_PER_PORT) % 32;
> +		pin->muxval = be32_to_cpu(*list++);
> +		pin->configs = configs;
> +		pin->nconfigs = nconfigs;
> +		grp->pins[j] = npctl->info->get_pin_num(pin->offset, pin->shift);
> +		pin++;
> +	}
> +	return 0;
> +}
> +
> +static int ma35_pinctrl_parse_functions(struct device_node *np, struct ma35_pinctrl *npctl,
> +					u32 index)
> +{
> +	struct device_node *child;
> +	struct ma35_pin_func *func;
> +	struct ma35_pin_group *grp;
> +	static u32 grp_index;
> +	u32 ret, i = 0;
> +
> +	dev_dbg(npctl->dev, "parse function(%d): %s\n", index, np->name);
> +
> +	func = &npctl->functions[index];
> +	func->name = np->name;
> +	func->ngroups = of_get_child_count(np);
> +
> +	if (func->ngroups <= 0)
> +		return 0;
> +
> +	func->groups = devm_kzalloc(npctl->dev, func->ngroups * sizeof(char *), GFP_KERNEL);

devm_kcalloc()?

> +	if (!func->groups)
> +		return -ENOMEM;
> +
> +	for_each_child_of_node(np, child) {
> +		func->groups[i] = child->name;
> +		grp = &npctl->groups[grp_index++];
> +		ret = ma35_pinctrl_parse_groups(child, grp, npctl, i++);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}


