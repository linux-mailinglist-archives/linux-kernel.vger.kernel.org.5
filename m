Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001A76CE1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHBNO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjHBNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:14:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071E1718
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:14:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so86441811fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690982062; x=1691586862;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHhseVvT/nCcvp+zpFG7HuUdAR0podhsq5OJkx5nqYM=;
        b=c02yXWO4khVJYJsJuNV2k2lSsgON+P7lCUVs9F90QDkARkX4bSVAXrsR2jKsWyL/9q
         sKFXALTezOlLtYfV7iglnPt3TWoyWyEdMt0dS9bwwXbVlrLUaLpV7PUXTulFVvlSH7iC
         vZoQ8WVC0neMxTSuhloLreFJLDFC/3wARV72+Hfgz4SivMsRsNWBKuZWTUFp8PToqkpu
         73Ug9z3kzL40vuiB0RtMs3PhVoBs8KDRFF206Co/4hfSeGXex/KVM5tB3Zw4tcXu9rIM
         T1dlohyQC8LnB3vk9zS7toSigW1+fMDitCV6+Zjarc0BKfpaXgqKU06Wo7jumfLCkP0I
         J3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982062; x=1691586862;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHhseVvT/nCcvp+zpFG7HuUdAR0podhsq5OJkx5nqYM=;
        b=K1heMFf7KIyVNoVjjkNJGFToAA3Wg4B478yNS4d5rTUzIqEfO/4aQ2Y2O7lbsbD8Kg
         68/tSixNane76gCT1pZ+Yws7Xutn7qMxCIdOo8PCnDy+cH9rxQJYCFMoIRhochRZMO3g
         eqOH09L3vI05TIxrUgWEFYcSJlo2kTRNFNIv9qTuAUiarzp3yAFld43VzqtNDyD2pZSk
         MAGePjcJSqdzRCpWIOYPmMZB4L1uA8p0WKS/CyfCaCMO7cbF27IAd59gvhWJUFa0eMbp
         uLEBpg5yyLoYUIPk/6JroRFBPNDje55oz/+SPLtGrHutamKsaxw+buw5op33SAdjcQeq
         196Q==
X-Gm-Message-State: ABy/qLaJPLR+57YGjEM7xq4SsisXdqeEIYSd52UTDkIqMfdFsf4s9KXU
        VQAR2VcIqM61+mTabpmw+XWnkA==
X-Google-Smtp-Source: APBJJlHsYb6Q3cIYABG0cK2/IR68Rdw9SZ6rXkoYBM9T4hGrInspVMXv8devrppoPiURI+JPpdDwbw==
X-Received: by 2002:a2e:99ca:0:b0:2b6:de52:357 with SMTP id l10-20020a2e99ca000000b002b6de520357mr4715072ljj.40.1690982061752;
        Wed, 02 Aug 2023 06:14:21 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id n6-20020a2e8786000000b002b97fe43238sm3594668lji.19.2023.08.02.06.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 06:14:21 -0700 (PDT)
Message-ID: <2e97b032-4ca5-e59c-c891-2ed9ca39d237@linaro.org>
Date:   Wed, 2 Aug 2023 15:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: qcom: Add PMIC pm7550ba dtsi
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1690970366-30982-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690970366-30982-4-git-send-email-quic_rohiagar@quicinc.com>
 <ce1af969-427a-3e4d-e85c-32d629755d9a@linaro.org>
 <bb374ec4-3dfa-42f1-dffb-fc8505625b73@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <bb374ec4-3dfa-42f1-dffb-fc8505625b73@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.08.2023 15:13, Rohit Agarwal wrote:
> 
> On 8/2/2023 6:12 PM, Konrad Dybcio wrote:
>> On 2.08.2023 11:59, Rohit Agarwal wrote:
>>> Add dtsi for PMIC pm7550ba found in Qualcomm platforms.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> ---
>> Subject: "PMIC pm7550ba" -> "pm7550ba PMIC"
>>
>> [...]
>>
>>> +
>>> +        pm7550ba_eusb2_repeater: phy@fd00 {
>>> +            compatible = "qcom,pm8550b-eusb2-repeater";
>> A new compatible should be introduced, so that it goes like this:
>>
>> compatible = "qcom,pm7550ba-eusb2-repeater", "qcom,pm8550b-eusb2-repeater";
> Just a doubt, Since the compatible can be same why we need to introduce a new compatible.
> Should every soc have a compatible string?
If it turns out that we need to add a quirk for PM7550BA 3 years down
the line, this approach lets us fix it for users that never updated
their device trees.

Konrad
