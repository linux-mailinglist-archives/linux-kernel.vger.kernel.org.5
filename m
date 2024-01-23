Return-Path: <linux-kernel+bounces-36059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB43839AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C356AB298CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D82C681;
	Tue, 23 Jan 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBtshZKd"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D22C1A4;
	Tue, 23 Jan 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043956; cv=none; b=jD7wwzaSNcQMoXvNS4swZcJCH0a3Ip4KkyOtzHSMwMAvI9eMopYOEHpU2xzT1ojm/M4dQo8jkJW4ev7z8JbTv+nM/s/kABl5BHlyEi+ZFygGnlenG8bFGQVwS+70UlZA0lgHh8JrN9Vi1EZZxiYL9TdeVgu9RwyFuu8lo81a0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043956; c=relaxed/simple;
	bh=LAb9jklOkanwcFSMqF7FXyCYHPIYqxV3pCk8iroPxPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjUR6RJGfzbVLz8glClYRXmJIr4nbn0W7XWOIUsEgvyhGAI2siHDWBFM70VrL+bUl9rzd+Xk8NL28yuJz9t7eFKi4IRbMSzIdmW7oBmifrQFSoiJWPYIBT/inLI50eUbUeUJaEBAJrquEnqAigydf5wNBmdBGkXnZ3SCDckO5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBtshZKd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dd82bfa998so850066b3a.1;
        Tue, 23 Jan 2024 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706043954; x=1706648754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7hK6N5tABRAYF0lmWIqZBB5CM9z/KRtcPvdR1T6JwQ=;
        b=ZBtshZKdLWuayVUhqbq6Fz4Ct96/t6405cDyoYifZ5XLTWbZG9dGQ1U6KK3ypbpopw
         jkBgMTLdM5lqYdi+0mTayT8ysZ51bRFqC5NFla1tsHVJVqaXpmPY67gJn7l7RVIqobhp
         JnBMhxxSaNKpRbdV3OdnFPOmd8atdty66tQuIOpx5RYkEa1HE40O/0IWeC0n6JqYHLd7
         jrQ/dbBxM9zeUGbv+gKvwPsGC97DTnZuVwrAkG6V65yl4o+16vKrM7/0QOHa50plBLh5
         PrGBp7+aYBb/1H/l0pppSy325i3ZKQNS7oQTxoYP/jPzs27sUPXnO9ews+CexxAcnInb
         bSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043954; x=1706648754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7hK6N5tABRAYF0lmWIqZBB5CM9z/KRtcPvdR1T6JwQ=;
        b=RK+sazfgK/lAkKG2da/2kB0dukpUxYqaZZz+Z+UD9zEQjb3G/vEnNPOT1Gi+GS63VB
         VnUyQoza8N/K/pDn6vSeXKjtKoMvYQqw4VKwZc0VwT7AhURQmXAWXf5kDgg2WREYaiRP
         dv4n0Ry4TAVM3olQSuimXrbzHCT9su4t2ZLQu6XLUM2mdQ/WC8AAXoxwRziXenwpdi24
         f4YsBk0RIBVcQlHy70USHFuWxbFmv1L5g3sBwfsRBLBISFup9C6R7R/aZNKsnIYfSEAY
         1fr2hgfXkYV3UmBTih2c7uhsPk0YiGA4M5qrQ/HYzp2cHAooTP/wOxa6KOGh8PlG2mFa
         qAnA==
X-Gm-Message-State: AOJu0YykgUfOA8dD7LU9YN0Wie3DBQhIWEJ3dfb0JrCOgeCBBRHMc83W
	dBN+0Plp0xYbfJXS3NoQJWefZCWtzzsB68ZwhyTva/vIFzWEj6Sm
X-Google-Smtp-Source: AGHT+IFCQdc/lC4369UHbvonoAAxgYklZsl5CIX6YXP3UXsjFiYldD4A7+R7kQnrxOMVaJbFsL74TA==
X-Received: by 2002:a05:6a00:2301:b0:6db:e463:96d0 with SMTP id h1-20020a056a00230100b006dbe46396d0mr3570881pfh.55.1706043954244;
        Tue, 23 Jan 2024 13:05:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e2-20020aa798c2000000b006d97cc5cc13sm12140361pfm.8.2024.01.23.13.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 13:05:53 -0800 (PST)
Message-ID: <c8aaa17d-9e3e-40ef-95b8-485007c48047@gmail.com>
Date: Tue, 23 Jan 2024 13:05:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/193] 5.4.268-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240123174434.819712739@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240123174434.819712739@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.268 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.268-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


