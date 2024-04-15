Return-Path: <linux-kernel+bounces-145269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3438A51B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191441C22818
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D977F7F6;
	Mon, 15 Apr 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HdNiGgHY"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E07F7E3;
	Mon, 15 Apr 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187905; cv=none; b=AaneojalEIedUkrxVjnrYQowUA7c+SRwXit53v/O4Lg2vigehVL1Sb1H57v1CUhVfexGQAykTwPh2tXD0tI7GJL6zyLnhxzUSx7xZlFXz5LTr3MSv9ErS5NwWPPsKJBxJiprQ82CKcG4GvinrnBQm+0CS/wB/cGYHz9PxELmzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187905; c=relaxed/simple;
	bh=KkPyxTFMiUPTu/EeDsJJp5beF1fBZCRUeC4IMLbejTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z2HlrY2tDfy3xy+mV6jZ+txD1sZM13XjAt+0/XZQUDTENN7eSdbw1KHU6XOcz19FVyLjEY41XvA5Tde9hd4qsRt+OO/YmN9rfjH9rn65hmaQj8qjURLL0EWZnkeqPb799EyDc0nZ/trb9SQPA6wT0cCe1PCzfzQC8XzQjJigYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HdNiGgHY; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43F6nokl020159;
	Mon, 15 Apr 2024 08:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=1NJcAo3U9LsyvaqFbXPecrsCzqfre2QNbxquk49f8MM=; b=
	HdNiGgHYeNXAepHA8IHW4FgMZ2mbHScXxrq4GvGkm3VgDSEoZwP4sj+TFhxPEuXW
	X1iseqei+2XC9RlH7WTQ/0xj65GfFzcYaazjmCI4knc+GLLcG3xTtAWh+jhYbiIP
	o4unFA0hQ0KSlLtS1y1RwHKzS3rRy7j1k79MSfFpE4v6jwwACh8ksYGco98KS4DF
	WnnvCdEkFkrtAoP9WEuxdkpPQNrJ0vqi8OP/0z0P620KT2HwOXQGvTUA53AndXKf
	FayLtNgj6vlsiebSeK2vBIm33KMSdC3xAEfPhGmGpxkx450j4aSAvHNFx9FEtJZr
	EDQVS/2F0hO40l2q4M7ZAw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqey9fxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:31:23 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 14:31:21 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 15 Apr 2024 14:31:21 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 17697820244;
	Mon, 15 Apr 2024 13:31:21 +0000 (UTC)
Message-ID: <99ba78fa-1d09-4072-849b-f994c87c1db6@opensource.cirrus.com>
Date: Mon, 15 Apr 2024 14:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: kunit: Fix an NULL vs IS_ERR() check
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <b32e80cf-b385-40cd-b8ec-77ec73e07530@moroto.mountain>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <b32e80cf-b385-40cd-b8ec-77ec73e07530@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4tDq8_KeDrmZJQtAfhwhroJOkMY1XBhN
X-Proofpoint-ORIG-GUID: 4tDq8_KeDrmZJQtAfhwhroJOkMY1XBhN
X-Proofpoint-Spam-Reason: safe

On 15/04/2024 11:34, Dan Carpenter wrote:
> The kunit_device_register() function returns error pointers, not NULL.
> Passing an error pointer to get_device() will lead to an Oops.  Also
> get_device() returns the same device you passed to it.  Fix it!  ;)
> 
> Fixes: 7b7982f14315 ("regmap: kunit: Create a struct device for the regmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/base/regmap/regmap-kunit.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
> index 44265dc2313d..9c5314785fc2 100644
> --- a/drivers/base/regmap/regmap-kunit.c
> +++ b/drivers/base/regmap/regmap-kunit.c
> @@ -1925,10 +1925,10 @@ static int regmap_test_init(struct kunit *test)
>   	test->priv = priv;
>   
>   	dev = kunit_device_register(test, "regmap_test");
> -	priv->dev = get_device(dev);
> -	if (!priv->dev)
> -		return -ENODEV;
> +	if (IS_ERR(dev))
> +		return PTR_ERR(dev);
>   
> +	priv->dev = get_device(dev);
>   	dev_set_drvdata(dev, test);
>   
>   	return 0;

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

