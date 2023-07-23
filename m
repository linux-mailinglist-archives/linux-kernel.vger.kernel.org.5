Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12E75E1BE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGWMPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:15:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17651BF;
        Sun, 23 Jul 2023 05:15:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52227142a27so634280a12.1;
        Sun, 23 Jul 2023 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690114512; x=1690719312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0cVsqWKdMS3mBx88flKmPv+jMfndkNyVojR/TC2ilk=;
        b=U+m8kc9k94ctRV4OWsCztKmwGJTETjk2SJ/HsKmZugWDv4oo2R67wmytQlOWnxF4N9
         gRxBc38039ZxluCRywchZZ0uYYhSoLVg+GnGIR/4arONyM76wjxYfq4/bZzp6MpUvn69
         0e7ZdxQ5R9nynlkO/gWWA1TCDdGi6wSUrvt5Zil3RZeZYNtL7Jsi10VOjFJyMU+oYEnX
         mfnbtPWwh3imSNzu02XJqeZO4nMAz1ar8s1S2rDwgP9N3Xwye9B6vAIEuhLzaLQf7qFh
         A/GM6TESxCpP1iMEWozESBBu9gHykqYEni1I0AyNIcLPHcoj9H4vITsKl1eiJiNB92dF
         GMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690114512; x=1690719312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0cVsqWKdMS3mBx88flKmPv+jMfndkNyVojR/TC2ilk=;
        b=FssKTDB4srFnJpBlXN1eCvtD/nMx02tDE766Is9JBgAb1gcdCBETaxlAG7gFwleVvP
         AjcDHGlUOs+zBfufA2Z0FMtueOq4LWfuRA0L7GUutN3l51HCHhqRs6mTY/0JAd6eUnuu
         8i+xfnUIb0qpPO+0slD6YxK4fqZZHzy3RuYaHwy+eL292bwlij8MiugruTFrxVDBLYWa
         EGk3znjQhZ1MjaTRi/adVHQZ6odA1P9sL5sgYYYbY5woVQMPNyJg9r4ZXLA09A3LTeFF
         GK/n2ms+oW3TUO/yj9mIuHnMWPOapfVpoMnH2+LdvzUi8ehEN46A32M384OPpD9Gv2XK
         zspQ==
X-Gm-Message-State: ABy/qLaJtxl7tiZtPt/Cv8WZhPZQVru6WTaOzGkTprwcyG/jiXcAasMw
        5w4c9P1D0ZsJ4F1+E7KK7Ao=
X-Google-Smtp-Source: APBJJlFhm4vB4wLbnZSCL5AYtDx03hNwuJMydCMROhqtB8Dzgj01WXS+MOKmtEgKKuczoWXJfPAE/Q==
X-Received: by 2002:aa7:c143:0:b0:522:2111:1063 with SMTP id r3-20020aa7c143000000b0052221111063mr1838477edp.18.1690114512123;
        Sun, 23 Jul 2023 05:15:12 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id p6-20020a05640210c600b0052217b3a10dsm2028995edu.63.2023.07.23.05.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 05:15:11 -0700 (PDT)
Message-ID: <15ee98bd-b92b-8a34-e3f9-a1537edf2da9@gmail.com>
Date:   Sun, 23 Jul 2023 14:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] iio: add MCP4728 I2C DAC driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <3d08130fcb093fea3f755848690db9b2c8e1cb75.1689857295.git.andrea.collamati@gmail.com>
 <20230720201311.0142db3d@jic23-huawei>
 <739ea3c7-7181-183c-799d-a3f9403c7f66@gmail.com>
 <20230723124101.1af2ae2c@jic23-huawei>
From:   Andrea Collamati <andrea.collamati@gmail.com>
In-Reply-To: <20230723124101.1af2ae2c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/23/23 13:41, Jonathan Cameron wrote:
>>>> +
>>>> +	if (mode == MCP4728_VREF_EXTERNAL_VDD &&
>>>> +	    data->channel_data[chan->channel].g_mode == MCP4728_GAIN_X2) {
>>>> +		dev_warn(&data->client->dev,
>>>> +			 "CH%d: Gain x2 not effective when vref is vdd, force to x1",
>>>> +			 chan->channel);  
>>> Even better if you don't present the option at all and wrap it up in the
>>> standard ABI of _scale
>>>  
>> I think that the solution could be:
>>
>> - Removing custom ABI (vref/gain)
>>
>> - Initialize them at device tree level using two 4-elements arrays.
> If doing with device tree, they should reflect something that is a characteristic
> of how the chips is wired up.  So you would need to explain why that is the case here.
>
> However, I'm still not understanding why _SCALE is not appropriate here.  We have
> a small set of options with well defined scales.

SCALE is appropriate. I didn't know that scale_available was a standard ABI.

I will follow  the implementation done n https://github.com/torvalds/linux/blob/c2782531397f5cb19ca3f8f9c17727f1cdf5bee8/drivers/iio/dac/ad5592r-base.c#L487
