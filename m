Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960367711F9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjHEUAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEUAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:00:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C511FA
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 13:00:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso5447231e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691265607; x=1691870407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhAu6PmKEo0kF+z5P57FmVQZkIDKTY7ThIP5e5i9EeM=;
        b=GtCKm6FtlPOymmajhv3nxUAoW2sPekKv5EQPTu9lT9CMbo5RThPMSYOGg3KzRvr8zr
         +tisfFMak46z5kLHkbtW4D7IDt8ueT6TNd2NpJJ60/dDSllNfHSZ6s75jXRBx7b43/BA
         2z3w4pbTTeU4ePt5VxJXjR3FbFtj9i6InmMOlSj52X2RRvfHPMfd01RoPtznHdWW4t3J
         cUBa9iOt0QC7jsYFjF8cY1f4FUzTQzPj2cJxpj/ILzQWkVXQZ1rs99Ls7GkAGqMBWsKM
         JSPl8EfpPlAJSOllj9rxunqBpZKCkKTa5n2qse8jGNAVD77+JSBb78mTpQT7TKXNBXgc
         Rlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691265607; x=1691870407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhAu6PmKEo0kF+z5P57FmVQZkIDKTY7ThIP5e5i9EeM=;
        b=Zr+ekowXBoKIW7a/fP33evq+eaQsbUICv6thRAUvkh2AcLRLd7fZ8IsLY8biceIYrd
         yHlGGs7xOpf/l4N45Vdnu7D56b58yLVVPYkp2sQ0lLiwFcCy92wvn1wZEtgvwGVpky0v
         8lwSpkudVNPj3M93lBGpP+uBFGa/5gxlqibBT6EVWNNod5T9o5yjlUj65h3q8kTlVlu3
         DHJgimRVGD/ILCJ1gtep40ZMnpJy+ArgNS39KXRurcrTW/AdwkIrrBC9S2D1xxtlPNub
         7T70tvRQM3TYwYtLR+9oI5Q3+l0ujzDHY5eLBQ4xITbO/pAbUqHgdKfdBVlP9mI9mTNh
         N+yQ==
X-Gm-Message-State: AOJu0YzkkeOVeI8lI2q2BCvKgiYGBJ182njJrrXApczZDWycQsOq3Brf
        GoU5Gietxvfrdib2EFY7DhkjllwLozi6OiIKhds=
X-Google-Smtp-Source: AGHT+IEDfY2I0VIl1G5sonT8G6oVVJQXTwrxdQOIYvZlil26v0aEv6jBikszqDBIEwhbe0DHv0bCKw==
X-Received: by 2002:a19:4f44:0:b0:4fe:2ac1:4151 with SMTP id a4-20020a194f44000000b004fe2ac14151mr3177922lfk.63.1691265607363;
        Sat, 05 Aug 2023 13:00:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id i22-20020a50fc16000000b005232e637c24sm310020edr.84.2023.08.05.13.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 13:00:06 -0700 (PDT)
Message-ID: <fa32cc95-6b9d-01e6-b65a-d41f3aeeae4f@linaro.org>
Date:   Sat, 5 Aug 2023 22:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] regulator: dt-bindings: Correct yamllint
 warnings/errors
Content-Language: en-US
To:     like@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, wangweidong.a@awinic.com
References: <20230804102703.931418-1-like@awinic.com>
 <20230804102703.931418-3-like@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230804102703.931418-3-like@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 12:27, like@awinic.com wrote:
> From: Alec Li <like@awinic.com>
> 

...

Subject: no improvements

> +
> +properties:
> +  compatible:
> +    const: awinic,aw37503
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^out[pn]$":
> +    type: object
> +    $ref: regulator.yaml#

This does not make much sense. You had here unvaluatedProperties. Why
dropping it? I asked to drop additionalProperties. Open the email and
look where the comments are given. In which context.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - outp
> +  - outn
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        regulator@3e {
> +            compatible = "awinic,aw37503";
> +            reg = <0x3e>;
> +
> +            outp {
> +                regulator-name = "outp";
> +                regulator-boot-on;
> +                regulator-always-on;
> +                enable-gpios = <&gpio 17 0>;

Please use proper defines.... you included the header for this.

Best regards,
Krzysztof

