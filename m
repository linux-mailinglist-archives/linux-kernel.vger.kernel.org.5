Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC61F79ED86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjIMPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjIMPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:43:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3B11BC9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:43:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b962c226ceso117041951fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694619800; x=1695224600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UVGR1vSOq8d04uiGlXr6zXZdncQJrHAcL7z9Oa7q5s=;
        b=wd4hv87ZYS8V4gXu/8SebigBk1s0bUr+j6ZxDypqWJTXM/xIOV9KcmPOEM1wXhLrEx
         eLPuLS/3CRprr38ykyId5kpXNkNl2hg0Fz7jhxIrT8BW6CDPn2umirz8NuCez0FRxdHe
         yAd08i2SIuPvtN4b8H1w+QSRqyd27BzIBL9jFFgbhhVGbhkNsC9DOiWn5A7qR6vLrl87
         wRiu3DgbdFcN+K79yFi5dUhKjLwCvQgMNt0tkDKhG6qIdefZtHQ1HNmjuVbbhQsu9D3Q
         9GaB9OnnkMy5YwVEByKqEh4y83PdOADHmjk9Vw8Dpx3tysEZ78QJwDie39Ke8FhXP1yc
         3KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619800; x=1695224600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UVGR1vSOq8d04uiGlXr6zXZdncQJrHAcL7z9Oa7q5s=;
        b=mnxB6ZwHJinX2lAiFeCCtaPqSoBvpfz0LWZLWyxAee83t5JP8gM+/hfk2SP2/2VctW
         TpXkIDQp9Btt+bKJ7QdCQC4VdUPO6G9RSE26P1I37zvOUY9N7PFFlCm6Pc9K42MHw8PI
         3+Kem2rKraEeDQmBfEVDP4np62zifnD13aQ5fcCc8SSgewjeXaodTH7GU9pJPeq74Iul
         abryJO+D06+1zwVc4IUmXJx6nZhyCWOrV+uu7+/CiaIJqB8XvL5pUMNeBc1Fv2LEGb/h
         drRAMfQvL6Eo9QtGnt7lvKObqyeyd8Qdbtl34TZXGawLWRXC77xpWReyg/0EQG/9/qbV
         HOSA==
X-Gm-Message-State: AOJu0Yz3srrkaBL99fN+VL2MCTJQ0UE0NYz/H/RdtRiN9Cd8bB4yn1FY
        zGf6Q1DTntnJgE/dxtMUjc+rBA==
X-Google-Smtp-Source: AGHT+IH0lbaO0JZ9flMoXDcb0nqt3WSvBbstzIb5rAju6JrWIQIlR0RUZOreeSKTPpCvh8WeZU5TWw==
X-Received: by 2002:a05:651c:1206:b0:2bc:c466:60e9 with SMTP id i6-20020a05651c120600b002bcc46660e9mr2556951lja.49.1694619800012;
        Wed, 13 Sep 2023 08:43:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090648d800b00992e14af9c3sm8686981ejt.143.2023.09.13.08.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:43:19 -0700 (PDT)
Message-ID: <0f92b568-399e-4bd8-84f7-088abe9dbe84@linaro.org>
Date:   Wed, 13 Sep 2023 17:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        martyn.welch@collabora.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20230913111644.29889-1-hnagalla@ti.com>
 <20230913111644.29889-2-hnagalla@ti.com>
 <052be57d-4081-43ca-6c9f-9afedb030a58@linaro.org>
 <b8305681-9fa5-e506-b8c7-03338b5ed4d8@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b8305681-9fa5-e506-b8c7-03338b5ed4d8@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 15:59, Hari Nagalla wrote:
