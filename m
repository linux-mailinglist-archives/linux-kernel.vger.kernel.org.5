Return-Path: <linux-kernel+bounces-119955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37388CF64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC10D1C67667
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88812B157;
	Tue, 26 Mar 2024 20:49:01 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25AA811F9;
	Tue, 26 Mar 2024 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486141; cv=none; b=GKNfCGs3OOiYBi6k1sIR/Hr8YrMMgbUcWmU2spU/t3e45shquacokkiN+Q+uJDS1bE5zXOCYnWSC8zTsacIp+OPdWH1VNii22ADPdViWA9E0KlKrckiapcqYapw7sPaaWAx0o2ZWM/ydFA+6H05xp4Gs/Gmj2OPVsYC0NgWFfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486141; c=relaxed/simple;
	bh=qngdt53VINITfW5NH6AC1yIESFnJuPIAbovt0DqaxEc=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=HXT33CVSURhmcHzbhsZ8ba1TLQVyS7SkkJzd30Gw+BjVHa6kHBgtZBH0zflZQPtbXFyb7uZUvTHm76IRJCm17TytU6GEBWJl5oWLKd1htXD8N3+JUSo+K+EvenGRnSzQChgMaIDzh4tXZt+P6Vz8rlPgL+j50iJ3YPkFJboQSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 0EAF337811CD;
	Tue, 26 Mar 2024 20:48:56 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240325120003.1767691-1-sashal@kernel.org>
Date: Tue, 26 Mar 2024 20:48:56 +0000
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Sasha Levin" <sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2893e8-66033480-5-6dc7f280@136063199>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E7?= 000/707] 
 =?utf-8?q?6=2E7=2E11-rc2?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Monday, March 25, 2024 17:30 IST, Sasha Levin <sashal@kernel.org> wr=
ote:

>=20
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git/patch/?id=3Dlinux-6.7.y&id2=3Dv6.7.10
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.7.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.7.y for this week :-

## stable-rc HEAD for linux-6.7.y:
Date: 2024-03-25
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D506a04d850a45d261e12a025af27c0ae5d4740c6

## Build failures:
No build failures seen for the stable-rc/linux-6.7.y commit head \o/

## Boot failures:

Devices failing to boot :-
Architecture : arm
at91sam9g20ek ( multi=5Fv5=5Fdefconfig )
beaglebone-black ( omap2plus=5Fdefconfig )
imx6dl-udoo ( imx=5Fv6=5Fv7=5Fdefconfig )
imx6q-udoo ( imx=5Fv6=5Fv7=5Fdefconfig )
qemu=5Farm-vexpress-a15 ( vexpress=5Fdefconfig )
qemu=5Farm-vexpress-a9 ( vexpress=5Fdefconfig )
imx6dl-riotboard ( imx=5Fv6=5Fv7=5Fdefconfig )=20
imx6qp-wandboard-revd1 ( imx=5Fv6=5Fv7=5Fdefconfig )

Architecture : i386
qemu=5Fi386 ( i386=5Fdefconfig )
qemu=5Fi386-uefi ( i386=5Fdefconfig )

KernelCI Dashboard Link :- https://linux.kernelci.org/test/job/stable-r=
c/branch/linux-6.7.y/kernel/v6.7.10-707-g506a04d850a45/plan/baseline/

We are currently investigating this issue and will let you know if ther=
e are any further updates.

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


