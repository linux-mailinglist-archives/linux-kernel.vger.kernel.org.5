Return-Path: <linux-kernel+bounces-18677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375CB8260E6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD54282AF4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39490C2CE;
	Sat,  6 Jan 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hGTQHy+d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54499DDAF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id M4dqrL7PqMVQiMAUWrTF90; Sat, 06 Jan 2024 17:29:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id MAUVrfQh0im6EMAUWrz2RM; Sat, 06 Jan 2024 17:29:48 +0000
X-Authority-Analysis: v=2.4 cv=Qft1A+Xv c=1 sm=1 tr=0 ts=65998e0c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=VwQbUJbxAAAA:8 a=Xv5lit1u7inJFwG0Rj4A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=SLz71HocmBbuEhFRYD3r:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kp3nPAn0Jw9fdBJE8vaNu80tZr2D5BJIDgFDgQoUEQY=; b=hGTQHy+dR2LgB/mfwf+U3j5CEh
	k2lZZ4G2/Ubiw82MjKPvrdgU039R6nWl9t2rDbx5vzqELlRMadSf3ZQCmxmb3+tg7DuWUF9UJoRqs
	S7H/+4Ovwmu76rrnrlcwIhHvnofT0Tp4M+7Hv17AxtifNJgIJ8GN+mwsFemkbAA4tLmW3gH0tsaVN
	3bFco1r8ElQN+fanpPvv40PBFZ4AD9PvxcjgriO4gKBQC0CM9vfHHTmWCcnSl6K1vnfzCOoqDdPt9
	S2FpaWAr5kXdgZmd41jp5lLvQiJMxNjmUg9jcuOEIhzVkX4gQfAypfqptbcLeGskGsutHXFhMjaP8
	n78pEEhg==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:54571 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rMAUU-002YaE-1R;
	Sat, 06 Jan 2024 11:29:46 -0600
Message-ID: <ea9d5db7-6be7-4cda-85d2-6039483eabb4@embeddedor.com>
Date: Sat, 6 Jan 2024 11:29:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: qcom: Use devm_kcalloc() instead of devm_kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240106171635.19881-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240106171635.19881-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rMAUU-002YaE-1R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:54571
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIPJQc6IOAejjN2O0VF4uH9OOB1ImVvgwJf5xgw+l7tEUDbo2SEACvh4s9oMcpqa4QT5XH1tKCR+QE4IdL8VthLLXnBAlIVqkHwLK7aIzTmhpqwIAI1/
 0ll84IOYpiI/V3trFcaBbTDCwtoLZcIsRtqETF9IrywGOCZK9nEUgOXnzs25wtkAIdLF2ohQLwZdB9Csy6Y0cjhm8eIdVACRXp8pGN+B38xHtQAQdRBPbd9N



On 1/6/24 11:16, Erick Archer wrote:
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
>   sound/soc/qcom/common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
> index 756706d5b493..747041fa7866 100644
> --- a/sound/soc/qcom/common.c
> +++ b/sound/soc/qcom/common.c
> @@ -73,7 +73,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
>   	link = card->dai_link;
> 
>   	for_each_available_child_of_node(dev->of_node, np) {
> -		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
> +		dlc = devm_kcalloc(dev, 2, sizeof(*dlc), GFP_KERNEL);
>   		if (!dlc) {
>   			ret = -ENOMEM;
>   			goto err_put_np;
> --
> 2.25.1
> 
> 

