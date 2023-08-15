Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9AD77C668
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjHODcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjHOD3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:29:30 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761891FD0;
        Mon, 14 Aug 2023 20:23:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-644e8aeb791so14124936d6.1;
        Mon, 14 Aug 2023 20:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692069828; x=1692674628;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TdSSMCQkYKXbWs7lLhu/IusMxnT2JccMO4bwVUpL//c=;
        b=IsHYDJpNsVGUrUdiU+s1FyhfbkjFASiK8a4/h89WvVDhVqzXRWHz2kT9yIFCvMHzVR
         +7Ir88Hc/6bkY4jcNSXtUitw55gHZtRspyQBX8LiluabDbLGYipht7G0ge0IPnJ+OFod
         LUzC9I6HKaINLzChHDhvZTS2BoT4SriSkV1/2VC3cU1qkxlKvxaNVeX7vYpiAYsD/S4d
         zv2fNiBFlDKDmuaCcHU60LZBiSO+DoU54buOwjRzSgeVYREfnIQHddWHywGxd+luTmN8
         Cg0Vm6NiBCWfsM3n5B36Q6KEK3zCpY6twZeQPFNjLx8M/jqmxq7Rz6tTOonMM48OjF4q
         17Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692069828; x=1692674628;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdSSMCQkYKXbWs7lLhu/IusMxnT2JccMO4bwVUpL//c=;
        b=dPBBuhYcTVbd4QLD8IlJkcMf0KCdz8PXfiLA29KZpkmJA4NzqBffZcGuoFEKwb6ucx
         mCzOcVVl6acuV+aRjil8n2bV5FdIKCMJRkey6qELiObj7K4Gf2OxWg/0kMH4sramg/qU
         641rdqBe4UoKJwemhxKS0n72XFoLVGrukcuseFNcN4fEB6CWJtlbbbb5a4jdxXa7XK7j
         dAAsNMgs2Dq1ElnP4/wywIc5vdHMq+ycDy/utyu5CEF+eHW+UieodMyDtOWWj0JSdO4K
         Zl/syDBepqtb++hxcUaOFgU/Vak2F2MO26ck+sJAP+f5AraWAPTMjSr5IEdnSo1W6/5p
         A0qg==
X-Gm-Message-State: AOJu0YwGwPrSVKOVnBuQj140dVxVBpN5XADXKc2+IPDVjHXN5tY4tYS2
        +KkwS02aIqxxyTGeNwNkcgfGg/9WzGcy9A==
X-Google-Smtp-Source: AGHT+IF0QkgNsmcp78aCqa8egeI0Kn1/DODZ0GI0qUhpkNdOWWV+26BFdryiE+MD2BP3mU7M7uef6A==
X-Received: by 2002:a0c:f00b:0:b0:62d:f170:f6b3 with SMTP id z11-20020a0cf00b000000b0062df170f6b3mr11831597qvk.19.1692069828529;
        Mon, 14 Aug 2023 20:23:48 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id z8-20020a0cda88000000b0063cf4d0d558sm1681770qvj.25.2023.08.14.20.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 20:23:48 -0700 (PDT)
Message-ID: <86601ba1-d89e-d4e6-5b16-437dc68adacf@gmail.com>
Date:   Mon, 14 Aug 2023 20:23:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.10 00/68] 5.10.191-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230813211708.149630011@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 14:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.191 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.191-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

