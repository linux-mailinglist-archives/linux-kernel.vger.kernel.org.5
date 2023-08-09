Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A374776802
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjHITLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjHITLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E653212C;
        Wed,  9 Aug 2023 12:11:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40648d758f1so565391cf.0;
        Wed, 09 Aug 2023 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608292; x=1692213092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39V1XP/MDO5emu6081lH6KVDmQxsvOMhi6iEGD0/k0U=;
        b=gjFv26sMM1eHzEtxx2MXwogocNkgovOz8URBxYoYe27GmwXNajwtgSm+orytKW12G1
         iISROCzHtKwuO8/dJMET4rnSkW/br8jXA2tigNpLSk8jr1sbD5ZcKT1uvIOAJL8a0dYf
         ZcXa9mrTBECaoh9GN4g6wxHAFGEImOCPfK6fyiOZ8pEDxUPLC87+FVFutkIVCgSPCmcH
         UBN6vqmqCRGM1HoDLT1pAnJ3ttlFvn+8wQadKZJu2LzO4p/SwT0jPNG/sxbvkYviqgmP
         2M7BMKBACmbL4CB0olPxXNTysUWXUOlbjxPL2F0OkTei02SBNKeUlVDD3Dj2T1Hd9bP4
         FQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608292; x=1692213092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39V1XP/MDO5emu6081lH6KVDmQxsvOMhi6iEGD0/k0U=;
        b=haO37o1mp6d2f3WusVDeFW379GiPqEPl1AeIpbz0MgKpkPBFDmzL/GwW00nk5ibFNO
         ijIFAsH84q9ONUEOWw07Wfg1Ybj4uaTY+ut4wPPxM8dSCceHmdyhz5NGEzSXfUGQYu0+
         dihhiv4UFYrrtiw7tOh1klQM2udAna/5LDsmezVPsnneDW1WEz3gEazeM5R+tpGHEBE/
         x1FDtZqdCNXAFzMJzHfpzH78RMZt8ib4sP9KY7fTNhMU0WC+niaSFNK5/Gs7YPNg6OP+
         +pz1FlqA3SUW9qf2hGBOCYcbhMYMSi/JARhmh1hEl45Tvc1khnW+ghXZy+PndZSMf80n
         Bmuw==
X-Gm-Message-State: AOJu0YwSpg/8wsisEZMq688mr7ny5nRKK4R3sckF/5dzczgFOqSW3GnH
        kjHRkPJlG0w1V95VUs3ff2s=
X-Google-Smtp-Source: AGHT+IEoDHHTd4iwD5s8iqaRVMVdpuvTq6P/qKBXPGbYljLoS6mP0Z9g307sIC3SkJPsJckDQW1L2g==
X-Received: by 2002:a05:622a:5ce:b0:40f:dc70:fde1 with SMTP id d14-20020a05622a05ce00b0040fdc70fde1mr334170qtb.18.1691608292122;
        Wed, 09 Aug 2023 12:11:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z23-20020ac84317000000b004100c132990sm2538301qtm.44.2023.08.09.12.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 12:11:31 -0700 (PDT)
Message-ID: <a7457613-7e46-bd41-a825-377fb2266740@gmail.com>
Date:   Wed, 9 Aug 2023 12:11:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 000/201] 5.10.190-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230809103643.799166053@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 03:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.190 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.190-rc1.gz
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

