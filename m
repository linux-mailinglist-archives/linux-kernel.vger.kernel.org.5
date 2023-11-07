Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE97E43A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjKGPk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjKGPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:40:58 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85DD95
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:40:55 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35950819c97so3879985ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699371655; x=1699976455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tz/3EAWv61f6wEBvRr3aAF3KcbwKrMc//gR1rrcsb8w=;
        b=ZG4OKm6zMrrXdkvuZ0QCVXeRczq2fmT8EB5BUSJjdpR7g0V4HOyYn5B4YhWUutTqeQ
         5Lslwl8VRDivK96GSmAt0R/e5ulKT8d+jzUUOofS3t1gSDkv0JXYje3H8e6ULAx3B6hR
         5nBWCAviP8VK3dbcO6O64OHhXWd/k8KCVBI8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371655; x=1699976455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz/3EAWv61f6wEBvRr3aAF3KcbwKrMc//gR1rrcsb8w=;
        b=s4g3CKDzQE1a4lUMo3QMo6Vx+AhdojmM/EA1mqR99ptKEErcTtkxIiRIl6N2Ky84iu
         C8PVCAJ0InpgM5blk7tBmzBA+14D+3TXm69a+/I6t3EesJm/t9Ct9YYYdVZgcjLK7E8c
         cyQtxVfe9fUH8p8mQp9TxuCtNWT75Da3ASkp8ar1QwvZJV+lDVtAP9Q5Xde8B7aQAg1D
         E/cCNsmxAwxQWTxuRWEg35tAT5X8NX+d8Qur4h8NasTFD2LY1LXtQpQNSZ0LDBzy7Vz+
         zmP8H5wgaOB9zO8eNCSkVUVIuIVvl+0BpWRKBQEqkGXf+ESyImAe24ZB/TxqJtXHp8mv
         y79Q==
X-Gm-Message-State: AOJu0YzKJKPKcbR03Hwk60GXyv5R0RqXTh4X7QT5gumb9dxY0/UOU2+W
        lw0xJ3XFF+XjIMzixGS4CAdSCg==
X-Google-Smtp-Source: AGHT+IGQAWYgGlHvzGOchOtYfwGf4w5IoTPD/+kKzlZTcA7bY03Zr+sGBRvCeJPucCtA1SCy16Gjew==
X-Received: by 2002:a05:6e02:168c:b0:359:4db7:102a with SMTP id f12-20020a056e02168c00b003594db7102amr25003454ila.0.1699371655252;
        Tue, 07 Nov 2023 07:40:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f8-20020a056e0204c800b00357fc1e2ffesm766889ils.23.2023.11.07.07.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:40:54 -0800 (PST)
Message-ID: <48432650-09c9-4cf6-8ec7-9c4577c18e38@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:40:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
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
References: <20231106130304.678610325@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 06:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc1.gz
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
