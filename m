Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED2B769579
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGaMDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjGaMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:03:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0410E9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:03:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so1095359e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690805007; x=1691409807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEecpTLaUids/0GTQ2ZI8VPfq6S42xD8yRN1b0qCVPc=;
        b=HAw1x5velW+bLBUR7tUBTOSNuZPky1S5j5B1dnEjNSt5fYAdbqeskoc8T+sDqpfwLe
         VaS2Sl5UhFNhC20PS9n28B99dvI667QIj2u8tudC8PIqnsDd8CHoJGljQoblh5Vwy4jA
         yKiMhvFmaCxFUCsfWopg06/LBht9wI0Id5Dm0jsJA1sbfsoBdhBd2rmgG7zHzvUAf5G7
         251217lywAH4ZVm1/Lpkm9CWQiYDO7c7nkJvGniW4b80ZJUhUPX9QCBpXEEj2SP4Q2kD
         MTcX2J1dYY7e/9zKj3/EsLBB6Vl0KUxQeX51c2Z/qiMF/XrpHNu/WqJd16MJEyRHGpj2
         lI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805007; x=1691409807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEecpTLaUids/0GTQ2ZI8VPfq6S42xD8yRN1b0qCVPc=;
        b=iqstlOELqJWK4tVhtg5gbFvlYrjZotKrmyAsYx3Vl1yIu1O4Qs5Rdl988jbUGqsyvb
         oFunGyOA0Wlwg10cyZ98GswTR0dx5NUzSSq3B54dKx8ayCEbjR51HeFNQUuZvl8TFi9r
         TOMFBmSUGRTfLI2AJifZm4y0rVzOfJCMbMFgl1A6+5/X0s3YeydRopUt8jnclO3/30Rd
         cGVh//J2rugdiXzivPIqvIa21FN134XiFjohARKykeoEQrnFhkUrRcqZcWoOXbcI/tJK
         Dj3m+I/TAioJ8nHhvdPE1Bo4eSNaeGP2fvaorNN/oI23BudIBa/xdFEntTmY7sxWZotR
         NBmA==
X-Gm-Message-State: ABy/qLYGHUjCXarJTLcfbAdxjEs9SBb/TIhDpAoRUbt5HqxiVCHyYD81
        0x/J696w98IpovEke9FqPegOnQ==
X-Google-Smtp-Source: APBJJlFKP9bY4dmN34bng8T/IQqzqVxap3KueVCX+iaZ6QIjxxhKK83KNs7Bbg2r9g71kqhN48m1TQ==
X-Received: by 2002:a19:4f52:0:b0:4f8:5e8b:5ec8 with SMTP id a18-20020a194f52000000b004f85e8b5ec8mr4907212lfk.9.1690805007235;
        Mon, 31 Jul 2023 05:03:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906495700b0098748422178sm6056439ejt.56.2023.07.31.05.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:03:26 -0700 (PDT)
Message-ID: <780aa090-3a97-abab-271f-59790df29cc4@linaro.org>
Date:   Mon, 31 Jul 2023 14:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/2] dt-bindings: clock: intel,cgu-lgm: add
 mxl,control-gate option
To:     Florian Eckert <fe@dev.tdt.de>, mturquette@baylibre.com,
        sboyd@kernel.org, yzhu@maxlinear.com, rtanwar@maxlinear.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Eckert.Florian@googlemail.com
References: <20230731100349.184553-1-fe@dev.tdt.de>
 <20230731100349.184553-3-fe@dev.tdt.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731100349.184553-3-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 12:03, Florian Eckert wrote:
> Add the new option 'mxl,control-gate'. Gate clocks can be controlled
> either from this cgu clk driver or directly from power management
> driver/daemon. It is dependent on the power policy/profile requirements
> of the end product. To take control of gate clks from this driver, add the
> name of the gate to this <mxl,control-gate> devicetree property.
> Please refer to 'drivers/clk/x86/clk-lgm.c' source file for the gate names.

Choosing which driver controls clocks is OS policy, not DT property. Any
reference to drivers in property description is already a warning sign.

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.


Best regards,
Krzysztof

