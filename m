Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C700978C6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjH2OI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbjH2OIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:08:13 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5BF113
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:08:01 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7950d0c85bbso7069039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693318080; x=1693922880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5A52SOhqx+LK1llSr0QkkwCAZdwMynClS+NesllUSg=;
        b=ESAbl/DQTDF14M08nuV6OqabJeJ/XfgWJ9UcBOnIAbjdxF927sZj9zXzUd2VeGPrF9
         dHucC5SBp3C6y2Q5SqOqfTzPN3EIjRxZgIsKy34+s6IZJAj7pUPOizUe+hwuD+wNdvwW
         G09UXS2jkZ7IuVthlSs9pClLCG2GRQIAZyYtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318080; x=1693922880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5A52SOhqx+LK1llSr0QkkwCAZdwMynClS+NesllUSg=;
        b=AvL6EslxP2xI3/C5SJZu6FSNGh1xOjjQNtUAhVn5qGePc8X5/uQ7y9FKkYbORA1OxT
         kuq8BYyUTpynMOj9BTjmE1fTTebM0pxqzLXQu1BcoocEajEbPU44NOD8129ks0MMyDpk
         D4vGniHkwLuoTaxhT2i/2eebpNSL0uG66G3BsDZmlOhdwFg49nunXZkcVqUXnb9K7IVI
         smj+Sm4+QQ2B9+GjWLTyOimVxPRT1NOlvgweWW2GbvB62zyHy2d+vo1dG7lo3hUxSNju
         4Qp0bF95wd3dHPyNg+GbrISsnB/enBZqzL9EYZH/OyDtf2C11241qAWH8X5iiWxwDWZs
         JyqA==
X-Gm-Message-State: AOJu0Yziqei10M8aFOA+ZJtptrbmNR2ByjsGCFk2qiEVjhbWG/WXqpIX
        zdSPBNpfnv3ugulOU/Yi+VnTRQ==
X-Google-Smtp-Source: AGHT+IF77SqYKsSv7x93DBydszfo6Yvo8h02fntFgI9+7/+WPTA62RjvgnoCXrBuXLffbcN+zbuYmQ==
X-Received: by 2002:a5e:8911:0:b0:792:7c78:55be with SMTP id k17-20020a5e8911000000b007927c7855bemr12984783ioj.0.1693318080641;
        Tue, 29 Aug 2023 07:08:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id gc24-20020a056638671800b00430996b3604sm3211365jab.125.2023.08.29.07.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:08:00 -0700 (PDT)
Message-ID: <2fe6f656-23f5-1fcc-5387-c9c2ed4dc701@linuxfoundation.org>
Date:   Tue, 29 Aug 2023 08:07:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 04:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
