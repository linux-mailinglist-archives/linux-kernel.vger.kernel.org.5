Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4A757538
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGRHWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjGRHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:21:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946C310E2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:21:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9922d6f003cso744168266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689664913; x=1692256913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4n4qqgB+2hjrsOUL30ez1Ai+t/nxxoWxeb0EXPeYD3U=;
        b=es1bxeLfaO0xY+BuGQ4kbRDr+cUVqBg0CW/7pnqWC5hYPhAuLqZ9tvVecxsqADBy/f
         OtRsfX+WHQVbkcqdQzYmznL/LliMQFYqThwOlYsj0eeO+sGktPsawONakijDItPqHBdE
         JRin/J42CfUzbHg4OQzKvvmsRdDZ+ai3U7u4Lu48pUcadEsgjlJsLu3mZjRqllItIaJO
         n3fhwoXIf7Bzt6u0cE2zpyXUwS78Efty+mYquLY7nASpnKPwGwfQhN/KfhYjlwpvvnME
         pwcqz3Wx7QIZfGGoOrNW6lgB3R02af3IUEGfwuQJPbmph/pHYIBSxD9WjptKLDuR6BEA
         4n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664913; x=1692256913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4n4qqgB+2hjrsOUL30ez1Ai+t/nxxoWxeb0EXPeYD3U=;
        b=jg98rbttyUDWE2UXaLmQfZPfFyQsCv+FC2RzELS8Mrx10DQYn708ENnYCpsZ3VkVaY
         xSx4o9AMsIp/5av3hFMs6ORcBGnPAlqcL+FFw7QfDeASNyieJuTRzxQDoZi2DoKeJ0nX
         2OGYomYxzeR+bYT5j7Ms6YSjpUq432N88j7NkNV9gTybaHij0BUJhwzgGGgpvAiI1dNl
         lvzwzOO4IZ03mJKnyv/xTrabUGqRT9CJCYxNikT25GEF2606A6lYfug9/hONj4DGd8wY
         qJpv+Mdz/0fr5YNXUKqQltwPVMB0FYBBNr7bje7I/BqTqND7H3xHosCkanwXFJMCbG01
         6QbQ==
X-Gm-Message-State: ABy/qLYXmAauG9rXalgZdpFPLdnsRBOgNZ+D5jjKomvZl69mTgU8NQ/D
        kBGKOCjRwuEJUTq9GWA9v8+HEw==
X-Google-Smtp-Source: APBJJlEPoEma6epYYKdKLymUlkCZUVI81YFqxVkZojmkdpGMGOEf3L+HYHZiUca0m/klUjEdyT2CrA==
X-Received: by 2002:a17:906:2308:b0:98d:e7e3:5ab7 with SMTP id l8-20020a170906230800b0098de7e35ab7mr11265940eja.11.1689664913098;
        Tue, 18 Jul 2023 00:21:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f18-20020a1709062c5200b0098d2f703408sm631266ejh.118.2023.07.18.00.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:21:52 -0700 (PDT)
Message-ID: <ef46f22a-4556-34b8-101a-ff913b42bb45@linaro.org>
Date:   Tue, 18 Jul 2023 09:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add description for new hwmon
 driver hs3001
Content-Language: en-US
To:     Andre Werner <werneazc@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
References: <20230718070114.3871-1-andre.werner@systec-electronic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718070114.3871-1-andre.werner@systec-electronic.com>
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

On 18/07/2023 09:01, Andre Werner wrote:
> This is the initial description.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> 
> v1: Using separate dt-binding hs300x.yaml
> v2: Reviewer recommends documentation of driver dt-binding in
> trivial-devices.yaml because the driver has no special properties
> to describe.

Changelog goes after ---. Even if you intended to keep it in commit msg,
definitely not after SoB. Does this even pass checkpatch?

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index ba2bfb547909..a4f4701337cf 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -315,6 +315,8 @@ properties:
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor
>            - pulsedlight,lidar-lite-v2
> +            # Renesas HS300[1,2,3,4] Temperature and Relative Humidity Sensors
> +          - renesas,hs3001

What about the rest of the devices - hs300[234]? Usually we ask for
specific compatibles, that's why separate binding made some sense.


Best regards,
Krzysztof

