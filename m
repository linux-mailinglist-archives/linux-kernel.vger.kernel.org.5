Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB17BC333
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjJGACC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjJGAB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:01:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6862FC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 17:01:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c1854bebf5so32443861fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 17:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696636913; x=1697241713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxBb/fEacQHB9wWPR/CpHe2sp5nl5oUFXbr6032DRc0=;
        b=E0Y7ENeUyh3G4UF0x2h0Ge0U7B3KpdAa29nXhHlXAYzuEiKbsrmvQjssXSEIYWrOEB
         p7OfiIue2tdmhWFOk8PdHX+FtnyiEAzfSDVUnFwk3me8kCZt6neaQX5gD12/aQT7Gna1
         Z5cGVvMGUlz5VZFkYyTBhGAQCe5i8a5EPEIYVgmg2ggtUmIWukHseL/S+TD3DeJxp+WT
         DZk3movrxL0Mh0O2EbCDZcFwrZnd8vX4i4oj22yqWhrq0GUbvpUJnP5i/KB917fXzywk
         65q7jJaKGxB5H53XV1bGvOYMt2WukjIp5WVk+KbMVSlkAaGQDvioF2n6M0TXlv+rQNDF
         USRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696636913; x=1697241713;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxBb/fEacQHB9wWPR/CpHe2sp5nl5oUFXbr6032DRc0=;
        b=rK4RdZSMPKP/9p+68F8fd4pf3sxFgZ6xA3xHAyQd8cCjDF2e1S8LT9r8yygnJUPLni
         k1LTBf9c1lW1QizILodYzY7kPEf6Ur/arcXznsJWCf8T2gNu3KSABGZjOZqIjah4r985
         4Qml21jW7ztXAER0VgOn8gdpMHiilJJAt+S082z3cPL3U+P8f2K+qzP+Qyo7fW3JG1oR
         gCKUdZknN+99wSHH21G244jWq/gExttExxNfR4gTUetDVGlGit0sSQp4Fx/UTuVxlz2R
         R/3hzznfWOunTif/K5I1qArO75Jr78n4R/LPSE7/CoofRbAdWoNyjtP+ZOxbgAbP22Cm
         b8rg==
X-Gm-Message-State: AOJu0Yxpx17mwiSUJ+yGFLjiNNN7XcJkE3+k1JMkv3MhQl8iTaVM45dH
        ykaGKJvhevbyHDIwcvcCduqxzg==
X-Google-Smtp-Source: AGHT+IHAEf2yoq/ewBVbR7rd/U7LE53ZFo8um+Ru4U3sr/d4iwC2DVJ6OZ5Ld2siYgTEFcBVVOV+Kg==
X-Received: by 2002:a05:6512:3256:b0:4fd:c715:5667 with SMTP id c22-20020a056512325600b004fdc7155667mr6889212lfr.20.1696636913647;
        Fri, 06 Oct 2023 17:01:53 -0700 (PDT)
Received: from [192.168.200.173] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id r3-20020a056512102300b005009c4ba3f0sm480526lfr.72.2023.10.06.17.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 17:01:53 -0700 (PDT)
Message-ID: <1d6f2ea9-d2bf-472d-98eb-1b711211ab59@linaro.org>
Date:   Sat, 7 Oct 2023 02:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V14 3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd
 support for IPQ6018
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, thierry.reding@gmail.com,
        ndesaulniers@google.com, trix@redhat.com, baruch@tkos.co.il,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     linux-pwm@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        nathan@kernel.org
References: <20231005033053.2626465-1-quic_devipriy@quicinc.com>
 <20231005033053.2626465-4-quic_devipriy@quicinc.com>
 <cfbc4805-c2e8-4dee-92bc-14d805dc2320@linaro.org>
 <cc5fef7a-d4d1-d725-36a5-86183bacc5a0@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <cc5fef7a-d4d1-d725-36a5-86183bacc5a0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.10.2023 09:36, Devi Priya wrote:
> 
> 
> On 10/5/2023 1:04 PM, Krzysztof Kozlowski wrote:
>> On 05/10/2023 05:30, Devi Priya wrote:
>>> Update the binding to include pwm as the child node to TCSR block and
>>> add simple-mfd support for IPQ6018.
>>>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>
>> Why did you send it twice? It's just brings confusion...
> 
> Sorry, kindly ignore. As the patches were not delivered to the list,
> tried sending it again.
In such cases, you should include RESEND in the subjects, like
this:

[RESEND PATCH v6 17/17] media: qcom: camss: Comment CSID dt_id field

Konrad
