Return-Path: <linux-kernel+bounces-52485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469268498DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7757B1C2208D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2D818E08;
	Mon,  5 Feb 2024 11:29:56 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983B18AEE;
	Mon,  5 Feb 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132596; cv=none; b=iSZ+oxHK+nZKm6o+l3LV0NRE/erfmzIDt2vCc3KBzRIER0o1VysFCuSPAoY+9G81ibLwCn+0Ng5KRzkEG0E0mMZicBlb8FyzyM9zru4DQQYAvGsTrlOEHyWOCq7pGnwWTML4t2qouy0wkkBeWZK+XZmAyj4dueXIwyYFQGNHhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132596; c=relaxed/simple;
	bh=q2CLz4M9YdaD+PJ4yP0uf2oAypT2VvZrvWWx9ZEF3Yo=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Oc5GUc9/lNA/slcyFFzpoXChB7EHd8YzQKg4yyiDOj6Eqdkg0aTv2+wOTr/hIXXMx+kaL40CeLhbgsUD5sC0dlodgjlRBSziAXGAimeRYIOmsRbdwftPfHqOAJcmFwNQOFiG7epWNB1gGV71IHlR5XK2zgSNAR68eo4gV4F3HvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id DD1F83780C21;
	Mon,  5 Feb 2024 11:29:50 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <13ddf68c-df25-4f5a-8044-33543a726889@linaro.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240203035317.354186483@linuxfoundation.org> <13ddf68c-df25-4f5a-8044-33543a726889@linaro.org>
Date: Mon, 05 Feb 2024 11:29:50 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, mathias.nyman@linux.intel.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: =?utf-8?q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>, mathias.nyman@linux.intel.com, "Greg KH" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7e9f-65c0c680-1-1d70df60@6844130>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E1?= 000/219] 
 =?utf-8?q?6=2E1=2E77-rc1?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Saturday, February 03, 2024 11:53 IST, Daniel D=C3=ADaz <daniel.diaz=
@linaro.org> wrote:

> Hello!
>=20
> On 02/02/24 10:02 p.=C2=A0m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.77 release=
.
> > There are 219 patches in this series, all will be posted as a respo=
nse
> > to this one.  If anyone has any issues with these being applied, pl=
ease
> > let me know.
> >=20
> > Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> > Anything received after that time might be too late.
> >=20
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6=
1.77-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git linux-6.1.y
> > and the diffstat can be found below.
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> We're seeing lots of build problems and warnings with Clang 17 and Cl=
ang nightly:
>=20
> -----8<-----
>    /builds/linux/drivers/usb/host/xhci.c:1684:37: error: variable 'sl=
ot=5Fid' is uninitialized when used here [-Werror,-Wuninitialized]
>     1684 |                         ret =3D xhci=5Fcheck=5Fmaxpacket(x=
hci, slot=5Fid,
>          |                                                          ^=
~~~~~~
>    /builds/linux/drivers/usb/host/xhci.c:1652:22: note: initialize th=
e variable 'slot=5Fid' to silence this warning
>     1652 |         unsigned int slot=5Fid, ep=5Findex;
>          |                             ^
>          |                              =3D 0
>    1 error generated.
>    make[5]: *** [/builds/linux/scripts/Makefile.build:250: drivers/us=
b/host/xhci.o] Error 1
> ----->8-----
>=20
> Bisection points to:
>=20
>    commit 37ef029fe9a5639f12250f75f5d1594c6a11e181
>    Author: Mathias Nyman <mathias.nyman@linux.intel.com>
>    Date:   Fri Dec 1 17:06:47 2023 +0200
>=20
>        xhci: fix possible null pointer deref during xhci urb enqueue
>       =20
>        [ Upstream commit e2e2aacf042f52854c92775b7800ba668e0bdfe4 ]
>=20
> Reverting the patch makes the build pass.
>=20

Hi Daniel and Greg,

Reverting this patch causes some boot failures :-
https://linux.kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kernel=
/v6.1.76-220-g4f7472958779c/plan/baseline/

Not sure if reverting would be the best way to fix this issue.


Thanks,
Shreeya Patel


> The problem manifests as build error in i386 and x86=5F64, and as new=
 warnings on Arm, Arm64, and RISC-V.
>=20
> Some reproducers:
>=20
>    tuxmake --runtime podman --target-arch arm --toolchain clang-17 --=
kconfig omap2plus=5Fdefconfig LLVM=3D1 LLVM=5FIAS=3D1
>    tuxmake --runtime podman --target-arch x86=5F64 --toolchain clang-=
17 --kconfig x86=5F64=5Fdefconfig LLVM=3D1 LLVM=5FIAS=3D1
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
>=20
> Greetings!
>=20
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org
>=20
>


