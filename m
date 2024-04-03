Return-Path: <linux-kernel+bounces-129192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2908966C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CB61F28A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC075D477;
	Wed,  3 Apr 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jElEjLkW"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D845F5B20F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129921; cv=none; b=HE7iYxfTgEjwzRVF5oW2HFfsov+jLxbaiVhyAcBFhyzMmQCUBJO5m8Tk0atyCYfW2mM054WrBoM75OeyYCtQ4PtLTf3yOl7rhO4ZdDm2Rj8vEDoP9QEHjnOhXNWBN1jyko1wj2+DlZqZzQs54MfhmT52vt3DFDL6fMCYWAxE5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129921; c=relaxed/simple;
	bh=t+afcddS67LgVDqa57/Lx+qG4wnPMeLDKqP7d8TGrYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWRRxZbUJAtn84jBxXhfvZ5t5rLpjCZDmALSkQTcDFiXYyVGy+1xC3ZqDB+fsggE9r7wjk9ncogYThZ05KW9mgs+In6rJodbswHRca/9WjVIY5GyHpiPCjxZc4P5NKPxQr+2sGqIMtwiwcnTg8S2/WZS260aQW4KMTIDTDYfSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jElEjLkW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-515a81928faso7437364e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129918; x=1712734718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UV7x4SdrFhgJGHP0b6yiQFBbxHGCZCUrIpXiA3P3DU=;
        b=jElEjLkW9OHvWXt4zAOajf0PApZ7DihvY+7GEvsfIBfq5LGUkth62rJyzTt9O81Ogi
         Czt0ag29Mp+ETsyA1TNeR4njkCaG+gX6bhqzMoL7TjEApnS+uvK4z3l+3hGuVscXgKcz
         qJvesXqhfzgLFFWy1k8e7tmZXRpY7wo97hc2UuM7gQn9RnNlyQ8u8r9A07rIxBfcckYD
         QxSXsF+vevwLAfz1k9/lv0BzkRlcBDiYiBaDZOsUYW+2r/UOEXZ3tL+93K09UqVq15FK
         WyEf0sR4gQP/6JoIEi7kenG1XcpNFwGVfTPTvw21iJAa89E1HlEb46HEC9i/XiE3dj3p
         wjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129918; x=1712734718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UV7x4SdrFhgJGHP0b6yiQFBbxHGCZCUrIpXiA3P3DU=;
        b=s96qzDTkicHjt3xAkEU0Vo8urOpJo+e6aZqxg/vt7dCMCf6cjpVPkfcnw5+cotfZR6
         xTNXFyQfQWWnStiPolVL8k+chTcaPHz9MjZsW0vva0Av1XF//gjdpjR0BJGBabOhedMD
         La2Zof6wSoDexoqC7QjoiedZTuquM0plGEV0hdQqt4zmqKQ4IA9jYPIUHkmWpAsvUC+v
         wesNkODPNS0PvcNK/hKqaPYH5US+DE8Iamqo1DsZAgD41RQ6qBJVIo4RiLplSs9ewKAh
         sP6koRFyQo8hwA/GB2rVwm0S6Gj949MD6tVLD/RgBtYuup9m6e0y1GZ/Q2L1zgeLZ7Hg
         XGfA==
X-Forwarded-Encrypted: i=1; AJvYcCVHrXzA2QdO8zKbUECmxJ/e6zltAMgUs3U8t/c/YpQmxVs7gSfDW0KruM5DGCVrqldffM70qhh/ZDmuzW+1QJPd00CVHLkB4pv0e+nb
X-Gm-Message-State: AOJu0YzFXWm7ndyAj5uG7eaySNCWvJOgxhWYqA84JEaca6yaUPfeAWDQ
	Np1WF1XDnjWjY2A3YAdy7yxrzJ2vA9HIB6sKCcxL5DQ2I3z2amar
X-Google-Smtp-Source: AGHT+IGwg3KxlWo+vqMlSAalmRTd1OOuVtKAAk4v+coLUVtGzRbJrbbHAC0b9gwxJJ9zhRNutyuwAA==
X-Received: by 2002:a05:6512:39c3:b0:515:c190:140f with SMTP id k3-20020a05651239c300b00515c190140fmr1621468lfu.14.1712129917545;
        Wed, 03 Apr 2024 00:38:37 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x27-20020ac2489b000000b00513c334b2fcsm1937257lfc.141.2024.04.03.00.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:38:37 -0700 (PDT)
Message-ID: <e0d760d7-5408-47b8-b204-7900bcd9c608@gmail.com>
Date: Wed, 3 Apr 2024 10:38:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] regulator: bd96801: ROHM BD96801 PMIC regulators
Content-Language: en-US, en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <3a6839e2663bd064100af41f6df0cace746cf2e4.1712058690.git.mazziesaccount@gmail.com>
 <9d302a8a-a8bf-4a26-b1fb-44db6a5f5eac@kernel.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <9d302a8a-a8bf-4a26-b1fb-44db6a5f5eac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi dee Ho Krzysztof,

Heading to the Seattle? If so - Enjoy! It's a bummer I'm not able to 
share a beer with you in ELC this time.

