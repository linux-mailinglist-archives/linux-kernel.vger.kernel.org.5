Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA6767245
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjG1Qoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjG1Qnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:43:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F420E4228
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso36327431fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690562609; x=1691167409;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLXtWNmM3MMfUbMpcwgo3a9g1FnaIAmyITqWRV+XAGM=;
        b=X1SL8v01yB0M+wfem3xc2QM51PRNEUz7hUhkBr/bLb39gOSwHpiK/PgwjutBHl+25z
         OZtEoq7zsRaLF5UNwGF96/S+fY+Tj9fxcVI+mPJ6HKBc0u9vQ28Gy9ODScSW9UQjrIJi
         /U+N6e2VKNMJfrk415l3rq4EbdXA04h3V3FgbIeAzJbCKiZF0OQOrgXnhlTouHGHsjKj
         Qu1C16XfoDBNRACEUGSzLSEa1GjoigmbBoW3q64KQPPGFiymRD9l12hWfl/6QvzsfUUx
         oWsKg9mud1PSJwJ8+IB4DQ1PLUmRUjjzWLTHxz8rR9mGn5WSoaBnZLg+EXA2WDxBG71+
         MQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562609; x=1691167409;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLXtWNmM3MMfUbMpcwgo3a9g1FnaIAmyITqWRV+XAGM=;
        b=FoL+xGMFYgTRjl4u8sNUPhW654W5uVIj9b3fkDLJDim1JAS24l8RidOxUzgkq8GKgo
         g/GBuAq9j6c989BAY2S8rPAU06qxf0zItfBD+3JciXOWjSXO5Jp1GWrFE/ZcQfbWVQx7
         U6qa5UUMHybwMejrlTf5Xqa2MfD4Zb0CfC0PeMLGKBXF+oKmt1joaGefleHmlUYRns+0
         +QRqFr4XRs06YHMxRWoZhA1fXDcttLHFZnq3K0XDF3pF1cnIjE2b7g+xgvvgVk8xWIHC
         hYvayxgqzllbIQ0KwnoEbLkdnnMWwoea6d73RqqNjtvE6GJxreM8fKLZQZa93nIgAh2P
         0Gnw==
X-Gm-Message-State: ABy/qLYOJNa3N+10MQVTyNRZQ1PXU2wjw0WutUHC1JAvF+4OmWZNmbBM
        5mFhEgaBIymXcrC3Jo8DxhTPJg==
X-Google-Smtp-Source: APBJJlEexXTmLvoaeZGsUV5MnopybPtyPw1E46DHyNUOXLXg4dSTHOVGxH8XG+/Jyxjoce5KbTNbeA==
X-Received: by 2002:a2e:7a17:0:b0:2b9:aa4d:3729 with SMTP id v23-20020a2e7a17000000b002b9aa4d3729mr2437037ljc.28.1690562608817;
        Fri, 28 Jul 2023 09:43:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906564500b00992e4d8cc89sm2255617ejr.57.2023.07.28.09.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:43:28 -0700 (PDT)
Message-ID: <0c518882-a269-1b8e-c962-aeff5ae9964f@linaro.org>
Date:   Fri, 28 Jul 2023 18:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/50] dt-bindings: mfd: at91: Add SAM9X7 compatible
 string
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102515.265971-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102515.265971-1-varshini.rajendran@microchip.com>
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

On 28/07/2023 12:25, Varshini Rajendran wrote:
> Document sam9x7 DT for flexcom.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

