Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005D3753742
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjGNJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjGNJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:59:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C328E211E;
        Fri, 14 Jul 2023 02:59:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b852785a65so11004165ad.0;
        Fri, 14 Jul 2023 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328783; x=1691920783;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vShZQMcarPkzUmWVXK6Ziq55LsnSbqaxjxY6sf8cpZQ=;
        b=K4QzBf7A6YFEWHUA6ixpR5W1HoUYkbJ4J1W17P4+oIwAt4hv00eR5M3A3DYwAiyYjl
         Cjhii1S2FLEqAefU1CBl2X9rFNItYL/fGQlJMxPXKPyUGG4FDXri1Ih33KHD/9hn/lMN
         NQ0G9M7ye3B4cQl1ZvnapuP2jXPAHTKFlVrBt23TKLyNNc7zAp1PHl7yViwtSvzO0bqV
         liXLvZ3vVOMKUviDUwGEALJnSnSmTuxXNrUATYeEnDbMAiHwPUvuzG43gGffELywmCcf
         jM7gPAux+Gc5dhxfbdaHdPyoX6/L4dCz+Kxd4eSHxIoem3MZU0hK60IE1u6b6YMy7vw2
         L/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328783; x=1691920783;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vShZQMcarPkzUmWVXK6Ziq55LsnSbqaxjxY6sf8cpZQ=;
        b=XldzDDrr4CkKSAT2cNl+Umw9pKrYOMV6pTANsp0fzuQEcJbraD5zTUSvF2h3Mc4Y0b
         pDMTNLHySh+eFteNHOZriopV5ObS9drBSTTJuTAB2ClC/mK04nI+aRWne1hGoEgA3e0I
         SaUTHfQ8EzZTjupeN24qV9EgYSBZpciKWueXtQvxKQxrCru2CZgyf+Ke1SGPXqcax99c
         RsgK1kLS9RghdehPCsYp4g/46eBUHWSSHPQd6UulWCeOCWSL+Wtn4dtHTrbKir4Alrkt
         lP+pjAXqiEtKnP9WFSGHIiTwKx9IQ8tCRQdFmiGNkREpotZpbc+zfdZ6aJMIIDQFvtVm
         WOgw==
X-Gm-Message-State: ABy/qLbu87vwBhWz6nrcpPirWkr7y///AC7NYNMUGmdvJkO4qEPUo2Fm
        BfogrxC6rQg5MO8WagpSNhk=
X-Google-Smtp-Source: APBJJlHHDmGNSykHBKxMZGwxSLLnEVvuoPUPo9OdWpoStDfN/OVYQwEXP4FINTJblZuIsfG93KAeHQ==
X-Received: by 2002:a17:902:f2d4:b0:1b8:a39e:ff4b with SMTP id h20-20020a170902f2d400b001b8a39eff4bmr1847417plc.32.1689328782949;
        Fri, 14 Jul 2023 02:59:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902848100b001b801044466sm7400745plo.114.2023.07.14.02.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:59:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
Date:   Fri, 14 Jul 2023 02:59:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Billy Tsai <billy_tsai@aspeedtech.com>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 00:13, Krzysztof Kozlowski wrote:
> On 14/07/2023 09:04, 蔡承達 wrote:
> 
>>          > This is because our register layout for PWM and Tach is not
>> continuous.
>>
>>          > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
>>
>>          > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
>>
>>          > ...
>>
>>          > Each PWM/Tach instance has its own controller register and is not
>> dependent on others.
> 
> Your email reply quoting style is very difficult to read.
> 
>>
>>
>>
>> Hi Guenter,
>>
>>
>>
>> Did you receive a response to my previous email?
>>
>> I would like to inquire if you have any further concerns regarding the PWM
>> and Tach with 16 instances.
> 
> But isn't like this in all PWMs in all SoCs?
> 

Correct, pretty much every fan controller is implemented that way.
I don't understand the logic.

Guenter


