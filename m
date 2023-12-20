Return-Path: <linux-kernel+bounces-7208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0193681A335
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFD61C20928
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111A40C09;
	Wed, 20 Dec 2023 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="c08f5B4h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1B41234;
	Wed, 20 Dec 2023 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKAKkXg026644;
	Wed, 20 Dec 2023 16:53:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=ODuYuQKuJnUVVTZxip+7TnDcgGAq0JCVdmWVKf/2CQw=; b=c0
	8f5B4hS07+okzYOl6OZQwZBYV9lC8uwN1aPx6rAHA5pW+DhTAHcasRKp4BbE0wvy
	phnlhbOwRPwcMxwXbo4HN14onzYTs9VdhBT1GLESgpAHlhVcmFNhkbIFLfhEeP+r
	aa0AaBGF1eRZ0yvgzBvIx89mdANcIblTXR+0mxG8oeIWQw5vDRNMX8vEbfeWRg0m
	S9PfP7ASPU7zAOt0xWEtBlYnPspmznj3DZ6uFiy0V/WBqSEV+Dm3XWmsByFVWcoq
	UrDpyhQ2VsQW4WQugMq3DFGRUdTRu2MCfnArsceN8VjRE7VCqyUfAI9O4JE4FbwY
	pefpQrqU4AtDcX67gCHw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v11w9262w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 16:53:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7FDA3100059;
	Wed, 20 Dec 2023 16:53:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 77C172207B1;
	Wed, 20 Dec 2023 16:53:45 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 16:53:44 +0100
Message-ID: <47716558-7a65-4296-92e9-0d923dd66eef@foss.st.com>
Date: Wed, 20 Dec 2023 16:53:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] tools/counter: Remove unneeded semicolon
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, <william.gray@linaro.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abaci Robot
	<abaci@linux.alibaba.com>
References: <20231220005143.84987-1-yang.lee@linux.alibaba.com>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231220005143.84987-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_09,2023-12-20_01,2023-05-22_02

On 12/20/23 01:51, Yang Li wrote:
> ./tools/counter/counter_watch_events.c:233:3-4: Unneeded semicolon
> ./tools/counter/counter_watch_events.c:234:2-3: Unneeded semicolon
> ./tools/counter/counter_watch_events.c:333:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7782
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Hi Yang,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for your patch,
Best Regards,
Fabrice

> ---
>  tools/counter/counter_watch_events.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
> index 3898fe7e35ec..2ce4c99ebd01 100644
> --- a/tools/counter/counter_watch_events.c
> +++ b/tools/counter/counter_watch_events.c
> @@ -230,8 +230,8 @@ int main(int argc, char **argv)
>  			break;
>  		default:
>  			return EXIT_FAILURE;
> -		};
> -	};
> +		}
> +	}
>  
>  	if (nwatch) {
>  		watches = calloc(nwatch, sizeof(*watches));
> @@ -330,7 +330,7 @@ int main(int argc, char **argv)
>  			i++;
>  			break;
>  		}
> -	};
> +	}
>  
>  	if (debug)
>  		print_watch(watches, nwatch);

