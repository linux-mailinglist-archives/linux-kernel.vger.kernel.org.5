Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3D7B9960
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbjJEBCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243807AbjJEBCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:02:01 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169FCC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:01:58 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-351265d0d67so728165ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696467716; x=1697072516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEnsQWLeaft+J62oGzu134FsAlbV6Xt4/uQ7daj1HXo=;
        b=FLs3qO/4cgHjSx8Ba0BU+naB0xnrWiA7WLhSO7o4bA0zZZ6m2uj4/kvBWKujvzsuZ8
         DtHQLuqN8x1PzXYzlaySFjCbK3//CqcFSj+7ihNK1K1WWN7IuK/O0fITxslfsTpdZSHJ
         aitpZPOyJeOlEIrcKi1GAp2ifKjWalOBDruUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696467716; x=1697072516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEnsQWLeaft+J62oGzu134FsAlbV6Xt4/uQ7daj1HXo=;
        b=Wfd3Fyysvgvw2LbKGWBg7qwLZObMoj/6SLQEb3L+FZ6ZSNYzYiE+Id9XxZWhWXi4Ws
         T8RY9EF2adm8CVugizz3HBN9lEigKFhW5H74kSBhqgp+j9iGzvSStaBUrLmXgobFwNHq
         usqGi+EkLwF+jW+8JKbdl0pk1/fLkL5itOBXbw7rHxNxToP5VnPW6baPUXRZ2xQ6YxT1
         SrK3U0JxlvhiK9rkHHDLunGWtJDG5rbbs1KJaPSMrMCaW7CrqScZYdeASaXXAcST6afU
         ee1khDgoqpjprSxSYkEP86JPddDlxJZyRL8rF4YMAsgYri6nGSp+oGMnGMz8VwUjn2ju
         p2hQ==
X-Gm-Message-State: AOJu0YyA97LdNdUV/yE25HDUfmDgwC4/AF0OuCBxs4JwdAc8Dy2EI7e7
        SqK8zLBPfrtAvd1HQxsbKgtQLw==
X-Google-Smtp-Source: AGHT+IELtAlxB0w589CeZedI82KQxlHVq6CHeVvwJf9537KGpS4YfFd6poKmDUGMkVZ0CWNB2QgycQ==
X-Received: by 2002:a05:6602:368c:b0:792:7c78:55be with SMTP id bf12-20020a056602368c00b007927c7855bemr3794431iob.0.1696467716574;
        Wed, 04 Oct 2023 18:01:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id fx13-20020a0566381e0d00b0042baffe832fsm139452jab.101.2023.10.04.18.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 18:01:55 -0700 (PDT)
Message-ID: <00d307ec-105c-4cdd-a8b1-73e4ad030cf9@linuxfoundation.org>
Date:   Wed, 4 Oct 2023 19:01:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
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
References: <20231004175203.943277832@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 11:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.134 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
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
