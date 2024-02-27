Return-Path: <linux-kernel+bounces-83981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A466786A0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3061F24140
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6AD14DFE7;
	Tue, 27 Feb 2024 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLc9UKy2"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49852149E13;
	Tue, 27 Feb 2024 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066068; cv=none; b=gLN93J1vi1CaQjhfXaeP8BNnzLDQDMjxtl72Y+aK4eLqYUOXhSVbcoHFS6B0skI8aBVnh2GfmIM6HGdS6iLmtErVVY1lMySlV/rEHerXJ+olzEmD/WbWiHyuFhHb//h9HeFb3GWhni51KSEPbv+jWILTq1TqqZNTgcoJn3GMlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066068; c=relaxed/simple;
	bh=f3z84LXBnZzBPTb1qf6WzHGjUhjJLj8dRujsavxbKpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC7MBKCf1xM3Pfehjq9N2KUmoluOeawWpQZVu60DmfCxodXMUmZvaEQyitjLrCd3EqILmegn9ZIysZ/YfUxhtwIMYLQkr52pnjW7TM9Oz5LzdooWPqw0SPpkyQkRsE3UWxmtdJkC35et59xWk7r5VoNnDR3wq4dhWGkLPzIMAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLc9UKy2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c1a1e1e539so2820746b6e.1;
        Tue, 27 Feb 2024 12:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066066; x=1709670866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mK/ZFrnnYw6RSzivQhp5csCqakE9t+9sf6LNYK8Z6+8=;
        b=FLc9UKy2SE44AqL0KBPljJMOqO97Yp7dsL2iueUlh6Lt1M8hHg2eSASE7X770z3K55
         Z4P+Aak1Sc2vy0PlHn2RRoXGZwXfpXcKGdOKd1PpzAwKLx6wLxiLNYhRTEF3147xZHYI
         Xetjt1M7iVw5cXBnpcy2Oj9ZZdBjV8D07xCNVNIEFsY4ZCBVbqu71/wzla6Sv0Hfd0hV
         VzXf82FQMoaG8rsj3PET95XHYlih9FmFHnl1LHwPJTU+cMnvNa9igMhsVOh80o9WRM/o
         hRHPfbNGH57zwsMJcMaNC2RxsQLveEIByFQHvmy80dIBT31go3PYh7wAuehIhJhtN96P
         5nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066066; x=1709670866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK/ZFrnnYw6RSzivQhp5csCqakE9t+9sf6LNYK8Z6+8=;
        b=FF6uT36Qjr99UXtDEEpS9pevM2ct2ILaebMlOXgaqrnps7HhCZIGp8H5Oi6TI1jWZK
         7ylqJigCstbYz320m1zsSUtiFqjz2erVS/dDDxKxq8ZqppqOJ2yYAxJGYD+rQsKEVorY
         S4Btb3dMwtqFGf8oWzg0JzVmyVOFzIyaNT8ulshXzvPpuyfWLXhDHetoEss51oah8l2r
         UOg48IA3v+5zs9X78xA9LMC/prNcv5ELBQk9QcHy3oHplZf6X3TVEw84dSiDyaBJYFJ/
         lvvNna4R8yLbsYB6O/sLHA7MWQRCL3uNz+r1XzNPmEOakImUIUurmIDpYfkyJn19b4vP
         a+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr/Z1nXSHZAwLMKSfzBmG0yYKO2cyYT9M7k5sj0gECsjNBL19Unqx/JBeVgCsq49IwrUsDvX1LQwvDziteV+puXSXW1RWT41XgQ4/kdWkGV7+cidM7oBQZOXSImqByz+DtgfBo
X-Gm-Message-State: AOJu0YxNXeiCqVePYqzm1raR28qhjwn12axGx54ButvgFTaYzHKAMSWt
	hnppv2397mmk+y53bo5EOJdwWDv8k8IOR3t46UmKp2gk6RQg9pPi
X-Google-Smtp-Source: AGHT+IEcT+EhiyvnVNxO9WJz91kkjHWjzkOXE0F36aECFMQ+TegqvIo8lOT/IQRlb0m7cfwCLt739Q==
X-Received: by 2002:a05:6358:1222:b0:176:91bb:9600 with SMTP id h34-20020a056358122200b0017691bb9600mr14704650rwi.3.1709066066189;
        Tue, 27 Feb 2024 12:34:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j3-20020a0cf303000000b0068fdc6f89cbsm4484480qvl.133.2024.02.27.12.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:34:25 -0800 (PST)
Message-ID: <58ac5eb4-3412-49fb-8682-f8959772aad1@gmail.com>
Date: Tue, 27 Feb 2024 12:34:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240227131630.636392135@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 05:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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


