Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA70761D31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjGYPT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjGYPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:19:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB74D1BF9;
        Tue, 25 Jul 2023 08:19:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbc2e1c6b2so3218025ad.3;
        Tue, 25 Jul 2023 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690298390; x=1690903190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVqB/OLB43pJtSZQsnoujE+pyOVuCDBgWkJZYpdI0zY=;
        b=A1nzV7buPe4RypyKfFqKtpzNmXZ+pUD2IcFbHeE57r+f1QLV1WNjJl6yzYv74tquOR
         BbfYh5z7GyEZ2dgt/gn50rz5nMtWRF51RYtK9EoYU/Cwd1hwLqMPOHl+GZ7cTDqHMFWI
         vZiW1YjXbMcMj7DE6SplENJBxxVGTTzI/RuObWFU0FLV8Ix+XSWDsqgOzoN9qAoXwnmt
         MlfLN3TDYBzlXhg4wjuywXcL7ivZTrjfvIobQgeGRzjErSVI7EkIXFuz4dW++kn/LPre
         cPYD4LPF1UClRlC/J9V2Ik/Yrein6LBnPuKWHgUt0+Y/XvMqP29GUeFiZo5e7CRbPklB
         VEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690298390; x=1690903190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVqB/OLB43pJtSZQsnoujE+pyOVuCDBgWkJZYpdI0zY=;
        b=Ei8+1kkjBBlIEt2IbwUpD+uTp7IG1oMeinD844emjc3VOdnDTv1prP0eM7opYXKiCS
         kGjibEaP8Du+evq39/lHtt7XJ5diVSdzTNU5xpgGMiUhVC4dch1kv4jqlNTudr6pmA3j
         H2aS7QqcIjwy0w3B5gZ1nNCaY9/0bKwqC99Hs6Yoa30Iw8caPCQXoG7sySCG4KTfuqrB
         UXkABZG+AiJDY5hqv3eR/5Rsw/f3mjr5drfGmWw045o2RhvGif7bdX6lU9QVrAS9Sfuf
         GgMFnnEnHIeJli+oyixVAyiTNEl9r3MAaVQZi8WwrzBESU9dpolFpja1ZFjvFQ2NmyDe
         i+8g==
X-Gm-Message-State: ABy/qLYnrlSacG++415oOjie4oeDnM/xGx+Wlk3L9ernyRAwG6RvN2JZ
        NsX+dfpzR5M4y2QpRt1TnqI=
X-Google-Smtp-Source: APBJJlEIDHUozeXKv8CobU8KbiZxUWpc+fGO6kGcJo6rJ/K1hNFEOriuQohfeHL0NQja2/8YncuGdQ==
X-Received: by 2002:a17:902:7403:b0:1bb:ad56:a831 with SMTP id g3-20020a170902740300b001bbad56a831mr3941862pll.36.1690298390136;
        Tue, 25 Jul 2023 08:19:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm11248399pld.13.2023.07.25.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:19:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Jul 2023 08:19:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andre Werner <werneazc@gmail.com>
Cc:     jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add description for new hwmon
 driver hs3001
Message-ID: <0340a749-7073-4002-ada4-c1866f90054d@roeck-us.net>
References: <20230718112810.21322-1-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718112810.21322-1-andre.werner@systec-electronic.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:28:09PM +0200, Andre Werner wrote:
> This is the initial description.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

checkpatch:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Andre Werner <werneazc@gmail.com>' != 'Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>'

Sorry, you'll have to resend this. The e-mail addresses need to match.

Note that, when doing so, I would suggest to add a sensible description.
"This is the initial description." is not a useful description.
"Add binding for Renesas HS3001 Temperature and Relative Humidity Sensor"
would be more sensible. Also, regarding the subject: bindings don't describe
the driver, they describe the chip.

Thanks,
Guenter

> ---
> v1: Using separate dt-binding hs300x.yaml
> v2: Reviewer recommends documentation of driver dt-binding in
> trivial-devices.yaml because the driver has no special properties
> to describe.
> v3: Simplify description of sensors compatible
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index ba2bfb547909..96eb59e56eb7 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -315,6 +315,8 @@ properties:
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor
>            - pulsedlight,lidar-lite-v2
> +            # Renesas HS3001 Temperature and Relative Humidity Sensors
> +          - renesas,hs3001
>              # Renesas ISL29501 time-of-flight sensor
>            - renesas,isl29501
>              # Rohm DH2228FV
