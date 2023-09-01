Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAD78FFD5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350174AbjIAPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjIAPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:20:27 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A210EB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:20:22 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34914064ea9so2232775ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693581622; x=1694186422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xY8BsCECr54L+c95O61jCyM46mbHUvE324/fO6bwAIw=;
        b=gKdnM6CB5HluKNsp/Y1gUD25dmNlR+jSQF+xa9D72zGRRgJjz7levUhbT0sOtzv+fJ
         gWN1M+dlaHPX6+zLig2k9ZOpoR1UY3kwwTq9s/q6jMFKJ+3be1kdR3E+duPXz7itvZCd
         IhQE2OqxGX/fVEUhFBMPNAv5JM9Hc5MOmJ0cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693581622; x=1694186422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xY8BsCECr54L+c95O61jCyM46mbHUvE324/fO6bwAIw=;
        b=PzRz93J2iIUJqOFCB3JpVDW+0rrwrhRvg7x1jPfolWeKAMQ7I7c/I9j2g1QhuYKFw4
         aKsEXmR+MXn2HNQYlFppWVsqQEaKEBf3JOBm2akWKVOaGaqHSepoWvMwnPMjg+qLnKpT
         VC8ae5UVhNT3GVW55wJVeMlOZiAYUWBZfrlWIZhwd+DeLeRGj+ViC02wp+IiDpfKaRVE
         8gsJ0dQn5QtPkOBqZTDJ5ltTPNGm1I0p2XLC3uiBWdCSIjvcuIzx9oVl+D2ZlwIxqtrO
         MWEZu0fBPUlapH/JxedQPmriHgEY/FuJH0xEnSEduUJ9qXOB12VNvnVRz1AKbtq5RmQW
         C7XA==
X-Gm-Message-State: AOJu0Yx/McjNRSunZ7/kF/KkNXFedyvCgS2Xmk/toqDUaP7DXpVWy6ST
        AfwREpE9ISjZrq+vW+HBtFXJng==
X-Google-Smtp-Source: AGHT+IGG3Ew+TxuHNK6QM0bToaGrJd2wXKh0rSJlX3Vov9MjzbOCzhl1ncGLiQIV6zyXr1scCg295g==
X-Received: by 2002:a05:6602:1588:b0:792:9b50:3c3d with SMTP id e8-20020a056602158800b007929b503c3dmr3192707iow.1.1693581622276;
        Fri, 01 Sep 2023 08:20:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s10-20020a02cf2a000000b0042b320c13aasm1118332jar.89.2023.09.01.08.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:20:21 -0700 (PDT)
Message-ID: <b761de93-f4e3-2395-07d8-7f8c86da1ff7@linuxfoundation.org>
Date:   Fri, 1 Sep 2023 09:20:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.5 0/8] 6.5.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230831110830.817738361@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230831110830.817738361@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 05:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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

