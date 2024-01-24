Return-Path: <linux-kernel+bounces-37640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1383B2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BD1C22DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF413342B;
	Wed, 24 Jan 2024 20:18:52 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08E13398C;
	Wed, 24 Jan 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127532; cv=none; b=YdCAE6j5dSh+r6LMPdJCJkyCqTtKaOqDVtiFDTUu5skM4v37CbPYbVD7TC0+vYKiv+7Ryt0Cv11AStH+EV11Jtvk+nbnhyBnrA+AEGJLlOWB+8NTlWst0YPs2YCmgBy+X4wal2PrFsjksxFlRQ/N1dt5JmJuTrZAewN72cFYJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127532; c=relaxed/simple;
	bh=5nUZgTl3b8nFrSckwwhEsc6G85YotXQiLLUQSFoGIG8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Pl0llU77z3YWvwRHNf5A0wArXWfvpDSx4IG3a2/Qs6UYuwRmSCbrj8r/1aXiatLpNaOdj+y2erFCPCkem/M6j0Oa3JlqaejDAGNvsg+zx0aaSroS2uVrqyHQIH6YX2d/pkDzXBMPcQSIuyvwSuNLn6EXUBGHKJANXEhlW8UsPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 901A937813E9;
	Wed, 24 Jan 2024 20:18:47 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240123174533.427864181@linuxfoundation.org>
Date: Wed, 24 Jan 2024 20:18:47 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7abf-65b17080-28b-71572780@19089974>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E6?= 000/580] 
 =?utf-8?q?6=2E6=2E14-rc2?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Tuesday, January 23, 2024 23:17 IST, Greg Kroah-Hartman <gregkh@linu=
xfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6=
14-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.6.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.6.y for this week :-

## stable-rc HEAD for linux-6.6.y:
Date: 2024-01-24
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D86b2b02ae53b684a71d629c5ae2511c2e0d0f675

## Build failures:
No build failures seen for the stable-rc/linux-6.6.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.6.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


