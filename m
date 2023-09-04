Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6086791E1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjIDUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjIDUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:06:50 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F6A100;
        Mon,  4 Sep 2023 13:06:46 -0700 (PDT)
Received: from [192.168.2.144] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C2BF03F261;
        Mon,  4 Sep 2023 22:06:41 +0200 (CEST)
Date:   Mon, 04 Sep 2023 22:06:35 +0200
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 3/6] dt-bindings: opp: Add compatible for H616
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Message-Id: <Z69H0S.FWOE3UYNRAYU3@somainline.org>
In-Reply-To: <6e4cd0a1-43d0-e2e8-7281-e20ae653eae6@linaro.org>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
        <20230904-cpufreq-h616-v1-3-b8842e525c43@somainline.org>
        <f512f11a-6b66-5892-ad9e-cc45d4abc508@linaro.org>
        <bda77747-aa97-0da9-fa73-cbb2dca48aeb@linaro.org>
        <2C8H0S.90380B1U7TPP3@somainline.org>
        <6e4cd0a1-43d0-e2e8-7281-e20ae653eae6@linaro.org>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Sep 4 2023 at 09:53:05 PM +02:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 04/09/2023 21:48, Martin Botka wrote:
>> 
>> 
>>  On Mon, Sep 4 2023 at 09:32:44 PM +02:00:00, Krzysztof Kozlowski
>>  <krzysztof.kozlowski@linaro.org> wrote:
>>>  On 04/09/2023 21:31, Krzysztof Kozlowski wrote:
>>>>   On 04/09/2023 17:57, Martin Botka wrote:
>>>>>   We need to add compatible for H616 to H6 cpufreq driver 
>>>>> bindings.
>>>> 
>>>>   Please describe the hardware, not what is needed for drivers.
>>>> 
>>>>> 
>>>>>   Also enable opp_supported_hw property that will be needed for 
>>>>> H616.
>>>>> 
>>>>>   Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>>>>   ---
>>>>>    .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>>>    | 6 +++++-
>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>> 
>>>>>   diff --git
>>>>>  
>>>>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>>>  
>>>>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>>>   index 51f62c3ae194..2fa1199f2d23 100644
>>>>>   ---
>>>>>  
>>>>> a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>>>   +++
>>>>>  
>>>>> b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>>>>>   @@ -23,7 +23,10 @@ allOf:
>>>>> 
>>>>>    properties:
>>>>>      compatible:
>>>>>   -    const: allwinner,sun50i-h6-operating-points
>>>>>   +    contains:
>>>> 
>>>>   This does not look like part of allOf, so contains is no correct
>>>>  here.
>>>>   This must be specific, so drop contains.
>>> 
>>>  BTW, I also do no see it used by the driver at all.
>>  Function sun50i_cpufreq_get_efuse uses it. It checks for H6 
>> compatible
>>  and if that fails we check for H616 compatible.
> 
> Such code does no scale. It also does not look reasonable - you cannot
> have different compatible there. Device binds to h6 or h616, so you
> cannot have OPP table from other devices.
> 
Heya. I checked how qcom nvmem driver does it. And yea this indeed does 
not scale. matchlist should have SoC compatible and driver needs to 
have single compatible. Thus also dropping this patch :)

Will do in V2. Thanks Krzystof for pointing me to the right way of 
doing it :)

Cheers,
Martin
> Best regards,
> Krzysztof
> 


