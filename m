Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5087DFA21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377235AbjKBSlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjKBSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:41:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5E4134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:41:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so18014081fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698950460; x=1699555260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEpZhe0N2sN6GVcRg3szCztdEpMXAkzbYdbkv3mYVKg=;
        b=ulnjtFJnhHlwKCyC1/AZ1zSE6jmTjNnGl+1gPQ9y5WwhoY2j3Zz9bYXPidm0rIx7QQ
         nW8jd00MIhV0SCLK5tPh33JCTPsPEgqkXjhZ/k+iAKRGweTzwac/BhJhrLKrXLcJnXqB
         AMekWuvy9ntZniv+v6b/i1k8kcwUQYbR6ri1CCeiqeTVlLoQWTJDVasEWqot/hEZVKzp
         Eh0OdoOqIm3YkU5E6efCiE2W5FNKctZZEiE/0nFPrBDUoiAhShEwLIZGubrQ2Ab7WVXX
         +Hd7GS+j688NSzCG6Quf2788tdHucq+L1mofbLXSx/z//aDwpgPTmKMzwj5iBWNMHI6E
         HiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698950460; x=1699555260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEpZhe0N2sN6GVcRg3szCztdEpMXAkzbYdbkv3mYVKg=;
        b=MiKUh1Rux/yobPooNXbG8irSVeya/PKu5DRqgCJp89FUYjTLhnkWxuzgx+Br1/vsFY
         lgQIj9JKAdyCyUSKeQRCs0tbN9d1fDcQ21bjZXSNT8zGZ+SOY+t/eDARlKkelLI5MBOl
         bsSJQ1p/wr2BakjC6Kl00JoZQOfdd2dKEAPfU6HDLImv6aXRXHCjUcP3jepZ3VGG9wev
         +Cy5MKQq8NvUqTVi7QvnN+fw4pQQsHxA1pe6MDVWs/qG/Sqj7KCxjfzZMd35Lvou2Qce
         YVzK0dL3wyfN34HVC5vTXLfIgvgos1Prdp1C7R/L1W19Xlhu3pNagy6fFYuxBFInkUiF
         QQTA==
X-Gm-Message-State: AOJu0YxP8K/gdAt5W2oRgSVVmTgTS7JUXc/7upSqqfqIyICO03C6SAnW
        iEkqME4vuGdmcF3whyFvKnIGXg==
X-Google-Smtp-Source: AGHT+IHOG6JY6QHe6uEhX0t0A0QtG2EyhAEZkQBZ47BXTPo2Tx8sm8ASqdDLXlJVbPtHx31RMFUn0w==
X-Received: by 2002:a05:651c:336:b0:2c5:15dc:ba99 with SMTP id b22-20020a05651c033600b002c515dcba99mr12946673ljp.51.1698950460025;
        Thu, 02 Nov 2023 11:41:00 -0700 (PDT)
Received: from [192.168.67.140] (92.40.204.37.threembb.co.uk. [92.40.204.37])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c2d4b00b00405c33a9a12sm1481939wmg.0.2023.11.02.11.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 11:40:59 -0700 (PDT)
Message-ID: <dbf4a48e-c808-4611-96b1-563ece1e451a@linaro.org>
Date:   Thu, 2 Nov 2023 18:40:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] dt-bindings: usb: qcom,dwc3: Add bindings to enable
 runtime
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     quic_wcheng@quicinc.com, linux-usb@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
 <20231017131851.8299-2-quic_kriskura@quicinc.com>
 <272a9764-1cae-4d86-88b1-00175de83333@linaro.org>
 <960101cc-78c0-49cf-ab62-90614eeb9ee2@quicinc.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <960101cc-78c0-49cf-ab62-90614eeb9ee2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

> Hi Caleb,
> 
>    There are two types of platforms, some use extcon and some use 
> role-switch to deliver vbus/id notifications. Extcon targets already 
> have this qscratch modifications present today in vbus and id handlers. 
> But for role-switch based targets we don't have any way to get this 
> notification to dwc3-qcom. In this implementation, I wanted to get those 
> notications from core to glue and for this we implenented vendor hooks.
> 
> The property added has been used to do two things:
> 
> 1. Register glue's vendor hooks to core driver
> 2. Do runtime_allow for glue (and by default for core as the dt is not 
> flattened)
> 
> In case of extcon, we don't want to register vendor hooks as 
> notifications are not necessary.

Could it just be enabled when role_switch is present then?
> 
> For xhci, we opted to enable runtime from userspace.

>>>         HS/FS/LS modes are supported.
>>>       type: boolean
>>> +  qcom,enable-rt:
>>> +    description:
>>> +      If present, register vendor hooks to facilitate runtime 
>>> suspend/resume
>>> +    type: boolean
>>
>> A Krzysztof pointed out, properties should define the hardware 
>> behaviour, not tot the implementation details. For this case the 
>> hardware isn't wired up to vbus, so maybe something like "qcom,no-vbus"?
>>> +
> 
> On all targets, vbus is not routed to hardware. This vbus toggle 
> indication is given to controller via qscratch only.
> 
> Regards,
> Krishna,

-- 
// Caleb (they/them)
