Return-Path: <linux-kernel+bounces-102487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8087B2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8DF288D19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010134F88A;
	Wed, 13 Mar 2024 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw7ZQN/n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439584CDE0;
	Wed, 13 Mar 2024 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361312; cv=none; b=qlndBA0QZDNO2JfbuuH3KRXLGVOZhgS00pE7dTDC7jLhfs4fUflfO2TU0zwtQ4pVoodfiryNjBvcfxc2tctjga8+IrpXhHvrbYeGqe/KVJJR67tUvSYrJFT181mX91OdXUtiKWQRLeJcOhdivKuEelDk9w1L79zaLWBtoPYWwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361312; c=relaxed/simple;
	bh=mf6LniCThShuOGl7OAYt74aiphBUMuKZey6YkXWo1q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZm3rVDCmwulnPJjuswAMzGAQ5uUMJNvpuSsJf21GjEJgSiZvZobl6NjBjIP+hliNBxDpD5I+ZfmcFw5gzRF6TPTFfCLI+WHUcsMEDkrpqaIPufC7IkPECywAlIg66bVMDEPt7VFaybX0EmjLOFPKTyI0bldvZjMHPQvNN+qPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw7ZQN/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A05EC433C7;
	Wed, 13 Mar 2024 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710361311;
	bh=mf6LniCThShuOGl7OAYt74aiphBUMuKZey6YkXWo1q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uw7ZQN/nZXOM++VIGHKwwrNwcmLnLa2Ma6kyBAXTbzaXzpeA0zm4RDJPPOohfUNcv
	 9OIrsaMdfP83RGVMlbSOFqtqmaeialFM98nPrYdFOrLA3K8+xMC+G1LIlsgKlCjAXL
	 /JBKXGdA4HcnUFaDKJt+s1Zquo2yp06zTqenm7tWhK/GJrn5ltgIQl+Iy8e0DbRYM1
	 rUCONGXPUXBs0kzwyu5l6rHlR3nscUqAQYJ75JxiHUJWfOYJCoGqUFOGHaYGHHMP93
	 3IhdmI0b8O6yNA5NxSR+5zVqfTOY6QGfeBdELfUd0QHLRSaW3hMrqPnJbHsBl5wFC6
	 VJbKNGDl49EHw==
Date: Wed, 13 Mar 2024 16:21:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, nathan@kernel.org
Subject: Re: [PATCH 5.15 00/76] 5.15.152-rc1 review
Message-ID: <ZfIK3cxPeIE2MN39@sashalap>
References: <20240313164223.615640-1-sashal@kernel.org>
 <2f15e804-a2d7-4ad0-9b84-02db8c89985d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f15e804-a2d7-4ad0-9b84-02db8c89985d@linaro.org>

On Wed, Mar 13, 2024 at 01:21:21PM -0600, Daniel Díaz wrote:
>Hello!
>
>On 13/03/24 10:41 a. m., Sasha Levin wrote:
>>This is the start of the stable review cycle for the 5.15.152 release.
>>There are 76 patches in this series, all will be posted as a response
>>to this one.  If anyone has any issues with these being applied, please
>>let me know.
>>
>>Responses should be made by Fri Mar 15 04:42:22 PM UTC 2024.
>>Anything received after that time might be too late.
>>
>>The whole patch series can be found in one patch at:
>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.151
>>or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>and the diffstat can be found below.
>>
>>Thanks,
>>Sasha
>
>We see new warnings everywhere:
>
>-----8<-----
>  /builds/linux/scripts/mod/modpost.c:1123:44: warning: excess elements in array initializer
>   1123 |         .good_tosec = {ALL_TEXT_SECTIONS , NULL},
>        |                                            ^~~~
>----->8-----
>
>Bisection points to:
>
>  commit 4060bae9dab232eb15bc7ddaaeb278b39456adf9
>  Author: Nathan Chancellor <nathan@kernel.org>
>  Date:   Tue Jan 23 15:59:55 2024 -0700
>
>      modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
>      [ Upstream commit 397586506c3da005b9333ce5947ad01e8018a3be ]
>
>Reverting that commits makes the warning go away.

I've dropped it, thanks for the report!

-- 
Thanks,
Sasha

