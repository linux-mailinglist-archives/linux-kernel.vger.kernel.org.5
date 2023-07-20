Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A9275B670
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGTSSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGTSSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:18:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F2186
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:18:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so1727266e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689877090; x=1690481890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=senDNrwiWuOfYj59UEyFt3M9kP51QB4iG5+klPG4J54=;
        b=OI5zj4YHHLybQ/wbTXCqfCeW6nL/OmL/1BSaDCSx+70qmKrqpykrxnASKJifClnp31
         clTyA+nlJg2K9l/K/RZ9zzmYMIUPA3nxAcEjmHoYvcr9UaAZ8AaOwwc2eCFxHJ2x43jw
         PPgVY+E3hIlj/X00Y1e7pAR/8EVrJoW2ddDip0lp3UHWbO6fx6k7lo3pML0X7ZUYXoEV
         ZlWtHa949GPfBKKVrUORvOTDbI7u3y9RL9uaAAQTOW6y5fac/uBGk+AKhZRf0+sdcn4O
         DP0j99r3rYOTb3+FtAF0Y9FShm9XoMPhlsMJRxzYoKs8ix6Kp2IlM97def1ghFuWSVQo
         WzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877090; x=1690481890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=senDNrwiWuOfYj59UEyFt3M9kP51QB4iG5+klPG4J54=;
        b=aaB9Z29jLGL3LZWaehGVWdZQV2MpFusZBgxUMBtAuOKzwFoAMIXsVJNkp3iQTuiG2s
         erfAjcSV4aggkx3KnO5lJ32VOegSb1ZxWXSgLH1MaHqlVzUzHK9MUpnpaPtp5e0atnrg
         zJlJ8WcfXmIQ1Bl7YT7GmA49udIz75b9QKptD2teeLdV1D8RW1NNxflJONlyMMUmdxmZ
         cB0iiG+QRm3WIq3zQ4KVKLNjEvxch+3wN3Vq9my6euz3rR+eaBrENb1bVHqtDK14wCU+
         J4G5hd/ND+BNGpwcAJnAnlUMStzkyYKpuU9ABtNy055p6Uhq6ah8x2JCJpq7JjztXqCW
         DsWg==
X-Gm-Message-State: ABy/qLZ+g0tJbtnBNm4s2RxPXA7naZelqp45CJGtGodNeRVFBsCsohM+
        6BKK7Yw0o4KJeNO2JbNQWelCRA==
X-Google-Smtp-Source: APBJJlGDhYeesS8Lx1AU09YaIgeaoiY/8zxvo048oKaDmngZ+YDsTXe6d3n+0nDg7OB6M3efVQ1wRQ==
X-Received: by 2002:ac2:44d8:0:b0:4f8:5885:61e with SMTP id d24-20020ac244d8000000b004f85885061emr2703446lfm.40.1689877089604;
        Thu, 20 Jul 2023 11:18:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id r29-20020ac25a5d000000b004fddac83416sm317540lfn.59.2023.07.20.11.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 11:18:09 -0700 (PDT)
Message-ID: <aa57b538-607d-27f8-292f-06912440c6a4@linaro.org>
Date:   Thu, 20 Jul 2023 20:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Resolve MPM register space situation
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v4-0-bae382dc0f92@linaro.org>
 <01907421-1003-1041-f1bd-ad11218527e1@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <01907421-1003-1041-f1bd-ad11218527e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2023 20:07, Dmitry Baryshkov wrote:
> On 18/07/2023 15:19, Konrad Dybcio wrote:
>> v3 -> v4:
>> - Fix up indentation in the bindings patch
>> - Add an example glink-edge subnode to remoteproc-rpm (its bindings
>>    require that..)
>>
>> Link to v3: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org
>>
>> v2 -> v3:
>> - Fix the example
>> - Pick up tags
>> - remove the outdated example from the cover letter, check bindings
>>    should you want to see one
>>
>> The bindings for the wrapper node used in the yaml example are merged
>> in qcom/for-next
>>
>> Link to v2: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org
>>
>> v1 -> v2:
>> - deprecate 'reg', make qcom,rpm-msg-ram required [1/2]
>> - Use devm_ioremap() [2/2]
>>
>> Link to v1: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org
>>
>> Depends on resolution of https://github.com/devicetree-org/dt-schema/issues/104
>>
>> The MPM (and some other things, irrelevant to this patchset) resides
>> (as far as the ARM cores are concerned, anyway) in a MMIO-mapped region
>> that's a portion of the RPM (low-power management core)'s RAM, known
>> as the RPM Message RAM. Representing this relation in the Device Tree
>> creates some challenges, as one would either have to treat a memory
>> region as a bus, map nodes in a way such that their reg-s would be
>> overlapping, or supply the nodes with a slice of that region.
>>
>> This series implements the third option, by adding a qcom,rpm-msg-ram
>> property, which has been used for some drivers poking into this region
>> before. Bindings ABI compatibility is preserved through keeping the
>> "normal" (a.k.a read the reg property and map that region) way of
>> passing the register space.
> 
> This almost bleeds to have some uniformity with qcom,rpm-stats (and with the boot stats). All these drivers provides us with the insight into the RPM memory.
RPM master stats - yes, it should be moved under this node.

The other stats - I don't yet know.

Konrad
