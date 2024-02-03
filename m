Return-Path: <linux-kernel+bounces-51216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34248487E3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C361F2460A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7205F86A;
	Sat,  3 Feb 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyK/1b+j"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A415DF07;
	Sat,  3 Feb 2024 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706980948; cv=none; b=qoLumFj3E6khKOO2Ikbu77PAoOdW25Q8W9W2jIjPUm7XP9xDrqmmW6LDSCE8fRO9l0tXGJAZS0I8PwQiyYgzh2M0vDSpkaBMU4H1Z5QKZJuZUSRSc+sjsOIMBEMVd/lE9qrv3s3RVaO8XChVpuGjX1do8XjtqSn2xSB69f+0ZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706980948; c=relaxed/simple;
	bh=r0Az24tQM2fEk8T5pbYkBZ/sgLSlycQdwIXMxWYMtuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBh4ijg9/yQvGz+ssDYnljJRYtTjHX3h5vrFDc/GZaaJun9CK16GhpVlIK6iCbhtqjldXBTmBwNUCA1OV0HQ0PTp3yc9CixRtgFNF+2V+WH2Ay/GrGeU2I+WPCdPlxj9b2qSJz+8/1rQZny5n13jfwbhnjVoAv0YvlRhoRcVOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyK/1b+j; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7858a469aso23233865ad.2;
        Sat, 03 Feb 2024 09:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706980946; x=1707585746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSQemLMTA4ltsDY8x47aFMp7z+fXsloI9Lhx8ffznVQ=;
        b=hyK/1b+jI/ATekELltRMAg4SEcDjW2hSjThG0S20wqjPi4IifVbHrAqSjK3k7ca7RO
         p1g9wJSK/W27jnEEiJJGceIZQQKgappChPGXaYI9MmA8HqNfVrbuQGLxG8PCw1Dj5Jkf
         UUy94EO9/B7CC8svyt6ljfKx2z7HJtx3Oq90xGlwh9awkKr8beM5ixGDTiJ/LfHdOeWa
         hY5VC4+u/nexZNgzWcoYaALxY5vRD9sbfiMZXh0OBbbCamBKseowypwHbe+gF4SYzFhS
         s6mrzFTtL19SEL7w5Edmx7z2A5AM+yhVBzByBbARZAC2XVQxViYjCki+F/sKhbOiN2c4
         rPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706980946; x=1707585746;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSQemLMTA4ltsDY8x47aFMp7z+fXsloI9Lhx8ffznVQ=;
        b=tUeSRZrffJFQa2fBST3ETrLxp/xim9GAgLcNXe9VGFnZvf69354cYPH/VH6HE9VnjN
         pvKfg2wuH7ku4L7jIHrU9D/GcrQDKiX+j94GGTYOzXobdACTqB0G094AzC+pFAvkM7hQ
         GBS862ydQEanFFYFsC8g8qQzNlNbEZY1IaQrVmDrVOCiBuG7/RFlyBgnRBrvnRV+0GTJ
         sQow+VcwLzLtTOuuhN08ZZvp6STfZq75Dflt2pYzFux5ijrlaK41bgMsXsJy2jGivy0x
         /eXdgmbfsXAXeIn/wpc5TkP4BXK2PzmPn46INaLMQVL6Xk+FG/Lo55G//laNpWTLB9v+
         qMEA==
X-Gm-Message-State: AOJu0Yxk9Nenkx6Q1VjDtd4ykGCedHnlttAn4ScCr9UCkoGImewzaVE4
	IJXEeEYA9oxI4Sv3HcSBrsHWaZp/Evx9hJZSaXwOMyg9mS3ascN2
X-Google-Smtp-Source: AGHT+IEHaKSGLLywsHC37FqufdahJqQQQ+JMnWmf7GNtw6yCcLxm5eLoscgOKf5iTtA69ZgVj5W1kg==
X-Received: by 2002:a17:903:120c:b0:1d9:f6b:28fa with SMTP id l12-20020a170903120c00b001d90f6b28famr12657958plh.36.1706980946390;
        Sat, 03 Feb 2024 09:22:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUM98B+9CtRS3mbSc9gKymsRaX4V6Be/qqmUhH4XgKKhAM5JlB9YcQVXS/43tR+FNIAsY0Cti7XBzEqVUGeSI6m5ZdpL9w++pfhhkfrYMAwEbHwa65Zar2IYD962EyZtCnCw5EbAZdzPYNZanr1M4/KMue/nDAXdPa4UKdRT43omxZ5Wy56hcAjBqcffH3DrP3X9EStkJEzZgWp6Jpith909GlWgG2NrFq2457yqAUkSBhbt6tQf/eDcvK2b3RSIG0Lyc42Lj0y28QaLlo0fIMCFF2eGOVh2pRrtPzwR87UHYZYNxez/l931npr/Q7c9Pte746iHvzwWKB1BNZpST0MLru9WNHmzMJ0zgQDE4M1ueEBhFSibKwkHoyKSQtFfkLy8cdsMum0vNOA9DudsVmVkSMwsaKLV5kks29auZVeVhkJI2pXbwCS8Uem5JA7GZ9hQqwoXG6mn2XSXy0nrndUbtJKCme9MeSQbno15w4BtCyPTfz8GWTrVdZLL4xUunHv25iJwtBn
Received: from ?IPV6:2600:8802:b00:ba1:4410:8da2:e94:f02f? ([2600:8802:b00:ba1:4410:8da2:e94:f02f])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e34200b001d7439bf914sm3460806plc.235.2024.02.03.09.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 09:22:25 -0800 (PST)
Message-ID: <b8365686-6c31-43c6-a507-d126b621a247@gmail.com>
Date: Sat, 3 Feb 2024 09:22:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/322] 6.6.16-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240203035359.041730947@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/2/2024 8:01 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.16-rc1.gz
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

