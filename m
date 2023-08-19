Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B107818DC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjHSKkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjHSKkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9D106AA3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 02:35:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-523d0fab783so2151736a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692437737; x=1693042537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXy3bc3W8hEI+d10Tnd1Q43Jc8SX1WBV0Tg2c/cXUNI=;
        b=GL9pfjsFCRAnfAYcBbZezhb/E8MaAs/kNZ8cVRiQrprHhooyTfujR34lE4GA2Hts57
         NkCEXlfWS/8BNFrePFUq5kT23ROVx6zaRCvhOLSzhdslgjJhDYadCecws486JYq3vwQH
         qL0jU+rzQQXrdsux5sSh0AWRVI+Bw6t/114J79E6mCZhNRonzso+sP+tQRwIpE+dLIly
         zinF80DUmCwSY5yygMLQwFcOm+fQhWIyO3eWGjAdnRi4R7LjlIrt2e53IO8YmOxDEFIf
         c85mLihAN02R652xLHm4yBn5AfB6H1kEC8Fv4IbyRqhu1Pucsq1p/Vn/ZRJ/hQgtZG3x
         B53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692437737; x=1693042537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXy3bc3W8hEI+d10Tnd1Q43Jc8SX1WBV0Tg2c/cXUNI=;
        b=ksHYdVwM+7e7zMseDSMRN3SliWnROIphoq51oKMbirrx+xLSftbU7zV55gczO118e5
         f2WRtlSujs0YpDdOLUtg12f9iusNw3dCqCHzIwtjxf3N5ffA0H95E2jkOVH1D/lMX2ZL
         tQjemY1ImKNSxYBdRMGBineoMqhTZU4phOpZGSQAdzGfrXHr+N7aUVw9gFRqryaIeSTx
         q33M+On+GD2NAgypEvhYsrqQl4zM6k5LlYnXRfbP771r0k9SyjE0geWXHPPWH4/B2IsM
         scZJaJ2KrBT2OVTyfWdKQ3zuEL5lclvdmgek1TDNe6/SwA9JGjvefDx8cz5QoU9wj0zG
         CsNA==
X-Gm-Message-State: AOJu0YzEWYu3tdu3esXI+xqnyi6wmFknAuFOvGlXM7WaI+WGOy5in6Dl
        NJJ7DJ+W5ylWcWgxKZx3g9V3Rg==
X-Google-Smtp-Source: AGHT+IHkoZRCadlwhyz7BaGiI6cguuY739O4FS480p+P7ndaptyPyw7BgT+jRx8SXjB47ckHVQXHtA==
X-Received: by 2002:a17:906:217:b0:993:fe68:569d with SMTP id 23-20020a170906021700b00993fe68569dmr1270933ejd.17.1692437737012;
        Sat, 19 Aug 2023 02:35:37 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id yy10-20020a170906dc0a00b0099d02ca4327sm2386605ejb.54.2023.08.19.02.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 02:35:36 -0700 (PDT)
Message-ID: <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
Date:   Sat, 19 Aug 2023 11:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
To:     Elson Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        rogerq@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 21:16, Elson Serrao wrote:
> 
> 
> On 8/15/2023 10:44 PM, Krzysztof Kozlowski wrote:
>> On 14/08/2023 20:50, Elson Roy Serrao wrote:
>>> This property allows dwc3 runtime suspend when bus suspend interrupt
>>> is received even with cable connected. This would allow the dwc3
>>> controller to enter low power mode during bus suspend scenario.
>>>
>>> This property would particularly benefit dwc3 IPs where hibernation is
>>> not enabled and the dwc3 low power mode entry/exit is handled by the
>>> glue driver. The assumption here is that the platform using this dt
>>> property is capable of detecting resume events to bring the controller
>>> out of suspend.
>>>
>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index a696f23730d3..e19a60d06d2b 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -403,6 +403,11 @@ properties:
>>>       description:
>>>         Enable USB remote wakeup.
>>>   
>>> +  snps,runtime-suspend-on-usb-suspend:
>>> +    description:
>>> +      If True then dwc3 runtime suspend is allowed during bus suspend
>>> +      case even with the USB cable connected.
>>
>> This was no tested... but anyway, this is no a DT property but OS
>> policy. There is no such thing as "runtime suspend" in the hardware,
>> because you describe one particular OS.
>>
>> Sorry, no a DT property, drop the change entirely.
>>
>>
> Hi Krzysztof
> 
> Sorry my local dt checker had some issue and it did not catch these 
> errors. I have rectified it now.
> 
> This dt property is mainly for skipping dwc3 controller halt when a USB 
> suspend interrupt is received with usb cable connected, so that we dont 
> trigger a DISCONNECT event. Perhaps a better name would reflect the true 
> usage of this?
> 
> Something like snps,skip-dwc3-halt-on-usb-suspend. dwc3 cores where 
> hibernation feature is not enabled/supported can use this property

So this is specific to DWC3 core, thus should be just implied by compatible.

Best regards,
Krzysztof

