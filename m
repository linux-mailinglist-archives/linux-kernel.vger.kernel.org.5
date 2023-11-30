Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A07FEA36
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbjK3IIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbjK3IIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:08:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A7BC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:08:55 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00191363c1so85714466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701331734; x=1701936534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0TlxkSYiSYMLKfsE9cTgw+R2Akfbcusr1v9Z2l/iJ4=;
        b=Kuncds0MIb4kZRgIrgNFDFIbnTdl6KEkIxZlen50mtDCacYISIB93eyLOkYd0Kued/
         ij9HeqBlaIz5wlCrVreXHqpAS/gNWeKhitvm6evD1I9J0lHQpMsfBWHcffQw4AmxL4tX
         6OaNmDH8oFCgon0Hr814vsfEfkzpO3dzntpolOV80dmv3MUk3ZaPlMkXJRXOT2HNbBLB
         WbGGfwSbqo7PXop86OTmFLMh2L/TMqJK+uGAY3reMcfa8m4nJr62vTo8Y2Y0/kmSzUA9
         K67tnV+3UfBcHw1aG5CmNpsjNZEfhVaUHmUSeY13m7aH/sBKoNsYD43jzCSL1o68+4cG
         dr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331734; x=1701936534;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0TlxkSYiSYMLKfsE9cTgw+R2Akfbcusr1v9Z2l/iJ4=;
        b=Nao6HOvjZWfEMPo+V9ylvARqPhnqPSR6YSYcV7ohg0VjZVQtr1YOckAEbfTyyT4EX1
         HjicrMMUT3w9HRk9sAN+wkOkIYe+lX6NAu14Lwau7jfTxZp4s54WwTaTE4W/WPvUT6M4
         mocsqcUcpbBUPqtrg7rPuk6TJvlrSzQlP6UyVn9c59UhBJZCHXE1F7z6CG+3/GPlMVDH
         Z2nbjjKu9Lnddp1eN1Lyi9ftXQQYbG3pChJfWUUQGSimfnloNSJe2qTYIeuvn3Jp7zcl
         R8tchWSUiys8WpbDCHDtNlVwoJ07qCD6XhU++V3jTAQn2F67vQPVhvhdmIBwd+wjKbG3
         Q6VA==
X-Gm-Message-State: AOJu0Ywe/y9r4BtLPPSIECM2KS5Q6i+aRYfZHHZA3UzhflogzGgL3ZrD
        hA3LvyJQyuxPniW85yzyaeHvWQ==
X-Google-Smtp-Source: AGHT+IG+zp9WU4nYZCOlDoa3Hyb5JWPq/5DfQn+YAqpp+sYDM3FQo1RNPzUztNps4jWnW8T3l++tDA==
X-Received: by 2002:a17:907:1687:b0:a12:6a16:15c8 with SMTP id cx7-20020a170907168700b00a126a1615c8mr5820940ejd.6.1701331734352;
        Thu, 30 Nov 2023 00:08:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id oz11-20020a170906cd0b00b009fc990d9edbsm395410ejb.192.2023.11.30.00.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 00:08:53 -0800 (PST)
Message-ID: <ef315412-99c7-4179-9e96-80eaf2e25f26@linaro.org>
Date:   Thu, 30 Nov 2023 09:08:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
References: <20231122191335.3058-1-quic_kriskura@quicinc.com>
 <ZV9dYpTYRXn63tXe@hovoldconsulting.com>
 <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
 <ZWCpGdJRexnk98IN@hovoldconsulting.com>
 <004ddc69-1566-4de4-b260-0fca96a9395f@quicinc.com>
 <ZWW_FOAKp95Cf9vN@hovoldconsulting.com>
 <18965bb9-7afa-4892-8b71-981ba29d2cd4@quicinc.com>
 <ZWXHrvUDnF2dMk6r@hovoldconsulting.com>
 <6d7527bf-8c1a-49b5-a0cf-99a92098c971@quicinc.com>
 <c8a28c72-5c0a-4a67-a4c9-e46a5716cda4@linaro.org>
 <ZWcPZPX-eT-xHAOv@hovoldconsulting.com>
 <3abe4ebe-80fc-4214-b01e-50c25575f2b9@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3abe4ebe-80fc-4214-b01e-50c25575f2b9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 11:50, Krishna Kurapati PSSNV wrote:
> 
> 
> On 11/29/2023 3:46 PM, Johan Hovold wrote:
>> On Wed, Nov 29, 2023 at 10:28:25AM +0100, Krzysztof Kozlowski wrote:
>>> On 28/11/2023 12:32, Krishna Kurapati PSSNV wrote:
>>>>
>>>>>
>>>>> So back to my initial proposal, with a slight modification moving
>>>>> pwr_event first (e.g. as it is not a wakeup interrupt):
>>>>>
>>>>> qusb2-:
>>>>>
>>>>> 	- const: pwr_event
>>>>> 	- const: qusb2_phy
>>>>> 	- const: ss_phy_irq	(optional)
>>>>>
>>>>> qusb2:
>>>>>
>>>>> 	- const: pwr_event
>>>>> 	- const: hs_phy_irq
>>>>> 	- const: qusb2_phy
>>>>> 	- const: ss_phy_irq	(optional)
>>>>>
>>>>> femto-:
>>>>> 	- const: pwr_event
>>>>> 	- const: dp_hs_phy_irq
>>>>> 	- const: dm_hs_phy_irq
>>>>> 	- const: ss_phy_irq	(optional)
>>>>>
>>>>> femto:
>>>>> 	- const: pwr_event
>>>>> 	- const: hs_phy_irq
>>>>> 	- const: dp_hs_phy_irq
>>>>> 	- const: dm_hs_phy_irq
>>>>> 	- const: ss_phy_irq	(optional)
>>>
>>> I did not follow entire thread and I do not know whether you change the
>>> order in existing bindings, but just in case: the entries in existing
>>> bindings cannot change the order. That's a strict ABI requirement
>>> recently also discussed with Bjorn, because we want to have stable DTB
>>> for laptop platforms. If my comment is not relevant, then please ignore.
>>
>> Your comment is relevant, but I'm not sure I agree.
>>
>> The Qualcomm bindings are a complete mess of DT snippets copied from
>> vendor trees and which have not been sanitised properly before being
>> merged upstream (partly due to there not being any public documentation
>> available).
>>
>> This amounts to an unmaintainable mess which is reflected in the
>> binding schemas which similarly needs to encode every random order which
>> the SoC happened to use when being upstreamed. That makes the binding
>> documentation unreadable too, and the next time a new SoC is upstreamed
>> there is no clear hints of what the binding should look like, and we end
>> up with yet another permutation.
>>
>> As part of this exercise, we've also determined that some of the
>> devicetrees that are already upstream are incorrect as well as
>> incomplete.
>>
>> I really see no alternative to ripping of the plaster and cleaning this
>> up once and for all even if it "breaks" some imaginary OS which (unlike
>> Linux) relies on the current random order of these interrupts.
>>
>> [ If there were any real OSes actually relying on the order, then that
>> would be a different thing of course. ]
>>
> 
> Hi Krzysztof, Johan,
> 
>    We are modifying all the DT's in accordance to bindings as well. 
> Still it would be breaking ABI ?

Yes, how can you modify DTB stored in firmware on the customer board?

Best regards,
Krzysztof

