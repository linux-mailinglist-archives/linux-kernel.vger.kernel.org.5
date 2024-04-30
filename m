Return-Path: <linux-kernel+bounces-164640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D18B8084
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5919C1C22FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3C199E88;
	Tue, 30 Apr 2024 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdse7GOy"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96F194C9C;
	Tue, 30 Apr 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505386; cv=none; b=nk/u2DsR6tH0mHKmL6ZXonbRNepiLpNm+Dj7in37Gc40lUh9WQx4BmsBUPO/XZn9K3ELX5kbbhcU/TeJ+EaHsNWUpgL3/XCx5eFXZtHqlGo1KCDrudf/n3HRojxUVvwz+556uiuzK97b6rZQrMYYkFmvhIAB25kDMVHS7/jFeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505386; c=relaxed/simple;
	bh=Cc8rFrKqFjUh9vE8MaMOVmsRSThjBVNwQFIE7Xfqzz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMxhc7bbliaYAnlCYi6gGM3ZpGu0lMe+hgDA/dlWIS/v2gfv351WlJS8p9qK6vTEtMh3DQmZdOkxZVUB/1irFwZ2PySJYdyftF4Cw+0QHECC0OpRq90WpISPclOMoaycTf5sVaOdi+/jVHylBrKCB4C9oQqTf2crnZxMRih09Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jdse7GOy; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ee1b203f30so1885076a34.0;
        Tue, 30 Apr 2024 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714505384; x=1715110184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbqkN4SGmwkA7nlxDTa0QrVcWbknDTvNN700GXIjAyQ=;
        b=Jdse7GOyIn07OX4Kmm64j0viSrtVu1d29P0c9mKVLKs5GcdlmFWsALirwBxfUbsYxP
         kKp7O3z5Q2bxoRc+s0zF9ut/BSqhXRiYmHBB438RaK2Labw4grhnC6ajjZ9E+c5x+piA
         6DydI83iufRo8NEJGio8mBGvxxkc0WsdsdXPTJEILSoHY+AB9CtIUljSo1P90vgelsB4
         Vk83QIILsA48ruN2GoYDMZ2XfFOE4n97SF7cYQIcs9KProaccMCC64r+FBR0cH+POaQi
         e/9dNh3GizHjc6AeMMPqUB9bftYp9JTj1WDW9bFuxl2McKQBUPPLkDschbxVIeiXojPy
         u96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714505384; x=1715110184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbqkN4SGmwkA7nlxDTa0QrVcWbknDTvNN700GXIjAyQ=;
        b=Jg5qINwKk6b5GHIIp89290TvGcFMPy4qUAeUwALaV+NiDUQMY74GzFExCOdKnsY6iQ
         roWve7qwEMUIz+uaNlFkDSFkP/B1srDiVNi4+uG3Up/2lFiJENnO68wMe3qZprC8BJsb
         0l9RlhfbJIhE8eOSdU1NluLoijfT+kwOngD8bL7k0qPfntj7KtHEPiNCNCgGLq65YuZE
         aE1MArbaFml30zilJWHfWUfA3ekWVAYCQvi9stuc7kx4u8kNk9yLSxuRl7Nqe0JFIq3U
         a6uf/sRkwb5+na3vMEp1Ogl0wY1+dzC8kOlZ141yRjkne8Biz+0BhFUTqyZZKmGKt4HU
         akcw==
X-Forwarded-Encrypted: i=1; AJvYcCXt97ZAWd/tMQCkIp9aYNYZgkrtJiWX/nh9t4Sz+8Yw7udxIWzDKlNLtGEnJ8MdqVQrJxUfYgqU5z+C1Tvh4l4WUi6ImpUgi4V6Xstukn/UwFPjNE2/KSmX8bRNzedSQaBT9SD3
X-Gm-Message-State: AOJu0YwkSJq91X5yoadIJ2HDGgCCKtQv5zEHUxjQIc6Y0YXSHOt6bE29
	e7QVWgIyHKMyuSboGf9lrifTtTadM+Mo1LN+mK9Jk5KU+Mv9uRGh
X-Google-Smtp-Source: AGHT+IHgEPMNSqehyh4pZ+KsgWY4amN+6zFG+eK2Dl/aF4k8boTtwcXDSBN5LzsPKP1DxDNZ4kEMKA==
X-Received: by 2002:a9d:7a41:0:b0:6ed:51e8:4d0b with SMTP id z1-20020a9d7a41000000b006ed51e84d0bmr515661otm.11.1714505384024;
        Tue, 30 Apr 2024 12:29:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n66-20020a632745000000b0060fc94219b0sm6410479pgn.45.2024.04.30.12.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 12:29:43 -0700 (PDT)
Message-ID: <3defd0f4-2883-413e-ac82-3ca298dea005@gmail.com>
Date: Tue, 30 Apr 2024 12:29:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103103.806426847@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 03:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


