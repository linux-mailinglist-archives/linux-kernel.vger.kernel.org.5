Return-Path: <linux-kernel+bounces-127229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88689485E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290362857E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9914286;
	Tue,  2 Apr 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tNmpcLN7"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372F14A8D;
	Tue,  2 Apr 2024 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016912; cv=none; b=ApsHAp9FzaXqE2jVfDrXMQIdmzzyfwq/7PEXtlzouL4bthKiX9CNl3+w1791nP7x9CG50WOTcggLtawZSFE53hTAmEGYEmzJbU/iHzPsxJe7E34MKzN1CUxWueM0+1JjXSaZJhG4BtZEz9sIqHvh076jyWg+z85Vsljt4Ea3YYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016912; c=relaxed/simple;
	bh=L/cepksWsJAulAIq7KxYXzP5InKjCyjd8aWigQpsGvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/MZoyl1xTapjwfuSHqolmchgtRzXaNEeHy6+KUpa+aijNyoxq2ais5Ty8eHJxm7xxw2fX1gMbyoUvdNWvexkAv2ANforLaYJzZ6z0Rzld7Ij45mSVO7yomi7bpcsiqDknLXvw4wUINvEtIWx5WQ2zg6PjVypls+i21xpzUD4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tNmpcLN7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 98C7B20E6F67; Mon,  1 Apr 2024 17:15:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98C7B20E6F67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712016910;
	bh=IC8o4VTPdCWxCV8lfNPO6z2ktngkRkqdOkjU6TGlf/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNmpcLN7fU4YNiIJUEYi3EZjJDqn1jWNNmLyC5CJNxfV7xQh9vG7R4ESawpGPA/b0
	 qfKL/VRnEIFOO0vza65R7L9vnMY2OhCp0Es8uwTyElAIRsavf2VXFD3sCdpfaSydMC
	 /itSNS08PL7SPU16QdJDSCeQg4SgzUMiPW1KzYxw=
Date: Mon, 1 Apr 2024 17:15:10 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
Message-ID: <20240402001510.GB5026@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240401152547.867452742@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 01, 2024 at 05:40:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

