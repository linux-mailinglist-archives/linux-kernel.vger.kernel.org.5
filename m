Return-Path: <linux-kernel+bounces-144252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B48A439C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B231F215CF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B8134CDC;
	Sun, 14 Apr 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XjW71lV5"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C4134CC7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713110021; cv=none; b=FErvNwOoO60KyDgXeCu4pnb2PxYa+G535P/39kN/ckHFyO3myCyQxayRMyPqjvgL8biX5ipT1EWPWGcpv1lC9bBQgaI9HaAVQF07107dmFgoPM2ysnfGWCgG7gvjvwhC66yVhYmoRO7GA0CBsmgXN97xmo8rPGLB1Mug1DQbOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713110021; c=relaxed/simple;
	bh=oghXr8N2ZGEG+8Q94vglMwjRqEByK2ZzGiNoRsnmL9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nXwV3Rn1SRuQOKUGiVuhWdFOR7gAkWFWxPTtE+b9ENbiOOsW24NwrEIz8c7oJWtg8Fb2iuUqdKHJ9ehCU1yR/0aSnHmmxXjAVoMo6GSHvAF/QAH4Fww/g39ReE3pqL/EHDpoQK9kr5EGzX2KaXSqYmDD1+fSZpvfYBGCsOJSmy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XjW71lV5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso2331891b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713110018; x=1713714818; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZ+UKcwPo/DHFQmKnZyKO8CQH7j9ol9bzvbQ2/YTxMg=;
        b=XjW71lV5TGNhUfVKtSaDRGqICFR7TOftKOD52YBum/Tz5vUt6Z5TuAsf5asZw22etd
         0cVGJYqLnnlzuiN0CnIk3YdCXzgFOLYsh/njHwMpAYa0Drf66QLca9Pws+zKTv1PG22m
         mcbqCzpnhqw+3eRH1btypIBbuq+/jMDlDpqw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713110018; x=1713714818;
        h=in-reply-to:autocrypt:from:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZ+UKcwPo/DHFQmKnZyKO8CQH7j9ol9bzvbQ2/YTxMg=;
        b=qOc1qoyjt/9k2wpqlq7ZZJH4LkeMx2a9MQp7mP1x6LlaAWHn3oljuZpYgIjsuYL5eB
         gnUiYF1kCh6zD4/n69LPGjtOTpCxZumYuCRcHvVtnf5vVoEwLXfrBuaByiPJmz1xuOcp
         0ATXYbSLZmn+xj0ll/LxfNnEXjwV0DH24AbmRUe4BvYAnyxMvxEu71ZQ8MPd9PxhIw4d
         Qlz9WtH5PNlJl+1na/Bst5hljGwj0n9vS/CnmxTtYmGB2IVL2VJtd7ejGxZA2lhSrT+v
         mRhu/iqMOPSzl/TpxD3W6uFCjJcSGIW5YbkWuFHO4ymOLf+IrLgkeJA067tVJSu7n2+S
         F+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVwYbb24yCqRmHqNq/9iVJjrP5MBd4Mr9r/dDtckqOkUj47m3zW6dTyGum9SKKSW4noqSzXUwi58r6rp194wpXeyT/KgZ9+dilMciLJ
X-Gm-Message-State: AOJu0YxVDRU6Wereyup6NVWtauOOq5audSNwAjsEhM8WCK2EX0RAliBI
	hKEcB2LDuaj94w0obUveZvTXBHFz/P+zaBfQ0ZX30Grr6BQdPsn4Kn6wskKm7A==
X-Google-Smtp-Source: AGHT+IHmbLMbqt296B3lrYLDx5qYsg67BZ2jWBC3+PUzMvUHacAVUwjVoMhyoI/kXFSWHHMxxoeHLQ==
X-Received: by 2002:a05:6a20:3209:b0:1a7:1e1c:3031 with SMTP id hl9-20020a056a20320900b001a71e1c3031mr8824475pzc.36.1713110017597;
        Sun, 14 Apr 2024 08:53:37 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z76-20020a63334f000000b005dc87f5dfcfsm5616241pgz.78.2024.04.14.08.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 08:53:36 -0700 (PDT)
Message-ID: <60e3fefc-1600-47f8-8bd5-b92dac56be2d@broadcom.com>
Date: Sun, 14 Apr 2024 08:53:32 -0700
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
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <7a75876def65f6282b7b3ca17ef8008c305d6c32.1713036964.git.andrea.porta@suse.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000163a1a06161082fc"

