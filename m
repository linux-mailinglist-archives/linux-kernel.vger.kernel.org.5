Return-Path: <linux-kernel+bounces-137480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D989E2BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C062F1F223B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062D156F39;
	Tue,  9 Apr 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9l2SEWe"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1F156F29;
	Tue,  9 Apr 2024 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688340; cv=none; b=YsBErky24jDgvlaeNQ1VBCIaxVvPRCw+M52aoWabjhUbR+YcTKIdjbv0MO1BQQTN+ynoB5/INnyKGkiVSMFQSK3d5GhWUUq1r2PiVU6g+8PMopeytS48/CsXtO7aIR58T5bUBTiFPJksOkxShE4PsFg9X7Gt3QiAPt90spa6h0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688340; c=relaxed/simple;
	bh=aNS9kIqluXJjz4q/1vM5WvxRYcJ3Gjql5Ytlgs2X2rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vj13nB7d9UvIZtC/pcUQ/SSx/gmcQLZBileqgq/Oby333EH32kqQSU07AW98x8W23d/FUYQrAnDBYNlaQit743CUlc2+q6YMkJi2UYPwRsukjBAgmOyXanpEcvnXAfvxv1DcKMXlZtxSVu7H3MSssoqjX6WOn4cb6/m0GPuozPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9l2SEWe; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d735b0756so62279185a.1;
        Tue, 09 Apr 2024 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712688338; x=1713293138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7IjqPDA7JLGylYObYo4WBmijPb/Bsi4IHv5IPatn7w=;
        b=Q9l2SEWeFIMG55R6LK2WHaAMOMjdhtIPPnLtPV+YJCS8Vay/r0JvMMXE4ZaGU/Ieuo
         B+fkAhOoXocN9vv04BET2gS3qX6T2XEXYqvc7TpyeJppF9Cz/DxOTmI591R8upkfQif/
         r5iDOG2gMpcZ9FoEzg9+5mDyOVXRk4/jHst3bvMPE35d0kZ4lczzALXxVkIT+lksU2H3
         x3VUWstMF/N2LfAWBV02Cnp8HkXIudwLxAl8xRRQyYhQLh470OnzZpTwHPSgUNv0mFHd
         ZIW/64M4/hCdKrobPeZ08w0/r3x2XegTNSYVQdCchnZC/6ImLmECfrgCmjZEAMUMtdHI
         M8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712688338; x=1713293138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7IjqPDA7JLGylYObYo4WBmijPb/Bsi4IHv5IPatn7w=;
        b=WhFYOdvCqQgV8FTZ2RXHyy6YJx3iyhBN7BwmhvWt/myLGMsU9+6Wdk2IMXLAwzCIWI
         /sYh8E3CwRI1grmH4O/2nfFW7QjWSWx4CI3z9sf/rSW3JIHTeqA0Q3HM3DmocnubC10r
         9kfSIoSfl+oAtu58XmDLCLRCmY/MQTXlJinF1zZMFXPRvIkrvMG5bVxHNXICvy38KvU5
         X8zQH9sLDJ++2AXWZlBsB/cyARVBdCkwJigXptxmvpG4KtKv/lVnG7WUxtxv6F7GyHNy
         txI9YLZ0dksMMiwpo0XhozpwsTk4D7wJeveWQFCtw4+hwySiefF0nZryFaCky/prWLCn
         OftQ==
X-Forwarded-Encrypted: i=1; AJvYcCVox6xie16Dsec7b6GiQIZ4q5RU1PIJSOHmUhDKFvPstQlvWswzb02/2lqwpsOMy9vAAVrkxBYdYCzOgXcU6QyAJOKREUQBYiMjPITpRkpPNobZntzlanwQrBd5npgGIz7151Pu
X-Gm-Message-State: AOJu0Yyb2r/PdOjpbAIiBqvlgmK4KHGz8dshoYmPl4n1PX8jdEaxMRb0
	5JhOdGRex+Q6+CjENVbDOoNE11rLT35kcXZutAUawXF5g/WjMmQ2
X-Google-Smtp-Source: AGHT+IFTNJFcm/AbtMmQopn2FsGx3oOyU5YKw8xMOrSNNSt+8hcWvgmnGvlaykxLNYHML+N4/HtzDw==
X-Received: by 2002:a05:620a:2a04:b0:78d:627e:1aaf with SMTP id o4-20020a05620a2a0400b0078d627e1aafmr1028849qkp.31.1712688337747;
        Tue, 09 Apr 2024 11:45:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id de14-20020a05620a370e00b0078d73533196sm586903qkb.76.2024.04.09.11.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 11:45:37 -0700 (PDT)
Message-ID: <5c6196b1-4c19-42c7-ab23-133978f9db77@gmail.com>
Date: Tue, 9 Apr 2024 11:45:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/697] 5.15.154-rc3 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240409173628.028890390@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240409173628.028890390@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 10:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 697 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc3.gz
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


