Return-Path: <linux-kernel+bounces-43717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C497E841857
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B77B213E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B6374CB;
	Tue, 30 Jan 2024 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHNgrfwl"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9336137
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578283; cv=none; b=AQ09B7tnXJVFIVAvOwH6g3syoE1M8YBuswZvpMNILaiKd8jJnSeYN9H0d12PM6TIpyWjccmEWdC1hVXl02AsoL8aGCPgzXCTDeeeo68bvf8E0nPooQYsmR/Alv4xdQ21RVaJjFCW0AP5RbeUMBVAZ2ygxmd9LIscJ6YZPYsI3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578283; c=relaxed/simple;
	bh=l0t9jFgPIDb+BxojStFw/B4mQF8sX83DTK7Dq/RDMiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/izE9X0tJewafsiV+0Pz97Ol/wgedKn07P2CdOdS131aCTkZiDZuOCKmVd7wGsOaDn8Ugdd4iQsrSkCO6e15NxdrlN0uQXnaNBLi5rVvbYrHEl3+Et8Indb6hZKtELEIVr7YmKi2vmNyitV5ts0ghkOL8bLD9pqD2rCNgu3uGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xHNgrfwl; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2185739b64cso1630717fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706578281; x=1707183081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKPTGpRJe4iviA3naEAAGwI9bB27NhTfAciTApm6FaU=;
        b=xHNgrfwlz/oC1NG5Ag09fbdGq0AEujFbVmZcOvLpTng3kzaJAAvJizbu2/hdhGVB89
         oAVo5eyTy9OGrWRRZnyZ2ESMXedyd2UCVKv0DO4IhNt83mqTJyL4AI6uWqdbUUfAAiEo
         of/l5DhsiKmLmR4Yi02SAof1rj0KmaCGRPlhEWmjjvjIKOsCzVKAFD9hX2xv/j1PGBtI
         aXrcAuMRN524lWciZHigTIiq1T7B4tPJwGdK3HhcI75Yy20k2kyiksrD5OUwrjtgCS/7
         D0QaK0iOYxXZwhj9e+oCwXw469xg++LIaHAJWYE4QDNTk4pW5ff69bQisnWzTP/uTVsV
         EHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578281; x=1707183081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKPTGpRJe4iviA3naEAAGwI9bB27NhTfAciTApm6FaU=;
        b=wvwuwzJk3QGsRZLqSr9xwYXp+Vwa4wcftUQ63kSfAdMn+P32fqBG5M4PZw+4cltB8o
         3IcLsvBLUVY6TsqTrRZuAcyc7u4Lw+wxr4P0+ILSDc73AYmYNKybdhGut6vWaYVGnFI+
         nnYMvnZbKh6YnJxYy3Yy1AkXpqh2UOzE9l0zrHaGORomv2lShJJBlLlYxH3RK6r3BK44
         9WAQve+MShZd4cW0ZmDCN225srYz3YXSyztYIhBvMh5o5LbQ1trtzc2mx39rqeMv0Ypb
         amqd9f5rAYuXAwKPf+TS6mTb80xobPFum74duxzhHCWa7cqFKjxierhU/Xa8eqdOOUZo
         Cb6w==
X-Gm-Message-State: AOJu0YyQVRO8derXpN4nK835IVUVGtwOCZzwxpuyOjLkpM1RUUYtVECM
	b9XDH0buVPUW6F7xAybbrLrM+EWakRtFru02yhS+cMwv42k+0Isp9qKWH3y1sjI=
X-Google-Smtp-Source: AGHT+IHiRF8RsmyJ9JXE/PR5570OucKCZWuOzmou1M+BxzDtaClKxilJ/q3KJ54CKVlIg/NScbdClw==
X-Received: by 2002:a05:6870:e0c9:b0:214:8499:1233 with SMTP id a9-20020a056870e0c900b0021484991233mr7224701oab.22.1706578280724;
        Mon, 29 Jan 2024 17:31:20 -0800 (PST)
Received: from [192.168.17.16] ([148.222.132.181])
        by smtp.gmail.com with ESMTPSA id lt7-20020a05687142c700b00214ca092655sm2295401oab.46.2024.01.29.17.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 17:31:20 -0800 (PST)
Message-ID: <4a2b55da-ee57-4fca-bb7b-240792b25460@linaro.org>
Date: Mon, 29 Jan 2024 19:31:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/185] 6.1.76-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240129165958.589924174@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 29/01/24 11:03 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.76 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see build regressions on Arm64, as reported by Naresh earlier, and System/390:

-----8<-----
   /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function 'mlx5e_build_sq_param':
   /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error: 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
     994 |                     (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO);
         |                                                     ^~~~~~~~~~~~~~~~~~~~~
   /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: note: each undeclared identifier is reported only once for each function it appears in
   make[7]: *** [/builds/linux/scripts/Makefile.build:250: drivers/net/ethernet/mellanox/mlx5/core/en/params.o] Error 1
----->8-----

Bisection points to:

   commit 1288b23c9c528796ab656d2796705f52c5ffad8a
   Author: Leon Romanovsky <leonro@nvidia.com>
   Date:   Tue Dec 12 13:52:55 2023 +0200

       net/mlx5e: Allow software parsing when IPsec crypto is enabled
       
       [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]


Reverting that commit made the build pass again.

Reproducers:

   tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13 --kconfig defconfig
   tuxmake --runtime podman --target-arch s390  --toolchain gcc-13 --kconfig defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


