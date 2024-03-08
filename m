Return-Path: <linux-kernel+bounces-96717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD19876086
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9612B28126C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA75C52F6C;
	Fri,  8 Mar 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Qq2Q+I3z"
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC3CA78
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888443; cv=none; b=dx8BYxRTelf4bOYocvmijWf8Ti8+GrCqKjdb3pZ0ka9Kfo3hrd/Re6NRMS4XPlpFdO+jI7aom0++uxDhxLTG+eTXbXSmUXEP3bj9dWkf5QXPsQfMCC0oRzonm3DxPFPWOiUc1GCoYZvh7F2/tMzgJhk6jRe6evnsrG2YA4UiQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888443; c=relaxed/simple;
	bh=HPrU0Wyhp98Idg6SSCatKl3na2JRMkwQ26OormfXCTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPFJNnUKiOSH8VKfPLbK0WljMpGAAaDqy5TeXikj5ph9WtjFtm5DS+f9q2aNB4sAa5R/VkkSAkS1VDqlZ/E5YqzIEICNKWbYne3sxlVrcrM0l62FuVH9k8YqpqOJm2yE/9WU4rc1l+lvxZmvaztTiAqwDVaVrCchDL+WuMtinIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Qq2Q+I3z; arc=none smtp.client-ip=62.149.158.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.59] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id iW2jrRVXfIrdViW2jrlbmd; Fri, 08 Mar 2024 09:57:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1709888250; bh=HPrU0Wyhp98Idg6SSCatKl3na2JRMkwQ26OormfXCTI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Qq2Q+I3z/JcHh73/vXv5Wem6JQC76uRqjD0UKt0CUGmTnnrcM+YDRltHYhKYaL7LR
	 3j73XPxXu/7XBTdSC6rgZcKgh4fZhwxI7iuDaEu2qID/jXlBr4YOUpVDwdAxfSpbD4
	 /GtgoWzteOuTfoP3M7wCDljMs3mFifb5XpTMAMaED5jHkNXb6bpjeQU3tMTTMzmMbk
	 CMbNhmb26SHlyTg+y+owCvvjTCS5o5CevxoaSEn6Xyq0omJD1g+emHGehkwGbVGtj4
	 OrJ78T14Iyi5E8DS0DnpgIsG9P4JEGI/hF3sftd2+jY4PhPgjQgP8GFEYaFKIGGb4M
	 732aA6MJraWwA==
Message-ID: <6d73b0a4-34e6-44ce-8757-4f4931c3da85@enneenne.com>
Date: Fri, 8 Mar 2024 09:57:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: clients: gpio: Convert to platform remove callback
 returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDN1goyN/Wfs4tz/HSwwvTn0Euf8tOoOPrB9EijwWLBOQwxZsuwfmkxCL2PC6iCEn+kYMnXjZFyu1csMHtuAZlWfrJLEf3QD71BkKdTBj3v7JEpyNbu9
 XrlsQzxaNi8wQw6+lMl8C8cpzemXpMVg84QJ4179Af9Q0EAAuOZ4SU8NTWebhrIz6EwyX7scK7z9tRCbPGaamDUvxMgfEOl0IZtjuaswgJbZrqWgtGVIm2Cz
 phdQmVqPk8Yxwqm3Oblsnr59IFwwie+ZKWTN4BTPu/w=

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


