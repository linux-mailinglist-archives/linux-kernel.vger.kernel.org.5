Return-Path: <linux-kernel+bounces-36215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE1839D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F611C21673
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43496EC5;
	Wed, 24 Jan 2024 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iCWj5trO"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B616622;
	Wed, 24 Jan 2024 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055679; cv=none; b=Jy5T+scq2wO8Xer/aqILMS0EwvdgKMQ2cpzvj5CpRo6ooRlUbtJFmyYijBWhAASLAp/AQfN4mHTom/EmvFxCzP5cgEauKb352ufdxuZ/DimHdx7AYiEaooTSFfsQIL1HU/n/S386MJsybOImZlnVNlS4mg3Uv62We3U9fvlleYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055679; c=relaxed/simple;
	bh=Mz6BEXTAuTt+PgF7urme+KMAPaSfBRgYh4BQ1N+/4Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwzT/udoqDUSXFuIXzYQDXbjm7KdrzBq8txJli9c+Y3tZIuL9gxdILVLAxQV7RhHmCw8g/7gTMCLJSy12ubnOc3E1BUVUjHvL5dWGUNIDJJGnCJIiz0eOiM0nsSJAAzcEXybsJ88iwr3Ms2x4/ljgzvLEAjRhKL3vd4ja7WqLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iCWj5trO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 13BCC20E34C8; Tue, 23 Jan 2024 16:21:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13BCC20E34C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706055678;
	bh=fn0BA6f9QKKSK2GUbwMrTqkF4kFyiVig/mbOROBwOpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCWj5trOBTXvYSSd+abMHabCSdfxPFJjFUg73mcK58brQNWFVBZ88ajZbThXIi3Da
	 yAZXezb3fXxyKeQM4HOI71DQEGXVWkj/p6b8k95vamLRYp+xDgrC7GFtALP0VqGVrV
	 7pGNDv1kQF1/CfFrFJVVhuD0tnuEV+wW6lRmcFIQ=
Date: Tue, 23 Jan 2024 16:21:18 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
Message-ID: <20240124002118.GB24616@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240123174533.427864181@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 23, 2024 at 09:47:11AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

