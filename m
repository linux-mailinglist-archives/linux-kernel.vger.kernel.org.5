Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E676DB22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHBXAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjHBXA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:00:29 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560631702;
        Wed,  2 Aug 2023 16:00:28 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63d23473ed5so1954306d6.1;
        Wed, 02 Aug 2023 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691017227; x=1691622027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxADmvrlLWmDyCAfvF5yFmWfrqeRu+A61EMrjZsBdpU=;
        b=MCTvs2WU0T65ZORgtIgfJ87PCli+WTdroZQHVcG4PCHRDJaFXjywFGlYS9Btx4uBn4
         2IliSatuleFIQ6L6o+MPmzZtXLk/+8v1l0xJK9xmEmMyW1xO+fdznksEsfvUiyzCkKdA
         mb8A3A6Zddk9MVpou1oCuqs5DcgxO4Ol4iOWZdNglz9Gbx6r/Yy6FZoZ1zxQoio9aKe3
         XnFXeJVAH6Bu6aDgr1JwZ9s2cNN5r5Dy4uplFwA/ZSiuMU7aw2aH9NO1D/Koh0GZ3U4x
         2x0oP3Y5PT7sDh+qmorH0yuws2CQ2QQulz93ovGs2K7tJX/VHUzyxS2YLqHXhtMRBxB0
         lVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691017227; x=1691622027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxADmvrlLWmDyCAfvF5yFmWfrqeRu+A61EMrjZsBdpU=;
        b=R7ISd8BKeENQWESE83I7lo+1t6FwyQhmnfUuC4FVSDTpYAUSZiTnCBMtYzNZP2vqyk
         gWeXLqBBA92wCSMBDJAOpPNdHO0eb07jq0YkVHALj6JaIVIvc6eR2eltgIPz10Rq8ZdK
         Z7nLuNDTDh3rDHdD1LU7ui6nXdjEAjuXpGD+kVYTpeH2eWRQ/YsActh1i2A4JiZx3Pz+
         r3Ul3EX3hsXAWQPaPfW1m4BwSazXIAmNmaHU7nuual1Qk2/kcPq9Ai8oDuD1l36/KZyN
         FysoBbO9jx/ghuQy49veiJAMKenVmZYore+Q42ddX316Hf957KsYg8r+vJFPxQAuKdGZ
         K3Bg==
X-Gm-Message-State: ABy/qLbb6mMwFfK9mrIhR5Gsmfru1+/OCefz0c+jhwREJFfCjyCTfERf
        GHBVpluCmPjRLrQHYy6zGO0=
X-Google-Smtp-Source: APBJJlHK7nE7o0Ajw+MONwVK5MWQ4wAv41//AS/uvZj9o4BsInIdqPWTGQ0NHbYfN5uvF3OssOdDTQ==
X-Received: by 2002:a0c:de0e:0:b0:634:cdae:9931 with SMTP id t14-20020a0cde0e000000b00634cdae9931mr15395990qvk.0.1691017227366;
        Wed, 02 Aug 2023 16:00:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n16-20020a0ce550000000b0063d585225e0sm4275868qvm.61.2023.08.02.16.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 16:00:26 -0700 (PDT)
Message-ID: <671b5b2c-1913-3693-296a-844abf5852a2@gmail.com>
Date:   Wed, 2 Aug 2023 16:00:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/225] 6.1.43-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230802065510.869511253@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230802065510.869511253@linuxfoundation.org>
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

On 8/2/23 00:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc2.gz
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

