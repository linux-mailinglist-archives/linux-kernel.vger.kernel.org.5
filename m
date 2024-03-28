Return-Path: <linux-kernel+bounces-122454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276AD88F7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF151F271FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4074EB2B;
	Thu, 28 Mar 2024 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u2gC3yo0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974351CAAC;
	Thu, 28 Mar 2024 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606213; cv=none; b=tdaUuBBNDgJ8bzNykHAL9Tqq9cRJ7GkdWjZ5xxQjMbkD5oa7dDUOKiT7dMjvgPN8CVf/cEuEjVIUZoD+qU+WL0EAbwMSIHWR5dV+068Ehn6y14d5C4KZK/0wqvKVj8+NSiCMARl+RoX9f4I7/G37W8+eu6NzBeQII+8fRZy9NSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606213; c=relaxed/simple;
	bh=w34YcD5mqMghawOrS/lU0OVpXNYKwgpFDiWMh0yR6Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Toh+Az6pxVO/wLyqxCtX2RjL+qzhaQgeRZ+nDdA+JjNmBK1SdcRWwc0pfNjjZ8wYR1TXPIjs6+tqFuf+pt6UwGzalcYsQsVjmMqAVydE237eiAsgkXIpSmMLtvdYqUq7ahNmD22KLHQuRzSAeNkltV9x3QG2Ay+IPMJ+5gsHUnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u2gC3yo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0FDC433F1;
	Thu, 28 Mar 2024 06:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711606213;
	bh=w34YcD5mqMghawOrS/lU0OVpXNYKwgpFDiWMh0yR6Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2gC3yo0D+k0KTNhNcifrk0HPqPxPEkUvY1DLEtdJASXjpLyb+5ywZUW5weAI8Bgi
	 9B+TyxKPIqF1Wa27S2MHQQRjpQyHnd+1AaQCeaQ9mpX9tnIgY3F1sgRsjoH3vlvvIC
	 o+u0EvBjDtZKtyRG4Y0Bq4EX+oHIgbLkNLlQH6Fo=
Date: Thu, 28 Mar 2024 07:10:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de, Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
Message-ID: <2024032802-catfish-wieldable-9b04@gregkh>
References: <20240325115928.1765766-1-sashal@kernel.org>
 <e114d9e5-26af-42be-9baa-72c3a6ec8fe5@oracle.com>
 <e1cd8fc1-5aea-4242-8220-9152853f9baf@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1cd8fc1-5aea-4242-8220-9152853f9baf@roeck-us.net>

On Wed, Mar 27, 2024 at 02:44:48PM -0700, Guenter Roeck wrote:
> On 3/27/24 01:39, Harshit Mogalapalli wrote:
> > Hi Sasha,
> > 
> > On 25/03/24 17:29, Sasha Levin wrote:
> > > 
> > > This is the start of the stable review cycle for the 5.15.153 release.
> > > There are 309 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> > > Anything received after that time might be too late.
> > > 
> > 
> > We still see this: Same as what Daniel reported at [1]
> > 
> > drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
> > drivers/cpufreq/brcmstb-avs-cpufreq.c:486:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
> >    486 |         struct private_data *priv = policy->driver_data;
> >        |         ^~~~~~
> > cc1: all warnings being treated as errors
> > make[2]: *** [scripts/Makefile.build:289: drivers/cpufreq/brcmstb-avs-cpufreq.o] Error 1
> > make[1]: *** [scripts/Makefile.build:552: drivers/cpufreq] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1907: drivers] Error 2
> > 
> > [1] https://lore.kernel.org/stable/20240327015023.GC7502@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/T/#m15bff0fe96986ef780e848b4fff362bf8ea03f08
> > 
> > 
> > Looks like, 5.15.153 is released, so we need to work on fixing this.
> > 
> 
> Same problem is seen in v5.10.214.
> 
> drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
> drivers/cpufreq/brcmstb-avs-cpufreq.c:486:2: warning: ISO C90 forbids mixed declarations and code

Already fixed in the queue, thanks!

greg k-h

