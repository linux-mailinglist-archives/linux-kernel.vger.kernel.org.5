Return-Path: <linux-kernel+bounces-75720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69B85EDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4AF1F24831
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4218A935;
	Thu, 22 Feb 2024 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkl9h2/K"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CAA35;
	Thu, 22 Feb 2024 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561501; cv=none; b=dmGK76qewutXqLLLN3ykuGm7EPy6J/hU/FTWA041lQzgvDuMspBxV1CTcCXSqWU65s3ovQtcBnOUy9GD5MHEogibeea/jQtCbKCKG2FzeUMf4hGdl/nShD7j6LRsB2TECnE4yGSToRvNo9VZufVYbVVlh34gmxLj0T1dahY1LUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561501; c=relaxed/simple;
	bh=6cM1nNU4sUYIudgP5How1TvdFL1U8i4R9xzk/u45MW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEp4ZTqqp5CNe+5WcSsURNnGSQpnBGsiJqAhQcAddFSKh9PAqon3tKK73BVI5jZb2KSbNdULmr0XrlyEVpnQqI5W9/uxC6P7PSfLIuL9L0LYnmpOAKgsEqqDmgkZhjEXMBdkT2XEL9G8uTZME2ydRmKIQfUqe/O6uVlWKeJgZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkl9h2/K; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68f51ba7043so31252016d6.3;
        Wed, 21 Feb 2024 16:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708561498; x=1709166298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anqGFlBV+rsLg3vMhzVMgDCSwtexSsDpUKQLzjs1Ooo=;
        b=hkl9h2/KRoGtY3ilhTyM8pdImGfzthuwP6dh7LPfEo+1RJXvhOt8XMk1XQcyXCmTCx
         0fjfmZnMOa9jgvYvyuBLXpKpTucoMQSCz1OO5aXdeU/R5f31nrJikDE4qq9BmY3OOQ5r
         b1iPAwFpzBb4zCT2DqLtxVt1Zb+K3arFAsu6kqQfvzdzIJ7EZpEW2YEPWc+4R1hYkjYJ
         LOVB0+1j6aSksuXZbEk5ZbtSf4AOn3NjkEVIefI3Twu5eUIZu0vj6/qSnX+z+/Oks3/Q
         fV3++Lh1bnIudDCMENorRPymbJAl5UDkluSisl3M0DBSpFxLv6EAp1e/iDpZi1N1tWFG
         E3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708561498; x=1709166298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anqGFlBV+rsLg3vMhzVMgDCSwtexSsDpUKQLzjs1Ooo=;
        b=WxX66Nb+na9my4n8bs1oSVt/s57E4IHwOTw1AfBhwu78OBvYWtkpiSAx6hXPxEv9QU
         /AMQXMZpoVt3Pw4NTJR5ekodrBV2MW/0+W1MGbhq0v8JA6n2PmBgITWcb1EUu1Qp9pIu
         GHs/MqdwBe65KJnUCtYmRrfdLlEqpjycMPX0ham3dvMRERqjLif5+b88iGlR0XeCnOmx
         dtNca/XoMGZCjlMvtXRNojONKBUnpdnNyT/V1Y1847mOMNyP5SGTuyb+lqudrXbdvdin
         XiJ1b+wOgmdwFtfba7PenLbpZ1Utij740kaS9xidOYKWxq7C4uA407mFAovAoVWBKsbP
         NehQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEg0s+wgYFUz/ypDdI5Edo4sk3iz0eMg4z+cdu5BR/w63uzuA2gJTYgT+3Y/yW9sWw0MWJPK9kGYQ2qI8Oh08IY+c5//6WFQOXdN0BOW6EbFJZA4ycxF6wApVnFeyurwBcP++6
X-Gm-Message-State: AOJu0YyOb6GXROsWRtxfwQXIjcWjTKNgzAb7fP9JqrcpKB+o6+sOOSAX
	43HSxiEqP7WAG3wXZwOwRAMsDFhkRaaeoRkOEXuQZ9r2+vCwWAOt
X-Google-Smtp-Source: AGHT+IEEGx4qOQu1n7xW61AL2JSTReDsufs5qC56cdZ3yIFGqrRdkeZ7gcw9oBgnuzV4cOIWbbFgiA==
X-Received: by 2002:a05:6214:2422:b0:68f:6dc5:149b with SMTP id gy2-20020a056214242200b0068f6dc5149bmr10959031qvb.58.1708561498418;
        Wed, 21 Feb 2024 16:24:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id db15-20020a056214170f00b0068fa7e73367sm1160611qvb.42.2024.02.21.16.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 16:24:57 -0800 (PST)
Message-ID: <58d5141a-6813-4831-ae44-9ccfcf79893b@gmail.com>
Date: Wed, 21 Feb 2024 16:24:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240221130223.073542172@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 13:01:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc2.gz
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


