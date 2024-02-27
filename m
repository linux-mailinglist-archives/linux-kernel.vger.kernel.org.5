Return-Path: <linux-kernel+bounces-83928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABC86A02D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FF1C23F07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649F524D0;
	Tue, 27 Feb 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifsdkVcA"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60544149DE2;
	Tue, 27 Feb 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062053; cv=none; b=bmg4dbTkLZlfCQBHbJRT6Rx5O/Pixa9RJQds6rxn5I56Y1RhpTePDT98bZfu1DaMx39ISUuTDD+QQ6jjxj3niTV+De+hstYpNpJuQyHXHtA79u0G5iBPp22kFK6Zo+VSJw9+dJr7oxH9hg9Cl+IUoynKIpPSLIo1kiXLRkiEqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062053; c=relaxed/simple;
	bh=XrtQdVMbRSzYjsznNaecSFZDnk2DEQW08+pU7w7QjkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbzPlCw7sh38YNWPD8vojKx6I5vgOO+yxT13eWpc15fj+25QIzsB73Drp8JlwC1amGbX4EbDPdHVES3naACXXSn5iICiCJHo8P4v1DG3PlJXbj0wYUSlXp6NNNR+a68uyoyD3W9y5hG+zA0rx7VuTuiPqhCC/c58Itf+un4IAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifsdkVcA; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so3816995b6e.2;
        Tue, 27 Feb 2024 11:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062051; x=1709666851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCrWUksx7vOTzvehmJl4wWEPKb6RL3b7eNiwdpGdi+k=;
        b=ifsdkVcA8ejXY1XFazfUhHmoGg9xrF2fxAR+T05EK71wuyVTp1cZaEnoGRmTkwB0S6
         Kxg/HXnQ5nqQhaMSiT7xKWDpdepcIe0Yiu3LVjBmguDBHckdc8dfUrm23AxQ+TGK67tt
         PLxVeQNcvovJEKMce2860F2OQZ7KnzE4kGUoHh7aQwAzF4q7mgxUzqeFe4Up2bbd0y1d
         pLCzvH/SJY8HWea4uyzgiOkfshTN8y+LT7MTUW+i3EZZVHhmDeT47ShDjMmq0FmpgtZ9
         TDePxMPFcmBpIB49OZA/EZHJiHFU/OlOHMWarSMTe2AQP+wnjoOLQime2PlH3Hz9GUHa
         wPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062051; x=1709666851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCrWUksx7vOTzvehmJl4wWEPKb6RL3b7eNiwdpGdi+k=;
        b=DZqeKMhQ3HJfwxvITYEdREp0Vj+c6/afQicve+J7XW3FXj7q4ZOU3ifLlG9TsNWrl/
         8tbF+ZxsAIizZ2R5X6xCooFSk0iT9/CUCfUwiXIAioCk6C9zEnE2Ix6qXGeqbNWX9mDz
         cY/ZnNKFKws4BLGzLJakiIeg7Rlv3sq2vek4thG61kCGuBOicoTJYDfh+VRBMQagFC8z
         EYGQqBJzWzgGbilGVnEmcmmlw/9r0g560GZ3ezorT0D+yY7glIp3bgDSNpDaj2r1NBpd
         Zm4qkO9qFdKyEOuMPacVVpx6IAP+IoAR+uCIXsMu8WeVgm8w62rjfHo3FJdmhFL0f0pL
         7N4A==
X-Forwarded-Encrypted: i=1; AJvYcCWqnvfTwG/bIPpByEjunCJAB8KadncaDIoTdEm0jtmcZg+0er9wDwcxPvZhqtlwty9JWjGYOYTVbfaw0pltPtpg/y8dnEFmaCvCSXUdqsfCww1+1lZv85Y+LHXEsPuE2O1aJNx4
X-Gm-Message-State: AOJu0YyilnFldIlwb/kb7Uj+Kesa84hKGXrhSKRxZLc+RjZQzboiB9y6
	CjONDDdZHr/tiyq1RBDp5UPle3OmmGKzpXk8P+aJnslRwLDPG/tX
X-Google-Smtp-Source: AGHT+IGKqibhDTaKHF9hHxyC6qvdkGJmUJhcVVJrA2OOZkmB37nOSFGRqE279uAV1IDj1tnRcZlMSg==
X-Received: by 2002:a05:6808:1244:b0:3c0:4357:1d20 with SMTP id o4-20020a056808124400b003c043571d20mr3288891oiv.47.1709062051366;
        Tue, 27 Feb 2024 11:27:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b12-20020a05620a0f8c00b00787c1102df8sm3860584qkn.127.2024.02.27.11.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:27:30 -0800 (PST)
Message-ID: <10ff67a8-074f-401a-9344-2c19ede9f628@gmail.com>
Date: Tue, 27 Feb 2024 11:27:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240227131610.391465389@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 05:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.80-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


