Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB76379FBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjING0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjING0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:26:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771F4101
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:26:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bfb12b24e5so9049371fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694672805; x=1695277605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vNd6Mhf35GMe9RWa+Xf0nZSRO80+x90q1mI0LjqNNU=;
        b=Oc5FOE5NRLURDO9gHKvjQiw11UkgkUHNO7QO0NipBLm5wweU1u8hYodmpLlTTF6mSy
         LyEvduS4dNk96AFboKHEW3J/3y7V7Fqf2maeXO/CW7pONwY5S26zcmHbDagxm8sNsp25
         scsuwUx7N0HR/bgKoNtmdOApdS4G42JECmGIAca2GYkX8Bxt8v1D7kCLviGEt0pxsd5J
         4peZCXCosIHDzDXizPqWKZty3hqheCwhSn4mU3KMTQItm4m6ljXANv037csLgDo04mqR
         fXhgNKsO1CuE4QQUi+jjvr7I1dZjHn76LjtU5Q3OFTQmAqaTPv6o9M7ZEQnJDcvymOLT
         G3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694672806; x=1695277606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vNd6Mhf35GMe9RWa+Xf0nZSRO80+x90q1mI0LjqNNU=;
        b=XEZ2rifOrCrhiiPizPmcMD+a0K6//zhpkGb3+YXLSg+5VfM5H23zq4Mqq3WNnN4Mv9
         ZORf2c9y+qYq9csYqjBvX5i38XCaPI/QUR4X1oBBgtDmS4aWzfpisV1s1OGOKz0KHZxK
         u2qK0e2vTM19I+25VYZqtocyAcrZ29UXIANhhnbUMTxK1GXayT/javANErpdJ8RsAiLd
         QJkjbJZH2HJ4yugyAWLdRDdsVLgobM9OLeACJ9F9q5Vm6QDFMWw++6qUL/gZLRXDHUVt
         JhCBRhurtkSS8gU6MuR4Rdz4X0Q9sFL5YbnqmsFcBHOyfwpPQtv6kosKHRpVetbY0huf
         WLBw==
X-Gm-Message-State: AOJu0Yy/QduGsRqUoovJ/AMTT5wEpO+eWWu02TBYT5vX8+mE/rtGgf1B
        Y33VqF+0QOl6/SPyL8ilu8yg7w==
X-Google-Smtp-Source: AGHT+IEXyD/63hRonxcmIDGjRGZcaw+/cu+rROOPezAiFh0Nr/O9LBQRR/P1DTlJe4FEXa2CWCykZQ==
X-Received: by 2002:a2e:9c0b:0:b0:2bc:fa8f:83bf with SMTP id s11-20020a2e9c0b000000b002bcfa8f83bfmr3161470lji.36.1694672805675;
        Wed, 13 Sep 2023 23:26:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ce11-20020a170906b24b00b0099cc1ffd8f5sm520889ejb.53.2023.09.13.23.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 23:26:45 -0700 (PDT)
Message-ID: <7796431f-ae52-58b6-499e-566a17292725@linaro.org>
Date:   Thu, 14 Sep 2023 08:26:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 06/14] arm64: dts: qcom: sdm630: Drop RPM bus clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <20230721-topic-rpm_clk_cleanup-v2-6-1e506593b1bd@linaro.org>
 <70b2a9d7-1a3e-25da-3d78-7bfa5d3a1e05@linaro.org>
 <c3dd5f68-af75-4880-83c2-ca7723561ae9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c3dd5f68-af75-4880-83c2-ca7723561ae9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 14:08, Konrad Dybcio wrote:
> On 13.09.2023 09:13, Krzysztof Kozlowski wrote:
>> On 12/09/2023 15:31, Konrad Dybcio wrote:
>>> These clocks are now handled from within the icc framework and are
>>> no longer registered from within the CCF. Remove them.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
> [...]
> 
>>>  		anoc2_smmu: iommu@16c0000 {
>>>  			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
>>>  			reg = <0x016c0000 0x40000>;
>>> -
>>> -			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>>> -			assigned-clock-rates = <1000>;
>>> -			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>>> -			clock-names = "bus";
>>
>> This is also against bindings. After your patch #4, such bus clock (or
>> other combinations) is still required.
> So, we have 4 SMMU instances on this platform:
> 
> MMSS (described, iface, mem, mem_iface)
> GPU (described, iface-mm, iface-smmu, bus-smmu)
> 
> ANOC2 (this one, no clocks after removing rpmcc bus)
> LPASS (no clocks)

Ah, I did not notice it.

> 
> Should I then create a new entry in the bindings, replicating
> what's there for msm8998[1] and dropping the entry with just "bus"
> from anyOf?

So this passes the bindings, right? anyOf: in the binding should allow
also no match, so this should be fine. However indeed we need to drop
the "bus" entry, because it is not valid anymore.

Best regards,
Krzysztof

