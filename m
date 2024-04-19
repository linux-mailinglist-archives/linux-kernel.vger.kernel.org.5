Return-Path: <linux-kernel+bounces-151328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A78AACFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F415AB212AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751957EF02;
	Fri, 19 Apr 2024 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gRgLoLAg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451422085;
	Fri, 19 Apr 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523268; cv=none; b=jcFNsc/cIeMJokTPPxRYgXgt2iSGA5/msmTq7AaZ6fdN2empD1Vi8NtwsUGe4jN9nbHAZ+hah5igllac/8714651/ENu3+FCk9BZKf1pFmH/mAJtnFHg9OE6e4V3+yoBf32ddQId2fzEs0jWV3GOxXvtirAGpFQEI7Fpx1WLG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523268; c=relaxed/simple;
	bh=l7Ibpa6QU5Vn4sTkHcXZOBTwcvPdpXqQhST+cjL92wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqqNX7YU+VSlychMrRjQXwnkPCJCRz7kxC18h+YGwPqHKq8pQPt49PLo076KBstEvOtoJh4cy6FBvxGduGgezLG9wQ2eLb9qqsgljTEQrn68U1zCb59v+2+ggmaAQ1f/ov95e9ZbmgTFI4uydYL41UUqFGYAuU0wgSFq9c/JgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gRgLoLAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACBAC072AA;
	Fri, 19 Apr 2024 10:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713523268;
	bh=l7Ibpa6QU5Vn4sTkHcXZOBTwcvPdpXqQhST+cjL92wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRgLoLAgb2+asgEIET/1L6mQ7FphOkifgyrQCrMxRa80/XcZVySu35W24lIljEqCn
	 Js+camzLVyPeab+JOuZhsYF+hjhCT+jkJ4S/TFLTAST0WojrwOxxz6kt7eESIZwtf8
	 reQiTZ2t71urGklP3SlU69FHdPNh6aSxxMggxwGM=
Date: Fri, 19 Apr 2024 12:41:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Phillip Pearson <philpearson@google.com>
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
Message-ID: <2024041949-strained-steadfast-13cf@gregkh>
References: <20240411095424.875421572@linuxfoundation.org>
 <787e0ac1-cb31-47d9-8200-3f6a3b4119dd@roeck-us.net>
 <c5d0c7f7-96a0-4806-b3b6-269d9189037d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d0c7f7-96a0-4806-b3b6-269d9189037d@roeck-us.net>

On Thu, Apr 18, 2024 at 12:38:59PM -0700, Guenter Roeck wrote:
> On Thu, Apr 18, 2024 at 12:25:21PM -0700, Guenter Roeck wrote:
> > On Thu, Apr 11, 2024 at 11:53:29AM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.4.274 release.
> > > There are 215 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> > > Anything received after that time might be too late.
> > > 
> > [ ... ]
> > > 
> > > Sean Christopherson <seanjc@google.com>
> > >     KVM: Always flush async #PF workqueue when vCPU is being destroyed
> > > 
> > 
> > This backport is bad. In kvm_setup_async_pf(), it removes a call to
> > kvm_get_kvm(). However, it does not remove the call to kvm_put_kvm()
> > in its error handler. Also see upstream commit 7863e346e108 ("KVM:
> > async_pf: Cleanup kvm_setup_async_pf()") which explains that one of
> > the error paths in kvm_setup_async_pf() which is not supposed to be
> > observed can be observed after all.
> > 
> 
> Reverting the above commit from v5.4.y fixes the problem. Alternatively,
> applying commit 7863e346e108 on top of v5.4.274 fixes it as well.
> 
> I added Phillip Pearson to Cc:; he did all the testing and can provide
> additional information if needed.

So which is recommended, revert or add the other commit?

thanks,

greg k-h

