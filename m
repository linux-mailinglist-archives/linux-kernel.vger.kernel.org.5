Return-Path: <linux-kernel+bounces-121429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A7588E7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD431F347CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E6147C79;
	Wed, 27 Mar 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="efm+yqeZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB512E1CE;
	Wed, 27 Mar 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549527; cv=none; b=BrKI77d/EvCuJjza6KvrroEDSYcor5N3Y9ZsW9E9za85Z4rIceToIYVQUDJDzFWlJ9IfLQoweK7lyeT2NZwUjYTAp/086D0oYLA7Q8U5+TlWiuuCsDuqvHhjuvtsXNk8mKKMfTBDpMZ8hJrKj0MtKAyblg34PHDSltwsEPRdOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549527; c=relaxed/simple;
	bh=PCLhu36SUCSWD5hd9q/ImeV2OBTVcU1BHYANgskVWXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=attaiVSnpHnpA0NhkwOrEmfKviJ2SwqL/PbvSwHv/0UJ5dIEGPp6o2bp91k64pXx/fQGPlUOK1wL7ebs0ILmV+w/Mg1rm4w1+H8bren2SX4OevuqgZliXYI9BeECBOXd7CNXnnHJxDtZrh1c7u3PE6QbRL5Swf+h8o5EJK8P3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efm+yqeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D26C433C7;
	Wed, 27 Mar 2024 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711549527;
	bh=PCLhu36SUCSWD5hd9q/ImeV2OBTVcU1BHYANgskVWXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efm+yqeZcz77LonJiFyjEJsh7JcQ+jobo9eHseizLeiCk9Q+anM4jxl+Qq0bVoJkF
	 hK/d2VA+jQ5zhx+KUZ5bFCou5YdJitg9SbIooXMkX4zEsjWeeGTWqud7cfJWx2EXWP
	 Kfei5q+6flnyUUd4NfLVjS3XdT1Z1C2nyZdqhxD4=
Date: Wed, 27 Mar 2024 15:25:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	florian.fainelli@broadcom.com, pavel@denx.de,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
Message-ID: <2024032713-paver-irritant-7277@gregkh>
References: <20240325115928.1765766-1-sashal@kernel.org>
 <e114d9e5-26af-42be-9baa-72c3a6ec8fe5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e114d9e5-26af-42be-9baa-72c3a6ec8fe5@oracle.com>

On Wed, Mar 27, 2024 at 02:09:31PM +0530, Harshit Mogalapalli wrote:
> Hi Sasha,
> 
> On 25/03/24 17:29, Sasha Levin wrote:
> > 
> > This is the start of the stable review cycle for the 5.15.153 release.
> > There are 309 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> > Anything received after that time might be too late.
> > 
> 
> We still see this: Same as what Daniel reported at [1]
> 
> drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
> drivers/cpufreq/brcmstb-avs-cpufreq.c:486:9: error: ISO C90 forbids mixed
> declarations and code [-Werror=declaration-after-statement]
>   486 |         struct private_data *priv = policy->driver_data;
>       |         ^~~~~~
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:289:
> drivers/cpufreq/brcmstb-avs-cpufreq.o] Error 1
> make[1]: *** [scripts/Makefile.build:552: drivers/cpufreq] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1907: drivers] Error 2
> 
> [1] https://lore.kernel.org/stable/20240327015023.GC7502@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/T/#m15bff0fe96986ef780e848b4fff362bf8ea03f08
> 
> 
> Looks like, 5.15.153 is released, so we need to work on fixing this.

Will go fix this up now, thanks for the report.

greg k-h

