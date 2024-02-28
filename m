Return-Path: <linux-kernel+bounces-84270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918AA86A466
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D932896C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E4A3C30;
	Wed, 28 Feb 2024 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TAEJ8tYb"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1011370;
	Wed, 28 Feb 2024 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079935; cv=none; b=Z4Dyebqn5LJqgSrc4aeU11Cp9Wjmf+pB9F2y+bUDu3iw1vMOQzwPzd8pe+i48uvZBXL357j5TG9suHiN6l5FRo5j+S/w5LKqLn63QrtCQABDxcJs2vYJIvl7qqFXPyw9svQ5rUHlwnWDn1pQzKGBGTJVYosMLWxtk/wsgRTESa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079935; c=relaxed/simple;
	bh=9PkFuAQnvHLgybqYTSuG4miDXpSkxYeaVLIU3V8OPXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXDQiyA8rvJD4oRVZcRxA61fi9yXQmdM7KluiZn5km3AB0jaJHOK9yH2Agr6j06S4p7cc3TDfOC8B43ftU0e9xJi8t21mDmsKG5uxt76on8AeYaKtp3Kk+WQQ/onITtdftoIvkkm9FvkRaHjO6ZS2RVchmXVsg5QBFHtyupqmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TAEJ8tYb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id C07CF20B74C0; Tue, 27 Feb 2024 16:25:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C07CF20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709079932;
	bh=/XtuIasPbJ+pa8jkpkpOnHa9UC5OeliChPUOffyAgm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAEJ8tYb2k+C87Sr6K8P1CHW6PPqCqH0+HOsis+93dQB0CtTb3oFzSp4nrQsFbnkM
	 4qByworn2L2nOAWrWxJ6shC8ZxbdGvSry3ftKycBquHWNoiQaciNDMH7qjaizngDGC
	 fQaQjUo2dqIBJjNipGE/J4a+VwdK6fCSSxBc1MhI=
Date: Tue, 27 Feb 2024 16:25:32 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
Message-ID: <20240228002532.GA24086@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240227131610.391465389@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 27, 2024 at 02:24:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com>
 

