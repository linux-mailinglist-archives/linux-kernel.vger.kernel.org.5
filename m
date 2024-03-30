Return-Path: <linux-kernel+bounces-125644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD36D892A00
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCE41F22392
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81366C154;
	Sat, 30 Mar 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwNLVC3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BEBE6B;
	Sat, 30 Mar 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790400; cv=none; b=I025abyA03m/L66vJVWBuuMaBnirdY7F+Hlr2io2A7js3dtDxOhJ0faQmHxXbk0kl/5Odco+33xIV+rI/X0ycQXTxKIwi77AnI3ib0318qid4Xrh3SSqvEv7wf/S6oWAzjW9rY39EjrhROuJm9E6wYGCaxrHcgrnD0HC30OX004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790400; c=relaxed/simple;
	bh=1ljIGYteHhKPVcUI0iKycGN4KMTT+Uc02PVKqlt0zZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgGxtoeLcRvXLYIDnMyOFmrYQUadFk/e2Iy8UiaSAiEKT9q2/79QLfgfrI5yaem24PcbRfQiO6RZOf36qlvwnLqAaxR/0253oeJiO6PmKtoVINuWfr1jeTGYauW4mpGixpX2RY0VjMEZH2TQJBCUzOyo/dLSXYJmp9pA09vduH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwNLVC3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868BFC433F1;
	Sat, 30 Mar 2024 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711790400;
	bh=1ljIGYteHhKPVcUI0iKycGN4KMTT+Uc02PVKqlt0zZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwNLVC3pNLlyk/7Z4sfem/DccnunranQoMwt3mC6siAnuCh+aqBPqBVdDsjYkhM3V
	 e/JrQ2Rgn7SM4lBwgcU52USXVzwfspga5fpUn74tUC73XUBQnL/tScYCheqbUkO9sJ
	 OMIFRpJooVhs9NLRhzwmxyYol8hwhen8oNgUxflo=
Date: Sat, 30 Mar 2024 10:19:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 4.19 00/41] 4.19.310-rc1 review
Message-ID: <2024033031-imperfect-jukebox-ea4f@gregkh>
References: <20240313170435.616724-1-sashal@kernel.org>
 <305ed269-b7f0-4ba2-9f63-ea15480fefc0@roeck-us.net>
 <ccf81903-b991-459a-9a3a-8d46efd909b8@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccf81903-b991-459a-9a3a-8d46efd909b8@roeck-us.net>

On Tue, Mar 19, 2024 at 07:24:37AM -0700, Guenter Roeck wrote:
> On 3/16/24 13:57, Guenter Roeck wrote:
> > On 3/13/24 10:03, Sasha Levin wrote:
> > > 
> > > This is the start of the stable review cycle for the 4.19.310 release.
> > > There are 41 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri Mar 15 05:04:34 PM UTC 2024.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > >          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.309
> > > or in the git tree and branch at:
> > >          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > > and the diffstat can be found below.
> > > 
> > > Thanks,
> > > Sasha
> > > 
> > > -------------
> > > Pseudo-Shortlog of commits:
> > > 
> > > Arnd Bergmann (1):
> > >    y2038: rusage: use __kernel_old_timeval
> > > 
> > 
> > Guess this wasn't build tested on alpha, making it unbuildable on v4.19.y.
> > 
> > Building alpha:defconfig ... failed
> > --------------
> > Error log:
> > arch/alpha/kernel/osf_sys.c: In function '__do_sys_old_adjtimex':
> > arch/alpha/kernel/osf_sys.c:1274:43: error: passing argument 2 of 'put_tv_to_tv32' from incompatible pointer type
> > 
> 
> Following up on this, I now dropped build and boot testing of 'alpha'
> targets for v4.19.y.

Ok, let me go unwind this and try to fix this up in the next set of 4.19
stable -rc updates...

thanks,

greg k-h

