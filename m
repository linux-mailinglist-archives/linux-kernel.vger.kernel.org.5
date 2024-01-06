Return-Path: <linux-kernel+bounces-18676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6088260E4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3095B283808
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10418C2D9;
	Sat,  6 Jan 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gowa6Gk2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E4C155
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id M0h6rKRFWMVQiMATMrTEu4; Sat, 06 Jan 2024 17:28:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id MATLrHrrBL3AmMATMrNNYV; Sat, 06 Jan 2024 17:28:36 +0000
X-Authority-Analysis: v=2.4 cv=Sdrky9du c=1 sm=1 tr=0 ts=65998dc4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=VwQbUJbxAAAA:8 a=3gf6MFcAdpgbip9PbcIA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jqbX15IrQLQ95FamULlsdlZsBzcnY9l7VxFlPvs2xck=; b=gowa6Gk2iiQNWan/JlPXQpunW0
	JPEGeHxCpmxiNUaJFG1hrEEL/H+UHDClk6YUK04blgYe6y3ls55iWqSbiOjE8jM+nsH8lmDf64A2B
	EU/Bptw8Qn09Itv9E2lA9R2z4zzu55/jNPz4VvpdMqLMKj5jK1uHylWgtlReif2G0u6BkJNAfWTw5
	u05V4MCK5ymyXYbnrnEN+plo/imTUq4UBGloGM2TL5Zde9Yjt5yiwK/mv5xWLkwtITAo6XovpAElG
	F9Nm1KHOze/dLMH9zkk6qf0qrU1kDjWntuijVFA7aUEc7rz4VlwW2vVAKJ3A3B+TS7e2egImVjxqB
	cu2xrHAQ==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:54571 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rMATK-002YaE-2e;
	Sat, 06 Jan 2024 11:28:34 -0600
Message-ID: <1b3c3242-d239-465b-990c-33680291ec46@embeddedor.com>
Date: Sat, 6 Jan 2024 11:28:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: Use devm_kcalloc() instead of devm_kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240106162752.18599-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240106162752.18599-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rMATK-002YaE-2e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:54571
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJtVS0HgrI4+urFYcvB0m+vfIk+4Dqaf7O6BepgwUVG1w8CCgj3XAVldYUTijfTNLoDSsPvBKDypzSxinFhtGemKWsk6TWSj39A+sm8AvlQpvkKGrBMv
 +zQGIz8RKym/EPcmNj00k96acxengER3eYl9Ub9t8cKdaXhfyEqMXINgvKN69WmMsxRX+8pf6eyslqoS/92K9iUF0ss1fSw6kMFZ4uXK8+PGtMZ0gDk9Cj21



On 1/6/24 10:27, Erick Archer wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   sound/soc/ti/j721e-evm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
> index b4b158dc736e..d9d1e021f5b2 100644
> --- a/sound/soc/ti/j721e-evm.c
> +++ b/sound/soc/ti/j721e-evm.c
> @@ -649,7 +649,7 @@ static int j721e_soc_probe_cpb(struct j721e_priv *priv, int *link_idx,
>   	 * Link 2: McASP10 <- pcm3168a_1 ADC
>   	 */
>   	comp_count = 6;
> -	compnent = devm_kzalloc(priv->dev, comp_count * sizeof(*compnent),
> +	compnent = devm_kcalloc(priv->dev, comp_count, sizeof(*compnent),
>   				GFP_KERNEL);
>   	if (!compnent) {
>   		ret = -ENOMEM;
> @@ -763,7 +763,7 @@ static int j721e_soc_probe_ivi(struct j721e_priv *priv, int *link_idx,
>   	 *		   \ pcm3168a_b ADC
>   	 */
>   	comp_count = 8;
> -	compnent = devm_kzalloc(priv->dev, comp_count * sizeof(*compnent),
> +	compnent = devm_kcalloc(priv->dev, comp_count, sizeof(*compnent),
>   				GFP_KERNEL);
>   	if (!compnent) {
>   		ret = -ENOMEM;
> --
> 2.25.1
> 
> 

