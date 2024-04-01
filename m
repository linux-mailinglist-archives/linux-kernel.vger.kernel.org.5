Return-Path: <linux-kernel+bounces-127052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87AB894639
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623B01F222A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0953E3C;
	Mon,  1 Apr 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZcqKfV8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601917552;
	Mon,  1 Apr 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004397; cv=none; b=YiRVyukWuv7YmLoongtUi3RiY2wT4a6A9BWMHCHfOmh11LNQVLhiE5YREDg1UwSS5uUVgGyzIvLz5/2jCacKYFld7GfN2ZxzJaVHu587kHa1Y/qEQH42t0sIscT4Y44hxZHWp+OdBrh+CxyXxam5cRP58GjvlKYu+kVkaWzMZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004397; c=relaxed/simple;
	bh=1eh4EosVIJe/RGgbyngmwAmaNn7FpgVczuCce1/V6dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmU5EJBCGxsMk007NhRGK/77LXFUKkEwXWnsi/ZZ4GRb8apW5bnW973oVq2FsBLNRNt85RYmBj4RUc8aDc+PuBnmwHhs9bE2efPnbpCVbFFRuXNIePDDqPaV2KFQANCGS207M/ImOkodjp1xNpO2pk+sp6v68MYWUQpB0TUw17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZcqKfV8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e223025ccbso17430875ad.3;
        Mon, 01 Apr 2024 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004395; x=1712609195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vmwsO/t4KNvnDmSvXyJNoMNNVTQa5mB2jFuIsMRTOg=;
        b=LZcqKfV8sJbxJJrIcuXGJH3w9WULH74apoFDYOsvy1oW+pW20NEMgzsRzn9krdWwEr
         MrOaZ5u4Qf3JXBFGKtPBUCOnxBzOAxJhP7pDi8P3CJ8uRMRAPLZKcqZyiR7ALmnYhgtF
         oZFf0/u3RkSPIZ0zA1akiTU602+0wvwPXH54J2D08OQB7T+om9bl9nAWtEw1SCEF5IzZ
         Bcx2qZ5da7LMYmH+FHBHd+XYSLYsXmxW0K9d7j8RwCq32fihkbXtSUWeQQCIFcz4dXnh
         aInECzIeyO/pshwItvppcjQRKpCNxladGgrBKGd7MUvb1c6UlAD17ihQzEYBWxp4HVr5
         xTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004395; x=1712609195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vmwsO/t4KNvnDmSvXyJNoMNNVTQa5mB2jFuIsMRTOg=;
        b=QKsH3+SlnLMrQt+P9ZF6/Nao5gdxOYRNu3ks+r71x6BHadHns3vVK0kAg0WsWHiGjK
         Wm0wyMXQisxRmZab5cdTJAwG7FrfNxopNwrauW6xONFsJzBz/s/4JUo4j3nxZaXWUyCs
         Y+Q/Se+vDHJ7ui6+hvLmkjHWsNnMs0E6bZE5SGJbG9YBd8uASELwFULsWLG0q3ibxuBC
         /lJZuEsxYcqMPuCftDdC5Di7VV0iINvrOr6E6cAD0P8aa2OqbSnCKEU6R2HhWGAMZQ22
         PGx32CBdq082HBLOtz+ZVDNhKsBda9WrinDg5IYC9U0mCagWxVYqS8M0Ik7O3Q/aTEzy
         FgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/BQjrUPJNAkfHy2bsZZ2dLkXZJhxZ+niYcVCo33MAlyfX64uVe3rmHbe3NKUd5fINA4tICg7DZQjLVUHQZXjDabiZX9hyM0hV9cPuywV8WxK4RHcCcx2RWNM9MaL3D/pyboyg
X-Gm-Message-State: AOJu0Yz85+VcJNqSb/oegCtpVCMDgdHS3jF+2zmqckuwbKzn6ZuyXSKE
	5/rj+lhvlEtyc6BNQndp84QVX8PyMPPDnG0N0q0m7TlwGlbdkwvh
X-Google-Smtp-Source: AGHT+IHXp/WGncQL5m+2scozSheJ2HjLV5OTyDk7ex5hN+Yk3jgndPR6FmSAQ/+tMINfp/heU8X8gQ==
X-Received: by 2002:a17:902:c407:b0:1e0:7f78:624d with SMTP id k7-20020a170902c40700b001e07f78624dmr10073853plk.57.1712004394743;
        Mon, 01 Apr 2024 13:46:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id kh12-20020a170903064c00b001e2194ab34bsm9234135plb.245.2024.04.01.13.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 13:46:34 -0700 (PDT)
Message-ID: <022b4411-2ebd-4f8b-adc7-0ae81a665181@gmail.com>
Date: Mon, 1 Apr 2024 13:46:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152553.125349965@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 08:39, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
> 
> ------------------------------------------
> 
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
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


