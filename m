Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF37B8DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbjJDTyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjJDTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:54:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4397A6;
        Wed,  4 Oct 2023 12:54:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c736b00639so1154615ad.2;
        Wed, 04 Oct 2023 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696449289; x=1697054089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ax4y6QJVKxvgErG0DcGbU2UbkVaUc5zLXMuWEhHo+wE=;
        b=DE0FnCQqpnOirZpdxiGaA/2XI57IOfG8VGKd6q++FcW782qJbDvohhvDpso63GoMCX
         ChrUR4EjG0FLxv5TEC0lTCbfLBZH0Sxd7RNw+/Tfujf70BKcwECTpZTQibOh4tUqK/LR
         cxJ5WwLC+Mdmq5cj4y+0UYqqHrjVM5mbpdCESuixtdrfU8QDyaclHys1twtxLdsxiPyk
         KvcT1YF6vMiJv60t8Ik0sLygRmrtIDqivwWnCCVv6pGPWvvI1On1NWVIJuZMONDkhKeg
         D1O/Mw49NkA6o5uNl/ZVdUupd0y6XoYQNtE0IWKFgPO/Elrwm8xwejvyZEDk6zNxB6Pz
         I5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696449289; x=1697054089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ax4y6QJVKxvgErG0DcGbU2UbkVaUc5zLXMuWEhHo+wE=;
        b=bNqz9iYDhEqo3Oye46Z8UmM7KXSY7a2BQ4oZYxfjmHec9jeNvfhl4TuVX3blF9Qs9K
         DjxGyVevTeTBUgQtoNtYgjNRjurAld0Ctaa4FQbkvSEDgjSpfyBc6ebMr6JTtebUhMBT
         C6dy1Fb9V3zk616XGciLBnFacQnaD8oIsj46S0VskHJFEGF0TQGEZZazZRs4OvEk6jDD
         P9Q9Q+3/hsZtls25TaaZHHV5bLlT2vUNpEbNBULLD/1pIuqlrnaYjimTiaozzXgN+Cg2
         pwafsEwdTTzUeLagRumVbFazlGR6etovNhbJ21uWiyQl9nDRz+Wn4bqXOcKVTAWKl1sm
         zRDQ==
X-Gm-Message-State: AOJu0Yw2h8vVYaGCF/4inR42TCQEYzzpi1GAt1tSXmAsLGFkO9w51gJV
        sZp1dzldiJJSPDdpOxbDnnM=
X-Google-Smtp-Source: AGHT+IFDGw20JsiHFnweDS0H9QrL7hlk239XyTciYlW5aXJgPwY9fechyBtZ4MubexABIoLuFfh92g==
X-Received: by 2002:a17:903:246:b0:1c0:b84d:3f73 with SMTP id j6-20020a170903024600b001c0b84d3f73mr3861334plh.53.1696449289213;
        Wed, 04 Oct 2023 12:54:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j4-20020a170902c3c400b001c5de42c185sm4108203plj.253.2023.10.04.12.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:54:40 -0700 (PDT)
Message-ID: <6f182be9-c7e0-4ed7-a1b0-a431f3906eff@gmail.com>
Date:   Wed, 4 Oct 2023 12:54:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231004175229.211487444@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 10:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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

