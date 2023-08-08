Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6D774F89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjHHXrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHHXrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:47:13 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EB719A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:47:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so95606191fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691538430; x=1692143230;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VZG7TCZvLFAbHq/1wBLzx2E5YyVPigTkVZVHiMhQFnM=;
        b=U+wtHP2lc50CwCQVIKv4CrFV0GfCfxF26eroErW+Sn5QXWbPBU9YME9XmuPVRSUGBj
         QMDjoDzZeqwOk2jIvaSM4ly0C6xF48aJVJF9DidB4vkcLpNy3VHizUfHp4efk/38JbLz
         lR7ieaBiGeM05a1baPyWeMxCns5nTAouAWyT72K6Wa4uay7XIWdBdn014Tv7oRL6J5vF
         8vKoPce4p5ciHVVSqBxcimHI5qDGq0g3wyR4gW4io2qQX7lkXqLS7o8pZ2HzUSWnokYD
         p5x0eSHthR3L8nnh72hdC+Z7oB+hBBWTAoSGFv7ozyyPnDID3mpDfq4xyjeEkW+pCi3i
         Toqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691538430; x=1692143230;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZG7TCZvLFAbHq/1wBLzx2E5YyVPigTkVZVHiMhQFnM=;
        b=AVdoRmDA6/mQG4IDtbafoDnidQUqEP+V7iOAKiFAjJ5WzgsC3x0+Sp3vOjPusMUOUO
         Y95PbH+XRiNKCgNPXiPb5g5HPQhasSIq3viSTeVVpZKY2PL0shWcI6g8Yp9V7ZSITs+M
         zaNs+FMhKgI9lEzGOzB9R/VXBQzLht9NTo5KOIwSYlmVoWdrzVvZCWl/ANI4KXBB3rNP
         0todKzsZ24uBLT7AXRAEXpHwGbL216uM8Sjg/IHkf0B8hoZSmGiMKRKy1ns481ECw2RE
         8tmasZ3MPoONfvlRbm9o6KwWz4/8Xq2nZi1BPI+NypDzals0DDJDPfeIlM4zbdOrItMF
         ZpXg==
X-Gm-Message-State: AOJu0YytvXlUYMEtNhvOgDEJOsqLtqkrlNui1coXOkRgdKI7qbvabreC
        8vONuMwAl/IXDyqXJCyeUXe0Mw==
X-Google-Smtp-Source: AGHT+IFBWK7BtOK07P1lkRjIV4kNADCddzfkRWw6PRzybwN5eLRLi+bkzQh96jH5UwNvaKPrKEX05w==
X-Received: by 2002:a2e:97c3:0:b0:2b9:bf49:901b with SMTP id m3-20020a2e97c3000000b002b9bf49901bmr670235ljj.6.1691538430152;
        Tue, 08 Aug 2023 16:47:10 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id t3-20020a2e9d03000000b002b6d7682050sm2473194lji.89.2023.08.08.16.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 16:47:09 -0700 (PDT)
Message-ID: <60cbc599-e95b-4723-9cc0-525bfe5cfcbb@linaro.org>
Date:   Wed, 9 Aug 2023 01:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8996: Improve GPU OPP table
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>
References: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
 <20230329-topic-adreno_opp-v1-3-24d34ac6f007@linaro.org>
 <CAA8EJpprgiXWZC2W3JSgG3jtTZDtbwoeQ6LBK=pqfpk0oMvNRw@mail.gmail.com>
 <bc5dd7d1-e001-8bd2-55c6-b6827c418371@linaro.org>
 <0e703d3c-7ad9-6265-fa71-b62650b96e79@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <0e703d3c-7ad9-6265-fa71-b62650b96e79@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.2023 15:30, Konrad Dybcio wrote:
> 
> 
> On 30.03.2023 12:57, Konrad Dybcio wrote:
>>
>>
>> On 29.03.2023 23:32, Dmitry Baryshkov wrote:
>>> On Wed, 29 Mar 2023 at 22:17, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>> Remove the self-explanatory comment about opp-supported-hw contents,
>>>> add required-opps to ensure reasonable power domain levels are voted
>>>> for (currently we've been piggybacking off of miracles and MDP votes)
>>>> and add newlines between each subnode.
>>>
>>> I'm not sure this is 100% correct. The values that you add are correct
>>> for the voltage scaling case. However, based on the vendor kernel
>>> sources I think that MX should only be scaled if the voltage is scaled
>>> too. I might be wrong here.
>> MX must be >= CX (and GX), so this should bring no harm.
>>
>> (citation needed, but that seems to hold true..)
> With that in mind, would you ack these patches Dmitry?
Bump?

Konrad
