Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678497F5999
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbjKWHuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:50:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19919D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:50:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso797517a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700725814; x=1701330614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIAjb98REr6rdhtsiSzATNTDYndhqLZwKGASgxrUl4s=;
        b=Nr5SIsnV4YGnGDpGuKGZUQErvQDfs+1y+s+Zh677WfzHR+Q7HkUxjN/T5XvDsI3WXm
         LvmqgBIGbPRd/7oC3FzyA0yQEeuXhVf9WEohADFC051yU8VMK2GZTc96sNYl71l/qyN4
         n8ZCZPqoQqhLxxA2QT8q225OsDWIw4b/rBmbPalCpm6iIN/Q2DpvAnbKcsAchym6hSqI
         9CgQp1gLVn7Sa1DLBPvZKUSISLmM+GCqFvGN30J9gC4Q25/eUteZGx0pMkoFoT3lo4L7
         Gqd38DILznFCeyKhnNu2Tu9LcKl+4Jy5AfJwfJZ9R7KZ4Fxg7EUuZIEFrVhtEJyST1RE
         doYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700725814; x=1701330614;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIAjb98REr6rdhtsiSzATNTDYndhqLZwKGASgxrUl4s=;
        b=DTFEKywvlrEfpomsre/Dr/sQrXvP8d8lHiJCfHM+aUKt4FafLwm4OdTq8mcJs+6H7B
         +WEBOBqEPLzlBRJPv0+5aAsAE/gMnugAW+VRXt6b2/w8GuIASp7Q1mVwlpKU2X7G84Bp
         2QmT6iF7MmcTmg4FyJKY8FL01rBARN+sjoea2T1dfCnNeTzScy0+aleEFwFEZNqgmFDO
         24E9+uv1FdVfqWY4LYvOZz77EqEhWwm2LBXCuVK5grU6l0CY9SipMN+M3J4pebFxkWcg
         NrAMIY5VNFaPS3nduaUtwd5IwH2WX305ikHMbpHWdAhDLkpSSfGHTELbRkqYdSzJgQNe
         N9Vw==
X-Gm-Message-State: AOJu0YxWyyguKyTaM9aMXUbXjHAFxmGVO8avYxtAtHCghA2pmCfG8jVS
        +UHzdBM/b3K2pv1LUPy4qicUDA==
X-Google-Smtp-Source: AGHT+IHZ9C/PdXjwZUm6CkTX/Ohh+d7rOCRL7PNbOGdfFDoAojkO7C+pXGLKVqUBJeygz0nrL0eqoA==
X-Received: by 2002:a17:906:28d:b0:a00:131c:bc3e with SMTP id 13-20020a170906028d00b00a00131cbc3emr3113517ejf.11.1700725814473;
        Wed, 22 Nov 2023 23:50:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id g10-20020a170906348a00b009fb1c3ce877sm432203ejb.76.2023.11.22.23.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 23:50:14 -0800 (PST)
Message-ID: <7f4d20fd-b975-47ab-8dfb-2a0eb3db04fc@linaro.org>
Date:   Thu, 23 Nov 2023 08:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        quic_wcheng@quicinc.com, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231122191335.3058-1-quic_kriskura@quicinc.com>
 <4c323ab5-579f-41f5-ab77-c087136e4058@linaro.org>
 <ab2952ea-1917-4b58-a0cf-64f3eba0b7c9@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ab2952ea-1917-4b58-a0cf-64f3eba0b7c9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 08:44, Krishna Kurapati PSSNV wrote:
> 
> 
> On 11/23/2023 1:11 PM, Krzysztof Kozlowski wrote:
>> On 22/11/2023 20:13, Krishna Kurapati wrote:
>>> The high speed related interrupts present on QC targets are as follows:
>>>
>>> dp/dm Irq's
>>> These IRQ's directly reflect changes on the DP/DM pads of the SoC. These
>>> are used as wakeup interrupts only on SoCs with non-QUSBb2 targets with
>>> exception of SDM670/SDM845/SM6350.
>>>
>>> qusb2_phy irq
>>> SoCs with QUSB2 PHY do not have separate DP/DM IRQs and expose only a
>>> single IRQ whose behavior can be modified by the QUSB2PHY_INTR_CTRL
>>> register. The required DPSE/DMSE configuration is done in
>>> QUSB2PHY_INTR_CTRL register of phy address space.
>>>
>>> hs_phy_irq
>>> This is completely different from the above two and is present on all
>>> targets with exception of a few IPQ ones. The interrupt is not enabled by
>>> default and its functionality is mutually exclusive of qusb2_phy on QUSB
>>> targets and DP/DM on femto phy targets.
>>>
>>> The DTs of several QUSB2 PHY based SoCs incorrectly define "hs_phy_irq"
>>> when they should have been "qusb2_phy_irq". On Femto phy targets, the
>>> "hs_phy_irq" mentioned is either the actual "hs_phy_irq" or "pwr_event",
>>> neither of which would never be triggered directly are non-functional
>>> currently. The implementation tries to clean up this issue by addressing
>>> the discrepencies involved and fixing the hs_phy_irq's in respective DT's.
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/usb/qcom,dwc3.yaml    | 125 ++++++++++--------
>>>   1 file changed, 69 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>>> index e889158ca205..4a46346e2ead 100644
>>> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>>> @@ -17,20 +17,25 @@ properties:
>>>             - qcom,ipq5018-dwc3
>>>             - qcom,ipq5332-dwc3
>>>             - qcom,ipq6018-dwc3
>>> +          - qcom,ipq6018-dwc3-sec
>>
>> I could not understand from commit msg why you are adding new compatible
>> and what it is supposed to fix.
>>
>> The entire diff is huge thus difficult to review. Why fixing hs_phy_irq
>> causes three new interrupts being added?
> 
> Some targets have two controllers where the second one is only HS 
> capable and doesn't have ss_phy_irq. In such cases to make it clear in 
> bindings, I added a suffix "-sec" and accordingly changed in DT as well. 
> Should've put this in commit text.

Where did you explain it in the commit msg? Why adding new compatibles
is squashed to this patch?

You need separate commit with its own justification. I am not sure if
calling things secondary and tertiary scales. Please describe all the
differences and come with some reason for the naming.


Best regards,
Krzysztof

