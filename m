Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4579FD16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjINHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjINHSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:18:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB722CFA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:17:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31dca134c83so553116f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694675875; x=1695280675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnyV9af3KTDSn5LmFo4v6eXcrqZ+B9e5Qxfuac0pjUY=;
        b=bBbpkGr2n0HTB6HQGlZEQHjLa0Tpxp1IpvUIgNVu3aEXG/u1wqNiL9RxT+wFLnVAYy
         lPYZSiSU4+dwTbDl+IGFoxUUQUosc8UeoUMfYbiUIl782pzdNqpyRwCktg9c4nVFRXLm
         gBkPYu82+qa7S3WbZfzhkViQiSBxJbOfQRAUi27r1hseHd+buQOw14PaM8URO0OxFhsX
         CMHqyrAl1/AKfEPm1sFEICCOjo4cdLFWHUtMAwrUgr/cS+hgl6ORmdowGd1C1Gdy9/bY
         RZ9iWU5fCtdPoj6s74p7WfHO38h1xLLtMb50CrDf/Y28likNu0J6nXW249GkdCUqp3Gj
         c+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675875; x=1695280675;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnyV9af3KTDSn5LmFo4v6eXcrqZ+B9e5Qxfuac0pjUY=;
        b=fdypbQ3lifM+XmRPSksWEJFwBYT1o840Rgy4Md8HtTV5MNZz/GCVpW3it+ERfZ26dQ
         irFBF05UuzroqySMEGZTRuzWpEaBIEVfLHSCAgBcXqtAoTbDZsyFte2Hfxd6/xbm81vo
         hTaEvl9t5wL7OM8Tto4V3MqhpFG/ZUTA1Wg2twijcC1R/Vc1EuomRAaDnJpuS2qTvBMY
         P4NTBKJ+jc0T6G8yS76GIPrVh3s2qQygShtAbs67Y3mWokwrWFvTldO7ngxb0yPq+qSD
         JsIR/a1Vx3upNQOF0JZ7wnEuGs3zirW6smE0MXzoO5US0/mfJAUh7gr8hA0hVNxh12m2
         5hXg==
X-Gm-Message-State: AOJu0Yx/3a7W3hTThl+zY5BfFX8oZ8dvkkfei0g3n4RtU1v+J83LbkvO
        x1tcuQFHIOjuMxdIl2PnUZL0NU8TD+xiscFWDVc=
X-Google-Smtp-Source: AGHT+IEK6SYA+nBzWeG6lMDvkeq82QWkULn4oFR/HTZ2x3sw8wMbXcV31yc++OhQtubr4HHqola0wA==
X-Received: by 2002:adf:de8a:0:b0:314:3bd7:6a0c with SMTP id w10-20020adfde8a000000b003143bd76a0cmr3970173wrl.33.1694675875014;
        Thu, 14 Sep 2023 00:17:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0031f5f0d0be0sm933196wru.31.2023.09.14.00.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:17:54 -0700 (PDT)
Message-ID: <bccc1cad-c50b-c10e-6cb0-80b6fb7ac4cd@linaro.org>
Date:   Thu, 14 Sep 2023 09:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] scsi: ufs: qcom: dt-bindings: Add MCQ properties
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694675158-38301-1-git-send-email-quic_ziqichen@quicinc.com>
 <1e89183a-b42a-b447-0c1a-bbfe646705ef@linaro.org>
In-Reply-To: <1e89183a-b42a-b447-0c1a-bbfe646705ef@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 09:16, Krzysztof Kozlowski wrote:
> On 14/09/2023 09:05, Ziqi Chen wrote:
>> Remove the maxItem limitation to property 'reg',

Your commit should answer to "why". Not "what".

>> and add description for the property 'msi-parent'.
>>
>> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> index bdfa86a..5ec2717 100644
>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> @@ -77,7 +77,13 @@ properties:
>>  
>>    reg:
>>      minItems: 1
>> -    maxItems: 2
> 
> So 20 items are allowed? No, that's not correct.
> 
> 
>> +    description:
>> +      Register base addresses and lengths of the UFS areas.
> 
> Drop description - it's useless and redundant.
> 
>> +
>> +  reg-names:
>> +    minItems: 1
>> +    description:
>> +      Names of the reg areas to use during resource lookup.
> 
> Drop such description it's useless, instead list and describe items.
> 
> Also, why all devices now have two regs? No, this is just wrong. And
> haven't we been here with two items?
> 
> 
>>  
>>    required-opps:
>>      maxItems: 1
>> @@ -97,6 +103,10 @@ properties:
>>      description:
>>        GPIO connected to the RESET pin of the UFS memory device.
>>  
>> +  msi-parent:
>> +    description:
>> +      Pointer to the hardware entity that serves as the MSI controller for thi UFS controller.
> 
> typo in "thi". Not wrapped according to Linux coding style (as written
> in coding style document). BTW, this is usually just "true" and without
> need for description.
> 

BTW, for both my comments - for reg/reg-names and this property - where
is the user? Except adding this to example, I expect to see users somewhere.

Best regards,
Krzysztof

