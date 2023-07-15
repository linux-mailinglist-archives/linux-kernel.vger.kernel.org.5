Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7408875499A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGOPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGOPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:09:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F32D7B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:09:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so4810941e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689433775; x=1692025775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGa9xQaYwq0n16HqAxWg44ncoO3Biv87YQ0pHHY9Ofo=;
        b=TdPg72x7UN3o7OWsHcoPnR/M8c8xPlSsKpd+CJ56q6yVkaGYsej4OulOcFeD0kvhZD
         prx1rl9riVLQJXaa9NAyIvEhOtuxyQL01cUTAaLWEDLxK/2R+sWbRhQ6KJeHToWTeFlP
         giSyrDqmWzTdLfkSTQx7c18qpXdDbaokX3oFUAPVLrjWiMRUBvwKm8Zr666LBr+2X3nU
         ahpUz8TqZ2aV2L4omNuj4QeK3PzskdQnVSEJdwTjU7aKC+IdyrAlg5w1PZM2ziS9icDN
         jRFkpMDX7FRv7U5AlVkE2Q+TR4r0RruPoq0IWSrR8T3Qs5AK8zDRBL6wb7fgtpAlBsJ+
         ffOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689433775; x=1692025775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGa9xQaYwq0n16HqAxWg44ncoO3Biv87YQ0pHHY9Ofo=;
        b=MXAEFUnmvVVsELxyH9DNGrFRSKcopHiTpt/x9bTbAfScPZwACSxm/cZHoGv37k/kyz
         sVyqkpa2dliBT1Zqg3onfVmLKtevQtupdYh06iYZu6cIzNdqhpbMmH5g1aAZOMecVyKp
         pqcykWpkH2TCUGey3mM/l/P/SsCpG0QRnXkLeAtOd5t8pj7xoFP1TP7t1jLNgE4/KP8J
         BSge4IQbNn+oKdOedbpaMUgh6s8N/BsEiNxKxkkGwE/OVC0dgnRAhGddH43hmKX8/6eG
         98SIWZiSfWxKuYKUMHFytrvtploxLa8Cf5/OgLQHVTtGnTXcP+PGjGdIXRMsnPtIhj52
         97cQ==
X-Gm-Message-State: ABy/qLYhA/3fJBCq+2jKwOvrol7Ioxr+RNWsa6LUAehGJxoISJcDAgUP
        uh9KGVnKhe5lKnC2a5mxo+PhtQ==
X-Google-Smtp-Source: APBJJlFH/Yo8cIGAb5QeEOdg6Z9p9FwimLUt6nDaACnwbOc/nYYlL1zvq/+Bg5EFnWgdmaSIBMA8sA==
X-Received: by 2002:a19:7918:0:b0:4fb:9050:1d92 with SMTP id u24-20020a197918000000b004fb90501d92mr4508841lfc.51.1689433774714;
        Sat, 15 Jul 2023 08:09:34 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id v6-20020ac25926000000b004f8555f7aa1sm1916688lfi.52.2023.07.15.08.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 08:09:34 -0700 (PDT)
Message-ID: <9201cb8d-845a-b5dc-02a5-9633572b5877@linaro.org>
Date:   Sat, 15 Jul 2023 17:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/53] dt-bindings: interconnect: qcom,bcm-voter: Add
 qcom,bcm-voter-idx
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <20230708-topic-rpmh_icc_rsc-v1-2-b223bd2ac8dd@linaro.org>
 <68fb8e22-dd23-d4bf-eda0-444039fd8e26@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <68fb8e22-dd23-d4bf-eda0-444039fd8e26@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2023 22:43, Krzysztof Kozlowski wrote:
> On 11/07/2023 14:18, Konrad Dybcio wrote:
>> In order to (at least partially) untangle the global BCM voter lookup
>> (as again, they are shared throughout the entire system and not bound to
>> individual buses/providers), introduce a new required property to assign
>> a unique identifier to each BCM voter.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/interconnect/qcom,bcm-voter.yaml       | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> index eec987640b37..09321c1918bf 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> @@ -38,8 +38,14 @@ properties:
>>  
>>      $ref: /schemas/types.yaml#/definitions/uint32
>>  
>> +  qcom,bcm-voter-idx:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      A globally unique predefined discrimnator, identifying each BCM voter.
> 
> s/each/this/ ?
Right, this makes more sense

> If I understand correctly, there might be more than one instance. The
> problem is that I cannot find such case in upstream sources.
I don't think there can be more than one per RSC.

SM8550 splits some RSCs into "channels" and these channels have their
individual voters, however they would still be attached to these
channel subnodes/subdevices and no, we don't support that yet.

> 
> 
>> +
>>  required:
>>    - compatible
>> +  - qcom,bcm-voter-idx
> 
> This should not be really required, because it affects the ABI.
Hm.. can I deprecate lack of it somehow?

> You also
> need to fix the reported warning.
Ack

Konrad
> 
> Best regards,
> Krzysztof
> 
