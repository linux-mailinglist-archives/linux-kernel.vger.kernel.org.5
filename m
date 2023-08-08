Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0A7746F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjHHTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjHHTHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:07:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE0A1252C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:29:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so89907151fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512152; x=1692116952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UL57MaBdPM6++P437QDJfGupULs2TDGGdbQMca9U3hM=;
        b=LS/H5QrueZXoKVG7iRDUNL6AkPo9xS5bdiweHMPDS3LhQg1efIWBJT6BL4GinveSNG
         ZuuiJfD+lgjBS9rLC/vxUKd8HTxg1hPFj7DbxL+BqO21/rw/bfrEmInJViXq6UuQqHCG
         IiNv0WBYbUlx/FOm5e70I8rd0drQUVTPDAzIqndmo2RqsKVMpFFIM9FLiVTd0375VLJe
         Q81pX7ZhqHVJCACj3l06iObQFMBemu1GialgaGFJRsxIzybF1GxmN4JaIDvOUB4pXWCq
         zzQI61ET0NOJox7Umj5kYX8Xn3rfQNZSuNbu05vMNB/77aJLw7JM8R0+6O/7zGLujTY2
         4Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512152; x=1692116952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL57MaBdPM6++P437QDJfGupULs2TDGGdbQMca9U3hM=;
        b=HIEjrfhm730pu7RQz9RFRhOB2djrK0tZDZyGNmn+PTvf5ZRSXGA1by/1GRa2z7QHct
         Y5q/kLu6H+cvQEjaeZQa5q0My6s2ItW31dqplBLUozFiCHi8ANNhVhR3fnxCR0wNGOy/
         RlbBgESHHRF6GECEfOBKbVK8SEXCqW5JaHG6idTjI4QCdnAFnLyUDm02C/Jibl5ZGz+z
         FF2Uce6UGvqp9Tkp7ypgcHhOcW9e1SkKdSzJY2V2RrdVCbpaelzhxA6jsBxuImJrBVDJ
         8vx8Re4I+R9/8qnIgOAErvqSNAEs2QkTQMWmva5BA4r2ZQmZeCQlYYISis8i2yip+TpA
         e4WA==
X-Gm-Message-State: AOJu0YzY5Yq4UX143gPB53N+Mw+mYFajHEkymVCHGVJ1dMLCcZ5l0jUQ
        T/IwHisQDPSicCzkVJf3xouRPTL80Bd0F1laKPs=
X-Google-Smtp-Source: AGHT+IFluzaGKTZK8dhiGf/jIxAe/vY+rM3Cg47RyOvynYVtONEW1n8zg4Kg7M1SwOUHcoCqsotjVw==
X-Received: by 2002:a17:906:10cc:b0:99c:c50f:7fb4 with SMTP id v12-20020a17090610cc00b0099cc50f7fb4mr5853025ejv.1.1691480985744;
        Tue, 08 Aug 2023 00:49:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id os14-20020a170906af6e00b0098963eb0c3dsm6235990ejb.26.2023.08.08.00.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:49:45 -0700 (PDT)
Message-ID: <74abc9e0-ba9a-d7ec-4f1c-815f8e351701@linaro.org>
Date:   Tue, 8 Aug 2023 09:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/2] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230807071831.4152183-1-marcus.folkesson@gmail.com>
 <20230807071831.4152183-2-marcus.folkesson@gmail.com>
 <ZNETcVNsEmvK0KKH@smile.fi.intel.com> <ZNHtMBG4yHpgL1kj@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZNHtMBG4yHpgL1kj@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 09:22, Marcus Folkesson wrote:

>>
>> ...
>>
>>> -	ret = mcp3911_config(adc);
>>> +	ret = device_property_read_u32(&adc->spi->dev, "microchip,device-addr", &adc->dev_addr);
>>
>> Why not spi->dev? Ditto for other uses like this.
> 
> After all, I think it is better to stick sith adc->spi-dev to be
> consistent with the rest of the probe function. Change to spi->dev
> should probably be a seperate patch.
> Do you agree?
> 

You can first simplify the usages and then add new family support
already using spi->dev.

Best regards,
Krzysztof

