Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF77A790002
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347332AbjIAPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241960AbjIAPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:35:32 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBA10EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:35:29 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso502573fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693582528; x=1694187328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTAgaIHV2Rbthcqd0GIeKy9VSrzSAIC0+RYFwEdspZM=;
        b=JLX6RP6MEPAwVkudHJUfSvIiJaoxYeM+E6JXoaAZZ49ysD3mSH0R7SfwNoA1ySwQFv
         XTrJyu3hWYIh0FEo10EoGD900zVqjdyoxonFpjCCP7AWFTrYypVX721oatR4g1Fw9sad
         RdQB8q2SAU0uGkaakqLevGI6jijrOqLqf7ynQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693582528; x=1694187328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTAgaIHV2Rbthcqd0GIeKy9VSrzSAIC0+RYFwEdspZM=;
        b=liebEFxIkiIiBMVGls2BoRcF6xIlbvLoZOJfZnLAsVK+xSNJlI078PByTijeCTc4Dh
         3i2l6ImRF5dnuIaUpyzs2dxnE4z0ETHYM63lg8FUHp/8F4aLWgk9BuuH5uHYjTHWbLHJ
         m7/bagIxP/wGZu5s3Q0kPae9a3bA4TroigOfpKMf+QIFCWjQbOlx1tG7yzFp3JdRrpLG
         mYm8Q65Dm9NEbQ79SPG8kF1NaKIM+a9vpc05mOU1giSE81mWXecsxC+/QVwNfViHm50M
         7k9gQUegVF26bebXB0yToTus1iZuYfRoOKRSSfvm3Frp1T2voy6eW1YsQMktH7HduL2w
         QCDg==
X-Gm-Message-State: AOJu0YxwfVUSaH9b94BbqdueqIZ5WWGNmg5utG3wCcWzEdD1znYAJZJH
        olJ81E0nhPiSVyddVG4/9ElByJrJnP55zAZxvzc=
X-Google-Smtp-Source: AGHT+IEOeZ6seXktCwZa24B3/OHNkOBSaxYQj8enZl/xf5knmJu5UdOWdrgkCFQ8hgO0zYD/5uIMjg==
X-Received: by 2002:a05:6870:ea9e:b0:1b7:5e47:5b75 with SMTP id s30-20020a056870ea9e00b001b75e475b75mr3199400oap.4.1693582528479;
        Fri, 01 Sep 2023 08:35:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d40-20020a056870d2a800b001c4b473581fsm2258172oae.12.2023.09.01.08.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:35:28 -0700 (PDT)
Message-ID: <1d74a326-1271-e21e-3a11-ea7ab05b0f23@linuxfoundation.org>
Date:   Fri, 1 Sep 2023 09:35:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 0/9] 5.15.130-rc1 review
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
References: <20230831110830.039135096@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230831110830.039135096@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.15.130 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.130-rc1.gz
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
