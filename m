Return-Path: <linux-kernel+bounces-8324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E876E81B5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44AF285DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFF66EB66;
	Thu, 21 Dec 2023 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFfoiIPP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B96E59D;
	Thu, 21 Dec 2023 12:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80874C433C7;
	Thu, 21 Dec 2023 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703161305;
	bh=ZXuqDithbYzkJx1AnJD01RR/3/aFDMJ/KwOLs+ao4Ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qFfoiIPPpBn54ZRPtowtPIyJNd5wCXGhD6jFqz/hcGpdCrFmJh9m77Tm68CiVR4yr
	 /bAXl00l6GijRJ2onq1v+mu4duw+dtp4vsHOW+XOO6mFM4KpM++1OD3ozGXeYTMVUz
	 8PCo1Zm94qM8YcJ8MttVJ+V7uvSeeZybdsvuAzynInLzwUbdcftyKSNgygddOAZI9A
	 CepIq0TyRWBU5gSGEL01JMZzFeRTRXfnrIWQSLqxtR/J3LosB1j1hwzgw79UukpXCi
	 WsttznHuUY0u7xNFXXXRXnL/3nFyC43098XNU5+Px1yQLrRDRHMuXLamC8r5xshK9P
	 R1DMxuHSoaEJQ==
Message-ID: <4027f264-c7e9-4b7d-b88b-ced20e431314@kernel.org>
Date: Thu, 21 Dec 2023 14:21:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: ethernet: ti: am65-cpsw-nuss: Enable
 SGMII mode for J784S4 CPSW9G
To: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231221111046.761843-1-c-vankar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231221111046.761843-1-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/12/2023 13:10, Chintan Vankar wrote:
> TI's J784S4 SoC supports SGMII mode with CPSW9G instance of the CPSW
> Ethernet Switch. Thus, enable it by adding SGMII mode to the
> extra_modes member of the "j784s4_cpswxg_pdata" SoC data.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

Please send without RFC in subject.

> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 7651f90f51f2..9aa5a6108521 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2855,7 +2855,8 @@ static const struct am65_cpsw_pdata j784s4_cpswxg_pdata = {
>  	.quirks = 0,
>  	.ale_dev_id = "am64-cpswxg",
>  	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
> -	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_USXGMII),
> +	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII) |
> +		       BIT(PHY_INTERFACE_MODE_USXGMII),
>  };
>  
>  static const struct of_device_id am65_cpsw_nuss_of_mtable[] = {

-- 
cheers,
-roger

