Return-Path: <linux-kernel+bounces-135896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3170C89CCCD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A6D1C22295
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193A146A65;
	Mon,  8 Apr 2024 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JcfcUPfs"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29E014600B;
	Mon,  8 Apr 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606817; cv=none; b=d1v7MUnOe+WGZteviiq7Ht5zdza+xF3T5R8XfannVMEYc/nybkVcsWjfArgBb4wBPqcg9yj/R7fgQrlba3kTCGH5JkKp1LMrltwG9vDSq6Kdlvb9M6YlEP6nlo1zt82Z81vHQ6SaIXxfY10eEFpACON2veydTIxVNuV0Q6vjZic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606817; c=relaxed/simple;
	bh=uP8p+u907i0fX21wYEXgRHvCgXzf0/e4KsgBCY2n9Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuHB36nKRGDQrYlBZN6hIs4ISaAe77ZUgtZJxrdka7gpx6ISjxYgeZcN0wsfLda3Phr9hVqLDGOdWYFSDVcnM5lIZtTiXiSAD8GX7JUZx4+x07ohCgxBd4otIIN53VBM2XMJ/IjLP4DBDucEPuL9dauGuB1+aVg6srIuV69YsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JcfcUPfs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 703AC20EA447; Mon,  8 Apr 2024 13:06:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 703AC20EA447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712606815;
	bh=xBr69HjT/zSd9c72AkS35t6i4F3bTZq50jzsNrhgI3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcfcUPfsQaJEylqoFo5J0kA6eRR+FWcY6sL1ws2uT/M2Bna+APb0eKCfZcIN1XMdH
	 VtFQfKrBUJJeZ5NqPXnBfrBBZHMJI3W/NzcAmY0xxIJ5e04/75U+/h/JacmnSkoDCc
	 hjnnAE5GgcbUm8wRzg2QdG5kqtLPCKzXQucq/CGw=
Date: Mon, 8 Apr 2024 13:06:55 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 000/690] 5.15.154-rc1 review
Message-ID: <20240408200655.GA4018@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240408125359.506372836@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 08, 2024 at 02:47:46PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 690 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

