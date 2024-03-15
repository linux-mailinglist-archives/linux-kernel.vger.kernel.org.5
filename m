Return-Path: <linux-kernel+bounces-104284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43E87CB9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3007B21F05
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA119477;
	Fri, 15 Mar 2024 10:48:57 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3217C6A;
	Fri, 15 Mar 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499737; cv=none; b=AVc///dyD9o4arcX0oKbnd/kYiZvh9L1FAzmZDTTVIKT/ql/rRFeLiJJwM+1HeCr2+ay1UMRuOh8Aai20uS9WyZT5xm67UtDSn+p12weJ3GexHV56GZe5Erbz9giecow066ulUhLB32SM2Z/UoCIcIN6DYzHIz8XI4dUjLzJHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499737; c=relaxed/simple;
	bh=R7GjhKviLkpXMF0CKnNF4FoimW5GhqDP2JTJ0azwgoY=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=QpB/VfmsQnajk+Mur1iT678am1oOvCeCwOULy/zWbqp2UxKFMgpwz6ATApajy6FJOut7I46qirvrh0NXshSoE0QlP53JbjPZQbUHRCuKiZC98K75wvYEEYjCqVSwkWlkdtUQEodws+CII3GhgEu0V/Ejey62OZH4xeCunQ0J82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 2AD903782083;
	Fri, 15 Mar 2024 10:48:53 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240313164640.616049-1-sashal@kernel.org>
Date: Fri, 15 Mar 2024 10:48:52 +0000
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: "Sasha Levin" <sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1faa5f-65f42780-55-41e48800@256342251>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E10?= 00/73] 
 =?utf-8?q?5=2E10=2E213-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 13, 2024 22:15 IST, Sasha Levin <sashal@kernel.org>=
 wrote:

>=20
> This is the start of the stable review cycle for the 5.10.213 release=
.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git/patch/?id=3Dlinux-5.10.y&id2=3Dv5.10.212
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-5.10.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.10.y for this week.

## stable-rc HEAD for linux-5.10.y:
Date: 2024-03-13
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D0a70dd1e1aa9dfe25d4647f86675dc6dac41631e

## Build failures:
No build failures seen for the stable-rc/linux-5.10.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.10.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


