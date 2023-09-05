Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46507930D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjIEVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjIEVQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:16:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB0EB4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:16:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-792973a659fso22618439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693948603; x=1694553403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lN5fpIYRwWULY83XeFrIApl3PJ3oceB+pvimMrfAuCE=;
        b=fWDnDClKbjxZIfM8wBa4YvCaJ+yAjDmnmRreDh8xOheTL2CqwTdMm7/QIPmxVcViln
         ZxfhOGJ8DveHhGSRlSpJsh8CDam+4fKXtfEmNle21d927J7LHN48JOy4zNHD563WsowS
         wNRAXhoQOGpmci/MJ23cXsYx2KcDyOkmGW1CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693948603; x=1694553403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN5fpIYRwWULY83XeFrIApl3PJ3oceB+pvimMrfAuCE=;
        b=cPM40uAWgPcTtpGaZSMNXspEEbBgUKfUH5PZPpLvquNDOqKfRiUEqUycLUVWnC4oqM
         J5pZAuS/F21Q2/0hxX/stTxN4KWP+MYLc0tFTTKBHjnuWPX4qocE38KtsGUXObaa3tJH
         Mbv2/F/H+TkjZTrob6QEJgPltMQVUIjHfU75JCCLRPIflkxeuYkkq1stBEPTC/+XLd8E
         asZCAZ/qdcpJhkjAGytWAM9Isay9sqIhswxZJXtPNebtC4BdPMYVdTqPQrIhBDlHIwLh
         FrLKz9JT1EeI5Ittl/aHvb/x5qFnSoTd/H6Gfvyc/aza0J826u/802EjXBlJYjEFCUIa
         LWpA==
X-Gm-Message-State: AOJu0YxqDVdosT4u8xbFP2uEq8X3xAlnSIjWSqFsuRS/7DxZ6K/6Lfis
        4BMQyZpeKdMJBd5SXZKrziuBeQ==
X-Google-Smtp-Source: AGHT+IHEPY4lFmXX0Ow6iJOiyRNqTd9k5SNtoCEfUz2WO8gHrcXjl+GBxtNwXR+mSJe6ze4lMbh59w==
X-Received: by 2002:a05:6602:4192:b0:792:8011:22f with SMTP id bx18-20020a056602419200b007928011022fmr12640055iob.0.1693948602750;
        Tue, 05 Sep 2023 14:16:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b0042ff466c9bdsm4449092jan.127.2023.09.05.14.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 14:16:42 -0700 (PDT)
Message-ID: <3c819b63-19be-62a6-a3a7-5c4430f7827c@linuxfoundation.org>
Date:   Tue, 5 Sep 2023 15:16:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
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
References: <20230904182945.178705038@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 12:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.131-rc1.gz
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
