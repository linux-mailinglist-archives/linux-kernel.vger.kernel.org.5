Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97D7652CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjG0Lp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjG0LpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:45:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA25B2681
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:45:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98e39784a85so452965366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690458319; x=1691063119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qeXnvcAiq6YWv+BROwmiyjzVjwKIDX/fTfibW2U9Ng=;
        b=haj4JLRqU16kQ/pCAc2zXSfGD4y2xOyhQZRlT94PCb08V82hArXlO7r+VBURosiLYF
         hWxtoN1Q2Qr3zilvKIyJogZjp+ey0Wt9oMCeoZtE0Fq4avoYOoYh0Bey45uEA2+v0IHD
         akKnLl/QQ2Kur95MNKXJTRaVSNjTs+jxxPyhIIIjphYwTWqLm3fjnFBlFMWBsFnXxTd0
         OMVxkX/2AwCbwAq8mQTRKu3hmfYPuQVaZlmhOmT+9M/+Hd10CJb1ErjEQ8t3KsIXZTOM
         DhR9Yk8mZws/ifAa8/gJvYwhRaHEwayj51zlajXVhKLSoBof0i/RPiHRtZYZQB9e4huu
         s8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458319; x=1691063119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qeXnvcAiq6YWv+BROwmiyjzVjwKIDX/fTfibW2U9Ng=;
        b=Rb8aGKKkiLZneOfoLAo0SR+1Qd+H5Y90CavInpVg67dnrapRXYfYpL4150GKgy7vAC
         bnlkT0FocvH3Eiz6TZ/WbRdxCyX+jqFwA/Xzca1eFk/l8dwSVz0eA9/CvprZSwrbzDcz
         nBdz70TW/FiF3iM1aq4COyIoz92d5w3UbVZyJ3A4zx+9WnS0bi7QNjd7KuU8w2nbkLIO
         XSPQ6y/nV4uAfClKQyjxpiht8bkmmj4pjJgyYgpncvJvAZBQ2LsZ+nStjMTP+aZxLZIj
         kFjwbxABZvSVkG2XpQis5zTtc0wKbcC9vMfu88iabwyOUF6B+l7c5wzMrHlPYi1/ugED
         elJA==
X-Gm-Message-State: ABy/qLY1YzWqwqzMZmF/SkkL+0HOLEEQGAIw9Wa4C/njNgk+6A7i6zM+
        5Emeja0I4vqZ+1s5r1U+D/CFxw==
X-Google-Smtp-Source: APBJJlGkjcM0tXeGSbsXIHSEtxD4pxFRr5EaDSYdzWNrpPx1y6oDJ7i0CJP0zJjVwc+iwJNrOkN8LA==
X-Received: by 2002:a17:906:2d2:b0:989:450:e565 with SMTP id 18-20020a17090602d200b009890450e565mr2267093ejk.23.1690458319274;
        Thu, 27 Jul 2023 04:45:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id pv24-20020a170907209800b009920e9a3a73sm660346ejb.115.2023.07.27.04.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 04:45:18 -0700 (PDT)
Message-ID: <2edb92b8-a6a8-c115-757c-daccef6be5f0@linaro.org>
Date:   Thu, 27 Jul 2023 13:45:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] dt-bindings: qcom: Update RPMHPD entries for some SoCs
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     mathieu.poirier@linaro.org, mchehab@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_vgarodia@quicinc.com,
        konrad.dybcio@linaro.org, agross@kernel.org,
        freedreno@lists.freedesktop.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jonathan@marek.ca,
        conor+dt@kernel.org, robh+dt@kernel.org, airlied@gmail.com,
        linux-mmc@vger.kernel.org, quic_tdas@quicinc.com,
        stanimir.k.varbanov@gmail.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        mturquette@baylibre.com, dmitry.baryshkov@linaro.org,
        linux-remoteproc@vger.kernel.org, sean@poorly.run,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org, mani@kernel.org,
        linux-media@vger.kernel.org, sboyd@kernel.org,
        quic_abhinavk@quicinc.com, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, marijn.suijten@somainline.org,
        neil.armstrong@linaro.org, robdclark@gmail.com
References: <1690448953-23425-1-git-send-email-quic_rohiagar@quicinc.com>
 <169045659774.1058731.6391693092002547810.robh@kernel.org>
 <fa84ec4f-bdb9-dace-c56a-46174a9b47ee@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fa84ec4f-bdb9-dace-c56a-46174a9b47ee@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 13:19, Rohit Agarwal wrote:
> 
> On 7/27/2023 4:46 PM, Rob Herring wrote:
>> On Thu, 27 Jul 2023 14:39:13 +0530, Rohit Agarwal wrote:
>>> Update the RPMHPD references with new bindings defined in rpmhpd.h
>>> for Qualcomm SoCs SM8[2345]50.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml   | 4 ++--
>>>   Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml  | 4 ++--
>>>   Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml    | 4 ++--
>>>   Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml   | 4 ++--
>>>   Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml  | 4 ++--
>>>   Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml   | 4 ++--
>>>   Documentation/devicetree/bindings/clock/qcom,videocc.yaml         | 4 ++--
>>>   .../devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml          | 4 ++--
>>>   .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 8 ++++----
>>>   .../devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml          | 4 ++--
>>>   .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 6 +++---
>>>   .../devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml          | 4 ++--
>>>   .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 8 ++++----
>>>   .../devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml          | 4 ++--
>>>   .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 8 ++++----
>>>   Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml    | 4 ++--
>>>   Documentation/devicetree/bindings/mmc/sdhci-msm.yaml              | 4 ++--
>>>   Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml | 6 +++---
>>>   18 files changed, 44 insertions(+), 44 deletions(-)
>>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.example.dts:21:18: fatal error: dt-bindings/power/qcom,rpmhpd.h: No such file or directory
>>     21 |         #include <dt-bindings/power/qcom,rpmhpd.h>
>>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.example.dtb] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
>> make: *** [Makefile:234: __sub-make] Error 2
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1690448953-23425-1-git-send-email-quic_rohiagar@quicinc.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
> This should be ignored as the patch that creates the new header is 
> already applied.
> Please follow this series
> 
> https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/

Please mention the dependency in patch changelog ---, so it is obvious
for people applying it and also for the bot.

Best regards,
Krzysztof

