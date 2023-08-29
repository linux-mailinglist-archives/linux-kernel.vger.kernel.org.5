Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F50478BE86
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjH2Ge2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjH2Gdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:33:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662AC18D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:33:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso384472066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693290829; x=1693895629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDhQb575zZtGvgbOfQFrrWaedCmdLDvfbJC6bCOqzL4=;
        b=J2ELgl3JW4LZj5oV//vBliF4CbbxRVWalmDr0Go27VRwASK4dzI+OFFS16Zxl/nVWS
         DBqB3XoB9BxOyasGmh5zskqnETjIUFNGfP8DPZyftj1h9zQFAr5kURPP2M3kGbMBLVBh
         /DbxMsNzLRQ0BW+UaO7JtPLJFuWKeje2a59BXePvnvTKRh4fkj8F3FjbCZNijPlj3L52
         hxAcBSkjJdoJk4O/iL8n6oroxgyxoN2dWv2vS31KVaAxSdncUWN9Lr2Ffh20Mf6hQfYC
         uVk2WqPKu+pbDdGir5+PmfRKJcSZARoIrI3J5YyH+IeV7a/iPoye2B7o0wdyCrs9buw5
         y7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693290829; x=1693895629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDhQb575zZtGvgbOfQFrrWaedCmdLDvfbJC6bCOqzL4=;
        b=BPsqSpVthiPgLuyZd8M8f6iFNsDuYYrMx1dKy5c/8j4tCaHt31SMwwtrG17z1qVV8d
         C5pSV2cHzx561JILqwrZJVePXhELC4f/tNG27RROjwP5vVGWBBsS2Lv+Srzj/ZlMPocu
         jTRsuPah0VRv/Io2t5eMLOHAiML53sB0A9p2QGz4IZB8jRs22qFVxbHqmIcIlpcmpA+T
         oUi3m9h2YzI11dpON29BhhcyEy8EkT4jhU3cxVWd+1lsTjeCaICrrLt8Bv43jhV1xeGg
         LVYFW6+FWg2sRkRX8I3r7Zyzjo3PVKMN91nT1OtNJzsr5cnwfLTQ3Mh/5aQwSaevmo2U
         0g9w==
X-Gm-Message-State: AOJu0Yz/KZfi216QfBYGHTK+JoFMfcsgtQlIvrud4s1VM66fe1gjoQ7h
        XJhpKwH/YqaHWCAYKcqm7IKywQ==
X-Google-Smtp-Source: AGHT+IFHPz0zE7ngWnnXF45tsOJ+fqrjSB+4GSz7x61aYxsX2j+NOzq1b3GxVSMYNK+GA5Rf0HgTog==
X-Received: by 2002:a17:906:8a50:b0:9a1:fab3:ee3f with SMTP id gx16-20020a1709068a5000b009a1fab3ee3fmr11811275ejc.40.1693290828942;
        Mon, 28 Aug 2023 23:33:48 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906814600b00992a8a54f32sm5569794ejw.139.2023.08.28.23.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 23:33:48 -0700 (PDT)
Message-ID: <73655c17-5246-2c96-d415-6a30497966c3@linaro.org>
Date:   Tue, 29 Aug 2023 08:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 11/28] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, gregkh@linuxfoundation.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-12-quic_wcheng@quicinc.com>
 <20230311134008.GA20831-robh@kernel.org>
 <f7bd1ae7-fc38-0f29-546b-9ea4a323f42f@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f7bd1ae7-fc38-0f29-546b-9ea4a323f42f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 04:05, Wesley Cheng wrote:
> Hi Rob,
> 
> On 3/11/2023 5:40 AM, Rob Herring wrote:
>> On Wed, Mar 08, 2023 at 03:57:34PM -0800, Wesley Cheng wrote:
>>> Add a new definition for specifying how many XHCI secondary interrupters
>>> can be allocated.  XHCI in general can potentially support up to 1024
>>> interrupters, which some uses may want to limit depending on how many
>>> users utilize the interrupters.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index be36956af53b..4e2417191f93 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -359,6 +359,19 @@ properties:
>>>       items:
>>>         enum: [1, 4, 8, 16, 32, 64, 128, 256]
>>>   
>>> +  snps,num-hc-interrupters:
>>> +    description:
>>> +      Defines the maximum number of XHCI host controller interrupters that can
>>> +      be supported.  The XHCI host controller has support to allocate multiple
>>> +      event rings, which can be assigned to different clients/users.  The DWC3
>>> +      controller has a maximum of 8 interrupters.  If this is not defined then
>>> +      the value will be defaulted to 1.  This parameter is used only when
>>> +      operating in host mode.
>>
>> Is this an XHCI or DWC3 feature? The former should be added to the XHCI
>> binding.
>>
> 
> Sorry for the late response...message got routed to a folder I don't 
> frequently check...

That is quite unfortunate, to put our feedback somewhere deep and then
send new versions of patches thinking there is apparently no feedback.
Fix your email process, so our reviews are not ignored. If they are, we
obviously should ignore your patches.

> 
> This is a XHCI feature, but the DWC3 design is built in a way that DWC3 
> host initializes the XHCI device and populates the properties associated 
> to XHCI dev.

You speak about driver now, not bindings. If driver has limitations,
change it. Not really problem of bindings.


Best regards,
Krzysztof

