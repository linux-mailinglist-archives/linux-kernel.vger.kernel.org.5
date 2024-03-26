Return-Path: <linux-kernel+bounces-120013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8F88D020
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67E6304ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A7113D88A;
	Tue, 26 Mar 2024 21:34:23 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED213D617;
	Tue, 26 Mar 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488863; cv=none; b=YP1hL/vTuf3wAvx3QRl5Iw1g7qaab7jcjVrrm2W+zqe1NGoedmAkSPgc3lYkogciPh6RcDOfAwp6FaDttg+9h0rAJBqSRDwHvNG4hS9irrocVMMzkmsV0NT5oT/y/ofo2Ad+JotQbQoka6CTPg/KSRuAnjNGNVV60lA2LPiMhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488863; c=relaxed/simple;
	bh=xZP2Ji27/WUgLA4q9DMoYCa04xDn6nXu+RxVklse45A=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=E2bmlXYC0wtbu5GagAeZA6NdmtlaKhXTFrZr7HfZ2Hq2ws5MhDp+CWoAuQDCnYXNLUCiJK4gssco+yAijyXgkG2iEEsb3O8cChActMLrUnrX7TR7EvegngzMcMs0e66N7Ht1v2XRG+YcG4XDd40QU8jrRU2uQ82aP8ScfUABiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 676CC378110A;
	Tue, 26 Mar 2024 21:34:17 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240325120018.1768449-1-sashal@kernel.org>
Date: Tue, 26 Mar 2024 21:34:17 +0000
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Sasha Levin" <sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <289a17-66033f80-3-29238bc0@200611248>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E8?= 000/710] 
 =?utf-8?q?6=2E8=2E2-rc2?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Monday, March 25, 2024 17:30 IST, Sasha Levin <sashal@kernel.org> wr=
ote:

>=20
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git/patch/?id=3Dlinux-6.8.y&id2=3Dv6.8.1
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.8.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.8.y for this week :-

## stable-rc HEAD for linux-6.8.y:
Date: 2024-03-26
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Df44e3394ca9c2225643f2727e0949c770ef5ef8e

## Build failures:
No build failures seen for the stable-rc/linux-6.8.y commit head \o/

## Boot failures:

Devices failing to boot :-
Architecture : arm
at91sam9g20ek ( multi=5Fv5=5Fdefconfig )
beaglebone-black ( multi=5Fv7=5Fdefconfig )
imx6dl-udoo ( imx=5Fv6=5Fv7=5Fdefconfig )
imx6dl-udoo ( multi=5Fv7=5Fdefconfig )
imx6q-udoo ( imx=5Fv6=5Fv7=5Fdefconfig )
imx6q-udoo ( multi=5Fv7=5Fdefconfig )
qemu=5Farm-vexpress-a15 ( vexpress=5Fdefconfig )
qemu=5Farm-vexpress-a9 ( vexpress=5Fdefconfig )
qemu=5Farm-virt-gicv2 ( multi=5Fv7=5Fdefconfig )
qemu=5Farm-virt-gicv2-uefi ( multi=5Fv7=5Fdefconfig )
qemu=5Farm-virt-gicv3 ( multi=5Fv7=5Fdefconfig )
qemu=5Farm-virt-gicv3-uefi ( multi=5Fv7=5Fdefconfig )
stm32mp157a-dhcor-avenger96 ( multi=5Fv7=5Fdefconfig )
sun7i-a20-cubieboard2 ( multi=5Fv7=5Fdefconfig )
sun8i-a33-olinuxino ( multi=5Fv7=5Fdefconfig )
sun8i-h3-orangepi-pc ( multi=5Fv7=5Fdefconfig )
sun8i-r40-bananapi-m2-ultra ( multi=5Fv7=5Fdefconfig )
imx6q-sabrelite ( multi=5Fv7=5Fdefconfig )
odroid-xu3 ( multi=5Fv7=5Fdefconfig )
kontron-kswitch-d10-mmt-6g-2gs ( multi=5Fv7=5Fdefconfig )=20
kontron-kswitch-d10-mmt-8g ( multi=5Fv7=5Fdefconfig )
imx6dl-riotboard ( imx=5Fv6=5Fv7=5Fdefconfig )
imx6dl-riotboard ( multi=5Fv7=5Fdefconfig )
imx6qp-wandboard-revd1 ( imx=5Fv6=5Fv7=5Fdefconfig )
imx6qp-wandboard-revd1 ( multi=5Fv7=5Fdefconfig )
rk3288-veyron-jaq ( multi=5Fv7=5Fdefconfig )

Architecture : i386
qemu=5Fi386 ( i386=5Fdefconfig )
qemu=5Fi386-uefi ( i386=5Fdefconfig )

KernelCI Dashboard Link :- https://linux.kernelci.org/test/job/stable-r=
c/branch/linux-6.8.y/kernel/v6.8.1-707-gf44e3394ca9c2/plan/baseline/

We are currently investigating this issue and will let you know if ther=
e are any further updates.

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


