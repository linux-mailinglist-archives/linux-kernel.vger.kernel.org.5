Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8D7F36D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjKUTfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKUTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:35:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF6191;
        Tue, 21 Nov 2023 11:35:49 -0800 (PST)
Received: from [100.117.177.39] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B2AA6602F3D;
        Tue, 21 Nov 2023 19:35:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700595348;
        bh=/VVJWABCA7OL+A9POx+GinmD39+Xcj9nJKZjqipf/BM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FXyvXTAY5u5vyGIr9fOEpnrHF2cv5bq9yC3SaO0eKxQZosbVe5MW9BQ/mxuRsaBQj
         9K/WM8nrvt9Z8lHOz+9JKYBtQVGjsA9ZTVLJD7a8a6vw+Jdohsp1BVtuZIJ4m1X3kH
         Qug3PUYCRChei4tWj8eW8otT5kwtNhHh9Q3X7qXXLYQoqIfof0Gy6FvKT8w8mKtDpd
         +Bd23TWMx7WrWnx5QHrddDoySQCRTMag753bpIVXYbx8/Q6n1RG95jviuPyFsRyokC
         upnWkL3JNdEHyUmP2xtgAvty5imYK7H52y82pLRaq8beacvoeVoY7LkP5IPSamKwq0
         f86E78pJjLEUA==
Message-ID: <06d3c2f7-50b4-b44d-fa75-8ca6a1a26d89@collabora.com>
Date:   Wed, 22 Nov 2023 01:05:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] iio: light: ltrf216a: Return floating point values
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de
References: <20231107192005.285534-1-shreeya.patel@collabora.com>
Content-Language: en-US
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20231107192005.285534-1-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/11/23 00:50, Shreeya Patel wrote:
> For better precision of input light intesity, return floating point
> values through sysfs instead of an integer value

Hi Jonathan,

Gentle ping for this patch. I am not sure if you got time to look at the 
patches
after LPC but just making sure it doesn't get lost between bunch of 
others :)


Thanks,
Shreeya Patel

>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>   drivers/iio/light/ltrf216a.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index 8de4dd849936..68dc48420a88 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -234,7 +234,7 @@ static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
>   static int ltrf216a_get_lux(struct ltrf216a_data *data)
>   {
>   	int ret, greendata;
> -	u64 lux, div;
> +	u64 lux;
>   
>   	ret = ltrf216a_set_power_state(data, true);
>   	if (ret)
> @@ -246,10 +246,9 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
>   
>   	ltrf216a_set_power_state(data, false);
>   
> -	lux = greendata * 45 * LTRF216A_WIN_FAC * 100;
> -	div = data->als_gain_fac * data->int_time_fac * 100;
> +	lux = greendata * 45 * LTRF216A_WIN_FAC;
>   
> -	return div_u64(lux, div);
> +	return lux;
>   }
>   
>   static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> @@ -279,7 +278,8 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
>   		if (ret < 0)
>   			return ret;
>   		*val = ret;
> -		return IIO_VAL_INT;
> +		*val2 = data->als_gain_fac * data->int_time_fac;
> +		return IIO_VAL_FRACTIONAL;
>   	case IIO_CHAN_INFO_INT_TIME:
>   		mutex_lock(&data->lock);
>   		ret = ltrf216a_get_int_time(data, val, val2);

