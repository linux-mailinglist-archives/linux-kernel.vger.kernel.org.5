Return-Path: <linux-kernel+bounces-138203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D489EE03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A426028394E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D8154C0B;
	Wed, 10 Apr 2024 08:51:46 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A213C9C2;
	Wed, 10 Apr 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739105; cv=none; b=a1VKv3hOsFeg0GgEej+FLfB9FbK7URpQKXncp91Otfw0Wvq0gEVHy6fNZzjUmtA/Ehzf5sRnaID9EpzTc+22ZSQPfV+ULrXJ7FAE+S5vMe+oq/TbKPPxV7S5pOR6Dqk9MF81z2vNJpdPHYEszWUCL6J55+Y93+gI1jDmy06fj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739105; c=relaxed/simple;
	bh=Jta1oDcbHz9bEzgiV8Kxi3isoYY2p/IT5RWmu7gcHVY=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=irunqHcFMOMrgecbDOlVTzDuU5avIWj4S9V9J2h1hTBkXQNnIGcUmUdhwhjHPKB+Tm7JXtAEsLXEzWgVXumk1mnpw977bX7SoonGtrXjgWw4Xv0QLE0W5RlHR1KXAKkm86B2N/s64lqegaPtqWBBgknKv2e1cGITHKubd1Xp3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 00C7E3781453;
	Wed, 10 Apr 2024 08:51:40 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240409172824.552652165@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240409172824.552652165@linuxfoundation.org>
Date: Wed, 10 Apr 2024 09:51:40 +0100
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	padovan@web.codeaurora.org
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3c0c9c-66165300-1b-194ac52@218876937>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E8?= 000/279] 
 =?utf-8?q?6=2E8=2E5-rc2?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, April 09, 2024 23:00 IST, Greg Kroah-Hartman <gregkh@linuxf=
oundation.org> wrote:

> This is the start of the stable review cycle for the 6.8.5 release.
> There are 279 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 11 Apr 2024 17:27:40 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8=
5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.8.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.8.y for this week :-

## stable-rc HEAD for linux-6.8.y:
Date: 2024-04-10
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D6d08df6c401e210cdf4959cc3249188ac6083489

## Build failures:
No build failures seen for the stable-rc/linux-6.8.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.8.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


