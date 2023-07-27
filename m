Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A62764FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjG0JfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjG0Jev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:34:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1814EE4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:26:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso934694a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690450006; x=1691054806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMaXbUqrbiSPsR9fDnkFqi2SZVEGcpYy42I+HCAltFs=;
        b=lniS1OFF848WJ1OmIIkB4rpRh1CFiWWEtypJ68HuBDnriGUuDq5COm/3tRrlyowxS5
         39vuiT3OIoDGqajiOFx+Sq4OINmgQfOYTwOMwEe1VTZQEzJdS1sWs2j0tOxWICWcc5rd
         W0xpNKnCGCWQSRg28HQc/1A1V7GcvI7DhiTl/Vn8Gh8aRmtDXo1LlEFJxoNU5EPulAth
         GXW0SFBTup5SG11tq3HkyovuMjxZX7QBHFF4FtkzC2G4yNJk9nQDtPjY1qWv43RXaVOQ
         EsaxDsL+dH5qV4Rm22MBXpWk8oDFAIFap2RruDPUk9ZvRxgqIEjc7t0N4pktoPCzWq7V
         9RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690450006; x=1691054806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMaXbUqrbiSPsR9fDnkFqi2SZVEGcpYy42I+HCAltFs=;
        b=lSZ2YX4B+4p2BOiXQsSXuA9JEa/Uu2z6k/klX8VjDcTfOHi/kfKuEccp1PevJ6uXZb
         Xhk3Wt9jnGCspdGB6l5HEUh/EwVwNvXDsSWO72qB0c7ywUjyoidp+P95Ce9iFKJNacP5
         +9OVbNQTgfxkvRzrY07z7tWnXrLH5+maHwQSDH9TLieCV5/spLHloN4Q4Wjtei5PN6Qd
         L5GASGNQ+z4/rausKQM0vTnFD3DndN8h+NSyBtbZz14fioFjsb5JQXSVlAObI+sHQ1sO
         T5OlOwxKru2UivkUstAoEwkyPhCFCHA+3JIiXXXB6ps0zqpOWzJVAQK0iTGjTRwcf/l1
         A+eg==
X-Gm-Message-State: ABy/qLbk+MEjROpDN91h4THkHQgRvnfZd6M1Z6TzT2Fu9vnx+w6mew4a
        0mrzZaycdd1csWvBaBNs+rGOVA==
X-Google-Smtp-Source: APBJJlELepkdS4PmnCDQWnLq2ADcHSS0/DzNlDsdOWAtT1NQERL4mpa1101BHqiLLlEfKxDqCLJJgg==
X-Received: by 2002:a17:907:ca29:b0:98d:cd3e:c193 with SMTP id uk41-20020a170907ca2900b0098dcd3ec193mr1050152ejc.46.1690450005847;
        Thu, 27 Jul 2023 02:26:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ja22-20020a170907989600b00991bba473e1sm560354ejc.3.2023.07.27.02.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:26:45 -0700 (PDT)
Message-ID: <ec964562-6ebb-e145-e850-0417a88077c2@linaro.org>
Date:   Thu, 27 Jul 2023 11:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new
 TDD engine driver
Content-Language: en-US
To:     "Balas, Eliza" <Eliza.Balas@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230726071103.12172-1-eliza.balas@analog.com>
 <61fce1da-c8dd-f911-e4bb-b2198612e7c6@linaro.org>
 <BN7PR03MB4545E574AB9886290115E5C89701A@BN7PR03MB4545.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BN7PR03MB4545E574AB9886290115E5C89701A@BN7PR03MB4545.namprd03.prod.outlook.com>
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

On 27/07/2023 11:05, Balas, Eliza wrote:
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, July 26, 2023 21:35
>> To: Balas, Eliza <Eliza.Balas@analog.com>
>> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Derek Kiernan <derek.kiernan@amd.com>; Dragan Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann
>> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new TDD engine driver
>>
>> [External]
>>
>> On 26/07/2023 09:11, Eliza Balas wrote:
>>> Add device tree documentation for the AXI TDD Core.
>>> The generic TDD controller is in essence a waveform generator capable
>>> of addressing RF applications which require Time Division Duplexing,
>>> as well as controlling other modules of general applications through
>>> its dedicated 32 channel outputs.
>>>
>>> The reason of creating the generic TDD controller was to reduce the
>>> naming confusion around the existing repurposed TDD core built for
>>> AD9361, as well as expanding its number of output channels for systems
>>> which require more than six controlling signals.
>>
>> Please use subject prefixes matching the subsystem. You can get them for example with `git log --oneline -- DIRECTORY_OR_FILE` on
>> the directory your patch is touching.
>>
>> Subject: drop driver. Bindings are for hardware, not drivers... unless driver is here a hardware term?
> 
> It is not a hardware term in this case, I will make the changes.
> 
>>>
>>> Signed-off-by: Eliza Balas <eliza.balas@analog.com>
>>> ---
>>>  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 51 +++++++++++++++++++
>>>  MAINTAINERS                                   |  7 +++
>>>  2 files changed, 58 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
>>> b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
>>> new file mode 100644
>>> index 000000000000..1894c1c34d4f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
>>
>> Why is this in misc? No suitable directory?
> 
> I chose misc because I don't know where it should fit, I did not find a suitable
> subsystem to include this driver because this is a driver for an FPGA IP core.
> Do you have an idea where I should put it?

Directory based on what this device does. Whether some device is
implemented as FPGA core or dedicated circuitry, it does not matter. Few
Time Division Multiplexing devices are related to audio, so they are in
sound. I don't know if TDD is something else than TDM. If nothing fits,
can be misc, but again - just because device does no fit, not the drivers.

Best regards,
Krzysztof

