Return-Path: <linux-kernel+bounces-164505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB68B7E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D22D1C21AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8A17F37A;
	Tue, 30 Apr 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjvo1DNN"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572111802B5;
	Tue, 30 Apr 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497857; cv=none; b=RPZgycQjbdnjGi+EL5zBeYuEyqdurCGHVWjZg7tBZkvvsya95JgMHWVmEzAlFfNSNG16jgP+KV6M23WffukywLiOIN7OnGY/LHdkBf4c23FKbBKd73B96osqJY+2vGDZdZIPwfy8ffdnnOBjlbhPZHwz1fqDO+pswbRTfpYdn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497857; c=relaxed/simple;
	bh=8c5E28VHtG6A/vJvFkJYiy9fvK9sNN/lCptMz5ClFbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSLjihXR43su/eaOgf+CGBwpL1mjeeIhBhYu7f7xVTT6DyXj58Rg3gwZNwenicvSdGKS2C3bENpE8IYWaqe439jzzkjENNiBnNJTEU2nCqcHNSkHPG75hTvA+hyVpr6bdrx8z9Mv8/GkBKT6RGDpCSiKIrVQoGRJRWysvSu2aXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjvo1DNN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78f0e3b6feeso211613185a.1;
        Tue, 30 Apr 2024 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714497855; x=1715102655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gC3Wisg+vFkvbQKP24bf+0UkU9wju72UQF1jovD9/R4=;
        b=Mjvo1DNNOFsrgwXcN64Oo3BzZAee8h118lJOUqbfjKy0qjpjW8s1u1/0xpmCy+Ws0w
         ngzMgicm3yN/UbTrLzcjV9nJexyStRZY/rbS7QiCKJQ09zF1FPTTsHcTsiNAGaB/55BQ
         QxD01gP6/P/YDKPaRgY6RASUrWgIU2g4OEdyt9M2+hLDZ2fm2mE5uiIcDyGcON/DN/7C
         06vipr4ORDQPFlxAaMZMrxd9cjqUzEha9PUZQr6VOaXx5S56WbdsW8MFm+G4lpiEjDyo
         n8+jmeexY/CKpgOVKFacV1vmcomkLcWo5cROQan4BXdeWK5AqyQY/jbNb2ezjM7y5GSP
         Raxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714497855; x=1715102655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gC3Wisg+vFkvbQKP24bf+0UkU9wju72UQF1jovD9/R4=;
        b=NziHEEXbpFOkcOHf0HGODE/neK0NJWfqqE+VWLHgMUVBCQFIVW9weD8y3sZb2mXaL0
         k1nIlxHhO+Px2UwQzObU2Y6VmDCUS18Gus2Z3w8295QuBebDq3gkzwhug3ULGscFYCZ/
         DTiFhaiXQyHhZKSHRI/qR7Rx91FZ4aV7c20TNjdPDvlC2bkweY0SLt3CrkeGfuHnWSaP
         RK1+XhOv1uSuhdF6oMUmM6WzX0NrqCfFLxPQul9vWqgtkWzxGGzgccCLqhyeCXk/azek
         xNWzTH5nPTokbVjAi+9hWQPjEtyxBUY6vHLpVvUGZL4cx1ijuoKav6DElMbS0j6nsUjm
         /TeA==
X-Forwarded-Encrypted: i=1; AJvYcCU0HKStnE6pnTZbk5EH7Ys5BrI7pwnad9uU0w5ajz6qvjITGRG4aqPBh5g1RDPS3ToEDw/IGtXa0urN58Vm9oGEP2rbvwhW2mNyZMmRmkntf+qKngykb2D3F2yCn09MDwwybz36
X-Gm-Message-State: AOJu0Yyq4nXMn1OzAl3gLjWAQwKVncGvtgmvgpjOJjqHyP0CDIVygZ+I
	eHqukuXmPrxoBY9KzrsnRsF+uAZwJsbnF1tkeKeBkoK+Jmh1oOJ7
X-Google-Smtp-Source: AGHT+IHz9lvNYsSw+CvuqUMUtxWUkw7sPyOBE1PtcyqOo0C+WKn1PnKvtaHa9EZUEusZtIhHDiEc5A==
X-Received: by 2002:a37:c206:0:b0:78b:d7a8:84f0 with SMTP id i6-20020a37c206000000b0078bd7a884f0mr16060504qkm.46.1714497854998;
        Tue, 30 Apr 2024 10:24:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o15-20020a05620a0d4f00b0078ee090baa3sm11577575qkl.10.2024.04.30.10.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 10:24:14 -0700 (PDT)
Message-ID: <84ef302f-2d49-4465-b5c4-91ea4c8fbdb6@gmail.com>
Date: Tue, 30 Apr 2024 10:24:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/137] 5.10.216-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430134024.771744897@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240430134024.771744897@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.216 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 13:40:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.216-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


