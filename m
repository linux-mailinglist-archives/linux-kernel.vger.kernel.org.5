Return-Path: <linux-kernel+bounces-37645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2D83B2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9761F23339
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051FF131E53;
	Wed, 24 Jan 2024 20:24:16 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42313340F;
	Wed, 24 Jan 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127855; cv=none; b=N4d06TO3BvNmlnNdBH5zSzeTJqvZqLMYz8xGt3HqSqVxjOtOhTnIgkEESifdlHPY2zKGLXJDI06WJYCh0JuJ07fE+F0h1opRWWL4i8W+NEwXvthYsOQBFWicZmRk59KDiPpbqwKmvuoQGZZrCxeRDeN3G8KBT5ww1iNdPhV4k2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127855; c=relaxed/simple;
	bh=PfxJU9zHH9Ctqongwu9A/T7Kewel9LEf6AADN8uUTKE=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=KlW6g+RYtVRgmVqUqhtC4JBGzCH+SI5uYZE9LnBjNL4xkVOgu271/Vpm7wdQmtLhzjd/UosnzPbnYKJuOF5wWCQJ+Y7KGcRe9xUbfY5ND8ufTE6Hu79QIZ7rE3PBje/cVWwmjxpK/ZcejCW5rj5Q59olcF7smSNqLeTA+rlrgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id CBD7437813E9;
	Wed, 24 Jan 2024 20:24:10 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240123174500.819179356@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240123174500.819179356@linuxfoundation.org>
Date: Wed, 24 Jan 2024 20:24:10 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <53f5-65b17200-1-34c04d40@156471961>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E15?= 000/371] 
 =?utf-8?q?5=2E15=2E148-rc2?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Tuesday, January 23, 2024 23:16 IST, Greg Kroah-Hartman <gregkh@linu=
xfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.148 release=
.
> There are 371 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 25 Jan 2024 17:44:14 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1=
5.148-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-5.15.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.15.y for this week.

## stable-rc HEAD for linux-5.15.y:
Date: 2024-01-23
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D6de5fbff4f2e80d1600441f61858895afcd2fc61

## Build failures:
No build failures seen for the stable-rc/linux-5.15.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.15.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


