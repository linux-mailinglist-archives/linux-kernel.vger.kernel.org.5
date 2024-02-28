Return-Path: <linux-kernel+bounces-84277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FF986A47E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B891C22491
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119320EE;
	Wed, 28 Feb 2024 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OaZQN1wX"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D105EBF;
	Wed, 28 Feb 2024 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709080287; cv=none; b=gzRsOpxvOQWz8c1FYlW+evOEnSWrkfgl7Pmdo38LXl/deb6jMusr7z2v0wiCuSKWi97vRnkSDChfZkQ7IlfK+hihTWWIAqsdaMggD/ViLXOZUVwhSwWDYktpVBmwRSk8vybgLuACGzV19Q/1WC8BSbH+Uf/5XBtIuQliervNJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709080287; c=relaxed/simple;
	bh=YO5p9ewp8cyiy+UwJymkL9pukjS9kGQqbsoM6gdF3r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uofWLTtM+Je83f3VnY2r0IH6d1i4kv0T3/zDp3Ig0SF2bCRqVrMaH1zjd99qlY6Tj3uM282gsFy5avXIYWZdXP2N47iT+4qTuwiPduulap4vSaHy07RZZSqlEuKZWnVgsTIla/K8GgT7Oxdv273muf1Y4jfDcnUteXvezc+myws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OaZQN1wX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id D4B3020B74C0; Tue, 27 Feb 2024 16:31:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4B3020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709080285;
	bh=MrtRKa4GY/IYxjZTBG1PwEQWlF8Ns9CgiTs+opEOoEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaZQN1wXCBfeL9xq6TG7aG1+XE52OC6VsX2zowo/jXfMMop5Cdyzm7Q2FFThaQyuU
	 RLGpaH2XTbiCznNRzX8On3E2yk1KEQi5NyrXdZlhDw/jz7e8QQY+27mO8J6D/zwfrX
	 HRMF4yPmTG0G1P7VAefalNxH6V4rkvFsTemhBNmA=
Date: Tue, 27 Feb 2024 16:31:25 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
Message-ID: <20240228003125.GC24086@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240227131625.847743063@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 27, 2024 at 02:21:51PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

