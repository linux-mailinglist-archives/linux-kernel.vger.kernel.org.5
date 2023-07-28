Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC5766A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjG1KV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjG1KV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:21:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765C3A89
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:21:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3176a439606so1937715f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690539712; x=1691144512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIgEfewhGpZL2oootStRCMhanFh9VY72choSS9YmzH4=;
        b=NxDq3DG+yxfLIEQfOO22aJKk0bGDWEk0CEBem5sGVsJyO3ttk8QG6FjZMeD++65Klb
         YGP1ngTf0lbSR+x4VmRHr+maguADYZ5wIwN+2KLYWW0HSmf2BkQuZDvGFVq8RtGfKMT/
         6a0slrY1BLxZYBcupjFXDUd0kjb9/P8fJjntzYZun8TX05gR5ti/T6xDuHJz1+kRNb8g
         k66DSaJDRR2fhClrpE5OeXM0TtLjgu9QabcQzzlXup3zE5hgI6FwDTkQVHVWVcK+ujx3
         QiZlKlLaEIcCfOtJBhhoXyDaBvrPHbHPsGEs5R1MY37csqAg2F8TmGZu4W6FI30N+92j
         CJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539712; x=1691144512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIgEfewhGpZL2oootStRCMhanFh9VY72choSS9YmzH4=;
        b=c8u7HZhFfXpKeZXZOqFzOJMOFlO+2EQUNXJERwOC1eFphMix/9dgtLlpAl6pjy2JMU
         T50r3B+fcoBYkr97dZARzHPvgZ3dnonkBzfDR0jeHWWTkkp1bBYyNi7Pboa3uMe2obvX
         fBlB8Bg/CXMU/6uPMM55FVoFecGqEw1ilbmRlDarMqE1DyO/yqaCyxqm+996WShAx7jJ
         i4aEG7dSqmAsF9/22wONqnvo7u15HwmPDCycC0dE2PYl/ccrX43tR30CG2BYjUjiLqK1
         Qcv7G5laG0vV52I2ps8VBPTofZPdZLOB9BGYydEkt2hdCopZCv1cpGM/Nc+KDkjqW/6E
         3LXA==
X-Gm-Message-State: ABy/qLYsoD0nFhClnRh5k+rklcOPUMt2vRoOpzu+tXwstX9UbzCvGpbV
        xiphEzKO0eGgTKh9kBubNkR1ag==
X-Google-Smtp-Source: APBJJlGatVpVurWro1sxgHRR/ZwFuWVYnizMfKm3exRiGdVI37m231JPFE7Urg+Tu8qUDhpIjRytsw==
X-Received: by 2002:adf:fd08:0:b0:30e:5bd0:21a2 with SMTP id e8-20020adffd08000000b0030e5bd021a2mr1380869wrr.52.1690539712359;
        Fri, 28 Jul 2023 03:21:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d4c83000000b002c70ce264bfsm4388138wrs.76.2023.07.28.03.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:21:51 -0700 (PDT)
Message-ID: <86d26a0e-93ef-a5c0-08a3-b8b1172254f6@linaro.org>
Date:   Fri, 28 Jul 2023 12:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, Liu Yun <liuyun@loongson.cn>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <74a37e9d.9a24.1899b9bea85.Coremail.chenhuacai@loongson.cn>
 <1c8b12b4-79c3-5018-c7df-946fe690e8c8@linaro.org>
 <20230728-pessimism-exclaim-de0dd7f4bb64@wendy>
 <7986a634-63b2-28d6-5f17-7b982ae56bcf@linaro.org>
 <20230728-overview-suitor-b54b5f27389f@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728-overview-suitor-b54b5f27389f@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:14, Conor Dooley wrote:
> On Fri, Jul 28, 2023 at 11:45:48AM +0200, Krzysztof Kozlowski wrote:
>> On 28/07/2023 11:18, Conor Dooley wrote:
>>> On Fri, Jul 28, 2023 at 10:36:42AM +0200, Krzysztof Kozlowski wrote:
> 
>>>> Are we intended person/entities to receive your Reviewed-by tag?
>>>
>>> It's okay, you only got a "Reviewd-by" tag ;)
>>
>> I guess so, especially that this disclaimer should be useless. But on
>> the other hand, do I want to deal with it if once Loongson sends me
>> Cease-and-desist letter for something? Why even thinking about this
>> should be my problem? Why should I even consider this topic: is it
>> harmless or is there any risk?
> 
> Oh for sure complain. My corp email is not in the CC, but it arrived in
> my inbox there...
> I was just noting that the tag was not correctly provided in the first
> place.

Ah, I misunderstood. Indeed, the tag is not correct.

Best regards,
Krzysztof

