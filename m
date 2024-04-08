Return-Path: <linux-kernel+bounces-135898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD189CCD5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D97F28433E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D9146A6C;
	Mon,  8 Apr 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bDST9qjZ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB2146A61;
	Mon,  8 Apr 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606872; cv=none; b=SxlwkouE2x95rBrU/irRQLSowi++bLD85+Em6ckzst5hFSsgJGzNQD4WWQg81BErfhjxhEhkQ3/E3xMqDYptxkvh14aAHce9Iiln9L7/nqJHJzpFon+SlA0oRjCod/NRtaBp60XX3xaFvQQKUuzx3RbO62VbFzjO/aZodCkrz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606872; c=relaxed/simple;
	bh=4RZHrWkSKjopx8REdxab1MAvkQJ5KivRTA5z1yQcJIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zfwjt3lKQ71GePIoahhH1dAPVxh6MVpTi42fgYqIIXA2iBBlCxs4PVD/qnSFOv3QoYvZ9Q26eKeQlzBmXxR3gZjc/9MsEHtVVX0zqWxTmaq7bsKV6UyNqa4r9b9bKpMqQOvj3S8/IgcMvpHCY/CBju9kcs98Vj+lHD6cWl9P2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bDST9qjZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 204D220EA447; Mon,  8 Apr 2024 13:07:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 204D220EA447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712606871;
	bh=/kc4M6yJ9qTJ0sFpqQ3vqEH4Z4qCN5AjMiJU2JS9mYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDST9qjZr/ZxkAdA+Ut8T+JOAiK3HhvqV6QACHAhk9jemt4qYdGKSrq0GTB3Jp5Ce
	 nzHWTuFwj//kaLoT/7qBlh6IQh/Yh33c+tavDFgMvU/YsBBLwZPXGFTRJeUWFk7xaM
	 FcYQL3BvvNOrV21ygwH9YoXBunXPmB1F9rQCYAlw=
Date: Mon, 8 Apr 2024 13:07:51 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
Message-ID: <20240408200751.GC4018@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240408125306.643546457@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 08, 2024 at 02:54:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
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

