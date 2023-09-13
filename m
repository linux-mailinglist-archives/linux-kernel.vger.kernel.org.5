Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4879E26D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbjIMInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjIMInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:43:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722EA198E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:43:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8a822508so198346566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694594617; x=1695199417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VWbnSO3QqQi1sbJoehxyEUytvvrSclKo+E9q29SgaY=;
        b=j9mPSQFXsaLuexh6o8nfFNRBqWUNtRskjH6vag+wavV+H5hGEno1ZLYzhFTQEyJ5o8
         0v8ZT9XNtikxrsuvMX8sdvoBSldUyYvQuo7hmakYOooMUlp0bFlFSEFKDTwYuw7HQ+/k
         YA5dgeU/iq4ohiF7RgCIagvyIwisanDTQQY4DCmJoMIrgCtPHp/VyruoT42USbPim9uu
         JBkTNnaZHGxssxHhKPWS3U7Bs/I2Sy36sKxNswDUr10Nj7+qpI2oSZtn1gyab8W5uclz
         do2GwlR2G7fq3FvVQACub4EnUdFoCNgbo1M8vhJLE8sFyLB4AzxKQBfaKnvgeVonF5Sg
         j5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594617; x=1695199417;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VWbnSO3QqQi1sbJoehxyEUytvvrSclKo+E9q29SgaY=;
        b=Cd0aKmQlKClRb1cwL3XK1IISQ+mEsoPTcm9Qv6enDdGQeK1ztMCX+h7greREcHhk6q
         sdMjEMQG+if883SRCG/yZBPb9apvY9pMl+SvLQAcYGdxv76CYafhEdELpO8tUMgP5iOT
         AzRvHpEdYuvo12bGDgdJnnhL8dZwe7/waYTweg6EBYCtdE4QOFlUdlTkpJ+yseTTFQM6
         QJyPmel4veLChfADOblNaFt2TKp794YB5Y62hS13zjrxp7xsof/UbRIxpEFdDmf6O+gN
         8DA1BbaDNTztsFx3gs7wvXzZgrpcwzskPjp7maouPJpGX/nVlTivJYbSDD9Dyjg1LsNE
         /Vnw==
X-Gm-Message-State: AOJu0YxfucfpyHjzsSj5hnaPfIhT+atd7KtE8ZJrceHfLUVqL8mKcc4K
        uLJUIndjI/gX03hnJztRGPRVfA==
X-Google-Smtp-Source: AGHT+IHQhQ4tantOAn3/0fVJr3ybsNR+u4GIF0fRCDA9G6qqdjslm83NMWHFBY3AZ69t5v9qg6zGsQ==
X-Received: by 2002:a17:906:109a:b0:9a1:c44d:7056 with SMTP id u26-20020a170906109a00b009a1c44d7056mr1640901eju.26.1694594616915;
        Wed, 13 Sep 2023 01:43:36 -0700 (PDT)
Received: from [192.168.37.232] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id pv26-20020a170907209a00b00992d122af63sm8018251ejb.89.2023.09.13.01.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:43:36 -0700 (PDT)
Message-ID: <3260f0ca-9e27-4920-8415-7f364dff773d@linaro.org>
Date:   Wed, 13 Sep 2023 10:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc
 node
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Devi Priya <quic_devipriy@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, richardcochran@gmail.com, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
        peng.fan@nxp.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, quic_saahtoma@quicinc.com
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-7-quic_devipriy@quicinc.com>
 <CAA8EJpo75zWLXuF-HC-Xz+6mvu_S1ET-9gzW=mOq+FjKspDwhw@mail.gmail.com>
 <CAMuHMdXx_b-uubonRH5=Tcxo+ddxg2wXvRNQNjhMrfvSFh0Xcw@mail.gmail.com>
 <daed3270-847e-f4c6-17ad-4d1962ae7d49@linaro.org>
 <CAMuHMdVxykGwyrKKSHBv9AHy4gAeH7DT7caZarbs-F40zz5Jpw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAMuHMdVxykGwyrKKSHBv9AHy4gAeH7DT7caZarbs-F40zz5Jpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2023 10:38, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Wed, Sep 13, 2023 at 10:26 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 13/09/2023 10:23, Geert Uytterhoeven wrote:
>>>>
>>>>> +                       clock-names = "nssnoc_nsscc", "nssnoc_snoc", "nssnoc_snoc_1",
>>>>> +                                     "bias_pll_cc_clk", "bias_pll_nss_noc_clk",
>>>>> +                                     "bias_pll_ubi_nc_clk", "gpll0_out_aux", "uniphy0_nss_rx_clk",
>>>>> +                                     "uniphy0_nss_tx_clk", "uniphy1_nss_rx_clk",
>>>>> +                                     "uniphy1_nss_tx_clk", "uniphy2_nss_rx_clk",
>>>>> +                                     "uniphy2_nss_tx_clk", "xo_board_clk";
>>>>
>>>> You are using clock indices. Please drop clock-names.
>>>
>>> What do you mean by "using clock indices"?
>>> Note that the "clock-names" property is required according to the DT bindings.
>>
>> Indeed, thanks for pointing this out. Probably bindings should be changed.
> 
> But what's so great about not having "clock-names"?
> There are _14_ input clocks.
clk_parent_data has an "index" member, which lets us bind
clocks[n] to parent[n]. With the DT properties being ABI,
including the order of entries within, that lets us get rid
of clock-names and the matching is marginally faster.

Konrad
