Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677FD76723D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjG1QoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjG1QnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:43:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5154488
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so3851077e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690562585; x=1691167385;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uOpN0VV7J1FlR7qL2Aly16/RraKO4tx9phQ8ZS+ixw=;
        b=m9q8KAf8JlOrKy2I7zgz4bxq1ewNubSCsnZ65MM/ZaGtGc9R2nLW9UXEOksFTGME58
         tzwTSe7DXdUtzP5zvIadumaoxIdzMspHav9rEbbxcdCEaJbbe8dGsSaIsbyMx6qfilL7
         Rsm+b2sTy5gk44a/vVWNmVtiWljTmrsBVNrkGJLQ17XAVvW01vFG/31LbNjsl0DmCJku
         5JRc6hEFwYhxFZlrANwzmC4OZ+vxuuIL7KzKDsFdTtmDeWcbvZQ5sdg+GE6G+5ID2OGr
         0GowpmByvUCgyUomtw5+Hm/zLioCV4ZxiCMmcvvtFpf6C6Y8AZUkANc9ONYYqiUeHwu4
         Wipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562585; x=1691167385;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uOpN0VV7J1FlR7qL2Aly16/RraKO4tx9phQ8ZS+ixw=;
        b=iCaoEcU5ECHjhpTyhsdacDsejnxKdHj0xhy+7Faa7Wb3awxjR8yXUwPxtWBtwwWdgc
         5IIu0LHcL0v9DVFabf40CfuLr9H2fLY8+jhuZ33QuCzPEPnz2Wg1yDIk0d/OWQDp6O/O
         nikETH/N4adinn1nzp1DCKgsyXXrCxDHBaRMJfH9+Y0KZSAxdtwPhN8pVFnJ+b5czgIF
         TRKnFdIhoFt568BRH1Wvpbv3YQ1bsEpNx9eFjpUoeB6eMYRC3uC9kbrjSPFyslO/O5FE
         29iVzPVTHTFtptiSTWGRJbF9MgAKMtINfNCY+R7AGbp7ENxuidqRDs2PRx9b8gSGKUkV
         tM0g==
X-Gm-Message-State: ABy/qLacGSIbXdtbxVTg6szCYEvv4mPl3Tc1kJYIEcqAL5o3juuDBZnr
        70PNpuBr6DutkjLMTYJ9Xnx7Xw==
X-Google-Smtp-Source: APBJJlGoE3aoNvtCgYaY6825L8hzP7nz6v0p3eXc3znPdnKJvP8nrC3tsSkFpoUBKTZ1tl/Z8d/npw==
X-Received: by 2002:a05:6512:3b82:b0:4fb:81f2:4228 with SMTP id g2-20020a0565123b8200b004fb81f24228mr2495966lfv.31.1690562584889;
        Fri, 28 Jul 2023 09:43:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w5-20020a056402128500b005227da4bb9esm1963929edv.62.2023.07.28.09.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:43:04 -0700 (PDT)
Message-ID: <5e5c72b7-67cd-5659-fd31-1214b5a043b2@linaro.org>
Date:   Fri, 28 Jul 2023 18:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 17/50] dt-bindings: atmel-smc: add microchip,sam9x7-smc
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102550.266134-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102550.266134-1-varshini.rajendran@microchip.com>
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
> Add microchip,sam9x7-smc to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

