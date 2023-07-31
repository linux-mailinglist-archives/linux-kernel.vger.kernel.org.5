Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F36768F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGaIEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjGaIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:03:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D11FF5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:02:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so40365951fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690790559; x=1691395359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MprwVZmNUV7a47mCTURUBSfMwGAKqbdXK1e5nVbgoxA=;
        b=VwNtgQDgYrVPUchMtfZ690ZpBvW/vnFfxiXWNzOXcd8hVJM9kZOa1NnYACjMR9ct7d
         KG8NvlOU70LrsblNBE/+X56kZsCUgkukAP97QYe6oAppHDHMFwL1L9TSgzp4CHTtXkJt
         hDjhWkoodM+dt2FAyHYlJHqAxwUfazFKD6spNoUA5C4v5+pdbWEftNUdD1YzkKzuzOzR
         6PgIieS07LJks8jfr0YMWpGHigMNoiRA6vmgJAg1YOICh2uSpIg1HShPDxY55rlCoZvR
         BaxDu8kO7ufs5ZhIcIufRxsMkHN4LiWvUDiEVfelP1RLzjRLsU+u2Jw01keIVRRLPXSg
         Mlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790559; x=1691395359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MprwVZmNUV7a47mCTURUBSfMwGAKqbdXK1e5nVbgoxA=;
        b=K7x/9u26VH34q7SA85yN37gadDRU36BOS1zt9Xzw048n1S5mbO7Mj71bZ+92zl8xPP
         ol0RpFEtSsKQ8a6cow09n9TurUsbaAQDnoXx9UK7e/mOEfzuSKcl/2YK/rAyxd10+/eL
         gevN4pTR6uaI6YA0hNfuUs1irJTLFcWLcOuEn/Oc/TtEyFJPDCn6phVCMu93qrFVlZAX
         1OZ8v+/pOeX3s/jx/ZEI0TbAeKUe6rOd8GcXrmIWAsohaXGfMJ2Hxufnw7YG9uJIJLgA
         ggJWHJJNfH3cLn8tYxXAzwvNGZXCKR1XRzRzJvbduQByJFRllw2362ouyMYrEEn7knQ3
         RyZA==
X-Gm-Message-State: ABy/qLbopzhUP+dg5HsWEZBxjcN+bB612NZVi+1M9LYa8M5q9GSoX864
        3KguIshkSO+kbOgUVc6du4vDoA==
X-Google-Smtp-Source: APBJJlGllSTwLHwrGgtsMnNsjbPWLnX9k2/UY2kzBkmdnksg2maL9QuCt0nuQECpBFBej1dpvYOMOg==
X-Received: by 2002:a2e:904e:0:b0:2b9:ec57:c330 with SMTP id n14-20020a2e904e000000b002b9ec57c330mr1167125ljg.7.1690790559168;
        Mon, 31 Jul 2023 01:02:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709063c0f00b009929ab17be0sm5799358ejg.162.2023.07.31.01.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:02:38 -0700 (PDT)
Message-ID: <dc327138-0fc2-0766-0d86-08977b07fb76@linaro.org>
Date:   Mon, 31 Jul 2023 10:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 5/8] dt-bindings: arm: qcom,ids: Adjust the position of
 QCOM_ID_QDU1010
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731061325.26431-1-quic_tengfan@quicinc.com>
 <20230731061325.26431-6-quic_tengfan@quicinc.com>
 <981a79ee-5258-eb76-020a-765f5f39866f@linaro.org>
 <53132580-53b6-06bc-8b48-51a3f56ab71d@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <53132580-53b6-06bc-8b48-51a3f56ab71d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 09:21, Tengfei Fan wrote:
> 
> 
> 在 7/31/2023 3:00 PM, Krzysztof Kozlowski 写道:
>> On 31/07/2023 08:13, Tengfei Fan wrote:
>>> Adjust the position of QCOM_ID_QDU1010, so that there is a coherent
>>> sequence of numbers.
>>>
>>> Change-Id: Id083e1ecc92c063c1a07a81c66dcb034020964b0
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>> warnings can be ignored, but the code here looks like it needs a fix.
>> Feel free to get in touch if the warning is not clear.
>>
> sure, will do this check if this patch still need.

I understand that resending this might not be needed, but just to
clarify: you must run checkpatch on all your patches before sending
them. This is the most basic step required before sending anything.

Best regards,
Krzysztof

