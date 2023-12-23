Return-Path: <linux-kernel+bounces-10570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72ED81D658
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9057C1F2205E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C015EAE;
	Sat, 23 Dec 2023 19:40:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828CE14A80;
	Sat, 23 Dec 2023 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (31.173.85.112) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 23 Dec
 2023 22:39:51 +0300
Subject: Re: [PATCH net v2 1/1] net: ravb: Wait for operation mode to be
 applied
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>,
	<mitsuhiro.kimura.kc@renesas.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20231222113552.2049088-1-claudiu.beznea.uj@bp.renesas.com>
 <20231222113552.2049088-2-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <98efc508-c431-2509-5799-96decc124136@omp.ru>
Date: Sat, 23 Dec 2023 22:39:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231222113552.2049088-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/23/2023 19:22:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182322 [Dec 23 2023]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.85.112 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.85.112
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/23/2023 19:28:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/23/2023 4:14:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/22/23 2:35 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> CSR.OPS bits specify the current operating mode and (according to
> documentation) they are updated by HW when the operating mode change
> request is processed. To comply with this check CSR.OPS before proceeding.
> 
> Commit introduces ravb_set_opmode() that does all the necessities for
> setting the operating mode (set DMA.CCC and wait for CSR.OPS) and call it
> where needed. This should comply with all the HW manuals requirements as
> different manual variants specify that different modes need to be checked
> in CSR.OPS when setting DMA.CCC.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 52 ++++++++++++++----------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 664eda4b5a11..ae99d035a3b6 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -66,14 +66,15 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
>  	return -ETIMEDOUT;
>  }
>  
> -static int ravb_config(struct net_device *ndev)
> +static int ravb_set_opmode(struct net_device *ndev, u32 opmode)

   Since you pass the complete CCC register value below, you should
rather call the function ravb_set_ccc() and call the parameter opmode
ccc.

>  {
> +	u32 csr_opmode = 1UL << opmode;

   Please use the correct expression, 1U << (ccc & CCC_OPC) instead.
And I'd suggest calling the variable csr_ops or just ops.

>  	int error;
>  
> -	/* Set config mode */
> -	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
> -	/* Check if the operating mode is changed to the config mode */
> -	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
> +	/* Set operating mode */
> +	ravb_modify(ndev, CCC, CCC_OPC, opmode);
> +	/* Check if the operating mode is changed to the requested one */
> +	error = ravb_wait(ndev, CSR, CSR_OPS, csr_opmode);
>  	if (error)
>  		netdev_err(ndev, "failed to switch device to config mode\n");

   s/config/requested/? Or just print out that mode...

[...]
> @@ -2560,21 +2559,23 @@ static int ravb_set_gti(struct net_device *ndev)
>  	return 0;
>  }
>  
> -static void ravb_set_config_mode(struct net_device *ndev)
> +static int ravb_set_config_mode(struct net_device *ndev)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> +	int error;
>  
>  	if (info->gptp) {
> -		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
> +		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);

   Don't we need to return on error here?

>  		/* Set CSEL value */
>  		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
>  	} else if (info->ccc_gac) {
> -		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG |
> -			    CCC_GAC | CCC_CSEL_HPB);
> +		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);

   See, you pass more than just CCC.OPC value here -- need to mask it out
above...

[...]
> @@ -2917,8 +2921,9 @@ static void ravb_remove(struct platform_device *pdev)
>  	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
>  			  priv->desc_bat_dma);
>  
> -	/* Set reset mode */
> -	ravb_write(ndev, CCC_OPC_RESET, CCC);
> +	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
> +	if (error)
> +		netdev_err(ndev, "Failed to reset ndev\n");

   ravb_set_opmode() will have complained already at this point...

[...]

MBR, Sergey

