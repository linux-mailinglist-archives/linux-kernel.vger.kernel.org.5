Return-Path: <linux-kernel+bounces-157363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8491B8B1069
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68285B276A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C916D304;
	Wed, 24 Apr 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My7OkhPf"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6115ECC7;
	Wed, 24 Apr 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977886; cv=none; b=tCy5arxEXQ+2aE9enlFx4Sazh6ITAzX/ZjlI7LLdEig/nF00uHpoGruUzlFU96cBoez5EfYEyorTPN1hV+GTYTztt93dH1n6oBgQ3JFh0i4x2Md8e0Eb1wPxwzGL/OqTv8uWR+pWP5PjD6NG7+C9bUJjZLZ7KI043lbswge7O8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977886; c=relaxed/simple;
	bh=e5ZKVeNtxf1w8OFUtdCpUboS6VVKv8i5GD5AF/b5/kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLJpTEe6WFf8bQ/Ij62whRbcXdC3A/leoWTAXrSOZW/sa5X/dEsXgJqrnYO5RxWifsGZUwunZQHI/Iziz6/gI4dB/ddrBIdTg9pPgshRgu3tXproI1lXjknikTqjGs8eeecjQMjpBy6HduswtVEO7qZdDijPfTr06BAlO6hA/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My7OkhPf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e40042c13eso126445ad.2;
        Wed, 24 Apr 2024 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713977885; x=1714582685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsZtiOHkbqirmmEckPSW+sQ0iABPhXuSiVY+tOMb7CQ=;
        b=My7OkhPf7KTOsGow3Yoio7YWk3SXXwRo58lnGsqLLf3n3b2AP/omhxEZ4lCN7TdJg/
         Fe/klmGUILBQz0qtWCowY8Yg0nnhXskQIJqnCV2T0iYMAp5dFoMsaX//RpxaVE462d3h
         E37/f9heaaXB0Mu/Ded3zz50wQnWS+ud67REaTjPRqy2D94M0SZZwrwizQCHhVtT+k1N
         2XkcUYeqi7cUpNiEi0OBNukXHyi1x+VuCeLnobqNIIZXITPrX4ymmOttqDUnqDEJMO72
         euKNyVwhrpVHM++QVGC1YY1Es18RrwyNW7icC3HWBfj+If7hwBV7s2YfDK+BN6LR1IGM
         SFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713977885; x=1714582685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsZtiOHkbqirmmEckPSW+sQ0iABPhXuSiVY+tOMb7CQ=;
        b=Iv2zHhOmGyAo7eeM00LvN9VuVHy2M3Msx21Onz19zqvlRYhVWSNpph/FCH4l6+liwN
         iizAAkMhkWVr3Ww/Ub0pb+LSzXXeC2PZPExKJ1xhrfVLe0ZdF1bjGRa+fUhJdZ2epjfn
         cD8zrdtukPvGmtV5WJQYdoLAPP/Q3kYzO+WOuRIGiiI5rJpBrolm223TiyjaKt2HSR5R
         S7sj+3bXjvieJN+8eHmwe6ppeVytOKz6gebEgY4pS2YB7oqD60KdXjmYmsm34zVenSi6
         MHWCjyu6jO1jrzoIAusH40s6NSguK3PxPKn75T8+GEwuAvMxkko/XE3FkFKYoeeJfYYK
         tljg==
X-Forwarded-Encrypted: i=1; AJvYcCVpN4biJUITTSIZSjvSk90IW+pO9f1pV0k5rbVb9oXacOlRAd6fXkwTrHG2CV4OJde+GEDYKKuXeAnjRfpqNmXPg52BXK5geFxhJWy5NRgokK7ImS4lUUafAX5buqnSFJt3O82H
X-Gm-Message-State: AOJu0YzGAV52OJf9RAiZjfMYInsBdAPsIxKprz8Jf9TH+MyeBUX7QVYb
	tHKgSbZcGCZQQ3Gfvz0gX+bo9b68OKDYwAyczWuVGXmaUwd9JnN9
X-Google-Smtp-Source: AGHT+IEDAmLGW91gRlRzuilWNOAMiR2h1TzrI0u2RLbDoGK1arYKxFN5HzbL4kNhu4tg8oYNanSk+Q==
X-Received: by 2002:a17:902:b587:b0:1e7:f944:b000 with SMTP id a7-20020a170902b58700b001e7f944b000mr2792857pls.24.1713977884786;
        Wed, 24 Apr 2024 09:58:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b14-20020a170902650e00b001e5e6877494sm12369676plk.238.2024.04.24.09.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:58:04 -0700 (PDT)
Message-ID: <380cd0a6-0fd3-4200-ba43-7d3b92b894c2@gmail.com>
Date: Wed, 24 Apr 2024 09:58:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/158] 6.6.29-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213855.696477232@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 14:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.29 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.29-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


