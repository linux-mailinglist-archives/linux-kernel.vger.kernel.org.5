Return-Path: <linux-kernel+bounces-36064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8938839AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C321F2C198
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8673986F;
	Tue, 23 Jan 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFZM/XZf"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EEC2C681;
	Tue, 23 Jan 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044790; cv=none; b=pQYk8FfhR+ib4Odd5tYlmLiKa4yIibdMLD14E48noW3fgwMxm7WVHXk9zQ6D0x5BITppZNuaU4QSBvp4s7TiZSK2t4mOkb6HBaxtgC+Z8yjMXwwHnm2H3Tq48dOly0LeF2T7mMu8iYXg8od701r5pWAC6J/uNYU1a7GxSED8Pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044790; c=relaxed/simple;
	bh=VXPP3Yfv+aN5927BzSpWYPembSi2sAsppWfJkocPaiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVP7j3ri2AhQ4qNc146r1rqG+LzbE3wCGoZKUz2Fmc3y00iYvClMwfEf9UqCmw32hLVxEeL/G4ldNnU/vkpgfUQ0myRhwUpexRSrl8I48okUToC/MFHjq3qQJKOUg+ebfftbOjzpICDQXQLbKIxDZNH9MJDgjKNg4cpsDo8VgFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFZM/XZf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso2469974a12.2;
        Tue, 23 Jan 2024 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706044788; x=1706649588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Io8epyIIIUF8bbtlZ2MdvLDPjTnzIChAR6sGUafC630=;
        b=dFZM/XZfgdZ2eNmnAYBDZPWpyk4x/VnD5iZVMuAP7VO60GKN7Kwi9qWsY/BogACVpj
         P66yHZ13ZWGq+LAiRx4pz6MD+Cl+nvlRERZwE7MiNghd7+KkOCjpmXG+GbXC+I3qJ779
         DhyKDsmdaIwAVQKJa1HI7NDJS3FL42pGtsEVlpYox6R49QINqF4uClwI8Pkk+z28QiSy
         t0REoxWHbIIhh1mPqecba3Fi+BxIkz/aGHfCgHw7LilnhM6MkG77Ft67B5oOBR6LmQmo
         WeQ78f/weKYJ2IHA52YGWM6Ay5P190xzeU4UMn7yhiFcbzS9GojyBWcQmuS35GObHkfy
         7RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706044788; x=1706649588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io8epyIIIUF8bbtlZ2MdvLDPjTnzIChAR6sGUafC630=;
        b=ZFEtX7Q4j4OPUktv75wkL+pWP3KqG11MBTAFPKS+B4jN2Et9DQyLNQ+tpL7uR7ZZlO
         VoqMxRGFwyOjAkgXLnfmWKTWX0g+ZH4BnA9zdRYbh7C5R9nDKPTpYs62hHANsB4dQ8tz
         j1H6vxIrsMTAx5Hu5pNBnJl5Uj3TbVa7nuqnBoFRxtnO/wjDKCV0uu5DufmksTN9uZb0
         q/OEIKGrHLFxjeFPfZmR2njzFFG5OXIA+yi4QwvA1vuD48lCk0EaVxdX6ZG/kN0Jy4Ik
         bPXdDVuBDnZCIpkkg1vvpAFCLcd149PaeK97gxC+3NrhMJiSclE8bgckl9YdKEAR5M1q
         1/Pg==
X-Gm-Message-State: AOJu0YzrC3j2XTaXobCAf5puaqrVZTiJGX0ENrWPIhYcP+qolpHL6FkB
	vRoaSpEzpzXCcjTJXsoaSddjHeI7j8oxlE/bCp2CMDZE0oKsngnH
X-Google-Smtp-Source: AGHT+IEh48OvAcikgSeMaSejKjwWPjve5WVTLz/rCnmWG7U/d6hF4BScscCeT86idN2WSeJF0cHMkA==
X-Received: by 2002:a05:6a20:6da2:b0:19b:1eda:ab61 with SMTP id gl34-20020a056a206da200b0019b1edaab61mr2927864pzb.54.1706044758541;
        Tue, 23 Jan 2024 13:19:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q81-20020a632a54000000b005d39e412031sm1588892pgq.36.2024.01.23.13.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 13:19:18 -0800 (PST)
Message-ID: <c8ac1c40-3944-43a6-b64d-a9b9ec98c7ff@gmail.com>
Date: Tue, 23 Jan 2024 13:19:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240122235732.009174833@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 15:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.209 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.209-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


