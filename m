Return-Path: <linux-kernel+bounces-145724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0757A8A5A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF85E1F21A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5D8155728;
	Mon, 15 Apr 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM0e58fZ"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5BF13A86A;
	Mon, 15 Apr 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206479; cv=none; b=DbSYpWwMCsrdKSxqciPciSQrb6/FjKrnMYxUrAC0AcZVAmmhpKJo98AE9LwBSrow/C6zmdPpB4DaORJCaSPsaPEeBbzUepd7Fy7iy0AIvMofawz8CDSatfazmYb8QUU3v+D1xKJgMPmzFqQB0MeChi7AVkgajWKetxtJvhF8wpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206479; c=relaxed/simple;
	bh=2ruptX+/9hWKb3oStP8xOxWrDxeGthrFWC5sxQMpkuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wzs40hQDtLhh0BkpAIeOWn8+VBJjO6Y9RXNvIGWRNcKZ+oKHIUjKg/KUA80RLHO1dZSb2qLDyOLoeL03qUYRiM/K/l9iq9+VLnL2VYAIa3hjh9eqnb2TOCgxcI6dTYHm4EORug878baoy7PVJ8dWL8IRIf1glP3vhsyPFPDTJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM0e58fZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3560859276.1;
        Mon, 15 Apr 2024 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713206477; x=1713811277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6P13yPcMqifhtf+m3GgrmwXTdYjr1GqnuIG3EWkcI=;
        b=cM0e58fZ4SmFx0VDLJTnD6PSir2Sz4GarUb2HxrPVI1/SWCOKJdG/Mh8g/VAxN9+bA
         6/Fds0EENUi1ePlE18nwRl60QjAcydsCWn4QS3KjW93uKVE30A5inMyl+AK6jymrmT0o
         T4feXAnR/vDhGCSCjI6Oq5TZSQyS6iOQA+fDGTnBdE1Ys8FvMSNa2JcquHmGaNeL61BO
         1eaGj0PPoVNNARiOYuIWbUBeIusLduyUfR5h3MZWQF7GFgPzGiaGXLZuoxeB6ftKjI4h
         UaVhgeouEwHyNIIQ+A+kkCca9RcY7YCf3CPZ7rDDFe/nplXvCU56ph3Wd4U15rrz3v50
         n/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713206478; x=1713811278;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly6P13yPcMqifhtf+m3GgrmwXTdYjr1GqnuIG3EWkcI=;
        b=UvcP4p9+fng7oYZxIkdo/PcZ+ssWz9vRSZqje90ktxEqf9uCK5wj+xYqXe/nZKwptl
         1FDn+vk+tfjbTEBgEw57quMmQSYn81JH023F5gjTLoYrQ66R0WyPCO52AOzSB65VoNfu
         13GleIbl7v/pQ9aDfZ74cF8sL4/IQMABSliSfqvZSX+Ovu8f3hmmcPVUeywA9wLoiS2p
         hzDdbG5lnmU6GnILEB5qWN3GzEvRggj0zX8gisMpIIcVd7eQ55Ub0zjuGEOgGUUlfb4f
         p5uMTAk0PpfT/rTi37B0T1jQ6gCM784XVJ88bwSsCzKnqBVKtRbEjbyN7yERXrSimNjJ
         UqUA==
X-Forwarded-Encrypted: i=1; AJvYcCWnb2M3oKxMyJ8ozp+otGhYa8mY6bbMKJillfzeq0sfy7UOjhXTWgWSrr9m/3+urUUYKVLh86/XJsXsvIkeUiTfUl8YvXzy9Qy9BCloqo8LxKgFyRCKo6REv/sgxeYULuOjQjvg
X-Gm-Message-State: AOJu0YzVdBJCIvMVd0ARaXZiLDWJ7BEiwtoZm1o+E5RHm/CCvANy1cEn
	X+JVvNUcrncmES1Is37LelrksT/pV5As3DUFbZJ42zRTQU2AwFEv
X-Google-Smtp-Source: AGHT+IGP/uVgNEMB9YuK+XS3yWg0wA62IO4XRQxZjXZw4SOvexnDeJM5wnrRkLQHw7XO6StDLRwgRg==
X-Received: by 2002:a25:b7ca:0:b0:dc2:421e:c943 with SMTP id u10-20020a25b7ca000000b00dc2421ec943mr8964930ybj.42.1713206477525;
        Mon, 15 Apr 2024 11:41:17 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id l18-20020ad44532000000b0069cc3a02eebsm104859qvu.4.2024.04.15.11.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:41:16 -0700 (PDT)
Message-ID: <1ba6c65e-5de7-4b42-85e6-979c8845abc4@gmail.com>
Date: Mon, 15 Apr 2024 11:41:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/172] 6.8.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240415141959.976094777@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/2024 7:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.7 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.7-rc1.gz
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

