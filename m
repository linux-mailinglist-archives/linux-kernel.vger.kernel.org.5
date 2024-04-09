Return-Path: <linux-kernel+bounces-137654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D7789E524
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54AD5B22ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F8158A37;
	Tue,  9 Apr 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y39dcCrD"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6AF1EA8F;
	Tue,  9 Apr 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699134; cv=none; b=fdX0LOTYdrf1WxfvTmugrBm958UVuK+MK1KL7pXfj1O62iw3eQEwX2ghRvIMBtNE3RVEXVpZOnvfoPYsxMeas2pIoGAIi8Yq18eu61P9wr464swdZuIQWQYg7hyKIh6hXkAfrtx1V6J1S8budArAxDNPjFMxOeK5EXN9m7MhcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699134; c=relaxed/simple;
	bh=BvDvYnOOXVplEXAKZS/pyR1MTJ4xfUq5mSJLxWWLxOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7rjdhcO+AGoOpmm0yqEAmLQtARzdTwwq8dgaQ9BMmEChoMhWHw8Y7mzhSKSgrWRDW7kLkhPscT88eSgAsRut/vyKvaKGt4TkkVtNBrxhV4OmroSCwOZIRPs0nifPG1MAfXh4IN7x+0vgBof5+WJ0ILDOVkHoIugAq4Z9SC7o8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y39dcCrD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a559928f46so1307649a91.0;
        Tue, 09 Apr 2024 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699132; x=1713303932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVtDfwwG8gLboGM4jqgJ+puQVYBzgA3lQVXohAbNgTI=;
        b=Y39dcCrDxkEbb87UMYJkApVHYwMTXoeHzjBGYPDB7fO68znjERmbzO5gTlvbhbmL8u
         LAGpa2GAB7orAK3kE0grER5YVO/ynKfnP52a0xzCm3Uucpc9DkELpIjQ125rtjzf5u8F
         opPdVPYGE/fsvKvo8N4isqKOEnjYAkECcs5GsNYJmnfEU+k7HMWhJ/KO31JheZMNmkor
         9OslkTrlCWGRxifcV6kCl3E3nxUmEii8W7Ps0Ln87Zj1u0U6q1pm6p8bs/c9IUNwnaQW
         07Qf9LRV0cYtBH/7Bbx0uebgIUkKKznqOsBrY7c3BFMREWsGGuiUF/ya1Hi72Imhn3fY
         U7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699132; x=1713303932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVtDfwwG8gLboGM4jqgJ+puQVYBzgA3lQVXohAbNgTI=;
        b=hQQWYoECz0zGipURGgj9NKMuPJDQwYJQUgqs/Lm3G+uYYBrESc0hT2RSoq0l8NdqdB
         t+k3Q2jZFDYfzmAIXrLLtgSgkhGVwPfeJ1mXfJmmku8uoSveVqgCYjLiE/o06gqZ3S4X
         eIK7zOvbxZk+xdfu3IwccE14VAOHYKTOddd1Zhk1oM0mBNrLS5l5uhelea50FVVVJNKs
         BeY5/YCGIAtJPbyhOdMoQvx8YZKFA/Hq8LKL9ht5s1xtznXtKMTyLANfpDWud7S1lvVv
         FrnmLqTq2EPvgDbXWwwpRV2f8Dm6C2FJayO5XvjhJg7Fljo0QRv4nZ/FzEvFT+MB0C43
         fb6w==
X-Forwarded-Encrypted: i=1; AJvYcCVePjLz2BOiYU+vhTwzhqp4PhueF1Ah0bU1BwdUetJ9ky+zgxKIG21w+RRWwJKJCWtc0aJyaVmxe5wLCnS10YkBhgaB42tkOdAQZ7282OYhTeboAdv8zovqPYC1F0AhBYaKgHE4
X-Gm-Message-State: AOJu0Yyt98tBk/LkoMapuTE0i/Gv9Df2BKurrWBUtJLY2BlbB7+TQxTX
	6npwA3z/Pq5o31a5hdCrSaLTQL1Ksn1O1nCL2zTsluc1k5Z/GeXY
X-Google-Smtp-Source: AGHT+IGq3sKA+G3xXmhaBew7ljkWLI4OQDEMZ/2WB/CMVm/z9wg/DswFuMYeCmjPuq067hOiftgEUA==
X-Received: by 2002:a17:90b:3cb:b0:2a5:3637:1968 with SMTP id go11-20020a17090b03cb00b002a536371968mr1002437pjb.9.1712699131931;
        Tue, 09 Apr 2024 14:45:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mg4-20020a17090b370400b002a043efdea6sm73077pjb.11.2024.04.09.14.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 14:45:29 -0700 (PDT)
Message-ID: <90403017-ecf1-40cb-8455-045bd04247e8@gmail.com>
Date: Tue, 9 Apr 2024 14:45:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/280] 6.8.5-rc3 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240409173543.596615037@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240409173543.596615037@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 10:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


