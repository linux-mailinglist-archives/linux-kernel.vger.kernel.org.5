Return-Path: <linux-kernel+bounces-24131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC4482B7FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F01C239D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571E5A0EA;
	Thu, 11 Jan 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2oszTF8"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6859B70;
	Thu, 11 Jan 2024 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso4829812a91.1;
        Thu, 11 Jan 2024 15:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705015495; x=1705620295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zoWmFoYkKu4HBJVGwO275SshfSpYBWqc1pCmIP2iww=;
        b=k2oszTF88DADtVlbfJV0f9YhuMWn/gELTAxMYD/grJ41U7RTY2+8gy9aVrHzl4b7wB
         u80Dr+JjIJB0Uebum5ufn2plXaoOocy0xzJsCf5LWFeib3EFov6ALdyszbA4ELVPDyYB
         Ara4Fdi6vJUplK4DvDtv+lEHj/SinkJ0bjyu3xF8Cmay/G1bAGHGoP5/elcQEQv1w9Wa
         +XHTN7hWGRSR19nIaRPmxAwa+bR/Vns7hBnEaqs0SG+SB4Vz2SijWa1EEbO1/scgXXtJ
         kbuXs4aQO2M+e4dAGoEZD9pl7p6ojq2hC9pRQpYuygan2x1seRqn8NSsC0j47CJkWWjb
         jiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705015495; x=1705620295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zoWmFoYkKu4HBJVGwO275SshfSpYBWqc1pCmIP2iww=;
        b=vHo4LtUDcO6k++iUl11nUPCzV+yy2f4JxdTH1YMjqPQXgeT2VKLBG3sMzeA/ZaBlwr
         prz5iDz5rr1ZLF0D8apszeXqpfpMh/qTkricVQbpSd85xsXYxRfowcH2kfxHY7+c5uGv
         isuDDbjYcD9NW6nhSzfvbq3TRwE/EBhr6z4fcGMIJkEtsduVnm8ggL5ZpeqYFiK254KD
         IsrqjxjptpJC3GkE8dPCUV/7U6+9tOEPHLKSiRzcBwIGcKSCeZ2q3WSOqiRoZL98g18M
         HvgDL3qTuRoHiyUshk8RoSea9HP16Zrsz4zMllrv+xzn/hSNgblIJl+6IBYVSiDFAOvp
         QHqQ==
X-Gm-Message-State: AOJu0Yy+Y/61s/GslucLWe6Gp0sbOf/4SD2CkXbQvqPhI+wiO7KMX4UZ
	tOSReKIJX2KmLJBMpDLHzYc=
X-Google-Smtp-Source: AGHT+IGWZE4gB9+B2RUPYypL6rlRC93oxdf4Aigp9TozTAlb2bl06PhD3Oq3MZkBSEJqJc0a7CXCRw==
X-Received: by 2002:a17:90b:4b03:b0:28c:7e73:2485 with SMTP id lx3-20020a17090b4b0300b0028c7e732485mr2181349pjb.36.1705015495237;
        Thu, 11 Jan 2024 15:24:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h28-20020a63385c000000b005ce71f1440bsm1781548pgn.72.2024.01.11.15.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 15:24:54 -0800 (PST)
Message-ID: <29e54f0d-aa80-44fd-9fe8-311faf87cd09@gmail.com>
Date: Thu, 11 Jan 2024 15:24:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 0/7] 5.10.207-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240111094700.222742213@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240111094700.222742213@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/24 01:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.207 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Jan 2024 09:46:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.207-rc1.gz
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


