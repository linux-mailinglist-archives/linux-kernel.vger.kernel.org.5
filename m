Return-Path: <linux-kernel+bounces-148574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6048A849A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F32B28407
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23213F443;
	Wed, 17 Apr 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RqDbioDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F513CFB7;
	Wed, 17 Apr 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360488; cv=none; b=CIMn9xFKTfkxfLsNkaEFEFuY7Z4uiGe0JmF8SZ3ry14CU3D+tRcVltHZRuMTZF+4ewm6co9AXS8PpBWBpAyVNnzhY8fSTWlOMR+qTpDE2AVVkZQPf1x1U8UmHMJWYDMaqlhEJKcNJ8tt8QNBTBTomaYcthT0VYzaa4WSORfTR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360488; c=relaxed/simple;
	bh=WsPDv7AF1G0PbOV+/cjKhePBPo6kURl1Gyj2WmHRyn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXNndVAKqxkURqFy+GXSSvW9Kx8FNSgAvvTlc49+QiB3IjFc+Jix9E0iQHSn486754aE38am854DT+xBMulLKkjWSrWsgrkHzhRR66XHmbgNepc1SBoTUxt4wYP/X9raoLrQlqcaR+/9y8t59C9hlvZOPWWTJedZtR2iojBV4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RqDbioDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4668C072AA;
	Wed, 17 Apr 2024 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713360487;
	bh=WsPDv7AF1G0PbOV+/cjKhePBPo6kURl1Gyj2WmHRyn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqDbioDvLVzUHbdmeiDnGfLAbZNsZmUDDasrCiVyIfe+b5z4wli961BtQtIRoeoaa
	 0qvPQN46xgVGZBxW9CN4qdUrACqVG6CLonK4xSyf2ucpRBLT/xItM9m34HBDqd4o9P
	 a84BUqpm5i3ERzMFpIyQfcbiVJPYQnzc/pQ/fOM0=
Date: Wed, 17 Apr 2024 15:28:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@denx.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	alex.williamson@redhat.com, seanjc@google.com, jpoimboe@redhat.com,
	michael.roth@amd.com, dsterba@suse.com, aric.cyr@amd.com
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
Message-ID: <2024041739-faceted-sandpit-0818@gregkh>
References: <20240411095435.633465671@linuxfoundation.org>
 <Zh/HpAGFqa7YAFuM@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh/HpAGFqa7YAFuM@duo.ucw.cz>

On Wed, Apr 17, 2024 at 02:59:16PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 5.10.215 release.
> > There are 294 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> > Alex Williamson <alex.williamson@redhat.com>
> >     vfio/pci: Create persistent INTx handler
> 
> This introduces memory leak in vfio_intx_enable() -- name is not freed
> in case vdev->ctx = kzalloc() fails, for example.

So is the upstream commit wrong, or the backport wrong?

> > Sean Christopherson <seanjc@google.com>
> >     x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word
> 
> AFAICT this is not needed in 5.10.

Why not?

> > Josh Poimboeuf <jpoimboe@redhat.com>
> >     objtool: Add asm version of STACK_FRAME_NON_STANDARD
> 
> Asm version of this macro is not used in 5.10.

It fixed an issue.

> > Michael Roth <michael.roth@amd.com>
> >     x86/head/64: Re-enable stack protection
> 
> This is preparation for preparation for SEV-SNP CPUID patches, I don't
> believe we plan that for 6.1.

This is 5.10, not 6.1.

And are you sure that this is not needed?  Remember the x86 speculation
mess that is happening here.

> > David Sterba <dsterba@suse.com>
> >     btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
> 
> (This applies to 4.19, too). mutex_unlock() is needed before "goto
> error" here.

So can you provide that fix please?

> > Aric Cyr <aric.cyr@amd.com>
> >     drm/amd/display: Fix nanosec stat overflow
> 
> (This applies to 4.19, too). This is wrong. It updates prototypes but
> not actual functions.

So should it be dropped or added to 4.19?

confused,

greg k-h

