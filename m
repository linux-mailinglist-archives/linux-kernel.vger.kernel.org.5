Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB217E2BA9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjKFSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjKFSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:09:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D444C6;
        Mon,  6 Nov 2023 10:09:46 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692c02adeefso4064382b3a.3;
        Mon, 06 Nov 2023 10:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699294186; x=1699898986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=neBbBkCbikRraB0nQmFPavVUC9R8TAdKlPMHdSdzNw0=;
        b=Eqcxm1wPSyzDTWB2zBUhMjlOSFyOfC9EQaBSnc1XAMSiHcKRh2oDi/XUOy+xqcAx/y
         AD8HZJlgGiX6RB+5fcoLnYqFIwzsADRSlRGfucVbn63F7nxiwzFzg6LU5RPVDpDEglFQ
         8FaEgDa3uhKvkUDmS7pWVF2RuEYig4J+MQyEDHrvnNY4jR+kdb4mU85CAs3E3eeN7PQK
         TNXDDbfvlia41U2n+ePioFahDbqsk7CwqRGiXxB8Rc6A2iaSSBHrKvvtybmyEnFej0yX
         aJHlFJkP48E1XqsNTWCc6DN2Ve3Jb3OfwhwRksTYtRH63b4AI20fYLXvtwfgwz5cwlDf
         myDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294186; x=1699898986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neBbBkCbikRraB0nQmFPavVUC9R8TAdKlPMHdSdzNw0=;
        b=VLkYdWXTYImvbnruh8W83n7gH3y19E45648/ajJw0woV/q02IJy7FGlx64NKV/1wOt
         JRlKyE2LFQCn4SCJKzU1BSCVcbffTliXnciYbRLgufzgywuLeJUYPSy77rkgGkHJgOu+
         Dnw4AkBvcZHeJlwpWS29MzIrUhEaiL9GC05Irvs9MeTsLdD0PiJYegfTQf6gHZa+cduc
         QHcBxggzm++ks+nY10OcrDf6P6Xm8LDNKrplTPmopXNGagJxYHl4S2XIEG9EQEnUlHyi
         WgqS5PVap7YJ3C6/ncALTqTVm5M9SLyX1o9b49e6n9VNG1sspeEhbKCbjKxTm+PkdMIp
         +I1g==
X-Gm-Message-State: AOJu0Ywse4Y7PiWck+xgKj34ACX4fol7YbdzexeDcHJkplRzU424IBnZ
        ZfVvZRvzOuGqIIz+M3WEvcE=
X-Google-Smtp-Source: AGHT+IH3ttiaL+UUmdWm09Np2ElUm26SZPhFEDb3REd7EVTtMMkwUQYDp2QiWdEBTKh1EUnnDWq4rA==
X-Received: by 2002:a05:6a21:a58d:b0:16e:ab42:9837 with SMTP id gd13-20020a056a21a58d00b0016eab429837mr32603706pzc.29.1699294185720;
        Mon, 06 Nov 2023 10:09:45 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f5-20020a056a00238500b006926e3dc2besm5868722pfc.108.2023.11.06.10.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 10:09:44 -0800 (PST)
Message-ID: <eee1e8a6-ed8d-4667-a2a9-18fb2a636a90@gmail.com>
Date:   Mon, 6 Nov 2023 10:09:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231106130305.772449722@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
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

On 11/6/23 05:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.11-rc1.gz
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

