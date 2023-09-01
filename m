Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4468D790033
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbjIAP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbjIAP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:57:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E95C10E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:57:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760dff4b701so19385739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693583846; x=1694188646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOp+ssdwZ/xOnIkHfRtIS6twREd4m/QNPQ7G44ZlNUE=;
        b=QEMnR9CdrCfvxsIoe/kng9nPFPU82ANjD+S0hNlacMLDCps1Ml0vJjbH4w3V12I16U
         /MwG4LbsFiGMakcflQHVjUA2+7PImql1ef6g7ZsxIbStF43BM2UkEL9x1t9utSDSISFS
         r4OG5dMHYi+AKixNTNT2zUZX1i3mCGvOaHkdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693583846; x=1694188646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOp+ssdwZ/xOnIkHfRtIS6twREd4m/QNPQ7G44ZlNUE=;
        b=Ca9aFqKAbAOhdwQOu88NsNU1rCdfroNUwxMPrOPV6tbl+51kwzGeWVC6Ea6QmvFQvj
         Rr+GmhLGAmaMTykG03CpVHyIxsQM3Ix/zSlHweCcgBj3qgs+P6TNb38VmoOJaOMxgJEh
         mHwaUmCKgbvWwYwFHrm22ucoCAMywHRcc7sXJnY8zPBCJvyDdAlbu3FHvBfcFiF6+8TP
         KB4mXRuY3ZKkvVPP6/DxL/TYZ/uECcWFYh+MdUcEC9xZAR2UHfCW4xLARfMepdJcFeHR
         MzZmvnqIJJVmYsXtP7ldVz1mvRuoi4w9zqoiZdHQkrR6hUDZC+H9iHEF34L9XauCMIWs
         JVvw==
X-Gm-Message-State: AOJu0Yx7/9OBNyzPT+Rdp3MraG4qkDhZ9P/kONkdh/RUZ9h7k1Cl2ZY5
        DVl2Z0AzRHZQn1LlyMXpzBvF4Q==
X-Google-Smtp-Source: AGHT+IHTa0lwsPdXjEpij8SAYIZZAr2aEeR5h/sXDMXJWU2TlwSmPVMkbRDd5kW55hisyEzDnIAx7Q==
X-Received: by 2002:a05:6602:73a:b0:794:da1e:b249 with SMTP id g26-20020a056602073a00b00794da1eb249mr2697575iox.1.1693583846073;
        Fri, 01 Sep 2023 08:57:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n7-20020a6b7207000000b0077e3acd5ea1sm1140014ioc.53.2023.09.01.08.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:57:25 -0700 (PDT)
Message-ID: <ff0684cc-30d4-47a4-2a9e-684835e834fe@linuxfoundation.org>
Date:   Fri, 1 Sep 2023 09:57:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.4 0/3] 5.4.256-rc1 review
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
References: <20230831110828.874071888@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230831110828.874071888@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 05:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.256 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.256-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
