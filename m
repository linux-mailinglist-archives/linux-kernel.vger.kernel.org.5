Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFFE771CFA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjHGJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHGJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:18:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2AE68
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:18:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31771a876b5so3184437f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691399879; x=1692004679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVzTFSX+f3NLp8W+oubkEcGfLvriaLn/mzk8yERB4EQ=;
        b=qJNkHMMX6yWfZ0+pTVtKomPhic8oIkVTU4BgI6+YGQ09zaqOV+wKh9W0VMaDF5vGVK
         unpdERvcAcVRzv4T+5eC6utzpr7Tujtt4DxNGg5+D0zups3hSP94fD4C6Uq7d+QA/UfX
         Sixs7SltrhRg3Z2s4cDrRNFbVUvMUojpSzMGxhDPUhF1dzNE6PeVKZRcXXA09Qr/NMCc
         4/ENs3n9eQZK25cJJHF3O3p4hP5uyg6YXkPYotQ85mlUAB18yaC4W/dV7RuK2jvuNwbF
         AyG5SBgOF2lJne/Hu/DDneyX2OuAtEZipBpoT1RUjDbrGTA/GusqpUqTCXE1vBKusIgW
         MYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691399879; x=1692004679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVzTFSX+f3NLp8W+oubkEcGfLvriaLn/mzk8yERB4EQ=;
        b=fLuSDLWCAjW9o7bwRIifesKNnMjA/FowYZdbUi5/2OxIrGApKEqOF8qMtu+il7XtxM
         owgclchA9MmQUBkadp2PYXPj02XDS6MhFj5eGLDxo1YoSrIZ4AIS9IzbSfg9SBi9jWMa
         t/wHyIm5pSTPbqgcaTpPbNvdsrds9AwfjBQwxTUZETHmre28/LDNZWw0f+jFvuWPsgLb
         pFr04HIcQw6cvIyHhMEemvzfm5flWS8nbyp44vJsH3Z90jwvlmDxVtSwFB6zbfkfP6pX
         lHhgxFfM8UIq314FDolVjL2PpWzOwxH4km5PxfBx3uVsnX/yUkdZJPah4PESWpabfk31
         mj/g==
X-Gm-Message-State: AOJu0Yxo55IzG/fzq5Q75iq815SL58OEI347uchMleKWYEDJromgHw3S
        JPe+I4ZG/7+o6rhOl1knXxoT+g==
X-Google-Smtp-Source: AGHT+IGt4KGgRS1McoIAI5KnJK92YrcRCVd7O+/H015bztf8+4T/Ho4NkPj03Y5Li3pMLxhNwVc9aw==
X-Received: by 2002:a5d:4044:0:b0:314:a3f:9c17 with SMTP id w4-20020a5d4044000000b003140a3f9c17mr5695333wrp.42.1691399879376;
        Mon, 07 Aug 2023 02:17:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id r15-20020adfdc8f000000b00317909f9985sm9893936wrj.113.2023.08.07.02.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 02:17:58 -0700 (PDT)
Message-ID: <f0744dfd-00fe-2f58-065e-6828b6bd3450@linaro.org>
Date:   Mon, 7 Aug 2023 11:17:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/5] ASoC: dt-bindings: snps,designware-i2s: Add
 StarFive JH7110 SoC support
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org
References: <20230802084301.134122-1-xingyu.wu@starfivetech.com>
 <20230802084301.134122-3-xingyu.wu@starfivetech.com>
 <37a636dd-fbd8-d475-8814-e0cc6d5cc812@linaro.org>
 <12a9bfda-9c9f-6baf-3e5f-ce7cc7d79aee@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <12a9bfda-9c9f-6baf-3e5f-ce7cc7d79aee@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 11:03, Xingyu Wu wrote:
>>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: snps,designware-i2s
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          maxItems: 1
>>> +        clock-names:
>>> +          maxItems: 1
>>> +        resets:
>>> +          maxItems: 1
>>> +    else:
>>> +      properties:
>>> +        resets:
>>> +          minItems: 2
> 
> The resets of TX0/TX1/RX on JH7110 SoC are mentioned in 'else' here.

Ah, its fine. Clocks seem to be also constrained.

> 
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: starfive,jh7110-i2stx0
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 5
>>
>> Also maxItems
> 
> Will add.
> 
>>
>>> +        clock-names:
>>> +          minItems: 5
>>
>> Also maxItems
> 
> Will add.
> 
>>
>> What about resets? 1 or 2 items?
> 
> Mentioned it in the 'else'.
> Or do you mean I should drop the 'else' and add the resets in here?
> And is the same for TX1 and RX?

It won't be easy to read... probably the binding should be split.
Anyway, it's fine as is, except the maxItems above.

Best regards,
Krzysztof

