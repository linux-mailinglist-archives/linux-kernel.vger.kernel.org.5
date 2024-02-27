Return-Path: <linux-kernel+bounces-82876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D4868B02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90291C213F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3C130E2B;
	Tue, 27 Feb 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcMqdd3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7559537F4;
	Tue, 27 Feb 2024 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023408; cv=none; b=eQCnPMbB9Zs9wJvaejw4nTFKzmuj1IwxsFpmOCbiol7HjW1ZSuTetDQngVKVTBXnfCt7VJ0v01QqoWDLziDyrvaOn3IpINbBfjXDY1UqiOj6Gt3hsjI0Fv6PMnhmVlgiwepOY9B4Vg/jbUrnbJ9DF5juYWrHHBxfCvV39TJ8BX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023408; c=relaxed/simple;
	bh=KkjZlxJWUs7c4tYPSq2G1Kdsh9ppUbCW3OtyEF3z18U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W371/c2hdxsJuQAU5d71PggwdSqq9/xJUM/yOJpUIkRKRzZAK3d+NhmD4txCWn5WrW8oMsSmr3ekLUsulE6b/67GWy/EPWHlooTUSpdNmzH17nqI/qW/mFcbWVy69NvuZJ1+bnXushOmXWLBQ4fiNDO63/wDt3UatzP3mRPc2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcMqdd3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDAC433F1;
	Tue, 27 Feb 2024 08:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709023407;
	bh=KkjZlxJWUs7c4tYPSq2G1Kdsh9ppUbCW3OtyEF3z18U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TcMqdd3iYyWmhYovEcy0ISDQWBGrWRwU30++w91A2fS2dqYMD6v6h8O2dqHJlstq9
	 j4qtKF7yvzbzewTPc1rg10afLpw2wHgqq2wTdYq71gjBxnU7xqVRfpYL675CN/3Mpv
	 liaav8mmG39sbXXnqRWYolPljMXim3AN99IZ4lZitfBlk54w8fEXf4OSv79lADbZ6U
	 B43M8x5WOYn5bEql8uBiTwCY6Z0Zs9dz7WtLhGNBxz4zlfB+lSAaV1jIIkRi1lytmV
	 1eTmXn9fPPj/8kQX8jcvQ3P8PcbSPlyUzf8gwKpjeUpCrPOG6vlSNWmOqT5qEZQRtm
	 9eQPF8AGa4jxw==
Message-ID: <a5abf9d8-bd82-48a7-a762-2e5daaff0bb7@kernel.org>
Date: Tue, 27 Feb 2024 09:43:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] ASoc: mediatek: mt8365: Add a specific soundcard
 for EVK
To: amergnat@baylibre.com, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nicolas Belin <nbelin@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-10-4fa1cea1667f@baylibre.com>
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
In-Reply-To: <20240226-audio-i350-v1-10-4fa1cea1667f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 15:01, amergnat@baylibre.com wrote:
> From: Nicolas Belin <nbelin@baylibre.com>
> 
> Add a specific soundcard for mt8365-evk. It supports audio jack
> in/out, dmics, the amic and lineout.
> 
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>


..

> +static int mt8365_mt6357_dev_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = &mt8365_mt6357_card;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *platform_node;
> +	struct mt8365_mt6357_priv *priv;
> +	int i, ret;
> +
> +	card->dev = dev;
> +	ret = parse_dai_link_info(card);
> +	if (ret)
> +		goto err;
> +
> +	platform_node = of_parse_phandle(dev->of_node, "mediatek,platform", 0);
> +	if (!platform_node) {
> +		dev_err(dev, "Property 'platform' missing or invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < card->num_links; i++) {
> +		if (mt8365_mt6357_dais[i].platforms->name)
> +			continue;
> +		mt8365_mt6357_dais[i].platforms->of_node = platform_node;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(struct mt8365_mt6357_priv),
> +			    GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "%s allocate card private data fail %d\n",
> +			__func__, ret);

Don't print anything on memory allocations failures.

Run coccinelle/coccicheck to detect such trivial issues.

> +		return ret;
> +	}
> +
> +	snd_soc_card_set_drvdata(card, priv);
> +
> +	mt8365_mt6357_gpio_probe(card);
> +
> +	ret = devm_snd_soc_register_card(dev, card);
> +	if (ret)
> +		dev_err(dev, "%s snd_soc_register_card fail %d\n",
> +			__func__, ret);
> +err:
> +	of_node_put(platform_node);
> +	clean_card_reference(card);
> +	return ret;
> +}
> +
> +static const struct of_device_id mt8365_mt6357_dt_match[] = {
> +	{ .compatible = "mediatek,mt8365-mt6357", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mt8365_mt6357_dt_match);
> +
> +static struct platform_driver mt8365_mt6357_driver = {
> +	.driver = {
> +		   .name = "mt8365_mt6357",
> +		   .of_match_table = mt8365_mt6357_dt_match,
> +		   .pm = &snd_soc_pm_ops,
> +	},
> +	.probe = mt8365_mt6357_dev_probe,
> +};
> +
> +module_platform_driver(mt8365_mt6357_driver);
> +
> +/* Module information */
> +MODULE_DESCRIPTION("MT8365 EVK SoC machine driver");
> +MODULE_AUTHOR("Nicolas Belin <nbelin@baylibre.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("mt8365 mt6357 soc card");

This does not look like correct alias. Drop.

> 

Best regards,
Krzysztof


