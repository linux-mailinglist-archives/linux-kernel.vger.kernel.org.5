Return-Path: <linux-kernel+bounces-37641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C080C83B2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C5D28A166
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC59133980;
	Wed, 24 Jan 2024 20:21:20 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00950811E4;
	Wed, 24 Jan 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127680; cv=none; b=E6+7Myygg8aZ0VXbwezCc9DqIQzs+SC8RJ8ECvYA4Hqb6v494fGxJJu1sP6q/T/uj/w2Oi3qinKxzpdGHKCTcEEBcPp+hhlMOMOJqKYWeePUTbGoVf9lmYrOwSG1hsDwUcyV222tvx7GO48ARTpmx+qWIFtUBkFTecuFUajYius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127680; c=relaxed/simple;
	bh=YXvuWLEJ7nz3sizA8P0woscW7XbnOlaFIKYGAwif/vY=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=qaxWUfx8PDRBxeE2wkF9Cpte0qe81zc4Ed1+e+k8+OgRCe1q4OZ4jsK/AAppr++kROWSL86qBDexmJ/ZRoqgEsKFQMT4HW7kFRAejF6tDbvxfrZW18nwrCDZIxafd3bd5zyK9zQtvpgUqSWaECqYy1olvPzHXS24YuFXJBY0T5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id BA24237813E9;
	Wed, 24 Jan 2024 20:21:15 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240123174510.372863442@linuxfoundation.org>
Date: Wed, 24 Jan 2024 20:21:15 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7abf-65b17100-28d-71572780@19090007>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E1?= 000/414] 
 =?utf-8?q?6=2E1=2E75-rc2?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Tuesday, January 23, 2024 23:17 IST, Greg Kroah-Hartman <gregkh@linu=
xfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1=
75-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.1.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.1.y for this week :-

## stable-rc HEAD for linux-6.1.y:
Date: 2024-01-23
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Da7fd791e5c51cd002dca6309fcd6ab75ee5fa9dd

## Build failures:
No build failures seen for the stable-rc/linux-6.1.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.1.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


