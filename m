Return-Path: <linux-kernel+bounces-4503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D30C1817E49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37141C22C42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA3876098;
	Mon, 18 Dec 2023 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CdEmAnJD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A7740AB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7b709f8ba01so46287739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702943802; x=1703548602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4hTBdhcHDhfzRm+cFBqMHZ+qbiNMQ567f4rRt8qp8A=;
        b=CdEmAnJDHbywORSUrQf+xE3LHy0Fx/RsFLfLW1YNZI6MDB0oG+pKpXogflOacy4U6R
         grGEilE+0pE7xzrugk+zzjTPHYBgrOr5WcMZvpBvdMGirx9XoBv5k5f1waTNdR9Jv/dW
         IZshve/v0ZyzYJDheGCbM+mYBOmTXIeywz4/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702943802; x=1703548602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4hTBdhcHDhfzRm+cFBqMHZ+qbiNMQ567f4rRt8qp8A=;
        b=oMH5gzpBKRLQj2y9oNQ990wsslOI1LNuqel1IWjeNtWSUQj/q34I/X0PHV96yUx77u
         DUUPqFr/V1XDGE1gGTVe8YxOYCGXoW/AHFujad3tvntzxns3mpGLZT5K5928+T+86ogO
         k8qjb1p4ye5snh5yxnRYQ9BlAJpSitQzmkftSNGryNwT9VbZHwzFgl7hrg13vTOiJXFF
         0DsnX7Xx/4zu160G04+Rg3CuVXwsEgWJZED3QbjS4oC/GtTFADPmvyAsd7fq1VXLZKDp
         zG+YkAtUeBKzdfsbndkiKw3JMKmp9PPZtXD9UGYRiOF7mvJxE5l5Q1uKFcc/feZ7A0L5
         e4Ug==
X-Gm-Message-State: AOJu0YxZV4GXE+4muar6Pmv0YTZqTXdaDNEEfyqyxGLyhK5YTdy1K2yr
	HBr2gkgJRAes5VpRnFf/N+Zgyg==
X-Google-Smtp-Source: AGHT+IF/8fpCvEIGDrXmUx5N5MNaa0wK6SMmJplMmiMaT3yCHBMZrOlWz4Sysy91zP5hP4V6Xw61NA==
X-Received: by 2002:a6b:5a12:0:b0:7b6:fc49:a5f9 with SMTP id o18-20020a6b5a12000000b007b6fc49a5f9mr27717992iob.1.1702943802279;
        Mon, 18 Dec 2023 15:56:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ck27-20020a0566383f1b00b00463fe3a0860sm1039606jab.142.2023.12.18.15.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 15:56:41 -0800 (PST)
Message-ID: <36c7b425-7e03-4722-a477-67de35895386@linuxfoundation.org>
Date: Mon, 18 Dec 2023 16:56:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/106] 6.1.69-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 06:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.69 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.69-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

