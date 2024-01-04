Return-Path: <linux-kernel+bounces-16159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA818239EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01050B246CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1131EA4;
	Thu,  4 Jan 2024 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hXWsgz2T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E32103
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso9311639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 16:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704329815; x=1704934615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0aOFxnS/WliN0SOxltC/PfrXfpMVs8czZrG52PYpWs=;
        b=hXWsgz2TtM0QairxPzv111a5JTbRu0KkM5Ew8VQjoaWYyTVMaGtALhK0gukiuFCvPa
         vZW1i0/t56tcWIrXGsS1H/cpE0Wd80n9tJhIA2uF8O1L+B5yMxICkf9GPpRSzLyJ0KU0
         3IT5fjLBM0qDJtCXByh13Ccg57Racr1QiZHuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704329815; x=1704934615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0aOFxnS/WliN0SOxltC/PfrXfpMVs8czZrG52PYpWs=;
        b=KRRDcRU4ETuSQamA7aY98d5X4CO0sAEtSispML67KvnhXjntsIe2meGcXv242RUy+z
         pBhn7Ncy8j/ctmBbpKHQV8HeBiG5JLkTsKHaOyaxL/vaN5N80mQCYyR3NaOGzKa52sYX
         fQ/yOY77mA6dPw0QLXWcDy5/yz2OoIXcTwsZoH56Xh+YfrIfJNYQ/5Gg2cbG4DaDGe8S
         MKZkXSU9ZtfA24SFmF4w+60nAgkunzoqjmrHb9lyzuoNPbff6EPDiDPkkYMVHuAz51eJ
         c22KI4SnkWDMDXRLcwhqCOOD6fBJ4z694Bv3idx9KLrgTpg3GxkorelreivG8R6K5y2E
         gSdQ==
X-Gm-Message-State: AOJu0YwYRXrP0MTVgdY0puu4QMKdGhCG2kt7lQUZwVnF0D3i7vz4WPFV
	cfnQUeb519SKN9TtXCxG0IY/M8qpvm8wvg==
X-Google-Smtp-Source: AGHT+IGzRDMkCIGaSX3ZkoCjX9C9btmWKAPBfa8Oj5WOXmDfPeE99rLQLkfg8ETQ98GXfXoGRmbf1Q==
X-Received: by 2002:a92:c548:0:b0:35f:f59f:9f4c with SMTP id a8-20020a92c548000000b0035ff59f9f4cmr30811397ilj.1.1704329815670;
        Wed, 03 Jan 2024 16:56:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id dp21-20020a0566381c9500b0046c10057bbasm7722443jab.126.2024.01.03.16.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 16:56:54 -0800 (PST)
Message-ID: <22262131-d9b4-45ba-85d7-d42c08e6b4ce@linuxfoundation.org>
Date: Wed, 3 Jan 2024 17:56:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/95] 5.15.146-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 09:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.146 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.146-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