> On 9/13/23 06:32, Krzysztof Kozlowski wrote:
>>>   - Removed unrelated items from examples
>>>
>>> Changes since v4:
>>>   - Rebased to the latest kernel-next tree
>>>   - Added optional sram memory region for m4f device node
>>>
>>> Changes since v5:
>>>   - None
>> Hm, why none? There were errors in the binding to which you did not
>> respond. Did you just ignore them?
>>
> I do not see any errors in my builds. Am i missing something? Please 
> excuse my lack of knowledge here. Thought the bot errors were outside of 
> the patch submitted 
> (Documentation/devicetree/bindings/dma/stericsson,dma40.yaml). 
> Appreciate your kind inputs..

I would expect then some confirmation that errors can be ignored.
Instead report was left just unanswered.

> 
> $ make -j`nproc` ARCH=arm64 V=1 CROSS_COMPILE=aarch64-none-linux-gnu- 
> DT_CHEKCER_FLAGS=-m dt_binding_check 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> make --no-print-directory -C /home/a0868345/temp/linux-next \
> -f /home/a0868345/temp/linux-next/Makefile dt_binding_check
> make -f ./scripts/Makefile.build obj=scripts/basic
> make -f ./scripts/Makefile.build obj=scripts/dtc
> make -f ./scripts/Makefile.build obj=Documentation/devicetree/bindings
> # LINT    Documentation/devicetree/bindings
>    (find ./Documentation/devicetree/bindings \( -name '*.yaml' ! -name 
> 'processed-schema*' \) | grep -F -e 
> "Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml" | 
> xargs -n200 -P$(nproc) /home/a0868345/.local/bin/yamllint -f parsable -c 
> ./Documentation/devicetree/bindings/.yamllint >&2) || true
> # DTEX 
> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dts
>    dt-extract-example 
> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml > 
> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dts
> # CHKDT   Documentation/devicetree/bindings/processed-schema.json
>    (find ./Documentation/devicetree/bindings \( -name '*.yaml' ! -name 
> 'processed-schema*' \) | grep -F -e 
> "Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml" | 
> xargs -n200 -P$(nproc) dt-doc-validate -u 
> ./Documentation/devicetree/bindings) || true
> # SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>    f=$(mktemp) ; find ./Documentation/devicetree/bindings \( -name 
> '*.yaml' ! -name 'processed-schema*' \) > $f ; dt-mk-schema -j  @$f > 
> Documentation/devicetree/bindings/processed-schema.json ; rm -f $f
> # DTC_CHK 
> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb
>    gcc -E 
> -Wp,-MMD,Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d.pre.tmp 
> -nostdinc -I./scripts/dtc/include-prefixes -undef -D__DTS__ -x 
> assembler-with-cpp -o 
> Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.dts.tmp 
> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dts 
> ; ./scripts/dtc/dtc -o 
> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb 
> -b 0 -iDocumentation/devicetree/bindings/remoteproc/ 
> -i./scripts/dtc/include-prefixes -Wno-avoid_unnecessary_addr_size 
> -Wno-graph_child_address -Wno-interrupt_provider 
> -Wno-unique_unit_address -Wunique_unit_address_if_enabled -d 
> Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d.dtc.tmp 
> Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.dts.tmp 
> ; cat 
> Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d.pre.tmp 
> Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d.dtc.tmp 
>  > 
> Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d 
> ; dt-validate  -u ./Documentation/devicetree/bindings -p 
> ./Documentation/devicetree/bindings/processed-schema.json 
> Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb 
> || true
> 
> 
>  >> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>  >> +%YAML 1.2
>  >> +---
>  >> +$id:http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
>  >> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>  >> +
>  >> +title: TI K3 M4F processor subsystems
>  >> +
>  >> +maintainers:
>  >> +  - Hari Nagalla<hnagalla@ti.com>
>  >> +  - Mathieu Poirier<mathieu.poirier@linaro.org>
>  > Are you sure Mathieu has this device and is a maintainer of this device?
>  >
> Earlier, Mathieu suggested he can be the maintainer. Beagle play is 
> based on AM625 device.
> 

Sure, no problem, good for me.

Best regards,
Krzysztof

