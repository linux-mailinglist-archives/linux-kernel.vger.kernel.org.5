Return-Path: <linux-kernel+bounces-142674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98DD8A2EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E553284471
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742AA59B77;
	Fri, 12 Apr 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="G0AypBFB"
Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443158231
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926856; cv=none; b=WfDnWJLul9YiLo2nY2mml6yphebqlo1H+O/AmmjE8GEysUsYFw1T9PxX7G1Y6XrIVFLW5odfXw1jKJhGyVF4Y+d6ofLrLyjoiOM5tgFkePKijvYA4HsCYOEkZTE+hNxDGndzD/vP2vYr5UASJp6faJrnaqdmRcVYdc8EXYEeVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926856; c=relaxed/simple;
	bh=HPrU0Wyhp98Idg6SSCatKl3na2JRMkwQ26OormfXCTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axwZA0eOZw65xyZEOceLuO0O7cgGHbsbBlQG5r2e5avSfG5WO+AYIwJwAG6wkCl/vm+c9GO28Ms2mU0FR6f4DniaDflnNFGANvBmAzONBQ8SwLxTfFDwgH9umrHYO8S9/PZqfNgmvsAWTXVuqeHRngHjGobt9z5KBbjDEZz6vow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=G0AypBFB; arc=none smtp.client-ip=62.149.158.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id vGWHrbMkVoq80vGWIrTNve; Fri, 12 Apr 2024 15:00:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712926842; bh=HPrU0Wyhp98Idg6SSCatKl3na2JRMkwQ26OormfXCTI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=G0AypBFB8BBUF6i720nidjUUkLEwRDx5W1ozwjWs/yXhhSZsaBwePJrnyJV5PuaB6
	 GFgmOc+v4S4qiNQ+XcuSeK4bQT8bnFx8HVwq0ucYi1awiH4cSJvr8Ik0mUNfjsypDs
	 Kfi6P4k3I1xtbWwGxtwLwxozoHvuxlfn66rjox5fQCKiwFqJAyL0W9kQP/T/pFlkbh
	 vK3YO1d19STZPRWjBBJCYuOmGdGUx02uWHhe/BJE1cdGQwuijfsvSRX8qMQXxshHeR
	 KNedSVriZclvJIQ/FTrEYdqQi7PjDPlyWffAQDJrUhPbvJMtyadLFGrzFr+lzkBmD1
	 fsGOtDv+sIdNA==
Message-ID: <30e27903-6f12-436a-a1bf-4d74749ac143@enneenne.com>
Date: Fri, 12 Apr 2024 15:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: clients: gpio: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOw0KeEWS6ddACUBkGdfxZ8IgvhfHEeQA6KqVGi6JVdmI6ymCX7gWSeCK4WByCF2oofKHyOHRxJo1GDpeYdAtlxDbTFu4YTZE8kNB4jSsNd8FoTABBuY
 caw6PzL6dAy1bxke/3wSkd+lEi3CRFHf5VoFzT5uqCKHy0NoVTaXZ9PN2KqtEIFaVWODa9TSkgL776FSMktbMWneigo5yHX2NP9AIKnVBLRwWekUN8T98dlz
 yEWIuQOoTK6DkLWY99kOOfkpkmyaFoOW+tVt+4sovY5ajHeTDKB5GAJSJY5QW46fmnGamf/z7v8VKEWj4fHySA==

On 08/03/24 09:51, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   drivers/pps/clients/pps-gpio.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 2f4b11b4dfcd..791fdc9326dd 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -220,7 +220,7 @@ static int pps_gpio_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int pps_gpio_remove(struct platform_device *pdev)
> +static void pps_gpio_remove(struct platform_device *pdev)
>   {
>   	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
>   
> @@ -229,7 +229,6 @@ static int pps_gpio_remove(struct platform_device *pdev)
>   	/* reset echo pin in any case */
>   	gpiod_set_value(data->echo_pin, 0);
>   	dev_info(&pdev->dev, "removed IRQ %d as PPS source\n", data->irq);
> -	return 0;
>   }
>   
>   static const struct of_device_id pps_gpio_dt_ids[] = {
> @@ -240,7 +239,7 @@ MODULE_DEVICE_TABLE(of, pps_gpio_dt_ids);
>   
>   static struct platform_driver pps_gpio_driver = {
>   	.probe		= pps_gpio_probe,
> -	.remove		= pps_gpio_remove,
> +	.remove_new	= pps_gpio_remove,
>   	.driver		= {
>   		.name	= PPS_GPIO_NAME,
>   		.of_match_table	= pps_gpio_dt_ids,
> 
> base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


