Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3817549B6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGOPPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:15:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1902D55
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:15:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f954d7309fso3627015e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689434128; x=1692026128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8KNCC9I1F9kjTDVRYpGot4ReKfbTH+5U1hLH87sHgA=;
        b=vCxGnQa+LCkNlnmfK8Qayb3iyzeW6pXHZtCyqghxe0qwfiW0sg7vZD+Y/Fx4VYqf5x
         HTkinc+fYyy9fGenLz3NiNjSsk179AtdxHYo/RcPhrGHmQ0zXVMzCJnDQwZvXlqwF97t
         B8xKRBoqTy+HctJFjfeDoRTYHoYUkewKSMSCYlhDVZtn/Km9YbKY876XJfEkh4oWJyIA
         rNBOgvnyQLi3vW688bGwup4XsSU6lWN/m0nrtNUCGkejbS8mWh2wRFidLhosGWvgO2F/
         77vsViNzk/ltUO6bTIr924fSQHhzPinkCGkXHM480FIjTf5HdJ8nqqRyqWyNQzkQBtdH
         E6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689434128; x=1692026128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8KNCC9I1F9kjTDVRYpGot4ReKfbTH+5U1hLH87sHgA=;
        b=QfMgk5/ovAvLxscw2AxE/Da820r3WjZ+uVBpG7Ii4aW06t1OmJPQgYw2CHrKPkigv0
         8IomzA0Q5i8lGPa7PaNdIWSy4COmdBqRrfR5M63t7wjYs+g8kbs8n202zwPEEFt6qlHF
         oWAzXINLWRLkKm8MvSI896yIOOTpBtc26Qu6KESFe6gpvSepNnoEpkmHWQJK0SBP1DNs
         eA1ZrlbyUu4sraqAO9et5RUu6UKZEb+PmWYofW+bBmZCr8XZBoSN3nDGKcNAZH15PDfC
         ptS9hCZLujBLQTgy1ECPKs/DS9629vGgyhuYUEC1Ob0X04XACPGM/IKdGmKMdWQR4pPd
         ZQeg==
X-Gm-Message-State: ABy/qLbh5yLPfjQ0MzSm9nb1QbuRR9HpdlbfSLgxfhtE2pmYUtmf6oLt
        IvWsePhtP4RvIOO1MyXmph/++A==
X-Google-Smtp-Source: APBJJlFhO1YTRc+DLVe6cqQkOVN5T/FwqJCpdLG+LekoBoSwlnhcoF6SYn52wV2EdmMKlSj1yauTYw==
X-Received: by 2002:a05:6512:3d86:b0:4fb:a5b9:98ef with SMTP id k6-20020a0565123d8600b004fba5b998efmr2453295lfv.26.1689434128601;
        Sat, 15 Jul 2023 08:15:28 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id v4-20020a056512096400b004f13cd61ebbsm1941406lft.175.2023.07.15.08.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 08:15:28 -0700 (PDT)
Message-ID: <9c0d6ed8-ebac-87a3-ba10-0c9a1d8eb6da@linaro.org>
Date:   Sat, 15 Jul 2023 17:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/14] dt-bindings: display/msm/gmu: Allow passing QMP
 handle
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
 <20230628-topic-a7xx_drmmsm-v1-2-a7f4496e0c12@linaro.org>
 <9256aa76-ded3-3fad-4564-e3451cf74065@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <9256aa76-ded3-3fad-4564-e3451cf74065@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.07.2023 10:29, Krzysztof Kozlowski wrote:
> On 28/06/2023 22:35, Konrad Dybcio wrote:
>> When booting the GMU, the QMP mailbox should be pinged about some tunables
>> (e.g. adaptive clock distribution state). To achieve that, a reference to
>> it is necessary. Allow it and require it with A730.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/display/msm/gmu.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> index 20ddb89a4500..9e6c4e0ab071 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> @@ -64,6 +64,10 @@ properties:
>>    iommus:
>>      maxItems: 1
>>  
>> +  qcom,qmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the QMP mailbox
> 
> mailbox would suggest you should use mailbox properties.
That won't be a very strong argument at all, but the Linux mailbox
framework did not at all fit the JSON-like nature of this mbox and it
ended up being its own thing..

> Instead maybe
> "Always On Subsystem (AOSS)" or just use existing description. I assume
> it's exactly the same.
I don't think I quite get what you mean.

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
