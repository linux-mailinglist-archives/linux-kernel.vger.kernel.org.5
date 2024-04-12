Return-Path: <linux-kernel+bounces-141937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0078A2556
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C5A283556
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD24D2E5;
	Fri, 12 Apr 2024 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="NzINVwSi";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="eWOJzqDe"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E0205E34;
	Fri, 12 Apr 2024 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897418; cv=none; b=VEEZOGFf9R9AqbGJDtlpQ6WJYnXD26Tvnw8hBibPwv3LCRsA98nFZO/MCucA5U7bQ/EClwF8su5nYOczZxDpCbn4I4oQuvTWtNMMZwv9uKDjNXI5l7OIAzOtMr6IDa+owwMb9atl/S2pCuEPN7C/RY80cCee4ONoas0S7u9tvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897418; c=relaxed/simple;
	bh=4+42ynGEyHlCRHCEji9sviaHUyVVm5QGhCORJy3G0Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz+3O+j0A1uEjD5Wyavv3rLBOvVXIppJ/iT/V5LDgPPRkt6Z3KHYAzSi1GPwNU/swuSdQV3pSVQo/ak/bNATLa3L+kjV+LPKu/3ckmhP7DGRHNPIk3ffwCaXjdb6ITrL63RlPLouc/3oMSnMmUIS0Up8GnOWLoU+LDWlz3b3R8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=NzINVwSi; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=eWOJzqDe; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 8CEF6C023; Fri, 12 Apr 2024 06:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712897408; bh=7WSthEQYlk7/SIGKZLPpcaTfbc1Ib5Ox8uDcREcjIvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzINVwSiTpry9k+ceLei9+eUtRNrT6PxYBoRJKbGv8sADltvPBzDQ1Crw/ljWwsgC
	 defCI62/tYCd6rkhC4WVRdFB+Xm/xuGjkp6wasfVB9bss1QeOGASJe5+VVEadmvnMK
	 nO0ZaQPodfUtsO3ZmtkMBeFyPG9mNPaRWT4pdLO8icpTS4agzAMLYaPaf4vaM2RqSU
	 bScm6LPdtegvqetIPtxcOT481OaKp1FCIX1v7q+r0sqMJTuZh4Gd+lbxM5Heg5gap1
	 4UBnSCDvp4jhkYUEJpHuwe7uy74j2vqdhxrjzH9QkW4VBzY+DlWaO8Mlni5QDTe3Io
	 /MN888BsLgBXA==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 14E9FC009;
	Fri, 12 Apr 2024 06:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712897407; bh=7WSthEQYlk7/SIGKZLPpcaTfbc1Ib5Ox8uDcREcjIvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWOJzqDexXHU4aJRlEzo734+unPKXb6PTP+216dp7SsTk8xyUCMECwIq+ePjvdK5I
	 88KvyI7j2yxXmuoOxZLT4ozTnU5ewPQ4JsBggf/Sv5hBVdb1J6NdqEzCz4qGYBXnTK
	 53gDcthgv/liMeSNc7Hb99Sqe+stv63ZmJHvxHGjT1934gU5Eho0gOUtw9P35AfEe5
	 5gJmQIEWb+4WrOWDttq2Qt/+ux4qsB1Z6cOjOQ7qOVOL+mik23UVg0Xm/uhz2lZI3H
	 BVtRLvTe+q+D7xNoTIJNwiN0NWCrf6QZK3ysYuRAKPMh/BakccpOOOlkdVKCKi3NxD
	 BrDSOez73hK0w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f355fdc5;
	Fri, 12 Apr 2024 04:49:57 +0000 (UTC)
Date: Fri, 12 Apr 2024 13:49:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
Message-ID: <Zhi9Zs8oWVfNckdJ@codewreck.org>
References: <20240411095435.633465671@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>

Greg Kroah-Hartman wrote on Thu, Apr 11, 2024 at 11:52:43AM +0200:
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.215-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 244ca117cb3c ("Linux 5.10.215-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus

