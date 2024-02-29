Return-Path: <linux-kernel+bounces-86591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71186C780
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A36B284C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD57A723;
	Thu, 29 Feb 2024 10:56:24 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F16351C;
	Thu, 29 Feb 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204183; cv=none; b=rwaQAv/6p+ZSleHM5WQcbse9pJP3yb65Vpz8AdTwQxWG49GoCTusA30Ej/MjqfbC1ugz5SsrUmGBBHpx8MDW6cPVLztKfkoK4O0VSmch4H/mkc622KNP2tJgwPF4cL6p0FxDLYw3dL5/TFJpdF9NXjE51uR6j89nmzGXLUS0MV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204183; c=relaxed/simple;
	bh=y1Jfip9o5DbaFiAazWsGG9BOH9m4j+SXIazClg4zvj8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=fCLcmu8u8wiY1OSgnnDnwPJWXhqv4UrE4LTwH4BQwxSCkYj3qHgkyDtS3lKS6D2X0i6t/LRetxFAMA2Q7fPUbGjDX6ZFD3FsboA1hcYk3xOT9FuZJmCmNMNXC6ph8W1X262SvoGqRY6MbMtsfelVZiNaRPvllcDZ2WVHFRjukRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id AFE843780029;
	Thu, 29 Feb 2024 10:56:17 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240227131558.694096204@linuxfoundation.org>
Date: Thu, 29 Feb 2024 10:56:17 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <95c1-65e06300-b-71f47500@137610097>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E10?= 000/122] 
 =?utf-8?q?5=2E10=2E211-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 27, 2024 18:56 IST, Greg Kroah-Hartman <gregkh@lin=
uxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.10.211 release=
.
> There are 122 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1=
0.211-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-5.10.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.10.y for this week.

## stable-rc HEAD for linux-5.10.y:
Date: 2024-02-27
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D5d69d611e74dd9f58af23f171ccd3405a650c6ed

## Build failures:
No build failures seen for the stable-rc/linux-5.10.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.10.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


