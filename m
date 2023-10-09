Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE7E7BEC3B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378145AbjJIVEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378204AbjJIVDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:03:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84021E9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:03:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so63368411fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696885427; x=1697490227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43JczQhR06svhP3+MFO67a4XDgSpc7xK7wWPqbVY3mc=;
        b=Tf09s6ZuTFQ61khnhibD7Law+sJmp194b8dKjNVEczJTXEhSz/iVrQ/og+vR7IueXD
         iPeRaN50OUwiiJwg3v5pn9mrFTc1IBPzFhe/41h9cogtoH64juBQPq7CPoMyd1ux+nfT
         TsvA3ttggXKCHyvvNk2XEnqpYC38TW8Jg0kOUB2zIw0sGUGwVUMnbMz/UohfBJQqT9Ua
         XwikSQjW3z7gF5C+sh5o18UHRX0BYYQRMSaXwMZybOf7wWaYhC8ejAYBrBm/BV5Pcgft
         15l42CY0jrN8qqG5NVelUakkdT0BdfXGJxcpjPvuaRv2qKoRXShg27SwaHAv43H2ZeXJ
         Sw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885427; x=1697490227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43JczQhR06svhP3+MFO67a4XDgSpc7xK7wWPqbVY3mc=;
        b=dWI5rNbxvNY9KgukMNUWaPcbiNrM+cAkffuC/6Mw3/irMdaA0eOStGl9Fl8/S8MeLw
         NowyaTpsP/BDac/aHY69ZycfB67aOkHtY2oGFbDi51O+YW6A+Jd72m7PsHkuUxnZFenu
         Sq4puORr6daCYOap8UTvvYZErw/spiSYTwmZoNPIfkV53GmpzYRbPjYeZGgoaxm2Xi7x
         Ad0wUv8vlFXGFQGIovkAKO8C68IgM2Ti0xexLGwrDZlwLRulKIRfTXYpFGhs7dxUL32r
         ZuDE9GfXsZD2rYIcMljiyWqBNXfJOdD9GkaPTUjQJOOE4sXhB5gXGT+xUhPiSjyFrQZh
         sVTQ==
X-Gm-Message-State: AOJu0YymkymKr+5Uoxqglcsx18J2E8YAFsUfh8jVStvM72MzOqdBy8/W
        HFUZPsNlW8RLkhoc/AIXH3nDig==
X-Google-Smtp-Source: AGHT+IFMY7QqUdgo8VEEaNfc3AJxOGVDc5LmcHQuYLgMIPjPJlsAadiflZalp6ZB8QmqLruGsgB5CQ==
X-Received: by 2002:a05:651c:104:b0:2c0:240:b564 with SMTP id a4-20020a05651c010400b002c00240b564mr13779157ljb.15.1696885427576;
        Mon, 09 Oct 2023 14:03:47 -0700 (PDT)
Received: from [172.30.204.90] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a19-20020a05651c011300b002bff365c7bfsm2155195ljb.35.2023.10.09.14.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:03:47 -0700 (PDT)
Message-ID: <0a039a5a-46c8-4f63-a9e4-fd5b197340ab@linaro.org>
Date:   Mon, 9 Oct 2023 23:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: Add new compatible for smc/hvc
 transport for SCMI
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
 <20231006164206.40710-2-quic_nkela@quicinc.com>
 <20231009144154.vfx5caqxtyezulxx@bogus>
 <b1c9ad08-5aad-ccbd-247c-a5b2aaa42b5b@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b1c9ad08-5aad-ccbd-247c-a5b2aaa42b5b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 16:52, Nikunj Kela wrote:
> 
> On 10/9/2023 7:41 AM, Sudeep Holla wrote:
>> On Fri, Oct 06, 2023 at 09:42:05AM -0700, Nikunj Kela wrote:
>>> Introduce compatible "qcom,scmi-smc" for SCMI smc/hvc transport 
>>> channel for
>>> Qualcomm virtual platforms.
>>>
>>> This compatible mandates populating an additional parameter 
>>> 'capability-id'
>>> from the last 8 bytes of the shmem channel.
>>>
>> While I am happy with the simplification here, I am also bit nervous how
>> long before Qualcomm abandons this. I hope this is adopted as is in all
>> internal and downstream code without any modifications and this is not
>> just a push for upstreaming some change to minimise delta with internal/
>> downstream code.
>>
>> -- 
>> Regards,
>> Sudeep
> 
> Qualcomm is using patch on all the virtual auto platforms using 
> shmem/doorbell as scmi channel. This is already being used without any 
> modifications in our downstream code. No delta for this patch series. 
> Thanks!
AFAICT Sudeep is looking for a solid guarantee that it will continue to 
be used as-is, on more than one platform and on more than one BSP version.

There have been cases where such firmware interfaces had silent ABI 
breaks (or were replaced altogether) between qc downstream branches and 
this would be unacceptable. Understandably, having a unified means of 
communication for *all* Qualcomm chips (i.e. not only auto) going 
forward would likely be expected..

Konrad
