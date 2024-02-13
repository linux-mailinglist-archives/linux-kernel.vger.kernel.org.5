Return-Path: <linux-kernel+bounces-64262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD0C853CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CCB1F2839A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891662162;
	Tue, 13 Feb 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hNmCKpD1"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE161696;
	Tue, 13 Feb 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858295; cv=none; b=QUZmwMX7J1MHdpnTmPSpBIaCQBOhKLsUEYS4NwcJ9GLppd0dyn7mkdjPzgR/Xf22eMMmG/VbZZpHvFAfK4c4Bpb5S9C38gxtVCUOjAuBqiY9J9rpe72Ah6xODT7WjkkMhObmMAi1BxZuIrx6mY9V0swlwH7UIrR1jhpxARFaIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858295; c=relaxed/simple;
	bh=fzN7fzoXqtgrisDWDUX5gMih2YsMgX/u1W7ItMkqisk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTVYXp/2bCqpUfMI1HkVV8H5usBQAxOwLMXRN3MuY8OsV9BsdOVn929KJA6GmqphHueNhEepAsxY8YDzQHQVM3QSlTQ6n7Pj4E8FbjVlfwxjcRoHEyTbTAhdg0DGSVHCsajJi2kNh0thUcqz2RXBpbMLTnN4aiD9/jKtxNVwfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hNmCKpD1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id A37C720B2000; Tue, 13 Feb 2024 13:04:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A37C720B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707858293;
	bh=r7Vu+VfvXMgf9E6eWrz0IvqLWPRYkQdm3rMc0zXslec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNmCKpD1qzf1SHnlyJNGjRBn8eu1lOXv5VONUIWuX1F6m4iBgNsf2TKYYm26YEFnV
	 dl1zeTc+pglU+TdJuLXfzLSTrL/oJzfOH0LdcdxN0Yu4Spdw/MTWtEKH+fr1St4FEw
	 3NTPcannheForft+p/GGilFCi7kOliffjkwTalp4=
Date: Tue, 13 Feb 2024 13:04:53 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Message-ID: <20240213210453.GA9651@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240213171844.702064831@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 13, 2024 at 06:20:46PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

