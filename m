Return-Path: <linux-kernel+bounces-146022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D97368A5EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C887B20C19
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B2159913;
	Mon, 15 Apr 2024 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XyMd7fqJ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8554159591;
	Mon, 15 Apr 2024 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225209; cv=none; b=aQkAWkgGTZvjtHM+Pq4ATckZaFfHmuAXSi9CqIk5ms4/HrYUPm8eN/FJlOBvSJfxv+c530Rxmc9Y6DSdxNJwIui+8AqrLjSDQjX4BJ/lQ4J6wCYjOZuarb4iXp5+yZ+LVZP3OZQCSDrBCVIbcuKJHyFozlbOhUVD+jlggstZIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225209; c=relaxed/simple;
	bh=IGEgV9i5prZjOOhn9NHJ88hW0jvaLTE+ORvIm3DROSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j39dnv/FnyFHO+2S2gRJJqLQlIe/rrZKx/FSlQCg45R1k/KwYSq2UPQ7lWq6nKlD0afMrRNqr2XSSG2zQALDVlWjgMG1qtBlUdq40lqZKtKF4tmDdXgMwQAKtgH/7mJtzSvE15hktbLkiKIE3WywJmJUqRAEt+ua/7veKBQ1t2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XyMd7fqJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 6F71920FCF9D; Mon, 15 Apr 2024 16:53:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F71920FCF9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713225208;
	bh=nTs39I7ll8z5rWDZRJGSaYOBXUW0TLZ4vfS/4WYtHC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyMd7fqJoI4Haq0x8JjWWvD9shwyLM97MjksJKmQfFjME08XNVuDpuUPJD2HH9wi/
	 8xtovzlmqsCaULjCjQdv9+vVEwGl8PcwmYmQaJfyYoHlU6C4VGKL4cUCVyvZMjLrmg
	 K38e3aA6mbZVcwSfL4G7X5WWeXxbtz1nitzzFj78=
Date: Mon, 15 Apr 2024 16:53:28 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/69] 6.1.87-rc1 review
Message-ID: <20240415235328.GB11121@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240415141946.165870434@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 15, 2024 at 04:20:31PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.87 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

