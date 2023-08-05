Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557D47711AC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjHETIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHETIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:08:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49209128
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 12:08:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so12629355e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691262518; x=1691867318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ci5g0L3lDWd1ad2I5/zlL521QTxiIlvqfwBSNYlhmm4=;
        b=isPu0U9HvnEnti01C5gZ605dboA1zdGghYeSHbU+qURewel+VxA8vdz+KyFpIwV5R4
         EDcdvy7us+eu6CxPGBEeM2K8Zll06tSQ2J4bn+fvsX3MtW3aDZUekGcfmZWTOamzGlLJ
         bhv6EyBF2NzKgC6QeLCydlZJLjYcWHU5LRQoRUCyBXcNEz6JjdPqUats00fr4EFxcG/Q
         lcO+dZEy1GA28aXrKudcK/Wz+Q8Aqd24+Ix6/crJoy0a+j8Fw6CuzxMYgl7FHi6yc2jd
         EvCvTIOI0Pq7bQVqZ1MYg0zdUvWahAJkcZD356ei92WJU0Y/9E8G5WQcfcac3BsODUIZ
         nv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691262518; x=1691867318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ci5g0L3lDWd1ad2I5/zlL521QTxiIlvqfwBSNYlhmm4=;
        b=bNYvOa/qlAM7JNUE6qh2x6P+wJiwuGQeDGRGyyivbU2pUuwm/MomnY6PxeqvAtd0Sa
         nPnI+OEwsl9aLB1AQ6H7GRd+MDMw27DcxcBxWWDADvHO/64BkPWp7DkI/c34hKnp+Tgd
         xQ0X0zyBu3zWkCuA5d8+J9kWSE3IScBIV2uyPmsvpA+W+6BLZsBkdcm3G9ZgtESye+Lf
         oP2lSDWz/2fDVnhbEPzh/VVaO5TGu/ozRkByMsmzFwn8zCg93nWl5tlekcCEa0Jflv8T
         krcE7TEEMLEmmVqxjhS4Bmf1DSScqpK8f9FnMU1Lh66Yd7Xh5t/JzR5lUS+RdbgGeBV+
         SlUg==
X-Gm-Message-State: AOJu0Yy8tfFjT3szfo4KrD96JeSfM8jOK9PIpOjo+yAhrzrYi0fE7hMu
        ztoz+3m7KYWhVbEidD68AqcBjg==
X-Google-Smtp-Source: AGHT+IGxR6lIQII7VnRB6Dnh3BPr2qdoP2ijfkvBwAnBE1qeXZ9OkTLEgGNFZbvuH4nuQC2KiUZv0A==
X-Received: by 2002:a05:600c:450:b0:3fc:62c:8275 with SMTP id s16-20020a05600c045000b003fc062c8275mr3405325wmb.35.1691262517660;
        Sat, 05 Aug 2023 12:08:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c218d00b003fe2bea77ccsm5705999wme.5.2023.08.05.12.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 12:08:37 -0700 (PDT)
Message-ID: <e2e7c830-07f4-a34e-6bf8-c9e8dc33bf57@linaro.org>
Date:   Sat, 5 Aug 2023 21:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Content-Language: en-US
To:     "Yu, Richard" <richard.yu@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-2-richard.yu@hpe.com>
 <9f1bd0f1-d93e-243a-4622-721319fd1235@linaro.org>
 <SJ0PR84MB20854B4A444283E31025FA398D0AA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SJ0PR84MB20854B4A444283E31025FA398D0AA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 20:07, Yu, Richard wrote:
> 
>>> +title: HPE GXP USB Virtual EHCI controller
> 
>> The word "virtual" in bindings pretty often raises questions, because we
>> describe usually real hardware, not virtual. Some explanation in
>> description would be useful.
> 
> Here we are working with virtual devices that are created and have no

Unfortunately I do not know what are virtual devices which do not exist
physically. I have serious doubts that they fit Devicetree purpose...

> physical presence. We have modeled our code off of ASPEED's VHUB
> implementation to comply with the implementation in OpenBMC.
> 
>>> + The HPE GXP USB Virtual EHCI Controller implements 1 set of USB EHCI
>>> + register and several sets of device and endpoint registers to support
>>> + the virtual EHCI's downstream USB devices.
>>> +
> 
> 
>> If this is EHCI controller, then I would expect here reference to usb-hcd.
> 
> We will remove references to EHCI in code and documentation. It has been
> modeled to following ASPEEDs approach as mentioned above.
> 
>>> + hpe,vehci-downstream-ports:
>>> + description: Number of downstream ports supported by the GXP
> 
> 
>> Why do you need this property in DT and what exactly does it represent?
>> You have one device - EHCI controller - and on some boards it is further
>> customized? Even though it is the same device?
> 
> That is correct. We can configure this VHUB Controller to have one to
> 8 virtual ports. This is similar to the aspeed virtual USB HUB
> "aspeed,vhub-downstream-ports" moving forward in the next patch
> we are going to use "hpe,vhub-downstream-ports"

Moving forward you need to address this lack of physical presence...
Aren't these different devices and you just forgot to customize the
compatible?

Best regards,
Krzysztof

