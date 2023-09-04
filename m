Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04D5791DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjIDTxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjIDTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:53:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAB0E8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:53:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so26835071fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693857199; x=1694461999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvaluZJNHnPZbmcG4bvJEAilbtSGa3vKoc36gbuUccA=;
        b=YaCgnZQYUFrNKrWgiRWzxWLqXHtEnuo90zmvzxCALMKuh61rMrX9XadWKKju1PUVCh
         MclK1+x+scodJ31IrVweGlL1CCF598CmyzCZ6DaBmtVkEgHz/4tkG6BOngZ3EbZQEN/X
         Lm12syBEvSvvRBBjAwhrZdPuVagH6/HGhTUnCQJMPYT1cun1b6LJCazswg2GrWLRr7LS
         H5p2TP3xevKmNUAdkKzWO6Q7MCjptiqTNchxm0oIlhRGcjvtzE8vktRaL/0isnLqv4Qc
         Y8PN5+TIMW7WPV+rvHNmHM6VuUDwfL9O7Llqpmv8A1f94x9wMSv/nfK96Lss9F7gecdM
         gFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693857199; x=1694461999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvaluZJNHnPZbmcG4bvJEAilbtSGa3vKoc36gbuUccA=;
        b=SRBso8vWJtJf/67F6C9BRwfn09B6bjj3KJMDUs5N19UEq8ZkiMz82NDCSrA0gVM575
         TVbAYbt7upCRvhB1fWngRZw/sdyfzRfPmbSMzSLqUtHoAJvo7Jpcavj6iFZCnqVtrf1v
         WYB2mvrOjzcrK2f3kje/A6KdSglXPESmTBpUasUVF0qyyGJ8nF7EGfA6m8cPe9HE2poI
         kmfYZr7KN5YqKf/brzDPyqTr/GoBLwlgzauatvv/tpGZW1+iLg4IjhtaHI3pZFPeKG5y
         BoIoItVOMOdqCbAeJuHu0iTFPdo0wxkx51P6ncD1Ii0NMfgNSpV5I0NWnauYKnYD/94x
         PBsQ==
X-Gm-Message-State: AOJu0Yxy1qWhsovNeCw9w4rZujc/AAhQKAo0M/L52BwuduPBl3k4xBpN
        iEOcofOJh/3EUt2idDONRKy3XQ==
X-Google-Smtp-Source: AGHT+IEfhBCcSQiWoHa2jiOolRPp2v0XsshOTlOP4jb6+QXkRjWKBP4OryeydAehfnhfGWiOqrEa0w==
X-Received: by 2002:a2e:6a09:0:b0:2bd:16e6:f07c with SMTP id f9-20020a2e6a09000000b002bd16e6f07cmr7407883ljc.17.1693857198894;
        Mon, 04 Sep 2023 12:53:18 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090637cd00b0098e2969ed44sm6475829ejc.45.2023.09.04.12.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:53:18 -0700 (PDT)
Message-ID: <6e4cd0a1-43d0-e2e8-7281-e20ae653eae6@linaro.org>
Date:   Mon, 4 Sep 2023 21:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/6] dt-bindings: opp: Add compatible for H616
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
 <20230904-cpufreq-h616-v1-3-b8842e525c43@somainline.org>
 <f512f11a-6b66-5892-ad9e-cc45d4abc508@linaro.org>
 <bda77747-aa97-0da9-fa73-cbb2dca48aeb@linaro.org>
 <2C8H0S.90380B1U7TPP3@somainline.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2C8H0S.90380B1U7TPP3@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 21:48, Martin Botka wrote:
> 
> 
> On Mon, Sep 4 2023 at 09:32:44 PM +02:00:00, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 04/09/2023 21:31, Krzysztof Kozlowski wrote:
>>>  On 04/09/2023 17:57, Martin Botka wrote:
>>>>  We need to add compatible for H616 to H6 cpufreq driver bindings.
>>>
>>>  Please describe the hardware, not what is needed for drivers.
>>>
>>>>
>>>>  Also enable opp_supported_hw property that will be needed for H616.
>>>>
>>>>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>>>  ---
>>>>   .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml        
>>>>   | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>>  diff --git 
>>>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml 
>>>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>>  index 51f62c3ae194..2fa1199f2d23 100644
>>>>  --- 
>>>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>>  +++ 
>>>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>>  @@ -23,7 +23,10 @@ allOf:
>>>>
>>>>   properties:
>>>>     compatible:
>>>>  -    const: allwinner,sun50i-h6-operating-points
>>>>  +    contains:
>>>
>>>  This does not look like part of allOf, so contains is no correct 
>>> here.
>>>  This must be specific, so drop contains.
>>
>> BTW, I also do no see it used by the driver at all.
> Function sun50i_cpufreq_get_efuse uses it. It checks for H6 compatible 
> and if that fails we check for H616 compatible.

Such code does no scale. It also does not look reasonable - you cannot
have different compatible there. Device binds to h6 or h616, so you
cannot have OPP table from other devices.

Best regards,
Krzysztof

