Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDD37E20EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjKFMIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjKFMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:08:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051BE2728
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:05:43 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so38496635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 04:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699272341; x=1699877141; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo4meWKVFbrqc+IQu3vvUKMXOAHSBvoghj78YURGCoQ=;
        b=bUD7kvHWOvxx7ddzLf/1RwE7B+hv9xcwrRVik93D7ez9KHUr4kQLYy43NhWr1zVr8x
         dVZqxBwxC90vWMJf899tZEWs28LRgcn4zUjtzHRxeE0OtjcVEiDyawQebvHEGKiAYFss
         WvAZSkyvV5AZwsk544wlGmfRG081CMjUjCNx69+eG52hy4hFXVwqIOH+HIaQPxmO5chh
         OpcV6puktPi1IyqUd5scoI0Casb1NR1+6a10xtrT/w8f6U27phD7juHQgdhSKz/WXPan
         UJmPw0sRku8Cx7+zyYQJaUs8XcEGQVaJwaGDZLb3AvKmCfPq22TdTNjs4TsMsM5+L6Xg
         BMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699272341; x=1699877141;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo4meWKVFbrqc+IQu3vvUKMXOAHSBvoghj78YURGCoQ=;
        b=UX1NLaeKk9q1SZd82ohBR8CxpqBzpycp7J69RZzaE+jAyMJHZFPGT9oygaxWSgxGnT
         kR01DKPFbH2peYBL88XQ7qcGmkOOVDbxTfY1fE9O8ZyqkDtrQ4xDMqvV7fXUULnJij8u
         QSFm3j64ByZG3hDWxp6c2kQdubFuyvriNS3aYqEsPXoyPcr3V0U+r2fiIQI2G1T2Pomk
         373uwV0gyY1QNrMPYwD3iD2/+HTcNRxCHcDZq8F0G3QdYriLkAUPxjZnUV8atxHoTLrm
         oOpXsAGwQGQ9ZDW5uMu8EBO8Q2Tfj8mH6vRh3+7v086d1EAN4LDmWXzzK8hmnJ0Y2JRR
         Ho9w==
X-Gm-Message-State: AOJu0Yy8RwmuniBxfzVGfL9VYV1+cSYGXWoZk10Dd9MuX//Pp0SUrA4r
        em1X8UCjaiI5zb2UEkBfNx6flA==
X-Google-Smtp-Source: AGHT+IGu95NsFHRZTou3YhjXBBK5ogenE5avfEYXW4hsTBJuOW/jW6etIJgVfKslUMiWzjhlSUBZ4w==
X-Received: by 2002:a05:600c:3149:b0:402:8c7e:3fc4 with SMTP id h9-20020a05600c314900b004028c7e3fc4mr23843592wmo.30.1699272341427;
        Mon, 06 Nov 2023 04:05:41 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:78ae:2eac:2baf:467c])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c419600b00401d8181f8bsm11695356wmh.25.2023.11.06.04.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 04:05:41 -0800 (PST)
References: <20231106103259.703417-1-jbrunet@baylibre.com>
 <20231106103259.703417-3-jbrunet@baylibre.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Date:   Mon, 06 Nov 2023 13:03:38 +0100
In-reply-to: <20231106103259.703417-3-jbrunet@baylibre.com>
Message-ID: <1jttpz9je3.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Nov 2023 at 11:32, Jerome Brunet <jbrunet@baylibre.com> wrote:

> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.
>
> The previous clock bindings for these SoCs described the driver and not the
> HW itself. The clock provided was used to set the parent of the input clock
> mux among the possible parents hard-coded in the driver.
>
> The new bindings allows to describe the actual clock inputs of the PWM in
> DT, like most bindings do, instead of relying of hard-coded data.
>
> The new bindings make the old one deprecated.
>
> There is enough experience on this HW to know that the PWM is exactly the
> same all the supported SoCs. There is no need for a per-SoC compatible.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 35 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index 754b70fc2db0..3aa522c4cae4 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -22,6 +22,7 @@ properties:
>            - amlogic,meson-g12a-ao-pwm-ab
>            - amlogic,meson-g12a-ao-pwm-cd
>            - amlogic,meson-s4-pwm
> +          - amlogic,meson8-pwm-v2
>        - items:
>            - const: amlogic,meson-gx-pwm
>            - const: amlogic,meson-gxbb-pwm
> @@ -37,7 +38,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 4
>  
>    clock-names:
>      minItems: 1
> @@ -70,11 +71,14 @@ allOf:
>                - amlogic,meson-gx-pwm
>                - amlogic,meson-gx-ao-pwm
>      then:
> -      # Historic bindings tied to the driver implementation
> +      # Obsolete historic bindings tied to the driver implementation
>        # The clocks provided here are meant to be matched with the input
>        # known (hard-coded) in the driver and used to select pwm clock
>        # source. Currently, the linux driver ignores this.
> +      deprecated: true
>        properties:
> +        clocks:
> +          maxItems: 2
>          clock-names:
>            oneOf:
>              - items:
> @@ -83,6 +87,26 @@ allOf:
>                  - const: clkin0
>                  - const: clkin1
>  
> +  # Newer binding where clock describe the actual clock inputs of the pwm
> +  # block. These are necessary but some inputs may be grounded.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8b-pwm-v2

Made a mistake here while making a last minute modification
it should be meson8, not meson8b

Will fix this in v2.

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          items:
> +            - description: input clock 0 of the pwm block
> +            - description: input clock 1 of the pwm block
> +            - description: input clock 2 of the pwm block
> +            - description: input clock 3 of the pwm block
> +      required:
> +        - clocks
> +
>    # Newer IP block take a single input per channel, instead of 4 inputs
>    # for both channels
>    - if:
> @@ -111,6 +135,13 @@ examples:
>        clock-names = "clkin0", "clkin1";
>        #pwm-cells = <3>;
>      };
> +  - |
> +    pwm@2000 {
> +      compatible = "amlogic,meson8-pwm-v2";
> +      reg = <0x1000 0x10>;
> +      clocks = <&xtal>, <0>, <&fdiv4>, <&fdiv5>;
> +      #pwm-cells = <3>;
> +    };
>    - |
>      pwm@1000 {
>        compatible = "amlogic,meson-s4-pwm";

