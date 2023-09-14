Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0E7A0306
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbjINLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjINLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:47:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B19B;
        Thu, 14 Sep 2023 04:47:48 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso13641631fa.1;
        Thu, 14 Sep 2023 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694692066; x=1695296866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yf8sd4MykaTLQ5lgfem5cP9B4aMgOVdyURQ2Y//BtI=;
        b=hGNuq0Ao5ZorVtWc9zc88ZSCSwrs/ShXpGSsPyJsIqLkpN5yFoz3UTkU2lrMdRdpNf
         m7wGjcXU27/OhU+uIinLS2Tis1G5PxS1oHSizg6I+jsi9coP8SUw0GvcVlAlPWb5dYaF
         cPFEeAeoMWzbIY0fJllgFfhYjMANfdT+dZNa0UsBrvyZMj2/FXbRWTs9FZph4e6a2/X7
         DE7RHuAnIP/fI6cJZxzfzsy4IZWjHdI7+yXALLhQDVh3YHk9J5EJZqeZGA6ZiWnGWZvb
         4p7wnuEjL5e4SbLLVsmPsFsebiCFMDmXzAdfrkHSKh4IEsIvDfZ9eueb/3L2lkOoFKgv
         XjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694692066; x=1695296866;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yf8sd4MykaTLQ5lgfem5cP9B4aMgOVdyURQ2Y//BtI=;
        b=VCY/2yJWZwWM9iz9uuFOBzIEmyqnkoR5ASbPcqR4P4rh89Vd2iMlzNbG7xlVeKBvco
         21z7rnK8Tz5xHemARC8gRK2NcNMekxtRB1CyBMjpx8PSfGF+BPVBKU8FbMm9B7wR4jwf
         hgJfhIHYxQBBvEoNqqyl5Viz+Whi2yTnzn+uJwtOSCMIOVdbJvyw8WIU2L6gfGXPqYhY
         4c/mH6iMbWxmgJwfsrS4Ujxjlp767/aIZuwckZA0tDtVjxLF9MyHaPyuiaD8Nww/M1Gk
         lmiwUV4E5BFNFnNpBke5aSclLoPAMkdEOiOzaQve/0rbFLufu4EAxx1X7YZdihNtK4eu
         fGKQ==
X-Gm-Message-State: AOJu0Yw8LuzLoypO9LV/ewx8XcN3th1+2T/PliPZKDxnPva5PQAn7fjO
        E+iw7U5RHt2bwOfYP+BoeiB9hF4zS8k=
X-Google-Smtp-Source: AGHT+IEzQjqtPQkQKjniAb0a6Hmu/i9+fy44xMKN/oe1brAjHK3IZkiGO+904a7fwTje8Uwg+QkvOA==
X-Received: by 2002:a05:6512:3091:b0:4f8:766f:8dc3 with SMTP id z17-20020a056512309100b004f8766f8dc3mr5547625lfd.32.1694692066237;
        Thu, 14 Sep 2023 04:47:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651204cc00b004fe33e05eebsm248392lfq.203.2023.09.14.04.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 04:47:45 -0700 (PDT)
Message-ID: <b8817140-508e-5c94-e37b-8727cf1abe4a@gmail.com>
Date:   Thu, 14 Sep 2023 14:47:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <20230910142225.5863a850@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 16:22, Jonathan Cameron wrote:
> On Wed, 6 Sep 2023 15:37:48 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
>> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
>> averaging and internal FIFO. The sensor does also provide temperature
>> measurements.
>>
>> Sensor does also contain IIR filter implemented in HW. The data-sheet
>> says the IIR filter can be configured to be "weak", "middle" or
>> "strong". Some RMS noise figures are provided in data sheet but no
>> accurate maths for the filter configurations is provided. Hence, the IIR
>> filter configuration is not supported by this driver and the filter is
>> configured to the "middle" setting (at least not for now).

>> +
>> +static irqreturn_t bm1390_irq_thread_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int ret = IRQ_NONE;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	if (data->trigger_enabled) {
>> +		iio_trigger_poll_nested(data->trig);
>> +		ret = IRQ_HANDLED;
>> +	}
>> +
>> +	if (data->state == BM1390_STATE_FIFO) {
> 
> Can this and trigger_enabled be true?

Thanks for asking this question. Intention was that these are mutually 
exclusive. However, I think that the check
if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
in bm1390_buffer_postenable(), before calling the bm1390_fifo_enable() 
is not 100% race free.

I, however, like the idea of having this check in the buffer-enable 
function - I think it makes the design much more obvious. What I will do 
is adding another check for:
	if (data->trigger_enable) {
		ret = -EBUSY;
		goto unlock_out;
	}

inside the bm1390_fifo_enable() to the section which holds the mutex.


Yours,
	-- Matti



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

