Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A545A7D3F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjJWS40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJWS4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:56:25 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D0B6;
        Mon, 23 Oct 2023 11:56:23 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d12b3b479so23090396d6.1;
        Mon, 23 Oct 2023 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698087383; x=1698692183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BH0kWO9VUQM2/DeE8iMxAfNKsGS6sxeTdVFQPB4LzGE=;
        b=UduWxxVX4zggl0KLL8hypnpMpPg4C9AkMqg0W0XpJ22z3tgFKe83Vw+nHoZViaj3tf
         aAtYmaBGVRDv+Mjz1gq/qM7b4QHK97S6FguIflIg3A1V40lwJunT7S8s9aGAOg9xRb3J
         c8Y2i1HBofa+uIPouSKCzcbeS5yg9+D24CVE5ybQ5DVn8HlRspTS29W5cb8yNww6b3SU
         6nqmo6XmblzV1rt9/R8Vf6f1/lZmokitNapzFtgusbRX/oTNHAjXqcwjpziXawLW/pwL
         eWox5mooCQTZML4fNGw0t2sStbtNv1YYb74XRQ3rQY9g6nn5G0iXCtRbUWRzSvPNAR4a
         jt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087383; x=1698692183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BH0kWO9VUQM2/DeE8iMxAfNKsGS6sxeTdVFQPB4LzGE=;
        b=nfKqjBDIm6/sRa41blzIK/FhoolUKxh6MnD4B447zu5oOaBbCmmRDWBP/Wm21KTYda
         KPXLIkHvQ9xW81rQIyGBGvWxaQ0b8PMWCsFCNmXZrjinkBsKuXiccdJSgJvW8JNll1kg
         j08VyGzh3CxC/j2IUe/CTLu/bAz5EpIGIoYXe/yK1YWY719CBNA+Z4O8E7uef0EqkngJ
         OCfIZFz+mv04dKFDlq0E304vDhtS52aBVNLNX/H1r57pDGkjf6+TK+1/qSqUNW0wf6MS
         ulGdT7uZU3Db2DJJa8O13J21YiaUVDejSjr8mmaj5iL1PpCuAw+J5O7Ikgk+z7XPOjbZ
         a1YQ==
X-Gm-Message-State: AOJu0Yy7D1ET4UW26cSu8BIGc4lpOlfcmNEdjqrr9VL03atx531UUAw0
        FuL1JUKcMtGEb0TULeVNhCY=
X-Google-Smtp-Source: AGHT+IHnMV4ob3kA/InN8Dg8NmBPlXO8MzNOjVKhkWuGzIlBEie5ZcWNCFQVx7vNFBjc4aulm4M6wA==
X-Received: by 2002:a05:6214:f24:b0:66d:4680:6dc5 with SMTP id iw4-20020a0562140f2400b0066d46806dc5mr15426148qvb.50.1698087382615;
        Mon, 23 Oct 2023 11:56:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k28-20020a05620a143c00b00767e2668536sm2922978qkj.17.2023.10.23.11.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 11:56:22 -0700 (PDT)
Message-ID: <2ce536f4-19c1-4822-aba1-648c1927c90c@gmail.com>
Date:   Mon, 23 Oct 2023 11:56:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/202] 5.10.199-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104826.569169691@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 03:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.199-rc1.gz
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

