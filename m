Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3357A76724C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjG1QpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjG1Qo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:44:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139AC49D7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bed101b70so132190266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690562623; x=1691167423;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gfddck5bBZ9TsVup/VlhiXHBawA1ufeeXyWEc/YWnEo=;
        b=eIFzbAhGy5AM0C4MQy7MoZm5NtsB9Dg8RuyfFsdcy206eeA3gSvVR5+yAJozVNmbvV
         SSbfTYW7cOuQuZlQk2QpyoUe1ej5IbJsS7frsEeEJtn8VfM8vKgpKhvOrM9dvJmPOL7E
         EolMC0TXv+eAjH9147e0YYOttbV/c5px3tzFR6WC53w9yiWDnxxnm8/Tb2OjF15AOHK1
         YNwPuybDkJfKoG5Q44WimPnPZVYliSQhciSL1pCd2vGl3cgptYHgOQX9DLQtFLROF7mU
         kSxlXvlk4EBPKMdnvTqmEwZPb0ssQ9YutPPYNbLl4/fshRum8KuyrTGhH9VIxmmAgn4c
         unvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562623; x=1691167423;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gfddck5bBZ9TsVup/VlhiXHBawA1ufeeXyWEc/YWnEo=;
        b=PiuBAPOlml+H/vbfJVyvd3Nh4UQuNA1Mmd4KKt0w1g1yeBDK6WjDrRAggCz7C6b3Rt
         DUThVVIAIsnoZYFIDvF4MW/p1dKclcVYauT4NRVgSKUtYgKtZUSSOptWWBwfnSfeX/TX
         almtKY89wh/kh3zJGEluqzw+MFolSNrmN7ZQIHV92UAyxZw3Vp36xAu4NxveZB/jRNYG
         eeZvb1yrWkN1glmK5qE+KihWtgjQbsgidLqF4M+RbGsZ3rFrxL8j4Ntw6bE1I5K0pSsW
         XYptzQ5GJKijyD3Aj4sw3p6bae1qandMtYQOcGWFLJPKH+7QaCOwSiNMOr4ePFUaBzNg
         ZAOw==
X-Gm-Message-State: ABy/qLa0Wsr89HqJgpVVJq/9lJgIvvuHU+XgY8B2wYZoz+Xkr57/EJ+G
        F4R+qp2lKhKoojMRc/fawsTXQQ==
X-Google-Smtp-Source: APBJJlFGeykyJdPLfdCAfwQ+bUtqvjcUsrZ1cPqeOxOBkY1XvMes28rv/xK4j/sGwTa1YLO0UEB5Iw==
X-Received: by 2002:a17:906:3059:b0:99b:bc51:8ca3 with SMTP id d25-20020a170906305900b0099bbc518ca3mr2627531ejd.1.1690562623360;
        Fri, 28 Jul 2023 09:43:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gy26-20020a170906f25a00b00993470682e5sm2225110ejb.32.2023.07.28.09.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:43:42 -0700 (PDT)
Message-ID: <5f00e6f0-0e10-c737-38d7-c7e47bc20b49@linaro.org>
Date:   Fri, 28 Jul 2023 18:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 08/50] dt-bindings: atmel-sysreg: add sam9x7
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        sebastian.reichel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102414.265666-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102414.265666-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:24, Varshini Rajendran wrote:
> Add RAM controller & SFR DT bindings.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 7 +++++--

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

