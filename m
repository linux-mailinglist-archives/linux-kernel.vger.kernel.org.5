Return-Path: <linux-kernel+bounces-83914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F2B86A00B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108351F24A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D42D51C4D;
	Tue, 27 Feb 2024 19:20:44 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DA51C34;
	Tue, 27 Feb 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061643; cv=none; b=bxqb6hKzC5h5XelAB6b+/tzpcapYXpmKAUCjJbhNiFwAw6Ctksg5015HEzlhZFEiU3x3dG80zLGPrgdl96DH6c4C9sUTuR0u8i74khdNP+nBeNBYd7jsWuzWqOrRTTJTW5GQsGnka1q+2SogrKEr8PXLZstyH1UIgCNXMbMuz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061643; c=relaxed/simple;
	bh=h7o4cj6c8ld5edqdaypKr59uqwpXz/+LNug+00ve6Pg=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=qHrW/F2z0caRl5fHhy9spl05YfnXYltvS/K+U3JFcX/WnfA3onkTOO3nGPQ+AE2ZEy3B6H4B1My25feOGTugUwaZxsMdrPd6anKeB5F5qdQ/nUugww3xZtMDTXxeI/QQ313c79WDpVt+A/bTU1P8/0X0pb05wOSJCoYhCD8XiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id D9CEA378206B;
	Tue, 27 Feb 2024 19:20:35 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240227131615.098467438@linuxfoundation.org>
Date: Tue, 27 Feb 2024 19:20:35 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1ca0-65de3600-5-5ba0f680@242277010>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E15?= 000/245] 
 =?utf-8?q?5=2E15=2E150-rc1?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 27, 2024 18:53 IST, Greg Kroah-Hartman <gregkh@lin=
uxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.150 release=
.
> There are 245 patches in this series, all will be posted as a respons=
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
5.150-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-5.15.y
> and the diffstat can be found below.

KernelCI report for stable-rc/linux-5.15.y for this week.

## stable-rc HEAD for linux-5.15.y:
Date: 2024-02-27
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D3ab4d9c9e190217ee7e974c70b96795cd2f74611

## Build failures:
riscv:
    - defconfig (gcc-10) and rv32=5Fdefconfig (gcc-10)
    - Build details :- https://linux.kernelci.org/build/stable-rc/branc=
h/linux-5.15.y/kernel/v5.15.149-246-g3ab4d9c9e190/
    - Errors :-
    drivers/net/ethernet/realtek/r8169=5Fmain.c:5512:23: error: =E2=80=98=
rtl8169=5Fpm=5Fops=E2=80=99 undeclared here (not in a function); did yo=
u mean =E2=80=98rtl8169=5Fpoll=E2=80=99?

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.15.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


