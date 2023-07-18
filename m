Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC81D757A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGRLhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGRLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:37:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3DD1B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:36:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991f956fb5aso693287766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689680218; x=1692272218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jO6ua4X85rMtlHrlvOM6ZeaIO7a3UQyMeLyISBdalqs=;
        b=oTYrcQsJJlBwD++7RreKiH6HawYxf7leUPok+WCk+33/y20iHM9fw/mPZzfDxIqJey
         GeRNpq8xBoIAjvJs1JTAEL0VhEb+a/H1Zx5zutNH5kZwqS4dY0KXgoa9sjYDe96vstek
         lVNKkoUi4vHJpf2UEl1AkxNgFgaBoQS+T52hklsmX6Moc+v9eJXSChNQNnCIWs4xhyaG
         NM9TKfnsoYmkT/wJnDrquwyLAxO3OdiJCocHuD/DgcWoZ7hfJWuj9d4H8IWmTGBhWdW5
         x6k1TUKv5KY7zHHASpvhi1T5hrnO23g2kWgSv8usUWJGi+oymQfRCS/6501R8VHagKQB
         7xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680218; x=1692272218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jO6ua4X85rMtlHrlvOM6ZeaIO7a3UQyMeLyISBdalqs=;
        b=YaSJulvbR01XhHjcPhxacsm/vkz6Rjh22TI1sNm3U9fbeEZpF7lWWEOcq1cK5AMOIq
         1Xg5oIHu9ZuH790yQHULs6zNlRRVvjinjmHbWB60H1sPw2zj6oFHL8uHObMr9nl6zWXM
         LNIlNbzy89aiT5CGntJUMbV83UggV7Y4pEFZ6Jq85N39P/LHWbdCf+RqLjWdLv6crhz+
         mhmYc26xPiK4aosAvHi0BATfhmyFo73JTREBt64/mTuRwNChwLVdVtgVg1XkOcZTuxqr
         kqwCCRVMmKd4xqqLe5qlsZyLMUhqSbGyvq4Wo5nfEg2rWNH4x7Y/+ZyriprAEoH/rtJ2
         lUzg==
X-Gm-Message-State: ABy/qLYX3ewbgKDV/3dC8qOCiUraXfwngNoUeNSBiz4EQ8UnJi/FWAgk
        d6I7S3GiL9gKl4AoeXLJoPoaVw==
X-Google-Smtp-Source: APBJJlFRd9RW4wntElyN0a/crvWTBHVAFZQOzsVP9TrDjczxK2gO/Q3rrQiKZgwATBugMDmHS3+VDg==
X-Received: by 2002:a17:907:9143:b0:992:47d7:35d7 with SMTP id l3-20020a170907914300b0099247d735d7mr11386417ejs.14.1689680218174;
        Tue, 18 Jul 2023 04:36:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dx14-20020a170906a84e00b0098884f86e41sm893296ejb.123.2023.07.18.04.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:36:57 -0700 (PDT)
Message-ID: <ba7af1a4-155f-cab0-4fd6-1f998ceb4936@linaro.org>
Date:   Tue, 18 Jul 2023 13:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add description for new hwmon
 driver hs3001
Content-Language: en-US
To:     Andre Werner <werneazc@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
References: <20230718112810.21322-1-andre.werner@systec-electronic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718112810.21322-1-andre.werner@systec-electronic.com>
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

On 18/07/2023 13:28, Andre Werner wrote:
> This is the initial description.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

