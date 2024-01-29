Return-Path: <linux-kernel+bounces-42076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CF83FBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E1B1C21828
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EFDF78;
	Mon, 29 Jan 2024 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0//VCh7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAEDDDD;
	Mon, 29 Jan 2024 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706493930; cv=none; b=pVMucsS8JtnmyYNniexEc08KoZ5BuPhs4Yn8O++gUridHMmpbgNMcXnp+0QEGvFwrbXNjWY+1EIiu2VywyiRC3qZO+j4BlhoFAcghrtEvCI13HFGHxTgU2mkBGQlXBDuBM4wjAeZmrjfq910DHiPdzZNZWNS9HctNgUqGTzpFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706493930; c=relaxed/simple;
	bh=R9OJHUY1pL3jg/qz4OiURdNfKiH8z3++M3YuB9lE10U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVv3kWh0qSUWR6btModP5InBYQJd4nLFqMXhmF2IPOgSUKZxDT4m9+QIKjZIsdr1yxUMtpUBiBwCSuDOyPGcj2meiifPaUX70wavbqV6f5hpELHlQgbr3EtCb9Oav54IejzNES0d02rcmAeqmjw6JiIFAi/fIM4PWGjIdqRC/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0//VCh7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so875932b3a.3;
        Sun, 28 Jan 2024 18:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706493928; x=1707098728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5cMX6p2wc2NF5P2CX7hgg0fQbhesHCjjIv0biNyFak=;
        b=d0//VCh7AdfN68gL/Q1RxVS7CRkzIe64D/eMX3AaEfjjWKfs4mp0hRra0uxmODKRFL
         azKfXFPNcRwqq14jcc+tlhnlILXH9/BlGnwoYhVV/ZbvKbv7GpA2TzkKw7Sg2EnMXtHI
         8/DPMRk2zQ6krClyiCb/+xTORv568BbNz3au/InOlNMFfIUbtB5Um7SOyDjNqXtyiyPA
         aiGhsP4LbJ7X2qSqqDfaP/rBE9JQqkj28IxP9ANlwQ93M4t+KLhs/MeYRIvzuxhBcmAA
         2SVKCzHVQ5GaX84VCF9/WWkERqpQaAG82CiK9op4gxvV4Ay3s2sLcy83UTXGhlLoZ8uR
         5uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706493928; x=1707098728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5cMX6p2wc2NF5P2CX7hgg0fQbhesHCjjIv0biNyFak=;
        b=ZqdWF4pErU87GAIjQLpd9ctZJGJqhdD7Wv7iLewKz129BpXqGHjBgIUqUqlHw6O0uL
         jWi1tO4YgkgViJpId0vM8RmJs3vficMBzVhevdZJG/e7rO49nM/VMg6YcKPEXiprxbXl
         N+Guu6/RvZf6FhH4EhK8rVbBXwsRG5wzAgUeFqNGl32SCOVLExTWv8mKRqPHw5lLeLeJ
         jluOxzTE6jPHvfXV9EPlspY1RXZOZ7fac/Iv1BeD52klvqeF2CizBOSmgzVDgNoe2iDT
         E5kYqSvUPYfP5+INsKChS4tvNz4azx8rqw9h68MOm+KhuOPJU7nO45XIwms3/ikITnJr
         /v7g==
X-Gm-Message-State: AOJu0Yxv0G8Y8tBdMBaO9jLyMeYd9XV7yVoOPEG1ALMKJnVWDwMwsAjj
	DBY58+MEXFfQUA6qFC2Zz66UPkjGFw7wEp9yQvkzGOegg81eQ7rb
X-Google-Smtp-Source: AGHT+IEsRbK1r0WadtVwyzw9Qs758YoooTlrrYn/rJWPx1nZkHl2Sd2JqGkKJ2SsF32jRVKWPVecKQ==
X-Received: by 2002:a05:6a00:d42:b0:6dd:800f:87f6 with SMTP id n2-20020a056a000d4200b006dd800f87f6mr1319406pfv.27.1706493928277;
        Sun, 28 Jan 2024 18:05:28 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id k144-20020a628496000000b006dddd046e54sm4950581pfd.206.2024.01.28.18.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 18:05:27 -0800 (PST)
Message-ID: <ce7912c3-ee63-4f3c-a15a-cf32cb8be44e@gmail.com>
Date: Mon, 29 Jan 2024 10:05:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linus.walleij@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240123080637.1902578-1-ychuang570808@gmail.com>
 <20240123080637.1902578-5-ychuang570808@gmail.com>
 <a2a4bb76-0e6a-425d-bfb8-e1a844b44274@wanadoo.fr>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <a2a4bb76-0e6a-425d-bfb8-e1a844b44274@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Dear Christophe,

Thanks for your review.

In the next version, I will follow your suggestion and replace all instances
of devm_kzalloc() mentioned here with the use of devm_kcalloc().


Best Regards,
Jacky Huang


