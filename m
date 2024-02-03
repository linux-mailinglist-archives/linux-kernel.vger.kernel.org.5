Return-Path: <linux-kernel+bounces-51172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477CB84874E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A52C1C22A94
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8F5F559;
	Sat,  3 Feb 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G1+j1aIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B45F47B;
	Sat,  3 Feb 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706976079; cv=none; b=SQkn69vYpun74BhOxsu6N2r4Bin6EWZ6hiS8GiGDWcaqHdSLETRHM2tcTl64pCSUeQKdQIhBS2ALaokSWidDxXoUu/fl6qRg4/kJiBVahZbcW093wvo7XzPKMplxu5XiTQi5pB+WIPZVvBTpJJy4lVGA6mnSCN7U5gFYqcAY8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706976079; c=relaxed/simple;
	bh=CSXjpaKMWYqcmTzvvC8xi5Ash2BUHUzfB+goNC8EqKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGT4o1rBMwlolXFfSYNA1FLxTTkRcLKUWGrf0cS3+V+BRDr4KCMBXfvqtZpYvizmkgJXgGEmYYjG+/BomQxZn6McdSbGiYAj/kK9anRwcAFd3AeLAavmkDsOXMbSQja4SznHl7MgwkOzmsiIM7e/+LwJboieWmRbXoGZJXJ2lsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G1+j1aIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA86C433C7;
	Sat,  3 Feb 2024 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706976079;
	bh=CSXjpaKMWYqcmTzvvC8xi5Ash2BUHUzfB+goNC8EqKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1+j1aIs6+t8865+OI8G5LloOjTrG/IQHJuU4RJhwUjn+MgC3S29AHm6/lmmvcgFT
	 fQL0MhVeLSsrVUkW+M7KjzlzCAYwI6CAUWCVs+dMT/Eb9cEjRvUFbK6wyShgqLsjm3
	 u6geJ9bPeMx27jwkdtrQkm9dtXvt4aQDplrrAzl0=
Date: Sat, 3 Feb 2024 08:01:18 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
Message-ID: <2024020307-unsteady-gizmo-ef81@gregkh>
References: <20240203035403.657508530@linuxfoundation.org>
 <5c1f616b-6244-4df9-967f-8063968dff3c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c1f616b-6244-4df9-967f-8063968dff3c@linaro.org>

On Sat, Feb 03, 2024 at 01:02:41AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 02/02/24 10:01 p. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.7.4 release.
> > There are 353 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.4-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Same problems as reported with 6.1, but something else happening on Arm (32-bits):
> 
> -----8<-----
>   Error: /builds/linux/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts:91.1-10 Label or path pmicintc not found
>   FATAL ERROR: Syntax error parsing input tree
>   make[4]: *** [/builds/linux/scripts/Makefile.lib:419: arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dtb] Error 1
>   make[4]: Target 'arch/arm/boot/dts/qcom/' not remade because of errors.
> ----->8-----
> 
> This is seen with Clang (17 and nightly) and GCC-8.
> 
> Bisection here points to:
> 
>   commit 4fed142bbe3ca920810eba12fe96800cfd094d0c
>   Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>   Date:   Thu Sep 28 14:02:44 2023 +0300
> 
>       ARM: dts: qcom: msm8960: fix PMIC node labels
>       [ Upstream commit a10a09f34eb80b83ca7275e23bf982dae2aa7632 ]
> 
> Reverting that commit makes that problem go away.

Will drop this too, thanks.

greg k-h

