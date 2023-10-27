Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5337D92CF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbjJ0IzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjJ0IzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:55:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29FD1BB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:55:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc29f39e7aso272715ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698396912; x=1699001712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Is4QFcJ/Sw1j/0rsJ9QPsUqhaamwV8h6F6t9b1JVKvc=;
        b=GJJKvWdGpAeVnuXHi+1NgFJZSry4yz+Y7Jfu9LKYo2hFx31RNEY3nTF4f48gTWpYUo
         YF1J+kdk8bXmxl8QlNFVfkyUv22StoFwhd4QppQttWxO26e11pHCGXzutPZGBfApPEri
         K1xXnU+Iwf6+e6YXDx/zt/gZKbOE08/YNVr7hS02gO0BQHPMyvY1nF+nb8T9Hpkkoyjt
         Lw8fPqjhIiGgcte+hmfxwRrsbNZnAy+7wiu/1JJQB5kOq7bAcwph9ZhfORCCdO/dTZEJ
         7HW779utfEmK1lBq0w5q3JP1zkEatiRw89UFe4s5sX6jnvF9h+J89ouFvkT39YhzhtF9
         +Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396912; x=1699001712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Is4QFcJ/Sw1j/0rsJ9QPsUqhaamwV8h6F6t9b1JVKvc=;
        b=HeCpaCwru2lEtFgVpuJ/phxNDiUTvVSvcRasYEaLp04czGRJUXwM0mSpOa8mNoHyjo
         faq1QXw1TKnAd5P6IRTVDdSc78pxm05tTQTiSnsLL8P4wNYFf2Fh7Jtb+1BeZwlfZ7xF
         4M4xRP0LkghXwNXofg9AQ1kll0Ei859rAvKgSTVx3k48jhzUw1VToRBUNnV2Cus0UzMK
         BUTJr6+HiScW7S4mllVVsf/JvVEm9XaGQuOeI5WKjHZqlnPhaJ26sm2sExcOK+9R/eDY
         IhIPECYibs+NNsOix210eXblv+sdL7V3xUvhbT/r6WGg82fapyBsdZHhzQazR0UAx+WF
         MsPA==
X-Gm-Message-State: AOJu0YyJcbwapVwd0RJqPjlP8yCe15JyJPjUxgmgbiqkn836ZCJdGh2Z
        mW5GwNU+3ktjOMGVgnKymEl8vw==
X-Google-Smtp-Source: AGHT+IHX8Q247cpzVHxbUsznH2cd5jtDT0ExlXQQSJfa3Ax/5zi7xuosF299B5v4WhdLzyuVwdJ65Q==
X-Received: by 2002:a17:903:11c4:b0:1c3:3363:8aea with SMTP id q4-20020a17090311c400b001c333638aeamr2208497plh.61.1698396912159;
        Fri, 27 Oct 2023 01:55:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:bfe6:93ca:47b7:e8ec? (2403-580d-82f4-0-bfe6-93ca-47b7-e8ec.ip6.aussiebb.net. [2403:580d:82f4:0:bfe6:93ca:47b7:e8ec])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001c5eb2c4d8csm1036273plc.160.2023.10.27.01.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 01:55:11 -0700 (PDT)
Message-ID: <c71d095b-cd39-4c4d-a985-7032a1da49d9@tweaklogic.com>
Date:   Fri, 27 Oct 2023 19:25:05 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>
Cc:     Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-2-subhajit.ghosh@tweaklogic.com>
 <b030cb0a-7a15-4497-9b0f-75615694dc04@linaro.org>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <b030cb0a-7a15-4497-9b0f-75615694dc04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   
>>   properties:
>>     compatible:
>> -    const: avago,apds9300
>> +    oneOf:
> 
> Drop
Sorry, do you mean I should not use the "oneOf"?
> 
>> +      - enum:
>> +          - avago,apds9300
>> +          - avago,apds9306
>> +          - avago,apds9960
> 
> I don't understand what is happening here. At all. Some compatibles are
> moved, some are added, nothing explains why you are doing it.
> 
> 
> Best regards,
> Krzysztof
> 
I have formatted the commit message wrongly, it will be fixed at once.
I am trying to add the support for all the three sensors in the same schema file.

Regards,
Subhajit Ghosh


