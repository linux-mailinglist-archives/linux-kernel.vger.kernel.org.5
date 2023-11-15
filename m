Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155E67EBB24
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjKOCP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKOCPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:15:25 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213FBC8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:15:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4219f89ee21so36312201cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700014520; x=1700619320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MSmTa/SaXp0ffMwVKsyznCoe5iJDVnuE9ssYFwaKy0=;
        b=hf3MiDAIF4P0DlKuygCBjELJ6YSBqR9BI6Xu1e4PLD8P1elgFX7/zQ0HcU2H+sn8rP
         c9tkUYCUj8nPxcQ4p9Kv2cC4L7cuBbwh0hmVqrYUTALQhIhWaeo/ky5+dgdZgu7aIOS2
         qdddam4T9JV23oAzWv7DyG71iVMydzsCbKXaeuOMKf7OBMJUARjJmdkQTf2LWQm8pLfK
         NM5jyScPCG16i5e4UPYvfQuux8I4cGS/jxCR+OqORugww3GDPcBwFpecTKgD3ybaOJ/i
         WVtZE072U1Y4knbVVEXN5km6vqiIMJeCBhEutQZtlmZ4xyZMWt2xm1a3mXDufE41Zde3
         vrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700014520; x=1700619320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MSmTa/SaXp0ffMwVKsyznCoe5iJDVnuE9ssYFwaKy0=;
        b=MlHVHjDk6o4wzWJFyjCOFl7AjV0+6UVLmEWlQHhrhHKnjSWvswKbcL6SDrVPX0yLxe
         7pV8Ly3yFa9DtvW0YYtyj7TeFnHgqXGnI/QGcaBdIHflVldChJM7ZiO4o/mgoWxzNOxZ
         WDIG8ra2K8gRsy27o1Fv9Z8YcZwJ+Yy8td49tzwfczkfi6506TUIAtOMTmqSNkedK2vP
         ylgdjFIzaARwpF3Ug4eQZ3diuzdUeWtFc6hyRWsePKXYHwfqtM8aX6DEwSnyRxIfdqS0
         4sOKjBRHTVo71XFWPL20J2Bq7APrBfNKe3gGzYuPC/terp+qiCOwRUD4lcfZM7vNCe9h
         FEJg==
X-Gm-Message-State: AOJu0YxcNc0H+ky2BQffVHHKs0InpXtKvU50rJzfeLe8iwmGk52+A/Na
        FniPd8a9wy1nvpz4/zQmbbSolA==
X-Google-Smtp-Source: AGHT+IEFSDLxFpKfNFc8ycvrsyoEzsbrXROUde3bhQvq7qYNrIR46TUGX+gKo8UDgoBxVdyI0rfrtA==
X-Received: by 2002:ad4:4689:0:b0:66f:b009:fc3b with SMTP id pl9-20020ad44689000000b0066fb009fc3bmr4296026qvb.5.1700014520268;
        Tue, 14 Nov 2023 18:15:20 -0800 (PST)
Received: from [192.168.142.156] ([50.235.11.61])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cf0cb000000b0065d1380dd17sm148577qvl.61.2023.11.14.18.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 18:15:19 -0800 (PST)
Message-ID: <68220eb6-8a20-42d4-83e5-d0d45b2f1404@sifive.com>
Date:   Tue, 14 Nov 2023 21:15:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Content-Language: en-US
To:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <25fcbab4c04bcbbdc4577dc58822540829f91dc9.1699879741.git.unicorn_wang@outlook.com>
 <20231114-grumble-capably-d8f7a8eb6a8d@squawk>
 <PN3P287MB032447BC501261D47E8E3124FEB1A@PN3P287MB0324.INDP287.PROD.OUTLOOK.COM>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <PN3P287MB032447BC501261D47E8E3124FEB1A@PN3P287MB0324.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-14 7:34 PM, Chen Wang wrote:
> On 2023/11/15 1:31, Conor Dooley wrote:
>> On Mon, Nov 13, 2023 at 09:20:11PM +0800, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> Add clock generator node to device tree for SG2042, and enable clock for
>>> uart0.
>>>
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>>   arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi | 76 ++++++++++++++++++++
>> There's no need to create an entirely new file for this.
> Agree, I will merge this into sg2042.dtsi in next revision.
>>
>>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi       | 10 +++
>>>   2 files changed, 86 insertions(+)
>>>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>>
>>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>> b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>> new file mode 100644
>>> index 000000000000..66d2723fab35
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>> @@ -0,0 +1,76 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
>>> + */
>>> +
>>> +/ {
>>> +    cgi: oscillator {
>>> +        compatible = "fixed-clock";
>>> +        clock-frequency = <25000000>;
>>> +        clock-output-names = "cgi";
>>> +        #clock-cells = <0>;
>>> +    };
>> What actually is this oscillator?
>> Is it provided by another clock controller on the SoC, or is it provided
>> by an oscillator on the board?
> 
> This oscillator is an individual ic chip outside the SoC on the board, that's
> why I list it outside soc node.
> 
> Actually the "cgi" is abbrevation for "Clock Generation IC chip".

Since the oscillator is outside the SoC, this node (or at least its
clock-frequency property) belongs in the board devicetree, not the SoC .dtsi.
See [1].

Regards,
Samuel

[1]:
https://lore.kernel.org/linux-riscv/b5401052-e803-9788-64d6-82b2737533ce@linaro.org/
