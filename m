Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2175D936
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjGVCwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGVCwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:52:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41935B3;
        Fri, 21 Jul 2023 19:52:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-768197bad1cso258298085a.1;
        Fri, 21 Jul 2023 19:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689994354; x=1690599154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUG04+YmfFxE15oDzUSXYZTpUikUCYUSbud9spAPUKE=;
        b=QJejqC/MF21jTryUqaR2+bZXjnaEvbpaKy6QMlAaPuq973fUT8j9oKAr4qhiiDItpj
         uKro3Z9Mzn+PvvRFW/8czGi44c13JWggwh6l4o1p35zHGGI/Ijh0wSegGHweqLkZ4Ax3
         1Fu5uP5WgADn2hER9EuwCejtMlJYvV1Q8NGtQpbiBmGeRmbkv8UC5ZRWmEahpYw4PUpi
         1h7l486SqUVufjbIDY2ZDBE2zSn5ItSDKTZLBZbGHuFDn7zFAADTSxxlRfhx00dGRhSi
         18/WMbJRcP/L11JFnroIQVDSuhfgTJTmzjxV86tpM/J+KZPQESVfp7xz/K6j3EXdgZfz
         0LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689994354; x=1690599154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUG04+YmfFxE15oDzUSXYZTpUikUCYUSbud9spAPUKE=;
        b=PtqooA1V60F1sEj+i1YLCBwrJuBYvRbYY2vLYHBRFYLD2M0CAfMnkkwVbxjvcX1LVF
         yCqPGvKKThmYuh0rXc3Ygkm5syPiKn3b674CUWmHyU8iVpN1myntzKw/bCUFsPAvHNMI
         uZT/MmUhxybKKY3igT+UgWlYxlswL8h8p5j09397ervEG0jzDA5SwShVS+FfYDEumNjn
         gkOsjaP+hhHi9LqmJMWBwOMqVaphdsLR8Olp6SHUFvwByX59ybH49G9M+W5Pw5RfKAs/
         H5wfmG9ky0sD6lS2dBaRGaxmSkoCcUs0JHt7LzC1H0mbVuUSu91ZOTTGu0BGZqvMl/v/
         7N4Q==
X-Gm-Message-State: ABy/qLYx1qYRlb9e/JdU+scu/Hjy6w9oih4DkFQIIoJAlGR7Gs2TPdXq
        Y8jnXMOhw3bMdYW9/8Imnf4=
X-Google-Smtp-Source: APBJJlFZg+i5rB5C4vliqzg095KXisFSeRMfMysADhQy5/P4UyCeJmD0fz0+zQvkU5Dat3Hl+wV0Vw==
X-Received: by 2002:a05:6214:122:b0:628:8185:bd6e with SMTP id w2-20020a056214012200b006288185bd6emr1770270qvs.5.1689994354354;
        Fri, 21 Jul 2023 19:52:34 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id o10-20020a0cf4ca000000b0063cbb29731dsm1750238qvm.66.2023.07.21.19.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 19:52:33 -0700 (PDT)
Message-ID: <b171db67-3a3a-577d-6fb9-cdc3be5f2ed4@gmail.com>
Date:   Fri, 21 Jul 2023 19:52:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6.1 000/223] 6.1.40-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230721160520.865493356@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 9:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.40 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
