Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D997CB555
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjJPVdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:33:09 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A2A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:33:08 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35291dbf7efso7068275ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697491988; x=1698096788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1cmLjYtXmkTukmFQ8B0vWtZyFMXkEqPE8NrYHJmnr0=;
        b=dOZUKS7glME9vQtVFUkomBEtggHhzobveMIcNWGgpO0L1hhpKfzoanA61J+IscLjZ3
         +gF14Hrz3LsSxPTr4pCtvC5W7ubZmPxzN+NRurZCfFUd458vs5a+uS/6a94oXPmcZM0A
         cwX+GzTvkR+8ONqZ1YyjVH0vA1ZCeFOrjmaPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697491988; x=1698096788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1cmLjYtXmkTukmFQ8B0vWtZyFMXkEqPE8NrYHJmnr0=;
        b=hrdB5oSDv8TWDioNmf0xOM6YXLb4TiwIO0Hf5U82+E6HbZ77FWW/RzwCix14V15wg3
         3aJyAywn5GWQe/pV1GOmFJx7vIcd8peMY7BFD6iThT53jOqfh6+I0DOoxlvJbJmkDpY3
         eW2KLrOVNIAsEe5surTDppSgZN7nL+spDNNuxHpYecF+Y1ZGtM72hJKHtEgK4Aqvo2dm
         MdqROz1cYJvhsHR8+Y06XWlMx8F1Wk5K4dy/m7G2oOKYglSwWVetxHRD1mJcmJ4nwZ5N
         Ie85ZPy+jypzzeBqkeWuTExQgGeNfeLyZw/K7ij9NJDYA6jkvQCZlcNcL+xiyuiTDGii
         VnPg==
X-Gm-Message-State: AOJu0YxTy7Evs5xAvZvoqNXBNRRjliii/+9guLb0ta0J/348htF23zlP
        3yxKTgdyXiwPMiZVJ2EzlvYdMw==
X-Google-Smtp-Source: AGHT+IFRgiYejT5HFoheHPppn0K20RqywRgI4lH2JKT5HNjMtQZgmHUAKp0ePrq/e+KvjLnVDxvycQ==
X-Received: by 2002:a92:5213:0:b0:349:4e1f:e9a0 with SMTP id g19-20020a925213000000b003494e1fe9a0mr675550ilb.2.1697491987759;
        Mon, 16 Oct 2023 14:33:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k8-20020a056638370800b0045c25ef9a56sm58767jav.21.2023.10.16.14.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 14:33:07 -0700 (PDT)
Message-ID: <fabe5bf2-e870-44c5-b4dc-79fe44a2288a@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 15:33:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
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
References: <20231016083953.689300946@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 02:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.136 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
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
