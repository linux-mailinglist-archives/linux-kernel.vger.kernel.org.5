Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73742791DA9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjIDTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbjIDTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:32:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D01A7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:32:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a2185bd83cso260405466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693855967; x=1694460767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZ6H5M4q548gV0CNQehrzM4g+Qp6ZkTiIwLgzPLmdrE=;
        b=KQHbcGg2qEza06wKXWjJyW+5jwb7PWYwfCfpqk4STzxrATbVejI80mDrcqYhfFyH7A
         3IHZytG0oRXvRSKQ/182aLUF3BwnHm+n23eWHAdncVBNDq+yYTB0iGgnw+5/PI6Le34d
         Jzb9nBLtS/qeDTkEF4X45mFI4b2OhcbmJAhUhqzAYLefp2tq1sM7g91uMt5Z/nzs8f/+
         H+I941HfFE01vT+BKC94CgLQ1pf7hgW6cmAsL2s10QYQw88F8Nld0NhCIF9UCJmwbHDI
         moeno5/yj5x5NoZlVu+swOJM1ArXPTgoS5dJxATLBJTsTzGkF1JwAsr50GM3UTK81c6D
         9Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693855967; x=1694460767;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ6H5M4q548gV0CNQehrzM4g+Qp6ZkTiIwLgzPLmdrE=;
        b=QrsWDJvjHdm3rpxwp3ONQlc3N3sHZ/NEcJqIw2aVJf9O+mPqw+gp55QW7qdbAcTGJz
         Ya9ZlaHbFObBQ0ZWyqBnOKFGrIfJIskod1qLcPfTLOO4X3na9mxSzJOEZ1mgEd0gW+xq
         l6CnaLaYXzxmsdnPx63fLlCYqu2har+NQI/ykEf3Bn60EL3biJmoLrcXS57FozYz+JtT
         oa0fRB6cYWqSgGG23sITovNb+t9M9861874WEigZF2YbwWn6uFe3IyNrBehvPEhKs0UP
         VRsXDwUJPGczspVpiDmOIjF9b1lGxuAreXr65QyrbnA8GrYDS601cak0EX3B9Ify8JIt
         xhOA==
X-Gm-Message-State: AOJu0YwCumxUxzHMo0HEZ6PNxAN0vXlAUb5Exr8xwzoQ9x+zsyOmsQq3
        jmUvPNM6TW6xcvbqPppvNslgYA==
X-Google-Smtp-Source: AGHT+IH0xh+QO8RhaNAVW0WGOeQOxfC0ae3lGMMNGhE9JO1OTC8YPy5jmTHCLOWkkmmbswgc2wghsw==
X-Received: by 2002:a17:907:b12:b0:9a1:aea2:d18d with SMTP id h18-20020a1709070b1200b009a1aea2d18dmr7710392ejl.48.1693855966844;
        Mon, 04 Sep 2023 12:32:46 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id qc8-20020a170906d8a800b009a5f7fb51dcsm6480287ejb.42.2023.09.04.12.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:32:46 -0700 (PDT)
Message-ID: <bda77747-aa97-0da9-fa73-cbb2dca48aeb@linaro.org>
Date:   Mon, 4 Sep 2023 21:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/6] dt-bindings: opp: Add compatible for H616
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Martin Botka <martin.botka@somainline.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
In-Reply-To: <f512f11a-6b66-5892-ad9e-cc45d4abc508@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 21:31, Krzysztof Kozlowski wrote:
> On 04/09/2023 17:57, Martin Botka wrote:
>> We need to add compatible for H616 to H6 cpufreq driver bindings.
> 
> Please describe the hardware, not what is needed for drivers.
> 
>>
>> Also enable opp_supported_hw property that will be needed for H616.
>>
>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
>> ---
>>  .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml          | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>> index 51f62c3ae194..2fa1199f2d23 100644
>> --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>> +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>> @@ -23,7 +23,10 @@ allOf:
>>  
>>  properties:
>>    compatible:
>> -    const: allwinner,sun50i-h6-operating-points
>> +    contains:
> 
> This does not look like part of allOf, so contains is no correct here.
> This must be specific, so drop contains.

BTW, I also do no see it used by the driver at all.

Best regards,
Krzysztof

