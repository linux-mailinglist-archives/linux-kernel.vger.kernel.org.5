Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B4D78C70F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjH2OOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbjH2ON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:13:59 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA9194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:13:55 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34914064ea9so3125705ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693318434; x=1693923234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ow39PSVhrVA+5+BHUV50uZmTZe4SBqTcpP4XBrIksQ=;
        b=ESWvNKtrA0zKcqPbJVo1y/jobBHITJRjL+Ii+MmQbE+W4WFnCYUPIb/nMEjf1EUwfr
         Ux4BCPuKZQA9lHGOXTru+ditiR5sy5bfGxw/xIWXytACF91N1vyLdwSXa+7R87oNt50+
         DmCQcuUSOXli0gZarqlRDcyx4aIdH0Ovluhco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318434; x=1693923234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ow39PSVhrVA+5+BHUV50uZmTZe4SBqTcpP4XBrIksQ=;
        b=TsrO7vdKeOkomPMrXUGBaXsmzavtBxotV6mrvWU4Q3XfDeUICfGMQjNWxY2vR2gajR
         QhOsViRC8UZ9jK9zgzrQg5kXzZwj3UpbD3NJw7bZfSngjfxGFPlN+3dFexKKvV2BR3KE
         H1KQQyzCKSc4AdImmYc8b5kUm1XTUH2O0tGhhxskGuH/3jct8AB4rDfWrLx4kDPvcu4S
         8ieMzgLnR2UCq39D9HcjV7Ys8nNRe9F7jQ3rlh8zlb90bYWghwYFEyQceTFYC2ZKSgai
         +UdMQ8RTl+2ickYuYRhNJkMnHL6k1Swqs/zWdFucNlwlahEIsshS9IyPNxVcoaPPX5R9
         6xkA==
X-Gm-Message-State: AOJu0YzWftOpeVSNYLjIOpAONakeG3hGi55kkfuREA57evHPfuo/fiE+
        ep2HEi05GZ3ebDAUBsKDYBnemw==
X-Google-Smtp-Source: AGHT+IG5LZETuQ/5kLHg1MRWthIIJ9cqREwChDwJz8qqmvY69opkos+OlSNzQ3fSSkH7lbL8/HGqdA==
X-Received: by 2002:a05:6e02:110:b0:349:582c:a68d with SMTP id t16-20020a056e02011000b00349582ca68dmr24273193ilm.3.1693318434690;
        Tue, 29 Aug 2023 07:13:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i6-20020a92c946000000b0034cac5ced38sm3138213ilq.13.2023.08.29.07.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:13:54 -0700 (PDT)
Message-ID: <668c35cb-580a-e099-5f67-ec19e289bc42@linuxfoundation.org>
Date:   Tue, 29 Aug 2023 08:13:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 04:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.129-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
