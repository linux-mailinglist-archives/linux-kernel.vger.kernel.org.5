Return-Path: <linux-kernel+bounces-36216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE16839DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC14B26FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE20EC5;
	Wed, 24 Jan 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gmgCGszN"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE6622;
	Wed, 24 Jan 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055698; cv=none; b=VqnQJHAxiceZTl30cId6GUs2WZAu2N3jtBSTtCB6BIzevPlYveDmcIEnxfGXVozUqI9ope23Whb5kxvio/C+PXE3qwY8iFzAGwnbS2Ca9kXLg0zskzTjiN6/eOfCCAELhyodRA3rJdu5JCtqYEhaltyrEucxvlYqOewd0VQmU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055698; c=relaxed/simple;
	bh=CdTm+3PysAE5+QoYS8LcEwdazq5TOdnmiBJPNP7RO/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNuvYrCHtpU8kg87TJFrh/rAL1A4BtrUCa9tkI7Zn2qAd6V4JZ7pWZvKlRIRJ+g4XEaIG9HzJym+qbHoY4ClDwgzQyyNu+B2qFZSSoO2CMxfL1sd8LQ5rNeOHEra9HW0i2vwaXDaxT/s+kW5f6UFaLidNX+mSDTegmq8YxVeBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gmgCGszN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id A501120E34C8; Tue, 23 Jan 2024 16:21:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A501120E34C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706055696;
	bh=KbZpvedJOOekg8RiSIRS6rIL13G1DaY4rQPe7msKRE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmgCGszNQTqZokTm/DQq2MDekkSEtL7LmR76qWlZLMkaDOZu4Pyowl70/qv1G+wte
	 k/73YMhQyYuNEmR425tCQEsqg02FfhpLmPTC0sUUo/17D5sToLNEeyWYmx0UhiNrf0
	 iHDvyTkhr9b1YCEUEBseQrqEH3wYrMc0zwUfAsHE=
Date: Tue, 23 Jan 2024 16:21:36 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/371] 5.15.148-rc2 review
Message-ID: <20240124002136.GC24616@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240123174500.819179356@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123174500.819179356@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 23, 2024 at 09:46:45AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.148 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:14 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

