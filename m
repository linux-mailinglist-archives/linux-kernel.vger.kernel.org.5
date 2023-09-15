Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E81C7A1CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjIOKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjIOKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:50:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3D18D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:49:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso2363395a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774991; x=1695379791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6A7AJrKsm3kj4VKQZj/CxbnuNiC61KN1keejYnfTK6I=;
        b=NIUA9Er7wq83NeastDeLmwWiChHbJnuYQpRsKuEWTF7PPteT8tiG24vHhpGu9KUnw7
         SZ3/oYitqZE/FhGnmX0iaEHeD4A54TFY48Ebs3pVHFlQiewkpD4gwksuupoQghm4nO+l
         ptF0mYpTBn8FbOxJ+91yKH1k4YGMmW3cFO1e9HiwNs8TEa6J4O/Wgst73gZQEz/2ryam
         znwEHROZcctx8Gx2R+TL1+kYDTo9UoSWiluDbrZyvTGRKORYZHUNJGxo65AuSrMsdF0A
         qqcnPYgdV6dqS/TLESanDAkyQnCR1fprVrpZyzyhy1WrukyqbbIIXSG7huKOy4qixv1C
         Jqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774991; x=1695379791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A7AJrKsm3kj4VKQZj/CxbnuNiC61KN1keejYnfTK6I=;
        b=LX1r5SYwWUI19YvdDE/YhCx0DSIgDAJFgC9X9sFmKVjzh7MW46R7gUbuXUK1egoC3V
         6T8mC6wveS4rn2fbBMdm6xVgmc8VHdyyIkZ+iQ4YgT07BN/TM0uFIYVn3MU4ygvqIoDu
         BvnGIbi1HYDIp23+UDn2gPNWUCG6juZ6UPSAtXOXOu6Gkf9kSdNNt+eP9YxzWeUEeQzt
         Mhi1UafW54CP/fmFg5XgunNMex4o6HqjF+MGopQnvdbJH7n6PEIuYwhVNg+GrRBqgfKP
         hbfwhsNx7Ev3MomLSXTRI9ZWxDCCYtrOWVZVx0X7DNfhWKhV/16lceWKogVt25WbiLMh
         NewQ==
X-Gm-Message-State: AOJu0YxcJqR8Zf7kQA8wEM6CCudXSlV77kVQgM7yz3dc7wKHRpUxXWeE
        w4GghaBX7dqFRU4FNRpMn56E6Q==
X-Google-Smtp-Source: AGHT+IHhSMQp1tp0GYzPk0wOrNW4u1uBvsA1qi4P5f35BkrGd6Ib7iszOkHLTk/A2gdvG/WGwnxlcA==
X-Received: by 2002:aa7:d4c5:0:b0:523:363e:f6e3 with SMTP id t5-20020aa7d4c5000000b00523363ef6e3mr1069556edr.15.1694774991395;
        Fri, 15 Sep 2023 03:49:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402348f00b005308a170845sm639680edc.29.2023.09.15.03.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:49:50 -0700 (PDT)
Message-ID: <09783255-332f-5ea8-9b5f-a37facb04fa3@linaro.org>
Date:   Fri, 15 Sep 2023 12:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 21/42] dt-bindings: net: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-21-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-21-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 



> +  mdio:
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false
> +    description: optional node for embedded MDIO controller
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - phy-handle
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ethernet@80010000 {
> +        compatible = "cirrus,ep9301-eth";
> +        reg = <0x80010000 0x10000>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <7>;
> +        phy-handle = <&phy0>;

Would be nice to extend the example with mdio, to be complete as much as
possible. Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

