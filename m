Return-Path: <linux-kernel+bounces-16136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD8823980
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD67E1C24ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76E1865;
	Thu,  4 Jan 2024 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KqCSyVhB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8141187A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-360412acf3fso1765195ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 16:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704327359; x=1704932159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFW5+JN1e6baQduS0ThNTE7VOfQRI53oZNpXeXFaA/4=;
        b=KqCSyVhBlv+peOKMmUgg4mqlV7nznVqJz64NsofImAOHVdwhF01f51hG/42s6cxqma
         kjehsErrZDt87a6rN25+e05y3wzwhxLI3ibcZYhMjJg43FeSZ7s40ZNXJuR3uKLXq1jz
         aRfbYDl9/1JPq3zgwx9ZQ7cWXXNHUPdYbRbHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704327359; x=1704932159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFW5+JN1e6baQduS0ThNTE7VOfQRI53oZNpXeXFaA/4=;
        b=ngXvvhdo9EIEWydhXC+2v9cKtw/be7klEp8g23WByAgvFIvKcTtXNOMxSwdx6Tb7Ad
         b7Gjz5BuCbavOFArMAoOJYMg6S2qL3a1OfI9k1sUAlj7C6d/IFrW069ZZ0X3/xI4WAoq
         TmBX4cwAPgOYqc5JSzcgAKJh8k083Ofpagwp3uKRTdSmFfq7N1U7NfaLiT/C+GYrj5iC
         p38j4rrbyThNxl5uv+nnAaLHnHDRm96VaCpTlN3QL4Ip+vVAbyL6TUasI0o09zL7bjIz
         F8rGD0djaNv++UMxhV0MvAZiHRupVRMJwFdhW8sIPUYL6TuRvOhFEu/Lw/7LZvh37ye9
         tD/A==
X-Gm-Message-State: AOJu0YxlvL66+A63fp4xfg4TYu85LsyODaA2OQbz8qVcZ0oZcdWRoz1n
	uIumd60QFt/U8M4yVtg2McQXBxeLTFcrYA==
X-Google-Smtp-Source: AGHT+IFjaX8gCUTNVn3Fj4E2mRZF4HJJTFO/WtQI41RRklrv7pjROSYlKsWpinL0cNQ3AGhshhJqnw==
X-Received: by 2002:a92:c26b:0:b0:360:2a3:7e5f with SMTP id h11-20020a92c26b000000b0036002a37e5fmr27774755ild.2.1704327358869;
        Wed, 03 Jan 2024 16:15:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r5-20020a922a05000000b0035ff4335bd6sm7147343ile.19.2024.01.03.16.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 16:15:58 -0800 (PST)
Message-ID: <89dfaefb-973b-4d41-ab2e-32fcbff2782c@linuxfoundation.org>
Date: Wed, 3 Jan 2024 17:15:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/100] 6.1.71-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 09:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.71 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.71-rc1.gz
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


