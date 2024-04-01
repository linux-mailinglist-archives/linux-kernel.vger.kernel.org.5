Return-Path: <linux-kernel+bounces-127043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758AE894622
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162651F23351
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E328E5490C;
	Mon,  1 Apr 2024 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoPSAsag"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CD5B05E;
	Mon,  1 Apr 2024 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003663; cv=none; b=UFYfrC9TIpyPIfxa/F5+Xjaoho2mPr1df5Ex09txbP9w6jF5VbrBoz0aPNTM36Jk+qXtMJmy0RrWXJS4ZqOiffQV3j1uD0z+Od4DTP+a8mXfIBgwDfSrc1o1K8fBRPaRWJc+HIWzS0x/zSBVnOL5EPR0Xzomcs9UhrKV7z7RqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003663; c=relaxed/simple;
	bh=IXvnhxI2pXQ52Hg1YEyiDW9h4z8TaCL/BxY7wfJZcS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIvePDtif0gkgWcQA+epRsXTVI2RJHL2sqfqGOvZ5kxmLTpmeHxhVJxyWnQTcbOJCdWD7MD2uUUGVmvnpuFhPcHrhVhAdIBPK6f4YUwf+r/gXMLOFyqcUMLXgfia/Ff8FSN1dAjY2gRf4KnXM4H+7SnmjQit8jHw6xnMceNQc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoPSAsag; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2559fe607so8603a91.2;
        Mon, 01 Apr 2024 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712003661; x=1712608461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FwFD4JYxhcIwnfKCG0w6eqnbQcVPaedMXbOYVzksxk=;
        b=YoPSAsagXEVv+Jc7kP6MxShjqOdDqe+VO9aCpRwi/5RHGM80m26EEfM7HuiIpmeBjD
         1WiMLuqg78XtnHcAgzZEAuU3oR83kdc7AQvSjRpL9Cud3Br/rKr7+Wb6H4UjnCXlS+Bx
         VTlG+gkGeOPVzC43eQU0M8mp69rh/kA/2gcdO9m4B36IV18ACJ1Wn1OCqd+0M7g1GuKM
         8PjTMBf0mo7pO7AtMeSWhq0ZEoamLpaSWMjzxtS8RJFggKonCQCwQpkCTKeCKZ2dwZ/o
         8nNPIGO9s70d/zt+oyJYFJUh/rqwGvH1t09dS3Hd83ghpdr7ivyKi4+wHFHRjPRjLgRS
         qHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003661; x=1712608461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FwFD4JYxhcIwnfKCG0w6eqnbQcVPaedMXbOYVzksxk=;
        b=iR7zHqFiiyzbBOlCJvPNzktlIJzpG4VySeFm04cjmmtP9UOuFq4XnRAsOoHaJp4h+J
         jLnGhb1E2s8zKT6xxJ/W2yDbXzSoRapXCMT2t9YCrTAps7kaB8aiKLacbjlriGMvplXL
         /0/JJXNKS4EJdhjVqoT7z/LprwTXuaIayOZR2JtLIv6LaJpWdtzQFS9WFu//yctJLcyN
         couxiQQEnemXltNye4QBBq1GRFPuS4TixtcpOzSxPPJoM2ZRa4YMO/UzBOr4bj0E0e+7
         Cx9CeQhfM9oGTihtW+uuES50wm6OEIV6uMWAjao8p/I4+MJYYP5mZAbUKl8cUNQG6XMC
         r7bw==
X-Forwarded-Encrypted: i=1; AJvYcCVijmAC6hI1rV/YvudFPTiltf5agSF79OSHNzv95cuwh9Aj6iQOxMTdtO1hOlOUQB/WIjAG0/MxOW9cWGRdbfLncycK3uSBquaqPJ8kULba3mzkxj743HSC7Utpdf5M2II3CGsL
X-Gm-Message-State: AOJu0Yyi1azFuVEiK3zfRl5Ggk1c4b2pJGiIM9vNrNZPc8HQtE9XhVvk
	VfNcytFS/6om6qKXPQjTy/3r3J1TeVzWrAxWx0qjeAgpC8909yGf
X-Google-Smtp-Source: AGHT+IFTxaQptQJCitxa2lQjF/XzI2d/woGr+xEoVq2OhhXdQPW+leNIfgcvPM0k+RuUFB8jtLnLHw==
X-Received: by 2002:a17:90a:5c86:b0:29f:67ad:7db0 with SMTP id r6-20020a17090a5c8600b0029f67ad7db0mr9768772pji.11.1712003660956;
        Mon, 01 Apr 2024 13:34:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u1-20020a17090aae8100b0029b9954a02asm9598386pjq.0.2024.04.01.13.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 13:34:20 -0700 (PDT)
Message-ID: <4bea0061-09e7-42ef-84b1-735682c5f65d@gmail.com>
Date: Mon, 1 Apr 2024 13:34:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152547.867452742@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 08:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
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


