Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189B680F4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376901AbjLLRrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:47:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1E83;
        Tue, 12 Dec 2023 09:47:50 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d053c45897so52043225ad.2;
        Tue, 12 Dec 2023 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702403270; x=1703008070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uyRFYn/2E3bBEASN5RSINhi7V604PFIKYA1eHnIvDBQ=;
        b=mnHWsR4BCYswM6xdbTV5EvY8KDDnhaukc0DESRYUXvW46dRFSEYwbmIVFlLibZq1YW
         GJwddn0m8PrNviUMcby16CXqNWLAWF+Ow8o9QtdA/pvZuLWitCsLdVZnxDbOWZ+7TK+D
         b4pGWSYQunQwFa48BLAL29/JdqjAZ9RmuRHGq1fCLmLP0IE0xUojr1bIlrQ9b56iQ78Z
         wpfgzFWNiXQ7JAq12Cjp5oJYhSWpWd/wDlKq8tDS5/lmXwQOKNE4QzAA6+KFWMY/1Ogu
         iMieLJF01ndrt9M6oPJZAul7SvaOWzKf4qrC9PF34XgYd3EQVgXLu7mvtwehjHvMWAyc
         npwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403270; x=1703008070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyRFYn/2E3bBEASN5RSINhi7V604PFIKYA1eHnIvDBQ=;
        b=vizF2ycog+H/lywuvfeXmlo6MOxvJspfE8Z/BALAUkQEcRNFvaXPKATm4WbasDKoxy
         1OvONQ+A3/5Vw4Kti94N7PEwkBotjBTp0jtvJSF9/wC9rZzA65WQcrwQVxuo2RgINF7L
         KZsF6hSzdx7jJCQnId2CW+8Tj71kf4rgDXCN2QQEet8Xk5jDvEVnXpfHTBcdcYnu3vOk
         9hxwz5I8yommpbzG1Jw+pLLMSCJnTgLwJONkf9bRtvZKvT7zANCKPp2m6g8L6fCjD5UH
         OFsAgTjqu4Aw5CbZ6Ow8yroEd+S7zLLCYWbtfn8t2aJihlFiYL4VdOFaoV+wDgq58NWF
         d6lw==
X-Gm-Message-State: AOJu0YzEQXpNSNNAodNX+3NOa1noOOnHHl1H4yyMOC97pstLvRyHvBsv
        hAfGkccHacTt4fgUNnBJSv0=
X-Google-Smtp-Source: AGHT+IGmnTAI20jP+s0/IaukLJr8Qhfet/RF5DkK9h1IsC8L8kkioQiHzhGMiqZw4lxucT59b+eQPA==
X-Received: by 2002:a17:903:11c5:b0:1d0:6ffd:9e21 with SMTP id q5-20020a17090311c500b001d06ffd9e21mr7008997plh.115.1702403270014;
        Tue, 12 Dec 2023 09:47:50 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p17-20020a170903249100b001cfde4c84bcsm8905985plw.141.2023.12.12.09.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 09:47:49 -0800 (PST)
Message-ID: <37a418c9-06ee-4bf4-a26d-b7ac3cd2d666@gmail.com>
Date:   Tue, 12 Dec 2023 09:47:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231212120210.556388977@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
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

On 12/12/23 04:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc2.gz
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

