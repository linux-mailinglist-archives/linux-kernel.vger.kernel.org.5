Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B075DD03
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGVOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:49:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A541999;
        Sat, 22 Jul 2023 07:49:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6689430d803so1750090b3a.0;
        Sat, 22 Jul 2023 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690037396; x=1690642196;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6RbVO1ScgDHvCnnDrduqM9cFNB+8gywma+fRSXcXBlY=;
        b=EIfc7YC6DTtA0YR8NlLDp3y9nj/fBsmGX5I8vui6vuJu+VdbZMs5PyzkbFngrjiFh7
         3+TRP/kYDPZx1mcTct6WKy1jyp7G5QsxJWqlfL9mRAiNKcUDKJcp83dzGolqIu0vL5Wv
         1Qc+Jeklwl6G0lruZIbk8wk9sgKJDzp6Hp3StPLH892xucJEephAmf+WulyufZa6n6kV
         x8ajlFxxXxZEHxD/9YCMn/yfFfed3oZ921Lov/uyDCiotRey9Lv1jyugQY4IZNB6fqSj
         pG29UA/351R2OUr/oz4A4sZ/q9/9JsJRgRMH3g9XqKc/cWv6j61VxAX5zdMSApuYAEym
         QACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690037396; x=1690642196;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RbVO1ScgDHvCnnDrduqM9cFNB+8gywma+fRSXcXBlY=;
        b=Nb9nCfQdhit8qjClnzpM4BWhi+LAPXjdwNpowTpRi3xbxun7TnBmAUNiV+LDq+ONy0
         ohlWHDiWzU24aiZCtIGnDGWL+gFtRh3kylc6/9oxDcpuYVKPqPf/K2WtJ83CvguAmjfo
         WwgyhJwBBxT8h/TxXJLo2PLvFkA+N/3508aRhhjdmaanbT8RBr4UJ/FhjainC6C/snJF
         k5YgO7Jb6O7oeA+hiDQ3OCrsx68M5ycoakfIYXc6JyfED2URLzeyr/AhJAeL1XFAsxu6
         tRedXhZYvpoUm0Xiy6yF887TsUGFcC1yiwJf/gOE915K2Zs8NzZSzyT+n8svGLsJbH1K
         UewA==
X-Gm-Message-State: ABy/qLYSkyLTvM2WGuzY6P9UUAwhW1tlaoLXKvpUd71qPg/h2pece+HU
        neGd9VLeA3P4R5EjvBIzGDA=
X-Google-Smtp-Source: APBJJlFjepFzPi/Ej+rmWsUG4Ww+c3XitwpKU0IkmaAi4l8ffNjPROhART6IL9X12YJZYbYJPCrNJQ==
X-Received: by 2002:a05:6a20:88:b0:138:2fb8:6c48 with SMTP id 8-20020a056a20008800b001382fb86c48mr4008099pzg.8.1690037396413;
        Sat, 22 Jul 2023 07:49:56 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k196-20020a633dcd000000b005501b24b1c9sm4998093pga.62.2023.07.22.07.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 07:49:55 -0700 (PDT)
Message-ID: <8730178d-fb3e-9841-8c93-c7cc3dc54a3e@gmail.com>
Date:   Sat, 22 Jul 2023 07:49:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230721160528.800311148@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 9:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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

