Return-Path: <linux-kernel+bounces-40623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1102483E352
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EA91C22212
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DD22F12;
	Fri, 26 Jan 2024 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J64cU7AZ"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12022EE8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300682; cv=none; b=bAocQUcWP+Dtm5rbz9ecXSErlUbTpEk4w1Y1xtuUC8o+KRsCAz3HA5Wj0ytCW01wg4tFDIidi/ZKZz/df86oj666rpGIltz+O7w2mEyRMfRq+pg9bjmKbKhezQkWiCZT37YvVWR19DFzguNf3JHHnDYP7TWXmXLy0TfqGkfwxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300682; c=relaxed/simple;
	bh=aacVZUW/5mGUDYhkkYBJUGL/Gh8Ctd/YyoFEal95FVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c28j2h97Ugx/qlv1PbCElQ+HIbnojF4mLUBvlURoiWmM81ZEAmAclRW3c5bnlBZZCKfM1ElqnspjTc1V+bYMr3D26Crq4L89N2RgL1eAdYbya0DkQ8InTSAJo229BXzckZejVe5h+4LvnYuMpCfodw/tktQul4EGw5gqhThAXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J64cU7AZ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f8343c3-7403-4346-9973-1b4421e3ad7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706300677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8oebQaftQNT6LeEHr7TKK0RzE3dlOdRvYdiT9hpg60=;
	b=J64cU7AZQmfIOteP1Arx1fIFb/l+unLnQLiVc+IckZodSv/fH3ql/JCtI81f4qbE5AsP17
	ROb9SXlR92gYbuPHBDIXPDL4wxR3Cc1Y+h0jmiucTF/uSLsONdhB3B3JNMj2k5jl50vCpa
	hT3rq4jcrGqua93Dtgvvn4I1yp+6Ll4=
Date: Fri, 26 Jan 2024 20:24:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues
 default settings
Content-Language: en-US
To: Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Rohan G Thomas <rohan.g.thomas@intel.com>,
 "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1706256158.git.esben@geanix.com>
 <379f79687ca4a7d0394a04d14fb3890ce257e706.1706256158.git.esben@geanix.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <379f79687ca4a7d0394a04d14fb3890ce257e706.1706256158.git.esben@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/01/2024 09:10, Esben Haabendal wrote:
> TSO and TBS cannot coexist. For now we set i.MX Ethernet QOS controller to
> use the first TX queue with TSO and the rest for TBS.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index 8f730ada71f9..6b65420e11b5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -353,6 +353,10 @@ static int imx_dwmac_probe(struct platform_device *pdev)
>   	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
>   		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
>   
> +	/* Default TX Q0 to use TSO and rest TXQ for TBS */
> +	for (int i = 1; i < plat_dat->tx_queues_to_use; i++)
> +		plat_dat->tx_queues_cfg[i].tbs_en = 1;
> +
>   	plat_dat->host_dma_width = dwmac->ops->addr_width;
>   	plat_dat->init = imx_dwmac_init;
>   	plat_dat->exit = imx_dwmac_exit;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

