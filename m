Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C280F206
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjLLQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjLLQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:12:08 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24BB4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:12:13 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b7684f0fe4so6785939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397532; x=1703002332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5Os7Zf9xtGAEMMOdp6/zayB3XH/JTR+GaEqzNPOqhg=;
        b=UZWSbbuB2C4dgmPehTNncpzKzoXypuXLJkZP88cI0i6Q+mE5ucRmaAcNb5NCf4zLa+
         xYh7h/cYPieJqVYVO68PYDIRGeJJ5NQtkgPMgNudn3uLLkRB0JgyT4u6J80Dn6GA0E93
         R+SjhcqxZuIAsObqrLb1Q2VwD6lSaiDFfo87M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397532; x=1703002332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Os7Zf9xtGAEMMOdp6/zayB3XH/JTR+GaEqzNPOqhg=;
        b=QBtQF73ZCDzGU/Ch/LE2W8hTT48v2EiVR6DI9qY38QiMmbTvmnYB+OUEenlNC8YQxh
         NHrsijCCcQ14mybYHZ/dXZndX7ASMgOHRyoomvkkCcKvSde31GtTCN7VloQO3+yQC9ui
         a5YO16iC2FVeNip8gX/dHScFxTBif8FDJjXOa087P25ZtsvQMxbMvqDZtBEcq16ZLi01
         o3a9lXjnKN8NPu0ZeByyIdcKmKJ6W6p10lU1ebgKodYbIZ+LFB2TLWq5fyNd0tq02787
         xBYMs9Rvs0DOLXWF5cL11oXVjh32z4iMYg4gOYLweTHr6/QwHuv50qv2W7jbUcp7i0qS
         FZXQ==
X-Gm-Message-State: AOJu0YyNusvQ5KVwlCP+24f2k8x0iccPQfZQz4bq0BVFisubUgTv+3Ie
        ZKW8xXVqbe4BGPi3LxzM3Qhr/6ZnQOWe9NVbsow=
X-Google-Smtp-Source: AGHT+IFlSd4M4f9h4XhHCPxW99K3g5dTcdwVKKOFnFzgm3FWCU+oaqjyDCgmSCas/3F7i/lOzxlxIg==
X-Received: by 2002:a6b:fe09:0:b0:7b4:2e28:2343 with SMTP id x9-20020a6bfe09000000b007b42e282343mr10516554ioh.1.1702397532654;
        Tue, 12 Dec 2023 08:12:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:12:12 -0800 (PST)
Message-ID: <8dd78791-bc0a-4aba-a205-003919164834@linuxfoundation.org>
Date:   Tue, 12 Dec 2023 09:12:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 11:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.68 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.68-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

