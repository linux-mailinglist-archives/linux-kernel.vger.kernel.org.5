Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B699875DCFB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGVOpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGVOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:45:44 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DDF9B;
        Sat, 22 Jul 2023 07:45:43 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-635ddf49421so15943186d6.2;
        Sat, 22 Jul 2023 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690037142; x=1690641942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqIzWQIELt1M29KP7P5oujEwHJFaetYOs/+klZpSQx4=;
        b=RK8jwytlqDCMYR7DAgQlFOPgz7ZSUk9yowDalHVAkF1SqVZHI7iZ+KGKQ1yO2EqoI4
         40U+i132HQbzSa8u/YHuXXLlkiIt4BfL1vukBpQmnnY84XgUQhZ+qNGv3zc3tu5xiSfC
         2VwJphHgH72PCCSR51oP4D0/J4UytCvaE/JWAzJpE8RAXddUNFiEIDk1DG/KtMjym0R3
         RhoP5njuk5nhyTVS9wE4+zgcetJQJ0SDJwerT22cHB9WNSw8SfsIVHwVhr4m3lOSsmHU
         i125jBVVk1aTEge62OA+pCkOw8jQQTKnF2q/eH3meyfBFDn3KrLIp/WDvSvMd7NglqP/
         vF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690037142; x=1690641942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqIzWQIELt1M29KP7P5oujEwHJFaetYOs/+klZpSQx4=;
        b=EE3YDWwog1/s0XKrc+1MFdIJTwX4VbLKMgatwTy/9WwnQvnF2PYxW+oWVJLVDId+Vp
         hpcvDFGHhDgmOKb2o1JSlaWl7xuWcGBjjGSsRegbCbNAiBGDnHvTgI7zTYrR45SmsCxN
         lbFjtfNRDDczqKQzRVwDmMw0iIPmrhofbN/gqRrmUJ6KIXdDwpwOWhQERHFAQg028/vn
         091PCkF8AOyRzJj0NMZ+u9KVDr10oliB9jVr/XxDJ8ch12VTE2LRmkYfZ+gotWLM8LJ7
         KmUnoITeJ+E02+9mZTlEbyYoa3zdY5Iz+tEiOkT9qDAhbJrQ9NMXBj4d51W9FfhQNpgM
         aZWg==
X-Gm-Message-State: ABy/qLY96kxlBJP21/8JIqM6ql2s5ZcWD1x2lS6bp1lIL1JNIErnAzur
        90uUegZijiR66614eLsASXg=
X-Google-Smtp-Source: APBJJlErq+eRGzlcgBN48vqeyOo9IGrUh9BQBxnfTMGubwltp7kE48GP+Eoj0stwnEeM1xlAJThRkQ==
X-Received: by 2002:a0c:8e07:0:b0:635:eff8:2b9d with SMTP id v7-20020a0c8e07000000b00635eff82b9dmr2401408qvb.27.1690037142515;
        Sat, 22 Jul 2023 07:45:42 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k9-20020a0cf289000000b006263a9e7c63sm61438qvl.104.2023.07.22.07.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 07:45:41 -0700 (PDT)
Message-ID: <d40d5a96-e0af-388e-9fd5-c068b0d2896e@gmail.com>
Date:   Sat, 22 Jul 2023 07:45:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 5/6] net: dsa: microchip: use wakeup-source DT
 property to enable PME output
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
 <20230721135501.1464455-6-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230721135501.1464455-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 6:55 AM, Oleksij Rempel wrote:
> KSZ switches with WoL support signals wake event over PME pin. If this
> pin is attached to some external PMIC or System Controller can't be
> described as GPIO, the only way to describe it in the devicetree is to
> use wakeup-source property.

There is a word missing in the above sentence between "System 
Controller" and "can't be", and I believe the word is "that".

> So, add support for this property and enable
> PME switch output if this property is present.

A property that "enables" something means that you are using Device Tree 
as a way to encode some sort of policy, maybe this is  just the wording 
here and what you would want to say is that describing the node with a 
'wakeup-source' property indicates that the device is wake-up capable, 
regardless of the presence/absence of an interrupt parent?

With the commit message reworded:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
