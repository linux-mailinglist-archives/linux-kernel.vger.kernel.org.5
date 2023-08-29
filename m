Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35AB78CC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbjH2Sw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbjH2SwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:52:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84757C5;
        Tue, 29 Aug 2023 11:52:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26d0d376ec7so3071783a91.2;
        Tue, 29 Aug 2023 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693335138; x=1693939938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l704Aik3201dAT3xaPekHycqSJkh+bdmlwzdqElcllM=;
        b=TeCZl/ajKA0PtVlbIja0thVpGwSQSUxnDDaadbdmC0Wg6892DefHZTi7sFgfIJoU0r
         RoMiAIfXhL9FnIaKkQZnJmLpHn6coTdNQEOu7faCUqPrkEUvI4EY/XujQvqLaxcaekJU
         Yc5IuBe8QgHPIPsySfM1G2aNnxk+OjhfJXnRNBlB014hrOoxuaEj9FfuVRnQBJ27j4R7
         USUJPDFfLWZSPqOhcRu6qjwNKxk+mYiu+J3ytt9M71WZ6GGeqhwJMeGmX/S2N+/afNms
         IbNC6dgxRrvWSyjAgwdO8oMb8hip/tu4IqQuKJeTTtwcfgHhtf2lMwX1pwwTx7AxH7fF
         gDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335138; x=1693939938;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l704Aik3201dAT3xaPekHycqSJkh+bdmlwzdqElcllM=;
        b=LCxCf7BnRBn/68Et+GRhfSC0xyzrq0y/4ohIhTG8hmZNdEctG71+eHNu+KzWYNBTG8
         5x1urzVs9kUgj3W1IX+W1NRAla8TUJaYnBv9w9At224uTO6aCTrwoBNnvVFyJTwwP9Eq
         BLiwyX/HoG4oz28YmQVX61YbeL+xwad47/hseawi0FlxvNG68euBtJknvuUAIZjwG+0u
         qG/sMgDWHut7T1Tw5E8Ydl5Y5SxC7yOsPBP20b8eHfX3RFN/SsmWV2H/tdgB8heGW36R
         qK+Qgv8ltAObiqSNrsd+Rw7CTJt1qc2eL1yBrYdcrlIHBZnBNXiEmc8qZbBOqsNzzQtJ
         gO8Q==
X-Gm-Message-State: AOJu0YzwOQsaawroaI5SpXIi9YGtmpq++YEArm/GAaJU7kmRYYqG2qXO
        juqHaJyPZzL1vS09q7Kur2E=
X-Google-Smtp-Source: AGHT+IFOQSJnZ5nO0IQjbJcAlfqk6huWA2MWRBZgkY4FkaEig+/fpIgF/euiU+uxX48VIJ93YI1uNg==
X-Received: by 2002:a17:90b:ed4:b0:26b:e2b:6c8d with SMTP id gz20-20020a17090b0ed400b0026b0e2b6c8dmr41893pjb.41.1693335137829;
        Tue, 29 Aug 2023 11:52:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j16-20020a17090a061000b002676e961261sm1921129pjj.1.2023.08.29.11.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 11:52:17 -0700 (PDT)
Message-ID: <be80528e-ce50-ce41-bf11-519f71dad2be@gmail.com>
Date:   Tue, 29 Aug 2023 11:52:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230828101150.163430842@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 03:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.129-rc1.gz
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

