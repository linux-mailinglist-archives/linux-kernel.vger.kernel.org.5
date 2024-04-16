Return-Path: <linux-kernel+bounces-146038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB668A5F44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988442820D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38BA35;
	Tue, 16 Apr 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8L/8s+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EC629;
	Tue, 16 Apr 2024 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227378; cv=none; b=iq6v0mDQ7FBfmmBVIVO7ro3f+h7VJCduu4S+t05r6VtyFJOr0NpTiVQSiFz3CgwUdUqhSsbGqBntzLGVa2pNsyWlGOJCCHHxq+H4yJUkNEjaol9ZqUqsbA71iL+oZll4dd4UqLqdzYHdUEoqhCIV+wLJTzLwUKiLfaIuqukNERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227378; c=relaxed/simple;
	bh=HfHk3WuIcIudmtsoBPGASPAMjayRcL28OAR0jozp9jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmIWYs7Iwz36ECJ7CL3gFQyG1i2VTrK+JBkoY733QAk3fUhhvz5hlxlbOwI+Yq4r4SptucICyT6t1dH/e2gJ2a0d4g0I5iGVRQheMpncshb55pWupqhaK87+5WNg4sf0cah3NTmLQsNvbUl6vWl9TAn6Dt1zUSvfRGQiONPgeuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8L/8s+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF6BC113CC;
	Tue, 16 Apr 2024 00:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713227378;
	bh=HfHk3WuIcIudmtsoBPGASPAMjayRcL28OAR0jozp9jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8L/8s+u8C3+FTyXdYyV5d+CU8/uXOC6PQLwrfZHDYBbQo6P0BrPAQDUhsoRh7z57
	 w4KUVqNZjv87vp/5ph1BtLdpnnvgf50wFXqQPZomWV8aXyLUomZ66T0qmkmRCwk9kE
	 4xeqSl5MbazN9RwGgATWJnc5nPNp2ZOHrDQD5eW5uQrhEoencltmA/YtkvMNn6dV37
	 Z3RCstCDuOzJF1vPiv9oEkh0tcPko8+ehvysJzaBwGbQtYGQviTt/+M6zZvqFjkcYc
	 V5TUvWIZe+oSrDcTb3tD4NKud/NLbRZXECUj99wmdjhkQIMmu0cOZYHPpxShJl/EIb
	 iY7R8ZCryu5mw==
Date: Tue, 16 Apr 2024 08:16:14 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Add tuning support for Sophgo
 CV1800B and SG200X
Message-ID: <Zh3DTkc60d-lYnSI@xhacker>
References: <20240414164112.2732-1-jszhang@kernel.org>
 <c6c041d4-d9ed-46bb-9e6e-b53dc9ac0002@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6c041d4-d9ed-46bb-9e6e-b53dc9ac0002@intel.com>

On Mon, Apr 15, 2024 at 09:58:31AM +0300, Adrian Hunter wrote:
> On 14/04/24 19:41, Jisheng Zhang wrote:
> > Implement the .platform_execute_tuning for Sophgo CV1800B and SG200X.
> > Some code is borrowed from sdhci-esdhc-imx.c. The tuning result is
> > similar as the one of SoC vendor's SDK.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> One comment, otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 112 ++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index ab4b964d4058..7b55acd9830c 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -66,6 +66,10 @@
> >  #define CV18XX_SDHCI_PHY_CONFIG			0x4c
> >  #define  CV18XX_PHY_TX_BPS			BIT(0)
> >  
> > +#define CV18XX_TUNE_MAX				128
> > +#define CV18XX_TUNE_STEP			1
> > +#define CV18XX_RETRY_TUNING_MAX			50
> > +
> >  /* Rockchip specific Registers */
> >  #define DWCMSHC_EMMC_DLL_CTRL		0x800
> >  #define DWCMSHC_EMMC_DLL_RXCLK		0x804
> > @@ -685,6 +689,113 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> >  	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
> >  }
> >  
> > +static void cv18xx_sdhci_set_tap(struct sdhci_host *host, int tap)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +	u16 clk;
> > +	u32 val;
> > +
> > +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +	clk &= ~SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +	val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> > +	val &= ~CV18XX_LATANCY_1T;
> > +	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> > +
> > +	val =  (FIELD_PREP(CV18XX_PHY_TX_DLY_MSK, 0) |
> > +		FIELD_PREP(CV18XX_PHY_TX_SRC_MSK, CV18XX_PHY_TX_SRC_INVERT_CLK_TX) |
> > +		FIELD_PREP(CV18XX_PHY_RX_DLY_MSK, tap));
> > +	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
> > +
> > +	sdhci_writel(host, 0, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_CONFIG);
> > +
> > +	clk |= SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +	mdelay(1);
> 
> Did you consider usleep_range() instead of mdelay()?

