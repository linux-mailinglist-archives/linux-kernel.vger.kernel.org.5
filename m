Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41967817F3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 09:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344083AbjHSHJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 03:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbjHSHJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 03:09:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CFF3C22
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:09:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c1f6f3884so206896866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692428945; x=1693033745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNZbeqSVhasfGUErtV5q61IvmoorlC+cVrGMEvE4cm0=;
        b=DC9Aovqc4ZYNUzbqRgn3hWorZIeZxG2o/E+MmADA2nbVL0KHnCUJyPeQXTXpuqA2Xz
         oZEWmSlNFfDCvxJZLQ+O/c47xTvamXrlEQKMQegL2MeFbNINIraW0cEG5/y92qSv1HCx
         dgVEAlTx1hXP/GJITC9Q6m6HUvGqrLejCtHJgvB+DQ2FLqXTuR1uH5pNK6i3XMGVUWqf
         LhHsECatVITe/9LtoFMCBXAiD2AxJ23fbjUPDzntkXEvwwVREhLS37XDW00Nl+Q/sqN2
         UX66eemUGqM3QKjn0kkuwcfofPAbb2y60SaL7B2Hpf26Dgrc62+JzRvDWunFMIqcxnvP
         lo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692428945; x=1693033745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNZbeqSVhasfGUErtV5q61IvmoorlC+cVrGMEvE4cm0=;
        b=l87cjHTyU0gbmxnv+5wOqWfO5+pj1MdHNtVnhE7eTXFMAN/ypWIIXwL32dNVkFQ4zz
         ZoCt60AH85cOAYszbdhGnnMvf4PK3N+V1Gc+Udc7sqdxCRV/Ac+wJ8a/DvjqH8q0uuwl
         CJF/dVaWUwP+4SkEv0EfciNaiiRjse08HtZp83mdTIbjbX+nJ4Km4IS+o/m7UY8la3tb
         h8ByTHX/eIwopt+bvnmBY/88fRSl2vtna8oHq3SC8xYvB1LWDIkhDI1iqn59+EPZf5uX
         /44EPtq7Puvm8QRMbEOSXCo5LEEfg4gUAi4i14N9sBoNSO3R8V1Ww8BTDIBOWxeR9T0X
         SxKQ==
X-Gm-Message-State: AOJu0YzvNFvfXxYYIxKFqUE+b0+aqO2BG5SnjVQaZHGYy2MbqbrA4uYs
        YH4LsUbPda1Vq+QAcVDHE/TYlxNjMHc9cpLc6vc=
X-Google-Smtp-Source: AGHT+IGqWVxgB6V8BKoeEAcFDjA1ZAfZLJm/2VnM41Up1zXYMnMwQUUXoTvaEt7h1dSKvcY9QNd5Hg==
X-Received: by 2002:a17:907:8194:b0:98e:2097:f23e with SMTP id iy20-20020a170907819400b0098e2097f23emr761355ejc.77.1692428945413;
        Sat, 19 Aug 2023 00:09:05 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id t23-20020a170906269700b00992b50fbbe9sm2206142ejc.90.2023.08.19.00.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 00:09:04 -0700 (PDT)
Message-ID: <f2be5c54-b98d-d4eb-2107-6364701edca9@linaro.org>
Date:   Sat, 19 Aug 2023 09:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: usb: Add binding for ti,tps25750
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
References: <20230817235212.441254-1-alkuor@gmail.com>
 <eba26f0e-40dd-3661-b089-bc34c9426000@linaro.org> <ZN+PzWuiLRsSVcmU@abdel>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZN+PzWuiLRsSVcmU@abdel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 17:35, Abdel Alkuor wrote:
> On Fri, Aug 18, 2023 at 11:31:35AM +0200, Krzysztof Kozlowski wrote:
>> Where is any user of it? DTS, driver or 3rd party upstream open-source
>> project?
>>
> Yes, for Geotab. We are working on bringing up a new BSP and we have tps25750
> which doesn't have a driver in Linux yet. We developed the driver but I thought
> I needed to get the dt-bindings accepted first before sending the patch for
> the driver.
> 
> Sorry, this is my first time contributing to Linux. Maybe this question
> was asked before but for some reason I couldn't find it.
> 
> What is usually the process? Should I upload the driver too?

Yes, please upload in one patchset, in following order:
1. This bindings patch
2. Driver patch


Best regards,
Krzysztof

