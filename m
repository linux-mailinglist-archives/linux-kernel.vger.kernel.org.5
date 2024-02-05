Return-Path: <linux-kernel+bounces-52375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95E849742
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4181F2235F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C4514008;
	Mon,  5 Feb 2024 10:03:10 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911617565;
	Mon,  5 Feb 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127390; cv=none; b=Yr7uYGiNXz25tFcLZDTlVwR+7onR5vUUWjm6PYI0Sn0ZMGtaQCxL0NzYUa9ODcxEVwUyIAHvaaDnnJjrgVjn1ji2zBBrFm1vd2wo27spzgoHfigIAlstCBfge6jzHqiEwU3y8/ybCsgtgV5AdC9RtFlk/6rkPGNiVOYaMrl58jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127390; c=relaxed/simple;
	bh=U8APChL26YPackRITDmxqa+FUsw07IjAEBEZTf+BIk4=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Z8LA1iy/s+acd6j6sff0ERMTB0/cdWETh6Y74UtNcDq8XdumYbVDovrZJznzs8oEkYcEYHsFoqSVXBvaqLfxdyrRdSq49CQHy+BZX7NvYmWdIFlgREGLVqGOpPkFhmxUMcVRttHFL8nYY0OMxNif/SQ8RBdADRETj0zi8f2/yr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 248CC3781FEA;
	Mon,  5 Feb 2024 10:03:05 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240203174756.358721205@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240203174756.358721205@linuxfoundation.org>
Date: Mon, 05 Feb 2024 10:03:04 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5afa-65c0b280-d-7bb05580@116609044>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E1?= 000/221] 
 =?utf-8?q?6=2E1=2E77-rc2?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Saturday, February 03, 2024 23:22 IST, Greg Kroah-Hartman <gregkh@li=
nuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.77 release.
> There are 221 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1=
77-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.1.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.1.y for this week :-

## stable-rc HEAD for linux-6.1.y:
Date: 2024-02-03
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D4f7472958779c55ae5b01cfb687a0e791c58f58c

## Build failures:
No build failures seen for the stable-rc/linux-6.1.y commit head \o/

## Boot failures:

Devices failing to boot :-

acer-cb317-1h-c3z6-dedede
acer-cbv514-1h-34uz-brya=20
acer-chromebox-cxi4-puff
acer-chromebox-cxi5-brask
acer-cp514-3wh-r0qs-guybrush
asus-C433TA-AJ0005-rammus=20
asus-C436FA-Flip-hatch
asus-C523NA-A20057-coral
asus-CM1400CXA-dalboz
dell-latitude-5400-4305U-sarien=20
dell-latitude-5400-8665U-sarien
hp-x360-12b-ca0010nr-n4020-octopus
hp-x360-14-G1-sona
hp-x360-14a-cb0001xx-zork
lenovo-TPad-C13-Yoga-zork

Reason for failure :-
BUG: kernel NULL pointer dereference

Defconfig :-
x86=5F64=5Fdefconfig+x86-board

KernelCI Dashboard Link :-=20
https://linux.kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kernel=
/v6.1.76-220-g4f7472958779c/plan/baseline/

We are currently in the process of investigating this issue and will so=
on report back with some more information.

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


