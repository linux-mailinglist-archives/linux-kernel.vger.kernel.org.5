Return-Path: <linux-kernel+bounces-141640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C208A2116
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDAE285035
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0733A8D8;
	Thu, 11 Apr 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/tSb9n+"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A42942D;
	Thu, 11 Apr 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872054; cv=none; b=LggN4+xjZDzwVO+mDmROSwryf1/Um3PNR7OOlMQqiP4O41LvYfh0xWYBJdB2Yq0BDN/gLnnlY7Hu6VULA9Yk8yve9XfYqBVWir3/DqwerdA2y+1Vty97xSbgGZx2ndyzOzw1WxKv2TbMqewpJLlmNGFkENPZ7I9Vcy2FJxJnD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872054; c=relaxed/simple;
	bh=NiiW7HlO8jYMlaSPOm+tGXTrPK1xT3n2rILXDAH4rJ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RnM9r04U/MA1cS610IIxrg9AOhwCgDrlWC8bGW0Qm7b79Q9o+hNprbxnlyH97adET8cl1r3P75TRrVOumDoMCpXwZazVGy0bE1ANVmVcM5d0DZ32kvX/8RKxu7A//vFHO1vfcwfqVWVE2TiAd93F9czt1bAONJrmgcnHzfinpss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/tSb9n+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so854765a12.1;
        Thu, 11 Apr 2024 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712872052; x=1713476852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ddxa7Lm0V7tNQ5Yf2X+O79t3Apo9+QNjaVHgEzh5CP0=;
        b=X/tSb9n+65FbFQKn2F47FmHcJ4Ii/+uZTw44W48HGzyGKLYJZ5Mc4rHlJWEywa5GmW
         spNFM/aXmI4Nw0N4R/K+zMaD8h+k3KmKaNSNG2kHl7vizBWOgqAHZuSEWBiqMjDlzBee
         1mtTA/B/L5xbEqtzCSn9mt9ipkO9qmyB2Wy4ccRqz3Qo1vw7qOc+GbeW1oKxQDnrPW4V
         Nk0gYPoDlRLZMWDJowmcqqvz1RRCFs1uLufbLhkx3YWjNO6ZRsoA6C3Mr39QTNsTyom2
         CMqEIlKKiHuv4vw8F7yfbTw47RRIaTVQw4gDcNInSGyFrTRw3lzWSJUg5jLRkSObsZFI
         93sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872052; x=1713476852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddxa7Lm0V7tNQ5Yf2X+O79t3Apo9+QNjaVHgEzh5CP0=;
        b=iNqTjAm8hZHn+WyZnHdwJvctqC4oaBEjETA66G46uoXT1iZCCcgY9NYGPe4a/5rkl5
         A8N9rL4exzLrGuorVxSf00FLl/E53iIbk7Bs1+rD361P/ZZ1mG6kHCLNm+Ylh6Ahxf7S
         It2OfwTDRynOEeBmENEg+pJUX8uwmXGfZTB8DlRnTuvJ2Ie5qnW/sxPhpfqxWBA2fA8n
         OQKJFmpqgvRpFrNOj0VyvUE2QdGLeSkvx5swdFjPHL0bVzDJxyN/ifPM78kwKchBj4WX
         r64t8ZwTh8TtUcGmTm/t8yq5Jfw6T4WAS0/ORzaT4sLLPs6oG9tqL6NUtozKPHGigWRY
         sLlA==
X-Forwarded-Encrypted: i=1; AJvYcCVpl/W8/Jg7TCWIONRRZEIquPRBBCuGUaarIemdZuNf71v+gEr2AuObcavWnrQPDANj20Ef9ATCe9WfRdhgiuZYb9ZRg69GxkLNOWs7jWiWPd88vHNPCkpcMwWqKExEa4J3tYql
X-Gm-Message-State: AOJu0YzdDn5ixb1CcKHS6R05a6ZhuWlm4y7BZTR10789uZO3AAXbEc3g
	A5u9jvcVPkjFcbtzSsmd7GboX1i2jSFcHRtvFIEO7qNmSZ7MIoKc
X-Google-Smtp-Source: AGHT+IG3OL39Tt2WbCq2ZhAMJutPEfrY2ljQNwyZVPQVJHZS0Yl/RyrZAznhXxuy4bMat415awG+jQ==
X-Received: by 2002:a17:90a:bf0c:b0:2a5:e055:88c4 with SMTP id c12-20020a17090abf0c00b002a5e05588c4mr4915966pjs.5.1712872051716;
        Thu, 11 Apr 2024 14:47:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a9-20020a17090a8c0900b002a058159ff8sm1582146pjo.8.2024.04.11.14.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:47:30 -0700 (PDT)
Message-ID: <c52995f6-20ee-495e-82a3-4e4f12c1fd5a@gmail.com>
Date: Thu, 11 Apr 2024 14:47:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.6 000/114] 6.6.27-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095416.853744210@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 02:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.27 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.27-rc1.gz
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


