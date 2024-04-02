Return-Path: <linux-kernel+bounces-128333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A587E895969
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C992C1C2134A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7714AD30;
	Tue,  2 Apr 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw2SRU1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757CE14AD1D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074479; cv=none; b=bpv9CkIPeT+mOSbMN7v1rSf/OBdpuqZanFscP+mlj5T6OzNStGej6ytRBmmuaZr6kmkt/rBn+Vlg6g5PdJ7Vkqs46yrsfpiDYUrqyLoQhYSM7eLfVPhTcSWjOgQ/pnZ7SSQDdrvV9JyPAwBYSvuiIR4wFXCzNKDArLyhH06H4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074479; c=relaxed/simple;
	bh=gyS4w7fTl56NdGVQKekpMW2uf40BBqJGE7Um5tPHirI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tN8A6wDDdsly21Yvc7qUu40MYyQaeeBcDxoYKtbbda0H/5HpqyUEc/CLwhvHuOS/9X95YOzijVPAbO7JqHprcR0kSjjeYFgHt9yb0oaeobYWKmxPmGLiCBVx4n+ZAhIfmwnupwO6PSCGp8gVuzfRb2juobF9jo1wGzxpg8IcebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw2SRU1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D97C433C7;
	Tue,  2 Apr 2024 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074479;
	bh=gyS4w7fTl56NdGVQKekpMW2uf40BBqJGE7Um5tPHirI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fw2SRU1uZN8Z3nY+IRQSgEKDDIobXn3BbsMLteS9XJomDo2OyViOEGJL30tDQkJjN
	 F4LfrJtodkILE9ezAqwupbMvmdaZbAh38TYfpCjVR/U2X4coe6WevckBRzc0sZQQqh
	 TWS7CZewBS4Eel+lN8WlRhLbfPy9kcm+/CvQuNbIDlaUYUt2Nfycs26445ieeuXdFO
	 lFwHJiW/180U14wm8cpdbyfEBYZea6kH7IF6Qwq6q0MK0LzmY/mNFVVr07+Lyq2Fst
	 tCVNMG96KXKE05xQw193yRz1yhSmVPZ/Ij5sB8ASOl2a0QSIth9nltnmLY5D46wLQr
	 JNOVh29+f+jHg==
Message-ID: <9d302a8a-a8bf-4a26-b1fb-44db6a5f5eac@kernel.org>
Date: Tue, 2 Apr 2024 18:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] regulator: bd96801: ROHM BD96801 PMIC regulators
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <3a6839e2663bd064100af41f6df0cace746cf2e4.1712058690.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <3a6839e2663bd064100af41f6df0cace746cf2e4.1712058690.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 15:10, Matti Vaittinen wrote:
> The ROHM BD96801 "Scalable PMIC" is an automotive grade PMIC which can
> scale to different applications by allowing chaining of PMICs. The PMIC
> also supports various protection features which can be configured either
> to fire IRQs - or to shut down power outputs when failure is detected.
> 

..

> +
> +static int initialize_pmic_data(struct device *dev,
> +				struct bd96801_pmic_data *pdata)
> +{
> +	int r, i;
> +
> +	*pdata = bd96801_data;
> +
> +	/*
> +	 * Allocate and initialize IRQ data for all of the regulators. We
> +	 * wish to modify IRQ information independently for each driver
> +	 * instance.
> +	 */
> +	for (r = 0; r < BD96801_NUM_REGULATORS; r++) {
> +		const struct bd96801_irqinfo *template;
> +		struct bd96801_irqinfo *new;
> +		int num_infos;
> +
> +		template = pdata->regulator_data[r].irq_desc.irqinfo;
> +		num_infos = pdata->regulator_data[r].irq_desc.num_irqs;
> +
> +		new = devm_kzalloc(dev, num_infos * sizeof(*new), GFP_KERNEL);

Aren't you open coding devm_kcalloc?

> +		if (!new)
> +			return -ENOMEM;
> +
> +		pdata->regulator_data[r].irq_desc.irqinfo = new;
> +
> +		for (i = 0; i < num_infos; i++)
> +			new[i] = template[i];
> +	}
> +
> +	return 0;
> +}
> +


..

> +static int bd96801_probe(struct platform_device *pdev)
> +{
> +	struct device *parent;
> +	int i, ret, irq;
> +	void *retp;
> +	struct regulator_config config = {};
> +	struct bd96801_regulator_data *rdesc;
> +	struct bd96801_pmic_data *pdata;
> +	struct regulator_dev *ldo_errs_rdev_arr[BD96801_NUM_LDOS];
> +	int ldo_errs_arr[BD96801_NUM_LDOS];
> +	int temp_notif_ldos = 0;
> +	struct regulator_dev *all_rdevs[BD96801_NUM_REGULATORS];
> +	bool use_errb;
> +
> +	parent = pdev->dev.parent;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(bd96801_data), GFP_KERNEL);

This and assignment in initialize_pmic_data() could be probably
devm_kmemdup() which would be a bit more obvious for the reader.

> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	if (initialize_pmic_data(&pdev->dev, pdata))
> +		return -ENOMEM;
> +
> +	pdata->regmap = dev_get_regmap(parent, NULL);
> +	if (!pdata->regmap) {
> +		dev_err(&pdev->dev, "No register map found\n");
> +		return -ENODEV;
> +	}
> +
> +	rdesc = &pdata->regulator_data[0];
> +
> +	config.driver_data = pdata;
> +	config.regmap = pdata->regmap;
> +	config.dev = parent;
> +
> +	ret = of_property_match_string(pdev->dev.parent->of_node,
> +				       "interrupt-names", "errb");
This does not guarantee that interrupts are properly set up. Don't you
have some state shared between parent and this device where you could
mark that interrupts are OK?

> +	if (ret < 0)
> +		use_errb = false;
> +	else
> +		use_errb = true;
> +

..

> +
> +	if (use_errb)
> +		return bd96801_global_errb_irqs(pdev, all_rdevs,
> +						ARRAY_SIZE(all_rdevs));
> +
> +	return 0;
> +}
> +
> +static struct platform_driver bd96801_regulator = {
> +	.driver = {
> +		.name = "bd96801-pmic"
> +	},
> +	.probe = bd96801_probe,
> +};
> +
> +module_platform_driver(bd96801_regulator);
> +
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("BD96801 voltage regulator driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:bd96801-pmic");

Just add platform device ID table with MODULE_DEVICE_TABLE(). You should
not need MODULE_ALIAS() in normal cases. MODULE_ALIAS() is not a
substitute for incomplete ID table.

Best regards,
Krzysztof


