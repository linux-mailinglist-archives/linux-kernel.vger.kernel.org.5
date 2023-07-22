Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C301B75D91F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGVC2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVC2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:28:23 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CADED;
        Fri, 21 Jul 2023 19:28:22 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403a840dc64so20957631cf.1;
        Fri, 21 Jul 2023 19:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689992901; x=1690597701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7uGHFjTE84Kh/AyzNxtyl3g/Y2MUZcAKzPcw06Ai+M=;
        b=QxZkoQDdmHa6SXNUxzIdk+9+scbuRhTzOBKCROB9MHPQD6lCjRNyQ/rGbtffqx3drW
         bhP/mNyZCF0DS76vf+ISwIR7rOyQaCLqrn4b3k5bQs1c5izS8sXOzQuSpnmf+CiEKr+a
         EtV2jmn04j9jQxvIjto98OTxmzMpvRzvBPmu1sBk/PUtIQS8xt1XGThgzyEl5OkcgrbT
         ImAI1nqYJ98ubTt0+Z/ZiAtwwr4HOq4vXKTLUXXpHwJWSkupaHWpP8XGe+5pf6Zh4Anq
         pVyWe1cRuJdPhTO1et6MBIpWGSXtxEb+f+bHJrC4DTD68MfZ2MxBFEOIdPSaB6tpVy7o
         bCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689992901; x=1690597701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7uGHFjTE84Kh/AyzNxtyl3g/Y2MUZcAKzPcw06Ai+M=;
        b=MlAfQHzD3JoKS3+hXi2fHjWebUCPdLwcjmtmCyZJd7DjpbIwJUL4iRjnmrV/2YsHqF
         eyBjDgXj8FhG42n12RXzraTvut0ULk7pN6UF6/i+aLmgW1w/IQe0F2kE65E4aKOB8fl/
         zS0b8GPGnmgKylT+ucQqYbTtZ9JbFpFYaBnCO8LGyYHBBbTDoWNKG9uKksCFcmhG6Zz1
         vXzo5Wss4S6NdZ3U0frZF0Y/T/+5xNPHQHOVPitTY9kcqnv9JN1DMb3xRdCaAH/z/RCd
         Ci3Ytl+6Omfmvw04fg8x/pJc7KhvFBxbQb5kcgjN3AbLzggUCn4KjUmBb8lLfUJzUQM7
         75EQ==
X-Gm-Message-State: ABy/qLbe1eg71/82sbYruhmOx5pPKIqOhvMwjosdLKNRH8NSQfcmKGJz
        JdFRKdHJ6h5X77OX0NHDmLU=
X-Google-Smtp-Source: APBJJlHa+px1NVCBOQO/Vi5EAq5O0Lt591JqTG+T2NeKAUCGjsp362oGRgRiId8NMg9YDUBA6wWwlA==
X-Received: by 2002:a05:620a:d8b:b0:765:40da:4444 with SMTP id q11-20020a05620a0d8b00b0076540da4444mr1943221qkl.10.1689992901092;
        Fri, 21 Jul 2023 19:28:21 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id j3-20020a0cf503000000b006262de12a8csm1738616qvm.65.2023.07.21.19.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 19:28:20 -0700 (PDT)
Message-ID: <32fd768a-a11c-44e1-1b15-a4bbdbb54385@gmail.com>
Date:   Fri, 21 Jul 2023 19:28:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 000/532] 5.15.121-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230721160614.695323302@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 8:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.121 release.
> There are 532 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
