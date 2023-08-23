Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC3785520
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjHWKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjHWKOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:14:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E4193
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:14:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c0290f0a8so688727666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692785665; x=1693390465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mo5/7rcHcq3EQgUwAoIukeLa+fenPjchd8RqeRcwzh0=;
        b=ihbNcP54FHcDcsNQrJFy0GzOhp3tX+EONzYnWeK6M6avTg1a2bKWR/FIon1jVynIFF
         b/8wrIu7GYhe9zB5u9KsIRwrSfLxXB6H3jZ+j0GlDrRhkYg60dC3Tqsf86HgGHn3o575
         lvOfUWlDqJssE01ir92sNmJlzB+sqgpw87Pe+8FlfeYJ3aRiQwXgTNU2R6NRZuOFTxQu
         OkUdcDurENzHPaqYct0JDv5GDG6HHGTaHMfPdOc+HLtRMTDg2/Gu0eUxydxWgl1wp27b
         6CQa8+Cw+wiKh5UCeyEMS6Xr5a1WwfCayQGIr1AxUzrJB18El8LCff29uONOyMSC39n2
         j9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692785665; x=1693390465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo5/7rcHcq3EQgUwAoIukeLa+fenPjchd8RqeRcwzh0=;
        b=Tuq+LNFiD9ifD/lUCfPwVnMaID4pvegK5XbasUqpz60pddIfGf0e/sl6DwybzPVEE3
         tfPBrTOIMC35sWpgXTbs90I/nQ0xgOosjAC899Q+nuOAXkA//51nEJ/SBYYhvkedOEiN
         5KKR1n4STUAyJ0Z2FotDR0Uu4rmjhwNYD1ecvYHzTsWfnYw0Dqi/1RVipMSvBXagTFAR
         9gpZEHolv7jRnQ+O9jwRQgQ9ZzM4/VHPSVxwnHW6B+Z+gFpw2n02sglb4u/IXQX5I8cS
         Yj3/oES++PMQI9Gcg2IyuSMrJKBwOOR3nrmCDS2TaVjmWqLbhFxv3x6UqluMr2a5gWLH
         4gGQ==
X-Gm-Message-State: AOJu0YyiwGyaAzdpSXNAQX9v4oRidToVJ7lEnX/gSkCHUXx3No5Pkcli
        nlSswiw2APFKSJSrNmrgledIdw==
X-Google-Smtp-Source: AGHT+IFF2WpbdYLFr/XFlhvXm6Isl4hPxZl/sv6oNX9VHvKVNXhsnhVKAZJbBOlUpIWjtMKFpzn9lA==
X-Received: by 2002:a17:906:74c8:b0:9a1:d29c:6aa9 with SMTP id z8-20020a17090674c800b009a1d29c6aa9mr1332297ejl.11.1692785665370;
        Wed, 23 Aug 2023 03:14:25 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id sa4-20020a170906eda400b00992665694f7sm9585022ejb.107.2023.08.23.03.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 03:14:24 -0700 (PDT)
Message-ID: <19f09a5e-c420-f209-ebef-cfa36ffa8467@linaro.org>
Date:   Wed, 23 Aug 2023 12:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] rtc: m48t86: add DT support for m48t86
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230823-m48t86_device_tree-v1-0-240023b435ac@maquefel.me>
 <20230823-m48t86_device_tree-v1-2-240023b435ac@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823-m48t86_device_tree-v1-2-240023b435ac@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 11:03, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add OF ID match table.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

How did these appear? It's v1, so it is a bit confusing.

> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

> 

Best regards,
Krzysztof

