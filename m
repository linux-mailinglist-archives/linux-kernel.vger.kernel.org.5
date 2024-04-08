Return-Path: <linux-kernel+bounces-135897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876A89CCCF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193EF1F25684
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572E6146A62;
	Mon,  8 Apr 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JFs9ax2s"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCEA14600B;
	Mon,  8 Apr 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606844; cv=none; b=nl/t2bgMDcHKrJnBGzBQK99otTYF0bgEnSDyHbH47J1GQa5mE2jmnBhKvvaHoOzz1ebiDG8dPOsFyYDa5T5xkNZ/KhR0zODFuMu3WfZsP/QGQm+6UpfcZbWT2P5Lhcz02hEO3MDw1R9jpqSATkBv7HsUIwAws8CiAj/hIvIbxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606844; c=relaxed/simple;
	bh=WltlHLDq8LjdpWjch2/J8wP5JU1xpBITzt0AMqnStb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aREUYzVvpyr0ymPzP8IEJrGgXnVGTUxX0kraG2+FPpO2g/mTI5swS3l1l8UWPJzRjuMU16bFqY7eJtBUIFEY9IWvl+v4sfYmf1ATayOCFJGMhQfFU4/ZHZEExm8vLeUccU7Clk3J01DLm8k7xN/+Oh8z+/NDPy71uAv86pv9fcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JFs9ax2s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 0BE4520EA447; Mon,  8 Apr 2024 13:07:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0BE4520EA447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712606843;
	bh=/aSrf1DAISt0waV7+s3IpY74Ne1v7uCVuxm1tptDBv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFs9ax2siOb+i8mnnZVVm9CxwV9b8MDWbYRc+eS2bv8u6eFb9IzplJY0NPcj5mGJ5
	 eRTi8bQJgX0xWXY0KTHJzVQzZsURWKFJXhX2GfyQh6oBNUGXUiRRh2I9C4zgwySvM+
	 1SaCZ1bXwsmY9rHfjxRO9kXKn0AaiKKMHvnjIzWs=
Date: Mon, 8 Apr 2024 13:07:23 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
Message-ID: <20240408200723.GB4018@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240408125256.218368873@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 08, 2024 at 02:56:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

