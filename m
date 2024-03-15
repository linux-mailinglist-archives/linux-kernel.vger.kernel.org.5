Return-Path: <linux-kernel+bounces-104779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3187D37D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7A4B2364C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE97450263;
	Fri, 15 Mar 2024 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvoHH16B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01084F201;
	Fri, 15 Mar 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526874; cv=none; b=DwTq75WHUZu4NI/bES2zJLlSnvWRCnm+8X8Z/uWSNfIbS/dJiTVap+Ro8xtIqVsP3Hf6GYvBEM640clLUYeNH35hKMty/uHpkT3Yu0NsLFG224F8gqlG6IK6NXO4KxD92yoeNXFfw0K1JltCEXR/q18+XwjY27nFzbzlbudLBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526874; c=relaxed/simple;
	bh=NwUfXfOCQurxDdwpyICSQ7BNgRd8mWinMpSJOr/C0eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWfZ8yZixKX5PIM2h0MAYmU+j/LLMvaiMXDg5k9l8wCQzg/F3F3KuuXzNhrzBhrO0qqd4uaj1OmOgvK0kFgZ294fBodlxBCk6doBzs+pO1SEkPAD54xTpCUHLaUEPOdEc/UlslHsfGLfVGWzPM6YH5WOOMyDtqNFJgJoCEUoVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvoHH16B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42742C433C7;
	Fri, 15 Mar 2024 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710526873;
	bh=NwUfXfOCQurxDdwpyICSQ7BNgRd8mWinMpSJOr/C0eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvoHH16BLNhpTsuYyP7rV1mDTnG4gU1ZlB/PVDuJFsRREydC50lvQgFnIBxo96JG3
	 KKa4TDRZdTSnDudnctGE+x2uS6HhgC4snZ/lFwj4p+4sRmQgIMkTVh/zLxrc03LEhO
	 iKf1duVx/fG5lmugJ58tyuzmBRKjc6rb459/MaaAsz6I/o/5Jw+Ege19t2Llpd3Os/
	 J5DIzKCSmhFdV52cQXNGNFu5G7b0BgkvYs1LmEHWKtK+rHnylIjIWhAKbfNnNZ4dC0
	 PViySj3d2MOlbqYa0lUWnDdznj1eYHcDbLyh8G4wyuXibWLWBJdNG+JO21m/piPI9X
	 Fk7Oql7NuXJeQ==
Date: Fri, 15 Mar 2024 14:21:11 -0400
From: Sasha Levin <sashal@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.8 0/5] 6.8.1-rc1 review
Message-ID: <ZfSRlyLNPMhF-OpN@sashalap>
References: <20240313163019.613705-1-sashal@kernel.org>
 <c3150fe5-0eb6-453b-86e4-3078dbb1e750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c3150fe5-0eb6-453b-86e4-3078dbb1e750@gmail.com>

On Thu, Mar 14, 2024 at 02:24:28PM -0700, Florian Fainelli wrote:
>Hi Sasha,
>
>On 3/13/24 09:30, Sasha Levin wrote:
>>
>>This is the start of the stable review cycle for the 6.8.1 release.
>>There are 5 patches in this series, all will be posted as a response
>>to this one.  If anyone has any issues with these being applied, please
>>let me know.
>>
>>Responses should be made by Fri Mar 15 04:28:11 PM UTC 2024.
>>Anything received after that time might be too late.
>>
>>The whole patch series can be found in one patch at:
>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8
>>or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
>>and the diffstat can be found below.
>
>Could you and Greg make sure you share the same CC list? I am usually 
>copied by Greg on stable release candidates, but a whole lot people 
>are not. This makes it easy to miss those.

Yup, will do. I didn't need to do this for a few years so our scripts
grew a bit out of sync.

-- 
Thanks,
Sasha

