Return-Path: <linux-kernel+bounces-141481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4E8A1EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C91B28E029
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA40B40BE1;
	Thu, 11 Apr 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i03MxOyH"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8C41744;
	Thu, 11 Apr 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860592; cv=none; b=et3GpFK6LYLHbAaxo87ZdbaByI+tjBcNtOqddmRYaIXFkse8pZZFVjoBbn6OSeBYXDUifVNr+jutufWFw5kYeGTL/uNsZGf/ZOss64WCDkd/ukQsmqJL/AmlfWV33nj7oeXC8fi0zxXJ78VHDxF3x1SCXotcpc31Wk8QgjVIILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860592; c=relaxed/simple;
	bh=Ft8JfQvHCLY2ghv8Ss761BEC9TQ/5kAvBzYcfHLpbv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU+RPY1yEo8xAlbP7S1LNsIdgy8VoM80IVmfQo7lktsJgC417yKbcyUUWZg15xR1nP8E+Kg/KoKxz3iUjUfEx0figQKmmlqwIIq3wzNDmdQ620NJwl4NNoR4escZZEbMPJ8J7r43POTYrTuVKxS91+GXTTxGgYSw5uZk0AzMKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i03MxOyH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.216.186] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id B898E20EC303;
	Thu, 11 Apr 2024 11:36:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B898E20EC303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712860590;
	bh=dN02yDdDosiWONjItu2a2iqcmYH10EILRT9j765+B5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i03MxOyHvZgSveQDWlCKvQEtyl8z5xvR5xn2cIVSL2fxgn+eautwWvzvjLpycNxb+
	 W4hHzDLGsvFBtVdKuYI0456oklEZoeTa1vYozQzZmJnEfJKLWw616OemoZqv3uMRy3
	 Yhmgkp+2Z/8gQWPWOs5O9kD3Xzq3qlfFY2uJsA1A=
Message-ID: <e944c094-b503-4a9a-a5d0-487c8b056e34@linux.microsoft.com>
Date: Thu, 11 Apr 2024 11:36:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095407.982258070@linuxfoundation.org>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/2024 2:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.155 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

<snip>

I wanted to repeat my request from another thread[1] here, that we revert commit 4949affd5288 
("ACPI: CPPC: Use access_width over bit_width for system memory accesses") in 5.15.155 due to
known problems with the patch, so it's not lost in the mail storm.

Thanks,
Easwar

[1] https://lore.kernel.org/all/97d25ef7-dee9-4cc5-842a-273f565869b3@linux.microsoft.com/

