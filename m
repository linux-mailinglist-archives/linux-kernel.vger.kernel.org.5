Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44C79E532
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjIMKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjIMKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:48:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FAF19B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:48:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502b0d23f28so6320226e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694602115; x=1695206915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p16cqlEMd92dBAoEF5vuQJ+lywDLoY/B9Jgb5zxp2p0=;
        b=LjQ4YNxwyEuEVVbZCl3cbXU1A0qTSXmzVEJS0wxnrY3B6inoa1zwiTXIxw61iAq+uP
         j4IMkBOaFPAm2ivvdw3G1UNzETiNTfMejxPT2/vGCvoHeNrPCJlpqQBuhd1yMEdPMv+r
         hxamMG5ByWA4+KwRXCkoDtyeHvbp1oGJuPXQxFZQvvnvgO9dt3EvdcZI5tMdkr/h0PIY
         igoqcctZwamnak3rk6PcJCzklS5xnWEAcqrvuWGXkzCTTJ+QOm4Yprp8DPovkq11BLnT
         WobdSyAC/Ax0vCQ8owGwgGruZi1KNFefx19Rp1bOBLFbf47sU7mPXS4huenCcAPFGC+0
         wjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602115; x=1695206915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p16cqlEMd92dBAoEF5vuQJ+lywDLoY/B9Jgb5zxp2p0=;
        b=C4tYrorYWtPq9ZHbXAafga63hExFCRoIQsx3y80U3jJEoa+g2DYZ+5L1bD10Ev7ZCe
         iTMtbH2cNSh/Jdr+T8+xqW1eTNZFhF1LSKXCTkw/8foBplf8zU4lTicWEbWFbHw+cn16
         +31HTpzNN3t6miXlt7yrwloHy+EwA1ydkn7d1D0kqQa2ku822scoTGB9XqcJ68OtkGw5
         1nSpz+noz9AyYLhjXWd2a9o0hpP9geHC0i5N+TPk++OY/PW6F1FcJMC6ZufPC6L7t764
         +OrmxL7McP2mwGBSkDusszVdjTYkpMl1BLaLG5aez/297w2Yks3A3GwTBINOm4YZxN5Z
         L+bA==
X-Gm-Message-State: AOJu0YyRVdZwHcgS5FttcDB1Q5tSvfogCH6xcW2KPx/YRM01qay32d9e
        Vsgqi66OMt8CZw1AUrS+jFRmEQ==
X-Google-Smtp-Source: AGHT+IG48WWjkEWSjFk2Tm3UfkWLLr5E+apDU8n7m6FZ9NqSOJmFHWSuYVjzkSlqyQtdjNNAxFQjHw==
X-Received: by 2002:a19:2d08:0:b0:4fe:1681:9378 with SMTP id k8-20020a192d08000000b004fe16819378mr1770190lfj.66.1694602115188;
        Wed, 13 Sep 2023 03:48:35 -0700 (PDT)
Received: from [192.168.37.232] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906390a00b00992e94bcfabsm8185483eje.167.2023.09.13.03.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:48:34 -0700 (PDT)
Message-ID: <9a0ab5a9-d4d8-41b8-94b0-9c62bd686254@linaro.org>
Date:   Wed, 13 Sep 2023 12:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] arm64: dts: qcom: msm8916: Drop RPM bus clocks
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-1-1e506593b1bd@linaro.org>
 <bd11d1b1-efe5-4f96-43e7-163fca5d3278@linaro.org>
 <ac501bcc-80a1-4b65-ba24-272152d1c95c@linaro.org>
 <7b500bba-3091-f425-a60d-e58a3d9e4c1a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <7b500bba-3091-f425-a60d-e58a3d9e4c1a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2023 10:53, Krzysztof Kozlowski wrote:
> On 13/09/2023 10:47, Konrad Dybcio wrote:
>> On 13.09.2023 09:07, Krzysztof Kozlowski wrote:
>>> On 12/09/2023 15:31, Konrad Dybcio wrote:
>>>> These clocks are now handled from within the icc framework and are
>>>
>>> That's a driver behavior, not hardware.
>> I believe we've been over this already..
>>
>> The rationale behind this change is: that hardware, which falls
>> under the "interconnect" class, was previously misrepresented as
>> a bunch of clocks. There are clocks underneath, but accessing them
>> directly would be equivalent to e.g. circumventing the PHY subsystem
>> and initializing your UFS PHY from within the UFS device.
> 
> And every time one write such commit msg, how should we remember there
> is some exception and actually it is about clock representation not CCF
> or ICC framework.
So is your reply essentially "fine, but please make it clear in
each commit message"?

Konrad
