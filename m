Return-Path: <linux-kernel+bounces-66409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A46855C57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE11A1F222DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B951798C;
	Thu, 15 Feb 2024 08:20:40 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F93C17;
	Thu, 15 Feb 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985239; cv=none; b=ByI+Vp5kmHx5CoToxN58OGWX2MMxVO/athFSqNbsm0MK9929WWcBB6s/jvkiPZG0sosipxcxI2zBvGoEPxxHPnLHye0pf+4q1LB2ioMMO7xaESp59wg+3KYYuaVDxz4+W/TYtxiBT/EFuw+U8XcGiNeza5320XcmPgO2k4hLBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985239; c=relaxed/simple;
	bh=qlv23S/JNSmUKqWUjDar2EWWu23eXMjxHWHVPb1kCXk=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=fMjv7khrYrzYfYdFrS/hCWZOF26F/tUCMVmug7+ha8U5nmhVqY5n7Uu//vMaWt1N6mtTLKXPKHqQLZfbEbRs0+3JQcolDG6oRxORTpIPMb4OOnmqnoMOj5+sV0xyj18hZF/tLtnrCJp93Da8dWrBVLF9mfEug+SuDStWpE6VWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id CEF2337813FD;
	Thu, 15 Feb 2024 08:20:34 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240214142247.920076071@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240214142247.920076071@linuxfoundation.org>
Date: Thu, 15 Feb 2024 08:20:34 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4b10-65cdc980-11-61454e00@94544082>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E6?= 000/124] 
 =?utf-8?q?6=2E6=2E17-rc2?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Wednesday, February 14, 2024 20:00 IST, Greg Kroah-Hartman <gregkh@l=
inuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.17 release.
> There are 124 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Fri, 16 Feb 2024 14:22:24 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6=
17-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.6.y
> and the diffstat can be found below.
>=20

## stable-rc HEAD for linux-6.6.y:

Date: 2024-02-14
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D36bb9c22c8b6e6fd34fd6fff147c78bc62a08fa2

## Build failures:
No build failures seen for the stable-rc/linux-6.6.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.6.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


