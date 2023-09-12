Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CCA79D856
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjILSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjILSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:06:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB701E59;
        Tue, 12 Sep 2023 11:06:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26d1e5f2c35so4878342a91.2;
        Tue, 12 Sep 2023 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694542004; x=1695146804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/FcdXt508wzlUPKZM2U2Z4krLmys9jD7gjAAQB1Fak=;
        b=qL9JMWzi2S/ofD95Uwc0vOLPsLrNmeskpB+yqAGzecfIR4ydFqOy58ztzD9YzAnn7h
         ZJ3McVbtYm+inL6V3ihq5anrudywpjf92J1lLDsrKL0zmO7OlBF4XrDbxqMxxNUnUVqA
         ErImQqbkhOZi2doKNEdNWrMP1EXV+nIk87liOmaekqKDJ330XYh3D6xiHE0TCywqNYFt
         70ENycCY2JkFyRne4oHRA6A4KyE2vk/n4J4tpVmsYuRDic17WcFJPvssGDC/PubN6otF
         R5kmT7fTHrz8wgFssm3m/TWeDyPvdfCwhiE7oDItxsIm8YwscOF9YtV09IAxr32+QwD2
         45vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542004; x=1695146804;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/FcdXt508wzlUPKZM2U2Z4krLmys9jD7gjAAQB1Fak=;
        b=HpcXAPoaeY9yfiRkjYBsJsWleeuJ3b3Np3fHCpD6wzjHAnJ8vHWC0wrnWoXHjlggSs
         OA+9aNtkNM/ISMCpFmwZikAXXosfNCBplAkutUHzqjGn0nJPKUHOCXsddkRVav1Pt/Qm
         cPPkWA6ztZ10m+8SULzlIJygJYxoJ6QLI+Wi3UNrX2QwQBGQ6s2qY0pVozdWci6zzpXi
         668xPfvnfFXu1VrhLImW5EIahVTV/EJeWzy6k155utJeA6WykiVW8UiYn4rHXJj7Bt9S
         HQiFCJX/80QDUPpRHJfCJV9Fy8IjbjuRlT4E7uJ8ErEeieeFVRqB5eyiK/oHYcGmizJB
         PCsg==
X-Gm-Message-State: AOJu0YwxMefWSm+xgWuNaOMfMXxT9EX7+ar+U0Ju0pvxw1x7dXjgLl2I
        +HSzaoRfgIcpNByCPG8VDV4=
X-Google-Smtp-Source: AGHT+IF1qy2cfIn54//x9+QFzFdq2dCQpP+A7JwFxYGlzyHdW63t3FsaKm0KYnTcxA7a0T1vP4p3GQ==
X-Received: by 2002:a17:90a:520c:b0:271:8d4d:d046 with SMTP id v12-20020a17090a520c00b002718d4dd046mr58739pjh.4.1694542004044;
        Tue, 12 Sep 2023 11:06:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l3-20020a17090a72c300b0025bdc3454c6sm9449911pjk.8.2023.09.12.11.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 11:06:43 -0700 (PDT)
Message-ID: <0903ba48-643b-7091-0ca3-e76b95c7e822@gmail.com>
Date:   Tue, 12 Sep 2023 11:06:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230911134650.286315610@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 6:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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

