Return-Path: <linux-kernel+bounces-159099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECF8B2970
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883E7282686
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2B21101;
	Thu, 25 Apr 2024 20:08:47 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8097152DE6;
	Thu, 25 Apr 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075726; cv=none; b=lcNCgmrDMrDioeIxIkC7TsTB5b3CNCm9OBIIFITtNSldii9dylHl/AZlWKYE+GCYg2xcvFcdjuoH84aI0TYpCPCVcWd+3vi9szDmH3bCP/OkxDud8oGEUqfZSPAzSC2wB60A6uzbyI6f764qYrm4fsR4M6LHNaTB5wAXVd7vCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075726; c=relaxed/simple;
	bh=CyZaL4cj97SzoWAYRd9H9lahmOaO+LImDMXOK11rsDY=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=ma5hN4SDdoWOXLIsVuqzeByd9RUphxOpgCgN78vnejoC3miHfhlr4AoxpPuDnhpblySv6mzzocX+W5bKMnNzntM3yyDCIuGKc5+8Lvkeylhj5shGjeYbszuCduAomeG7DQ9SnZVs0A9WIP8BXv9fUSHeY4U98x17EXZBiDS54eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 3679037809D1;
	Thu, 25 Apr 2024 20:08:40 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240423213853.356988651@linuxfoundation.org>
Date: Thu, 25 Apr 2024 21:08:39 +0100
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <99cbe-662ab880-3-768c9e80@206940875>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E1?= 000/141] 
 =?utf-8?q?6=2E1=2E88-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, April 24, 2024 03:07 IST, Greg Kroah-Hartman <gregkh@linu=
xfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1=
88-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.1.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.1.y for this week :-

## stable-rc HEAD for linux-6.1.y:
Date: 2024-04-24
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Dcde450ef0f2f55f2c1d63110616bc88f9af5cf38

## Build failures:
arm:
- multi=5Fv7=5Fdefconfig (gcc-10) and omap2plus=5Fdefconfig (gcc-10)
- Build details :- https://linux.kernelci.org/build/stable-rc/branch/li=
nux-6.1.y/kernel/v6.1.87-142-gcde450ef0f2f/
- Errors Summary
arch/arm/mach-omap2/pdata-quirks.c:271:2: error: implicit declaration o=
f function =E2=80=98gpiod=5Fadd=5Flookup=5Ftable=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
arch/arm/mach-omap2/pdata-quirks.c:264:3: error: extra brace group at e=
nd of initializer
arch/arm/mach-omap2/pdata-quirks.c:262:41: error: =E2=80=98GPIO=5FACTIV=
E=5FHIGH=E2=80=99 undeclared here (not in a function); did you mean =E2=
=80=98ACPI=5FACTIVE=5FHIGH=E2=80=99?
arch/arm/mach-omap2/pdata-quirks.c:262:3: error: implicit declaration o=
f function =E2=80=98GPIO=5FLOOKUP=E2=80=99; did you mean =E2=80=98IOP=5F=
LOOKUP=E2=80=99? [-Werror=3Dimplicit-function-declaration]
arch/arm/mach-omap2/pdata-quirks.c:261:3: error: =E2=80=98struct gpiod=5F=
lookup=5Ftable=E2=80=99 has no member named =E2=80=98table=E2=80=99
arch/arm/mach-omap2/pdata-quirks.c:261:11: error: extra brace group at =
end of initializer
arch/arm/mach-omap2/pdata-quirks.c:260:3: error: =E2=80=98struct gpiod=5F=
lookup=5Ftable=E2=80=99 has no member named =E2=80=98dev=5Fid=E2=80=99
arch/arm/mach-omap2/pdata-quirks.c:259:34: error: storage size of =E2=80=
=98pandora=5Fsoc=5Faudio=5Fgpios=E2=80=99 isn=E2=80=99t known
arch/arm/mach-omap2/pdata-quirks.c:259:15: error: variable =E2=80=98pan=
dora=5Fsoc=5Faudio=5Fgpios=E2=80=99 has initializer but incomplete type

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.1.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


