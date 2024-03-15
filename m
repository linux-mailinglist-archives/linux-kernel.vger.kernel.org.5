Return-Path: <linux-kernel+bounces-104296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69187CBCA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2671C21D89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71A19BA2;
	Fri, 15 Mar 2024 11:00:02 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDE1B7E1;
	Fri, 15 Mar 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500402; cv=none; b=T/1VU68xW1qv6iBFNt3IEYQpGaDYMXQ7hNR+Jm9AhPs3JQFibQeUdmPC5QTekSDBMxASXgr94Bln+9Ui9Mpt2jy5Hkq8CwBAIlljo2lPg9gXmmu5keS4X/XFDQPfo0B3AZniyjoTkBzMyW9/vkFLlP8oIOJaVim0i5l0Xj74CsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500402; c=relaxed/simple;
	bh=0xjdFwXEYOG0jlKW4cYdOJe5BNNCMixxr/Ok7MVkRW0=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=GlIpn42KDEzfr8Sk+S6prmHvnpkLVcc8qs3W1VG1wUXfxFJ/qBjKHfCFO2CbNvM+3PCgILYzvMVQyzLl9L95ZuhDz0z1dZO1v6ZWq3sRrp9N1W7mEMLH4CLfl0yGwSkU1FGC7blSZXPo5SF24IA2zuD1+Dij9668Caa1sdigILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 10CA637820D8;
	Fri, 15 Mar 2024 10:59:57 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240313163236.613880-1-sashal@kernel.org>
Date: Fri, 15 Mar 2024 10:59:57 +0000
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: "Sasha Levin" <sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1fb18d-65f42a00-6f-4a825480@259324213>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E7?= 00/61] 
 =?utf-8?q?6=2E7=2E10-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 13, 2024 22:01 IST, Sasha Levin <sashal@kernel.org>=
 wrote:

>=20
> This is the start of the stable review cycle for the 6.7.10 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Fri Mar 15 04:32:27 PM UTC 2024.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git/patch/?id=3Dlinux-6.7.y&id2=3Dv6.7.9
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.7.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.7.y for this week :-

## stable-rc HEAD for linux-6.7.y:
Date: 2024-03-13
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Db103e69cd70cdeef14f92bdca721df82e6dcbe0a

## Build failures:
No build failures seen for the stable-rc/linux-6.7.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.7.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


