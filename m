Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F77E4369
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjKGP22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjKGP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:28:25 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5812010C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:28:23 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7ac830e8b74so56748139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699370902; x=1699975702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sft1C3A6T0DctjsOESWwGHV4ahcDcNNrlDQS0ASGVvs=;
        b=IyYZNXmpNzLHCqUTD4WxKtdhkgu/DrsdWUJ39IgXbqoZ/EQdoCpk60/zIQdo7rcLDq
         P/l91RS4s7ExRN7A5CCwxT0qQYcZgf9JqeLWLG+I4ge8xXAkwGyUAabGS4zvqs1VMPR2
         d3TLCAp/RBQV3kAvT3oMEHX1qYnA5RHw8GkcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370902; x=1699975702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sft1C3A6T0DctjsOESWwGHV4ahcDcNNrlDQS0ASGVvs=;
        b=Gph9qlHkyDMw+JXeLoJ12xKnuq/Q3pIULRI1+Rkrd0sFH6Ns1ZZrRV8O/88yV4SpUm
         odJIzKEX2DLylB59FkF0gA4yp5QnzA9zuQjOs3oRdJgNesbgZvo6Vf60fDDhPYFomEel
         L5JuR88d1dWtVhKgT3b2uROu84O2ZlBsp7oNRuC00cGpuQ1qtW0brTgYutLYN0gsLKPS
         VesHuo2BZaeZU7+wxLROfSZ791+hU9MNGa1YvxdNJrOTCS+F29BvciZbxloOwB6C05JP
         h/1F/rfnLXkIDYsQVn0esJb9z2XsOvVNQtLaNc5JhNdstNxHqgREf4fg7j2yqdHV4x/U
         4Azw==
X-Gm-Message-State: AOJu0YySxBKpBlMvsDraLDrNbCvFhufqnErSby73ta3S9hpqtWQ349Pf
        2HmOKjwxnQhcv1czGx/uZ8DyQQ==
X-Google-Smtp-Source: AGHT+IFU7vICgMkTp/5tRvxQt3mPkK29vnkQ3Rl/QuzAD4dk8abYYXL+kDAVSvhUUsnpGOyLf7g1jw==
X-Received: by 2002:a92:d08b:0:b0:359:39ac:a161 with SMTP id h11-20020a92d08b000000b0035939aca161mr18294494ilh.1.1699370902738;
        Tue, 07 Nov 2023 07:28:22 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id db8-20020a056e023d0800b003596056a051sm3201829ilb.71.2023.11.07.07.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:28:22 -0800 (PST)
Message-ID: <bc65e6e3-ac1f-44de-8872-13641cfa8751@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:28:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
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
References: <20231106130305.772449722@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 06:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.11-rc1.gz
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
