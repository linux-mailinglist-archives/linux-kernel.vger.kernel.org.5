Return-Path: <linux-kernel+bounces-15905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE55E82356A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904511F25B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102B1CA9D;
	Wed,  3 Jan 2024 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkHK2Sra"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533DE1CF81;
	Wed,  3 Jan 2024 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so3261040a12.0;
        Wed, 03 Jan 2024 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704309338; x=1704914138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUKrvnDKVUQB/NUh9WHSZ3lM3rwikTTA7m5z5TfQ1LE=;
        b=EkHK2Sran3KbDSC6Nm+9jZf1mG366I3zFhRPiN01KQDZm4oXZ804Pdxakxgl2X/PPN
         Fm64PQjfBOsXRLsZZcmtZHYzW2ADh2chHPvqnidixF969qXt6VhQPSCRUgaXEFqk1oM7
         Zj4jsOkz3KMDx0lA58rpvtFb0HAHaW1lg3vyc0RhSp2N18qPrIjc3NzhNh8ElhyOEkGr
         1jWTW3WaceXOyTPfR33eddWdOB/igS0B7YMsqjILiBdHZMQanW45trra+VGq+Tmr77GQ
         xXzlYtZUbqWMxHLyAtqaPl4sBDoWd4UACgvzwDPWxABbnGwnFBIrL99Ds1hY0x+st0WD
         1vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704309338; x=1704914138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUKrvnDKVUQB/NUh9WHSZ3lM3rwikTTA7m5z5TfQ1LE=;
        b=CFSzNCCNaaQDCBndUMfDq7s6+l9OLd3wtXLAnroUPkgv6cwH3zsw/OBn6Yjl0VwyFk
         fccJUuNvGvWPy1inig/G0mt/p7hBC51mBAYjGuuF68j7kAzNz0pa7lW2LEZWQczScpKl
         TkefAeyvHh+0Peud2LL8Kvip7pnDQl4nCUY7a0qbylWbGg+G4GzMjZrVWEKD7gK0zLpV
         P1XHjWtgJikTlRPteQvlrRjN4fkztaNgdvTVkSds3f3tyyVMcBnf+QCkpGtwNVs0781F
         4/ET4uGwWc3sBzZ7oof2QetkY+QgyyeFvFsVg+A/p5gTRPtRIy8cvukieUNLJ7UNIdtq
         RtTw==
X-Gm-Message-State: AOJu0YyPiiFG6SgWAFIwjpVF09iV5od0NCFGfnEXUb+ScFKcUHY8LFmz
	TyNSISd8j46vglytytb7uVzSH+2zJiA=
X-Google-Smtp-Source: AGHT+IHfnT/bgD24BwhFVCndtsgTgB5xyFndtPtFp1nVWMlDecJNekMCkFq98cxglhWyQrPm6JMZIQ==
X-Received: by 2002:a05:6a20:9717:b0:196:e00:29f8 with SMTP id hr23-20020a056a20971700b001960e0029f8mr5935741pzc.32.1704309338505;
        Wed, 03 Jan 2024 11:15:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id du8-20020a056a002b4800b006daa809584csm3473076pfb.182.2024.01.03.11.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:15:38 -0800 (PST)
Message-ID: <22d414cc-d2fa-4323-8cd2-61476e28e0eb@gmail.com>
Date: Wed, 3 Jan 2024 11:15:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/75] 5.10.206-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240103164842.953224409@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.206 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.206-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


