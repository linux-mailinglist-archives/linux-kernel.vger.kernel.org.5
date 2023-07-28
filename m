Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFCF76723F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjG1QoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjG1Qn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:43:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6FC44BD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99b9161b94aso328895066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690562596; x=1691167396;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQ55/ky9Pj+neLMsamH3qracFC571ulzZ8/9WTpWnnE=;
        b=Z5dpE0OvaiWogancNSpoYZQmrXij1xlhCnCE8nF3fxLY9FEmXL0cyGHT3m4P2JFvFc
         CJcm74wAqlvi3rCrzdgQhjMvI2F7erI1dJ1dBgUu+LX9GU8gCC2OgJZgCTGWkFJI0oJw
         zZZGTMYHhpZSCz8FGbdMI6rKm6O+Engam8lv5DzWs9Nsic2TwcooPy4ViGzjPEhveKiS
         NSB++P6GM7/XhwdOGwHi6pNx5zCqFcwJubyxoPOMfdbBT6hplS12JUA6eTvekTFNaz0D
         CSMBylCpY6XYPwH2v1IbRxK3JwYiLqkrCSHL710wGs35Q4soGCuhoXyNZ6mYOoDBGKcb
         AsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562596; x=1691167396;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ55/ky9Pj+neLMsamH3qracFC571ulzZ8/9WTpWnnE=;
        b=i/5lKhlMrqbNbErfyjBrUxakySGZLcjWHFeudGGkKimixATu+QuPKmUvP7ILc+jo+F
         o2oJIuDmPi2vXAAgxXxZzlsCQDwPucnzb6nMdCKrdwTGQk4X3zaGct3RDbOkSYoouKlq
         ThZG6iPQOz1AaEmqldVZnl+3WMUhBLye/GfR04Tc+TueHsSmN0+c57XHMZFfvAKWjgXy
         DogVBXCULjXFz1VPERLY5zZiHUxCtfe79GDVxnTVvAqifhwFWWdhlqGValqFBvljxblu
         ZOec/CEHEMCiNsB/1bMpbMiNAORSV+j2OnEzjPHmGHhwa1W4F2CxlpDYeeWhWfRa70be
         jFgA==
X-Gm-Message-State: ABy/qLY1XxscNvR4I7QcH7j8GuNcPuipKwpF8QA49x3xwh+Nrlsegno+
        H+VAtUfB59cg287A05sKR67uy4MUkuH+P52uEonajQ==
X-Google-Smtp-Source: APBJJlH8syQrZT0zrBqPjIfzdimE3+36N3Bok3cS7M/uncemv8kO8pGPoUGRbKdQOMnJBbo5TQbITQ==
X-Received: by 2002:a17:907:2bcf:b0:96b:e93:3aa8 with SMTP id gv15-20020a1709072bcf00b0096b0e933aa8mr2981701ejc.21.1690562596058;
        Fri, 28 Jul 2023 09:43:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906688c00b00992c92af6f4sm2277991ejr.144.2023.07.28.09.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:43:15 -0700 (PDT)
Message-ID: <fbacb797-ea27-7106-c00c-5b4501dab22e@linaro.org>
Date:   Fri, 28 Jul 2023 18:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 16/50] dt-bindings: atmel-matrix: add
 microchip,sam9x7-matrix
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102539.266085-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102539.266085-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:25, Varshini Rajendran wrote:
> Add microchip,sam9x7-matrix to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

