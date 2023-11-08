Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E027E5BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjKHRE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKHREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:04:54 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4001FF9;
        Wed,  8 Nov 2023 09:04:52 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b565e35fedso4123410b6e.2;
        Wed, 08 Nov 2023 09:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463091; x=1700067891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xj1XYIPtCt7xD0Af65okNbQPMnt8v3pzIoFtsXE0fE=;
        b=GiRe0k50ybgAKeQPcW3albPIEh4xRxhDVZXDYPHf8PHPe//drYqsn1042BLlx5j87j
         d1+3Ha05T+vA0oC10YKv3nQNCINgQThkLKXlxzukUTeuIb/IIQdcSK8Yem630wtnQjD5
         KjEQtL4I/GpFmk/Ye/zQqwCCObCceWbXULZgyU5/YLefHn7XMNOQHmOY0VKxe1L7y4+Q
         S7LThh4cbQ7URKHwQpnQfGQXUbtJgh6xu7AUS+23sq7UgwH70KOjQ1hESDDp86T4FZDM
         fsg7qMW4sfGDpnGyvSMpkHoTo9QOaTNwkSH3jrychthJbMvwF0eEHl/mMILRqj3WC4Dk
         8/ng==
X-Gm-Message-State: AOJu0YwgprbiaYhYAIUt+dM4MqVPwA5LvM4vrp1B3eAJW2JhKV9MYD53
        9o42rUxsisazZ1EfRLPZPcIN6YvNeA==
X-Google-Smtp-Source: AGHT+IFUgayMAUgXghb9NJTuV24YA3ejycTle65azlc47oD34VwRdZy3OlWJTd6DlfLxmK7vh9ke9w==
X-Received: by 2002:a05:6808:1382:b0:3ac:aae1:6d64 with SMTP id c2-20020a056808138200b003acaae16d64mr3049174oiw.2.1699463090240;
        Wed, 08 Nov 2023 09:04:50 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u5-20020a056808000500b003ae51628725sm1963024oic.13.2023.11.08.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:04:49 -0800 (PST)
Received: (nullmailer pid 2416480 invoked by uid 1000);
        Wed, 08 Nov 2023 17:04:48 -0000
Date:   Wed, 8 Nov 2023 11:04:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH 1/6] dt-bindings: pwm: amlogic: fix s4 bindings
Message-ID: <20231108170448.GA2388329-robh@kernel.org>
References: <20231106103259.703417-1-jbrunet@baylibre.com>
 <20231106103259.703417-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106103259.703417-2-jbrunet@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:32:48AM +0100, Jerome Brunet wrote:
> s4 has been added to the compatible list while converting the Amlogic PWM
> binding documentation from txt to yaml.
> 
> However, on the s4, the clock bindings have different meaning compared to
> previous SoCs.
> 
> On previous SoCs the clock bindings used to describe which input the PWM
> channel multiplexer should pick among its possible parents.
> 
> This is very much tied to the driver implementation, instead of describing
> the HW for what it is. When support for the Amlogic PWM was first added,
> how to deal with clocks through DT was not as clear as it nowadays.
> The Linux driver now ignores this DT setting, but still relies on the
> hard-coded list of clock sources.
> 
> On the s4, the input multiplexer is gone. The clock bindings actually
> describe the clock as it exists, not a setting. The property has a
> different meaning, even if it is still 2 clocks and it would pass the check
> when support is actually added.
> 
> Also the s4 cannot work if the clocks are not provided, so the property no
> longer optional.
> 
> Finally, for once it makes sense to see the input as being numbered
> somehow. No need to bother with clock-names on the s4 type of PWM.
> 
> Fixes: 43a1c4ff3977 ("dt-bindings: pwm: Convert Amlogic Meson PWM binding")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 68 ++++++++++++++++---
>  1 file changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index 527864a4d855..754b70fc2db0 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -9,9 +9,6 @@ title: Amlogic PWM
>  maintainers:
>    - Heiner Kallweit <hkallweit1@gmail.com>
>  
> -allOf:
> -  - $ref: pwm.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -43,12 +40,8 @@ properties:
>      maxItems: 2
>  
>    clock-names:
> -    oneOf:
> -      - items:
> -          - enum: [clkin0, clkin1]
> -      - items:
> -          - const: clkin0
> -          - const: clkin1
> +    minItems: 1
> +    maxItems: 2
>  
>    "#pwm-cells":
>      const: 3
> @@ -57,6 +50,56 @@ required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8-pwm
> +              - amlogic,meson8b-pwm
> +              - amlogic,meson-gxbb-pwm
> +              - amlogic,meson-gxbb-ao-pwm
> +              - amlogic,meson-axg-ee-pwm
> +              - amlogic,meson-axg-ao-pwm
> +              - amlogic,meson-g12a-ee-pwm
> +              - amlogic,meson-g12a-ao-pwm-ab
> +              - amlogic,meson-g12a-ao-pwm-cd
> +              - amlogic,meson-gx-pwm
> +              - amlogic,meson-gx-ao-pwm
> +    then:
> +      # Historic bindings tied to the driver implementation
> +      # The clocks provided here are meant to be matched with the input
> +      # known (hard-coded) in the driver and used to select pwm clock
> +      # source. Currently, the linux driver ignores this.
> +      properties:
> +        clock-names:
> +          oneOf:
> +            - items:
> +                - enum: [clkin0, clkin1]
> +            - items:
> +                - const: clkin0
> +                - const: clkin1
> +
> +  # Newer IP block take a single input per channel, instead of 4 inputs
> +  # for both channels
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson-s4-pwm
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: input clock of PWM channel A
> +            - description: input clock of PWM channel B
> +      required:
> +        - clocks

What are the 'clock-names' in this case? Because it's still allowed.

Rob
