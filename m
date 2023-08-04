Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627F07709A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHDUWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHDUWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:22:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF824ED0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:22:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso4189351e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691180533; x=1691785333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKr2Hkt55qkSfnLkJbVoLwPS/UDdOuvLrWIlK7PEvtI=;
        b=WogOu13mS86v8vPpdIUYopFnPlOlx5nA2Cyc9XEM4P/dWjdCeywIzcYuiIr7SPXluG
         G8omvKO8SzHWM8+pK7gn8fL2Me1Mcp52Uwam9/12aoN3t/JKqcJjVIICPGyvD1T8zjse
         5wIUkf9GkTPVOF9LhQMGyIeF+wXx51sYIQ8x8/iFoZ6eHaEz+smNPDRhAbAzPVQnWe8e
         3z/R0hYpr/zecQk+qdFXEzF/SrV0oaLxiKQsL0vkkhjV3M+eL8zZATUbVEstkrl4KDFM
         Ic6sSMYOqLVDMHVTsGeSl0f291Oc6xrVAwTctjlq87QPVjoJ+5Lfk/IfxJB1wn7om3Sx
         K4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691180533; x=1691785333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKr2Hkt55qkSfnLkJbVoLwPS/UDdOuvLrWIlK7PEvtI=;
        b=PJzxssJfya/N/Su8IfG77z2J1uSPb+w4ZMYIIABF+a8PkS0Oxdw9zNoTdxnnRTuy8t
         PR0n1ME0z+1H0RUX7FD8NM1A5PIw1HncqiyX0/1Qe3otW+0vr6KbCo7bhNLQ7gS2Lub7
         4xssuuPYegeY4t5qBRnkiHNTH5ai8qNFP1+9a+L39626ldDqlkTppbBiXTkG5m1C+Auo
         GpUn42FeAb+4Bjx6GFbPqjmDaWfg1Flo0kZiThDt7CNanEKxJaxk8ncPaLhy+pKPHOTZ
         Bij8HuN66OEN725n/2zsi7Pi+pCGJoJ4CoYFEm/ZDYU3enEOVam4oBsiBwpXFSLJGSSs
         cFfA==
X-Gm-Message-State: AOJu0Yyb44ikztBIaqEq0fxXoiWTPwQVbIOXzJPEIdVNx/n/8FYZx87J
        xU2vqGV8B2a1tcjjN1FK6UsvtA==
X-Google-Smtp-Source: AGHT+IEt5wjIsM7XDltlaDgQUC29KGzo6KmQ6aqTHOTxoMeNi4W+2jQTeg9Cc30vRqnypJGj+/nGYw==
X-Received: by 2002:a19:9201:0:b0:4fd:f7b8:555 with SMTP id u1-20020a199201000000b004fdf7b80555mr2207879lfd.19.1691180533060;
        Fri, 04 Aug 2023 13:22:13 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id y12-20020ac255ac000000b004fa52552c7csm497785lfg.151.2023.08.04.13.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 13:22:12 -0700 (PDT)
Message-ID: <e68932e1-8365-4f52-90f5-a96f2ec0c1a6@linaro.org>
Date:   Fri, 4 Aug 2023 22:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v4-0-bae382dc0f92@linaro.org>
 <20230328-topic-msgram_mpm-v4-1-bae382dc0f92@linaro.org>
 <168968640959.915849.5129879096888517309.robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <168968640959.915849.5129879096888517309.robh@kernel.org>
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

On 18.07.2023 15:20, Rob Herring wrote:
> 
> On Tue, 18 Jul 2023 14:19:10 +0200, Konrad Dybcio wrote:
>> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
>> use 'reg' to point to the MPM's slice of Message RAM without cutting into
>> an already-defined RPM MSG RAM node used for GLINK and SMEM.
>>
>> Document passing the register space as a slice of SRAM through the
>> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/interrupt-controller/qcom,mpm.yaml    | 52 +++++++++++++++-------
>>  1 file changed, 35 insertions(+), 17 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dtb: /example-0/remoteproc-rpm: failed to match any schema with compatible: ['qcom,msm8998-rpm-proc', 'qcom,rpm-proc']

The missing schema is merged in -next via the qcom tree.. Could you give
this a review?

Konrad
