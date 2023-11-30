Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314167FFAD0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjK3TKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3TKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:10:16 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AFD40;
        Thu, 30 Nov 2023 11:10:22 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cdd214bce1so1298198b3a.3;
        Thu, 30 Nov 2023 11:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371422; x=1701976222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QitiP5XoRIz3e5peYWbCOL+stxKLuwju5RuWWjYKtdk=;
        b=nX5NW2+GyVof7MzsFEsjl47R4qmffZ8jocd8lOJilLUVG2ZG4qyuPXgScJ3fGxZO0E
         adUtIxyh2aEBnOay0cw1aUh+mKdXWYOIwMtQBgyfLBiomt5MRXJZIUSJhveIZNI8dxn1
         NAEldlA3DkWWXpcPlw6KF4LPyzNTDWvzeUuvPHxt2oFaBQ7obq0SoHOmtxrWetLN2Dh4
         obnc8G3d5hCX5wF7NC3PiAaeJpXjOVgaJ13O8aVEzfzrakLbgddVAHzWLGTccqoKapl2
         DePC8C/PI5QnRvfisZMCq5k7856iNf0LqTqREmTWLIUg2KDScjjMTQTDwKtBWHl7PcZd
         8j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371422; x=1701976222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QitiP5XoRIz3e5peYWbCOL+stxKLuwju5RuWWjYKtdk=;
        b=F90Y/7sc6WCwrPY2qHeSD5bZQ4grz2ZRLqGm8iqLEsRZ0mJPD1SSPtLrz6VRDHxcuY
         EHzB6m/LSkdywP43rApEpxPZl/SMDB+UzxTDjv65WiLbJpiAmuXPSr3mDw5sH2Ryxeyy
         Bl2biFXCLg06D7RMhOZxpaWjdxnlDxnRRQYQNXmlkusCazZyUwqxA3YCyMRQlYtDyxUm
         vEzHHTLe8zJDurTvb/pw3Tf5Lxt/mnIhZpn5nC19qrNbJ97kqU+ebC8zrEs++U08sQ9V
         sLWSkloxKfxWXRLHYeL21ghvKjG4Gz8xIOEPfe2iFO4v/01dhLZ1vXAfuot/zhUvLR3Q
         ZBYQ==
X-Gm-Message-State: AOJu0Ywdg2p7MqPkhxc93AzNkxZqqufrcBTFK4FyQFYhzzOcn4YEKz+T
        NehbEMjAFXuBIsVP6KrbvRE=
X-Google-Smtp-Source: AGHT+IHxIthsTZ50FfgNUEXYgObdZ0eyLoZ/m4F1pEt0Pn46iewGSeoWvofyMMSEEWAw+V69/bPv9g==
X-Received: by 2002:a05:6a00:2d0b:b0:6cd:f69f:e3a3 with SMTP id fa11-20020a056a002d0b00b006cdf69fe3a3mr1681746pfb.21.1701371421855;
        Thu, 30 Nov 2023 11:10:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 77-20020a630150000000b005b8ea15c338sm1595622pgb.62.2023.11.30.11.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 11:10:21 -0800 (PST)
Message-ID: <63978ea9-0be6-4698-ba0d-7eba78e986e0@gmail.com>
Date:   Thu, 30 Nov 2023 11:10:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/82] 6.1.65-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231130162135.977485944@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 08:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.65 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.65-rc1.gz
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

