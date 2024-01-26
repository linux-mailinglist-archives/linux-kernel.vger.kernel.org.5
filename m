Return-Path: <linux-kernel+bounces-40633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE983E36E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE841F26E95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC7224205;
	Fri, 26 Jan 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBHALqoS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C23250EC;
	Fri, 26 Jan 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301279; cv=none; b=MvOXiSj+eMCmzZifKWA4wr7bJIdxVbD3ENu1UOo8bEme/XwJfF1vbtrI7YVIwVsB6+tmTSYpwvShkhM2aqLJt+YGQBRx79Y8vmbAKF1c30tHGZo6W8fpU9+lbu5YFFV5yuD8rdZm/fTWNW/mf3Opvgx1PFVeM2VpoQCSpCvxNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301279; c=relaxed/simple;
	bh=fKXandC+5QOPgaaNNK48snxQs+rXCoRJZv+oHcWZwXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtzmubQwGuDpppc/WY4xlsJzvpp1BxH3nQXicd8ENIdkUbtbqTfzE+EzDFJhaJU73NiAx3w0xLXZXfB4KltIGWXF6xcdA7u6DBVs8XrPuhGLs3k3scEAzbyIM4dsgCEy5KoNqBEq5k7+iSWmws5qTLBEsORqcf149On+6gPol5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBHALqoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0674C433C7;
	Fri, 26 Jan 2024 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706301278;
	bh=fKXandC+5QOPgaaNNK48snxQs+rXCoRJZv+oHcWZwXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBHALqoSmF/TAHePeBhX/syG9ctKGwupCxyx8jKndDgbJpbm7EWnsgjvjT7Vrx2DY
	 2Hj3E2tlWwXS00a+C4+TdFMfIVO3SnoY9yZpS67owsD6d6mZHp1suJb4GVWVRg2R8b
	 k6XY4XmoYuyiaSlucogkXWHktINh5FIwfXn4i52Po2ZoWMM0rk9H3uDXofwGsPZ8Dg
	 xij+uHtg0x5OISKjzS24Cl/kW4q1ygl0Ja9uPMFNu0bqZOuRFaNIGARh/Xkz6rFNuz
	 mQBjnQzkiOfUqwhjDs15QLxiAMAsYCMJbj1LL5UYNyEn/LD6B+42yYsmzGK8KcWYqP
	 cGu2VWgCtdVyQ==
Date: Fri, 26 Jan 2024 13:34:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, llvm@lists.linux.dev, keescook@chromium.org
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Message-ID: <20240126203436.GA913905@dev-arch.thelio-3990X>
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>

On Fri, Jan 26, 2024 at 10:17:23AM -0800, Guenter Roeck wrote:
> On 1/26/24 09:51, Greg Kroah-Hartman wrote:
> > On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
> > > On 1/22/24 15:55, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.10.209 release.
> > > > There are 286 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > [ ... ]
> > > 
> > > > zhenwei pi <pizhenwei@bytedance.com>
> > > >       virtio-crypto: implement RSA algorithm
> > > > 
> > > 
> > > Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
> > > It is quite beyond a bug fix. Also, unless I am really missing something,
> > > the series (or at least this patch) was not applied to v5.15.y, so we now
> > > have functionality in v5.10.y which is not in v5.15.y.
> > 
> > See the commit text, it was a dependency of a later fix and documented
> > as such.
> > 
> > Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
> > gladly accepted :)
> > 
> 
> We reverted the entire series from the merge because it results in a build
> failure for us.
> 
> In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
> In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
> In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
> In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
> /home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __read_overflow2_field(q_size_field, size);

For what it's worth, this is likely self inflicted for chromeos-5.10,
which carries a revert of commit eaafc590053b ("fortify: Explicitly
disable Clang support") as commit c19861d34c003 ("CHROMIUM: Revert
"fortify: Explicitly disable Clang support""). I don't see the series
that added proper support for clang to fortify in 5.18 that ended with
commit 281d0c962752 ("fortify: Add Clang support") in that ChromeOS
branch, so this seems somewhat expected.

> I also see that upstream (starting with 6.1) when trying to build it with clang,
> so I guess it is one of those bug-for-bug compatibility things. I really have
> no idea what causes it, or why we don't see the problem when building
> chromeos-6.1 or chromeos-6.6, but (so far) only with chromeos-5.10 after
> merging 5.10.209 into it. Making things worse, the problem isn't _always_
> seen. Sometimes I can compile the file in 6.1.y without error, sometimes not.
> I have no idea what triggers the problem.

Have a .config that reproduces it on upstream? I have not personally
seen this warning in my build matrix nor has our continuous-integration
matrix (I don't see it in the warning output at the bottom but that
could have missed something for some reason) in 6.1:

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/7662499796
https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/7662534888

Reverting this series from 5.10 seems reasonable given your other
comments but if there is still something to sort out upstream, I
definitely want to.

> Of course, on top of all that, the error message is completely useless.

Indeed, outstanding papercut unfortunately:
https://github.com/ClangBuiltLinux/linux/issues/1571

Cheers,
Nathan

