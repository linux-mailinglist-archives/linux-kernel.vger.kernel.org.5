Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC67A48A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbjIRLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241722AbjIRLmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:42:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39394C3;
        Mon, 18 Sep 2023 04:42:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-503012f4e71so2181240e87.0;
        Mon, 18 Sep 2023 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695037333; x=1695642133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VqtxL5s67XQMQv+XRQaf354eoULULKL7lw9uhdGZpw=;
        b=gsgmlcdiCdNLdcszGJyGO5eL3F7DxOdnWs8X98QTx+Gqq4rbuwjBDQV39aA2fHY+by
         BKey1St08/vMHpjBJ6FVnz4E4rhy6HMYu03xiglnEMqGXyf7UBpi9sqxlSAx1dfDYyRv
         m3WpF2Cm174L84Od3Jk+eAHJu8OqqHmruqe06Oq/93h24FnabsLg7Qw7ayueaXdqHN6E
         9T5OMfigx2KX8f92ISXMkbGFny1xk63TnHvtF2qvYa7AQZYBdLjRp9cNVyF1ZuELya14
         fIrGQoNQRFDC5TLV+X5BgBiDNSOH445fz7ij6nRgF+JtNNBz+Syf0xew85iyrZfhBW4U
         lp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695037333; x=1695642133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VqtxL5s67XQMQv+XRQaf354eoULULKL7lw9uhdGZpw=;
        b=TihEdbx9kTgaRVxonXpUGsRitfJxtgsnH6utXvwDLsD1jMhYDi2X6yQMTPLmLRiIWG
         u3qNyURVgGmpWyQxLYcGai8u+06xLEfDFk6mkJDmazrHxre1SlQtMQnwS0yhaJynyM1R
         ZIQkHwT86fX0TlN7pO/L7pFir8UFc0idItfbTrNakojgqIgfDVHTEOtiO2FxMkq1lCTG
         /b/Nj630USGnHAQGPIomsyBUJMc0qeibeGpAR/eaNsdURndahVXsMQ59C4y3GfkXJ3wJ
         WnxRbq5E0QTwzghiZPwb32bl/LvWopg308Wab9tqBVz5DdUMKfti53hMQBiNbbCSvF1J
         jlmA==
X-Gm-Message-State: AOJu0Yyaxr8tUQvpp+7D2HnTASAMj39CYPBr2CvjBOwgf7zQP/wE70hw
        rKgUKA+/mU8iFn1BTOogQCI=
X-Google-Smtp-Source: AGHT+IFafyU+jaXJvIwyzFuHlrYPrdMRQAJYuf4EZPKNBQhmlWesULuoeRipZvWIIhfCWnQzdWpPdQ==
X-Received: by 2002:a05:6512:1319:b0:500:d96e:f6eb with SMTP id x25-20020a056512131900b00500d96ef6ebmr3906867lfu.19.1695037332892;
        Mon, 18 Sep 2023 04:42:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id d27-20020ac25edb000000b004ff91a94156sm286576lfq.121.2023.09.18.04.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:42:12 -0700 (PDT)
Message-ID: <4084c827-abf6-0f15-7957-13db50912943@gmail.com>
Date:   Mon, 18 Sep 2023 14:42:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
 <20230910142225.5863a850@jic23-huawei>
 <b8817140-508e-5c94-e37b-8727cf1abe4a@gmail.com>
 <20230917102615.618dd01a@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230917102615.618dd01a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/23 12:26, Jonathan Cameron wrote:
> On Thu, 14 Sep 2023 14:47:44 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 9/10/23 16:22, Jonathan Cameron wrote:
>>> On Wed, 6 Sep 2023 15:37:48 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
>>>> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
>>>> averaging and internal FIFO. The sensor does also provide temperature
>>>> measurements.
>>>>
>>>> Sensor does also contain IIR filter implemented in HW. The data-sheet
>>>> says the IIR filter can be configured to be "weak", "middle" or
>>>> "strong". Some RMS noise figures are provided in data sheet but no
>>>> accurate maths for the filter configurations is provided. Hence, the IIR
>>>> filter configuration is not supported by this driver and the filter is
>>>> configured to the "middle" setting (at least not for now).
>>
>>>> +
>>>> +static irqreturn_t bm1390_irq_thread_handler(int irq, void *private)
>>>> +{
>>>> +	struct iio_dev *idev = private;
>>>> +	struct bm1390_data *data = iio_priv(idev);
>>>> +	int ret = IRQ_NONE;
>>>> +
>>>> +	mutex_lock(&data->mutex);
>>>> +
>>>> +	if (data->trigger_enabled) {
>>>> +		iio_trigger_poll_nested(data->trig);
>>>> +		ret = IRQ_HANDLED;
>>>> +	}
>>>> +
>>>> +	if (data->state == BM1390_STATE_FIFO) {
>>>
>>> Can this and trigger_enabled be true?
>>
>> Thanks for asking this question. Intention was that these are mutually
>> exclusive. However, I think that the check
>> if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
>> in bm1390_buffer_postenable(), before calling the bm1390_fifo_enable()
>> is not 100% race free.
>>
>> I, however, like the idea of having this check in the buffer-enable
>> function - I think it makes the design much more obvious. What I will do
>> is adding another check for:
>> 	if (data->trigger_enable) {
>> 		ret = -EBUSY;
>> 		goto unlock_out;
>> 	}
>>
>> inside the bm1390_fifo_enable() to the section which holds the mutex.
> 
> You could make the exclusive nature obvious in the thread_handler by using an
> else if () above.

Right. Thanks.

> 
>>
>>
>> Yours,
>> 	-- Matti
>>
>>
>>
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

