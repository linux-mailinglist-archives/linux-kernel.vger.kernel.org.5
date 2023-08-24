Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A317867BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbjHXGsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbjHXGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:47:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03E9E4B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:47:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a19bf6ab66so479258366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859663; x=1693464463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWyCqPmgJ3hv088pfINrZgnv5A96Iv0KRz5jP4Vn3gE=;
        b=Q1YxpQjwCSojzu8J7+jwEuQ5tsa8M8oZ/+fvYjx8tgyKlcSZKO1lJZAFcjvoM1qP7B
         YWGXCzpqecdVLPDMIfxvovI6TgUmHg+AZfaarnDtkhGHEYwHNLnZiQPOBWF/1ENdHUyQ
         2XjKvZVXv1XvXbx4xN0Sf3kp6r3muB35cVXIni3qM+o/6ipGnJPvAjuDS5hnIyUFT2H7
         Haq9br+D7bFShH/PrPIu2fEDb9mUcZ8dyNkEqOh4iV+91xcMzLkMqboRXHt/5e3N02la
         rpcHvpTLkZ32A48bPvzRmY+eqQFr4wGLscI2XdERPtvtRaIGrefupRoFbjFpxborNAN/
         P2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859663; x=1693464463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWyCqPmgJ3hv088pfINrZgnv5A96Iv0KRz5jP4Vn3gE=;
        b=aP6Hq0aZJtD3HY9FYP5gOYVEKfJY7s6jUGXr3NuinIzBYaWByvB2xgGnrOcQRfIlDE
         Bqnmtay9A2iFn9sA1GPrt5/qsAR8PJ718c5FYBk7j/c4BT3kw9dedMA+6RBcTpYDV0o9
         dwxpYdY5sU6kx94JReVgeQ9Epcn4sSf8cEJxE3jVGCh2Dd8Ma6yIA3epfrvHZzfnH9W2
         InC1bq2bZ3bg+c8lX5FvEx34EQtSFWGfF27R2Vt0joOYJB0kIP/YIr8OnFBPRFF8qy9I
         j2CLIFwehLZgUlyenDALZcN8H/QLC8M1D4980EmIxEP/GW2olmUcxOB42H34yzkr6vNb
         zkrg==
X-Gm-Message-State: AOJu0YyqSQJyJRud5TjtcmIZ8pjahfZ88X3Rc9OQM/C38d3YmU9Fx0hj
        +c77r/4OemgHfZRln/kmbYeWKg==
X-Google-Smtp-Source: AGHT+IHfYRd2GZMGltUOIDuVqHLml+WqQhUAkxEy8QUA1nMKr5wWj9DOhrwgjT4jD06tdPeXmUeVIA==
X-Received: by 2002:a17:906:53d9:b0:9a1:aa7b:482e with SMTP id p25-20020a17090653d900b009a1aa7b482emr5956781ejo.26.1692859663054;
        Wed, 23 Aug 2023 23:47:43 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id i12-20020a1709061ccc00b00991e2b5a27dsm10595780ejh.37.2023.08.23.23.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:47:42 -0700 (PDT)
Message-ID: <d07213a9-6cf5-3577-a2c7-d0f2773a8247@linaro.org>
Date:   Thu, 24 Aug 2023 08:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 4/5] net: ti: icssg-prueth: add packet timestamping and
 ptp support
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-5-danishanwar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823113254.292603-5-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 13:32, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Add packet timestamping TS and PTP PHC clock support.
> 
> For AM65x and AM64x:
>  - IEP1 is not used
>  - IEP0 is configured in shadow mode with 1ms cycle and shared between
> Linux and FW. It provides time and TS in number cycles, so special
> conversation in ns is required.
>  - IEP0 shared between PRUeth ports.
>  - IEP0 supports PPS, periodic output.
>  - IEP0 settime() and enabling PPS required FW interraction.
>  - RX TS provided with each packet in CPPI5 descriptor.
>  - TX TS returned through separate ICSSG hw queues for each port. TX TS
> readiness is signaled by INTC IRQ. Only one packet at time can be requested
> for TX TS.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Co-developed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

How patch author could review or not review its own code? How does it
even work? I write a patch and for example judge - oh no, it is wrong,
but I will still send it, just without my review. Or I write a patch -
oh, I like it, I wrote excellent code, let me add review tag for my own
code!

> Reviewed-by: Simon Horman <horms@kernel.org>

Where?


Best regards,
Krzysztof

