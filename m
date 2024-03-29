Return-Path: <linux-kernel+bounces-125196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51538921FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F811C213A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D80137765;
	Fri, 29 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ5kh/eF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DAC136E01;
	Fri, 29 Mar 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731369; cv=none; b=qsFs/zd/S9xfVw8F+TV9LgwTxba6E96bWDuZxBaS5Qj1ubplY3PADA5WE+qEqzhvcFkQtRYXh7ShCTea/lfkGkLYnSDs6wQsNBmbWqNVj96kLKla3iraa6hYnxS/UZhFfqbtH2rr0OJzB/L56dZxrQk8MB0DrC3jYsSoPJMw8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731369; c=relaxed/simple;
	bh=isBCBT3seLZHai1OgzPx3zwWr4nR668ZJ3SMftDDp6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9JA8JdPw6KqBrpIY9pXMYvbEQs3MUKMrqQskz/eiEXcg0mutRw53ntwlvEemGzCVsjT32CCCr3ecEO7UCrQWREdnLCeJpNdP25y3br4CQk5URtGVRfLEsLKuh0b9KCri0WwLX11FrH8g82zF36jVJak4hszoinLR9V0DA97oeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ5kh/eF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6422C433C7;
	Fri, 29 Mar 2024 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711731369;
	bh=isBCBT3seLZHai1OgzPx3zwWr4nR668ZJ3SMftDDp6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJ5kh/eFxvCB7x0HP9o7GJ025aeWR+BDUKfpEeIIYigLiXrGXi/gyZYGwm1M0wIw5
	 RZ7k6YyugQtGNOCHPSI/Q4LFhlBCbcdGgTklkcpMx2V6f1IKOTHs3ZB7QZp5eTIoi3
	 u69yhID5We6VtYO8ucXLvNOvfoHL49CS+sepNyKzW/J+NZiNXTMRZZ5eCqZ31Td+68
	 NorqtgqaNH6A+ShOFysLPth9FfYCFQRw+4Ee/lBwRRpg+k7tLDNIGmNb8Tw1HHP4OY
	 JF+SGtwvPX0HWLRAzSBautwu9NJ3voJxFVUp7Q4aSyekrr0TY8y9HkKV0JlF4BXBmG
	 VMUerY5p90Fgw==
Date: Fri, 29 Mar 2024 22:26:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 3/7] phy: qcom: qmp-combo: introduce QPHY_MODE
Message-ID: <ZgbypXhhTGep1r8-@matsya>
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-3-07e24a231840@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-3-07e24a231840@linaro.org>

On 29-02-24, 14:07, Neil Armstrong wrote:
> Introduce an enum for the QMP Combo PHY modes, use it in the
> QMP commmon phy init function and default to COMBO mode.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 41 +++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 3721bbea9eae..ac5d528fd7a1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -61,6 +61,12 @@
>  
>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
>  
> +enum qphy_mode {
> +	QPHY_MODE_COMBO = 0,
> +	QPHY_MODE_DP_ONLY,
> +	QPHY_MODE_USB_ONLY,
> +};
> +
>  /* set of registers with offsets different per-PHY */
>  enum qphy_reg_layout {
>  	/* PCS registers */
> @@ -1491,6 +1497,7 @@ struct qmp_combo {
>  
>  	struct mutex phy_mutex;
>  	int init_count;
> +	enum qphy_mode init_mode;
>  
>  	struct phy *usb_phy;
>  	enum phy_mode mode;
> @@ -2531,12 +2538,33 @@ static int qmp_combo_com_init(struct qmp_combo *qmp, bool force)
>  	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
>  		val |= SW_PORTSELECT_VAL;
>  	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
> -	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>  
> -	/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
> -	qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> -			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> -			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +	switch (qmp->init_mode) {
> +		case QPHY_MODE_COMBO:

Case should be at same indent as switch :-) coding style 101

> +			writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> +
> +			/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
> +			qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +					SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> +					SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +			break;
> +
> +		case QPHY_MODE_DP_ONLY:
> +			writel(DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> +
> +			/* bring QMP DP PHY PCS block out of reset */
> +			qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +					SW_DPPHY_RESET_MUX | SW_DPPHY_RESET);
> +			break;
> +
> +		case QPHY_MODE_USB_ONLY:
> +			writel(USB3_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> +
> +			/* bring QMP USB PHY PCS block out of reset */
> +			qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +					SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +			break;
> +	}
>  
>  	qphy_clrbits(com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
>  	qphy_clrbits(com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> @@ -3545,6 +3573,9 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_node_put;
>  
> +	/* Set PHY_MODE as combo by default */
> +	qmp->init_mode = QPHY_MODE_COMBO;
> +
>  	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
>  	if (IS_ERR(qmp->usb_phy)) {
>  		ret = PTR_ERR(qmp->usb_phy);
> 
> -- 
> 2.34.1

-- 
~Vinod

