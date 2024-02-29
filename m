Return-Path: <linux-kernel+bounces-86588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D533086C774
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D7C2882FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068837AE70;
	Thu, 29 Feb 2024 10:54:17 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFB7AE68;
	Thu, 29 Feb 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204056; cv=none; b=nO2TzEpsh3GWDcTrAzaIApmZGi2qh52obIHr0ItC6Qi3cJeU45CzVwSG5ev0uqkd4wgPtENKsCRxlQ6m7OGooCBoWgy58QJ1Mrl3S3juotkZyz4mgC63PSOUcJZkvow8K1njhxARRwcG0jZVV5RrCfLqcNLiym0Gy+43QBJBBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204056; c=relaxed/simple;
	bh=VLuJ/1dp9fBz+UVjbLAoAC913Ohwh/ZMiEdFJ/NSt70=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=B+JMXcfnNXsZUmvEV5qEz5ADogWvRMMJC8CcVdo85UpM8wuvO+VAYf6N6BOCDg3qox4aTcc4ztjxo2gPR1S3d3BPOEsRZyhpXqJq6jIz/Zp0pcwndLxFnOczkWmgry/luB82qHb5bmBy5sZHBEgOhmFxAKWYHYHG9Y2/YRqmBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 978253780029;
	Thu, 29 Feb 2024 10:54:11 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240227131625.847743063@linuxfoundation.org>
Date: Thu, 29 Feb 2024 10:54:11 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <95bf-65e06280-19-20e5b800@156243285>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E6?= 000/299] 
 =?utf-8?q?6=2E6=2E19-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 27, 2024 18:51 IST, Greg Kroah-Hartman <gregkh@lin=
uxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6=
19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.6.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.6.y for this week :-

## stable-rc HEAD for linux-6.6.y:

Date: 2024-02-27
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D3c05aa9775af6258ef849f6db3539689f244d3c8

## Build failures:
No build failures seen for the stable-rc/linux-6.6.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.6.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


