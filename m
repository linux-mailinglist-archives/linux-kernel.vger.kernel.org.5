Return-Path: <linux-kernel+bounces-142679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313FD8A2EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635FC1C21C75
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7775FDDC;
	Fri, 12 Apr 2024 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ge9ufb63"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538385B209;
	Fri, 12 Apr 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927022; cv=none; b=I+8uop+HZ7gEETDG3Rv147qoGUXF1hwxbPt4uV55OwdVGFmatkHKg7Q0tvJpv0f59kYGZ7tGhDWnuaAvrc3Y1iykf8hHJeBXUJfXLpjB8Dus2vvifxO5Jwzi+TkaR+nnJm6Er2HRn9SkuK87Uppoip47gjyDJabXnXvOM5qeBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927022; c=relaxed/simple;
	bh=0YhlaO/sZ/lNFpDfyQm508LIh6BokOglMf/3nuV3KFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QX+xMAVpO/NfFsAak1NLSqwmx5KA3LpNct2CVkD4c1esgtHWlmmfqCqkk5oPklEy3dy/3wPUmomzn168UsWvA9RuV57sMjwzXf9zMRlnUEtVGJGD4rs/Yhsz9XPqajqxaecitjfqe7bLb/vOdW0PZZ7B2gri8x4tacX3aaVpQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ge9ufb63; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43C8iia5010918;
	Fri, 12 Apr 2024 08:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=HtpTjQV+kePvQ/cWjDO7/zh0v/lMKFoQUpCxIgN6XBg=; b=
	Ge9ufb63T+FLn4Pru+/xqqxb5nkjIdp3H3el4FDOATIo/7XJ3NyOoTWmdh7TXApJ
	jMkx3BE76gq/V/6CZfz8OKy7baicZfLmEfdT8Sga+98GmjRE5BmnxcTthZli1Ll4
	l3kaTme3JhRGXbRZfdiGPeNo5JpDhvCntstm7qVhTncO/HScvs6zulHRFxw+PgKh
	rnLeapAWZ01oDRWYR1GDlMnwe4lTzy5LSVWnvckQ0WWG/4FCqkIaB8G6bVr0jR8K
	jwXGuEcgHmCjs+jxKEKVU/y0KgcMruESTgW9ZVZZu7yJ17ZESx2GUfgnVVnSC8xl
	S8or50whM3m2yvMrEz1iDg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xf1q6071d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 08:02:21 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 14:02:20 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 12 Apr 2024 14:02:20 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1E4D8820270;
	Fri, 12 Apr 2024 13:02:20 +0000 (UTC)
Message-ID: <b66339af-1e07-4509-9fd8-12a927618172@opensource.cirrus.com>
Date: Fri, 12 Apr 2024 14:02:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: soc-card: soc-card-test: Fix some error handling
 in init()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <450dd21a-b24b-48ba-9aa4-c02e4617852f@moroto.mountain>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <450dd21a-b24b-48ba-9aa4-c02e4617852f@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KH0pgunqufVkBEQtkVJJMIKs3hQ3mZVe
X-Proofpoint-GUID: KH0pgunqufVkBEQtkVJJMIKs3hQ3mZVe
X-Proofpoint-Spam-Reason: safe

On 12/04/2024 13:07, Dan Carpenter wrote:
> There are two issues here:
> 1) The get_device() needs a matching put_device() on error paths.
> 2) The "if (!ret)" was supposed to be "if (ret)".
> 
> I re-arranged the code a bit to do the allocation before the
> get_device().
> 
> Fixes: ef7784e41db7 ("ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: add a put_device()
> v3: move the kunit_kzalloc() to avoid a second put_device().  Btw,
>      kunit_kzalloc() is cleaned up automatically.
> 
>   sound/soc/soc-card-test.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/soc-card-test.c b/sound/soc/soc-card-test.c
> index 075c52fe82e5..e4a4b101d743 100644
> --- a/sound/soc/soc-card-test.c
> +++ b/sound/soc/soc-card-test.c
> @@ -134,22 +134,24 @@ static int soc_card_test_case_init(struct kunit *test)
>   
>   	test->priv = priv;
>   
> +	priv->card = kunit_kzalloc(test, sizeof(*priv->card), GFP_KERNEL);
> +	if (!priv->card)
> +		return -ENOMEM;
> +
>   	priv->card_dev = kunit_device_register(test, "sound-soc-card-test");
>   	priv->card_dev = get_device(priv->card_dev);
>   	if (!priv->card_dev)
>   		return -ENODEV;
>   
> -	priv->card = kunit_kzalloc(test, sizeof(*priv->card), GFP_KERNEL);
> -	if (!priv->card)
> -		return -ENOMEM;
> -
>   	priv->card->name = "soc-card-test";
>   	priv->card->dev = priv->card_dev;
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
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

