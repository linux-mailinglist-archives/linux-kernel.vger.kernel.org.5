Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276BB75E101
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjGWJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:40:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A1E6A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:40:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so47173741fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690105236; x=1690710036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LlZmT4tMDOB873i3zzQ26d5Y0kjAgWR/PhFUxBYLHA=;
        b=geiHVdXPhueRuZs/egiBJN1uroQUc2XUIobsjZKMrzW9eFIbwVLTk426g5wBfifL83
         VFPOhOSi+o7FAZUIV190+omtE39ueBbqgd3q8oM3acgpMsY6yYNlwxbyYlCtH9O/OcrD
         ra2WDkrTZnIjPt7+0CRaI8Zd1qZUxlQgc+KvrDjTfY7Hnqu8ox27MBe0374pXY9przvC
         vcom30p7z/UzdgLliiWsRRfqoI456l7SK59xvGEpuyxC4rQwZ1SZSm8ijTk7CrwCCaBe
         GEIxbn5WYglontvA0bcRsBxuLR+JuSgsvkAepEb1trywaC5bZbwtF5EL5zOZMjcetJDN
         GLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690105236; x=1690710036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LlZmT4tMDOB873i3zzQ26d5Y0kjAgWR/PhFUxBYLHA=;
        b=Rf00FvLtrzEnVjDFWSkUmIdD+BAjmxD9t5qGFpULx470tXuDDuZ+G0bze3aOBHKw+F
         kYG5qVTeGigzFFtfr4snNPwrRRXXyCJBFC5GuW5REHdx+ZsyFUr283LB1xrbsmCzXH01
         QbJut9XQ7bwlRTbtZmMkCcSrXeat0VbJY0R5JCN7JfxyoT/qaN2NVqMio/zBIpjeWe3C
         76I9hga7M+XRqnCrwiGhWb4yQc3uXx0Xd2F53W/E+hMEag/lNke02Ur/N1ckjmBu58Fe
         gJVN9KDv+EPHUPz3r7i7qFRUkNeopdrhRKLZqaVeFUY2Xvyy4/HIM/joCep4FanzHIjh
         70BQ==
X-Gm-Message-State: ABy/qLY6dU7UZ9Vzsg5LO1mFf0GCgdvX2IgPrvodQzfuzbHw5xxYc0k/
        3brhOWfArnXyomN3TXJmXo0+kQ==
X-Google-Smtp-Source: APBJJlFrWguwFhN5iKtC4ZiJPTAlNGKoD0rvT/DCYS0aE8fiB4TThWkJR3wuZ5V6xoWJSpIyCfFHTA==
X-Received: by 2002:a19:8c1c:0:b0:4f3:80a3:b40a with SMTP id o28-20020a198c1c000000b004f380a3b40amr3514230lfd.69.1690105235831;
        Sun, 23 Jul 2023 02:40:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y16-20020a5d6150000000b00313e59cb371sm9253083wrt.12.2023.07.23.02.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 02:40:35 -0700 (PDT)
Message-ID: <17dc1961-c629-e09f-8979-1e6cbc92534e@linaro.org>
Date:   Sun, 23 Jul 2023 11:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Icenowy Zheng <uwu@icenowy.me>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
 <5a9ccb708f004e70e2102417eb48b766b03777cd.camel@icenowy.me>
 <ZLwH9RFnJymdy7YD@finisterre.sirena.org.uk>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZLwH9RFnJymdy7YD@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,

On 22/07/2023 18:46, Mark Brown wrote:
> On Sat, Jul 22, 2023 at 08:11:43PM +0800, Icenowy Zheng wrote:
>> 在 2023-07-18星期二的 16:04 +0100，Mark Brown写道：
> 
>>> Since we currently do not define any trip points for the GPU thermal
>>> zones on at least A64 or H5 this means that we have no thermal
>>> support
>>> on these platforms:
> 
>>> [    1.698703] thermal_sys: Failed to find 'trips' node
>>> [    1.698707] thermal_sys: Failed to find trip points for thermal-
>>> sensor id=1
> 
>> I think this is an issue in the core thermal subsystem, and sent a
>> patch; Unfortunately the patch seems to be rejected by linux-arm-kernel
>> (and some other mailing lists)...
> 
> It did seem to be a bit of an excessively strict requirement, I was
> going to poke at that myself.  It does seem worthwhile doing the change
> in the sun8i driver anyway, there might be some other issue that causes
> registration to fail which would have the same issue.

Why do you want a thermal zone if there is no trip point ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