On 4/2/24 19:14, Krzysztof Kozlowski wrote:
> On 02/04/2024 15:10, Matti Vaittinen wrote:
>> The ROHM BD96801 "Scalable PMIC" is an automotive grade PMIC which can
>> scale to different applications by allowing chaining of PMICs. The PMIC
>> also supports various protection features which can be configured either
>> to fire IRQs - or to shut down power outputs when failure is detected.
>>
> 
> ...
> 
>> +
>> +static int initialize_pmic_data(struct device *dev,
>> +				struct bd96801_pmic_data *pdata)
>> +{
>> +	int r, i;
>> +
>> +	*pdata = bd96801_data;
>> +
>> +	/*
>> +	 * Allocate and initialize IRQ data for all of the regulators. We
>> +	 * wish to modify IRQ information independently for each driver
>> +	 * instance.
>> +	 */
>> +	for (r = 0; r < BD96801_NUM_REGULATORS; r++) {
>> +		const struct bd96801_irqinfo *template;
>> +		struct bd96801_irqinfo *new;
>> +		int num_infos;
>> +
>> +		template = pdata->regulator_data[r].irq_desc.irqinfo;
>> +		num_infos = pdata->regulator_data[r].irq_desc.num_irqs;
>> +
>> +		new = devm_kzalloc(dev, num_infos * sizeof(*new), GFP_KERNEL);
> 
> Aren't you open coding devm_kcalloc?

I think yes. Thanks.

>> +		if (!new)
>> +			return -ENOMEM;
>> +
>> +		pdata->regulator_data[r].irq_desc.irqinfo = new;
>> +
>> +		for (i = 0; i < num_infos; i++)
>> +			new[i] = template[i];
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
> 
> ...
> 
>> +static int bd96801_probe(struct platform_device *pdev)
>> +{
>> +	struct device *parent;
>> +	int i, ret, irq;
>> +	void *retp;
>> +	struct regulator_config config = {};
>> +	struct bd96801_regulator_data *rdesc;
>> +	struct bd96801_pmic_data *pdata;
>> +	struct regulator_dev *ldo_errs_rdev_arr[BD96801_NUM_LDOS];
>> +	int ldo_errs_arr[BD96801_NUM_LDOS];
>> +	int temp_notif_ldos = 0;
>> +	struct regulator_dev *all_rdevs[BD96801_NUM_REGULATORS];
>> +	bool use_errb;
>> +
>> +	parent = pdev->dev.parent;
>> +
>> +	pdata = devm_kzalloc(&pdev->dev, sizeof(bd96801_data), GFP_KERNEL);
> 
> This and assignment in initialize_pmic_data() could be probably
> devm_kmemdup() which would be a bit more obvious for the reader.

I think you're right.

>> +	if (!pdata)
>> +		return -ENOMEM;
>> +
>> +	if (initialize_pmic_data(&pdev->dev, pdata))
>> +		return -ENOMEM;
>> +
>> +	pdata->regmap = dev_get_regmap(parent, NULL);
>> +	if (!pdata->regmap) {
>> +		dev_err(&pdev->dev, "No register map found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rdesc = &pdata->regulator_data[0];
>> +
>> +	config.driver_data = pdata;
>> +	config.regmap = pdata->regmap;
>> +	config.dev = parent;
>> +
>> +	ret = of_property_match_string(pdev->dev.parent->of_node,
>> +				       "interrupt-names", "errb");
> This does not guarantee that interrupts are properly set up.

Hmm. Yes, you're right. I'm not sure if I did think of this.

> Don't you
> have some state shared between parent and this device where you could
> mark that interrupts are OK?

There is currently no need to share/allocate any private data from the 
MFD. We get the regmap using dev_get_regmap, and interrupts using the 
platform_get_irq_byname(). Nothing else is shared between the MFD and 
sub-devices.

Considering the use of platform_get_irq_byname() - and how failures to 
get 'errb' IRQs are silently ignored in bd96801_global_errb_irqs() and
in bd96801_rdev_errb_irqs() - this check is just a slight optimization 
to not even try registering the errb IRQs if they're not found from the 
device tree. So, I think things do not really go south even if we go to 
"errb route" when the "errb" IRQs aren't successfully registered.

Whether this warrants a comment, or if this check is just unnecessarily 
complex can be pondered. Personally I think the purpose is pretty clear 
and thus the complexity is not added that much - but yes, a comment 
above call(s) to the platform_get_irq_byname() saying errb IRQs are not 
guaranteed to be populated might be justified.

> 
>> +	if (ret < 0)
>> +		use_errb = false;
>> +	else
>> +		use_errb = true;
>> +
> 
> ...
> 
>> +
>> +	if (use_errb)
>> +		return bd96801_global_errb_irqs(pdev, all_rdevs,
>> +						ARRAY_SIZE(all_rdevs));
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver bd96801_regulator = {
>> +	.driver = {
>> +		.name = "bd96801-pmic"
>> +	},
>> +	.probe = bd96801_probe,
>> +};
>> +
>> +module_platform_driver(bd96801_regulator);
>> +
>> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
>> +MODULE_DESCRIPTION("BD96801 voltage regulator driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:bd96801-pmic");
> 
> Just add platform device ID table with MODULE_DEVICE_TABLE(). You should
> not need MODULE_ALIAS() in normal cases. MODULE_ALIAS() is not a
> substitute for incomplete ID table.

I guess I have something to learn here. Thanks. :)

Take care
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


