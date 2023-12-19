Return-Path: <linux-kernel+bounces-4878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CA781833C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942412816EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623511712;
	Tue, 19 Dec 2023 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="DHZsk6dY";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="S2k5tAzp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B0134A6;
	Tue, 19 Dec 2023 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 38ECFC009; Tue, 19 Dec 2023 09:20:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702974019; bh=z/0FZrN0KqpDTOtDkKzEnxjxxsSs9NJtKvNMljVBU6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHZsk6dYVkCuGAfg73U/7JGESnqXaJRFTh5IOmR2a+X2HKorebe4L1ZVbOjvHmUX2
	 9+poD/+bjeC3FXGVOKklio6Tcq5EO+I+8nyvzhgRhpuTnOApSAoSSTdO7ZET3Lech5
	 ZtbCtQMMU22PU+ADdVGn511/NLsMRME6wu5KvGJl0I8Z6oZmSx46o22pUCLZRkdE5E
	 ELdZVJUVe71V5hBwP+3TU0qy9rzgczxAVO8SSyOjjjAJZKPV2U3ofCl+Qj8/Ziv3Sz
	 BBzw2gGYO7X3DZPZ+OqhTc60GU/hkiP/Wd1G9Nfy62tewWFPBRDvOko2xpt8oUhkd1
	 HU7qd7QR+CnNQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 64155C009;
	Tue, 19 Dec 2023 09:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702974017; bh=z/0FZrN0KqpDTOtDkKzEnxjxxsSs9NJtKvNMljVBU6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2k5tAzpfmqBy5YsRNL/cI7AFAiOPa0MevxEEL0OZ8vSWBShaFKONeCMVYtUiiXzC
	 8StKuIgvxK3KFd8i4AhqSUHKF6voUCyzPvR3tOM8aXPIIkNpwci1v/nKRwhKUjiWsx
	 xcprPNMLL4G/Y1422LSQwwI499kOhIyP1OwaeU8HfR7kEIF1ltK06KIXVNqaVo3Vfy
	 7sjXnigpfi0rZr5xoKuEnayRAKzECxZq4M56WM66G+3/7nEe0H1jeCeWA9dwNHeQBC
	 45pqT/+X1HKa4Q5LYg6r4U3kyZr8D19Xd9jg9IocKb6x6X8GgHUDFzmM0vT0/POWTB
	 froJeqIZvMlBA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id d050cb09;
	Tue, 19 Dec 2023 08:20:09 +0000 (UTC)
Date: Tue, 19 Dec 2023 17:19:54 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/60] 5.10.205-rc2 review
Message-ID: <ZYFSKmbQbvPhoFbm@codewreck.org>
References: <20231219074407.947984749@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219074407.947984749@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Dec 19, 2023 at 08:53:19AM +0100:
> This is the start of the stable review cycle for the 5.10.205 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Dec 2023 07:43:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.205-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 163d4e782432 ("Linux 5.10.205-rc2") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>


Thanks for the rebase of the drm/mediatek spinlock patch!
-- 
Dominique

