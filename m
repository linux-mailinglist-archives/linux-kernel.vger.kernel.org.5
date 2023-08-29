Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2E78CD23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjH2To2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjH2ToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:44:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB4139;
        Tue, 29 Aug 2023 12:44:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc3d94d40fso36967515ad.3;
        Tue, 29 Aug 2023 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693338262; x=1693943062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mToAGNYEJndzIg6op7Xj1XSTquaaHAfcvA8BaN3iBy0=;
        b=rb3xlOeBxfsjR0b6+YQuty/cbhGQ0vKK0PCwmhVsss/TK6jg9pSdpp8e6lIZKBF/Ua
         S7CL55VwFTam0N426ABM4yfE15nrTfH2neXwDhC1PTVtv+RWV+3yQQS7enFNb8sLgiTU
         AWDRI/hqqiDgI8ZW2Yq07lZe0KAw/XulEwPHP3R+/+Deswp4ZZxu3zLHm35fKBZH3IJw
         RBu3P2pzR/aRlTIGcyGTGTfMNjSXZ7y+jxA/2w3QXHPv2UtDhw4glnnFNu2XvNHA3tMU
         GnWPk3oFWaNmTFoQSKTtBx//sSkVxuFgHlTiPLh6mhzf5e+gABEfJvCsafN3+EsBnKjx
         UPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338262; x=1693943062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mToAGNYEJndzIg6op7Xj1XSTquaaHAfcvA8BaN3iBy0=;
        b=LOrIf5cf0cvEDTJ2AbacEUEq0rTygcjRw6m7XM/6ucCAJqq7AIbCEKYwjqOvi7g7Ql
         RO/qfUXI9Boc0qogVa8nT3rN36Li5EDCMB0zsxebIJRs+VYADhQ43GQCUqAFoO3vCdBe
         6o+oWoMDfmbxUX6eBAI5YWGnhsHCOyIzq6yM9prznoM2ZnZ8jmxUniFIYf/e/JZgWgyW
         CgfuFkKMaMEX1Onu78pVhicGWRKY4drtRr6PndjxE7SgYhsOPwgCTvtc/DKoXNu1raxX
         lHRV+BxwmU9h0RspPmqZK81rTRXJvWSSaRDRzl6GE9ZkAwREJEiB60YFVAQEtcCL+D2P
         JOZQ==
X-Gm-Message-State: AOJu0Yze2wZWjeLsg9tKAEXNa2k8/HCGi3cvGKInnsPxB1rznbji9s7E
        GGej8fBeACjCJtvy8mQfXeA=
X-Google-Smtp-Source: AGHT+IEuYiWzg0ugLovZhtJNHSU/a5jwe8SZ5NHNAbiCIDtyarZHLuEQB46PS7VQ/FctISB/7BBvVQ==
X-Received: by 2002:a17:902:e883:b0:1bc:422a:b9fd with SMTP id w3-20020a170902e88300b001bc422ab9fdmr159983plg.13.1693338262206;
        Tue, 29 Aug 2023 12:44:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ji18-20020a170903325200b001b9d8688956sm9769305plb.144.2023.08.29.12.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 12:44:21 -0700 (PDT)
Message-ID: <d58bf5ac-7b38-a5ec-ec54-0148e3bc80ca@gmail.com>
Date:   Tue, 29 Aug 2023 12:44:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/122] 6.1.50-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230828101156.480754469@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 03:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.50 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.50-rc1.gz
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

