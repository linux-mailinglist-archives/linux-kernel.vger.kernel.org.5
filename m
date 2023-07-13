Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515D5752A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjGMSyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGMSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:54:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CEE2D66
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:53:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so7040605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689274417; x=1691866417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xmc1sE9Mq+D+NHMQWiyH+jo9A18cWBOIkCA/5pe5/a0=;
        b=AT2yZufGgFU4zc5kdeWcjkY+4EPwoYSGlVdmT5fsMKXBRAjXelkG637w7llP/wqvhk
         49z+FNYxoKGtvpN8zvIL4YMlKSifYy7TTSip+6EzNNuPHt1rWvzlGzetQXwEtCXcV25B
         GgXZoEimNeOu38gQjz6iWjiIpE3z2jTcb3Jb+gojFSt7BxlzR+trZPwRrHiv2oJAb19I
         8Pk96Ytz/SZMxXM6eXtvPY4Kva4qzd52T7d/rbB4vTEqpOrhnxuxQ3Qc4fpTSj68lpd5
         mrI2P3P0tsWC9Uayb4ohDEL1af0Q/fImjdX5JsIHWJ6tUQJdLVJLJaQi34hVgIzProCG
         GJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274417; x=1691866417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmc1sE9Mq+D+NHMQWiyH+jo9A18cWBOIkCA/5pe5/a0=;
        b=Nq0wFEx13Skesr+IPcXYi+lIFXNjdvbuWswqdjHjskbhf41eVUSD1rv73Uz2eaTJ20
         EiK31ClkMNvRYcZwSjNYmKSuXmuVIStLCHwx+WmBL175bNWhrI7v91iWMf+OSnl5B77W
         VqsmeOZ9BWYwxj0sExOPy0x4EN+Y7jsN731VmpHedG/hBYmM+caym6/AnSk50tVUIwpg
         v/BwL91uPAC/vy5JkB+VFuycyH2qnFnu+8UYio/LeY7GHpQ2duBjpwln9PJJBVVm+AUm
         LROL383Fr6HRjLODE5Ab0osNx7KH78nY6d9Y+Cs7C/2LY0AkY0urWBhFzxXyvnrs7AaW
         7P6A==
X-Gm-Message-State: ABy/qLZJqcQAHL1E2A+xFe0QbYc+0Zz5Z6uoW0yX42vyiOHZ6sK6ddbO
        eAH6grx9SBTnxWmwQUykpZxCQg==
X-Google-Smtp-Source: APBJJlFGcBOC1CQdQzgJvkJuHC7qUoBaELowjSnjyXxtm2hCTolZLj1cIz2922V2EK06GANygH9RJQ==
X-Received: by 2002:a05:600c:ac6:b0:3fa:9741:5b73 with SMTP id c6-20020a05600c0ac600b003fa97415b73mr395202wmr.10.1689274417049;
        Thu, 13 Jul 2023 11:53:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fbe561f6a3sm19089261wmh.37.2023.07.13.11.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 11:53:36 -0700 (PDT)
Message-ID: <ebd30cd0-5081-f05d-28f7-5d5b637041e4@linaro.org>
Date:   Thu, 13 Jul 2023 20:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
        git@amd.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230713103453.24018-1-pranavi.somisetty@amd.com>
 <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
 <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 17:59, Andrew Lunn wrote:
>>> +examples:
>>> +  - |
>>> +    mdio {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        phy: ethernet-phy@0 {
>>> +            reg = <0>;
>>> +        };
>>
>> Drop this node, quite obvious.
> 
> Dumb question. Isn't it needed since it is referenced by phy-handle =
> <&phy> below. Without it, the fragment is not valid DT and so the
> checking tools will fail?

No, because the example is compiled with silencing missing phandles.

Best regards,
Krzysztof

