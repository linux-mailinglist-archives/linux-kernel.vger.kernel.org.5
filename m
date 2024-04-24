Return-Path: <linux-kernel+bounces-157419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562678B116F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ED21F276BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19416D4F6;
	Wed, 24 Apr 2024 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GInyvqwn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFF16D4E7;
	Wed, 24 Apr 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980824; cv=none; b=sXTF50K1m/x+YvVLLEijZS8WXyllZSshxXe1DUJvOAWktVHNspcEzV6ihJv9gmlzEb6/nbEa96iG/x8+Xa6VOtlIyBh4KWPATgxCOYtmFbjxd+6Uc2MjLdc4az6XP+sI3fZ28FEcbBjBUMhvdh2GKMpSNfDORcHsOxMqHZAZhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980824; c=relaxed/simple;
	bh=3ulp/AFGfJ8TKWcjkvSHDpHVf9ob13UZsZaRg2nTma8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyYGoxtIqU1jT6/d4cpjVnete+px8WvTFMbtuxM++SuQJlLnxmy8NxXvcq/Npn3BJve5Tbcx9Dq0cGpYpVEjI5jRkjp1UDndpLehiWq6uwdX0lRJTWWsgjHnJY2/Z63nyjMOQm2DDUTVqOWTRnSFmXkQDhA+Hy/92IRLkzjxXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GInyvqwn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3c9300c65so884385ad.0;
        Wed, 24 Apr 2024 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713980823; x=1714585623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AX3wkTmJw2SYmJLJtHNaFQxm/J59nt6zUunS82mxxbw=;
        b=GInyvqwnL3NrHL9KTNxMbesoZNnl8qM8/QtV/crrJsUon6Vd5QYN9wq8hYtkQnHYWb
         TugonxTFvrHtU4pbBX3Wwo2v+/Qe9Ju9q4FaxenWfrAHiVlrO7hDb3BpYQrBF+GCp5OM
         KGPIzMoA3nmYVFyZ1C1KgMwN4mHIxmk0qeoqNLuhtAL8D/LQB0JVJCR/kNzChNdaXG6g
         RSj64Ketf08mYiICuNaszasAbUf7+lak+p4BnjOdA5w2WwM3YedzuhZa3ggg7XDc7JI6
         j3H1oOEyiERNKTV6LzMQcILhlqSMencqq3DIszf6jbMbSRgorwXn8w9skS5CWUUz5Rea
         zO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713980823; x=1714585623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AX3wkTmJw2SYmJLJtHNaFQxm/J59nt6zUunS82mxxbw=;
        b=JFX+UPRPP5cY6fk5nxyGlkcn18PhLQ4hFnJlX3dJM2+lkpAnMaTBF7IeIPIV95Px6l
         9lIZFfI5x1v94993tLGyR4krfpl9uBNcYqtOy7Pf3qIKMWhvp7gpGqGO70Xj0fu+Gr18
         xKn3ut7VSeMffAulygd5R/Lorj1rU6SWN3QElCs/HHxXYhOP/ZF/50EM5lcKFfNFPRnT
         qyIoawOp4Dgiibj2K1+HCm+wyVMzAhsV84HVaQ93oCDJTaYKzK0NdOlYpx3Qh0fTK+4t
         ndqMNGKyIvLFm91Kt/rUc9oywUNsDZ1q97tu9Aa02E8K+ZTGT69OlHjfFIKlqYp+bWfg
         /tgw==
X-Forwarded-Encrypted: i=1; AJvYcCX5DWqN/uGGFYk5OAlQaBYQXG9wGIhSa031ZBPboZqPP5tbGu3q32VP2kL4yncEWm04JJI8SbsrYzo9S76TpArWq3Ozgi2unPrj4wefPXt/WrhDg5FepnlTO1FGsCidmGehpx9I
X-Gm-Message-State: AOJu0Yy6YL9OfR0Af2wzncEwEt/5E9VnnotyNp6eeb13BtsZKIyigkR1
	VnIgccCskDcvHe76nr39iNPg4ZYscbkiwVfKjmkDZ+3YtnQmG5Ak
X-Google-Smtp-Source: AGHT+IGGiyT97MQdP6BJF1NJUmX2poKgH1hddx9G83LT+ayCELDcks7CSQ3RQMz0/xD82c+XzI/4CQ==
X-Received: by 2002:a17:902:ce06:b0:1e4:9c2f:d4f7 with SMTP id k6-20020a170902ce0600b001e49c2fd4f7mr4146620plg.28.1713980822718;
        Wed, 24 Apr 2024 10:47:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d10-20020a170903230a00b001e8b81de172sm10577801plh.262.2024.04.24.10.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 10:47:02 -0700 (PDT)
Message-ID: <276ef4a1-6477-4e3f-ba8a-ea3127edb6db@gmail.com>
Date: Wed, 24 Apr 2024 10:47:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213855.824778126@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 14:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.8-rc1.gz
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


