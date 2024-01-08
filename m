Return-Path: <linux-kernel+bounces-20113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C48279BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA5E1C21BEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AA055E69;
	Mon,  8 Jan 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cgGP3T2l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901C54BE9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bec3b9db1bso5961139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704747355; x=1705352155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FozcbD392EoHS/61C3J7n8Lnu2PFzEqIfm1NNRw0ONg=;
        b=cgGP3T2ll5RDlhl3XPtA2589ZkDl4Me1PA0s82hPmEBQLrWrKOmFeoWT2wK+OmkLlZ
         WJxG38GGjtIJWNACKlyJuzQ5RGl3iRLDtZWwFqNU2yy12ouUJQI0q9XtUAf+imK0OlM2
         MsHjvy+N9ymPL3FeqmzA1HqGKBVuhCkIL6kb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747355; x=1705352155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FozcbD392EoHS/61C3J7n8Lnu2PFzEqIfm1NNRw0ONg=;
        b=FznaVfzrDMB1OcI4H9x8QVUwK7JUigBfF5ZW26l/WCa/Ynbcrbqlcm3XJY1ZHWQhrt
         GjlhKL51Ho/wfzAvW4o3VERchiTWgPzhrUcxtru2pL+FaoZ4QmR8uIVVjIWiCunUmMin
         8OOrk4p8yLvUgPnl3eLtHv/45eTCzApGuoS/cE5ysY0Y65xHCkkaFBqgUxyBIIUOHDZd
         CAd0+V/I/SkIDRuLrily2bdQtfa9iepezdh/8MkwhXwEw2M/K/CBH3kFTyfRAYUtIDcZ
         FUNUtE1kNlrMej0KypyE5R/8oMUWX9+Sswe+D2QF/x0PrUS4SSTLyvidR4b0HcSqmthn
         WXlw==
X-Gm-Message-State: AOJu0YzUBYizmY5+FQ0QQmARuI8Hb+fwELKo214FQ7ZcklmsqBgvhypS
	cn1o8S0KeVo/gfcbTMdy9Yx2evGwTYDiLw==
X-Google-Smtp-Source: AGHT+IEsCxx22dw61jddRHvI4wlX79x52MWlS2DXSCOaDvBDAcalau4rJEE4j1KfiFIF9plGs0NMew==
X-Received: by 2002:a5e:da4b:0:b0:7be:d855:4893 with SMTP id o11-20020a5eda4b000000b007bed8554893mr236092iop.2.1704747354775;
        Mon, 08 Jan 2024 12:55:54 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y11-20020a5ec80b000000b007bc102fb67asm122482iol.10.2024.01.08.12.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 12:55:54 -0800 (PST)
Message-ID: <e51703d0-ab7d-4b67-bca1-74afc760e6bc@linuxfoundation.org>
Date: Mon, 8 Jan 2024 13:55:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 08:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


