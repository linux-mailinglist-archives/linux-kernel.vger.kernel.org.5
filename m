Return-Path: <linux-kernel+bounces-76188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A785F402
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23D3B21F63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CDE3613A;
	Thu, 22 Feb 2024 09:09:31 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78836B02;
	Thu, 22 Feb 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592970; cv=none; b=ng+/OAHP0ADV9IyLHs0aw7iWOhrZ8ibX0FXVdjf7W/SU8sy+wm+jR10OUNFe2CylIaeI4qZUfeQaXd/GUj34JwqieYAZfWzpasePvgbCaPe0RyN/W+fUlqif7LjEQBOMRURR3pBzxQhZgVS/qnaF7pBesMjSLyKD8ylmagjEkOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592970; c=relaxed/simple;
	bh=3Va0AQy8MDXlS2QxLxNPjM7H4iXSmpPj9TMQdWDWW3w=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=nB22FGNKyob59hjALjSpcIPeEt3B4HMcGenhYK7MjX/nWq/+zVXlplLYdjgX04CbjFebMfgriddKSRZc42oEy+9EW9sL+xx/2hz5gFceRF0vUzDfK3koUakkEt7Ds5My9pUipgCUYeEl0s+ZIrqwcJZjHd5Zql46x0UIjFwBt5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 068EC37820C7;
	Thu, 22 Feb 2024 09:09:25 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240221125954.917878865@linuxfoundation.org>
Date: Thu, 22 Feb 2024 09:09:25 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <10aff2-65d70f80-1-48916200@130435435>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E10?= 000/379] 
 =?utf-8?q?5=2E10=2E210-rc1?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Wednesday, February 21, 2024 18:32 IST, Greg Kroah-Hartman <gregkh@l=
inuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.10.210 release=
.
> There are 379 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1=
0.210-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-5.10.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.10.y for this week.

## stable-rc HEAD for linux-5.10.y:
Date: 2024-02-21
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Dd2880f0e0d6f4221aa1ac48b8fb2b71168adff88

## Build failures:
No build failures seen for the stable-rc/linux-5.10.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.10.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


