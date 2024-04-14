Return-Path: <linux-kernel+bounces-144001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C58A409D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B11281D91
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91491CA87;
	Sun, 14 Apr 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9OpL61s"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940A1C290
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713075909; cv=none; b=XnLlEJACcGhUC/dvf1FwQlqXWbDHYmJd7Yp6S/qwhTv7mADDGY6Fw3owQFVvFVS5sRSIsIw7oJNHE/khER0tHrVUv2bfkTATlV4nie0ujAQ918qyCXclv8a0rCG8NtUgrKKWzk8LsdMrywTCeBtaA/d0IJhYyxusZBLySisEO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713075909; c=relaxed/simple;
	bh=fgxHtb/5CHFFT/bsZ5y6bjmR0xlX39z2vR+5tdsWpak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o2cls5aTZP+WX4KmUyuj4aQOb82TYyrEnzDoQSZr9SuFJuZbQbQ5jgIOYHuikQxKnkgRQudz7QBVhJd88JF18FT65loKxLsEj1G0EYkNWLLvrYUexdkBPH3Sw33oiPlveuN4jjhiUb9lKcpmxDIyIsRKh+RfLAvUe/EoEuuBuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9OpL61s; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so3505536a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713075906; x=1713680706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u/LWT/+84euic85Ih6MoO5wP5ADqT6fgnDeoK7fefwY=;
        b=Y9OpL61sBAN+DYeY11J7JwuBLwgqgH3MHWJBVoSY3QftlMfS5vErQEM0Wu3pzR6Pzo
         juMB6RpJ3jggNd41x3qOIJ3Ftf1dZVMsHPBm7EbxtVvAdz33vq/ozyP+DlS3b/raWH4+
         eSkO1K4DwyTTBnuhEqsrT6mE18KopgETfkVaGTPBrtYSFJKYw44E5irkdfN9JoG80YRD
         K8gnthXn8a9Qf0ySGHQsSs54fHE79KSsz0Ni6BMXvqogPgXk3kdM+NEvOKPKov8cyAYf
         Mef8bdkQZ/9CHQcqRnu1/NbhBWsJG9u+1SNM/ZzvXbFgDDPkuItbZlz39q9UAG0FHgKK
         fMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713075906; x=1713680706;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/LWT/+84euic85Ih6MoO5wP5ADqT6fgnDeoK7fefwY=;
        b=l7GdDQjtHupPR86IT5GnrKY10q8InUBH3x+U09z6velzSyYWBnOlx+9d9AP2wZisro
         1K64Vy0eMHt9XInRVVpjC0nQZkDaFQGC/UB+Jm/mmLevYoA4ZhRSe6xejBu3I/vc90Gj
         muTXWBJTGp/4Dg5sT8w6FW+zS7aLV38GXwR5cD3tIIfClZ6mxdwGmNSrn+bHak+C2V9D
         9Mn44Qsg8WM2AxlmVMeAQSrdZFgtizRXPyiqijcB8IsLfLVGSa26eUIa4Eawd+nSvEOh
         ypSvC4HIGQZttMUgzyLp9Jl4Ta3UISITl4gngCUGPqMWGLH2sb8C9AY63+pHsPY5VOV/
         ujnw==
X-Forwarded-Encrypted: i=1; AJvYcCUavQPYkkidQ41YTTLPGmbJSuiCmEJGYgwBSV+CtYAUNJBIwVdLuA+vx1L1pqKkxe5m0n1/rQr/XVym30Ax/+7cWSh6jYHkeab/J9pI
X-Gm-Message-State: AOJu0YxutsJE3w0SbKt3lJWLqq7//ygqGhOErTTLKf6ig6pffc/PPS7d
	qdWm8cH+yvfL/mIt/87jLP50tfLv+pBTbJbDCaPgP5fEidU7ZH0SAJr5jfYV6Zw=
X-Google-Smtp-Source: AGHT+IF2rO7bpFlt1tuC/ZxBAgzkzfXXnp+rcf4jvvRnSPP/wXVgHC17G1sOEk1odOTpWtBwPVJSyg==
X-Received: by 2002:a17:906:71c7:b0:a52:3874:63bf with SMTP id i7-20020a17090671c700b00a52387463bfmr4079477ejk.59.1713075906113;
        Sat, 13 Apr 2024 23:25:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x13-20020a170906b08d00b00a51d073da7esm3818081ejy.82.2024.04.13.23.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 23:25:05 -0700 (PDT)
Message-ID: <0b006463-750a-40ad-8deb-4f1d43ecc102@linaro.org>
Date: Sun, 14 Apr 2024 08:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mmc: sdhci-brcmstb: Add BCM2712 support
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
 <7a75876def65f6282b7b3ca17ef8008c305d6c32.1713036964.git.andrea.porta@suse.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7a75876def65f6282b7b3ca17ef8008c305d6c32.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2024 00:14, Andrea della Porta wrote:
> Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
> register block present on other STB chips. Add support for BCM2712
> SD capabilities of this chipset.
> The silicon is SD Express capable but this driver port does not currently
> include that feature yet.
> Based on downstream driver by raspberry foundation maintained kernel.

DTS and parts of this code look like you just send to us downstream
code. Upstreaming does not work like this. Please consult your folks in
Suse to explain you more how upstreaming process looks like.

> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 130 +++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 9053526fa212..907a4947abe5 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -12,6 +12,8 @@
>  #include <linux/of.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
> @@ -30,15 +32,31 @@
>  
>  #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>  
> +#define SDIO_CFG_CTRL				0x0
> +#define  SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
> +#define  SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
> +
> +#define SDIO_CFG_SD_PIN_SEL			0x44
> +#define  SDIO_CFG_SD_PIN_SEL_MASK		0x3
> +#define  SDIO_CFG_SD_PIN_SEL_SD			BIT(1)
> +#define  SDIO_CFG_SD_PIN_SEL_MMC		BIT(0)
> +
> +#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
> +#define  SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
> +#define  SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
> +
>  struct sdhci_brcmstb_priv {
>  	void __iomem *cfg_regs;
>  	unsigned int flags;
>  	struct clk *base_clk;
>  	u32 base_freq_hz;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pins_default;
>  };
>  
>  struct brcmstb_match_priv {
>  	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
> +	void (*cfginit)(struct sdhci_host *host);
>  	struct sdhci_ops *ops;
>  	const unsigned int flags;
>  };
> @@ -124,6 +142,42 @@ static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
>  	writel(reg, host->ioaddr + SDHCI_VENDOR);
>  }
>  
> +static void sdhci_bcm2712_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +	u32 reg;
> +	bool is_emmc_rate = false;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	host->mmc->actual_clock = 0;
> +
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	switch (host->mmc->ios.timing) {
> +	case MMC_TIMING_MMC_HS400:
> +	case MMC_TIMING_MMC_HS200:
> +	case MMC_TIMING_MMC_DDR52:
> +	case MMC_TIMING_MMC_HS:
> +	is_emmc_rate = true;
> +	break;
> +	}

That's not indented correctly.

> +
> +	reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_SD_PIN_SEL);
> +	reg &= ~SDIO_CFG_SD_PIN_SEL_MASK;
> +	if (is_emmc_rate)
> +		reg |= SDIO_CFG_SD_PIN_SEL_MMC;
> +	else
> +		reg |= SDIO_CFG_SD_PIN_SEL_SD;
> +	writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_SD_PIN_SEL);
> +
> +	if (clock == 0)
> +		return;
> +
> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +	sdhci_enable_clk(host, clk);
> +}
> +
>  static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	u16 clk;
> @@ -139,6 +193,17 @@ static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
>  	sdhci_enable_clk(host, clk);
>  }
>  
> +static void sdhci_brcmstb_set_power(struct sdhci_host *host, unsigned char mode,
> +				  unsigned short vdd)
> +{
> +	if (!IS_ERR(host->mmc->supply.vmmc)) {
> +		struct mmc_host *mmc = host->mmc;
> +
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +	}
> +	sdhci_set_power_noreg(host, mode, vdd);
> +}
> +
>  static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
>  					    unsigned int timing)
>  {
> @@ -168,6 +233,36 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
>  
> +static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 uhs_mask = (MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104);
> +	u32 hsemmc_mask = (MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS200_1_2V_SDR |
> +			   MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V);
> +	u32 reg;
> +
> +	/*
> +	* If we support a speed that requires tuning,
> +	* then select the delay line PHY as the clock source.
> +	*/
> +	if ((host->mmc->caps & uhs_mask) || (host->mmc->caps2 & hsemmc_mask)) {
> +		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> +		reg &= ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
> +		reg |= SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
> +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> +	}
> +
> +	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
> +	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
> +		/* Force presence */
> +		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> +		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
> +		reg |= SDIO_CFG_CTRL_SDCD_N_TEST_EN;
> +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> +	}
> +}
> +
>  static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
>  {
>  	sdhci_dumpregs(mmc_priv(mmc));
> @@ -200,6 +295,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>  
> +static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
> +	.set_clock = sdhci_bcm2712_set_clock,
> +	.set_power = sdhci_brcmstb_set_power,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
>  static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>  	.set_clock = sdhci_brcmstb_set_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> @@ -237,7 +340,13 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
>  	.ops = &sdhci_brcmstb_ops_74165b0,
>  };
>  
> +static const struct brcmstb_match_priv match_priv_2712 = {
> +	.cfginit = sdhci_brcmstb_cfginit_2712,
> +	.ops = &sdhci_brcmstb_ops_2712,
> +};
> +
>  static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
> +	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
>  	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
>  	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
>  	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
> @@ -314,11 +423,16 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	struct sdhci_brcmstb_priv *priv;
>  	u32 actual_clock_mhz;
>  	struct sdhci_host *host;
> +	bool no_pinctrl = false;
>  	struct clk *clk;
>  	struct clk *base_clk = NULL;
>  	int res;
>  
>  	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
> +	if (!match) {

Why? This is not explained. Please do not add random pieces of code,
just because downstream code makes mistakes. This should go otherway -
downstream should be fixed, not upstream get downstream mistakes.

> +		dev_err(&pdev->dev, "fail to get matching of_match struct\n");
> +		return -EINVAL;
> +	}
>  	match_priv = match->data;
>  
>  	dev_dbg(&pdev->dev, "Probe found match for %s\n",  match->compatible);
> @@ -354,6 +468,19 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	if (res)
>  		goto err;
>  
> +	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(priv->pinctrl)) {
> +			no_pinctrl = true;
> +	}
> +	priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
> +	if (IS_ERR(priv->pins_default)) {
> +			dev_dbg(&pdev->dev, "No pinctrl default state\n");
> +			no_pinctrl = true;
> +	}
> +
> +	if (no_pinctrl )
> +		priv->pinctrl = NULL;
> +
>  	/*
>  	 * Automatic clock gating does not work for SD cards that may
>  	 * voltage switch so only enable it for non-removable devices.
> @@ -370,6 +497,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
>  		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
>  
> +	if(match_priv->cfginit)

Not conforming to Linux coding style.

Best regards,
Krzysztof


