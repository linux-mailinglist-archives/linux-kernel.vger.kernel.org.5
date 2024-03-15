Return-Path: <linux-kernel+bounces-104795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0B87D3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006B51F24213
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0F1EF1D;
	Fri, 15 Mar 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOruKdQz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7814A9F;
	Fri, 15 Mar 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527980; cv=none; b=WIah9445lI6VD6nf+g7FYkL2Yl6jHEMSIECWn7QhE7TzwIl3rtZXjcAlH+zwxuN+DHOBM7QjYMU+UrjDNistc9kgj0+JbWPCUI2rCi24Hw79iPF6I4B6SrL0934i/inC8YYAykngCNEeo/SHG9PkWht8Aeidd9kxPpc3+g29Jtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527980; c=relaxed/simple;
	bh=7I4/RRMtzQx+H/f6YtVER38TRYi2f1vWrtkoyySbmaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdzQW+W6N/KwUiVb93xVs5kqlmZ0psYEun5g59ZMAFSwsolRBZ/VWIV34jQAWLoDMCREHOo5MzPx++2+Ixyu/x040LPBcBlNc6ZTHVJp29wuNXiAhxsKSqPbcYC/XSItpSGs1rMmh2UKW6Cy151SWUVk2ZPj2O2LaH7PQlsNwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOruKdQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E29C43394;
	Fri, 15 Mar 2024 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710527979;
	bh=7I4/RRMtzQx+H/f6YtVER38TRYi2f1vWrtkoyySbmaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOruKdQzq8BxjZVPZ0lU0+C0CbN2sefYHuWuQctomwM8qQikA01PRAe3RsvF7KCwK
	 jYqANV9VjVPgGZA4RgH/weZWIp29sfPbQjbKB7ukiG2BN/2go5iETfjWXqJ3vzncfB
	 kjkm4Wm1XjHyCe+8bHNIKB+qbVqyOkFL3CIZjnUsjrkaWRUcFv24U3lJF2h8F7leIO
	 C6+m21XCaXsbc7FdCbYPEgUr+5r/5fTesKOmMfsHrbFQ65uq7vYk3RNlLf22EFbW4D
	 k7MFx4Ectm5FIbKzObWm6hbEErtyswZ2gIUSN7Wn8nHeELCmnY2RCLz5VWa58toL9T
	 VUoLcHksPuvbg==
Date: Fri, 15 Mar 2024 14:39:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <ZfSV6RVweBOlKZW_@sashalap>
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfNwZ2dqQfw3Fsxe@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZfNwZ2dqQfw3Fsxe@eldamar.lan>

On Thu, Mar 14, 2024 at 10:47:19PM +0100, Salvatore Bonaccorso wrote:
>Hi Sasha,
>
>On Wed, Mar 13, 2024 at 12:45:27PM -0400, Sasha Levin wrote:
>>
>> This is the start of the stable review cycle for the 5.10.213 release.
>> There are 73 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
>> Anything received after that time might be too late.
>
>This one still has the problem with the documentation build and does
>not yet include:
>
>https://lore.kernel.org/regressions/ZeZAHnzlmZoAhkqW@eldamar.lan/
>
>Can you pick it up as well?

I'll pick it up for the next release cycle, thanks!

-- 
Thanks,
Sasha

