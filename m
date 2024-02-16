Return-Path: <linux-kernel+bounces-68580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498AC857CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD2C1C24302
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FD1292C9;
	Fri, 16 Feb 2024 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jwHE2CTd"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD658129A6E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086907; cv=none; b=d3VznM3Rc4L1q1Iowydk9S+c6QfGBhH+18Cm/GTTokevRGNfrXSIzRVg7zrgnLvzE5YiVSNh91xroi4+259YW8W46S1OPQYOHBVBhe5MQ3sHo2yaowZDwPqWlS/zbvNtMQAfkX2e4/1OagR3xaTMt4vzVPf82wkqyb52wZoamm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086907; c=relaxed/simple;
	bh=RXHXULm6CLCtGziLfQFbpobv9QyFXSz1cAwBDvaO+BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OP74QLvaZfdcytWnKU1Ba6qw5uXZMGukE5/dG6aBKD1td96Pu4WOJPx1uacC7iKV0IfiA8TlDKd+2hbwVs5HTHHGEJUJFzTgCCsbnWNhhyyoKGsV9do+wrTPFcSbc7qy/W6U+fpBusJm6I0dPuezn8CTqvlNBhTyaG4uXXqaL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jwHE2CTd; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240216123502euoutp019de12b22e0e4435bbe1805916d2414b9~0V-zwrQuB0548005480euoutp01Y
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240216123502euoutp019de12b22e0e4435bbe1805916d2414b9~0V-zwrQuB0548005480euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708086902;
	bh=YfHwf5LXfAjRRD70B0avDgyj1BOBhSHLzrzNRjUUX1s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jwHE2CTdOcNaKSz201iCUh7FYrqKuVuY0B+h0wvhppwTRMyWMjJmjx7JfZQkNaE5w
	 0B8n8XIY5t0UJBFMSHIYL5+RWs6ce2hhV1k3YHesLjkDN//zhh8yFg+qJWv1vQxXWM
	 E/yyrto21SmE/i6rvH+PphcfPt298oDkb2VZ0320=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240216123502eucas1p156cfb170867a320c721c946788b66bac~0V-zi7AcJ0811008110eucas1p1E;
	Fri, 16 Feb 2024 12:35:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 14.20.09814.6765FC56; Fri, 16
	Feb 2024 12:35:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240216123501eucas1p2912e1b3f45f45f9de260d3b5ebe31ff1~0V-zB5hBr2375223752eucas1p2U;
	Fri, 16 Feb 2024 12:35:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240216123501eusmtrp1540fe706448b8d0685437f3d18224829~0V-zA6Qf61221912219eusmtrp1h;
	Fri, 16 Feb 2024 12:35:01 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-2b-65cf56766105
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.CF.10702.5765FC56; Fri, 16
	Feb 2024 12:35:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240216123501eusmtip1bad563d3b3d03a14445a9b7c8a032730~0V-ylAvEU1482514825eusmtip1Q;
	Fri, 16 Feb 2024 12:35:01 +0000 (GMT)
