Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AF376E10D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjHCHOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjHCHOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:14:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2452230F9;
        Thu,  3 Aug 2023 00:14:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso1036011e87.1;
        Thu, 03 Aug 2023 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691046872; x=1691651672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fg8N0Ukwg5RT6KNmHsUPwBhkLcVgEuX75u4FVwewJOY=;
        b=RUjDkXzP0AiKbK9wwFP5j96Yrb2mgdb+EQsYDX8wtD++YQhGa8M9ooVTI78/uaROZX
         7brRq8R0RBnFMoXh2m5NEHMu1EptDblqEfghgVmOzav6YVqEQuzOK3oKH693ix+ABpQ6
         smF6Cpt9zwAZ5PrkI9hsSaXzlP6Q2aq+ljjmMI7voYyIp86lxam8BeOUPzhjM+eSIG3M
         HbRzgDe9371+x3TlS5IdgqgGw48bdGcUxqOaZ/IHBNjFnXApY46eUH+h+/9hqBEnXEul
         GqKkbcG6wI3HM7KtT2ytiL/q5pPrebeEVoCE2bpGAkURGxSWb7Sb21wc3hYZMOiF+mUs
         CDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691046872; x=1691651672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg8N0Ukwg5RT6KNmHsUPwBhkLcVgEuX75u4FVwewJOY=;
        b=e9KuaqsHMem1j+OlLsLnQz9akykMKYOjQ33f+hc9UOLFh3IZfVi4o5jZIc5UpQ78ZC
         CBe36iryixRU5FcntsEJxZOsQ6ApjmsOgBxFAkbNt4hCLhqYF0DndWJrTCskmseTIgVt
         uWlDnIMC01kyi33tlmPJZXgoyG0jnqIwC4aT9R4xiIDHgfxgO0rBcHwSYbXx0OSAUVu1
         ChX+bcLj6ZREVQX6mwN2cd/9EOXJwkLLacsYxmFPLGhj6LIxgC0iPX0wnVEzYjmXW4mJ
         nzaad2epB3cBd4d6rPfb5hDaiNqrmLmbsFVkz2Glh+VRKaE46o/1H+3lcM1Cx95iFVrq
         t3MA==
X-Gm-Message-State: ABy/qLa2IOOjBb5DKIS/K3sevOSpFnGRaPpvg/prsWrM8hbsRof3yQ8O
        RhQn1X6pYuiLnA2odCmfMqY=
X-Google-Smtp-Source: APBJJlFBBXv5kkT7TKX008z8jJbkXBV5s3fpAwGd6L9x5vE20vxwAjVqLDdnI8ZWkbU4MfvwZ4YcRA==
X-Received: by 2002:ac2:5f6a:0:b0:4fb:740a:81ae with SMTP id c10-20020ac25f6a000000b004fb740a81aemr5902054lfc.16.1691046872122;
        Thu, 03 Aug 2023 00:14:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:32f:1f0:c25b:89f6:3b46:6d1e? ([2a01:e0a:32f:1f0:c25b:89f6:3b46:6d1e])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d6992000000b0031134bcdacdsm20942059wru.42.2023.08.03.00.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 00:14:31 -0700 (PDT)
Message-ID: <8e74af01-36c6-3a41-6d31-91b09ea62026@gmail.com>
Date:   Thu, 3 Aug 2023 09:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: st: convert sti-pwm to DT schema
Content-Language: en-US, fr
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230801220559.32530-1-rgallaispou@gmail.com>
 <20230802080238.d3nam6elnern65rb@pengutronix.de>
From:   =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20230802080238.d3nam6elnern65rb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Le 02/08/2023 à 10:02, Uwe Kleine-König a écrit :
> Hello,
> 
> On Wed, Aug 02, 2023 at 12:05:59AM +0200, Raphael Gallais-Pou wrote:
>> +  st,capture-num-chan:
>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>> +    description: Number of available Capture channels.
> 
> I have the theory that nobody actually uses the capture feature and I'd
> like to get rid of it. People who do use it, should better switch to the
> counter driver.

TBH I only found two drivers using it, including this one.

$ grep -rinI "\.capture" drivers/pwm/ | wc -l
2

While I agree that there is not much drivers using capture feature, I 
have mixed feelings about removing it.
> 
> I wonder if this is the opportunity to drop st,capture-num-chan. There
> is no mainline user.

If there is no opposition about removing this feature I suggest to do it 
in a second time, in a serie.

Regards,
Raphaël
> 
> Best regards
> Uwe
> 
