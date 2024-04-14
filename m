Return-Path: <linux-kernel+bounces-144023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D28A40F3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF121F21419
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E32E208AD;
	Sun, 14 Apr 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="USN+2HSB"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA021D52D;
	Sun, 14 Apr 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713080084; cv=none; b=K8r+9TuiEwW4rtfRsQPcQia5lrEXb8JsdB3o8zeeua/IvsaX0mmrjIjFg1HdnyQf6QX7HLyiXdvnOyIU3dOv0vWg3wo1tNjduvigTeNhfSuY0gjv27cJkpP1A5rSp6xQ5jB9j1B6O+OhRrKdJ14zTV464V1Z13c6UDChc/fDqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713080084; c=relaxed/simple;
	bh=JqDEH4d03FYv1pbMhnBDI3uRW0/QRr0DbZrSbrdsEVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=T4qbcFPqxjKJJUjL1z6+3oyPkm5oGHMQ+h03djHysa4OfOvhRwOz4L5b/WL6eDos85uHI3ExtuMzJ3RKte655bM2SgFjjggK0avsnJfwJnkeMGwdoEyYiGHCq2weucz63Hyjs18S36oj4d4pu9dLnu6TyEwuWoWNdknl4RBjNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=USN+2HSB; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vuNirwhk0cHHHvuNirGmsW; Sun, 14 Apr 2024 09:34:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713080075;
	bh=w71WW/wIloXSDyf1TIRvwvHZz5mS+7JZkQXLMMZvJVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=USN+2HSBsNWhZLPjoWqdJNgs84SCD59R98KFZlHv1Y8oab0Qo3sWY9RRwciNnnn5/
	 ZQEZfg2ZEbsh9No6sfOtibyRbVZZDKU6SJJPMX97JjrJ/o465pgZRiRZiU0Depfwvh
	 xdmS67jZ8Jr9EwrZ3DBIHKBI37iVrHrJREmgCXFdYKBhu5plpXYsqjmxC1qq0bWJra
	 MCuDtGiecZ++3mJAOXhJ21HxJYJeaz4tln6KkEJXJ5K0Nd+Yi4V52hPdEJSAj49ias
	 zHvvAoTXxDJnbOPPESYBb1O7Y3/jAwkXRqMtY2QhliffhM3hZ4ANKasefkaTOAQsvA
	 VmAwcCq/qaFyg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 09:34:35 +0200
X-ME-IP: 86.243.17.157
Message-ID: <57f240af-7e99-4bc1-a2c5-415441aa5f0b@wanadoo.fr>
Date: Sun, 14 Apr 2024 09:34:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mmc: sdhci-brcmstb: Add BCM2712 SD Express support
To: Andrea della Porta <andrea.porta@suse.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <a3d82e5a28fe53f1f61621d37d1695b0cd7655d2.1713036964.git.andrea.porta@suse.com>
Content-Language: en-MW
Cc: adrian.hunter@intel.com, alcooperx@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, florian.fainelli@broadcom.com,
 jonathan@raspberrypi.com, kamal.dasu@broadcom.com,
 krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 phil@raspberrypi.com, robh@kernel.org, ulf.hansson@linaro.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <a3d82e5a28fe53f1f61621d37d1695b0cd7655d2.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/04/2024 à 00:14, Andrea della Porta a écrit :
> Broadcom BCM2712 SDHCI controller is SD Express capable. Add support
> for sde capability where the implementation is based on downstream driver,
> diverging from it in the way that init_sd_express callback is invoked:
> in downstream the sdhci_ops structure has been augmented with a new
> function ptr 'init_sd_express' that just propagate the call to the
> driver specific callback so that the callstack from a structure
> standpoint is mmc_host_ops -> sdhci_ops. The drawback here is in the
> added level of indirection (the newly added init_sd_express is
> redundant) and the sdhci_ops structure declaration has to be changed.
> To overcome this the presented approach consist in patching the mmc_host_ops
> init_sd_express callback to point directly to the custom function defined in
> this driver (see struct brcmstb_match_priv).
> 
> Signed-off-by: Andrea della Porta <andrea.porta-IBi9RG/b67k@public.gmane.org>
> ---
>   drivers/mmc/host/Kconfig         |   1 +
>   drivers/mmc/host/sdhci-brcmstb.c | 147 ++++++++++++++++++++++++++++++-
>   2 files changed, 147 insertions(+), 1 deletion(-)

..

> +	if (brcmstb_priv->sde_pcie) {
> +		struct of_changeset changeset;
> +		static struct property okay_property = {
> +			.name = "status",
> +			.value = "okay",
> +			.length = 5,
> +		};
> +
> +		/* Enable the pcie controller */
> +		of_changeset_init(&changeset);
> +		ret = of_changeset_update_property(&changeset,
> +						   brcmstb_priv->sde_pcie,
> +						   &okay_property);
> +		if (ret) {
> +			dev_err(dev, "%s: failed to update property - %d\n", __func__,
> +			       ret);
> +			return -ENODEV;
> +		}
> +		ret = of_changeset_apply(&changeset);
> +	}
> +
> +	dev_dbg(dev, "%s -> %d\n", __func__, ret);

Is this really useful?

> +	return ret;
> +}
> +

..

> @@ -468,6 +581,24 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   	if (res)
>   		goto err;
>   
> +	priv->sde_1v8 = devm_regulator_get_optional(&pdev->dev, "sde-1v8");
> +	if (IS_ERR(priv->sde_1v8))
> +		priv->flags &= ~BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS;
> +
> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	if (iomem) {
> +		priv->sde_ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> +		if (IS_ERR(priv->sde_ioaddr))
> +			priv->sde_ioaddr = NULL;
> +	}
> +
> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +	if (iomem) {
> +		priv->sde_ioaddr2 = devm_ioremap_resource(&pdev->dev, iomem);
> +		if (IS_ERR(priv->sde_ioaddr2))
> +			priv->sde_ioaddr = NULL;

sde_ioaddr2 ?

> +	}
> +
>   	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
>   	if (IS_ERR(priv->pinctrl)) {
>   			no_pinctrl = true;
> @@ -478,8 +609,16 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   			no_pinctrl = true;
>   	}
>   
> -	if (no_pinctrl )
> +	priv->pins_sdex = pinctrl_lookup_state(priv->pinctrl, "sd-express");
> +	if (IS_ERR(priv->pins_sdex)) {
> +			dev_dbg(&pdev->dev, "No pinctrl sd-express state\n");
> +			no_pinctrl = true;

Indentation looks too large.

> +	}
> +
> +	if (no_pinctrl || !priv->sde_ioaddr || !priv->sde_ioaddr2) {
>   		priv->pinctrl = NULL;
> +		priv->flags &= ~BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS;
> +	}
>   
>   	/*
>   	 * Automatic clock gating does not work for SD cards that may

..


