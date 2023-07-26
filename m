Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD9763694
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjGZMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjGZMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:43:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4072A10D4;
        Wed, 26 Jul 2023 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690375368; x=1721911368;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=yb7UNFDUu3EthD0NoQF6eXkIYg2OLo/W18p29qdTVdc=;
  b=EBoRjg2gyg7M9R0LE2MRe2cOhyOP9qo+DOs+aL5A7r5uLh2Mb7zAEMDT
   TNg71GBlrDcuJOg5x63iJ47yikjm0lqwySNKqTJQQut5V9RnzLwGbhoV4
   1GGWhEMZrfgjc888C42rUefwZSK5DySxwombb/rHDMEqeUboCsc1MkmU1
   p2l16TmR1DDJ18XoRIPmlYy//osnVRquO+Nu8X3THhdHEDAbBFK7OOTQd
   fedrnsr3k6fTYA4zX7gw4I3ULqyJxYbDjCF8e96oSSHq3HGmakWdxRiGW
   6GSA1PJOMsTp1xGC5NWxcLUgbRgcAwzhGKyWxptWW9wX+N5bNYlWIlQsT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="352905813"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="352905813"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="1057205098"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="1057205098"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.75])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:42:44 -0700
Message-ID: <dfc72fd8-0b4a-71bc-ee0c-9ad97f8de6dc@intel.com>
Date:   Wed, 26 Jul 2023 15:42:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 4/6] mmc: sdhci-cadence: enable MMC_SDHCI_IO_ACCESSORS
 support
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230717125146.16791-1-pmalgujar@marvell.com>
 <20230717125146.16791-5-pmalgujar@marvell.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230717125146.16791-5-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/23 15:51, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add support of CONFIG_MMC_SDHCI_IO_ACCESSORS to allow Marvell
> SoC ops for SD6 controller to overwrite the SDHCI IO memory
> accessors.
> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 59 ++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 8bcf585185053b0afaff2625d62316cec1824fa3..f1e597219c603f3921439cedb22dcb2884abe68d 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -448,6 +448,59 @@ static u32 read_dqs_cmd_delay, clk_wrdqs_delay, clk_wr_delay, read_dqs_delay;
>  
>  static u32 sdhci_cdns_sd6_get_mode(struct sdhci_host *host, unsigned int timing);
>  
> +static u32 sdhci_cdns_sd6_readl(struct sdhci_host *host, int reg)
> +{
> +	return readl(host->ioaddr + reg);
> +}

Doesn't need to be implemented if it is the same as the
default behaviour

> +
> +static void sdhci_cdns_sd6_writel(struct sdhci_host *host, u32 val, int reg)
> +{
> +	writel(val, host->ioaddr + reg);
> +}

Doesn't need to be implemented if it is the same as the
default behaviour

> +
> +static u16 sdhci_cdns_sd6_readw(struct sdhci_host *host, int reg)
> +{
> +	u32 val, regoff;
> +
> +	regoff = reg & ~3;
> +
> +	val = readl(host->ioaddr + regoff);
> +	if ((reg & 0x3) == 0)
> +		return (val & 0xFFFF);
> +	else
> +		return ((val >> 16) & 0xFFFF);
> +}

You can use upper_16_bits() etc e.g.

static u16 sdhci_cdns_sd6_readw(struct sdhci_host *host, int reg)
{
	u32 val = readl(host->ioaddr + (reg & ~3));

	return reg & 0x3 ? upper_16_bits(val) : lower_16_bits(val);
}

> +
> +static void sdhci_cdns_sd6_writew(struct sdhci_host *host, u16 val, int reg)
> +{
> +	writew(val, host->ioaddr + reg);
> +}

Doesn't need to be implemented if it is the same as the
default behaviour

> +
> +static u8 sdhci_cdns_sd6_readb(struct sdhci_host *host, int reg)
> +{
> +	u32 val, regoff;
> +
> +	regoff = reg & ~3;
> +
> +	val = readl(host->ioaddr + regoff);
> +	switch (reg & 3) {
> +	case 0:
> +		return (val & 0xFF);
> +	case 1:
> +		return ((val >> 8) & 0xFF);
> +	case 2:
> +		return ((val >> 16) & 0xFF);
> +	case 3:
> +		return ((val >> 24) & 0xFF);
> +	}
> +	return 0;
> +}

Probably could just be:

static u8 sdhci_cdns_sd6_readb(struct sdhci_host *host, int reg)
{
	u32 val = readl(host->ioaddr + (reg & ~3));

	return val >> (8 * (reg & 3)));
}

> +
> +static void sdhci_cdns_sd6_writeb(struct sdhci_host *host, u8 val, int reg)
> +{
> +	writeb(val, host->ioaddr + reg);
> +}

Doesn't need to be implemented if it is the same as the
default behaviour

> +
>  static int sdhci_cdns_sd6_phy_lock_dll(struct sdhci_cdns_sd6_phy *phy)
>  {
>  	u32 delay_element = phy->d.delay_element_org;
> @@ -1666,6 +1719,12 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
>  };
>  
>  static const struct sdhci_ops sdhci_cdns_sd6_ops = {
> +	.read_l = sdhci_cdns_sd6_readl,
> +	.write_l = sdhci_cdns_sd6_writel,
> +	.read_w = sdhci_cdns_sd6_readw,
> +	.write_w = sdhci_cdns_sd6_writew,
> +	.read_b = sdhci_cdns_sd6_readb,
> +	.write_b = sdhci_cdns_sd6_writeb,
>  	.get_max_clock = sdhci_cdns_get_max_clock,
>  	.set_clock = sdhci_cdns_sd6_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,