--000000000000163a1a06161082fc
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
> register block present on other STB chips. Add support for BCM2712
> SD capabilities of this chipset.
> The silicon is SD Express capable but this driver port does not currently
> include that feature yet.
> Based on downstream driver by raspberry foundation maintained kernel.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   drivers/mmc/host/sdhci-brcmstb.c | 130 +++++++++++++++++++++++++++++++
>   1 file changed, 130 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 9053526fa212..907a4947abe5 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -12,6 +12,8 @@
>   #include <linux/of.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/regulator/consumer.h>
>   
>   #include "sdhci-cqhci.h"
>   #include "sdhci-pltfm.h"
> @@ -30,15 +32,31 @@
>   
>   #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
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
>   struct sdhci_brcmstb_priv {
>   	void __iomem *cfg_regs;
>   	unsigned int flags;
>   	struct clk *base_clk;
>   	u32 base_freq_hz;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pins_default;
>   };
>   
>   struct brcmstb_match_priv {
>   	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
> +	void (*cfginit)(struct sdhci_host *host);
>   	struct sdhci_ops *ops;
>   	const unsigned int flags;
>   };
> @@ -124,6 +142,42 @@ static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
>   	writel(reg, host->ioaddr + SDHCI_VENDOR);
>   }
>   
> +static void sdhci_bcm2712_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +	u32 reg;
> +	bool is_emmc_rate = false;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);

Reverse christmas tree declaration please, longest lines first and 
shortest lines next.

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

Both lines are mis-aligned and requiren an additional tab.

> +	}
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
>   static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
>   {
>   	u16 clk;
> @@ -139,6 +193,17 @@ static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
>   	sdhci_enable_clk(host, clk);
>   }
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
>   static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
>   					    unsigned int timing)
>   {
> @@ -168,6 +233,36 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
>   	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>   }
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
>   static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
>   {
>   	sdhci_dumpregs(mmc_priv(mmc));
> @@ -200,6 +295,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
>   	.set_uhs_signaling = sdhci_set_uhs_signaling,
>   };
>   
> +static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
> +	.set_clock = sdhci_bcm2712_set_clock,
> +	.set_power = sdhci_brcmstb_set_power,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
>   static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>   	.set_clock = sdhci_brcmstb_set_clock,
>   	.set_bus_width = sdhci_set_bus_width,
> @@ -237,7 +340,13 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
>   	.ops = &sdhci_brcmstb_ops_74165b0,
>   };
>   
> +static const struct brcmstb_match_priv match_priv_2712 = {
> +	.cfginit = sdhci_brcmstb_cfginit_2712,
> +	.ops = &sdhci_brcmstb_ops_2712,
> +};
> +
>   static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
> +	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
>   	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
>   	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
>   	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
> @@ -314,11 +423,16 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   	struct sdhci_brcmstb_priv *priv;
>   	u32 actual_clock_mhz;
>   	struct sdhci_host *host;
> +	bool no_pinctrl = false;
>   	struct clk *clk;
>   	struct clk *base_clk = NULL;
>   	int res;
>   
>   	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
> +	if (!match) {
> +		dev_err(&pdev->dev, "fail to get matching of_match struct\n");
> +		return -EINVAL;
> +	}
>   	match_priv = match->data;
>   
>   	dev_dbg(&pdev->dev, "Probe found match for %s\n",  match->compatible);
> @@ -354,6 +468,19 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   	if (res)
>   		goto err;
>   
> +	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(priv->pinctrl)) {
> +			no_pinctrl = true;

One too many tabs here.

> +	}
> +	priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
> +	if (IS_ERR(priv->pins_default)) {
> +			dev_dbg(&pdev->dev, "No pinctrl default state\n");
> +			no_pinctrl = true;

One too many tabs here.

Please just run checkpatch on your patches, thanks.
-- 
Florian

--000000000000163a1a06161082fc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIM/ZziCrbwHNKXg5
85Z68G46ruWuf8L2ygaY4pfNfuMHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDQxNDE1NTMzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDhAMCwd1/e7LHJc9MxdgQKrxbGQ8dwWx/V
nBYtYBa/3TPRU2AdrdOsfx1sHokzJQny1wVfOOvYS1q8JPvZt7AlpABwhzkwH8qsxy1J6/dLHMjd
W2MTu/vtGwvB2g/HUrXJvW+JPWKxF3kPOpEINed+PDbnbdAaZQ3gCw6FqVwIboQprmUhooLhCUeH
tSoQ/U3SgkOwOnZXVWhPqABZ4PSpMJcY5ItV8etPsaibRtzO80osJhHBAL2OHjC3rEVaDxCVovJo
sdCu/xPSagOxS4xFlUhI3qV43gn2X2VnLh+CHIwPTLbBeaAOWBarPXiGECLo1XW7SSGNCAM9VNuw
/+Dy
--000000000000163a1a06161082fc--

