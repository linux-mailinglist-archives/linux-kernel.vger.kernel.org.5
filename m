Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7248767146
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjG1P6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbjG1P5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:57:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754DC4200
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:57:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992ca792065so315910166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690559869; x=1691164669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3k2wrLxfWSkDK/Y1m8f2Pt0Rfn4qiNug0qbBZtToG0=;
        b=byZzrObqM1awjhRH6ayU77OLhZUhdGlbuO5PvixRZZOczNwAGLCu6SNQS9aL83Gl1D
         LiSSiJQulyfppGS8zrC5ATucF710+dD+DWjZZbAMr8b6CmFCFpC7lLa2ei0dkZVCBNDr
         fDQRYCPK+u+p5yOpAocE+11ZybK0fhyt0pwJbQdjKq8cPhvUvZsS5+7AB6bJGVtPgKMO
         iQbGf2/+p+46gt7sUkRMkXiQZpCtK7Frxk9Q8MWYPM5EEKCT9eAmZWolF4PEsxRWQr1l
         thKCDhKCri1gFM9nPDwHNMzzgOEkQyIzgygmgamirCWcLiZo2VRoigzZNSAr5NE4jF/o
         nGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559869; x=1691164669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3k2wrLxfWSkDK/Y1m8f2Pt0Rfn4qiNug0qbBZtToG0=;
        b=QPFJ0hLSDQVw066NFDfTGYEdaeNjW2+s0J1Nj3Y+cI/8Aerz/Gjy3fN7F3EGXpzf8k
         35odq5hi8SWiJ57W24k1jDlgzRwGowdONLw2xF2jLBW0LeZPdRFji8V1y/EWdmB/Wmrt
         CBRMrazOP8ft9mbUv9uGTCDLkYxErsOKnoLD/sklXqj9mkr29LvMq3NvoziK5FS/CKTJ
         qPzTsFUgFAanKL9Sugo2UbuD0UEyP25eWX+/YDyzy4HlKp+GAbOfy4S3asR+AgClsYBQ
         2RV4N3nYOibp08zVHg6yBvfMG4nRZrqgZgmhqBw3ni47EAVryiSjzNsutjJoixG3yQrK
         3img==
X-Gm-Message-State: ABy/qLav0JGlllVSUTalawhUTlE2iTEomLOB9c4qwx+F05ZaRnFsBFd1
        ANhh2ikA3g1fYGq8XobbXcQKgQ==
X-Google-Smtp-Source: APBJJlHFwTIAeiAKV/aZGLjJnIMrwD7AUm86fYh7o74TwOqlcm7xVzwDHHCwwMay/wyIZqIHJo/OUg==
X-Received: by 2002:a17:906:8a45:b0:977:ecff:3367 with SMTP id gx5-20020a1709068a4500b00977ecff3367mr2317200ejc.40.1690559868653;
        Fri, 28 Jul 2023 08:57:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id pw3-20020a17090720a300b00987e2f84768sm2197937ejb.0.2023.07.28.08.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:57:48 -0700 (PDT)
Message-ID: <a2024453-e749-b659-52a0-83ded8bb5c38@linaro.org>
Date:   Fri, 28 Jul 2023 17:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add PCIe0 node
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com,
        "reviewer:ARM/QUALCOMM CHROMEBOOK SUPPORT" 
        <cros-qcom-dts-watchers@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <1690540760-20191-1-git-send-email-quic_krichai@quicinc.com>
 <17c2ba50-3b72-523c-d92b-1ecbf9be7450@linaro.org>
 <f3d5c72d-90d3-b091-f995-5ad0bf93ae1d@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f3d5c72d-90d3-b091-f995-5ad0bf93ae1d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 17:10, Krishna Chaitanya Chundru wrote:
> 
> On 7/28/2023 5:33 PM, Krzysztof Kozlowski wrote:
>> On 28/07/2023 12:39, Krishna chaitanya chundru wrote:
>>> Add PCIe dtsi node for PCIe0 controller on sc7280 platform.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>
>>> +		pcie0_phy: phy@1c06000 {
>>> +			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";
>>> +			reg = <0 0x01c06000 0 0x1c0>;
>>> +			#address-cells = <2>;
>>> +			#size-cells = <2>;
>>> +			ranges;
>>> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>>> +				 <&gcc GCC_PCIE_CLKREF_EN>,
>>> +				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>>> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
>>> +
>>> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>>> +			reset-names = "phy";
>>> +
>>> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>>> +			assigned-clock-rates = <100000000>;
>>> +
>>> +			status = "disabled";
>>> +
>>> +			pcie0_lane: phy@1c0e6200 {
>> Isn't this old-style of bindings? Wasn't there a change? On what tree
>> did you base it?

The work was here:
https://lore.kernel.org/all/20230324022514.1800382-5-dmitry.baryshkov@linaro.org/

But I don't remember the status.

> Let me rebase and send it again.

This anyway looks like wrong compatible. You used sm8250.


Best regards,
Krzysztof

