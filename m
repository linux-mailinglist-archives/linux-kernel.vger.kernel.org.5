Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1475A807501
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378353AbjLFQbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378023AbjLFQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:31:44 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88355D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:31:50 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b442912b8bso10665439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701880310; x=1702485110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDgo2Cq9agN60fB44yQGuaAdYgge0fbUUX+iicw+JS4=;
        b=EO0TCUu2k9ZPhpSFMOjxsSWGzqsjwVouTSHtmb6Yz8wYNGhFgV+HdyAaoa9+1peVMG
         kWnquusDmHUsGuoMhQ25Yw37BHgYQ5ghXIaz+3m+yu5rt7gQRUkXBT61sDiPdOa5Dj7s
         wU05ygZd4Qraojv/kKoV7WQZjfnuZLjsy2RdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880310; x=1702485110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDgo2Cq9agN60fB44yQGuaAdYgge0fbUUX+iicw+JS4=;
        b=h6OeTfEE5cF6Cm/2Xc2++HhyFdAj+X8AtJlluppeKuSt8oC8QeH+g5Cgd27/NDjFIW
         lc36KV6Xy1cx+DsoCcQPBBmhGnlXC9xpvvwFm26uvSPVQFz5FfrTQ7uXn+QpC7NvTc/m
         oHx1EauRh9U5Etaw8Mvq3dRzmEfDbwVMJ35WyMxTOL66lZn7Y0uhy3Vdb+OZCPUt9rda
         U1dNJBP4y8aF/pFvguYfm3PzI33NUnDIrmnSx6rVlUtY0yLGu1cCa6dzgdhM4DdCKI/+
         ApGVKRYY1KDa7sQMiZ1KI+9XOrBy2hn421I7LeLU/V4Endu68D67tMP4O2FKCiDqVj8F
         axgw==
X-Gm-Message-State: AOJu0YzGZ9gjnRN6+8FbHz7hWgmfAJpaUrahmduKke2Oj15fcz+EMAAZ
        vylqiC4B5VZsT38MPOiGtqsSDw==
X-Google-Smtp-Source: AGHT+IFBeELv64/d8AuOa3xLLsK3PGlt938fjaP7VdvXIOnh5ODloxlxDxRzn4vnwtsAKO4aT+uOtA==
X-Received: by 2002:a5e:c30a:0:b0:7b3:58c4:b894 with SMTP id a10-20020a5ec30a000000b007b358c4b894mr2839717iok.1.1701880309819;
        Wed, 06 Dec 2023 08:31:49 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d9807000000b007b3e07371bbsm3970203iol.19.2023.12.06.08.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:31:49 -0800 (PST)
Message-ID: <fa221062-03b4-46d7-8708-9d3ce49961dd@linuxfoundation.org>
Date:   Wed, 6 Dec 2023 09:31:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231205183249.651714114@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205183249.651714114@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled. Fails to boot up. Boot hangs during systemd init sequence.
I am debugging this and will update you.


thanks,
-- Shuah

