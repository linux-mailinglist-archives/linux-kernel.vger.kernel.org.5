Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06529773EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjHHQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHHQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:39:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E2C155A4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:54:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5234f2c6c1dso17972a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510051; x=1692114851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6MY1hiBmbwXLoucjEj2Xi2SFMUgMZzIdibN/5/2L+I=;
        b=wy14TU4UZVX19+51Rna05JGuApi2FZnGS+g/R0QWHc58GHrs6E2v7nzWVB+T++bERK
         i+aUWyJ9SNexBSllhI5nhKgb59kwktMXUmVU9oaTS0O3gjthsCDJp8HLPhAC1rXRh02P
         xMSVRoYchmYjR+cxYo+o0dXgjgdYee9QTmbrWBiJzVhh+HNBgL/sAe0HZXEA++H82Y5n
         QrD2Ver86aRHbx6vgEbgnGufEothi49cDX2JYOCONUQfg1Jfsc5mxGMLfRMjLOznImyJ
         YCjUDbtdNEi/9uUJXhUaWYseM1WsVVz1WUYVLXIFcNHNkUMyQRS0bgdB3mpc+cJgp0Nv
         31BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510051; x=1692114851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6MY1hiBmbwXLoucjEj2Xi2SFMUgMZzIdibN/5/2L+I=;
        b=YiLcSVYp86P9oxIGGiz3pmJenPj+/vQAXONHPuzlAlirkGbkM5LR/C8hxLJ+tJbXqU
         lUWUijFOXtvkkUWp2+TEV590Luqi1rl6BjnyM7JQxGlu/bgI67Ylm/cQtd5ODrx8SVxk
         rSbMveCiweYO+XyyJ8ENX2oX5FIS60qRJnXBmT27unvsWH7USFEh4v2Qs+Es9MONxypp
         KjbGywkoCJuz+EHn8HIVURRIMRI4PjGmhRUyZDggBKiMVhXdzSRGEM6s9pbAQ9d7Dweh
         ZsOQ8uaI0BOfTUfBL4+1O29PnPOzgjdvU7aG96rVhFv+PlgO/+AWSjXVvP68Wsugle7v
         cfJA==
X-Gm-Message-State: AOJu0YyFJRKRLFb1BF42iZNah1+8cVUDJtLBNIwVwgzbeJWw6XPpuykN
        TV5kMTuM+hCxcaPeYU7tzVJYBS6diab6/c4ncAQ=
X-Google-Smtp-Source: AGHT+IEFM3DwvG4gSvRW8WGApgoleljA2c2Cr/zQIjyrhjF0UV2hAUM2hKy+et7OFD1S77hBApF2qg==
X-Received: by 2002:a17:906:54:b0:999:26d3:b815 with SMTP id 20-20020a170906005400b0099926d3b815mr13144104ejg.64.1691506434441;
        Tue, 08 Aug 2023 07:53:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id rk22-20020a170907215600b00982a92a849asm6796311ejb.91.2023.08.08.07.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 07:53:53 -0700 (PDT)
Message-ID: <8e7cf088-e206-746d-0360-16479b1a33c3@linaro.org>
Date:   Tue, 8 Aug 2023 16:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Content-Language: en-US
To:     Md Danish Anwar <a0501179@ti.com>, Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
References: <20230807110836.2612730-1-danishanwar@ti.com>
 <20230807-euphemism-trailing-ef4130dc7437@spud>
 <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
 <1ade44f5-b3d1-dcde-6819-9e944f3b115d@linaro.org>
 <5ca41ad1-4f42-f71a-4b5f-f2b6def42cb1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5ca41ad1-4f42-f71a-4b5f-f2b6def42cb1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 12:57, Md Danish Anwar wrote:
> On 08/08/23 3:48 pm, Krzysztof Kozlowski wrote:
>> On 08/08/2023 11:44, Md Danish Anwar wrote:
>>>>>    properties:
>>>>>      compatible:
>>>>> @@ -171,6 +181,9 @@ examples:
>>>>>                <0x22400 0x100>;
>>>>>          reg-names = "iram", "control", "debug";
>>>>>          firmware-name = "am65x-pru0_0-fw";
>>>>> +        interrupt-parent = <&icssg0_intc>;
>>>>> +        interrupts = <16 2 2>;
>>>>> +        interrupt-names = "vring";
>>>>>        };
>>>>
>>>> These examples would probably be more helpful if they used the
>>>> appropriate defines, no?
>>>>
>>>
>>> PRUSS Interrupt controller doesn't have any appropriate defines. This doesn't
>>> use GIC so defines from arm-gic.h can not be used here. These are specific to
>>> PRUSS INTC.
>>>
>>> I think these example are OK. Please let me know if this is OK to you.
>>
>> But isn't "2" type of the interrupt?
>>
>> Best regards,
>> Krzysztof
>>
> 
> As per the description of interrupts property in ti,pruss-intc.yaml [1]
> 
> Cell 1 is PRU System event number, cell 2 is PRU channel and cell 3 is PRU
> host_event (target). None of them is type of interrupt. So that's why they all
> are hardcoded. I don't think we can use IRQ_TYPE macros here.

OK, thanks for clarifying this.

Best regards,
Krzysztof

