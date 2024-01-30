Return-Path: <linux-kernel+bounces-45395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24974842FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AB71F23FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3A14AAA;
	Tue, 30 Jan 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bTloNO5J"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD371B52;
	Tue, 30 Jan 2024 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653598; cv=none; b=qVK2i0qpJVC8Wq6qBm6KKVndnTeg6uZFyn4muoHhAW3WF3yAbs0OQn0UVjUIXGc9Y+1QfhIzmo0FdGTkN993KR2VbXSAmCsM/a2JNUH4wTNAZRk4EIbuxrNdgbFkeY+rBehYoM2+50pMy9sbAmsu19UV/RcPLCiMsf3JSLiQ3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653598; c=relaxed/simple;
	bh=qDbatyl7TuVLvbsdwD3VoXNlDb/0Z06EvCU6sfzFnhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWc6mQXDjgkp+ZfNH/b3nYtycNB618avkgsQB2ambxvLIOdKKjUoYZ/l+D5vvMATC1KypN2Nex5zNvcVfy+ZRCwdLnJkqGefPxw1RHvtgtZW/R3iHPXkuVsvYHNDDnhgtm3+zfc3CqGegtZX8mv7AR0+anTzBS0H4O6vfHypkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bTloNO5J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 383CD2057C0C; Tue, 30 Jan 2024 14:26:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 383CD2057C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706653596;
	bh=DIV4h+mi+lV8Etu39UHsp3WDRvDDZ/5dIzoWPcFdusY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTloNO5JPk6ABjlnKhDBUeZh2QWJMD6iWXh9gNLFTCS0xuSN6nteMaKNuNgP9KYMJ
	 5cNrVZ2zlaESAZzYskGJfE+VHPAEvWBN0xsvYCNgty3EvwVpFgGwqB9Lx4lGjv7z5o
	 gp3ku2k8wL++9yHYLTdYhpQ8y1OcJOh4T2Hw/Krw=
Date: Tue, 30 Jan 2024 14:26:36 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
Message-ID: <20240130222636.GA14930@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240129170014.969142961@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jan 29, 2024 at 09:01:04AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

