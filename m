Return-Path: <linux-kernel+bounces-75695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC88085ED7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C484284552
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D4D12C549;
	Wed, 21 Feb 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf4S0x5O"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A612C539;
	Wed, 21 Feb 2024 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559919; cv=none; b=QNMZO57ehXb9OuS2erebGemwn+CKHuRGY8JukdOQ1bePmqwMhxLQifOfgdQAW2rO7Le8b9fUgq/3ytdlhUXCU27N4BwOhrjxD75Ulffz4EuH38PIqzUXXzfYh5yIrH7DvPBMPInlwhQR/FBWOpyGGJ/W9RCSq8K/QE4+Rn+m7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559919; c=relaxed/simple;
	bh=NjHEsS63nxugBfuzRK3toKI+rQRHzacrMXIMYoWFJ2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWNiFZzrkQMdhqCAjjaKm5BagWAQ0DhYHu/bez1K/4kBAlA3tjfDRP9LDM5Mw7OglgiV7q5kiEr7q5SFd9J6vYQ6+Ief+ko0+DRRWe/Zbw4UhEPk30jbOnvBnzxAGd7h3QQvKxAyzpkQQkRpXcAGCCVCE2IV+66/uwyKdimcF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf4S0x5O; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4b978e5e240so576137e0c.0;
        Wed, 21 Feb 2024 15:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708559915; x=1709164715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EP0KhQ7me5uYGkPq+SVmWVeUELHXBfsEoRR+81Wyip8=;
        b=Xf4S0x5O2FMdbOCOBGCNdCfLisexMrxW5wlwTRf0bVif9kogy6Uu6OYN2w3arA2G/q
         bMK6hCNuLm+PNIE+ew14mubBP7SXT/+FDL8VTkbqkKbD64Rn2FC4fZe7GoutFyFt8kbs
         bG2XW8wooDvALfw1CZjH2ksjafjD8CVfjKXFiIRybg4YtQFG9W3FXTHNSFUOUzGPFORN
         YglcmwCpvOSVHmMXHUuOHxD+5BbayaZrGx/5+2Ewd9XCPxFYWvtWBAsZJBscAf9R3h4e
         Z8ap5P+4JNsjAW9bN5wNDRbBBRGK3DYs7F3u7Q+Csx41Ij8HnD8a8U4W7Kkz9jBG11Xk
         TIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559915; x=1709164715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EP0KhQ7me5uYGkPq+SVmWVeUELHXBfsEoRR+81Wyip8=;
        b=GYAe1sFSbE7L/n4cG17CLWU/F4gvk9P2IXEZPl0H/YdmCOIc3uoQq5N+90vgKSScvR
         wMje3/aU6CWnIFA64VdjMHWjiWol9yRyxjrPMaYX1BsmXKcwb3Ybe6/u+d1TYGBn8MQj
         WOVnT+1tIbuE3uwx+yJh1Y7yuG99J5zuTjPjaHbvJx1HiBSLKusISIFppJIjKaHca4pS
         O2wH8I8QkizZSvAcb0w4oewBfb2OJ8VmFAr8P4H1oriL4Ziaq1KicyKzbrWh6mOswiqf
         HPg5CDNwm98rackaQWS4/L+Bio1oWEJbsVAP23zWYBY7Oc8w3EE2pChbVUuV9kWCaK5N
         7UUg==
X-Forwarded-Encrypted: i=1; AJvYcCWQoB130AcMBev3gJdY5hQ6tdua6n6aTsvqG+UUDSuii6jFqBvGGog/nudWjV3uZj2Rm86VrHIGd3vlTJshevxhzlpBwJD3JbQPkMIQs7cB3+Pc8wjU89XdY64+8At3AV6IK+NH
X-Gm-Message-State: AOJu0YzgHPUzIS6ua6j5GtXRwVV3jVNct3MXFoNZNe4K/7B/xsOzYO3j
	agX9Vj6EG6NUpQimvQ+WMtVvTOPOuii5KKC6wvn5rLGXtT+IGd89
X-Google-Smtp-Source: AGHT+IENn9yK4/uMQmv06gzZbnBeeYU5yEghu5HVKlU8WptLqR1Yg0RIQ0MmB+EAwwuafjTgDx6jHQ==
X-Received: by 2002:a1f:e602:0:b0:4ca:80c5:7544 with SMTP id d2-20020a1fe602000000b004ca80c57544mr9019451vkh.4.1708559915320;
        Wed, 21 Feb 2024 15:58:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id md15-20020a056214588f00b0068f760929c0sm2496421qvb.71.2024.02.21.15.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:58:34 -0800 (PST)
Message-ID: <9a906f5e-4644-44f2-a67f-2960f056eedf@gmail.com>
Date: Wed, 21 Feb 2024 15:58:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240221130007.738356493@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 05:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


