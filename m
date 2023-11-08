Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1437E5C03
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjKHRLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjKHRL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:11:28 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9095E1FFA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:11:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4079ed65582so52976415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699463484; x=1700068284; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=eUTx16xBPwlSZNLX67xZHVAtRWSJgwxGWbgEGrxHA48=;
        b=KSlPFqeU+33VZ1dFlE2WWrdFXM0P6lbqgbQ7vfc5k58c1pngtRkB6bH5TQKNt1tmr8
         +sWTQL6lV3ZpXgJGExQxfXvdWBNOudd4mTp86VgTlCVfxGALtxpjvrMAXx0VwIMVPOT6
         Ft+w9Yq16jxOXR3wg2A8GIm68DhVdGLyGfO7rae+qnIt1DJEz30TGSfUWS27zN/ulQMc
         6oXFOdKbugyZH490PrdyFlenogS6yzdDNauyOCXYfSKrFSsKdZHhAaAsvRzq+5NQz6ip
         DZzri90KQLGvFboq2Dxo9lIljsILVuv1+ukhFMI4yU50vADeXBnURtEVAWfXbWRl0LYn
         MvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463484; x=1700068284;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUTx16xBPwlSZNLX67xZHVAtRWSJgwxGWbgEGrxHA48=;
        b=NT/m71RTLF/wUVWbspVUGhbfOqfyFf2PrfCxGhYnaYamZOXY5DE0WwcDFMHqwYt5YZ
         RC834a15aDsrqA5p+SIQQzHYyGpX7Ye2CGatL2hNbpfDV79KxB8IiwreIJ3QUxoNknDD
         Bl7HddJEgstoGI8nRC5kxYiPuIiyhVTg2mkYSftE3kSMt01B2SGADnYBC0p9M1OOiXXf
         InjRmQ0ejmTJgDMy7KzkHccBq0Hquvmohaxiwp5RnFt+PPRL9DVgdv0r6pBDPkhmQUf1
         HsdnS8mBK5YVX/cSr/gS7d/QBec3LEi98I1xDY1CPTOzvpDl6sVW+3tKDEqmwLFT9a3W
         hcUQ==
X-Gm-Message-State: AOJu0YzHd09W327j5/l0xkW9Fg/tjp1cQ0aLGt3X3EnGsOf54aCGERQn
        i+5Cshbs/jz+kZuuhKkwW+tlVg==
X-Google-Smtp-Source: AGHT+IHkXUfrA1tiasSTEFj1aoP6Rt1HVyFxHeX293YAedpxpxcOfIUTWQPEe2dFIo4RSBo5O6hgVw==
X-Received: by 2002:a05:600c:3544:b0:404:72fe:ed5c with SMTP id i4-20020a05600c354400b0040472feed5cmr2402712wmq.29.1699463484552;
        Wed, 08 Nov 2023 09:11:24 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:dfaa:8961:ce90:9db0])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4bc2000000b0032da319a27asm5373005wrt.9.2023.11.08.09.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:11:24 -0800 (PST)
References: <20231106103259.703417-1-jbrunet@baylibre.com>
 <20231106103259.703417-3-jbrunet@baylibre.com>
 <20231108170621.GA2417622-robh@kernel.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Date:   Wed, 08 Nov 2023 18:10:56 +0100
In-reply-to: <20231108170621.GA2417622-robh@kernel.org>
Message-ID: <1j7cmscgqs.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 08 Nov 2023 at 11:06, Rob Herring <robh@kernel.org> wrote:

> On Mon, Nov 06, 2023 at 11:32:49AM +0100, Jerome Brunet wrote:
>> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.
>> 
>> The previous clock bindings for these SoCs described the driver and not the
>> HW itself. The clock provided was used to set the parent of the input clock
>> mux among the possible parents hard-coded in the driver.
>> 
>> The new bindings allows to describe the actual clock inputs of the PWM in
>> DT, like most bindings do, instead of relying of hard-coded data.
>> 
>> The new bindings make the old one deprecated.
>> 
>> There is enough experience on this HW to know that the PWM is exactly the
>> same all the supported SoCs. There is no need for a per-SoC compatible.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 35 +++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index 754b70fc2db0..3aa522c4cae4 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -22,6 +22,7 @@ properties:
>>            - amlogic,meson-g12a-ao-pwm-ab
>>            - amlogic,meson-g12a-ao-pwm-cd
>>            - amlogic,meson-s4-pwm
>> +          - amlogic,meson8-pwm-v2
>>        - items:
>>            - const: amlogic,meson-gx-pwm
>>            - const: amlogic,meson-gxbb-pwm
>> @@ -37,7 +38,7 @@ properties:
>>  
>>    clocks:
>>      minItems: 1
>> -    maxItems: 2
>> +    maxItems: 4
>>  
>>    clock-names:
>>      minItems: 1
>> @@ -70,11 +71,14 @@ allOf:
>>                - amlogic,meson-gx-pwm
>>                - amlogic,meson-gx-ao-pwm
>>      then:
>> -      # Historic bindings tied to the driver implementation
>> +      # Obsolete historic bindings tied to the driver implementation
>>        # The clocks provided here are meant to be matched with the input
>>        # known (hard-coded) in the driver and used to select pwm clock
>>        # source. Currently, the linux driver ignores this.
>> +      deprecated: true
>>        properties:
>> +        clocks:
>> +          maxItems: 2
>>          clock-names:
>>            oneOf:
>>              - items:
>> @@ -83,6 +87,26 @@ allOf:
>>                  - const: clkin0
>>                  - const: clkin1
>>  
>> +  # Newer binding where clock describe the actual clock inputs of the pwm
>> +  # block. These are necessary but some inputs may be grounded.
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,meson8b-pwm-v2
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 1
>> +          items:
>> +            - description: input clock 0 of the pwm block
>> +            - description: input clock 1 of the pwm block
>> +            - description: input clock 2 of the pwm block
>> +            - description: input clock 3 of the pwm block
>> +      required:
>> +        - clocks
>
> Again, clock-names?

yes, same thing
