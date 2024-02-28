Return-Path: <linux-kernel+bounces-84550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC686A82E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF071C22CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CED219F6;
	Wed, 28 Feb 2024 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4FhzALR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA92224C9;
	Wed, 28 Feb 2024 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100229; cv=none; b=nNg0nDpphFCdyV+K8N+a3nktMS8sihhb42as4BpzT4YFAQS/EBUvK1MOEem58Hele5hO+0ykz9K9nz7ZNf4w6jdDhqoPepMlVShPot8OUzBn0+y/EeF2xwHfaJtMWcjimLAyJR2FuXZ9Cq8AFzhZKBKvd0gwkJ2Nugz2ZO6v7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100229; c=relaxed/simple;
	bh=F1lpd6mjzs77VPjPOAqOkZLOH3pI/TjJeE/2xlIYQ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDNWRMD+UfIDbUo+KUopXHVLFBmcxTv3xqRitMXvbNABqFAyAQGqQLSVBlWAful0aSJOUoEyQKm5SK1yzd2LVLC7d0If2s4gNYFLlZP6eI+t9j9nD0gfHtf/IdonJ1wYCRUyh26tCPyIUmoSBuBB4L+6ySah0I8yEUrvnEgz5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4FhzALR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32610C433F1;
	Wed, 28 Feb 2024 06:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709100228;
	bh=F1lpd6mjzs77VPjPOAqOkZLOH3pI/TjJeE/2xlIYQ3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4FhzALRzNHcp16ljheOWIch2gXYn+lqSOa7IVXx6vdCspMCzLn/R6jEitQCADUyL
	 KVhOlQW8FCSghRDGq8jKdPFsX/UYLYmlHlRP8ajUZQzI+K29wdn9H3fC8PEiNtft/7
	 vhNDg/4YY5kwSg37hKyNc1qWmcZ+sLn9MuP0UPfk=
Date: Wed, 28 Feb 2024 07:03:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, kuniyu@amazon.com
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Message-ID: <2024022816-unclog-cohesive-79c3@gregkh>
References: <20240227131558.694096204@linuxfoundation.org>
 <0b1b1523-3f26-4ce3-bdeb-4df3c2a8e685@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b1b1523-3f26-4ce3-bdeb-4df3c2a8e685@linaro.org>

On Tue, Feb 27, 2024 at 12:56:00PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 27/02/24 7:26 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.211 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.211-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We're seeing new warnings on 32-bits architectures: Arm, i386, PowerPC, RISC-V and System/390:
> 
> -----8<-----
>   builds/linux/net/ipv4/arp.c: In function 'arp_req_get':
>   /builds/linux/include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
>      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>         |                                   ^~
>   /builds/linux/include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>         |                  ^~~~~~~~~~~
>   /builds/linux/include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>         |                               ^~~~~~~~~~
>   /builds/linux/include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>      45 | #define min(x, y)       __careful_cmp(x, y, <)
>         |                         ^~~~~~~~~~~~~
>   /builds/linux/net/ipv4/arp.c:1108:32: note: in expansion of macro 'min'
>    1108 |                                min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
>         |                                ^~~
> ----->8-----
> 
> Bisection points to:
> 
>   commit 5a2d57992eca13530ac79ae287243b3ff6b01128
>   Author: Kuniyuki Iwashima <kuniyu@amazon.com>
>   Date:   Thu Feb 15 15:05:16 2024 -0800
> 
>       arp: Prevent overflow in arp_req_get().
>       commit a7d6027790acea24446ddd6632d394096c0f4667 upstream.

Ugh, I fixed this up for 5.15, but forgot to do so for older kernels, my
fault.  I'll go update it now.

thanks,

greg k-h

