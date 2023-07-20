Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC9975AE18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGTMQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGTMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:16:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B18F2115;
        Thu, 20 Jul 2023 05:16:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so986200a12.2;
        Thu, 20 Jul 2023 05:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689855386; x=1690460186;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1jBjQi0KhEajIiTYUBIV9zjJYw88SZt2ebRbzw25T54=;
        b=Rx0IAvtvCgI478Tkv9nAG5r3qxTK+G/bHLDDC8u16yEs67xixXmUqwZS9nLOPKdM+W
         ph77qh0JHo1ss4Lu8VDfmU3l6eTWWDcDnw6QEmEr0njduggDYjOHgK/tuLlfHKp1NY8G
         Z/CV/k3C3x4OqXSsVfiZf+Q4iEPIADB4ELX8OSnOYuZWT2s5vZ464il1TJErf4wmwZ1o
         HfUrAZLINzpFrQmdb8/WIhcC88nIMn7fFDT8fZgp9sqqIVm1FxJv5cb/w+1aDJcAmG4Y
         zXlEvKnvjlZqc/D1vwr1GEjfUoJoIU3k1LgeemK8rSr7o4nBDaMVq+cnzouZvz5JyM1A
         p5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855386; x=1690460186;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jBjQi0KhEajIiTYUBIV9zjJYw88SZt2ebRbzw25T54=;
        b=C0sO1MtI5AV9yHMBItUiVngaro0FEBPUYW0tnXaJBPa6DVeIa5x112Pne5BDY6EyUf
         mHx3RLyFHTcAbCHalBqgh6sDUsFLAXXgwcarHy5uD8N3YtaSvzp5nmQ+AxnocbA8ht5T
         5BYDDQcNLDJAGHfDoJwVZcYvT0nmSyM4LYPzoKEZbgJz3MIX926qp5ZP4XFjS+D76epR
         +YEzV8gIbETMPFAsIpy5a1czr0bIa6yZkC0ICaDCQj+FZ5kzKfASmtvMvdIFPxCm6ptQ
         kNBCXGvIviQ+4/xTaOk4T14aaM/SnE/WFE4DXbczytG2JpWB+YXmYnPh9zoyaRQnY756
         bniA==
X-Gm-Message-State: ABy/qLYN0sSL5cpgNGgeI7c70qHFqgF0FNzq9vrzPhYcPRw3uvty6hM5
        K8mN9tSdsXseSC8OuvXDFBw=
X-Google-Smtp-Source: APBJJlG7WK2iF0b+9kUZXbq11rWoRyzLjsln3AKLNuSgbBGU6mf9LZUG7nRD/QWLPX4YXC9MQvMLHg==
X-Received: by 2002:a17:906:18:b0:993:e752:1a6f with SMTP id 24-20020a170906001800b00993e7521a6fmr4504228eja.6.1689855385738;
        Thu, 20 Jul 2023 05:16:25 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id lf26-20020a170906ae5a00b0098e42bef736sm628637ejb.176.2023.07.20.05.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 05:16:25 -0700 (PDT)
Message-ID: <b82ee6d3-fa33-1e5a-be9d-7f13259dbcda@gmail.com>
Date:   Thu, 20 Jul 2023 14:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrea Collamati <andrea.collamati@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: add mcp4728 I2C DAC driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1689541455.git.andrea.collamati@gmail.com>
 <75145a12-a85e-e553-d32f-3212357c4a7e@gmail.com>
 <bd3890e4-3880-b292-5b9f-e9443185681c@kernel.org>
Content-Language: en-US
In-Reply-To: <bd3890e4-3880-b292-5b9f-e9443185681c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/23 08:38, Krzysztof Kozlowski wrote:
> On 16/07/2023 23:26, Andrea Collamati wrote:
>> mcp4728 is a 12-bit quad channel DAC with I2C interface.
>>
>> support for:
>> * per-channel gain
>> * per-channel power state
>> * per-channel power down mode control
>> * per-channel vref selection internal/vdd
>> * store current state to on-chip EEPROM
>>
>> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
>> ---
> What changed? Are you saying you ignored entire review you got?
I didn't ignored, but I didn't list the changes. I will look at other emails to understand how to write v2 v3 ... changes..Sorry.
>> drivers/iio/dac/Kconfig | 12 +
>> drivers/iio/dac/Makefile | 1 +
>> drivers/iio/dac/mcp4728.c | 635 ++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 648 insertions(+)
>> create mode 100644 drivers/iio/dac/mcp4728.c
>>
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index 3acd9c3f388e..fa1516f6a285 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -389,6 +389,18 @@ config MCP4725
>> To compile this driver as a module, choose M here: the module
>> will be called mcp4725.
>> +config MCP4728
>> + tristate "MCP4728 DAC driver"
>> + depends on I2C
>> + help
>> + Say Y here if you want to build a driver for the Microchip
>> + MCP4728 quad channel, 12-bit digital-to-analog converter (DAC)
>> + with I2C interface.
>> +
>> + To compile this driver as a module, choose M here: the module
>> + will be called mcp4728.
>> +
>> +
> Why two blank lines?
>
>> config MCP4922
>> tristate "MCP4902, MCP4912, MCP4922 DAC driver"
>> depends on SPI
>> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
>> index addd97a78838..5b2bac900d5a 100644
> ...
>
>> +
>> +static void mcp4728_remove(struct i2c_client *client)
>> +{
>> + struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> + struct mcp4728_data *data = iio_priv(indio_dev);
>> +
>> + iio_device_unregister(indio_dev);
>> + regulator_disable(data->vdd_reg);
>> +}
>> +
>> +static const struct i2c_device_id mcp4728_id[] = { { "mcp4728", MCP4728 }, {} };
>> +MODULE_DEVICE_TABLE(i2c, mcp4728_id);

Sorry.. I fixed but then I code formatter replace the old one. I will pay more attention..

besides clang-format and checkpatch are there any other tools to avoid these formatting errors?

Thank you

> Yeah, my feedback was ignored.
>
> That's not how it works. Anyway, I doubt that it should be a new driver.
>
> If Jonathan agrees to have new/duplicated drivers, then fine with me,
> but then don't ignore the comments. Instead:
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
Ok.
> Best regards,
> Krzysztof
>
