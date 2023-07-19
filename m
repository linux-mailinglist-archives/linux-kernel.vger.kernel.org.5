Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E831759C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjGSR2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSR2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:28:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612BD19B4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:28:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-316eabffaa6so6293162f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689787707; x=1692379707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/5+Fuy5VkiTYMoOECLM7hAipJr0qI60CxfgtI6AAuc=;
        b=yp1os99ShMB+le9v5DtBkGmxSFRbBfkllJ7vQUZlPwIh4QZfTVQEGu524krM1tcwfJ
         bY88m6u5xNUhXNEFBKX6Hj8tC2JiVGi0GUaKOkkFcVyHi/6he7roUifo1Oskha5LUnLp
         ZB3ZGF8sHENGYv5lHyjyLrSeligmStZ2Cv0pcuZ+XoI/KJBtEQ40K2Gx4Km2Flmy2cSB
         faNX4uC7wzfJG7+YdJQz9CoazFMdKIhQJH1GkAtFWL9wtzhaPu4fZ6dzztTz/XZVtFmf
         zDXnGc1JOyPm1xNHlphnewyWS5hYT8RluUtlWVkHbQT70e4K2KbkpUtUSw2wn+hRXUV2
         Iw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787707; x=1692379707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/5+Fuy5VkiTYMoOECLM7hAipJr0qI60CxfgtI6AAuc=;
        b=DO+9eTL/Lk+d2k6W0djO74GJc8F9z0Z1ayi73/rcW1AeCTHAcUc38CRe7S8IOvS3fg
         up0+mvAFTaCWXf5k26msrXH2nZc+HPtOE/6nz8hpVT9NwCW8JilzYvdynAxJL9xdtvpb
         KdxEe411u12+5OXuzA8LrS6YOcLbF7nQ2B71BxDe0w4XxKCmpMLnVRHwi8D/1vRc+acO
         eLzpVYr/QiQ1ryFx59z7E8HZi6JVLu9ApmMHpB41DVDokCuV/xCLuyVZkYkJMZLBYl23
         4UY6uhsu8ChFFywHX0D4XoSn6vClZ9TLrRchHFIcMquJs6GTwCX487qBJZpIFg/JTCqh
         uBMQ==
X-Gm-Message-State: ABy/qLY8WYJO/rDQ9+7VdP+Ckm/ytwMxcGB8jMn8CKzbmYB+zO782IGg
        8eCohOQAHSapmlGCGMpSlFk5MQ==
X-Google-Smtp-Source: APBJJlEO2bDu4shZhayU/BpDN5r5YMeRzn0LLyi87Q4mcBpczeBLmsrJOo2xzh+hh8qu8pnsEzBZdg==
X-Received: by 2002:a5d:4f90:0:b0:311:3fdc:109d with SMTP id d16-20020a5d4f90000000b003113fdc109dmr392088wru.1.1689787706840;
        Wed, 19 Jul 2023 10:28:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d4e4f000000b003143c6e09ccsm5866159wrt.16.2023.07.19.10.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:28:26 -0700 (PDT)
Message-ID: <da024b3e-017c-097e-c9c8-55560a7f76c3@linaro.org>
Date:   Wed, 19 Jul 2023 19:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: sunxi: add Mango Pi MQ-Quad
 binding
Content-Language: en-US
To:     Matthew Croughan <matthew.croughan@nix.how>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230719172551.3248166-1-matthew.croughan@nix.how>
 <20230719172551.3248166-3-matthew.croughan@nix.how>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719172551.3248166-3-matthew.croughan@nix.how>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 19:25, Matthew Croughan wrote:
> Document board compatible names for Mango Pi MQ-Quad
> 
> Signed-off-by: Matthew Croughan <matthew.croughan@nix.how>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

