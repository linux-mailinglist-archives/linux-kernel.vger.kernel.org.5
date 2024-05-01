Return-Path: <linux-kernel+bounces-165193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E791A8B8953
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C026285DC6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAE1758D;
	Wed,  1 May 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8SuyQgp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE097745D6;
	Wed,  1 May 2024 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563439; cv=none; b=VvJkEhLYEDjYbmuWP+rIJpj2mKydFaB88pdTdwTYbD7mVrq0bXIKhMR3eR0Ofjxhvz2hWllk/S/TDrzWPcKf6Lf9rAnU2eE3lfEIRxRhRSf2GQY6SGh273paumap5RfncysGezmLwThtJJ3VXhJwg5VFTnsanJTK+JGVMA63rh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563439; c=relaxed/simple;
	bh=LEeCsHmbQISjdH/dqpw9rVUicJTGdkjLDLHYNDuZq2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYRxzMfgzlEpehzV0sd7p5RCyejcgTNnWFGfY0Zv6PrwBsou3TcvUPWVN+ZdF1cTJNxW3PL1ugIvRth8PjtLY+eRDlWrzWjPQjRAZHD0qBGXCFWFbXCCDnw06fapI/Ro9MU9RvYF+PWPzAw+27KddFHVmnzm0YgiwYi5J+FORHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8SuyQgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CC1C113CC;
	Wed,  1 May 2024 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714563439;
	bh=LEeCsHmbQISjdH/dqpw9rVUicJTGdkjLDLHYNDuZq2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8SuyQgpG+kff4B/ck8zR3xy6ymFigFvfzTh7zrjbMlNemvq8vj2IKNHg6xMkpDNj
	 vpRS7lB1ItTc9u0JFRW6QAGB4KPqHU13AEtQg2Jg0SOyAZb66XKsHLmntUG+H/m1SD
	 3E8bLfN1r2R66a+eSxHtpCL4fVu9Bso3cXTH98Y5wIM7i8fEIFE444TrjRQ98OJXMX
	 GSDZYB9gHkyAP1hh9G5Kz7xUBOObBLbUIDrAQldu6GC3TFSsvwudWBVhElQkKljHoP
	 teTBHdQ554L1PX78axsvoZLvRd2YTiEodSJ/ZFx3JuZQuOgqApB83yGGihYwblKFLc
	 /zaqoEzEjEU6w==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
Date: Wed,  1 May 2024 13:36:02 +0200
Message-ID: <20240501113602.164929-1-ojeda@kernel.org>
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 12:36:18 +0200 Greg Kroah-Hartman wrote:
>
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

