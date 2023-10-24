Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2382E7D56DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJXPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJXPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:46:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA288DE;
        Tue, 24 Oct 2023 08:46:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so3627581b3a.1;
        Tue, 24 Oct 2023 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698162383; x=1698767183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=broF79zHCDHtcT0lMzk4mTNTLoYN8J3GX3kjH8mcCUM=;
        b=MSoN6t8TObG51diAn+H9kKszjtu2NAxqlEBFHlrs3oR7CPbYbaL9GMhH5SV2jkz5Dx
         Y3fzLb71Ua31y5VOtA2MjMZ8NmG3iY92+aJS8L32clxf0yjq1KzFxqvkIit7KWP+bCuG
         iTpy7CMcW0zj2pMOA6Gx6c/76IOrtNB97RXPxOMC0ZsLgQ9ca8Zc0zFiQJgF/S+pOGEt
         Sogfa2BKEfzjOnZ4zfO3UDkymwUHlptAtHuV45FnWdcmUUCm36Z0XVdIGCnZIRnNaLRa
         FJVOZ0JZ7g+1Q+QWnBTvTkPeQutmDiM3K8gadeRSO6MDXA7R5ALUG2OCjtR/k968va9Q
         Qajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698162383; x=1698767183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=broF79zHCDHtcT0lMzk4mTNTLoYN8J3GX3kjH8mcCUM=;
        b=NduAV1PeywPLR2duyu+948a8kST1fJ0Fr9GVt/RIm4MQ7BS6n/aX9soTTOg6FXclYM
         eFXNx311ZEHibKq7rtK8+/n95n7jl1WAlfvcdJ0rBSHwQnckpvxPvdkA/+7vUzETA5yz
         4QRLN8RgVhH8viIc21GMfgMklUQgIj3DaPlyQqRqol4fRFID36UoXRXfwkBGCNZRLtZN
         Rz2FHaDwyoGDShxPlMjEhpBz6s4VsxRyjFkBMiQs7cFePBILLzigf32V6Lrb5GJp/N6W
         AmmvdH3YVkV/sG6AFXohEUtqQOFjqYaI9i03XYzqsE/dAz9up2vuZiYAKEenupTS+fTD
         2XdA==
X-Gm-Message-State: AOJu0YxymVZdqJgrhI4nylF3Gesff+DmW+fPvmgU8kY4RwMU2W//qJDu
        fQF6Q9xObOee6x5BeCgklF4=
X-Google-Smtp-Source: AGHT+IEOtVboZSjZpVV9kZKORPcgmgBeOBXfWSWLkeVvGDprv0+eboKjsKz1pxeoTGPqG3Dau9h9vw==
X-Received: by 2002:a05:6a21:7742:b0:17d:9da4:5eb3 with SMTP id bc2-20020a056a21774200b0017d9da45eb3mr2894397pzc.56.1698162383021;
        Tue, 24 Oct 2023 08:46:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j11-20020a63cf0b000000b005afdd58bab2sm7398084pgg.30.2023.10.24.08.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:46:22 -0700 (PDT)
Message-ID: <42a345ec-fa05-400d-bc74-306241bc324a@gmail.com>
Date:   Tue, 24 Oct 2023 08:46:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/120] 5.4.259-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231024083306.700855687@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024083306.700855687@linuxfoundation.org>
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

On 10/24/23 01:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.259-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

