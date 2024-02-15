Return-Path: <linux-kernel+bounces-66405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F3855C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C111BB21C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14BF12E67;
	Thu, 15 Feb 2024 08:19:25 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B011CB0;
	Thu, 15 Feb 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985165; cv=none; b=YcWABTX7Or6CHxsHR50xhNLQIBdk/rVxjo9RloxEHFeERJf6QeD0ZpUfoTz+reKtQDP8BvH4zCp7fmb7Hn7dzuX0ZnQr1mg1BoWZ0C39tYdu/vF+qlOj2xQwD732i0on/zSf/Vr5xyhH3yuAjCJZL/f2zA5xHj270xWr9lfOVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985165; c=relaxed/simple;
	bh=iKnYr81o5hV+pRY3NBoR16c+PMpKohJg5JHYWfKUrlU=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=ZdXdnMIvXZP2U2RQPtrrzKNJdsszrSe1F+rk4cmiJAPUN5v1AO3imHB1g4x1nzr2t3JgG5bcGscZiiLjHFmHIykG6AMh/NdgASOH/Zw6IJMFCj4Mt7Cxk0ie8DF24vOcH7hD1ZjMZy3xW3T8qEDMEWo/PVlsI0ko+2AxYxiLzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id D510D37813FD;
	Thu, 15 Feb 2024 08:19:12 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240214142941.551330912@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240214142941.551330912@linuxfoundation.org>
Date: Thu, 15 Feb 2024 08:19:12 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5068-65cdc900-1-67057380@4073141>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E1?= 00/65] 
 =?utf-8?q?6=2E1=2E78-rc2?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Wednesday, February 14, 2024 20:00 IST, Greg Kroah-Hartman <gregkh@l=
inuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.78 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1=
78-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.1.y
> and the diffstat can be found below.
>=20

## stable-rc HEAD for linux-6.1.y:

Date: 2024-02-14
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Dea6a03790c420fec42790d8c5db2e81663954186

## Build failures:
No build failures seen for the stable-rc/linux-6.1.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.1.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


