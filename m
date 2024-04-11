Return-Path: <linux-kernel+bounces-141536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5977E8A1F85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A20D1C224FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A915E8C;
	Thu, 11 Apr 2024 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1b45qYR"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B013FFC;
	Thu, 11 Apr 2024 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863772; cv=none; b=oBr9HHMbBB2DRA+qohZTOhK5uZFFvHpcpHC2KuZTqfj8qd325MEZED7HaB+jTBPc6pBhoX+BeERWSodQ0T6O/GYCbUUQ2tVhoEKQpV1yJabaGzZg6drNhP9iDW2kQZL2+BS0HWpVRtC75QNK/RMwUWDr5HwpmBYvHo9ORaQXo8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863772; c=relaxed/simple;
	bh=0UZR6CKH6h178zPDhPDB3a2CrnZFz+/8Wj1C8d4j8Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/wtnVBneUAKn9IyJpLO/+zz3mdHdXay8utPtbqRHEuPo8wCUWQViI12e1vPTTVHyRaul8bTYmEEwoN4jfbBHWeDBrEZFbVBSrBhJlD/zaRyCRvPgi9pKzpBeUdkTeVV1RpWU8hUfGYOVRY3uwB5Lu//nPmJZHIurmIymnSBA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1b45qYR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso229387b3a.0;
        Thu, 11 Apr 2024 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712863770; x=1713468570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hbi/5jt0y+jOH+G5BmgxVz/BqPv9rK9wWbxiYNwm7pI=;
        b=T1b45qYRl0oQg5gnCL7u6MSbo696dZ1Jx4kYUtzK40o18iZEHvSxeZIKWpYAwkwQfn
         xZUCInfzOdRVVx7mhDcpxFszpTLzYANGE2qFV1kjcjfg3sQGzSgTSqZc+gIqz6nKPHqn
         EMZiuXT9dZDZbZt+gUP1RRVTNeTQPZrE0/yTZOP0eS++W11UuxgWchNo7iNS/GIgGl/f
         Iulb/QJzKth9b2tkuz2yIgAaMHdx1ElbvN3UggcTU+lTQVbBocw4KFWDBrStW49/TdpP
         bvmNOaZ7jymBZyO/CoMfLj4UHMFfOPyLRBeDIYDZ5J8Rgc1tnYUt23WwiG1kU7bnb3pe
         24aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863770; x=1713468570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hbi/5jt0y+jOH+G5BmgxVz/BqPv9rK9wWbxiYNwm7pI=;
        b=ZVF5lPay/t1iMxV4dEnBIb3CjyWJudwPmgvXOzRfnohIjBq+ZDKgQUGeo7aq2SO/wB
         YIlAzE4k+ovTcvaJhM0lpbrDqqzppcJTm6sLQ+zw/083w7mGximDESMz2dystT41qkAg
         6AOv6Rt+T2dJ/BD7MO73g0/CCb6ueY8nUtustLx7ba0T6VQt/33rcxM6oY5DZH8bgzFI
         AXLaGTB2h12OqjzDH2bgFYwMGhjQ+Y82nuug4KuLXFBqeT8SIU3BPFSU3YzViiqRMR3j
         q318hhxe/1+NlNGfWkM5ncdtqkmbT46KDDzvb8fbqipRLiUX6zhDuhMQWJdoV8uCIdHH
         u9Tg==
X-Forwarded-Encrypted: i=1; AJvYcCU3fDi5LrlEyyXVfiQrZsgiIGP3uP4FTNwpcwZ+Ax2CI1hi2hMtxksI9HfRx3MjYU/0+XKxk7cGKhNBXg0aShU6zy2NkUfbLhdNbecnREcCEax1D/HVGz2seRnkBkKeHhNuiCt6
X-Gm-Message-State: AOJu0YzZGMWEAhyDYjq6BmTfa1KMThbnawsei7PHisw6a/QesrEQQew4
	PiegvUUJoQJBfctQjjnMQYoIvLvssNibqXNOyK0ypuuEQJg/JRaG
X-Google-Smtp-Source: AGHT+IFw//f9itzpMOGLKU905z/0fvYX1JVXRIh5gvwlWskL8Pa40IN8Se8iFkXz9sLsKjror/Wtjw==
X-Received: by 2002:aa7:8888:0:b0:6ea:8b0c:584 with SMTP id z8-20020aa78888000000b006ea8b0c0584mr780753pfe.9.1712863770306;
        Thu, 11 Apr 2024 12:29:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id lc11-20020a056a004f4b00b006e6529c7d75sm1537850pfb.3.2024.04.11.12.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:29:29 -0700 (PDT)
Message-ID: <42230b1d-9e52-40c2-9875-2f88098e2ae8@gmail.com>
Date: Thu, 11 Apr 2024 12:29:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095412.671665933@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 02:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.86-rc1.gz
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


