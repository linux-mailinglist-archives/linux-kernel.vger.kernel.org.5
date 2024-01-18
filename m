Return-Path: <linux-kernel+bounces-30351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97DC831D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127D11C22415
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A12C6AD;
	Thu, 18 Jan 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVpaGvP9"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB102C6A2;
	Thu, 18 Jan 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595750; cv=none; b=ahUfI/LQDuz15lxDzDBScshvdFe+TlIPqrct+DnTmZHfG4LhYkCOPP54LGRNQX+6CKTSttAOIG1RqaVvw8oFz0/IA/E6zOb+DWkTx5jY1CTJ6h2+DgNvzs2bT0/Zc04KsockLADbTExV/QHis4mh64wiauLKFuYiUphGw2pi388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595750; c=relaxed/simple;
	bh=HVtIWULhKgdre+jmToxGqERh4Fcm+IoYq7p6h7HkQ6E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=XDek8eeRLXL2Ru0Oy00kF8uQAIoDOf5Fee/afkMoIFaOGHQdwll4oZwkNeKykzLW+OX5Wyat1Jgll4KvZZRvaPwZ+WCeERKihAuS2Q3i9D2LQfg5i+YANmPu6FWrx3TDKlcXQfMlH6qE6mNHWX5R/8t9xIijtLYLSGw3a1uRKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVpaGvP9; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7cecc0a662dso2104663241.1;
        Thu, 18 Jan 2024 08:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705595748; x=1706200548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gpvBWl64BM2U+Fa3xxlD+umyFQJyzuRde12Sfj64vBo=;
        b=MVpaGvP9YRJ6RjFSVsQTGH8Q7Ef9A5bKnp6lno+s4DDJ8CIYYKccyKyvE9AIECCNIQ
         3CtYyqOdDLQ0iut5/OCmyqjyWFrCQcLhLiumQhtn0qtFp69rsCSbRUw0DAG5d0M101FQ
         0ZrwkN5RKVAMIlahL/p6O97u3qLKw6fWeEWD38++LFMBeJdmIM2ss/CVHnNr+wt1Krso
         RczYhDIx9uV1+F66R/T1KS9aqXv93/3XeayNExXOrrWt1UcFv9TTHXGqY/15sEorzRGA
         ai3TFSkclmqZml7y+IxSxI7yOPhNjnwZxd5FTKwaM+a/AXXUZIBZHG4y5dNLkAHpHNGm
         +wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595748; x=1706200548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpvBWl64BM2U+Fa3xxlD+umyFQJyzuRde12Sfj64vBo=;
        b=fAF4zzPYaOEDF3j6n57i+huLM1BvlbIhY1C3uYzqKNV01NZ45NWIdZ+i6OrUmQE6rw
         IpAO2clTHSmOrRmYj5bo5kJlrjeHRqT9FXBljXJhc/RAw2GUnRW2BZuIvwEFemNp3T2H
         lny51dVTca+9zPKwSoPufYyrnTpWtG2n078Z62SGDMHav7es4UZmLq05ml9o2hf1d2LG
         BT7ef/1qMxGO+O/7FMbrlMqWB6g0PiHySKXVkie8ZNfai0X7Js5vtbgtSG1QEa8jwvCG
         08tTnHNEQQPnxKyS4P0qhoPIYLKwnLsjyzXke88qPSuufqzo+g/dKUn0569OqRAJwEBs
         GGuA==
X-Gm-Message-State: AOJu0YwpYpIfvESFvEklm5kp3KIe+y8ji/VFlgS3rFTp1UbD4hGn7FZQ
	n0xr4Lugvge9jHjL+a8UZBqJfIpdHwF3qbeJr4zGhaPJ8PbJ6VDlBUhbac1A+nVBuJ3XMrNm96V
	6FR7CxQKpSU6u5ndRWbABF9Zs7d4=
X-Google-Smtp-Source: AGHT+IGMs6yZyS34Oap5tc2ZDXBJhIXQx0gOhbO4B68g+nsccnaReqwgyA/t+qBdbyFSF6xrgOnuxZep/LYYPo8vPfA=
X-Received: by 2002:ac5:c8ac:0:b0:4b6:d3f2:6d26 with SMTP id
 o12-20020ac5c8ac000000b004b6d3f26d26mr726202vkl.26.1705595748326; Thu, 18 Jan
 2024 08:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104301.249503558@linuxfoundation.org>
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 18 Jan 2024 08:35:37 -0800
Message-ID: <CAOMdWSLdLSOMpNb24CWDDOf2qH9ZLw+7_+vOmAiDWB6St_XnBA@mail.gmail.com>
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

