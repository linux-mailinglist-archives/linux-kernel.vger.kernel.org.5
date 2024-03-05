Return-Path: <linux-kernel+bounces-92971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322738728D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCFE1F23DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ABC12AAD1;
	Tue,  5 Mar 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R19V3xCp"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84E128374;
	Tue,  5 Mar 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670912; cv=none; b=SehgLpxAksZiRxlD9r7Gc+H4kTIJF/pzrZljVXmxf4IGiL0BoRmDYVi5cY1h4oQeGEAV/yB2OABU/pZS2UirQWFXLOc//IRkHd2gn+C9uLt+kPycXuTzLa9fFU4SZxMtrmKn8gV06D3JuoIbxfsoTnxYx60UxNLGd4MxSTz6rkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670912; c=relaxed/simple;
	bh=JF6fDApDsX++KtLanJ/r0alLG2Z+uQ27cn/Q5oWN64w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmxdI5H2pV7HTkY8Cj6kH6Q1W4HJNCn5WNZQWUGNlpKrPDSaPEnOtohxB0v7JOOB8i7jh6wakvtavrrgxOtLm8Vz1Kos1SSJELGSh0dIr8gDLBAZbRJ/uX/6n78hVIIgOKxpO318YUT/hAB64wEylGVo4geIyWJFJmcgZy9wIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R19V3xCp; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6908b5037d5so3918536d6.3;
        Tue, 05 Mar 2024 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709670909; x=1710275709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FrNURxI2AhHY8M3Cu8OHGX+AUp0lYpynoWd9QA5tDs=;
        b=R19V3xCpBR6Nr+WfhNLqjntYXYzHAgg6YhA6mXuXrwHIZwQDmcMDc1FkSCNrRU1Nqh
         q9PhOHYvPIIMDZa/Hp65A7ExydtPn9uLUs/R/gb8Rr04oKnBaQlhhgUtLT29Ad6V3Wec
         4ww72R7a8VRTqRvR6DPghzTpmdozATBHSXvsvlZsVhf3JQklAheczdvy+EJ9iAGNUh9I
         vOJNqrcZtmVTKoFZ1LFDBJ+RihyiY9sDYa6GRVVJkqySIpjjH+gDeJ5U3kZACaNA/Hmx
         Fw5pxo4BgoJQN+XqS+rR3PlJI+ve0yGztjUd/NvtEwHJp+WNCaS4+UHuocM0uJvW+h6d
         t1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670909; x=1710275709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FrNURxI2AhHY8M3Cu8OHGX+AUp0lYpynoWd9QA5tDs=;
        b=kLrgMWXLX8Lqf52PhL+D7YQVnVIsn3ZLqR4whmVTQAe5MrTWgBI3WAA+79Oqisa9iI
         vvA4/Jf3trk0E9spk0tLZwSwKhB7a4BFsypoqrogzYRlkXYD3SK0Kk/bEl2fgM2TNE1u
         zs0OM4jQOPMpUCBVxotzT6tkMuGVVulo7xfFWUXbLgMkypOO4OMIZQ/NlSKtyGvi1/uk
         pTk0CBUfAO0n+3exW0v42HnujkNl3g9nMjXnV6tmIiSvuEfp1Brcyi1TDPF55PsEO/R/
         Ho5hA8VLDuR3mPVNd7Ve+XqemtWse6fdykTlg9fXjP4gpHqY0z21z02KTuVS9jdXLPt6
         +qiA==
X-Forwarded-Encrypted: i=1; AJvYcCUQECWuTtbPmMM7i9ZkMej1Pg+fLlq0sSIG/gqc2qyKNn8qIlI6/KYU3r5DcDfN5FBoV9mvTUibOFCLj3Yhzmvznru2qMfTeFfx24Se9hm+On8scBo8JZXvsq5AcgFKnv3WLTIO
X-Gm-Message-State: AOJu0YykG+ChPAxExeZfwT7aTZyptxxoQhf3LNLlcLTR11SX2/iq2Rxu
	PzKv4kzCI0VH47y1le001zJr3mTQ1vThNYftSjgJblep0xIbriVK
X-Google-Smtp-Source: AGHT+IHHlW2xpDPXU3vukbWNxCLqNBXdnAx3IgO9ZDNUY6PrEtww62MH4TuIY1CFsEwW4k4fmNf2bQ==
X-Received: by 2002:a05:6214:4953:b0:690:74a0:16af with SMTP id pe19-20020a056214495300b0069074a016afmr3792962qvb.50.1709670909587;
        Tue, 05 Mar 2024 12:35:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id cy7-20020a05621418c700b00690796f7f3fsm2297986qvb.28.2024.03.05.12.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:35:09 -0800 (PST)
Message-ID: <ba316f6f-4f77-4b75-a5c5-eb128568fc87@gmail.com>
Date: Tue, 5 Mar 2024 12:35:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/41] 5.10.212-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240305113119.020328586@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240305113119.020328586@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.212 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:31:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.212-rc2.gz
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


