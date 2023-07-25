Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867D876231A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGYUO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGYUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:14:26 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8771BC8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:14:25 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id ca18e2360f4ac-78706966220so50115539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690316064; x=1690920864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLm8Q14L9KRoYi2NDYJZjjfwgSEV8RLSyDVs7O5+lX0=;
        b=Txm4YGTz9Vf10B2dUaJo5+vTdXTTXHFhI3yNuIulEVtZov0jw6xoDc7bP1RuJFSAZX
         P2m+LBEE1vLjdhTmdyEccvyEu5kXXH6bKOHenIsBs3pcJGSlRaruFBCyh+QCRdxZ426p
         mz9TJmpUKJhmydm9ZnmStOfINLlUVFvMU3Jj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316064; x=1690920864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLm8Q14L9KRoYi2NDYJZjjfwgSEV8RLSyDVs7O5+lX0=;
        b=laiqraLX7pQiKQlASQIqqcZ0AI5pA4WwU7TNqhnlBpXEWCJuL9nr0GPqGQzstKxY/o
         9pp3qiPvcO6Q+a5lla8s+vaaTF6ZAKynYEQEpj+TJFlhGwAtrdYDhPYTZDpmtzbohIOt
         2B+q8yTNVXPpEe6blTS8Kvw8nyOIwD23g6uIEoe1TKy1+XPoHgXAb7iggVCOc0n6sj3D
         pW8oxn9Hulag8a/3hLfGurKBeALFa5JRBmu9Vj37R8BAS2Adag0mHifcKlwdJvfRpUNc
         70XaTlzqg87sgdcBl6wZ9aQmc7fYU0MOgrQ8cHrM9Dse01kypP5yoTsKmdjcTEraWvvC
         zivA==
X-Gm-Message-State: ABy/qLZ89TEYJ+fMvnqL1TjLVBM8ZQLVq2S4ekqzRKt2SO8J9N2N4iJ6
        WhprEqvY7gbpBXKJga9Lv7rE6A==
X-Google-Smtp-Source: APBJJlH+5YOOuZ5gc0acRLrWkQBFmyMk2Gue0Ig6Wi5QKf0PDS5q6L52OI2OAJO7ikKDt6ts9FN95Q==
X-Received: by 2002:a05:6602:8c9:b0:787:16ec:2699 with SMTP id h9-20020a05660208c900b0078716ec2699mr10069538ioz.2.1690316064405;
        Tue, 25 Jul 2023 13:14:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q13-20020a5d850d000000b0076c569c7a48sm4522609ion.39.2023.07.25.13.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:14:23 -0700 (PDT)
Message-ID: <78e537a3-5073-6694-625f-350f26144600@linuxfoundation.org>
Date:   Tue, 25 Jul 2023 14:14:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
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
References: <20230725104514.821564989@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 04:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.7 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.7-rc1.gz
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
