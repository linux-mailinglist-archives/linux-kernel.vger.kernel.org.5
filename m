Return-Path: <linux-kernel+bounces-159117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80E8B299E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A867D281561
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88AB153809;
	Thu, 25 Apr 2024 20:19:21 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFC37153;
	Thu, 25 Apr 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076361; cv=none; b=SZKPHD89o1hJ8KArREK5vYtF89aLWlf3IsRuccYwPTj/j6t8nbRn6BzBLAjlTLp/DL8umydZ+CjFQtSKeCzvqTi/10RY8QvjJi6ua2L4px52i6Sa2IWHslbpjQ/TEEVVUw6xeEWBdFGwIo4KehsfWREPKSqF1mYAbzpevehMB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076361; c=relaxed/simple;
	bh=Th3djsGTVHRdDs+lvt8P7lxA+O49hf8OM2PZNr5JrtQ=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=DhnCi4cqZ/l41nwAWwa9zk/MIZie+46wSXoU2CQivgfgZD4YU3V8VAYOiXAd9Bg4n0A/m84X5DJtaVGYgXgIdTTt9l6eiapI0sdNvyamo94m0pvouvhffj73L9knQpoSK+zEsA55SkorFiCY8KsorcaT0tAMfTA/debcqjEe3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 107EC378045F;
	Thu, 25 Apr 2024 20:19:16 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240423213844.122920086@linuxfoundation.org>
Date: Thu, 25 Apr 2024 21:19:16 +0100
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <99f49-662abb00-5-1a63b1e0@13200930>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E15?= 00/71] 
 =?utf-8?q?5=2E15=2E157-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, April 24, 2024 03:09 IST, Greg Kroah-Hartman <gregkh@linu=
xfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.157 release=
.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1=
5.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-5.15.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.15.y for this week.

## stable-rc HEAD for linux-5.15.y:
Date: 2024-04-23
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D70f39a25a6b86d04f5693eac9b6f203ed23d8260

## Build failures:
No build failures seen for the stable-rc/linux-5.15.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.15.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


