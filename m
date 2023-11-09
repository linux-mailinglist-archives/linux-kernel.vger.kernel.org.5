Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4D7E6888
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjKIKm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjKIKm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:42:27 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF61FEB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:42:25 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c504a51a18so1670381fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699526544; x=1700131344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/T3nAMPk3GrqIEl5q2gbW7BDPvpAe0liQvy3DzEQmwc=;
        b=gO5+tRU6acrLCeoOk7D9VSAGkDWyj3JJCd78lAiExFb8o9sE75sbX8gsxiSn535yfz
         9OAEx2JJ53HQzZMaF0mpKqMrKZA/+YRZEZdyG1AxC6xOKHJPlFQSZQm6hg9/4C2t8HJr
         ieb5+80p3dxDvIiarWbFa9+FXhgo9i7Bi6YXzYiKi9mcoYr8K7i3gTkfFmwUdS9eTYvw
         FB7QeV3jTstK+HXmYeLr1hhedxaIeoNdEBEUTayXPGkoebAA0spDafTYIDK+cI97S4dB
         TMAG87H1v58sZsiQkkqxqe8ZH6whv9mH7YCtOReFWDvjgxp8BySTm5fZp36mW2tqcqrZ
         uVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526544; x=1700131344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T3nAMPk3GrqIEl5q2gbW7BDPvpAe0liQvy3DzEQmwc=;
        b=OGNd+UCW30Pae227IOMBKIXVtwUleBR3S4V3W0xxY496BtymzV7rvCMjCan4YF6nfl
         /rSs4xMobfIgtdDhnxq9PhSo68Nc17Kry+5OO/hUc6HCdNpASoU2rWJaOV7j0cX2eIfe
         klVHHtlg79EsyRBUlKIbmwaYeSYw9aXwy6ydaPce8M670eJSHffaLuERlfHDqscatlTw
         YsG8JtOi7fX0If7xkMldZJO4V+j28kHsnNRE1tLgjpuWXgFON6S1zlsCzjRyNA/MNM+o
         +yhL0sAIelVvLkJHl9rzXN05/BLlLHyVlK1AiW/UezKvSzJwthCAye/KX9qtB7bYS1cC
         0rfg==
X-Gm-Message-State: AOJu0YxiXPGKHHlFeOegtCf1AR7a5cIzeP88JSn8QNf/6adeVP8ODNQF
        +NNM53yCl5OgRjLiQYNOY54WUBJWe9qcvkzXa3WZFQ==
X-Google-Smtp-Source: AGHT+IHcJMnl4Agc3MEocHCsrLtdMFFEcJLC2XSn3K1KlAQHuyrsJ6xuAtI3wP4NAa7wEFjA1O7D4w==
X-Received: by 2002:a05:6512:3f0d:b0:509:8d70:49e8 with SMTP id y13-20020a0565123f0d00b005098d7049e8mr1595802lfa.6.1699526543435;
        Thu, 09 Nov 2023 02:42:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:87b4:87b9:6476:5df7? ([2a01:e0a:999:a3a0:87b4:87b9:6476:5df7])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b004090ca6d785sm1698384wmq.2.2023.11.09.02.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:42:23 -0800 (PST)
Message-ID: <5cb0a3ae-405c-4b07-adaa-0e3109e76c69@rivosinc.com>
Date:   Thu, 9 Nov 2023 11:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/20] dt-bindings: riscv: add Zfa ISA extension
 description
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Samuel Ortiz <sameo@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
 <20231107105556.517187-21-cleger@rivosinc.com>
 <20231108-basics-delete-710d0682bf0e@spud>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231108-basics-delete-710d0682bf0e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/11/2023 15:59, Conor Dooley wrote:
> On Tue, Nov 07, 2023 at 11:55:56AM +0100, Clément Léger wrote:
>> Add description for the Zfa ISA extension[1] which can now be
>> reported through hwprobe for userspace usage.
> 
> FWIW, hwprobe is not relevant for the dt-bindings.
> 

Ok, since I'll resend a V4, I will remove this mention top hwprobe.

>> Link: https://drive.google.com/file/d/1VT6QIggpb59-8QRV266dEE4T8FZTxGq4/view [1]
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,

Clément

> 
> Cheers,
> Conor.
> 
>> ---
>>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> index 87c7e3608217..dcba5380f923 100644
>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> @@ -214,6 +214,12 @@ properties:
>>              instructions as ratified at commit 6d33919 ("Merge pull request #158
>>              from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
>>  
>> +        - const: zfa
>> +          description:
>> +            The standard Zfa extension for additional floating point
>> +            instructions, as ratified in commit 056b6ff ("Zfa is ratified") of
>> +            riscv-isa-manual.
>> +
>>          - const: zfh
>>            description:
>>              The standard Zfh extension for 16-bit half-precision binary
>> -- 
>> 2.42.0
>>
