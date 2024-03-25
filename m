Return-Path: <linux-kernel+bounces-117671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D3088AE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC6C1F62A67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436E545C06;
	Mon, 25 Mar 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uc23wkhs"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1155223
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389746; cv=none; b=B3eE6SIPTtPOKrsWbAQMw6v1ilzh14yiC/8UpIqpsABKHhaoY5CkIF9GV7nv3QYbyrOWUqTZiD4ockx+pixIl9yss5vnSxsGkidvJY4WMi1Mj6kmvu2ym/AaBAxVrSa0nl9Vh+wCrKcDiKaBvAdR7dz7p7bblzuYcyoF7sPyTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389746; c=relaxed/simple;
	bh=lxLARG/z8mUbwOnEndw/aPaZdDReWbd2fqQJESwXNYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUul82zsORng7A3wCQspAIH/cs+hSE0S4REub3owJu89XM/HLwcpMhyoIrAzWIsVMHkWgSXxdraZwzTVtpJ9rUtAfZWWBOULNFpLBBNeiOep25g4kOzXeMZbkTUfOQDYUK/nqPvvzxCMqENhag0m8TXxOOqLsUAh2vV5qYq0074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uc23wkhs; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-220ee7342ddso1616963fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711389743; x=1711994543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E52yW+sF6XzKO9Az8rZdRh6PQ7+k4mFgNJL/1sREfRE=;
        b=uc23wkhsnqp+Ne3OI8jqqaq7oNsj6K+vn/lFDJw93VYA531FcZUpQ4IkSpRXugReIM
         gMoGer9MmQ5gewb2044+rg4ut3+DEWQcXzE3QpqXNCBWOq6hSqSBjbmthwXgNGoQ0/Na
         4EqQIrNpemb8khucNV13Lba2Du5EIOC96o36M+XE+bBJ0QBNmA7laZDLhDoDMZ72oT3K
         NsNEYqKQ/9eMrfV8oeeoTPbFNiE0PrN4CcFpuOCZjCOjrdjprzJkDZwknFNiJio840mx
         zIU+ZBNG2hIGmm1JsIvE10XdPRhpdgwcvz4ZR/k/rddZ2rBpmlB7uF0MemmX3acad3qE
         WK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389743; x=1711994543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E52yW+sF6XzKO9Az8rZdRh6PQ7+k4mFgNJL/1sREfRE=;
        b=neCG+bCJtJi5ck4zinL7qcSNa74ifibgGwZ75RON5MAWJV3510goniWupHdCmY9seq
         Lf4sQXRzKe90X52FoKTYiHuQ5DLBuck9xz5fzLcY9ZKV2pqQVzpBK1+1ipjuAFov+XVC
         uP6vPqmRm2fLEZNscKlLsyCP85NXaW7pheKFqhyDHUXWGACFungHknm6k1nT90waxmik
         lTfmC0QYJWPY57H4Omsi5sDw3BJCCYnfscb13TwHQb1gx8516L+hvbfOezAnP4JXXh9S
         tlvAuHGv+YSpKcxIW8xrlNosg3HEcR5Dokuv71VxWQACm5IIHjI+CILUO9ShnQLnhoZF
         Es1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnZGCVf8ymqJPPfznIpDdmrla+zIASj1QWW/abmt/ZpDxJM6/C0ai2efIyn6ozcOO5uCdwFgwp5wBuLFitFO36h19xvLHSGsyUdLuv
X-Gm-Message-State: AOJu0YzDfDe9RTX5am1j8UO+Uz1qf3KqGk7MEruE9FvDia8PZvBLyGAy
	rh84WAxHAJ6ijJB8Xir/8Ha74vXujtA83kJw3nAKCXo0DbU7Fgix+7+8CBQvjXA=
X-Google-Smtp-Source: AGHT+IGL7MjykGc3x6fq30Iwm4UqOlCErDW/FkZbM+UsXaKx+5/ikyFovIATmsU60pyNmfB1PDf9rQ==
X-Received: by 2002:a05:6871:3401:b0:22a:4fea:f435 with SMTP id nh1-20020a056871340100b0022a4feaf435mr1956742oac.2.1711389743347;
        Mon, 25 Mar 2024 11:02:23 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id dw23-20020a05683033b700b006e6cf0f7ba8sm827599otb.57.2024.03.25.11.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 11:02:22 -0700 (PDT)
Message-ID: <fb9b5df4-23fe-4299-938f-dbc36a4dc052@linaro.org>
Date: Mon, 25 Mar 2024 12:02:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 samitolvanen@google.com
References: <20240325115951.1766937-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 5:59 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:50 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.22
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

We see the same problem with new warnings on RISC-V as with 6.7. Just like with 6.7, reverting that patch makes the warnings disappear.

   commit 34630ced09415d273146191778dfc5338f545db7
   Author: Sami Tolvanen <samitolvanen@google.com>
   Date:   Mon Mar 11 19:31:44 2024 +0000

       riscv: Fix syscall wrapper for >word-size arguments
       
       [ Upstream commit a9ad73295cc1e3af0253eee7d08943b2419444c4 ]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


