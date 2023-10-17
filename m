Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA67CC998
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJQRNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjJQRNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:13:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604FA4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:13:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c4fe37f166so69450181fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697562785; x=1698167585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sh8eLOBFVl/qMkjQqVR7VwaPs8qPzyo0SZOnoQF1las=;
        b=uzI6T7N/NSAYIc2Er26XScp9mEpeLfT5uGoHm1BCvIlmihfxOtrsJSwXDKRzAYPJUo
         Ik/q+iKOnCfrwnYwsNqEGV3dauBNDBtOUdbX04m6GbsCEI7WZZ7UCLn5RJ86T0OhJbxM
         QT2oij+1z1MLbtgUq4kA+Pg55HrRe8VEw+zCc22X77neRbqATbqBeapTXEFcizGB5zoG
         hBkVJ4PHHlSv8622AV1Jy90MHnXfOO9Npvsvo9E9wzM1vNBponsUfBwubdeTaPmMSne+
         Ch0vZxn45RDbQv1dschJixzxJPO21AS1Z+dY4sA0VOjOtGZZ2irL48yavFHTOt0NXESP
         yEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562785; x=1698167585;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sh8eLOBFVl/qMkjQqVR7VwaPs8qPzyo0SZOnoQF1las=;
        b=OUwgVe/9s3STQFi6h0nOK57wWinFD0NTuFBrbrfTPScfOb/8hw6zDqzx3lrxRanm8l
         O2f2CGbhfss3v0sP9qYBVku7Hk1DnZdDPVnB6adNOi3TCLwmITnr/7A3vOQVW1CW94Gf
         41JeXBkJtewGjLOyQSkBf9kIhVWUKZeacHiMCcfElMmap5/HLLWR/sogrNpft3FvIrEn
         ly2/TEh8p0YbTLwZFlbXpUbo2oZWcBROIWmkj6KgfMjOWRO3FJoWGgUySzUZlVMTCRM1
         TlyJPnq/wbRxiSKpV3+ieQR+ZQnqo73zKzGb+/fbYZbgjnvtVYBuM9OfNRDZ66pbGSdf
         EYHA==
X-Gm-Message-State: AOJu0Yyt+g2GApX59pQ76YpzljqnO+Mzj5yBPtDg+BSjCNv8lNrxCs5I
        jWuUCWQA73m1wRlAK6Akw4jE4Q==
X-Google-Smtp-Source: AGHT+IFciqtzoNcAnKm6FUo7fRMsIRy+b+gJyFmCmGopJYGEdxNdwig+tCTn4ivIW6GFHBJQC5iNbQ==
X-Received: by 2002:a2e:8781:0:b0:2c5:1075:5ec9 with SMTP id n1-20020a2e8781000000b002c510755ec9mr2238626lji.13.1697562784813;
        Tue, 17 Oct 2023 10:13:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003fe1c332810sm10487278wms.33.2023.10.17.10.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:13:04 -0700 (PDT)
Message-ID: <44333dbf-7023-4124-9586-2ca13e83c0fd@linaro.org>
Date:   Tue, 17 Oct 2023 19:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq6018: use CPUFreq NVMEM
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231016175532.2081344-1-robimarko@gmail.com>
 <20231016175532.2081344-3-robimarko@gmail.com>
 <2f22ed28-47b1-4a92-aae5-b625ab4ad731@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2f22ed28-47b1-4a92-aae5-b625ab4ad731@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 18:55, Konrad Dybcio wrote:
> 
> 
> On 10/16/23 19:55, Robert Marko wrote:
>> IPQ6018 comes in multiple SKU-s and some of them dont support all of the
>> OPP-s that are current set, so lets utilize CPUFreq NVMEM to allow only
>> supported OPP-s based on the SoC dynamically.
>>
>> As an example, IPQ6018 is generaly rated at 1.8GHz but some silicon only
>> goes up to 1.5GHz and is marked as such via an eFuse.
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index 9aec89d5e095b..49f0e6aa4b5bb 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -96,42 +96,49 @@ scm {
>>   	};
>>   
> [...]
> 
>> +			cpu_speed_bin: cpu_speed_bin@135 {
> underscore -> minus sign
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I think Bjorn does not read comments, so he just picks up such patches
because they got review. Better to ask for fixing it, instead of giving
conditional review tag, IMHO.

Best regards,
Krzysztof

