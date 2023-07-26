Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46610763E64
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGZS1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjGZS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:27:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A22109
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:27:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-314172bac25so93581f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690396030; x=1691000830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzqLjK8Xkeivl0wa82o9EWmkTswR7UuotwLLOVNsxDI=;
        b=XIeExHC3gE95BlPr7LcDASW+2lbz9h6J603EJA7u/73d3JODLmmjMLlEbUbx4I/+q3
         1f+y0Cxq2PWBooI0+1TmIA+UOOyU2im1uQl05kqLJRB3Dkh6pk5+hvEM3cx2F+5zkjWQ
         jDyY1pZYFvxQ+AiqaxYDsi3+84ACj0qze363zDYWIZ6atuz0KmLiS/XTzsZmkeD3psAb
         QohvsTdKueeG8UD2kN5XnsJ0cv1ucAVlANsSih5w7WXcnye5p+QQOq2fME2Nsx3OCzSi
         ueSgn//FAL5MSXcICy/VI0JNHiebjYd4vd4UQ8GRzMyNjuWayfgv1NArR9oPi7mH2vv+
         rVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396030; x=1691000830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzqLjK8Xkeivl0wa82o9EWmkTswR7UuotwLLOVNsxDI=;
        b=TCrd9msfS5pup/KS/BEeBKCTxbcVziMVjI+Dcwu3D7dClYfxJhMffUmUU60F5LQpTz
         2VZ8dr5W8Xz9YpbiUMpAZPMR0p78SdBPrjt8DKvgox2cbl1n3HvCQigVPkEyyUad3fQ4
         Fqsh2slWtJqiyy8u1OTEn+0+cTJce1S6YdyHiMay9478j5kFzwRd1FkA9yHPaG85e/W5
         1ebCByUEHlebwu0l84QlzJiFXOQAiRj3psj6z1rDOaYJhjXpSyG54gBGBQv0Aub0vFwx
         /sgptGize1o2ymdYjkgPcVNMR4gLf0qPUjBzstrk+bwNkahsEfMqBIaMLqFOZQU7WSw1
         Hp1A==
X-Gm-Message-State: ABy/qLYFxhIA0hNYw6m8kWjoPc1v9Y0oLkyc8u5fU7qVNn5jFR7mqiQJ
        W/NmwrWVUSE3qiuQmoCGFUCfiA==
X-Google-Smtp-Source: APBJJlGl9LY0jYBeuOLBKY/QOl/1k5dmLtdC/W/SevHXT9DXZyuU6rQZUTHdpsXNOj0X1NBGoz+fNA==
X-Received: by 2002:a5d:5142:0:b0:317:3f64:4901 with SMTP id u2-20020a5d5142000000b003173f644901mr1899720wrt.41.1690396030280;
        Wed, 26 Jul 2023 11:27:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906038a00b009929ab17bdfsm9914020eja.168.2023.07.26.11.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:27:09 -0700 (PDT)
Message-ID: <7a44e513-2b6b-aed3-3d71-e56bd0be2417@linaro.org>
Date:   Wed, 26 Jul 2023 20:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <82628237-e087-269e-9673-cf3873fe4b35@linaro.org>
 <4105d77e-e011-8df7-35bf-bbfca0b640da@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4105d77e-e011-8df7-35bf-bbfca0b640da@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 20:19, Guenter Roeck wrote:
>>
>>> +    enum: [1, 2, 4, 8]
>>> +
>>> +  average:
>>> +    description: |
>>> +      Number of samples to be used to report voltage, current and power values.
>>> +      defaults to <0> when not set
>>> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128]
>>
>> I am sure hwmon has some property for this. Are you sure it is called
>> "average"?
>>
> 
> Something with samples. adi,power-sample-average is similar. Others
> use average-samples, qcom,avg-samples, touchscreen-average-samples.

So probably it's a time to come with something generic, e.g.:
average-samples in some hwmon.yaml

Best regards,
Krzysztof

