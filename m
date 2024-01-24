Return-Path: <linux-kernel+bounces-37467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A037D83B078
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C9D1F24402
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3312AAD1;
	Wed, 24 Jan 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VejsDasd"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94917E764;
	Wed, 24 Jan 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118652; cv=none; b=UcqNy75aO48UFYw6QtKoblE8DdT59WPXe3FEZd6ONdoUbVs1IIMeb2Ww9Am/UJi4TdVFqKMxu7ghKeBVomgmWPyA6HIiJ409VEZ+pSLEzVlUSZ6YXY9r9T1IfaWWVedzXf7g5hdsSdvtfMwKb22dUcCXv5BIatzgYRQokG2eQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118652; c=relaxed/simple;
	bh=zmpMtbPNi11VZtlC6OMkLjiOFt4LIwYNYu/Xb3aM49c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/GZj6HjfYROjIZ3c39Q0GiSkqN2aIrkgVV/9W7ny7crYMkrDQyE5P+iM3k/TQMQT9GeJL7/i4UAcpZDeBEINTex9B0GiinLyxbU29BVtJ1kqLewTg0oCcT7oeQVpWp7GeCs2xReSTzAhGx4DPIsXAyI+cLqfdaAC+p/g2/X8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VejsDasd; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-783137d8049so479997385a.2;
        Wed, 24 Jan 2024 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118649; x=1706723449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mV/Ca+SH/xfxgnTjXdWX10lc/dyq1IqSKNfOcSnfkFc=;
        b=VejsDasdff59RUJATFdEDIyfjqTkzCG94r3lTz9Ps2TnR2rf1XkWRwo1GlNiTRfd6C
         XnwJFqcHWVwCBGIT8Cq3qDwfIw1NewsjsJrzq62k5xeuwJ05Yijuf1UqOdwAtCjqBSXz
         vj7GBgUjpygCjWpbhvcNdZyEfV7OOxIvu96s3bptN2zqDa+QbhrDGjww07P5AavquuMp
         939wdD8ki6PDPrEzS/W7/qV7Y9bNe4LXsFF4APknDNSjvHuCm50V/4KPiQfzh8jSa7eg
         M/k3eDND/SkQzLd3NHqdTyuDKYeQ7q+Ut8ZTJ4sd/pUtsnJbiPZ2nRwVyZJsU8IhtXst
         oh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118649; x=1706723449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV/Ca+SH/xfxgnTjXdWX10lc/dyq1IqSKNfOcSnfkFc=;
        b=JSa0JmcQ3dMlPjI7fxeQPKlkf51o8YIDRD4IE6DWBmWYG28qoKzOeCO8S92ZsgcdPi
         jJOPwf6qp5UIn+E2ygyHaC6/HO9z7OHYSzrHqn13Uya0snGisIQWHkEmyI2PL60MNA7x
         sfdff6smwNE22ptkgq6HPIEjCMW18o2JWMGctkWfqjnymgwXMCEL5ZsB/GXHtpGqODiM
         y3/G5cDk2azZNK8yctP/hAn7okNRWfIUrwladQLB8vC8w0LnBPAUZEmgZdiWGGNYR4y+
         A+IVl3reBMc02Ec0NxL7ztKpBwcv+XSNMkbQG9C5/abH4q/vwrcbZJYVufjv7scOpK93
         29DQ==
X-Gm-Message-State: AOJu0YwriS4SR5cZXkpT3uErOBw11wsnWqepuqBD3kbE1ZlTp6JhTmC0
	vrxzRLPW3J+P/ppNv12xGLheA0wG2AMeMdCwQNPWoIDuHsuw5Ps5
X-Google-Smtp-Source: AGHT+IHbcuCuw0k1Q4GLr7cIkKxGbFEY+cx8KBkgDCxdC9f5fRfvBRz8LAbmIQf/xPV8AMaZMIJ2gQ==
X-Received: by 2002:ad4:5dec:0:b0:686:acd2:9b60 with SMTP id jn12-20020ad45dec000000b00686acd29b60mr1685402qvb.46.1706118649605;
        Wed, 24 Jan 2024 09:50:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d15-20020a056214184f00b006819a4354basm4705402qvy.37.2024.01.24.09.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:50:48 -0800 (PST)
Message-ID: <95210b70-38e6-4d7c-acb9-d2681261f8c7@gmail.com>
Date: Wed, 24 Jan 2024 09:50:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240123174544.648088948@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.2-rc2.gz
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


