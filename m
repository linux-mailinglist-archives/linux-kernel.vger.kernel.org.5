Return-Path: <linux-kernel+bounces-32941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C5D83623C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8538B1C26186
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570E3D0A1;
	Mon, 22 Jan 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="GqZUmf2R"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208B3AC19
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923572; cv=none; b=hqf99D0nAE+XfZlcUypvHpNHaTRUGPHpdlMhLbIFOi7vx/LZ3h7YpWovg1la0/LcFThsqaZf3CY1b9f1Gvgi7N+2csc8Qve2mxSiChFVo70oz9E9A+JchMgNAzHf7Kp6+SURlhMj0e/e46IE1VNwZzUgP/QjZP9qzHC9p/v9STE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923572; c=relaxed/simple;
	bh=hDOlhtMQCv0ZUcTnLwP3plzcjZq49aIywW1xbB/0o9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gn5bwZj9lTnzNE6uVkeojIduUL0jSKvBUXTORI7ZSq5aLVxpYOSws8+nI8zp2dG4ix+SuYxM7l1ncU0/DpPtvdzPGBvgaooGKszqF7Q2VOS58PjA4u89RlvaXLGQ9dgZxrjX+GqmenHj2wFX1B8aerYHWPh5WDWdErAV4JwshNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=GqZUmf2R; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6dbd7f1a300so1381088b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705923570; x=1706528370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1EUmMR17Pa8J0jAlZypSL6+g8Srm5M13PwsXUfYUP9Y=;
        b=GqZUmf2RS2u6G9DLvItocko9fkEd5HGlK2QxF64DnFsavfFjh7Y7K5eByT1uxwyFdn
         6MatjOdQn4Pj6bg8UIbwXaCCHppufkxOGA31S5Rl5SktWyXwRhh5NLZ8QeE0nMh1u+q1
         D7WZRcAgqcZHL6yDUEgSSx0Kd0AZcnaKzvnM7+Y6CGOrXO2zPBdmVwCc0RPqVPbRO/f+
         rKZzZtWprWZBWoGRSprcV0vSc/OnpVRMBDMCz0njR39tk+Yrl/wKUbvrC8aTZfIlwTO2
         NN6raBM6mtiH2DkFXlpqeZIhEwUT+HcduMK9VpGv4Sb1RrJum52J2qjoNWz30u9fyY2Z
         y5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923570; x=1706528370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EUmMR17Pa8J0jAlZypSL6+g8Srm5M13PwsXUfYUP9Y=;
        b=eH5lVuSQ06sDxbPXVUsHjacs/WRA6GGVD2mxDAhjgfuM/4RWgwk4z15/IMiepV9Uhe
         /wjbeTGgiJkB/vZqFhMpPL5MO22StQtpwyC7EdRKfe5P/3QeLJw9M1KVyxrvyHeEQEyh
         GoW7cc3w4DjAmkHKUxBv2TMxitb6G0JzNxCf4mSg2286+0uEgd5yVA4tcK7HBYE+KO1X
         +NBrPamGG5zSV66vG4q5tStiulJOJs7gO21jqnOtBytA4HFNFToaxdxiMdRmN85xsOub
         Dqc8HRr8bp8clDAdkkmWTFpG/BDIYxKIHQ2iJEfNsTaNagipF8UIfcVKnjMf8+U5sSyR
         Ht/Q==
X-Gm-Message-State: AOJu0YzRyGLZuAf6vK02kUTlmovQ4KEjaJuTqmLVIjmMHtiwrTvf8IhK
	XxZx8tMWEB1+Dmler3yy34ciVMlBiKb2WzIxA3HI+OSWUwpKfHkZS3wJ7SPQLHU=
X-Google-Smtp-Source: AGHT+IHely7tfA2gE24XEktiw5Yd+K8wVvpQCBuJfsIqOfhQT8xeJ7ethlDWbTCHUoq/dgyt2d1N7g==
X-Received: by 2002:a05:6a00:a86:b0:6db:ad5c:80b8 with SMTP id b6-20020a056a000a8600b006dbad5c80b8mr5839715pfl.7.1705923569747;
        Mon, 22 Jan 2024 03:39:29 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id t187-20020a6281c4000000b006d99125b114sm9817341pfd.65.2024.01.22.03.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 03:39:29 -0800 (PST)
Message-ID: <05727e6f-3355-4572-96e4-0b2ac4d8dca7@tweaklogic.com>
Date: Mon, 22 Jan 2024 22:09:19 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andriy.shevchenko@linux.intel.com, anshulusr@gmail.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 javier.carrasco.cruz@gmail.com, jic23@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
 matt@ranostay.sg, mazziesaccount@gmail.com, robh+dt@kernel.org,
 stefan.windfeldt-prytz@axis.com
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
 <8a7f03b6-caca-4fbb-8093-0ba87bd2e850@wanadoo.fr>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <8a7f03b6-caca-4fbb-8093-0ba87bd2e850@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/1/24 19:52, Christophe JAILLET wrote:
> Le 21/01/2024 à 06:17, Subhajit Ghosh a écrit :
>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
>> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
>> channel approximates the response of the human-eye providing direct
>> read out where the output count is proportional to ambient light levels.
>> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
>> caused by artificial light sources. Hardware interrupt configuration is
>> optional. It is a low power device with 20 bit resolution and has
>> configurable adaptive interrupt mode and interrupt persistence mode.
>> The device also features inbuilt hardware gain, multiple integration time
>> selection options and sampling frequency selection options.
>>
>> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
>> Scales, Gains and Integration time implementation.
>>
>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh-ojZBjWEdjYKukZHgTAicrQ@public.gmane.org>
>> ---
> 
> Hi,
> 
> a few nits and a few real comment/question below.
> 
> Just my 2c.
> 
> CJ
> ...

>> +
>> +static int apds9306_read_event(struct iio_dev *indio_dev,
>> +                   const struct iio_chan_spec *chan,
>> +                   enum iio_event_type type,
>> +                   enum iio_event_direction dir,
>> +                   enum iio_event_info info,
>> +                   int *val, int *val2)
>> +{
>> +    struct apds9306_data *data = iio_priv(indio_dev);
>> +    int ret;
> 
> Other functions below that look really similar have a:
>     guard(mutex)(&data->mutex);
> 
> Is it needed here?
You are right, don't think so. Regmap lock is being used.
I will review the locking mechanism. Acknowledging all other comments.

Thanks for the review.

Regards,
Subhajit Ghosh


