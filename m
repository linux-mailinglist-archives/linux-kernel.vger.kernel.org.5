Return-Path: <linux-kernel+bounces-164614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B28B8019
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF76E1F23524
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA3199E86;
	Tue, 30 Apr 2024 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKWusrqR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742519067A;
	Tue, 30 Apr 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502987; cv=none; b=gDONStATBgZkVmIWu1krmNvs8Z/9krW6CFxEh0sHW5yfGM66Xu4lBzwUnCy9FvJmvzpO9txLmrOMCfcMk7wNZC7d9HIQzfLOLzzruwCcjt7SrN6r4oVmZeHdQWbjk6o8Ko/S4TCzna3WO9rzGSotpnGsrdl4mxlpkyEpKbNpbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502987; c=relaxed/simple;
	bh=FhrQaeTdgZ/NZwmj37cjeoHdptexvaXyvbepUmbgMMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qq2CwvTjSB4oqKD5a4ev/YFSh4N/5MrZN71qPcs5ADCr7+THaTedQYvCrRq2E4YkZ1eEnvCH9iOtD2K1rJ9dp2LU/qaLKecgMKJ8cuEm7E2Nyl5zAlVSDNdJouTWjwYjyM3W5EWosOx4v7uZF6dNeWaxEtd72xTigIDElxeyXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKWusrqR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3ca546d40so51841885ad.3;
        Tue, 30 Apr 2024 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714502985; x=1715107785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=METv65pV08IjO8SJMBQwsooi61TBGF9gD0NnqLs8/fw=;
        b=DKWusrqR4Pr/KspZrDBE3WNaksVBUwutPQ4cfQXql1XLhG1RxUljDqs28ek321Usy4
         ZlWEO2E//hEQoc+95RFK0RpU750e64/FC+haBQVbMGohJMJ2K+U+gJ/jwagaWa6DcU53
         Ksf6jW2e4QxlWtSzxmSR/8LCncFfw8FkCCGPu6shwMPnx6mSDIIsG4KFliyCto3Esbqq
         N6bZblIAPon4sLEu5GQzh8VtKK1AZH14aKdAlTKgrXMNy/HM/W5hxdsb4RpRlDy5fWn6
         1/OmCzFJYz/Yga9Ji1lHy/vX0BbWQsWRkVHOkP4+KqEvGa9RNS8+bdbEMdyTWnoI1L15
         vZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502985; x=1715107785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=METv65pV08IjO8SJMBQwsooi61TBGF9gD0NnqLs8/fw=;
        b=PavyEQxqCM5mWbqNvUuEoz1vi4PmpH1cZdbeFj+OFuhqv96C5IfbDkGJvFQhnHtW4/
         0/wMWsvAVjDHmcs66z9uZKzsr8BalC986dwhChAoceJNjgGKdK/UksfaqeQN4qJFeet+
         ZGzB78RLvh35Vz8bvwHfBgU8ngn2sr83OqRKEgB7QAgL1CftP8ZD4bNvwf6BjYEJe9sp
         n7Jm+CxV2nPqMqAkBwTDawcfS89a+9ja+aZY5SsC0zGoz4omIRxD9SiiR7JtkDLuD1P4
         wm/QXYjRl9r9J0sDdf1JoUGdSEOjYuJfAwWkYeIJK3MFedFXjsrOUFOJ5vMpnksaVc2z
         RHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVDxMge1xOFyHza859dV7WcYzRUe1TTc0Z5av2Br78N8bg58vkrq/euDox0MLS3sGZgazLFSjubuMt8GgiypsvGSm+A9FCqUynuyS4hnXTbcyRg9yhvMWCg0zK+O9/6QYcFsOO
X-Gm-Message-State: AOJu0Yz/5JqFYApOWPZ6RwhzCLTQuhhQLccYZb6MYzH1w6+S7sJk+JLD
	MyTsaUTzAxgyqi+fBxJbotGjXvcAwfJyt/MM+/gAsXvdTw0bF7GP
X-Google-Smtp-Source: AGHT+IGBWjUw0lT1zEwMhsWJzOV66gUmz+pv5M6BItPvu9kPj6xn5cJx7yIoE+LTyznwNxaw+lYZTg==
X-Received: by 2002:a17:90a:d0c2:b0:2b1:99fd:91f3 with SMTP id y2-20020a17090ad0c200b002b199fd91f3mr359672pjw.41.1714502985037;
        Tue, 30 Apr 2024 11:49:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r89-20020a17090a43e200b002a7e4b99752sm1895756pjg.0.2024.04.30.11.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 11:49:44 -0700 (PDT)
Message-ID: <33760059-444c-4cd7-b2bf-74e94012f895@gmail.com>
Date: Tue, 30 Apr 2024 11:49:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/80] 5.15.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103043.397234724@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 03:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.158 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.158-rc1.gz
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


