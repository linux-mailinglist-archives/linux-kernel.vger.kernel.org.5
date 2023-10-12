Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB91C7C6EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378816AbjJLNOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378791AbjJLNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:14:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595CCA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:14:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4054496bde3so9747545e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697116465; x=1697721265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGxpG5sySkyzmI8OEkqZujhsy1RfTOcPN5J5Y4xsLqQ=;
        b=Wg0ipS7f1tkM3aoNIkur9kiLjZrxXqocPDT2dcG457X237ER/rzkf3SYCVLLUVeUie
         0l5sG3DcjaAzGpX10MDnIuWWQiE9r5IhG9dwaygJWtd5TragV4MLPKN33wMS1AgtElvo
         rZUuedOwhg9YEaFEtFrW3KAMpScGE2t9v4JYhpHZpaWUpVTMWLmBavoMM/NT5vHrcZzu
         kOz7l7eFKgJrNW1VwKhYXJuUenk6kUWh2yjE1O6ZJgbazB35HhlhwX1IbGXItDsRQZaV
         9lhQYBpYIzHvHO8IhdgVYLvgJNFjgUkFOKeP9rc9bL7D6l2KwLXtCVaV2QVl9+dKZtKm
         X4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697116465; x=1697721265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGxpG5sySkyzmI8OEkqZujhsy1RfTOcPN5J5Y4xsLqQ=;
        b=V2Eoaq5w87Ibso6AugU26hiUXgfcSE4Rb7nxTURBZTnVZShMZ7zbpwXy8NCK8G5MF/
         0OMfR08r2GuukzJnzf+GPIw7byzLklj44rSaov6yqo69rAnRya7W8by+NRUdtaqg8hbv
         0YtPHK/7w8qQgmPHgpJgZ8HnKJ3vXl/vFWScdszV9x5XrRIIPG7n27hOTwAjGfwPSE2J
         bwVjmFgogWCjc2m0MKriV58Rao7CDaWqlRF7d4MVm3fzvId4ETSE9c6Gw3FJm/N1r4Bx
         pwnw3FJZem6tcunGKuD+K/HkWYOMJNfIWsO5fGHKy0spZda4tOr/TSyH+wj4UQxXeksi
         wU6Q==
X-Gm-Message-State: AOJu0YzeZo6sgLYcuHic8u6Ewsqsd2yF3kE9ClwNV9HvKR5rnplohEO2
        HSAThYdAFsMTARmBUUB5TXxGvIUQZ3aDnAHQHU0=
X-Google-Smtp-Source: AGHT+IG5FBvx6h3rweF+lc3pX+7wrDJo3+bueRZ5ZXPOGUr0QjJSlkyXomBlJX8IQEp5yOQntjegGg==
X-Received: by 2002:a7b:ce89:0:b0:402:f07c:4b48 with SMTP id q9-20020a7bce89000000b00402f07c4b48mr20417716wmj.28.1697116464566;
        Thu, 12 Oct 2023 06:14:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id i14-20020a05600c354e00b004068de50c64sm19851900wmq.46.2023.10.12.06.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 06:14:24 -0700 (PDT)
Message-ID: <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
Date:   Thu, 12 Oct 2023 15:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal/core: Hardening the self-encapsulation
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
 <a6b51de7-4f56-4db9-a7dd-60555ac6c37f@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a6b51de7-4f56-4db9-a7dd-60555ac6c37f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

On 12/10/2023 14:01, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 10/12/23 11:26, Daniel Lezcano wrote:
>> The thermal private header has leaked all around the drivers which
>> interacted with the core internals. The thermal zone structure which
>> was part of the exported header led also to a leakage of the fields
>> into the different drivers, making very difficult to improve the core
>> code without having to change the drivers.
>>
>> Now we mostly fixed how the thermal drivers were interacting with the
>> thermal zones (actually fixed how they should not interact). The
>> thermal zone structure will be moved to the private thermal core
>> header. This header has been removed from the different drivers and
>> must belong to the core code only. In order to prevent this private
>> header to be included again in the drivers, make explicit only the
>> core code can include this header by defining a THERMAL_CORE_SUBSYS
>> macro. The private header will contain a check against this macro.
>>
>> The Tegra SoCtherm driver needs to access thermal_core.h to have the
>> get_thermal_instance() function definition. It is the only one
>> remaining driver which need to access the thermal_core.h header, so
>> the check will emit a warning at compilation time.
>>
>> Thierry Reding is reworking the driver to get rid of this function [1]
>> and thus when the changes will be merged, the compilation warning will
>> be converted to a compilation error, closing definitively the door to
>> the drivers willing to play with the thermal zone device internals.
> 
> That looks like a good idea. Although, shouldn't we avoid the
> compilation warnings and just first merge the fixes for drivers?

Yes, we should but there is the series for nvidia (pointed in the 
changelog) which need a slight refresh for the bindings AFAIR. That 
series is since March 2023 and Thierry seems busy [1]. I'm holding the 
hardening since then.

So I don't know how to make progress on this? I was assuming we can 
merge this series and let the compiler recall what has to be fixed.

[1] https://lore.kernel.org/all/ZK14edZUih1kH_sZ@orome/

and as soon as it is fixed, we convert the WARNING to ERROR :P




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

