Return-Path: <linux-kernel+bounces-66168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2F85580B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA01C1F21DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84C145351;
	Wed, 14 Feb 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq6FjHT8"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669FB145339;
	Wed, 14 Feb 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955053; cv=none; b=FN/9f3lNlXtLpOTdxFEHQukQEA1+mVfrtoWXDxS//LDtp6mzonCK1m8++U25j7nKHfzn/k0IWPiVZiG7Ih3QF3Cz89r5e0DPHIpqf7pzRZMtvrONVrVWW4n8EHulpOtXU1MxdymWV6JiXor+JiV45najg5oE8La2839Y/WXvwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955053; c=relaxed/simple;
	bh=VqSJFmpRhmAQYjXv/G4gNLTLSwvkjnB6qhWoxX234c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUq+lIMXr3vIjqKev+y4p0jpA1XOXIKOLKkVA6sy3rbMmbuYoiUDCZUGjECiua2zguWdh6n8UFD/80v9+QwOfWU0i78S5mC8dvc5CAkvzVr8QauBPKHXbtmHFMLMTlu3y7rcwH1OqFj742Y1uVzpqHFfMVEn6Wy3xsdZSiC9xCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq6FjHT8; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c031776e0cso344461b6e.0;
        Wed, 14 Feb 2024 15:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707955048; x=1708559848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezJuggmm91LEsLCew+tJs/aRiavsyGNCiHmODaOsV/E=;
        b=Xq6FjHT8ba8u03CYvtPKPIWkG9xIQvGU1+TWVM8++cnBRbXNvIzwAkO2HlqoIoqaKw
         fKSvtEvGVrfUBRQDbOU+2615N3gdOX92QDl3Km1a11gyCttDFB9RI4ji5dXbns1T68eg
         Lan2dWFEnjJT5GOoBJl9ZodZhzKHaTbPJrddlEEVBIDl2fmhjGxqjq6h+g+Hoz9jD2UW
         Te0Z66LPHftV5gPlkuEL6yff0NB4i9ueicfJ6srGXANpmysFYPESeOPrCB7pvSNh8X2W
         WT26ovJLx1ULadQFpVaMJAQ8mkYcAA0iUIG1LKILvaeRAXgS+dytl5g77ux4FYaAU+2h
         5GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955048; x=1708559848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezJuggmm91LEsLCew+tJs/aRiavsyGNCiHmODaOsV/E=;
        b=rlC5IRqpnNG1NHW78tYIZdLFoKlJ8rFWFmNQOgw+g9oUwqChvZbQAxdwVSDeDHnV0n
         nHwOANGNmWw11H4qkusIzWr8vsBIGlin/VZMWJEBUGRgqHsvTGDaa0gOeeWeLMoJ+dn6
         bnk1xW8Tn3lp3Gavy70OLSvCDwlPmgquuhDB789GCtHCOwWYPo65MszTPc0sn4LJq7Aw
         JeaLBDeWYvlDcwVtMyhUfh4arY+shbD9n9x1ChOY53AQmO4Y1zSumZVLjutuccRBUNWJ
         YxnzmdhTXAJWUaJU1Xhg7aQQijpqs8TWnPJzY5SLfVtYCyrJFMM7ykmkL9ptSka39XFf
         6iog==
X-Forwarded-Encrypted: i=1; AJvYcCWBOKClKztFpJwuvwBbDOsTWoJCguKBN+hE2AViknQWAJYSp/97CaxxqphJhYFANSCWNXOLSNr2bePtPpmKD0gWjDR5nNcuGQRTGX6knSKCtWwzKhLIqmAiCwOos1Uda8s5iBlo
X-Gm-Message-State: AOJu0YyNYY2EtlJnDFkrg1bEwS3dgUT1t551E7oBYC+InWFTHYqkZ5MV
	N/mu6en0WJPTcZzeVjgfuZnV+tzOm3r+psMpTFTf+eHGX2G9nvgz
X-Google-Smtp-Source: AGHT+IFmteV6QcMkwcLvoWrAbxzXbTXPEKz8uD88/kDBh4zvX4Ff7Pu096JAki/XNnJe8oo8yXlF4w==
X-Received: by 2002:a05:6808:218:b0:3c0:3b90:ae24 with SMTP id l24-20020a056808021800b003c03b90ae24mr311493oie.24.1707955048504;
        Wed, 14 Feb 2024 15:57:28 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mv3-20020a056214338300b0068cb4ed4840sm78127qvb.62.2024.02.14.15.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:57:27 -0800 (PST)
Message-ID: <bfb2446f-69e6-41df-9fb3-10eb4308ea0b@gmail.com>
Date: Wed, 14 Feb 2024 15:57:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/65] 6.1.78-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240214142941.551330912@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240214142941.551330912@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 06:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc2.gz
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


