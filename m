Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93047A1BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjIOKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjIOKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:09:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0AB359E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:07:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a6190af24aso259129166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694772436; x=1695377236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIOsoLWZh5rJG/1YfIOAx2GIO6JUFBkc7NqnYEd6i84=;
        b=GoX7555YFEk+k3lGjsD4PFykqWC8MhjqbLtrmX8p+6zQQXOlDJNfYBY0Szu2J/pfs4
         1uxBvjGnIlY4jEs6S6OtTFKxojcG1zRfOJQZT6mrxaglp7GtQLCOxXfivN/fKX4QPML8
         pbCJwRwdHfhA5YMdm65Zaype/frdkoh15nrUDkZ6+/gxMnjtUGwqxa/yaS4ir0P0vr5F
         qfrZ+idSVo8t5sfK6YV05a/q5i2nbmAVnhTTrr5ABEMgtzR0Dinwa9b+CeVE1l5bX3ZK
         JagcDJw16vCFOaMte32wneHCLXh3I8iBX0yJYevEQZJgOPg7deDwUgNLs0ssbCPNGtQR
         H7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772436; x=1695377236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIOsoLWZh5rJG/1YfIOAx2GIO6JUFBkc7NqnYEd6i84=;
        b=VAJfjnL53m5qrgd2t32PnRNkBdnvcHnsT3/mhR1houQ7fF8XHJtXMiwtvVVsrQUzBa
         F3TkrpldQkKZ1Xw6vxpF9+P50vZ+3n82SZqPLAo5zwh4RYZEdAXDMmcTBRTpA9JUW59M
         zbAl9K8nCjOTVzRj3RFenJ5EgM7X6XKT+hffyIFeQLNCxt2BWVgvdnhP2BBfGlrXr8yC
         LMUB23/wOVd56F120995Whu9AxtplLkzm+IurSVSEpQxszoAhwE319Xp27YZRD2ikbXr
         J8AR8NWLzcnr89YtBIPnYSIDDjR1KS9ax4jJ+7huVrf5i+tVjJ8OuSDWpbR4SzzUJ7gR
         akSQ==
X-Gm-Message-State: AOJu0YxxB79naLKrIWfq0h27nW7S4dLULA0NGhSV+IYZD6q5VrjmbPAC
        ud2+YTjUHOXMOQ9aSk5mPiA5WA==
X-Google-Smtp-Source: AGHT+IHVDXtlJMX8pYFZuW54VGTOuf0bTZVgZR6yMV40BZzJvKHWbNORMLTbJ3Zb0tHHlGkaQajY2A==
X-Received: by 2002:a17:907:2cc9:b0:9aa:1e43:d0b9 with SMTP id hg9-20020a1709072cc900b009aa1e43d0b9mr886782ejc.5.1694772436590;
        Fri, 15 Sep 2023 03:07:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ay21-20020a170906d29500b00992e14af9b9sm2192760ejb.134.2023.09.15.03.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:07:16 -0700 (PDT)
Message-ID: <862905cc-48c3-2dc9-6032-6ee189a629e6@linaro.org>
Date:   Fri, 15 Sep 2023 12:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 10/12] serial: 8250_dw: Add Sophgo SG2042 support
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Wang Chen <unicornxw@gmail.com>,
        linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
References: <20230915072558.118325-1-wangchen20@iscas.ac.cn>
 <803daa8f-f4bd-34b7-f826-89e1db5f24f6@linaro.org>
 <CAJM55Z-GMm5Hmk7-QWt8Prvp7qyFzOrQVjOjB7jfoX-oiT_C1A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJM55Z-GMm5Hmk7-QWt8Prvp7qyFzOrQVjOjB7jfoX-oiT_C1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 12:02, Emil Renner Berthing wrote:
> Krzysztof Kozlowski wrote:
>> On 15/09/2023 09:25, Wang Chen wrote:
>>> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>>
>>> Add quirk to skip setting the input clock rate for the uarts on the
>>> Sophgo SG2042 SoC similar to the StarFive JH7100.
>>>
>>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>
>> Missing SoB.
>>
>>> ---
>>>  drivers/tty/serial/8250/8250_dw.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>>> index f4cafca1a7da..6c344877a07f 100644
>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>> @@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
>>>  	.quirks = DW_UART_QUIRK_IS_DMA_FC,
>>>  };
>>>
>>> -static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
>>> +static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
>>
>> Why? What is wrong with old name?
>>
>>>  	.usr_reg = DW_UART_USR,
>>>  	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
>>>  };
>>> @@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
>>>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>>>  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
>>>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
>>> -	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
>>> +	{ .compatible = "sophgo,sg2042-uart", .data = &dw8250_skip_set_rate_data },
>>> +	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
>>
>> So devices are fully compatible? Then use compatibility and drop this
>> patch entirely.
> 
> I'm fine with this, but these are two different companies and SoCs that just
> happens to have both implemented the Designware UART with an inflexible input
> clock. So if fx. a real quirk is found on the JH7110 then we'd need to either
> change the compatible on an unrelated SoC or change compatible on the JH7110 to

Wait, why? The compatible is still there, so you just add here proper
entry, if ever needed.

> something like "starfive,jh7100-uart-with-quirk" and "starfive,jh7100-uart" will
> forever be a quirky way to spell "dw8250 with inflexible input clock".
> Is that how device trees are supposed to work?

I don't get this part. But anyway if the blocks are really designed or
done independently and there is no shared part, except the DWC block,
then indeed the compatibility might be just a coincidence...



Best regards,
Krzysztof