Message-ID: <1542ef65-508b-45be-ad5c-63ad124cb1a2@samsung.com>
Date: Fri, 16 Feb 2024 13:35:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: cdev: fix a NULL-pointer dereference with DEBUG
 enabled
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>, "Paul E . McKenney"
	<paulmck@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
	Golaszewski <bartosz.golaszewski@linaro.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240216105930.16265-1-brgl@bgdev.pl>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7plYedTDR7+4bJY8W0Nk8WuB9vY
	LKb8Wc5ksXn+H0aLy7vmsFl8WvKNxWJjy1ZGB3aPxddus3rsnHWX3WPTqk42jzvX9rB5fN4k
	F8AaxWWTkpqTWZZapG+XwJXxadtrpoKZXBVPO46wNjCe4uhi5OSQEDCRuPJiOWsXIxeHkMAK
	RonOVQehnC+MErfXXWaDcD4DZc59ZoRp6fl5mgkisZxRou/+dUYI5yOjxNHN69lAqngF7CTa
	3vezgtgsAqoSO64cYYSIC0qcnPmEBcQWFZCXuH9rBjuILSwQIvHp0BewXmYBcYlbT+aDbRAR
	WMwosWXHJahEicT3/9vABrEJGEp0ve0Ci3MKGEtMuv6DHaJGXmL72znMIM0SAnc4JPaf38AM
	cbeLxKz/j1khbGGJV8e3sEPYMhKnJ/ewQDS0M0os+H2fCcKZwCjR8PwW1NfWEnfO/QJaxwG0
	QlNi/S59iLCjxO/m/ewgYQkBPokbbwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164xDyB
	UWkWUrjMQvL/LCTvzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgIjr97/iX
	HYzLX33UO8TIxMF4iFGCg1lJhHdS75lUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLp
	iSWp2ampBalFMFkmDk6pBiZOwbsHTxff0G5fp/laYqW0mlT/6btH7Nfvv3Ek81K5kZ3hqXS+
	3v0ejdHBvh8+Wx6b+/v6z+DDhl0rFgTGx7+7N+efW/UfdfU5PonlH68rrbtz+IxY6xOu2ndr
	Gzf5/rQTrfeJmlx5Xvj8t/szd5eXCqpefc7+4gYns+aSwMK/Zj5mLw4EcT1ZXvjuhJbP0qSf
	Ny5WO5hl1Nzm6g/YXu0a0219tcHCz3nynT9uXStnv3Nbdz8l2Lp/11XN8jTrG20nlS2+Ldvf
	lsxV1PdxytVFGQ7LVmr65piwmzU5HE2Pmqtp805ee5GTt7TS7ps9z27E7T0VtO6C+IaF321e
	i7NfXMIg8cZRIebK/hMlRlZKLMUZiYZazEXFiQBBqJJkswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xu7qlYedTDfqfa1qs+LaGyWLXg21s
	FlP+LGey2Dz/D6PF5V1z2Cw+LfnGYrGxZSujA7vH4mu3WT12zrrL7rFpVSebx51re9g8Pm+S
	C2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4
	tO01U8FMroqnHUdYGxhPcXQxcnJICJhI9Pw8zdTFyMUhJLCUUeLK5ymMEAkZiZPTGlghbGGJ
	P9e62CCK3jNKPJ7/EyzBK2An0fa+H8xmEVCV2HHlCCNEXFDi5MwnLCC2qIC8xP1bM9hBbGGB
	EIlPh76wgdjMAuISt57MB9ssIrCYUeLI7EmMEIkSiUkP/0Nta2OUONH7iQkkwSZgKNH1tgus
	m1PAWGLS9R/sEA1mEl1bu6Ca5SW2v53DPIFRaBaSQ2YhWTgLScssJC0LGFlWMYqklhbnpucW
	G+kVJ+YWl+al6yXn525iBEbetmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8k3rPpArxpiRWVqUW
	5ccXleakFh9iNAWGxkRmKdHkfGDs55XEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YW
	pBbB9DFxcEo1MLVMfO7wrCzG5+miVCXlyRoNr3xW5GgtPT0l77DGqfSueSt/z7hk833unMAf
	7EWd+x5m7FLJbCz8W2R9iE/aVr4iKDS76l9T7olz9lFLZI7z39ihFFDA7ONSoeQmHJt4KOT3
	oUncC08f/SbDOFfzWW3xoz3t3H7zZU+H25XV//4bazv9dLvqFpabsteCz8f3TOfRf/1kTdab
	y6kfJvvbv01M2apTlvBrW9XRBZu2pU28du/XZnd+oXP7xK6p+6qqGxjwz3y0cOukxS8eR9/5
	bMZ5uCTl0bNzm9gTNjOH7FvquOB2ruppL99w4Xf3KplcJ0bMOi03f2fOlHxTVXXGVmW7S2L3
	XHa3lSSsW7WxJ0mJpTgj0VCLuag4EQAbF1CCRQMAAA==
X-CMS-MailID: 20240216123501eucas1p2912e1b3f45f45f9de260d3b5ebe31ff1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240216105945eucas1p15af2e143fe2090cd33fabb91ff012571
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240216105945eucas1p15af2e143fe2090cd33fabb91ff012571
References: <CGME20240216105945eucas1p15af2e143fe2090cd33fabb91ff012571@eucas1p1.samsung.com>
	<20240216105930.16265-1-brgl@bgdev.pl>

On 16.02.2024 11:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We are actually passing the gc pointer to chip_dbg() so we have to
> srcu_dereference() it.
>
> Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors with SRCU")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/lkml/179caa10-5f86-4707-8bb0-fe1b316326d6@samsung.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpio/gpiolib-cdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 85037fa4925e..f384fa278764 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -2795,8 +2795,8 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
>   		return ret;
>   
>   	guard(srcu)(&gdev->srcu);
> -
> -	if (!rcu_access_pointer(gdev->chip))
> +	gc = srcu_dereference(gdev->chip, &gdev->srcu);
> +	if (!gc)
>   		return -ENODEV;
>   
>   	chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


