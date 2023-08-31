Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A563178F3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjHaUXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbjHaUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:23:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA3CFE;
        Thu, 31 Aug 2023 13:23:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf57366ccdso16460625ad.1;
        Thu, 31 Aug 2023 13:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693513396; x=1694118196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUNHbyKTSQS93UHBi8ExMlTCLzp4hfcMKt31LVSlu18=;
        b=V/qIRpfZUI39SK8XZeHCsPAP8fSgkkhjUPnvW9EVxj+N9zr0neq7ZsjoF/4IR2V71U
         oJoOlDQ8VX5VO/lmwdkDHZZGLCBrS5BUP2NviLJqHrkKMJ6WcPNJfzVroyXApoTPa1kd
         Lbfj55bgm0lTQXe2i/qTXT7crzu+yLc10I6Xcfml2FjrSfvb+UmUTfRKygusq2Dh1pyr
         jGla8OgpKcXfD/quWozUQ7vgx6kIbvfqjaolk9eOml/+OcwnqBe75YEozIzoNFfWc3C3
         7KCbafvOYBw5FIzR1VmohGfrF0BfvSIb5sb0xpwxjZBeii1Xist4ZdB773FQRW2SDxL4
         Vuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693513396; x=1694118196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUNHbyKTSQS93UHBi8ExMlTCLzp4hfcMKt31LVSlu18=;
        b=Xq35q5BziXxBHECFgU9gjiqUEbNgMR44vnartOs6OqLuqhXcXAqsLRiBLfh8OTYx/i
         PZwF9uCu99NfGXoPR6FQ63806oflJKtBKq1qGl6Ts2E3TklDdYCI21Frp8czbhaz+q1B
         7xrwLAeW+Y8whNVOvG9osuJrZQHiSCOo5+QtuBQv9RD3ZUse1FO8t2GCFDWTzZhy7bsl
         f6H/Pm16cN4Arr4UqQZ2eU4wgkPo4cEFm2qLxVJTrJwIqQgkEuUmlGu5PpWV5fwrvUAI
         Of1M+mAaDTAHdYyvod75CdP0f9aKyTNL632BWJAm4FmnyW5dSMigAvpOL7a5qMx1UbWE
         LvTg==
X-Gm-Message-State: AOJu0YxG/EaQ1OnIGoCN7ibsMSg/tReiwU6lt1g16IbiFwLVBkttjs5E
        3FUAgLSspRoz2MuyZwkce0A=
X-Google-Smtp-Source: AGHT+IGeiB0OTdQeE7+Q39Fwoi5mY5qweQfsfdYkffkwDWT73haMIPvpC5Bf5B2/h8gkW+Q2kLrqLg==
X-Received: by 2002:a17:90b:154:b0:26b:2d0f:56c6 with SMTP id em20-20020a17090b015400b0026b2d0f56c6mr701332pjb.18.1693513395704;
        Thu, 31 Aug 2023 13:23:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t2-20020a17090a024200b002717a368efasm3579134pje.12.2023.08.31.13.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 13:23:14 -0700 (PDT)
Message-ID: <447f5a2f-c4ec-8749-5136-0abd14920237@gmail.com>
Date:   Thu, 31 Aug 2023 13:22:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 00/11] 5.10.194-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230831110830.455765526@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230831110830.455765526@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 04:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.194 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.194-rc1.gz
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

