Return-Path: <linux-kernel+bounces-144022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D518A40EF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC261C20BB1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05EB208A7;
	Sun, 14 Apr 2024 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="chUpjni5"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59A1C6A8;
	Sun, 14 Apr 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713079740; cv=none; b=Y7tQV6CSEh4IhKaYjPdq5pOStOuHg/CnKOaKApSwYhqJM8Qch2UAcsYA/B1WbZo0gvF4mRYBBcefgYdRYGLlRaCHdCOzz8h08vEj9nKT20g1KCMXOE8TBc8hnLj4Zg5iin1E9EsgfxxWDRXiz/mPLU2bgcS3KoX0RA4fXm72tuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713079740; c=relaxed/simple;
	bh=zxDtmr9cEt3OU2v2d+Z08dqlldGrpRufndtqdNYKnlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=LYT17mmCiLd6/xUf2U0wYnBp4rj8Mapv87IC6zQLFEv6h66wZ1/t4X+0a9lcpzj4FKmgwAVNfFAyFxKpenlm0A8/hXjZtaoK4PyQOHSa8NHU1rYOq3Qp/Sgjrf+DfPBV5ufWgMHsQCu5aF+q/fd0xKke0ZX4JySDSsD0TpgZUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=chUpjni5; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vuIGrbbZtReGpvuIHrYJio; Sun, 14 Apr 2024 09:28:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713079735;
	bh=sg8mnWXtf9g5Ie61S+7ZWPXichK4YHH1B5BtmQzPcp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=chUpjni5ug14LifuErcTbkLCzLte4FPuoL4pJlu6lKeTCoAD+Y7Z1FTsMVx66miFQ
	 VXWAxiwsaBWgHXkWWLLoesvYPoweacr23nndBiVD9QMrcc89XDLoGc48HrjCER2AM5
	 VQnoejJQNVXlacqGEObUyhb1bN7boe8gX1L7uYN7TdipijICiRhlfwVtD/OdE8H88x
	 Nq/x2Iq/Uzfy4pq9qjAaNDVzkCN8lNj7UsyGjCQKUBJc+PJyB1xmMg8uO7UzTay4+q
	 WK4KXkbAKEVg1uwFVmvfnht2k44JQMorfe3Cdi4m20HKRQMtYKe2v8oxl8nZxfVqD/
	 sQjtNZ0w+wFjA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 09:28:55 +0200
X-ME-IP: 86.243.17.157
Message-ID: <059f414d-096e-4a45-bde5-d984fddf96b6@wanadoo.fr>
Date: Sun, 14 Apr 2024 09:28:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mmc: sdhci-brcmstb: Add BCM2712 support
To: Andrea della Porta <andrea.porta@suse.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <7a75876def65f6282b7b3ca17ef8008c305d6c32.1713036964.git.andrea.porta@suse.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: adrian.hunter@intel.com, alcooperx@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, florian.fainelli@broadcom.com,
 jonathan@raspberrypi.com, kamal.dasu@broadcom.com,
 krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 phil@raspberrypi.com, robh@kernel.org, ulf.hansson@linaro.org
In-Reply-To: <7a75876def65f6282b7b3ca17ef8008c305d6c32.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/04/2024 à 00:14, Andrea della Porta a écrit :
> Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
> register block present on other STB chips. Add support for BCM2712
> SD capabilities of this chipset.
> The silicon is SD Express capable but this driver port does not currently
> include that feature yet.
> Based on downstream driver by raspberry foundation maintained kernel.
> 
> Signed-off-by: Andrea della Porta <andrea.porta-IBi9RG/b67k@public.gmane.org>
> ---
>   drivers/mmc/host/sdhci-brcmstb.c | 130 +++++++++++++++++++++++++++++++
>   1 file changed, 130 insertions(+)

..

> +static void sdhci_brcmstb_set_power(struct sdhci_host *host, unsigned char mode,
> +				  unsigned short vdd)
> +{
> +	if (!IS_ERR(host->mmc->supply.vmmc)) {
> +		struct mmc_host *mmc = host->mmc;

This would look nicer if mmc was defined at the beginning of the 
function and used in the if (!IS_ERR()) test.

> +
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +	}
> +	sdhci_set_power_noreg(host, mode, vdd);
> +}
> +
>   static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
>   					    unsigned int timing)
>   {
> @@ -168,6 +233,36 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
>   	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>   }

..

> @@ -354,6 +468,19 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   	if (res)
>   		goto err;
>   
> +	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(priv->pinctrl)) {
> +			no_pinctrl = true;
> +	}

Indentation looks to large here.
No need to { }

> +	priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
> +	if (IS_ERR(priv->pins_default)) {
> +			dev_dbg(&pdev->dev, "No pinctrl default state\n");
> +			no_pinctrl = true;

Indentation looks to large here.

> +	}
> +
> +	if (no_pinctrl )
> +		priv->pinctrl = NULL;
> +
>   	/*
>   	 * Automatic clock gating does not work for SD cards that may
>   	 * voltage switch so only enable it for non-removable devices.

..


