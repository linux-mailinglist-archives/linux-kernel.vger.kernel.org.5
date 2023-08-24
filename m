Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6578784C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbjHXS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHXS6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:58:15 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218E1BD1;
        Thu, 24 Aug 2023 11:58:13 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bd3317144fso150825a34.1;
        Thu, 24 Aug 2023 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692903493; x=1693508293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTx6IU2Ceazpc05DJ3qYtLFFrnEetHYitYmMRZqMriU=;
        b=WOLiJcE+SWGGX95VXh8H5Gr76E5LwURu/6NJSn5hiS9LCJOGs5VrS5QEi5bLxScIFd
         34lnY0cKM6IJd1QNEnC8gDaZsz1LkpI8F/e7jk+DeMBC7utnS1U2mHjU3vq3SlTWgqP5
         GrhBFTetM2eHXydSnonip/+IXf5G+ZaA3epaYiDZEUOmSihNzeE8BACiRaTvSD99gvex
         PLGJ126FYShxKGXA5FgdFOfjlwvnJIP4RhnDDwcNwgTzyZFlgOo/GgujQgPdDG0HDarh
         YSS4iJ/q6zH6qNzIAoSAcjLy639IE/p9vuKv4QCkzzKtIiGud1/J0SxNqE56+Drlvezt
         2wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692903493; x=1693508293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTx6IU2Ceazpc05DJ3qYtLFFrnEetHYitYmMRZqMriU=;
        b=ky5oxam+F9Aq8cZ4ZtENsRklq4tGhi+qatvGkizh6B6BG3FX5JRIr5Utz4hQlwcGAY
         r2vvTDn7wwN7O1aZagFUmYneue4g2I+kdAfWgh/1B7E7GdM4DZ/LdoX4nIHFeLyWiUF0
         eTWJ43pYAvAEepcghy1Ad9hMi31rUujbWLILJDaBoc07QfBZi+15O/37OEW0DrDMaYhX
         rVSF6BIzbxQSioUv5ot/34WjjlaBzypJF/myYwumhlaxKD3BKixONegb+b1I0u+lyfOJ
         7Pk3LSFOp4V1/XH7vlZtLNIpDkTDpqWh8+i4T3VHvweUpjJOYw7RkmuWTvIzuBOhTbAA
         JvTg==
X-Gm-Message-State: AOJu0Yyp48xJ6PKHIeqfWWD8RXNtd8OjfEMGCPr2SmoiX1n98TFutese
        incJIkRCfXI+sc5JBb8iY8s=
X-Google-Smtp-Source: AGHT+IGIdGYFpUdJfRknf/yomB3a+RSBgDVRGmkaCdT3LuYrH7cKx5fAD4wFRuW3ARgGvn7lLsDbbw==
X-Received: by 2002:a9d:63c1:0:b0:6bc:cace:c07 with SMTP id e1-20020a9d63c1000000b006bccace0c07mr3417604otl.18.1692903492877;
        Thu, 24 Aug 2023 11:58:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id jr16-20020a05622a801000b00407906a4c6fsm25855qtb.71.2023.08.24.11.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:58:12 -0700 (PDT)
Message-ID: <286fcd22-35a6-54f3-4abd-9bfb415defdb@gmail.com>
Date:   Thu, 24 Aug 2023 11:57:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230824170617.074557800@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 10:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.192-rc1.gz
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

