Return-Path: <linux-kernel+bounces-104278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894187CB92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02268B2281C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA619477;
	Fri, 15 Mar 2024 10:43:16 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004C18EA5;
	Fri, 15 Mar 2024 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499396; cv=none; b=eNhdRe/Mei+iIfxyyCIdZYeF+Mc8W0KN0wqEsriNwFnXXfnVHrdPxzeioh+9b2II9xHC5CBkJG1RYf2owapXLPxwbFry+aYKucn1BQYMdK4poKdt/qrVuiifQQzn6QbAe5GVt+4at8al7/hMeeZt1UdtoCJzcAfqU2oGjyoAifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499396; c=relaxed/simple;
	bh=KPZfPSs9Bh7Me+VVKS8w0NBe//T6pt9pxKaa8aeHkKg=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=UbLx2I1ktG+SSDDoQUfPVeHOw8zlpQ5JYjzhJX4rJ3BspU/dysWBxbo7gtvmeuma9/2UQbNykzilkgCxOKE5bjMHJ/FWuNvILgnSPJq2bvEzUvfA2gSo29XhREh8wzp0N6Kxg80JL4d8pOvIYyukATjjNAUNVw7JBmsogp+k0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 29EC63782083;
	Fri, 15 Mar 2024 10:43:12 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240313164223.615640-1-sashal@kernel.org>
Date: Fri, 15 Mar 2024 10:43:11 +0000
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: "Sasha Levin" <sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1fb18d-65f42600-6b-4a825480@259324147>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E15?= 00/76] 
 =?utf-8?q?5=2E15=2E152-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 13, 2024 22:11 IST, Sasha Levin <sashal@kernel.org>=
 wrote:

>=20
> This is the start of the stable review cycle for the 5.15.152 release=
.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Fri Mar 15 04:42:22 PM UTC 2024.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git/patch/?id=3Dlinux-5.15.y&id2=3Dv5.15.151
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-5.15.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.15.y for this week.

## stable-rc HEAD for linux-5.15.y:
Date: 2024-03-13
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D97877abed2af926040ddc1dc8d68d11b73e44e42

## Build failures:
No build failures seen for the stable-rc/linux-5.15.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.15.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


