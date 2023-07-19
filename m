Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256A7759B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGSQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGSQzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:55:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C75F11C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:55:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403aa5d07caso46166811cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689785713; x=1690390513;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xaknZ+WQXJ6kJPUpwHcZWxBULSRjgk951uD8BaEmJU=;
        b=aPUCeq/XP3LmF7NuRP26v0Ge989d6G7AGSAJCXIRKXQAgd1xsjUx1DAtIBfGkxmxt6
         P24KcgnWKabeJoWjDmdO8WzrixJy45+ZWk///46bnP8O7+8IOSYXX2YQv2ge/GCKHLAR
         vK9LYCbBmo75UvZx7pxPL5K5EXxkrHw8JXRvMdc/4lyfIPNCThSEc7lNF6wxZ+Lr8/Vm
         MLOIYl4A0BEt20JSXblMlyFmE75sZmRpaFiBxy61LhhAarRUWEh+p7yt+uWz5mTStslZ
         HdDdsQhADeG7HDbHzxwL28T8hUQ97MY6/WjeYue/hVljKA2HDS+qRdk306qBDcsDEalj
         VAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785713; x=1690390513;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xaknZ+WQXJ6kJPUpwHcZWxBULSRjgk951uD8BaEmJU=;
        b=aLJFC5EAoISNN6PtK9n2vBF77A3J+GsVdfqKjZMDgxyhN+nYLYP3sKxi0qEO/SRHcn
         2s+rA5PFIuu9ofbwoEp7Y0pgJ5/P0orouyA0kziOEbOOV097ruquvPkE8t8dYtNLZYku
         9O7YxAjV/2XpTrIaFbBHYGFp6NiaySdwkZzIlRoVa1f70TvOnLH9NvolC6NSjNrjHAUK
         RV72RhFzx/OnXu9s6LnDOvWXYtG88576spHtiV8k3erLvSoWxr9UeV7z80GQW89VBUA9
         GxLC53PQATo/Oq+nL7fy+7DiUqfD8IW86Lx4SHPkSkU+SUPPDV0OfwNBhxVbXZfzbOrv
         HY/w==
X-Gm-Message-State: ABy/qLa5Dmyrd6i65JIgd0Ax/pgXFIGUHQopj5bmlE/O0PnlQYh/20NA
        8KY2vnB+jfWvW9p/AKM9/Lk2lQ==
X-Google-Smtp-Source: APBJJlEPsbeM2nGzrTcEBeX746FG7Qyy/DhvSGKqoQV2FqRjNNJfHAVrQWcpMXH6G6hSipJSYJxWVw==
X-Received: by 2002:a05:622a:1883:b0:403:eb6a:5f5f with SMTP id v3-20020a05622a188300b00403eb6a5f5fmr11425456qtc.42.1689785713469;
        Wed, 19 Jul 2023 09:55:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:8499:3c3c:78f6:f355? ([2600:1700:2000:b002:8499:3c3c:78f6:f355])
        by smtp.gmail.com with ESMTPSA id g10-20020ac8774a000000b00403f0e47dd6sm1436861qtu.67.2023.07.19.09.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 09:55:13 -0700 (PDT)
Message-ID: <44c057f5-d229-86f1-adc4-5585334d3113@sifive.com>
Date:   Wed, 19 Jul 2023 11:55:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 2/4] gpio: sifive: Look up IRQs only once during probe
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230719163446.1398961-1-samuel.holland@sifive.com>
 <20230719163446.1398961-3-samuel.holland@sifive.com>
 <ZLgTwiTzykDhCd5w@smile.fi.intel.com>
Content-Language: en-US
In-Reply-To: <ZLgTwiTzykDhCd5w@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-19 11:48 AM, Andy Shevchenko wrote:
> On Wed, Jul 19, 2023 at 09:34:43AM -0700, Samuel Holland wrote:
>> of_irq_count(), or eqivalently platform_irq_count(), simply looks up
>> successively-numbered IRQs until that fails. Since this driver needs to
>> look up each IRQ anyway to get its virq number, use that existing loop
>> to count the IRQs at the same time.
> 
> ...
> 
>> -	ngpio = of_irq_count(node);
>> -	if (ngpio > SIFIVE_GPIO_MAX) {
>> -		dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
>> -			SIFIVE_GPIO_MAX);
>> -		return -ENXIO;
> 
> Do we still need this check?

I don't think so. I think this check was only intended to prevent overflowing
the irq_number array, and that is now handled by the loop condition.

>> -	}
> 
> ...
> 
>> +	for (ngpio = 0; ngpio < SIFIVE_GPIO_MAX; ngpio++) {
>> +		ret = platform_get_irq_optional(pdev, ngpio);
>>  		if (ret < 0)
>> -			return ret;
>> -		chip->irq_number[i] = ret;
>> +			break;
>> +		chip->irq_number[ngpio] = ret;
>>  	}
> 
> If so, here we need something like
> 
> 	ret = platform_get_irq_optional(pdev, ngpio);
> 	if (ret > 0) {
> 		dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
> 			SIFIVE_GPIO_MAX);
> 		return -ENXIO;
> 	}
> 
> Otherwise you need to mention this relaxation in the commit message.

OK, I will add something to the commit message in v3.
