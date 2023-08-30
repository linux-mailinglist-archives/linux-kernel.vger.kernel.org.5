Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6403D78DCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbjH3SrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbjH3OiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:38:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6332A1A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:38:13 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so86080801fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693406291; x=1694011091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMgMrR7+l3U6InFHuLJKmHUuLjLzWvIThsVzLRt3aVA=;
        b=boeH8U4vR+1Vf5QffwQHIOwj9K1UppXefxIOnmXcfZDJMLWz5h27gJGL0BjAv7NP2v
         czLtXy8fTv8Ta4MKe8tmFDz3x+nYu8kvD7/JisJ8I0VWODUxat/ebLB+YAl1bvGvY0n6
         BhwSU3096kAV8xGe1QVSjzqhf6SadAFA5Cs3wRQiZuGhKUTGElQS8vN5nm1SfZa+pl7E
         L4ibf79GLQm5KVtsPa1LEor8Lo3FfL04VKYdbPDJ62kf9WQpFDXmXjk3/3u0/d41RFzY
         a0s4HQzez8GacA5Ao2R6CuljBfjt9QpGhDfR/GKy6MV6NP8YpI6vqUDCjSatrvef4tNl
         vwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406291; x=1694011091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMgMrR7+l3U6InFHuLJKmHUuLjLzWvIThsVzLRt3aVA=;
        b=BZswZlPmc345sUWkiEirVHx4yApnSsR/LcfYJnfHVF21m0FfAjMZ5xiH6QrrwNCQlE
         u4Ycbmc5BXPfH0O9rSUBuRXXavsSqOVJGBUAL1D4IlKTSYZwNU40kVOYvjq/kNRGKOQk
         ddxtypUTZR5OBX2zOIMSc0XIVk6g4HcC1rnLOleXgcx6mKtxRh7gooFT9OsQFic5zKHy
         +1+8/EzMv4HA9BWUemcPrMKUAFOJh5PeLE8dbTLVURP7weo60vRmzgidx+eiiv3vsJOe
         sjcZGlP38pLznOJCDCrqEtXnypQSGk7NiZ+3JjnPlpCHWNv1aceQd96VPyWxzJ1ausgQ
         n8cA==
X-Gm-Message-State: AOJu0Yx64X984xSCAc75Uh3sgm2aOtjgm2z3k+cvJvhzZUxsVDLx/Zw5
        tDpaN8LehlpKX+neINozioms0Q==
X-Google-Smtp-Source: AGHT+IErThUR7PX4P9tgEp26JOMA5iIFhpRzIW70CUb4TYwhSuoCzQURMIk4hJsKeGk6T83B+0C8aA==
X-Received: by 2002:a2e:98d0:0:b0:2bd:10b7:4610 with SMTP id s16-20020a2e98d0000000b002bd10b74610mr1823901ljj.25.1693406291406;
        Wed, 30 Aug 2023 07:38:11 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id sd26-20020a170906ce3a00b00997d76981e0sm7249079ejb.208.2023.08.30.07.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:38:10 -0700 (PDT)
Message-ID: <b467c423-dbd4-8a14-8fa4-169658e21693@linaro.org>
Date:   Wed, 30 Aug 2023 16:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-binding: Add custom property for MAX7357
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Peter Rosin <peda@axentia.se>,
        Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230830115744.4102929-1-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830115744.4102929-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 13:57, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add a custom property "maxim,bus-lockup-fix" to enable proprietary
> features on MAX7357. The driver configures MAX7357 to isolate the
> failing channel and trigger a flush-out sequence for bus lock-up
> resolution.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

It is "dt-bindings" not binding and several other fields are needed.

Also "add custom property" is quite generic. When you add next custom
property you are going to have two commits with the same subject. Just
make it descriptive - "Add foobar for MAX7357"



> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/i2c/i2c-mux-pca954x.yaml  | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> index 2d7bb998b0e9..984d4614a270 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> @@ -71,6 +71,11 @@ properties:
>      description: A voltage regulator supplying power to the chip. On PCA9846
>        the regulator supplies power to VDD2 (core logic) and optionally to VDD1.
>  
> +  maxim,bus-lockup-fix:
> +    type: boolean
> +    description: Isolates only the stuck channel and generates a flush-out sequence
> +      to attempt to clear the bus lock-up.

Why wouldn't you want it to be enabled all the time? Why should it be
configurable per-board?

Best regards,
Krzysztof

