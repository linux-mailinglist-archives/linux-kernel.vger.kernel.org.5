Return-Path: <linux-kernel+bounces-166054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013AF8B954B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959FD1F2219E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE2225A2;
	Thu,  2 May 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="f+iKHjcz"
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F26219E0;
	Thu,  2 May 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634965; cv=none; b=Kzp8aOSn3Qbnnf312KNHeSql4tlUF80z1HLkVd5Qzle8zEu6oe5SeQgiHTz1Pqj2bTx+MWTwTNkIwIuLU8yGlxiasZwiqdJHm47IGP7Fj2QK1O7dRtzAU8RHoBdsBssHLmgp3/NmufCGa+rNp7LD4Wqke5/PQK6oyjwwaXjxpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634965; c=relaxed/simple;
	bh=InJ1KvTZhJZGkBt9IR1PzmLSGtaJQfTs0v/RJwTc/aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtDM6d3Sbse6oHR6O8coxFitliNZ35EZhZ3T+NDGjFOfrRiKHjqptJDymmTzNsbLdj3nFKsC974on8i+QHnGEK4gFMjagUdQXkR3OGUtsHojXE7gOW8HYV2AYUP0KkxaQozrkP6rDBOOMkv4zU1VBOr6GsJM0I/ITb4dnSvpvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=f+iKHjcz; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1714634962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMyXoskH2fdXecStRSTZuPIAwnF4pStbeUt3ygWVzvs=;
	b=f+iKHjczKeI6oFSsfhP4oFNx5idPyqvt+r+egVsUifGN2ASN3tONhblZXko7xHUKlXDn3l
	JtZ3nnlRTg+1lxAQ==
Message-ID: <daf3d612-283b-467a-82b7-bbf04fd8f723@hardfalcon.net>
Date: Thu, 2 May 2024 09:29:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103058.010791820@linuxfoundation.org>
 <356c4202-875f-4277-885e-31fdbfd746c1@hardfalcon.net>
 <2024050218-olive-majestic-f64b@gregkh>
Content-Language: en-US
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <2024050218-olive-majestic-f64b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-05-02 08:50] Greg Kroah-Hartman:
> On Thu, May 02, 2024 at 08:44:30AM +0200, Pascal Ernster wrote:
>> [2024-04-30 12:37] Greg Kroah-Hartman:
>>> This is the start of the stable review cycle for the 6.6.30 release.
>>> There are 186 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
>>> Anything received after that time might be too late.
>>
>> Hi, 6.6.30-rc1 is running fine on an x86_64 Haswell VM.
>>
>> Note that I have *not* tested building the kernel documentation, and I
>> suspect that building the documentation with docutils >= 0.21 would likely
>> fail without the patch from
>>
>> https://lore.kernel.org/all/faf5fa45-2a9d-4573-9d2e-3930bdc1ed65@gmail.com/
> 
> What is the git id of this in Linus's tree?


Hi,


AFAICT this has not been merged into either Linus' tree nor into 
linux-next nor into docs-next.

I've added Jonathan Corbet because he seems to be the most likely 
maintainer for Documentation/sphinx/kernel_include.py if I 
understand/interpret the MAINTAINERS file correctly.


Regards
Pascal