Good idea, will test and send out a v2.

> 
> > +}
> > +
> > +static int cv18xx_retry_tuning(struct mmc_host *mmc, u32 opcode, int *cmd_error)
> > +{
> > +	int ret, retry = 0;
> > +
> > +	while (retry < CV18XX_RETRY_TUNING_MAX) {
> > +		ret = mmc_send_tuning(mmc, opcode, NULL);
> > +		if (ret)
> > +			return ret;
> > +		retry++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
> > +{
> > +	u32 val;
> > +
> > +	val = sdhci_readl(host, SDHCI_INT_STATUS);
> > +	val |= SDHCI_INT_DATA_AVAIL;
> > +	sdhci_writel(host, val, SDHCI_INT_STATUS);
> > +
> > +	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> > +}
> > +
> > +static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> > +{
> > +	int min, max, avg, ret;
> > +	int win_length, target_min, target_max, target_win_length;
> > +
> > +	min = max = 0;
> > +	target_win_length = 0;
> > +
> > +	sdhci_reset_tuning(host);
> > +
> > +	while (max < CV18XX_TUNE_MAX) {
> > +		/* find the mininum delay first which can pass tuning */
> > +		while (min < CV18XX_TUNE_MAX) {
> > +			cv18xx_sdhci_set_tap(host, min);
> > +			if (!cv18xx_retry_tuning(host->mmc, opcode, NULL))
> > +				break;
> > +			min += CV18XX_TUNE_STEP;
> > +		}
> > +
> > +		/* find the maxinum delay which can not pass tuning */
> > +		max = min + CV18XX_TUNE_STEP;
> > +		while (max < CV18XX_TUNE_MAX) {
> > +			cv18xx_sdhci_set_tap(host, max);
> > +			if (cv18xx_retry_tuning(host->mmc, opcode, NULL)) {
> > +				max -= CV18XX_TUNE_STEP;
> > +				break;
> > +			}
> > +			max += CV18XX_TUNE_STEP;
> > +		}
> > +
> > +		win_length = max - min + 1;
> > +		/* get the largest pass window */
> > +		if (win_length > target_win_length) {
> > +			target_win_length = win_length;
> > +			target_min = min;
> > +			target_max = max;
> > +		}
> > +
> > +		/* continue to find the next pass window */
> > +		min = max + CV18XX_TUNE_STEP;
> > +	}
> > +
> > +	cv18xx_sdhci_post_tuning(host);
> > +
> > +	/* use average delay to get the best timing */
> > +	avg = (target_min + target_max) / 2;
> > +	cv18xx_sdhci_set_tap(host, avg);
> > +	ret = mmc_send_tuning(host->mmc, opcode, NULL);
> > +
> > +	dev_dbg(mmc_dev(host->mmc), "tuning %s at 0x%x ret %d\n",
> > +		ret ? "failed" : "passed", avg, ret);
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct sdhci_ops sdhci_dwcmshc_ops = {
> >  	.set_clock		= sdhci_set_clock,
> >  	.set_bus_width		= sdhci_set_bus_width,
> > @@ -721,6 +832,7 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
> >  	.get_max_clock		= dwcmshc_get_max_clock,
> >  	.reset			= cv18xx_sdhci_reset,
> >  	.adma_write_desc	= dwcmshc_adma_write_desc,
> > +	.platform_execute_tuning = cv18xx_sdhci_execute_tuning,
> >  };
> >  
> >  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> 