On 2024/1/28 下午 03:52, Christophe JAILLET wrote:
> Le 23/01/2024 à 09:06, Jacky Huang a écrit :
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add common pinctrl and GPIO driver for Nuvoton MA35 series SoC, and
>> add support for ma35d1 pinctrl.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>
> Hi,
>
> Should there be a v4, a few nits below.
>
> CJ
>
>> +static int ma35_pinctrl_dt_node_to_map_func(struct pinctrl_dev 
>> *pctldev,
>> +                        struct device_node *np,
>> +                        struct pinctrl_map **map,
>> +                        unsigned int *num_maps)
>> +{
>> +    struct ma35_pinctrl *npctl = pinctrl_dev_get_drvdata(pctldev);
>> +    struct ma35_pin_group *grp;
>> +    struct pinctrl_map *new_map;
>> +    struct device_node *parent;
>> +    int map_num = 1;
>> +    int i;
>> +
>> +    /*
>> +     * first find the group of this node and check if we need create
>> +     * config maps for pins
>> +     */
>> +    grp = ma35_pinctrl_find_group_by_name(npctl, np->name);
>> +    if (!grp) {
>> +        dev_err(npctl->dev, "unable to find group for node %s\n", 
>> np->name);
>> +        return -EINVAL;
>> +    }
>> +
>> +    map_num += grp->npins;
>> +    new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num, 
>> GFP_KERNEL);
>
> devm_kcalloc()?
>
>> +    if (!new_map)
>> +        return -ENOMEM;
>> +
>> +    *map = new_map;
>> +    *num_maps = map_num;
>> +    /* create mux map */
>> +    parent = of_get_parent(np);
>> +    if (!parent) {
>> +        devm_kfree(pctldev->dev, new_map);
>> +        return -EINVAL;
>> +    }
>> +
>> +    new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
>> +    new_map[0].data.mux.function = parent->name;
>> +    new_map[0].data.mux.group = np->name;
>> +    of_node_put(parent);
>> +
>> +    new_map++;
>> +    for (i = 0; i < grp->npins; i++) {
>> +        new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
>> +        new_map[i].data.configs.group_or_pin = pin_get_name(pctldev, 
>> grp->pins[i]);
>> +        new_map[i].data.configs.configs = grp->settings[i].configs;
>> +        new_map[i].data.configs.num_configs = 
>> grp->settings[i].nconfigs;
>> +    }
>> +    dev_dbg(pctldev->dev, "maps: function %s group %s num %d\n",
>> +        (*map)->data.mux.function, (*map)->data.mux.group, map_num);
>> +
>> +    return 0;
>> +}
>
> ...
>
>> +static int ma35_pinctrl_parse_groups(struct device_node *np, struct 
>> ma35_pin_group *grp,
>> +                     struct ma35_pinctrl *npctl, u32 index)
>> +{
>> +    unsigned long *configs;
>> +    unsigned int nconfigs;
>> +    struct ma35_pin_setting *pin;
>> +    const __be32 *list;
>> +    int i, j, size, ret;
>> +
>> +    dev_dbg(npctl->dev, "group(%d): %s\n", index, np->name);
>> +
>> +    grp->name = np->name;
>> +
>> +    ret = pinconf_generic_parse_dt_config(np, NULL, &configs, 
>> &nconfigs);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /*
>> +     * the binding format is nuvoton,pins = <bank pin-mfp 
>> pin-function>,
>> +     * do sanity check and calculate pins number
>> +     */
>> +    list = of_get_property(np, "nuvoton,pins", &size);
>> +    size /= sizeof(*list);
>> +    if (!size || size % 3) {
>> +        dev_err(npctl->dev, "wrong setting!\n");
>> +        return -EINVAL;
>> +    }
>> +    grp->npins = size / 3;
>> +
>> +    grp->pins = devm_kzalloc(npctl->dev, grp->npins * 
>> sizeof(*grp->pins), GFP_KERNEL);
>
> devm_kcalloc()?
>
>> +    if (!grp->pins)
>> +        return -ENOMEM;
>> +
>> +    grp->settings = devm_kzalloc(npctl->dev, grp->npins * 
>> sizeof(*grp->settings), GFP_KERNEL);
>
> devm_kcalloc()?
>
>> +    if (!grp->settings)
>> +        return -ENOMEM;
>> +
>> +    pin = grp->settings;
>> +
>> +    for (i = 0, j = 0; i < size; i += 3, j++) {
>> +        pin->offset = be32_to_cpu(*list++) * 
>> MA35_MFP_REG_SZ_PER_BANK + MA35_MFP_REG_BASE;
>> +        pin->shift = (be32_to_cpu(*list++) * MA35_MFP_BITS_PER_PORT) 
>> % 32;
>> +        pin->muxval = be32_to_cpu(*list++);
>> +        pin->configs = configs;
>> +        pin->nconfigs = nconfigs;
>> +        grp->pins[j] = npctl->info->get_pin_num(pin->offset, 
>> pin->shift);
>> +        pin++;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int ma35_pinctrl_parse_functions(struct device_node *np, 
>> struct ma35_pinctrl *npctl,
>> +                    u32 index)
>> +{
>> +    struct device_node *child;
>> +    struct ma35_pin_func *func;
>> +    struct ma35_pin_group *grp;
>> +    static u32 grp_index;
>> +    u32 ret, i = 0;
>> +
>> +    dev_dbg(npctl->dev, "parse function(%d): %s\n", index, np->name);
>> +
>> +    func = &npctl->functions[index];
>> +    func->name = np->name;
>> +    func->ngroups = of_get_child_count(np);
>> +
>> +    if (func->ngroups <= 0)
>> +        return 0;
>> +
>> +    func->groups = devm_kzalloc(npctl->dev, func->ngroups * 
>> sizeof(char *), GFP_KERNEL);
>
> devm_kcalloc()?
>
>> +    if (!func->groups)
>> +        return -ENOMEM;
>> +
>> +    for_each_child_of_node(np, child) {
>> +        func->groups[i] = child->name;
>> +        grp = &npctl->groups[grp_index++];
>> +        ret = ma35_pinctrl_parse_groups(child, grp, npctl, i++);
>> +        if (ret) {
>> +            of_node_put(child);
>> +            return ret;
>> +        }
>> +    }
>> +    return 0;
>> +}
>


