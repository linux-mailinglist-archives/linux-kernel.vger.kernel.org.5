Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B4C774727
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHHTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHHTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:09:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76478D929B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:31:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so39931625e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512260; x=1692117060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Go6XT9Xkscl41fZ/aEq4wJ8QEtBrmQLK5ZjjJvK6FoU=;
        b=O94NBZjKx+58Uuz3M/0xH4ZfxQA/RiNttc8LU/tBgS0mn+GMQ7JfQ2D6L5+/nim3RB
         kcQA7S3bK+8B2qYaRAMr8V3BUSrwXPf0vJ/UnD0ntKgPXmrdj3ZCh5zOAhrGDH3413rz
         lGoVJjzjTMAOsYBjhxkTAJ2qnE648zsa/CCiy+FXeX1kvCwGXkswa6dOVARYborTjG71
         SVtCEYC/h6uMDlUZqEOcbw0IijHEhktGn4niA1bP7JoC/HcTzCl9ZVbPZ5ffvFHQJwcd
         R8xL7jF8Yu8Ba3HuZJYZ6S/Iy6Ic9Of1iLw4Fj+vh7X1D48U3IiY4AznzX9sI5XvAba/
         CQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512260; x=1692117060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go6XT9Xkscl41fZ/aEq4wJ8QEtBrmQLK5ZjjJvK6FoU=;
        b=hIHv/xoEDGtwMDgRrz7qlETHCCOaBg6xnw0kvruVDHSgTZzkXqumn1N4XSBKnuVldR
         Jvi3SVJdeLNnk0EjLcOll9d6ktFssl7PFuh3xubUyD/2ZSYEjKU0Wfv+zTQNaVYfPEPG
         dmZH+1wBK5omQPkKAI0slMGiTG26rXJOY05F0iWc2moR6fGDJIvG5WPgOqpixPAUk2lc
         4gJWeQp3bmFiOlTm5RRsm5aihtwdL7PHE8A4vMMm65G9yOTFtEQig8QNfffDBS1ozbbI
         ZYd08tNpPHJL6jW+3NEPj882BDrztSQ78vrDROUqkjYXIfT1o71jQm+57yM45AKDVZgE
         Zsew==
X-Gm-Message-State: AOJu0YyAzcRUlJKZcQNoKK8ytcgisHtanzuyTpm1gVs1Z+o5b3Xj8B98
        7bWCxWtn4MOKWHBRjxpl6vjIMlm0M7lZQPZRAWI=
X-Google-Smtp-Source: AGHT+IHyamondwf86gYopYCiGXf9C3pe+fwNo5AweauN2G6KAu88O/9463pYl6fAJQL0APVu83+16A==
X-Received: by 2002:a7b:c5cc:0:b0:3fe:785:abf9 with SMTP id n12-20020a7bc5cc000000b003fe0785abf9mr9253537wmk.2.1691489859599;
        Tue, 08 Aug 2023 03:17:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c214300b003fe407ca05bsm14651226wml.37.2023.08.08.03.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 03:17:39 -0700 (PDT)
Message-ID: <258045bb-b84e-3811-65a3-20ede71118d3@linaro.org>
Date:   Tue, 8 Aug 2023 12:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: add device for Genesys Logic hub
 gl3510
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230808100746.391365-1-jbrunet@baylibre.com>
 <20230808100746.391365-2-jbrunet@baylibre.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808100746.391365-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 12:07, Jerome Brunet wrote:
> Add gl3510 USB 3 root hub device id
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

