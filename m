Return-Path: <linux-kernel+bounces-159114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD458B2999
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB481C21A03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD1153597;
	Thu, 25 Apr 2024 20:17:46 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B715380D;
	Thu, 25 Apr 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076266; cv=none; b=iCLh2sIoYS6i4/218Np0rvIG78jbi/T8s/mkFwuHrN7KL/5xcV6rkV6/1+wDSlE5UlviwqD8zZaPN64lAEPvwffwGDrei56kFrkwLE2t12qxjVzSlSbSwY9RDjmxhbJJ9lTl6vxgCv07BLOKXKOBt9v4StFPtFUt7jEzwTZTmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076266; c=relaxed/simple;
	bh=4P+2ddj5AhVb3QscxtU44Agv9wTgnD9nyxTNsVYUmcQ=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=rfZY4ItwJP1bnT5/eqH7WUFI8jhitSw/JAPXtZg9dugeoO6OgIcemEG7ESiJmwOcFGNF/VKc8QZ+mx4m7F/oKB1eelbK0wlu2ohXiU6nKGvhNiuB8hRmcUNeZADAy1w6afo/rEzIukampeeGIXD6iCtH5/bFL3dyPja0oXLabck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 82B6B378045F;
	Thu, 25 Apr 2024 20:17:40 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240423213855.824778126@linuxfoundation.org>
Date: Thu, 25 Apr 2024 21:17:40 +0100
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <99e7a-662aba80-7-7c9a8880@58293979>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E8?= 000/158] 
 =?utf-8?q?6=2E8=2E8-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, April 24, 2024 03:07 IST, Greg Kroah-Hartman <gregkh@linu=
xfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8=
8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.8.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.8.y for this week :-

## stable-rc HEAD for linux-6.8.y:
Date: 2024-04-24
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D9919cd9ab98868581abf895dc0913cb6760c176f

## Build failures:
No build failures seen for the stable-rc/linux-6.8.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.8.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


