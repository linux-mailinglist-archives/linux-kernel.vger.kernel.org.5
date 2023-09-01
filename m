Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86186790025
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjIAPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjIAPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:50:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9836B10E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:50:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a9e89fa553so237251b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693583453; x=1694188253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDVLiGkCJ44mSe9398hxPMh1wdeWVEXWAYExdgYO+l4=;
        b=V/ytYuOSteXa0YWsSJ5H7DYT4JgnbA8oCIe7037oM8XAIcpqujPYC5jKMe8dPr4GtN
         BZaSpl2bxS0PjjQf+V3zQ2xryRgx4deSSZZF3mexE8QrkeJx+t0t6XjnQT9ht403ELQC
         8cRLQbzqrwfLmgMafaImoikVapX4S83KBHXZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693583453; x=1694188253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDVLiGkCJ44mSe9398hxPMh1wdeWVEXWAYExdgYO+l4=;
        b=GNpR3VQyYjs3MqRDxPXeERBcziH0ecmxFuoIYpqHiLxTxw5+YKvHGUuKUQzYveCWY+
         bqQU1ADbGBNz4s4vX2SAxZJPg2geOaS4WOAnu/UgmLWSoN30Z+uSOnHRYD1qJNga9/Du
         GC07zwuvLB8efa9awJQ74si3gAyiYP3EeyxB1QWuroEDG0HclmhNwgP4/xi2KZlNvDBY
         snnfX0gPEkeXL3Lf80cg19IZmmU055oekUFoSWb27xozXKs6avn3jAJ0M23CHs5x3NgX
         XEIJrsL3flwetMwM7XFzfR8AcP93H5RoDv0rIRAVk25F0+j9dTMcvLPVdqzbfw7Fnjr3
         Mrnw==
X-Gm-Message-State: AOJu0YyYKc30JsmQpnr0h2zuzs5Ms8CQ8uaLX+vIhGktFETtbTL7+ueW
        nKPvl4L5sSKEgOxEQMSMlgm26Q==
X-Google-Smtp-Source: AGHT+IGYxGykt5vTi4lZLI418Gz4H7++6jPC4+QxnO4vCE+VSdDD+qw3KAVsbATSlIfTV0HXI5a7lg==
X-Received: by 2002:a05:6808:1a06:b0:3a8:8aa8:a4c8 with SMTP id bk6-20020a0568081a0600b003a88aa8a4c8mr3579934oib.2.1693583452898;
        Fri, 01 Sep 2023 08:50:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q29-20020a056808201d00b003a76d7f596esm2090874oiw.54.2023.09.01.08.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:50:52 -0700 (PDT)
Message-ID: <6ae96706-6d0d-f42e-0110-4339ac94f4a6@linuxfoundation.org>
Date:   Fri, 1 Sep 2023 09:50:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 00/11] 5.10.194-rc1 review
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
References: <20230831110830.455765526@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230831110830.455765526@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 05:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.194 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.194-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
