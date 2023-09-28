Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E177B23C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjI1RYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1RYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:24:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2602FDD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:24:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1c66876aso1740594166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695921871; x=1696526671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sf5OH6kBmJyPwDhUW7u4YAzeX5WNRzEQ/aLpmeyGPhg=;
        b=hZn5VprwxKGrrJG2Vlv1tp9jyjxWNvYoMRCwgvhcwYgSrdt2qzjHwjoRSn6044xUut
         OvrcVje/PdFJymgBsax05AUjO8UshYcm90QdEv1YrAQNLwpS7U0JPksguNoCAwk643b/
         U4s5yOAvxC6NOkdJEV2r+aMvFP8nCVzJDPXC/Vk347azZEuklnus7aaI2cSd3BMS3Kz6
         C2Y5ysmRg6YLP1tJPFmivf8e+Buk1xBqFMi5v+9q1qt2NB0H8HLLztHgFboGBWySExfk
         9mdunUOD5c8klxlaks40M+Gse5qoZmNEm8sVM//5Qi3oZycXju8TI9NwhglATLWEhK14
         eTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921871; x=1696526671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf5OH6kBmJyPwDhUW7u4YAzeX5WNRzEQ/aLpmeyGPhg=;
        b=VxbhptYt7m5VbeG58AtiFjYQRIBugeJMyPyOg0B/FinwOwdS+KPZtDIuoXQP57quLr
         heE0S0utcH1oQjBW7jnPAh27cFS9EPrVKGRB3dyWjCpNvYRTlgSn3ZgeTcPD+FSUsEiT
         PXnRMcR0Bmf85UoH4NWp8tZ6uyd6hotK25NPk9fMvPaASKyOYnSr7VCPm79d00etKcMW
         nQz10eP8ZbJJPz3avOs8Tgg3/yA8woqHt2sZHYjKLDAXQoAC/YaQyb57zJjD2pkF8VaR
         ulE2lh4/rsTz4/XIMO0YhmkdOppqLJX0bh15/gOQsKLBlfWfkU2CugL4/nELWB3Og+jP
         aiYA==
X-Gm-Message-State: AOJu0YyNMUq4gZsM9fDpFz1jmf4NgZfbPgTo9M1yL8peRgWMR+zMYmfe
        /NsTkt5vygisCGifvldWocPwQA==
X-Google-Smtp-Source: AGHT+IGWKtMktEDNyzj+OCWOdCcZomnjz/lXLLhTbRKdOalIdw1wC+nGR2ivss8BaYTvYNlS+UR9cA==
X-Received: by 2002:a17:906:8a7a:b0:9ae:3d75:4c83 with SMTP id hy26-20020a1709068a7a00b009ae3d754c83mr1884348ejc.0.1695921871577;
        Thu, 28 Sep 2023 10:24:31 -0700 (PDT)
Received: from [192.168.33.189] (178235177217.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.217])
        by smtp.gmail.com with ESMTPSA id bu24-20020a170906a15800b0098669cc16b2sm11048763ejb.83.2023.09.28.10.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:24:31 -0700 (PDT)
Message-ID: <a5f9e39d-7815-49ef-9279-c7c98a01aff3@linaro.org>
Date:   Thu, 28 Sep 2023 19:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Raydium RM692E5
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230927-topic-fp5_disp-v1-0-a6aabd68199f@linaro.org>
 <20230927-topic-fp5_disp-v1-1-a6aabd68199f@linaro.org>
 <20230928-tightrope-other-c460f227577c@spud>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230928-tightrope-other-c460f227577c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.2023 19:09, Conor Dooley wrote:
> On Wed, Sep 27, 2023 at 03:19:01PM +0200, Konrad Dybcio wrote:
>> Raydium RM692E5 is a display driver IC used to drive AMOLED DSI panels.
>> Describe it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/display/panel/raydium,rm692e5.yaml    | 73 ++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
>> new file mode 100644
>> index 000000000000..423a85616c1c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
>> @@ -0,0 +1,73 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/raydium,rm692e5.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Raydium RM692E5 based DSI display Panels
> 
> The capitalisation here drives me crazy, but I can live with it...
Oh that's what I get for copypasting a different yaml as template :D
willfix

> 
>> +
>> +maintainers:
>> +  - Konrad Dybcio <konradybcio@kernel.org>
> 
> In case it's a typo, you sharing the d between first and surnames in
> your email addr?
Intentional design decision!

> 
>> +
>> +description: |
> 
> This | should not be needed.
Ack

> 
> Otherwise, this seems fine to me.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks!

Konrad
