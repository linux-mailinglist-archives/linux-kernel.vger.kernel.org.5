Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAFF7BBA13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjJFOSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJFOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:18:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE168C5;
        Fri,  6 Oct 2023 07:18:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9936b3d0286so403045766b.0;
        Fri, 06 Oct 2023 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696601919; x=1697206719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmTNhahVlLjLwaQlHbv41r5WgbZRC4QhjNNkQIXElyw=;
        b=XoiK9GUJuSlOBU0sdAEfniSGdyRyMqBn3R/cjtwRgVXJbsAaQbifbDH3H8fsAb938Y
         QMaV6MZHzbIwADP+tScFvnBjrTUMyxrRmiLIsB1E33hSiY5fPk/X8tv2qPRQGX+eTiZW
         yckRc1er9Glpp3YXbbBD0Hdicy09CqA9mSmen5oRCrTwBHpH1lxBlGqw8LXviDXnPjQx
         7jq/TGXLqH7hN1GX7NdXBXunhW3Ao4pB8uj1VEnT2vQz6rUjPg4H/jpvKBB1xH8JUmnF
         7JNS19Hvi3mrsBfYEbYe1lhKiiF97ZMUlOcQSC+FG4gVfA930wuwGIafmnKtoF+acD50
         FQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696601919; x=1697206719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmTNhahVlLjLwaQlHbv41r5WgbZRC4QhjNNkQIXElyw=;
        b=ZBsszL3rzmK09bwmkdq9P1YSyG+oGyi7/DKqfhNXLCwDk4Hq6xWSHUwoZfFloEtxrv
         ua6Beaxt1usDu6nAnHJ2DGSAQ2QlRv3IPJQgO8YG4ElZK5ItiSpH55v5o8hrRoXxipMh
         +LdWQJK3uhCCHgwFnnkRDn9F/c9a27CVuJrLRJeU+uzzxqJlOSgvhc2f4hZhwXZ8xYBf
         S3qetoBAZ2bw8EQXxMfr2ngXFZUZWQZ/L2OYBmRrBZAgNO5DkHxqG5mJMbTKako03363
         uuloMb7+YFuJqj6t3rpNbh8VRUTd3E+vOQtdx92afxb/4hkZaSGKb1P1TlvDTJ/IQnfV
         6ztw==
X-Gm-Message-State: AOJu0YxIoX06ovzOEvJc9XiGl2126UoovqfOVOef5GsJUEbZ1jAbcS+m
        MB4hh5+kVlD3iQoxxnaeYaBhQbyCZnsyBSrL
X-Google-Smtp-Source: AGHT+IFPssNvdDSrhsENbJLGoa0rvZp3zpleLsg6gyuJ+0YhysS296jJ15ngd5HgjjZ1TuGY4WGJGQ==
X-Received: by 2002:a17:906:308c:b0:9ae:829e:d930 with SMTP id 12-20020a170906308c00b009ae829ed930mr8031948ejv.9.1696601918987;
        Fri, 06 Oct 2023 07:18:38 -0700 (PDT)
Received: from [10.76.84.110] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w19-20020a170906481300b009b9720a85e5sm2932839ejq.38.2023.10.06.07.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 07:18:38 -0700 (PDT)
Message-ID: <07afa29c-bfef-72dc-d471-f72dfcebe342@gmail.com>
Date:   Fri, 6 Oct 2023 17:18:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/2] iio: adc: ad7173: add AD7173 driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231005105921.460657-1-mitrutzceclan@gmail.com>
 <20231005105921.460657-2-mitrutzceclan@gmail.com>
 <20231005180131.0518f46c@jic23-huawei>
From:   Ceclan Dumitru-Ioan <mitrutzceclan@gmail.com>
In-Reply-To: <20231005180131.0518f46c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 20:01, Jonathan Cameron wrote:
> On Thu,  5 Oct 2023 13:59:22 +0300
> Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:
> 
>> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
>> which can be used in high precision, low noise single channel
>> applications or higher speed multiplexed applications. The Sigma-Delta
>> ADC is intended primarily for measurement of signals close to DC but also
>> delivers outstanding performance with input bandwidths out to ~10kHz.
>>

...

>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = ad_sigma_delta_single_conversion(indio_dev, chan, val);
> 
> It's fairly usual for it to be safe to grab a single conversion when the
> buffered mode might be enabled.  Do you need an iio_device_claim_direct_mode()
> here?
> 
ad_sigma_delta_single_conversion() calls iio_device_claim_direct_mode()


>> +static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
>> +				   const unsigned long *scan_mask)
>> +{
>> +	struct ad7173_state *st = iio_priv(indio_dev);
>> +	int i, ret = 0;
>> +
>> +	iio_device_claim_direct_mode(indio_dev);
> 
> This looks wrong.
> Firstly iio_device_claim_direct_mode() can fail so you always have
> to check the return value. If it does fail and you then call
> iio_release_direct_mode() it is unbalanced release of a mutex.
> 
> Secondly update_scan_mode is only called as part of buffer setup
> and there should be no races around that (and the mutex this
> tries to grab is already held.
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-buffer.c#L1265
> )
> 
> If you are protecting something device specific (rather than
> the mode) then a device specific lock should be taken.
> 

The use of a lock was inspired from ad7124, but from looking at it the only use it has
was to protect concurrent access of the device setup from write_raw (that now uses ...direct_mode())

I think it's best to drop this lock. 


>> +		chan[chan_index].differential = fwnode_property_read_bool(child, "bipolar");
> 
> bipolar doesn't normally == differential. 
> You can have unipolar differential (just that you can't get a negative answer)
> Perhaps just a terminology thing?
>

This device supports only differential channels. Here, the differential flag is used to show
if bipolar coding should be used.


>> +	st->info = device_get_match_data(dev);
>> +	if (!st->info)
>> +		return -ENODEV;
> This works for the cases of DT and ACPI but not for anyone just
> using the spi_device_id table. 
> There is spi_device_get_match_data() to cover all options.
> 
I could not find the spi_device_get_match_data() function in the repo.
It appears however as a suggestion from Andy Shevchenko in a thread:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2382960.html
 Is this it? 
