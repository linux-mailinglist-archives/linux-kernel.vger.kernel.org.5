Return-Path: <linux-kernel+bounces-75670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B685ED2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DA32827FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A0212AAF9;
	Wed, 21 Feb 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGRvRsks"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B281752;
	Wed, 21 Feb 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558880; cv=none; b=OXE6hX0I7ffbMhERBC4xI8o3+KAXAzH7gqBX8CxPbby/gltcQ7tfQAfdq9VWKxBR5LbDE4U4uBkLaabjr8k7GZikw6MEkrTYZdLsANo5SlcoUztwm61KwcaqVSSbuxP+ezN7WYUYxn7Sft4CoyvA1G9fHhW7nroihPE0Fb1jUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558880; c=relaxed/simple;
	bh=peA9XfH82m0PDu+D+3ZCMjMzlRV6jT/mQwz03yS/uF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTict709vcdKN6xBShDeFOYMuL2GGJeZK3udb2PdF/rLIiIwrdBzmy+LVnkanjyRomq+G56xbJR5Kb5rz5gwjURLKEDGQhcMxrmyPr1FtDcmt0Ry1K91uuWwABOK78b+BRAzODuOIWFvm5PglKC2DXEodXfuWLENRTrTsJcCLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGRvRsks; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4560664b5so1129228b3a.1;
        Wed, 21 Feb 2024 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708558879; x=1709163679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wn3lnUr6QvHlVk0vYM9gSiyKQ1rcyaC3AxclYDdvOE=;
        b=KGRvRsksz5AQl7JKZ/XJ4z5jq3YvmS/9QfbJiUXTfp9E4kFT9E3LvCsX7B/7Ajc04v
         VTP3Y16drkYOu0hgryfwv7wEpx8A4CgJvL+GMJKjrO5w5MDrUVZshrvFxojLCvhI2mpu
         9UCVM8iqXG3B+bCWRzoPj8ppexg3hJ58cykPcdqNaYhkSaqjWJnHRMMBD950IeFHrkN7
         fsr49xalwXA6jiZFXbt8DrY3o9WPpLLUorQKGoCbvO3s7TNKP0MmUjVUsJFDpXSuTqwW
         qXSCmLNvmvKBSealptK1Bnmq/agHKNFW7IuOKJCmkX+jtIIV2IWDb+R0ZMIW7qqhRD9B
         lmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558879; x=1709163679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wn3lnUr6QvHlVk0vYM9gSiyKQ1rcyaC3AxclYDdvOE=;
        b=SbMlcjexqetMCe9+haSm9aXsquOMxN40toW9jKJjTrcb5Dj08/3iP+YkkLLSYsmpG3
         F0hsZsS389qoZrQcoRt+PXuckAkZ2V1UDXpw2oAYkWrf/63xrKOwxOPNImvesJsvj2Kj
         lfWfvpOgxNLtd6bIjMGq3nbqJL4gWBfgKq1uKqj/0awI7s+tsGyB4f1x4RJHUiKwcbP5
         TGSvQwKxsUERUbl7b+8gRWOwiCB2V1eGVkhq+h2sOhrjS8bKe9c3SoQQo2x1iraaiuoV
         gEg1+hRXB6ro1G6gpaXOPpn5ybO3lpWpAaqRD0XFZvKTXj1OJBt0yEFx8X59CjgKOB4c
         ODUA==
X-Forwarded-Encrypted: i=1; AJvYcCUuhUnEm5gzDzlKA4kB5UGxkzRBhSutblV2y8PtZgYW2wi56bRT2Y80JZbfD3si1K6ZnEvwv5MeFWa3/wnm5gm3K6cC02qvZnSVBJ5pHvFOmjZJ0ULAPqbKafnBDxlEZkp4jkTp
X-Gm-Message-State: AOJu0YwQdVqP6xCA6nIkGhi9K3H80mEegZ9nbRcdeK1XN75WRzWHFPAD
	62vBnkcH6wdYc8PcKbjZYU38IMN5GqLhzmOwJYEmcG0siNqbrnIa
X-Google-Smtp-Source: AGHT+IE4OsDUYJmlhzfSnU3fjQT55rsecC0mb4NZ0MRKrPJG4olCy8r0HlPJgm4UfflptFVs5PlLTg==
X-Received: by 2002:a05:6a21:1706:b0:1a0:9391:b066 with SMTP id nv6-20020a056a21170600b001a09391b066mr15253871pzb.35.1708558878754;
        Wed, 21 Feb 2024 15:41:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g5-20020a17090adac500b002989864e50dsm676669pjx.0.2024.02.21.15.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:41:18 -0800 (PST)
Message-ID: <8f70c289-8fc9-4925-a3b0-feb928259b6d@gmail.com>
Date: Wed, 21 Feb 2024 15:41:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/379] 5.10.210-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240221125954.917878865@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 05:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.210 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.210-rc1.gz
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


