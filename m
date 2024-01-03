Return-Path: <linux-kernel+bounces-16045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A182376D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31E21F26635
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF381DA39;
	Wed,  3 Jan 2024 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRdz+HzB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21941DA30;
	Wed,  3 Jan 2024 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so7456527b3a.2;
        Wed, 03 Jan 2024 14:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704319471; x=1704924271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7iewc9p+e5BRzaH3h+6ugVYrcUX2L5YJYU1XW/tpRA=;
        b=hRdz+HzB7tMFBLxG06bOambmGe31aeJxWp8mkXdNfEqQLF2ZQPq+iVTUrtKKCQKRXo
         4rwO7ucZhRFmtYO+OMA8T28TbEsz1EVeGjJo3uYC89/CVcH72rqwUm6Q8s5q1hvoJ/zL
         1Mu2t2McQi0vNh3CynEpGgWazmsNkNTM/hnxO6Z4FVj10e0fSQERoQzlfGs4XShCzbv+
         +ecp4AafQ/qZQlx4nUnia+u4e572+ruqRvgECwxIjCK+H5ENST/aJWxcC16vl/EPwPp5
         h+NyvsV1kl5uJDBy2xqAnL+yAKDOHNgryDQCWrK/sWGGkqBabb54YTucLJUWrovlN9Vw
         XWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319471; x=1704924271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7iewc9p+e5BRzaH3h+6ugVYrcUX2L5YJYU1XW/tpRA=;
        b=Ue0pXw7kjBLiSDBtK0hXUjMDhNDJfeauSj1z7JXdXDaIbeVymHzNyxWwXghTVGecZJ
         XQtpMk6xP5AetaOGJ4OhhWCv5hJSw3svKHKAiCYr6qSHUl5qBhkwLdmtZMYfGIyEmamY
         H9ZxeEBGNdcg2iqrvniIVTJHDVI0Rcahb26TedguRx8LaPAMF9+wA18sDhzipFCbnyG7
         Mwe5KdNMJH8uSwy6NeAM8Y2/RmgMKjFGSLte06Fmf8ZqlEjMwT+1utzCjk/11oS9tbIH
         +LCzX1Cah4ksvy7cPmaMJqZbmPkcFK1aPQjI5x7bY1wWbzCBy56Ddait8DHJWBG+DJ4C
         HPoQ==
X-Gm-Message-State: AOJu0YzG6P8L0CWIkwDqjpb43IZY7P/MeAqPFS69kfQqnA3Xx3ddu9NU
	Yp5DWhTRMTqM5ZXQHxvND0k=
X-Google-Smtp-Source: AGHT+IGFAU/chI/igQ3rX6cuspXRekK0D0+GMOnXBB/fR5lCzwlRPqDmltazxxBLKaSkiMUBVHC+1A==
X-Received: by 2002:a05:6a00:3989:b0:6d9:e91c:a5bc with SMTP id fi9-20020a056a00398900b006d9e91ca5bcmr13608036pfb.38.1704319470948;
        Wed, 03 Jan 2024 14:04:30 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u36-20020a056a0009a400b006d9b3b38525sm17876588pfg.161.2024.01.03.14.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:04:29 -0800 (PST)
Message-ID: <c0525f2a-3871-4500-b941-a35e1224a4f6@gmail.com>
Date: Wed, 3 Jan 2024 14:04:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240103164834.970234661@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 08:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
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


