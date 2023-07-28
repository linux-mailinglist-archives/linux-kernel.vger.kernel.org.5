Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078C776649A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjG1G6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjG1G63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:58:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70171BC3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:58:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31771a876b5so1646992f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690527507; x=1691132307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iftaUnOVi0WItO5ujzoJ74yz/u7rI0zj1tXOnX70SiU=;
        b=gnTkAf4jKjqvw3D0gLbYc3BVQKNvCUIJXKHHBHEq5LLEy0xMC3Wye8gy53UmiEdyMH
         8+zOqQyvd/pbLBQzM7VNhGyzRqc4JR7Mh1JZxilfeSoi8SozTrYIlKq1Tqx9PonbEJyQ
         nONzdxsCgAOgKvwaaNxQiMxaQz7NBTDJIpyNH+ZHdNOcwEGdwGVXorKtnvFiPHBpcEnn
         vbP+EtzBk5GXe8jDMCtcHt5/KZM+5yI33wsU6Lm3GKl6hpvtbF4DfQB+SJ5dV1qqnTZE
         FRStCo0U+/8FjqHemMjf6WtuFhUXremL6VRQ2wIocxkHgCjtVisvXdQDDxFneQ6p3KP0
         NO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527507; x=1691132307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iftaUnOVi0WItO5ujzoJ74yz/u7rI0zj1tXOnX70SiU=;
        b=doL5zUlzAOD1OqKQ46pbPW3bJ71Mq3lPOQgPD4q2TsDUXWQYHKQNVygVvmHP9F63QG
         bRwa/ICxeUrHNqu2UvPEYQXVYIRwzvr0LVbpPvX6v32M1ZQFNQfWEPARuElTuclZsdJD
         FU4u1U3J1G0F5fKzs4veEJDBiNIvmAfIkdjCMF5mH9DFOAB5dCb8tVc8S3ijQJ+hymAE
         qSOaN4CEBf1oQQiu5mJqSD+hiRhdReQqk3vwlu3eZTGOaKcbinoKKVcpJLm+aiE1AJY/
         vspqx+v+bpj1mPUoysbM6QP5ARJprbY42L9b7zjdIe1s1zr3ofw9eKXVChPCj22ppNNe
         ymag==
X-Gm-Message-State: ABy/qLbD14ZlpmzkCf1UhfzSIr7CAz9ad4g3I73VeAxc+cr2KiIrWd+k
        SFJGgXXM/AcKZpeYusqxzI5Pz5cup7SljYR3mfQ9DQ==
X-Google-Smtp-Source: APBJJlH74MhrNj52K2JQ3OFV5R+EOUknys3ZEpt8lbO1nGVe2KfuEUWoAPNijHM7Yry2nXJj/++DrQ==
X-Received: by 2002:a5d:5589:0:b0:317:6ef1:7939 with SMTP id i9-20020a5d5589000000b003176ef17939mr1030919wrv.23.1690527507368;
        Thu, 27 Jul 2023 23:58:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o3-20020adfe803000000b003143b7449ffsm345862wrm.25.2023.07.27.23.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 23:58:26 -0700 (PDT)
Message-ID: <be748338-987b-d474-d040-82af7cfb5f01@linaro.org>
Date:   Fri, 28 Jul 2023 08:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Content-Language: en-US
To:     Eric Lin <eric.lin@sifive.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
 <cbf0a8fd-3479-1684-fe90-81f2159804ef@linaro.org>
 <CAPqJEFr5h+5+F4TdNuRMaWsrmeedbfGgbgd9wh8sUUQsj2Pw-A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPqJEFr5h+5+F4TdNuRMaWsrmeedbfGgbgd9wh8sUUQsj2Pw-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 08:01, Eric Lin wrote:
> Hi Krzysztof,
> 
> On Fri, Jul 21, 2023 at 4:35 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/07/2023 15:51, Eric Lin wrote:
>>> This add YAML DT binding documentation for SiFive Private L2
>>> cache controller
>>>
>>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
>>> Reviewed-by: Zong Li <zong.li@sifive.com>
>>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
>>
>>
>> ...
>>
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: sifive,pl2cache1
>>
>> I still have doubts that it is not used in any SoC. This is what you
>> said last time: "is not part of any SoC."
>> If not part of any SoC, then where is it? Why are you adding it to the
>> kernel?
>>
> 
> Sorry for the late reply. I didn't describe it clearly last time.
> Currently, we have two hardware versions of pl2cache: pl2cache0 and pl2cache1.
> The pl2cache0 is used in unmatched board SoC. The pl2cache1 is
> utilized in our internal FPGA platform for evaluation; it's our core
> IP.

And why do you add bindings for some internal FPGA IP block which does
not interface with any SW?

Best regards,
Krzysztof

