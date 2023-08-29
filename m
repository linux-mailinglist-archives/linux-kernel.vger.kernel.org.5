Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAF78CBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbjH2SIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbjH2SHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:07:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4EA1A3;
        Tue, 29 Aug 2023 11:07:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68becf931d0so3431493b3a.3;
        Tue, 29 Aug 2023 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693332466; x=1693937266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HHqHaW4KwaaV6z2LCLOETVk7sy6B6NzFH3inU6ye2zw=;
        b=Nja9BvFialiNZmk9WoYj9ghI8KB9gJs+9U/l75OclD9Z2NEWPm5g+1CP15VR50S7UR
         oTP8mlXmkzhzePB3/K6IbvI1ejLqeFsIQ9R7wWQT05BnKnFzRb0EZtekifppgoovawSU
         iZPz/7+fUvwR1JxZjil5desOSC/f16fSsQkk/EHiJQebq1VONBWT9rZVEtVMHzC7ccoS
         c0DwRPZ9CCRu9D8bwuHzccVAKe+SoxXEwu6Rs0X7Ko82/v1DpFqO92oZK3/NGcbEFyQa
         OVwOYWHv34oXYarbCzbZzlOg5dUcZFlwhWnbalk7doiGCaAU3z+8cinor8HTmdXnM/Ub
         nHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693332466; x=1693937266;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHqHaW4KwaaV6z2LCLOETVk7sy6B6NzFH3inU6ye2zw=;
        b=Hzu6i4RwVI8W0q/aVgrpSf10dCAxucR131DpGxgkQH4bwdrtO3+OG+taA/Qh6akwTZ
         GPgG0Gjy5FTc73EgAGGLf/UmkFKh7ZSQnJShOFpik4MXGHG50AHzMAmCR+gSlwRKLoOQ
         WpWCmuiqVbmz8NbR6u1UfJjQA3N6PUQK3HWpRd/qsetxttFySyxOu5jMUDYge5FqwKB4
         a9pvJ0pnXwliYqsR/49tObl9aCbFTxA+spTH3kuZEUPnLFnYjfCOO3jk9tUWZSc/d//f
         zjCCxUDXuOgObNgQH8a/h8fxxvyZ4QoVIZcVR9yEcELxxtQa/8jeOkC+qUnD8kZxLtTE
         rpxw==
X-Gm-Message-State: AOJu0YxzLEKiWOngIDBqhvdfzNY1csQ2O1NB+7fBNwgs+VSbxDjbxo3V
        wQMI+9MxiGGU/dFYGAGsuOU=
X-Google-Smtp-Source: AGHT+IH6MH7k4ug7I5ZRMawMDH0VR/q8VbMH6uQ19gZnP7/JRPEznb631iIMkAIcHs3g+SO57yK0lA==
X-Received: by 2002:a05:6a21:6d95:b0:13b:b4bb:8b18 with SMTP id wl21-20020a056a216d9500b0013bb4bb8b18mr86334pzb.1.1693332466360;
        Tue, 29 Aug 2023 11:07:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z37-20020a056a001da500b00686bef8e55csm1384388pfw.39.2023.08.29.11.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 11:07:45 -0700 (PDT)
Message-ID: <ecb75e57-438c-fb29-41dd-5921899ee743@gmail.com>
Date:   Tue, 29 Aug 2023 11:07:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230828101149.146126827@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.10.193 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.193-rc1.gz
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

