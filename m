Return-Path: <linux-kernel+bounces-138802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58E89FA89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86935284005
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC3171067;
	Wed, 10 Apr 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="T3vtKfSK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CD16F286;
	Wed, 10 Apr 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760256; cv=none; b=RK/Y0nrt8ps4ufdwpFJR7jOMs/Y7BEy+GNHw0amCKb8Pn6pNLKwm1hsJ/26b4SQkKVavEO8S3wLfQwLtHAgUqICZVzhxKJFydWaA4dNY/HCjp3oa87FtQotkI74XEDfZJWz7K1KxQoIKtYh1UpB9vBvxGO881zd1Ta+csB9XRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760256; c=relaxed/simple;
	bh=cSE/nADZUnwpjgd127H/SRAZZwR+/T1NTDUTegptNHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UY6uyK1UlkEEQuk77tosYSEJdzGJanZUxPMqo3GSQYSHCX1oddq9hsEXtgJGu/XFJvlGY5uETVQBWuj7z8LZCZ7QlLt1PRPoJ+pe+DwKoh3w2rMjUdktsqpQU6YB/2vb1KQvcf1i8tURkJG2PnuFvsWZ+lwsD/oU8p5yookJfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=T3vtKfSK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A8gTd4014181;
	Wed, 10 Apr 2024 09:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=2paSzqGxF3zDhh/x1qVgOOBa//AyVxnNV03nVR4Q7aE=; b=
	T3vtKfSK3RVK1uyZ2qyCrH4y0aHhPijsPf6tXnvxrgMn5d7pU3vGJGqD6K4YkQOd
	GNhi8ivVyCLrdHBnByKsnYlGoymcxpx2fxZLEk0XOT3PHjc+XF74qN4s6q+ElHxH
	phI4j3Sa0C6/XBLZtF8KgwhCIHypr2zXJr60cVFC/rrl/wxC1Y9Mxe4R5NdNbptP
	ZMWtKBC9oOAFBc0QVL/gpObdkLPBxW3509k2Eyc8n9/H54lhSlQnEp9Jmg/l6hu+
	aebi/V/TDJL5UQNM8HqRJxKrgbduO7GGLiU1+kFhzAKRRzXsYTm/fRCpecpHW89s
	WLH74vTJZocateKcrs88qg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjncy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 09:43:47 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 15:43:45 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Apr 2024 15:43:45 +0100
Received: from [198.61.64.213] (EDIN4L06LR3.ad.cirrus.com [198.61.64.213])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3B64782024A;
	Wed, 10 Apr 2024 14:43:45 +0000 (UTC)
Message-ID: <c8e9a7a0-6fcf-4bbe-a659-b2360f5980d8@opensource.cirrus.com>
Date: Wed, 10 Apr 2024 15:43:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: soc-card: soc-card-test: Fix some error handling
 in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <2db68591-64e2-4f43-a5e1-cb8849f0a296@moroto.mountain>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <2db68591-64e2-4f43-a5e1-cb8849f0a296@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dyBpEva414NQpTFU_ccy3iM0CX0Bee2e
X-Proofpoint-GUID: dyBpEva414NQpTFU_ccy3iM0CX0Bee2e
X-Proofpoint-Spam-Reason: safe

On 10/4/24 15:22, Dan Carpenter wrote:
> Fix this reversed if statement and call put_device() before returning
> the error code.
> 
> Fixes: ef7784e41db7 ("ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: call put_device()
> 
>   sound/soc/soc-card-test.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-card-test.c b/sound/soc/soc-card-test.c
> index 075c52fe82e5..faf9a3d46884 100644
> --- a/sound/soc/soc-card-test.c
> +++ b/sound/soc/soc-card-test.c
> @@ -148,8 +148,10 @@ static int soc_card_test_case_init(struct kunit *test)
>   	priv->card->owner = THIS_MODULE;
>   
>   	ret = snd_soc_register_card(priv->card);
> -	if (!ret)
> +	if (ret) {
> +		put_device(priv->card_dev);
>   		return ret;
> +	}
>   
>   	return 0;
>   }

Thanks.
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

I can see that put_device() is also missing earlier in the
function:

	if (!priv->card)
		return -ENOMEM;

I can send a fix for that.

