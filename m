Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF8763D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGZRSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGZRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:18:35 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085071739;
        Wed, 26 Jul 2023 10:18:35 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403ea0a50f7so52319651cf.1;
        Wed, 26 Jul 2023 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690391914; x=1690996714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FW1A4VNorTdwVBkVvQqGIBLGEHRe0ZX2gQnqvSur9/c=;
        b=NKUjlcvJA5BVtmIFl3QXvmfJxJ1rPk+F2BI2oIo1qsjwKF+OvugHwLzRaDWNa9cm2p
         qmGXHHowlNid7bfyc8gjSqrinUFgK3EgSw+QQCFvUNDqud7zBzz1svbSH+DVZz6u4WZN
         Dx4OvyY6EaV1b+wOfXfEKcyrnI1ANxG2e0bAROlvvwKV7NKjbnKzIcCgS//ihwtGyvGa
         ztBaovJrXPHFG/wwCrm+6rF+ead/0UX3OlnuD+ognZVVeWmfnC4/Yzf/9Ccn+rbBrt3i
         ziBZBx+ovPXHWWjrCb2d+wM3vkD2tDUoEq9XFn8i+8kkKswEQDAVkeFF/y0MphFCL4da
         HS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690391914; x=1690996714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW1A4VNorTdwVBkVvQqGIBLGEHRe0ZX2gQnqvSur9/c=;
        b=K4wADj445YCM4785hsY/cBAowXNtxJRz8oA/+WpQ6BXqMgKo1CyFPQ+M0Xd9resbrH
         Zckz06EuGaL8U6N2ePr5pgdlsfmVRV2odSlTaPgipbU/3lg2CgeMqCgHVt0nrso3nehY
         I1M3wr/1x3sgQzgABdCezt8XWTt52LSuM6tlGsUi7ROLLF//JAE2fUZnKNtePaYS8XBw
         bnqbUFphitzOURxis3duntOqP5hgmhaxtwHMUjDua3ktbIo6JmXOTEAyzBVPxZ5kqvFC
         fS9FAr6iDRPHsQRNBccMJlbst4H0XuZOznlpiFlGlz7lEeu/Fzz/uaUPfas8YMXq1NkE
         juTg==
X-Gm-Message-State: ABy/qLZTWpvhAZWurYwm9AadFzXWjNm5r92+YP1A61ZhRq/r0Tnx9DCy
        SlTUEm6+hfl1laCw1PpLgfQ=
X-Google-Smtp-Source: APBJJlE7Mg8n2QYpxhgc9RYoF2KdX5wG6cMQxbLCVpDdJaX/CJo0VeLnZrcefcS5vCX2OtOKBHC1Cw==
X-Received: by 2002:a05:622a:312:b0:403:a338:2c18 with SMTP id q18-20020a05622a031200b00403a3382c18mr2612625qtw.42.1690391914067;
        Wed, 26 Jul 2023 10:18:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bv22-20020a05622a0a1600b003f9e58afea6sm4907625qtb.12.2023.07.26.10.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 10:18:33 -0700 (PDT)
Message-ID: <2f2d416d-90bc-3e04-fa69-0726bfe01055@gmail.com>
Date:   Wed, 26 Jul 2023 10:18:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 000/508] 5.10.188-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230726045328.327600022@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230726045328.327600022@linuxfoundation.org>
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

On 7/25/23 21:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.188 release.
> There are 508 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Jul 2023 04:52:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.188-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

