Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC87B11C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjI1EwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjI1EwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:52:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03983121;
        Wed, 27 Sep 2023 21:52:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bffa8578feso212458131fa.2;
        Wed, 27 Sep 2023 21:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695876729; x=1696481529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50CeIcBtyDTmcONQhSsmODzCCq0J0/waCFp836ioZfA=;
        b=cxR7ksdCfDSCYmtYWqK0+53si0DWuCOdgEl9BP2mVllFOdb5VWr9jIw7tj59uA3G5g
         unDKLX8xLKLvOlpCIQlJz+bwNh0TYkwVou0cfPX6QamUHO9UPmvKxbz3q7e1G/LB9Uq+
         mtMKAtQro1ZlJpwVXxgCOLtWsC/BGx144yzNGKTGVjXlDhPGHyHcIKQkXX5t1T3wXSuO
         6mgNtlDduj0oH4OwdOLLaB/E+HnFeEhVfii8fuHte54zWs7sRkKCmPx3Cbc1w7Bx6YKN
         xRc03J/YDVCBnlUwFju6Zvm1N5seWi8Sa+1dD2OAVSy3n2zsqXoxve/5Gz5M/TtE6okC
         cX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876729; x=1696481529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50CeIcBtyDTmcONQhSsmODzCCq0J0/waCFp836ioZfA=;
        b=JQq34NWucYUAAszmhMRBOU+hIxc7YXW7GezdXk0wahyJt9wmDH3J7vBYb3h4dFLviL
         uv23pVmmkVWuwNd7KJNg7ODhZ1yBfphMQHh5HjuF+3BvWNW0jw8UlEnfWbaDa5IKX5Gn
         2PHscJ55uN222KVqYZeOab7A25wx6icHGHSvm9B6kyUE8JneSubK3aVu3gnw6oC3eaAw
         iB3DvqAdx3tSqTaoUH6LNxq36/dephRdLKTuGEB7omcg1ZQQcEjRC840M0666qDk8I4w
         lAfMkeobLPXNbNNqH6GikV2KyQH56twXoe84t9Fk/o87dKYtJO2Ky8UtOlIRLLuMOLuz
         AlPg==
X-Gm-Message-State: AOJu0YxWYU7E+y4KiRd6+9b9PHb8as0z4QZJ/BI7gQVJ5HuQ6pI23rZU
        dajj/Dy8ArER3Pk/Lyp5jAc=
X-Google-Smtp-Source: AGHT+IHRPWejVElofn9/9Ioro7bntPjotq0g/0Z86Cj+JgSnoqhwy1+TcB94wcEGwXXVrN0+igLJ0w==
X-Received: by 2002:a2e:9854:0:b0:2bb:78ad:56cb with SMTP id e20-20020a2e9854000000b002bb78ad56cbmr85554ljj.37.1695876728814;
        Wed, 27 Sep 2023 21:52:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e7a15000000b002be5d222c60sm3321524ljc.102.2023.09.27.21.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 21:52:07 -0700 (PDT)
Message-ID: <4f352a44-1fe2-f44a-20ba-efaed874b1b0@gmail.com>
Date:   Thu, 28 Sep 2023 07:52:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Support ROHM KX132ACR-LBZ Accelerometer
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1695819243.git.mazziesaccount@gmail.com>
 <CAFukWp0TM+v7Y93gFuHL2_ihefxxPmDkGT4R9nmruL70D7KNZA@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAFukWp0TM+v7Y93gFuHL2_ihefxxPmDkGT4R9nmruL70D7KNZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 17:30, Mehdi Djait wrote:
> Hello Matti,
> 
> On Wed, Sep 27, 2023 at 2:56 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> The ROHM KX132ACR-LBZ is an accelerometer for industrial applications.
>> It has a subset of KX022A (NOTE: Not KX132-1211) functionalities, dropping
>> support for tap, free fall and tilt detection engines. Also, the register
>> interface is an exact subset of what is found on KX022A (except the
>> WHO_AM_I register value).
>>
>> This series adds own DT compatible for the KX132ACR-LBZ and also own
>> chip-info in driver to allow handling the different 'WHO_AM_I' value.
>> The separation of the Kionix KX022A and ROHM KX132ACR-LBZ does also
>> allow adding support for the KX022A tilt/free fall/tap engines which are
>> not present on KX132ACR-LBZ.
>>
>> Matti Vaittinen (2):
>>    dt-bindings: iio: Add KX132ACR-LBZ accelerometer
>>    iio: kx022a: Support ROHM KX132ACR-LBZ
>>
>>   .../bindings/iio/accel/kionix,kx022a.yaml     | 10 +++---
>>   drivers/iio/accel/kionix-kx022a-i2c.c         |  4 ++-
>>   drivers/iio/accel/kionix-kx022a-spi.c         |  4 ++-
>>   drivers/iio/accel/kionix-kx022a.c             | 34 ++++++++++++++++++-
>>   drivers/iio/accel/kionix-kx022a.h             |  2 ++
>>   5 files changed, 47 insertions(+), 7 deletions(-)
>>
> 
> You could also mention this device in the list of supported devices
> under drivers/iio/accel/Kconfig

Oh, indeed. Thanks Mehdi!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

