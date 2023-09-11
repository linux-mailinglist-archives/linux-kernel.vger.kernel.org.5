Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D9C79AE99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377710AbjIKW2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjIKKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:46:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C7E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:46:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so5614422a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694429177; x=1695033977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1POdEc/E2ZusgejphNXd3OJhAFK6/wwgs/QP11+1gVg=;
        b=EOdMZOHUjFCh2GZ7q3gstHGRSpbiu3cgdHcEqk+a4DcUM9vkDOPVxoAxb9b1Br0leT
         jOJAjmGfMwsFKQfsiEgLdN48k1ujyogfOMAaL4kXYsvS0AZOgBiQMKKrHlRxWtjIQCBR
         HXOHcex7S0b6OrR560kB2PT6duWiEXQ95hpPKMu2JcGBtuVyaEkmZSOYVUJTCnW8iuyI
         2CMQmbRdYOl5RwhDJJRmfNVgReGx92oM/WPfuSSIlw2t4a1CdbyhdlLBeDeeKuf3BNC7
         kIqSHzbay+uofeVdzAsgyF3XCbQAHJko2hzPIgItEbt6hfroYVzveyeAn+zlrSXsRLVC
         euUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694429177; x=1695033977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1POdEc/E2ZusgejphNXd3OJhAFK6/wwgs/QP11+1gVg=;
        b=titRnSTCgWtm1Ewj2RR+qxO85donHmd4R609KVC5pS08r34iWvrzQ0P1DT+1DkZ2XF
         C0TDEEylk+sdGRTQA+FnzmxuzxytMvGr9JBbnpvCeMb0Zd6W+k8Tbr2ksu4kAOdbWcp/
         CFgT+HeojekTn+tY4q8ON+UIKAfU9iKMY06ly4z1kW8H62zORtDPT/tSYn6l8HZajjPs
         j8tE8VqtncD++/WqqsV8ieawgIaoOrOfjLUS+1dmdTMlwxbelah38m4NsiKyDhh2QN9p
         yIlUcwsuzjJoAXugq87OiSCMhMVv6CtENgHPiB52nmTPCixXL/MonsKPXMaX+yGE9CBL
         lWxg==
X-Gm-Message-State: AOJu0Yz5Wsu50KwaOdBHbRGo/Z4hlwQSaIHlZftDsZHtNbWxXcE3f2P9
        RNQW3koJF3dAI4jOfcoa0FaMwg==
X-Google-Smtp-Source: AGHT+IGrKbf96+hmTkM28gwb18InoQ1Gar1UQttHOdx7jpOSjyR5QgXjIJJgRj7M7NjHoVVE83Mxhw==
X-Received: by 2002:a17:906:5db4:b0:9aa:e13:426a with SMTP id n20-20020a1709065db400b009aa0e13426amr4778375ejv.73.1694429177493;
        Mon, 11 Sep 2023 03:46:17 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr. [176.171.221.76])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709064c8800b0098963eb0c3dsm5170227eju.26.2023.09.11.03.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 03:46:17 -0700 (PDT)
Message-ID: <c742bdb3-1981-82e1-b63a-cd4b61666f14@linaro.org>
Date:   Mon, 11 Sep 2023 12:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-5-keguang.zhang@gmail.com>
 <1cc2c8f8-1f9b-1d47-05d4-9bcad9a246cd@linaro.org>
 <CAJhJPsVj1836-DoKTokxMd664FPX70vtSv96x4DfHzBFRZ_9Tg@mail.gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAJhJPsVj1836-DoKTokxMd664FPX70vtSv96x4DfHzBFRZ_9Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/8/23 13:01, Keguang Zhang wrote:
> On Thu, Aug 31, 2023 at 4:40 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Hi,
>>
>> On 30/8/23 15:42, Keguang Zhang wrote:
>>> Add two new F: entries for Loongson1 Ethernet driver
>>> and dt-binding document.
>>> Add a new F: entry for the rest Loongson-1 dt-binding documents.
>>>
>>> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
>>> ---
>>> V3 -> V4: Update the dt-binding document entry of Loongson1 Ethernet
>>> V2 -> V3: Update the entries and the commit message
>>> V1 -> V2: Improve the commit message
>>>
>>>    MAINTAINERS | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ff1f273b4f36..2519d06b5aab 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
>>>    M:  Keguang Zhang <keguang.zhang@gmail.com>
>>>    L:  linux-mips@vger.kernel.org
>>>    S:  Maintained
>>> +F:   Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
>>> +F:   Documentation/devicetree/bindings/net/loongson,ls1*.yaml
>>
>> Why not simply squash in patch 2
>>
>>>    F:  arch/mips/include/asm/mach-loongson32/
>>>    F:  arch/mips/loongson32/
>>>    F:  drivers/*/*loongson1*
>>> +F:   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
>>
>> and 3 of this series?
> 
> Do you mean squashing patch 2 and patch 4 into one patch?

No, simply modify MAINTAINERS at the same time you add the new
files.
