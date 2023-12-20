Return-Path: <linux-kernel+bounces-7204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25D881A32D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B8EB211B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ECB41841;
	Wed, 20 Dec 2023 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xbf/l7ur"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757546B92;
	Wed, 20 Dec 2023 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BKAJMxu026336;
	Wed, 20 Dec 2023 16:52:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=dMuOAk+gwvkbeHZULHNVEMOJGqXKMt2xpT/Apfey03s=; b=xb
	f/l7urPxvrldORWLQ24h8lgbfRitKrFHG+QvaC7BjQIJGYn+mI/s/oZnOeK2y2/t
	qkykqrhxu9lakzQwgZwgW6kCeHouvFrv2hEBdOGxnpS0Rf8AH9T7NEgbjDvEnyGn
	ZidlWnQXPMo8j7FfMgsMFYaJyW0dkBs9IxvT9Eemyd4iOabY8S4O1NsgHBJ8eeNf
	D2+IXTJM50FN59SzuOZyKBgutYmYT4gagoxZAg3X+mqO05jXwhNHfPq6TBWqowMh
	m+lHiFlQY94j3Xk+bn3XEkWrwbFradlEM6Kn73w09EIbO8sK1aYAK/1xjhv9TwWK
	Bw52LkzGpnDNZU8r3HmQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v126m2t9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 16:52:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02F33100057;
	Wed, 20 Dec 2023 16:52:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED5B12207AC;
	Wed, 20 Dec 2023 16:52:30 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 16:52:30 +0100
Message-ID: <6a7ecf2f-eee9-4297-b0d6-be7e7f1d9fea@foss.st.com>
Date: Wed, 20 Dec 2023 16:52:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tools/counter: Fix spelling mistake "componend" ->
 "component"
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
        William Breathitt Gray
	<william.gray@linaro.org>,
        <linux-iio@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231219133015.365943-1-colin.i.king@gmail.com>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231219133015.365943-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_09,2023-12-20_01,2023-05-22_02

On 12/19/23 14:30, Colin Ian King wrote:
> There are two spelling mistakes in the help text. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Hi Colin,
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for your patch,
Best Regards,
Fabrice
> ---
>  tools/counter/counter_watch_events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
> index 3898fe7e35ec..37d1b4b3e63d 100644
> --- a/tools/counter/counter_watch_events.c
> +++ b/tools/counter/counter_watch_events.c
> @@ -120,8 +120,8 @@ static void print_usage(void)
>  		"  evt_capture                (COUNTER_EVENT_CAPTURE)\n"
>  		"\n"
>  		"  chan=<n>                   channel <n> for this watch [default: 0]\n"
> -		"  id=<n>                     componend id <n> for this watch [default: 0]\n"
> -		"  parent=<n>                 componend parent <n> for this watch [default: 0]\n"
> +		"  id=<n>                     component id <n> for this watch [default: 0]\n"
> +		"  parent=<n>                 component parent <n> for this watch [default: 0]\n"
>  		"\n"
>  		"Example with two watched events:\n\n"
>  		"counter_watch_events -d \\\n"

