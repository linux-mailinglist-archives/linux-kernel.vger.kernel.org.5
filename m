Return-Path: <linux-kernel+bounces-51167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCB848746
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB35E1C22B46
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0695FB99;
	Sat,  3 Feb 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iurWTXJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDA5F846;
	Sat,  3 Feb 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975859; cv=none; b=h87nSIwbSTri+aVQx+5zAtG8MilNmz6G10yqRgd24dl5P6zccCcCri4ObeO0dK1HjFm08clHFu8yLMK4Ikg/H14eoNpdQdhbqtE0ArqZluTz6KMt7CHy7vOzCLeXqIlj+5sGhZNl1ONuRQgtwsm9a6/LW6vI+pBTSCbYh20q8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975859; c=relaxed/simple;
	bh=wf8fBS/vb+ZIqeaPKUjoyZFP4m5Z7EM0iPQrVLE2ifY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7KZhoZ2fpENBu2CZUWkQYVeAiLxTcyTCzbfPaCj/iKK04NBC3JbJxGN17MPNEHLb/k56FQX+mVQo36MZ8BSKm7XOMmaCvBezLopioIWRUmr8DPuKYlaNkLf98rD5JxaK8C8FhLecwcIxKLWGGXopMwCS9eM4ZPI8Zuzid/txYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iurWTXJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E004DC43601;
	Sat,  3 Feb 2024 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706975859;
	bh=wf8fBS/vb+ZIqeaPKUjoyZFP4m5Z7EM0iPQrVLE2ifY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iurWTXJsrdAc+m0HgHdHRGLVUkALhg7s4HY1vy86L+2vIgvu4K0udhVtV28I5jOIt
	 wuDw17/L2F/KDbXvoFH6jqLnvVO6P5OhgHA1MxXIvtAmaSn408m4jjyEUTsl9ep6SJ
	 w8BLBoqZjV3sNHSOWtSc6C/71DAQ4ag/KVYE/FFI=
Date: Sat, 3 Feb 2024 07:42:49 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	mathias.nyman@linux.intel.com
Subject: Re: [PATCH 6.1 000/219] 6.1.77-rc1 review
Message-ID: <2024020331-confetti-ducking-8afb@gregkh>
References: <20240203035317.354186483@linuxfoundation.org>
 <13ddf68c-df25-4f5a-8044-33543a726889@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13ddf68c-df25-4f5a-8044-33543a726889@linaro.org>

On Sat, Feb 03, 2024 at 12:23:33AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 02/02/24 10:02 p. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.77 release.
> > There are 219 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.77-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We're seeing lots of build problems and warnings with Clang 17 and Clang nightly:
> 
> -----8<-----
>   /builds/linux/drivers/usb/host/xhci.c:1684:37: error: variable 'slot_id' is uninitialized when used here [-Werror,-Wuninitialized]
>    1684 |                         ret = xhci_check_maxpacket(xhci, slot_id,
>         |                                                          ^~~~~~~
>   /builds/linux/drivers/usb/host/xhci.c:1652:22: note: initialize the variable 'slot_id' to silence this warning
>    1652 |         unsigned int slot_id, ep_index;
>         |                             ^
>         |                              = 0
>   1 error generated.
>   make[5]: *** [/builds/linux/scripts/Makefile.build:250: drivers/usb/host/xhci.o] Error 1
> ----->8-----
> 
> Bisection points to:
> 
>   commit 37ef029fe9a5639f12250f75f5d1594c6a11e181
>   Author: Mathias Nyman <mathias.nyman@linux.intel.com>
>   Date:   Fri Dec 1 17:06:47 2023 +0200
> 
>       xhci: fix possible null pointer deref during xhci urb enqueue
>       [ Upstream commit e2e2aacf042f52854c92775b7800ba668e0bdfe4 ]
> 
> Reverting the patch makes the build pass.

Thanks, will drop.  Odd that gcc doesn't catch this as well :(

greg k-h

